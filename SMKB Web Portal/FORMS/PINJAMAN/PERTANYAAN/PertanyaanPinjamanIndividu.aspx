<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="PertanyaanPinjamanIndividu.aspx.vb" Inherits="SMKB_Web_Portal.PertanyaanPinjamanIndividu"%>
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
   <style>
      input[readonly] {
      background-color: #e5e5e5;
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
      max-width: 1200px;
      margin: auto;
      }
      .form-group {
      max-width: 100%;
      }
      #permohonan .modal-body {
        max-height: 60vh;  /* Adjust height as needed to fit your layout */
        min-height: 50vh;
      }
      #detailTotal .modal-body {
        max-height: 20vh;  /* Adjust height as needed for #detailTotal */
        min-height: 20vh;
      }
   </style>
      <!------------------------------------------------------------------- CODE START --------------------------------------------------------------------------->
    <div id="PermohonanTab" class="tabcontent" style="display: block">
        <div class="modal-body">
            <div>
                <h5>Individu</h5>
            </div>
            <div class="form-group row col-md-6 align-middle">
                <label for="inputEmail3" class="col-sm-3 col-form-label" style="text-align: right">Carian :</label>
                <div class="col-sm-6">
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
                <div class="col-md-3">
                    <div class="form-row">
                        <div class="form-group col-md-5">
                            <br />
                        </div>
                    </div>
                </div>
                <div class="col-md-11">
                    <div class="form-row">
                        <div class="form-group col-md-2"></div>
                        <div class="form-group col-md-1 align-middle">
                            <label id="lblMula" style="text-align: right; display: none;" class="col-sm-3 col-form-label">Mula: </label>
                        </div>
                        <div class="form-group col-md-3">
                            <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display: none;" class="form-control date-range-filter">
                        </div>
                        <div class="form-group col-md-1">
                        </div>
                        <div class="form-group col-md-1 align-middle">
                            <label id="lblTamat" style="text-align: right; display: none;" class="col-sm-3 col-form-label">Tamat: </label>
                        </div>
                        <div class="form-group col-md-3">
                            <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display: none;" class="form-control date-range-filter">
                        </div>
                    </div>
                    <div class="form-group col-md-2"></div>
                </div>
            </div>

        </div>
            <div class="col-md-13">
               <div class="transaction-table table-responsive">
                  <span style="display: inline-block; height: 100%;"></span>
                  <table id="tblPenjamin" class="table table-striped">
                     <thead>
                        <tr style="width: 100%">
                           <th scope="col" style="width: 10%">No. Pinjaman</th>
                           <th scope="col" style="width: 7%">No. Staf</th>
                           <th scope="col" style="width: 30%">Nama Pemohon</th>
                           <th scope="col" style="width: 25%">Kategori Pemohon</th>
                           <th scope="col" style="width: 20%">Tarikh Mohon</th>
                           <th scope="col" style="width: 15%">Jenis Pinjaman</th>
                           <th scope="col" style="width: 7%">Baki Pokok</th>
                           <th scope="col" style="width: 15%">Status</th>
                        </tr>
                     </thead>
                     <tbody id="" onclick="ShowPopup('1')">
                        <tr style="width: 100%" class="table-list">
                           <td style="width: 10%"></td>
                           <td style="width: 7%"></td>
                           <td style="width: 30%"></td>
                           <td style="width: 25%"></td>
                           <td style="width: 20%"></td>
                           <td style="width: 15%"></td>
                           <td style="width: 7%"></td>
                           <td style="width: 15%"></td>
                        </tr>
                     </tbody>
                  </table>
               </div>
            </div>
         </div>
         <div class="modal fade bd-example-modal-xl " id="permohonan" tabindex="-1" role="document"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="static" >
            <div class="modal-dialog modal-dialog-centered modal-xl"  role="document">
               <div class="modal-content modal-xl">
                  <div class="row">
                     <div class="col-md-12">
                        <div class="form-row">
                           <div class="form-group col-md-2"></div>
                           <div class="form-group col-md-8">
                              <br />
                              <input class="input-group__input text-center mx-auto" name="Maklumat Permohonan" id="namaPeminjam2" type="text" readonly style="background-color: #f0f0f0" value="apa2"/>
                           </div>
                           <div class="form-group col-md-2" style="padding-right: 20px;padding-top: 10px;">
                              <button id="refreshButton" type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">×</span>
                              </button>
                           </div>
                        </div>
                     </div>
                  </div>
                  <ul class="nav nav-tabs" id="myTab">
                     <li class="nav-item">
                        <a class="nav-link active text-uppercase" data-toggle="tab" href="#spesifikasi-am" >Info Pemohon</a>
                     </li>
                     <li class="nav-item" role="presentation">
                        <a class="nav-link text-uppercase" data-toggle="tab" href="#bajet-dan-spesifikasi" >Info Pinjaman</a>
                     </li>
                     <li class="nav-item" role="presentation">
                        <a class="nav-link text-uppercase" data-toggle="tab" href="#kend">Info Kenderaan</a>
                     </li>
                      <li class="nav-item" role="presentation">
                        <a class="nav-link text-uppercase" data-toggle="tab" href="#komp">Info Komputer</a>
                     </li>
                      <li class="nav-item" role="presentation">
                        <a class="nav-link text-uppercase" data-toggle="tab" href="#sukan">Info Sukan</a>
                     </li>
                     <li class="nav-item" role="presentation">
                        <a class="nav-link text-uppercase" data-toggle="tab" href="#mof" >Ulasan KJ</a>
                     </li>
                     <li class="nav-item" role="presentation">
                        <a class="nav-link text-uppercase" data-toggle="tab" href="#cidb" >Info Potongan Gaji</a>
                     </li>
                  </ul>
                  <div class="tab-content" id="myTabContent">
                     <!-- ~~~ TAB 1 START ~~~-->
                     
                     <!-- ~~~ TAB 1 END   ~~~-->
                     <!-- ~~~ TAB 2 START ~~~-->
                     <div class="tab-pane fade show active" id="spesifikasi-am" role="tabpanel">
                        <div class="modal-body">
                           <div>
                              <div class="row">
                                 <div class="col-md-8">
                                    <h5>Info Pemohon</h5>
                                 </div>
                              </div>
                              <br />
                              <div class="row">
                                 <div class="col-md-12">
                                    <div class="form-row">
                                       <div class="form-group col-md-4">
                                          <input class="input-group__input" name="noStaf" id="noStaf" type="text" readonly style="background-color: #f0f0f0" value="" />
                                          <label class="input-group__label" for="No Staf">No Staf</label>
                                       </div>
                                       <div class="form-group col-md-4">
                                          <input class="input-group__input" name="No. K/P" id="kadPengenalan" type="text" readonly style="background-color: #f0f0f0" value="" />
                                          <label class="input-group__label" for="No. K/P">No. K/P</label>
                                       </div>
                                       <div class="form-group col-md-4">
                                          <input class="input-group__input" name="Kumpulan" id="kumpulan" type="text" readonly style="background-color: #f0f0f0" />
                                          <label class="input-group__label" for="Kumpulan">Kumpulan</label>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <div class="row">
                                 <div class="col-md-12">
                                    <div class="form-row">
                                       <div class="form-group col-md-4">
                                          <input class="input-group__input" name="Taraf" id="tarafKhidmat" type="text" readonly style="background-color: #f0f0f0" value="" />
                                          <label class="input-group__label" for="Taraf">Taraf</label>
                                       </div>
                                       <div class="form-group col-md-4">
                                          <input class="input-group__input" name="Gred Gaji" id="gredGaji" type="text" readonly style="background-color: #f0f0f0" />
                                          <label class="input-group__label" for="Gred Gaji">Gred Gaji</label>
                                       </div>
                                       <div class="form-group col-md-4">
                                          <input class="input-group__input" name="Umur Pada Tarikh Memohon" id="umur" type="text" readonly style="background-color: #f0f0f0" />
                                          <label class="input-group__label" for="Umur Pada Tarikh Memohon">Umur Pada Tarikh Memohon</label>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <div class="row">
                                 <div class="col-md-12">
                                    <div class="form-row">
                                       <div class="form-group col-md-4">
                                          <input class="input-group__input" name="Tarikh Lahir" id="tarikhLahir" type="text" readonly style="background-color: #f0f0f0" />
                                          <label class="input-group__label" for="Tarikh Lahir">Tarikh Lahir</label>
                                       </div>
                                       <div class="form-group col-md-4">
                                          <input class="input-group__input" name="Tarikh Lantikan" id="tarikhLantikan" type="text" readonly style="background-color: #f0f0f0" />
                                          <label class="input-group__label" for="Tarikh Lantikan">Tarikh Lantikan</label>
                                       </div>
                                       <div class="form-group col-md-4">
                                          <input class="input-group__input" name="Tarikh Sah" id="tarikhSah" type="text" readonly style="background-color: #f0f0f0" />
                                          <label class="input-group__label" for="Tarikh Sah">Tarikh Sah</label>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <div class="row">
                                 <div class="col-md-12">
                                    <div class="form-row">
                                       <div class="form-group col-md-4">
                                          <input class="input-group__input text-right" name="Gaji (Pokok)" id="gajiPokok" type="text" readonly style="background-color: #f0f0f0" />
                                          <label class="input-group__label" for="Gaji (Pokok)">Gaji Pokok (RM)</label>
                                       </div>
                                       <div class="form-group col-md-4">
                                          <input class="input-group__input" name="Sambungan Tel." id="sambunganTelifon" type="text" readonly style="background-color: #f0f0f0" />
                                          <label class="input-group__label" for="Sambungan Tel.">Sambungan Tel.</label>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <div class="row">
                                 <div class="col-md-12">
                                    <div class="form-row">
                                       <div class="form-group col-md-8">
                                          <input class="input-group__input" name="Jawatan" id="jawatan" type="text" readonly style="background-color: #f0f0f0" />
                                          <label class="input-group__label" for="Jawatan">Jawatan</label>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              <div class="row">
                                 <div class="col-md-12">
                                    <div class="form-row">
                                       <div class="form-group col-md-8">
                                          <input class="input-group__input" name="Jabatan" id="jabatan" type="text" readonly style="background-color: #f0f0f0" />
                                          <label class="input-group__label" for="Jabatan">Jabatan</label>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <!-- ~~~ TAB 2 END   ~~~-->
                     <!-- ~~~ TAB 3 START ~~~-->
                     <div class="tab-pane fade" id="bajet-dan-spesifikasi" role="tabpanel">
                        <div id="divTab3" runat="server" visible="true">
                           <div class="modal-body">
                              <div>
                                 <div class="row">
                                    <div class="col-md-8">
                                       <h5>Info Pinjaman</h5>
                                    </div>
                                 </div>
                                 <br />
                                 <div class="row">
                                    <div class="col-md-12">
                                       <div class="form-row">
                                          <div class="form-group col-md-4">
                                             <input class="input-group__input" name="Kategori Pinjaman" id="kategoriPinjaman" type="text" readonly style="background-color: #f0f0f0" value="" />
                                             <label class="input-group__label" for="Kategori Pinjaman">Kategori Pinjaman</label>
                                          </div>
                                          <div class="form-group col-md-4">
                                             <input class="input-group__input" name="Jenis Pinjaman2" id="jenisPinjaman2" type="text" readonly style="background-color: #f0f0f0" value="" />
                                             <label class="input-group__label" for="Jenis Pinjaman2">Jenis Pinjaman</label>
                                          </div>
                                          <div class="form-group col-md-4">
                                             <input class="input-group__input text-right" name="Amaun Mohon (RM)" id="amaunMohon" type="text" readonly style="background-color: #f0f0f0" />
                                             <label class="input-group__label" for="Amaun Mohon (RM)">Amaun Mohon (RM)</label>
                                          </div><div class="form-group col-md-4" style="display: none;">
                                             <input class="input-group__input" name="Amaun Mohon (RM)" id="amaunMohon2" type="text" readonly style="background-color: #f0f0f0" />
                                             <label class="input-group__label" for="Amaun Mohon (RM)">Amaun Mohon (RM)</label>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="col-md-12">
                                       <div class="form-row">
                                          <div class="form-group col-md-4">
                                             <input class="input-group__input" name="Tarikh Mohon" id="tarikhMohon" type="text" readonly style="background-color: #f0f0f0" value="" />
                                             <label class="input-group__label" for="Tarikh Mohon">Tarikh Mohon</label>
                                          </div>
                                          <div class="form-group col-md-4">
                                             <input class="input-group__input" name="Kelayakan" id="kelayakan" type="text" readonly style="background-color: #f0f0f0" />
                                             <label class="input-group__label" for="Kelayakan">Kelayakan</label>
                                          </div>
                                          <div class="form-group col-md-4">
                                             <input class="input-group__input text-right" name="Ansuran Bulan (RM)" id="ansuran" type="text" readonly style="background-color: #f0f0f0" />
                                             <label class="input-group__label" for="Ansuran Bulan (RM)">Ansuran Bulan (RM)</label>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 <div class="row">
                                    <div class="col-md-12">
                                       <div class="form-row">
                                          <div class="form-group col-md-4">
                                             <input class="input-group__input" name="Tempoh" id="tempohPinjaman" type="text" readonly style="background-color: #f0f0f0" />
                                             <label class="input-group__label" for="Tempoh">Tempoh (Bulan)</label>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                     <!-- ~~~ TAB 3 END   ~~~-->
                     <!-- ~~~ TAB 5 START ~~~-->
                     <div class="tab-pane fade" id="mof" role="tabpanel">
                        <div class="modal-body">
                           <div>
                              <h5>Ulasan KJ</h5>
                              <div>
                                 <span style="display: inline-block; height: 100%;"></span>
                                 <table id="ulasan-table" class="table table-striped">
                                    <thead>
                                       <tr style="width: 100%">
                                          <th scope="col" style="width: 5%; text-align:center">Bil</th>
                                          <th scope="col" style="width: 98%; text-align:left">Perakuan</th>
                                       </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                 </table>
                              </div>
                           </div>
                        </div>
                     </div>
                     <!-- ~~~ TAB 5 END   ~~~-->
                     <!-- ~~~ TAB 6 START ~~~-->
                     <div class="tab-pane fade" id="cidb" role="tabpanel">
                        <div class="modal-body">
                           <div>
                              <h5>Info Potongan Gaji</h5>
                              <div>
                                 <span style="display: inline-block; height: 100%;"></span>
                                 <table id="spekfikasi-table" class="table table-striped ">
                                    <thead>
                                       <tr style="width: 100%">
                                          <th scope="col" style="width: 5%; text-align:center">Bil</th>
                                          <th scope="col" style="width: 75%; text-align:left">Jenis Pinjaman/Perkara</th>
                                          <th scope="col" style="width: 20%; text-align:right">Harga Potongan (RM)</th>
                                       </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                 </table>
                              </div>
                           </div>
                        </div>
                        <div class="sticky-footer">
                           <br>
                           <div class="form-row">
                              <div class="form-group col-md-12">
                                 <div class="float-right">
                                    <button type="button" class="btn" id="showModalButton">
                                    <i class="fas fa-angle-up"></i>
                                    </button>
                                    <span style="font-family: roboto!important; font-size: 16px!important"><b>Jumlah
                                    :RM
                                    <span id="totalPotongan" style="margin-right: 25px"></span></b></span>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                                 <!--~~~ MODAL TAB 6 START ~~~-->
                                 <div class="modal fade" id="detailTotal" tabindex="-1" aria-labelledby="showDetails"
                                    aria-hidden="true">
                                    <div class="modal-dialog">
                                       <div class="modal-content">
                                          <div class="modal-body">
                                             <div class="row justify-content-end mt-2">
                                                <div class="col-md-6 text-right">
                                                   <label class="col-form-label ">Butiran Hutang/Potongan (RM)</label>
                                                </div>
                                                <div class="col-md-6">
                                                   <input class="form-control  underline-input" id="totalPotongan2"
                                                      name="totalPotongan"
                                                      style="text-align: right; font-size: medium; font-weight: bold"
                                                      placeholder="0.00" readonly />
                                                </div>
                                             </div>
                                             <div class="row justify-content-end mt-2">
                                                <div class="col-md-6 text-right">
                                                   <label class="col-form-label ">Jumlah Gaji (RM)</label>
                                                </div>
                                                <div class="col-md-6">
                                                   <input class="form-control  underline-input" id="totalPotongan3" name="TotalTax"
                                                      style="text-align: right; font-size: medium; font-weight: bold"
                                                      placeholder="0.00" readonly />
                                                </div>
                                             </div>
                                             <div class="row justify-content-end mt-2">
                                                <div class="col-md-6 text-right">
                                                   <label class="col-form-label ">Peratus Potongan (%)</label>
                                                </div>
                                                <div class="col-md-6">
                                                   <input class="form-control  underline-input" id="totalPotongan4"
                                                      name="TotalDiskaun"
                                                      style="text-align: right; font-size: medium; font-weight: bold"
                                                      placeholder="0.00" readonly />
                                                </div>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                 </div>
                                 <!--~~~ MODAL TAB 6 END   ~~~-->
                     <!-- ~~~ TAB 6 END   ~~~-->
                     <!-- ~~~ TAB 4(KENDERAAN) START ~~~-->
                     <div class="tab-pane fade" id="kend" role="tabpanel">
                          <div class="modal-body">
                              <div>
                                  <div class="row">
                                      <div class="col-md-8">
                                          <h5>Info Kenderaan</h5>
                                      </div>
                                  </div>
                                  <br />
                                  <div class="row">
                                      <div class="col-md-12">
                                          <div class="form-row">
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" name="Model" id="modelKenderaan" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                  <label class="input-group__label" for="Model">Model</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" name="Buatan" id="buatanKenderaan" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                  <label class="input-group__label" for="Buatan">Buatan</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input text-right" name="hargaKenderaan" id="hargaKenderaan" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                  <label class="input-group__label" for="hargaKenderaan">Harga Bersih(RM)</label>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="row">
                                      <div class="col-md-12">
                                          <div class="form-row">
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" name="Sukatan Silinder" id="sukatanSilinder" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                  <label class="input-group__label" for="Sukatan Silinder">Sukatan Silinder</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" name="No Chasis" id="noCasis" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                  <label class="input-group__label" for="No Chasis">No. Chasis</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" name="No Enjin" id="noEnjin" type="text" readonly style="background-color: #f0f0f0" value="" />
                                                  <label class="input-group__label" for="No Enjin">No. Enjin</label>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                     <!-- ~~~ TAB 4(KENDERAAN) END   ~~~-->
                     <!-- ~~~ TAB 4(KOMPUTER) START  ~~~-->
                     <div class="tab-pane fade" id="komp" role="tabpanel">
                          <div class="modal-body">
                              <div>
                                  <div class="row">
                                      <div class="col-md-8">
                                          <h5>Info Komputer</h5>
                                      </div>
                                  </div>
                                  <br />
                                  <div class="row">
                                      <div class="col-md-12">
                                          <div class="form-row">
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="kategoriPinjaman2" placeholder="&nbsp;" name="kategoriPinjaman" readonly />
                                                  <label class="input-group__label" for="kategoriPinjaman">Kategori Pinjaman</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="jenispinjKomputer" placeholder="&nbsp;" name="jenispinjKomputer" readonly />
                                                  <label class="input-group__label" for="jenispinjKomputer">Jenis Pinjaman</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="jenama" placeholder="&nbsp;" name="jenama" readonly />
                                                  <label class="input-group__label" for="jenama">Jenama Komputer</label>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="row">
                                      <div class="col-md-12">
                                          <div class="form-row">
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="ingatan" placeholder="&nbsp;" name="ingatan" readonly />
                                                  <label class="input-group__label" for="ingatan">Ingatan</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="pemacuCakera" placeholder="&nbsp;" name="pemacuCakera" readonly />
                                                  <label class="input-group__label" for="pemacuCakera">Pemacu Cakera</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="modem" placeholder="&nbsp;" name="modem" readonly />
                                                  <label class="input-group__label" for="modem">Modem</label>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="row">
                                      <div class="col-md-12">
                                          <div class="form-row">
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="kadBunyi" placeholder="&nbsp;" name="kadBunyi" readonly />
                                                  <label class="input-group__label" for="kadBunyi">Kad Bunyi</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="tetikus" placeholder="&nbsp;" name="tetikusPinjaman" readonly />
                                                  <label class="input-group__label" for="tetikus">Tetikus</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="nosiriKomputer" placeholder="&nbsp;" name="nosiriKomputer" readonly />
                                                  <label class="input-group__label" for="nosiriKomputer">No. Siri</label>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="row">
                                      <div class="col-md-12">
                                          <div class="form-row">
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="monitor" placeholder="&nbsp;" name="monitor" readonly />
                                                  <label class="input-group__label" for="monitor">Monitor</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="namaPencetak" placeholder="&nbsp;" name="namaPencetak" readonly />
                                                  <label class="input-group__label" for="namaPencetak">Nama Pencetak</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="papanKekunci" placeholder="&nbsp;" name="papanKekunci" readonly />
                                                  <label class="input-group__label" for="papanKekunci">Papan Kekunci</label>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                                  <div class="row">
                                      <div class="col-md-12">
                                          <div class="form-row">
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="cakeraKeras" placeholder="&nbsp;" name="cakeraKeras" readonly />
                                                  <label class="input-group__label" for="cakeraKeras">Cakera Keras</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="hargaKomputer" placeholder="&nbsp;" name="hargaKomputer" readonly />
                                                  <label class="input-group__label" for="hargaKomputer">Harga Bersih (RM)</label>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                     <!-- ~~~ TAB 4(KOMPUTER) END    ~~~-->
                     <!-- ~~~ TAB 4(SUKAN) START     ~~~-->
                     <div class="tab-pane fade" id="sukan" role="tabpanel">
                          <div class="modal-body">
                              <div>
                                  <div class="row">
                                      <div class="col-md-8">
                                          <h5>Info Sukan</h5>
                                      </div>
                                  </div>
                                  <br />
                                  <div class="row">
                                      <div class="col-md-12">
                                          <div class="form-row">
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="kategoriPinjaman3" placeholder="&nbsp;" name="kategoriPinjaman" readonly />
                                                  <label class="input-group__label" for="kategoriPinjaman">Kategori Pinjaman</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="jenisSukan" placeholder="&nbsp;" name="jenisSukan" readonly />
                                                  <label class="input-group__label" for="jenisSukan">Jenis Sukan</label>
                                              </div>
                                              <div class="form-group col-md-4">
                                                  <input class="input-group__input" id="hargaSukan" placeholder="&nbsp;" name="hargaSukan" readonly />
                                                  <label class="input-group__label" for="hargaSukan">Harga Bersih (RM)</label>
                                              </div>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                     <!-- ~~~ TAB 4(SUKAN) END       ~~~-->
                     <div align="right" style="padding-bottom:20px; padding-right:20px;">
                        <button type="button" class="btn btn-primary  btnSimpan1" id="btnSimpan1"
                           data-toggle="tooltip" data-placement="bottom" data-dismiss="modal"
                           title="Setuju" value="05">
                        Cetak Jadual Bayar Balik</button>
                     </div>
                  </div>
               </div>
            </div>
         </div>
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
                     <button type="button" class="btn btn-secondary" id="confirmSaveButton1" value="05">Ya</button>
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
                     <button type="button" class="btn btn-secondary" id="confirmSaveButton2" value="23">Ya</button>
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
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="refreshButton2">
                     <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body">
                     <p id="resultModalMessage1"></p>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal" id="refreshButton3">Tutup</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal  CONFIRM END        ~~~ -->
      <!------------------------------------------------------------------- CODE START --------------------------------------------------------------------------->
      <!------------------------------------------------------------------- SCRIPT START ------------------------------------------------------------------------->
      <script>
          // ---------------------- UNTUK TABLE START -----------------------
          var tbl11 = null;
          var isClicked7 = false;
          var shouldPop = true;

          $(document).ready(function () {

              init();

              function init() {
                  loadSenarai();
              }

              
              tbl = $("#tblPenjamin").DataTable({
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
                  //"ajax": {
                  //    url: 'PertanyaanPinjaman_WS.asmx/LoadIndividu',
                  //    //"url": "Invois.asmx/LoadMesyPH",
                  //    "method": 'POST',
                  //    "contentType": "application/json; charset=utf-8",
                  //    "dataType": "json",
                  //    "dataSrc": function (json) {
                  //        return JSON.parse(json.d);
                  //    },
                  //    "data": function () {

                  //        var startDate = $('#txtTarikhStart').val()
                  //        var endDate = $('#txtTarikhEnd').val()

                  //        return JSON.stringify({
                  //            category_filter: $('#categoryFilter').val(),
                  //            isClicked7: isClicked7,
                  //            tkhMula: startDate,
                  //            tkhTamat: endDate
                  //        })
                  //    }
                  //},

                  "rowCallback": function (row, data) {
                      $(row).hover(function () {
                          $(this).addClass("hover pe-auto bg-warning");
                      }, function () {
                          $(this).removeClass("hover pe-auto bg-warning");
                      });
                      $(row).on("click", function () {


                          console.log(data);
                          var rowData = data;

                          fetchSecondTableData(rowData.NoStaf);
                          fetchThirdTableData(rowData.NoPinjaman);
                          /*fetchDropdownData(rowData.JenisPinjaman);*/
                          no_mohon = rowData.No_Mohon;
                          /*initDropdownCOA("ddlCOA", rowData.VOT);*/
                          $("#noPinjaman").val(rowData.NoPinjaman || ' - ');
                          slctdNoPinj = rowData.NoPinjaman;
                          $("#noStaf").val(rowData.NoStaf || ' - ');
                          $("#kadPengenalan").val(rowData.KadPengenalan || ' - ');
                          $("#tarikhLahir").val(rowData.TarikhLahir || ' - ');
                          $("#tempohPinjaman").val(rowData.TempohPinjaman || ' - ');
                          $("#namaPeminjam").val(rowData.NamaPeminjam || ' - ');
                          $("#namaPeminjam2").val("" + (rowData.NoPinjaman || ' - ') + '        ' + (rowData.Nama || ' - '));
                          $("#jenisPinjaman").val(rowData.JenisPinjaman || ' - ');
                          $("#jenisPinjaman2").val(rowData.JenisPinjaman2 || ' - ');
                          $("#kategoriNoPinjaman").val(rowData.KategoriPinjaman2 || ' - ');
                          /*$("#amaun").val(rowData.Amaun || ' - ');*/
                          $("#amaunMohon").val(rowData.AmaunMohon || ' - ');
                          $("#amaunMohon2").val(rowData.AmaunMohon || ' - ');
                          /*$("#failRujukan").val(rowData.FailRujukan || ' - ');*/
                          /*$("#tarikhMesyuarat").val(rowData.TarikhMesyuarat || ' - ');*/
                          $("#tarikhMohon").val(rowData.TarikhMohon || ' - ');
                          $("#tarikhMohon").val(rowData.TarikhMohon2 || ' - ');
                          /*$("#tempatMesyuarat").val(rowData.TempatMesyuarat || ' - ');*/
                          /*$("#bilMesyuarat").val(rowData.BilMesyuarat || ' - ');*/
                          $("#gredGaji").val(rowData.GredGaji || ' - ');
                          $("#gajiPokok").val(rowData.GajiPokok || ' - ');
                          $("#kumpulan").val(rowData.Kumpulan || ' - ');
                          $("#tarikhSah").val(rowData.TarikhSah || ' - ');
                          $("#jawatan").val(rowData.Jawatan || ' - ');
                          $("#jabatan").val(rowData.Jabatan || ' - ');
                          $("#tarafKhidmat").val(rowData.TarafKhidmat || ' - ');
                          $("#sambunganTelifon").val(rowData.SambunganTelifon || ' - ');
                          $("#tarafKhidmat").val(rowData.TarafKhidmat || ' - ');
                          $("#buatanKenderaan").val(rowData.BuatanKenderaan || ' - ');
                          $("#modelKenderaan").val(rowData.ModelKenderaan || ' - ');
                          $("#sukatanSilinder").val(rowData.SukatanSilinder || ' - ');
                          $("#noCasis").val(rowData.NoCasis || ' - ');
                          $("#noEnjin").val(rowData.NoEnjin || ' - ');
                          $("#pemacuCakera").val(rowData.PemacuCakera || ' - ');
                          $("#modem").val(rowData.Modem || ' - ');
                          $("#kadBunyi").val(rowData.KadBunyi || ' - ');
                          $("#tetikus").val(rowData.Tetikus || ' - ');
                          $("#nosiriKomputer").val(rowData.NoSiriKomputer || ' - ');
                          $("#hargaKomputer").val(rowData.HargaKomputer);
                          $("#jenama").val(rowData.Jenama || ' - ');
                          $("#ingatan").val(rowData.Ingatan || ' - ');
                          $("#monitor").val(rowData.Monitor || ' - ');
                          $("#namaPencetak").val(rowData.NamaPencetak || ' - ');
                          $("#papanKekunci").val(rowData.PapanKekunci || ' - ');
                          $("#cakeraKeras").val(rowData.CakeraKeras || ' - ');
                          $("#jenispinjKomputer").val(rowData.JenisPinjamanKomputer || ' - ');
                          $("#hargaSukan").val(rowData.HargaSukan);
                          $("#jenisSukan").val(rowData.JenisSukan || ' - ');
                          $("#hargaKenderaan").val(rowData.HargaKenderaan);
                          $("#tarikhLantikan").val(rowData.TarikhLantikan || ' - ');
                          $("#umur").val(rowData.Umur || ' - ');
                          $("#kelayakan").val(rowData.Kelayakan || ' Belum Ada Kelayakan ');
                          $("#ansuran").val(rowData.Ansuran || ' - ');
                          $("#kategoriPinjaman").val(rowData.KategoriPinjaman || ' - ');
                          $("#kategoriPinjaman2").val(rowData.KategoriPinjaman || ' - ');
                          $("#kategoriPinjaman3").val(rowData.KategoriPinjaman || ' - ');
                          $("#vot").val(rowData.VOT || ' - ');
                          sessionStorage.setItem('NoPinjaman', rowData.NoPinjaman)
                          sessionStorage.setItem('NoFailRujukan', rowData.NoFailRujukan)
                          toggleFieldsetVisibility2();
                      });
                  },



                  "columns": [
                      {
                          "data": "NoPinjaman",
                          "width": "8%"
                      },
                      {
                          "data": "NoStaf",
                          "width": "5%"
                      },
                      {
                          "data": "Nama",
                          "width": "15%"
                      },
                      {
                          "data": "KategoriPinjaman",
                          "width": "10%"
                      },
                      {
                          "data": "TarikhMohon",
                          "width": "7%"
                      }
                      ,
                      {
                          "data": "JenisPinjaman2",
                          "width": "10%"
                      },
                      {
                          "data": "BakiPokok",
                          "width": "10%"
                      }, 
                      {
                          "data": "Status",
                          "width": "5%",
                          "render": function (data) {
                              if (data.includes('A')) {
                                  return 'Aktif';
                              } else if (data.includes('B')) {
                                  return 'Batal';
                              } else if (data.includes('S')) {
                                  return 'Selesai Pinjaman';
                              } else if (data.includes('T')) {
                                  return 'Tahan Bayar Balik';
                              } else {
                                  return 'Unknown'; // Default value if none of the conditions match
                              }
                          }
                      }
                  ],

              });


              var dtbl2 = $("#spekfikasi-table").DataTable({
                  responsive: true,
                  searching: false,
                  info: false,
                  lengthChange: false,
                  paging: false,
                  ordering: false
              });

              var dtbl3 = $("#ulasan-table").DataTable({
                  responsive: true,
                  searching: false,
                  info: false,
                  lengthChange: false,
                  paging: false,
                  ordering: false
              });

              var dtbl4 = $("#vot-table").DataTable({
                  responsive: true,
                  searching: false,
                  info: false,
                  lengthChange: false,
                  paging: false,
                  ordering: false
              });

              function fetchSecondTableData(noStaf) {
                  $.ajax({
                      type: "POST",
                      url: "PertanyaanPinjaman_WS.asmx/Get_SecondTableData",
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      data: JSON.stringify({ noStaf: noStaf }),
                      success: function (response) {

                          var table = $("#spekfikasi-table");

                          var tbody = table.find("tbody");

                          tbody.empty();

                          var dataArray = JSON.parse(response.d);

                          var totalAmaun = 0;

                          var percentageP = 0;

                          if (dataArray && dataArray.length > 0) {
                              for (var i = 0; i < dataArray.length; i++) {
                                  var row = dataArray[i];
                                  var newRow = $("<tr>");

                                  newRow.hover(
                                      function () {
                                          $(this).addClass("hover pe-auto bg-warning");
                                      },
                                      function () {
                                          $(this).removeClass("hover pe-auto bg-warning");
                                      }
                                  );

                                  newRow.append($("<td>").text(i + 1).css({ 'text-align': 'center', 'width': '5%' }));
                                  newRow.append($("<td>").text(row.Butiran || ' - '));
                                  var amaun = parseFloat(row.Amaun) || 0;
                                  var amaunformatted = amaun.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                                  amaun = amaun.toFixed(2);
                                  newRow.append($("<td>").text(amaunformatted).css({ 'text-align': 'right', 'width': '17%' }));
                                  /*newRow.append($("<td>").text(amaun.toLocaleString('en-US', { maximumFractionDigits: 2 })).css({ 'text-align': 'right', 'width': '17%' }));*/
                                  tbody.append(newRow);

                                  totalAmaun += parseFloat(amaun); // Ensure that amaun is converted back to float before adding
                              }

                              var totalAmaunFormatted = totalAmaun.toFixed(2).toLocaleString('en-US', { maximumFractionDigits: 2 }); // Ensure totalAmaunFormatted has 2 decimal places
                              $("#totalPotongan").text(totalAmaunFormatted.replace(/\d(?=(\d{3})+\.)/g, '$&,'));
                              $("#totalPotongan2").val(totalAmaunFormatted.replace(/\d(?=(\d{3})+\.)/g, '$&,'));
                          } else {
                              var messageRow = $("<tr>").append($("<td>").attr("colspan", 3).text("No data available"));
                              tbody.append(messageRow);
                          }

                          $("#totalPotongan3").val(row.GajiPlusElaun.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,'));

                          var percentageP = (totalAmaun * 100 / row.GajiPlusElaun).toFixed(2); // Calculate and round the percentage to 2 decimal places
                          $("#totalPotongan4").val(percentageP);
                          console.log(percentageP);

                      },
                      error: function (xhr, error, thrown) {
                          console.log("Ajax error:", error);
                      }
                  });
              }


              function fetchThirdTableData(NoPinjaman) {
                  $.ajax({
                      type: "POST",
                      url: "PertanyaanPinjaman_WS.asmx/Get_ThirdTableData",
                      contentType: "application/json; charset=utf-8",
                      dataType: "json",
                      data: JSON.stringify({ NoPinjaman: NoPinjaman }),
                      success: function (response) {
                          var table = $("#ulasan-table");
                          var tbody = table.find("tbody");
                          tbody.empty();
                          var dataArray = JSON.parse(response.d);
                          if (dataArray.length > 0) {
                              for (var i = 0; i < dataArray.length; i++) {
                                  var row = dataArray[i];
                                  var newRow = $("<tr>");

                                  newRow.hover(
                                      function () {
                                          $(this).addClass("hover pe-auto bg-warning");
                                      },
                                      function () {
                                          $(this).removeClass("hover pe-auto bg-warning");
                                      }
                                  );

                                  var checkboxCell = $("<td style='text-align:center; width: 5%'>");
                                  var statusCheckbox = $("<input type='checkbox' class='bil-checkbox'/>");

                                  // Check the checkbox if Status is 1
                                  if (row.CheckedStatus === '1') {
                                      statusCheckbox.prop("checked", true);
                                  }

                                  // Disable the checkbox
                                  statusCheckbox.prop("disabled", true);

                                  checkboxCell.append(statusCheckbox);
                                  newRow.append(checkboxCell);

                                  newRow.append($("<td>").text(row.Butiran || ' - '));
                                  // If you have additional columns, append them as needed

                                  tbody.append(newRow);
                              }
                          } else {
                              var messageRow = $("<tr>").append($("<td>").attr("colspan", 2).text("No data available"));
                              tbody.append(messageRow);
                          }
                      },
                      error: function (xhr, error, thrown) {
                          console.log("Ajax error:", error);
                      }
                  });
              }

              $('.btnSearch').click(async function () {
                  isClicked7 = true;
                  loadSenarai();
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
          });

          function toggleFieldsetVisibility2() {
              var hargaKenderaan = document.getElementById('hargaKenderaan').value;
              var hargaKomputer = document.getElementById('hargaKomputer').value;
              var hargaSukan = document.getElementById('hargaSukan').value;

              var infoKenderaanTab = document.querySelector('a[href="#kend"]');
              var infoKomputerTab = document.querySelector('a[href="#komp"]');
              var infoSukanTab = document.querySelector('a[href="#sukan"]');

              // Check conditions and adjust tab visibility accordingly
              if (hargaKenderaan.trim() !== '') {
                  infoKenderaanTab.parentElement.style.display = 'block';
              } else {
                  infoKenderaanTab.parentElement.style.display = 'none';
              }

              if (hargaKomputer.trim() !== '') {
                  infoKomputerTab.parentElement.style.display = 'block';
              } else {
                  infoKomputerTab.parentElement.style.display = 'none';
              }

              if (hargaSukan.trim() !== '') {
                  infoSukanTab.parentElement.style.display = 'block';
              } else {
                  infoSukanTab.parentElement.style.display = 'none';
              }
          }



          //async function initDropdownCOA(id, vot) {
          //    console.log(id);
          //    console.log(vot);
          //    $('#' + id).dropdown({
          //        fullTextSearch: true,
          //        onChange: function (value, text, $selectedItem) {

          //            var curTR = $(this).closest("tr");

          //            var recordIDVotHd = curTR.find("td > .Hid-vot-list");
          //            recordIDVotHd.html($($selectedItem).data("value"));

          //            var recordIDPtj = curTR.find("td > .label-ptj-list");
          //            recordIDPtj.html($($selectedItem).data("coltambah1"));

          //            var recordIDPtjHd = curTR.find("td > .Hid-ptj-list");
          //            recordIDPtjHd.html($($selectedItem).data("coltambah5"));

          //            var recordID_ = curTR.find("td > .label-kw-list");
          //            recordID_.html($($selectedItem).data("coltambah2"));

          //            var recordIDkwHd = curTR.find("td > .Hid-kw-list");
          //            recordIDkwHd.html($($selectedItem).data("coltambah6"));

          //            var recordID_ko = curTR.find("td > .label-ko-list");
          //            recordID_ko.html($($selectedItem).data("coltambah3"));

          //            var recordIDkoHd = curTR.find("td > .Hid-ko-list");
          //            recordIDkoHd.html($($selectedItem).data("coltambah7"));

          //            var recordID_kp = curTR.find("td > .label-kp-list");
          //            recordID_kp.html($($selectedItem).data("coltambah4"));

          //            var recordIDkpHd = curTR.find("td > .Hid-kp-list");
          //            recordIDkpHd.html($($selectedItem).data("coltambah8"));


          //        },
          //        apiSettings: {
          //            url: 'PertanyaanPinjaman_WS.asmx/GetVotCOA?q={query}&vot={vot}',
          //            method: 'POST',
          //            dataType: "json",
          //            contentType: 'application/json; charset=utf-8',
          //            cache: false,
          //            fields: {

          //                value: "value",      // specify which column is for data
          //                name: "text",      // specify which column is for text
          //                colPTJ: "colPTJ",
          //                colhidptj: "colhidptj",
          //                colKW: "colKW",
          //                colhidkw: "colhidkw",
          //                colKO: "colKO",
          //                colhidko: "colhidko",
          //                colKp: "colKp",
          //                colhidkp: "colhidkp",

          //            },
          //            beforeSend: function (settings) {
          //                settings.urlData.vot = vot;
          //                settings.data = JSON.stringify({ q: settings.urlData.query, vot: settings.urlData.vot });

          //                return settings;
          //            },
          //            onSuccess: function (response) {
          //                // Clear existing dropdown options
          //                var obj = $(this);

          //                var objItem = $(this).find('.menu');
          //                $(objItem).html('');

          //                // Add new options to dropdown
          //                if (response.d.length === 0) {
          //                    $(obj.dropdown("clear"));
          //                    return false;
          //                }

          //                var listOptions = JSON.parse(response.d);

          //                $.each(listOptions, function (index, option) {
          //                    //$(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
          //                    $(objItem).append($('<div class="item" data-value="' + option.value + '" data-coltambah1="' + option.colPTJ + '" data-coltambah5="' + option.colhidptj + '" data-coltambah2="' + option.colKW + '" data-coltambah6="' + option.colhidkw + '" data-coltambah3="' + option.colKO + '" data-coltambah7="' + option.colhidko + '" data-coltambah4="' + option.colKp + '" data-coltambah8="' + option.colhidkp + '" >').html(option.text));
          //                });

          //                // Refresh dropdown
          //                $(obj).dropdown('refresh');

          //                if (shouldPop === true) {
          //                    $(obj).dropdown('show');
          //                }
          //            }
          //        }

          //    });
          //}

          // ---------------------- UNTUK TABLE END -------------------------
          // ---------------------- UNTUK TABLE GAJI START ------------------
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
          // ---------------------- UNTUK TABLE GAJI END --------------------
          // ---------------------- UNTUK SETUJU START ----------------------
          //function getDateTimeMesyuarat() {
          //    var tarikhMesyuaratInput = document.getElementById("tarikhMesyuarat").value;             
              
          //    var date = new Date(tarikhMesyuaratInput);
          //    var year = date.getFullYear();
          //    var month = (date.getMonth() + 1).toString().padStart(2, '0');
          //    var day = date.getDate().toString().padStart(2, '0');
          //    var hours = date.getHours().toString().padStart(2, '0');
          //    var minutes = date.getMinutes().toString().padStart(2, '0');
          //    var seconds = date.getSeconds().toString().padStart(2, '0');

          //    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
          //}

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
          var resolvedUrl = '<%= ResolveClientUrl("~/FORMS/PINJAMAN/BAYAR BALIK/CetakJadualBayarBalik.aspx") %>';

          $("#btnSimpan1").off('click').on('click', async function () {
              var selectedValue = slctdNoPinj;
              var params = `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;
              if (isSet(selectedValue)) {
                  //Dptkan data dari ws
                  var data = await ajaxPost('<%= ResolveClientUrl("~/FORMS/PINJAMAN/BAYAR BALIK/BayarBalikWS.asmx/FetchData") %>', { NoPinj: selectedValue }, false);
                  if (data.Status) {
                      //data4cjbb = data for cetak jadual bayar balik
                      sessionStorage.setItem("data4cjbb", JSON.stringify(data.Payload));// simpan data di session storage
                      window.open(resolvedUrl, '_blank', params);
                  }
              } else {
                  $("#lblMessageModal").text("Sila buat pilihan bagi carian dibawah")
                  $("#MessageModal").modal("toggle");
              }
          });

          function isSet(value) {
              if (value === null || value === '' || value === undefined) {
                  return false;
              } else {
                  return true;
              }
          }

          //$('.btnSimpan1').off('click').on('click', async function () {
          //    var msg = "";

          //    var msg = "<textarea class='form-control' id='confirmationText1' placeholder='Ulasan'></textarea>";
          //    $('#confirmationMessage1').html(msg);
          //    $('#saveConfirmationModal1').modal('show');

          //    $('#confirmSaveButton1').off('click').on('click', async function () {
          //        $('#saveConfirmationModal1').modal('hide');

          //        var confirmationText = $('#confirmationText1').val();
          //        debugger
          //        var newPengesahan = {
          //            mohonPengesahan: {

          //                setujuPengesahan: confirmationText,
          //                tarikhPengesahan: getCurrentDateTime(),
          //                /*skimPengesahan: $('#skimPinjaman').val(),*/
          //                /*tarikhmesyuaratPengesahan: getDateTimeMesyuarat(),*/
          //                /*tempatPengesahan: $('#tempatMesyuarat').val(),*/
          //                /*amaunPengesahan: $('#amaun').val().replace(/,/g, ''),*/ // Remove commas from the value
          //                /*tempohPengesahan: $('#tempohPinjaman').val(),*/
          //                /*bilPengesahan: $('#bilMesyuarat').val(),*/
          //                /*filePengesahan: $('#failRujukan').val(),*/
          //                confirmPengesahan: $('#confirmSaveButton1').val(),
          //                /*novotPengesahan: $('#ddlCOA').val(),*/
          //                ptjPengesahan: $('.Hid-ptj-list').eq(0).html(),
          //                kumpulanwangPengesahan: $('.Hid-kw-list').eq(0).html(),
          //                operasiPengesahan: $('.Hid-ko-list').eq(0).html(),
          //                projekPengesahan: $('.Hid-kp-list').eq(0).html(),
          //                nopinjamanPengesahan: sessionStorage.getItem('NoPinjaman'),
          //                nofailrujukanPengesahan: sessionStorage.getItem('NoFailRujukan'),
          //                kodpemiutangPengesahan: sessionStorage.getItem('KodPemiutang'),
          //            }
          //        }
          //        console.log(newPengesahan)

          //        var result = JSON.parse(await ajaxSavePengesahan(newPengesahan));

          //        if (result.Status === true) {
          //            showModal1("Success", result.Message, "success");
          //            tbl11.ajax.reload();
          //        }
          //        else {
          //            showModal1("Error", result.Message, "error");
          //        }
          //    });
          //});


          async function ajaxSavePengesahan(mohonPengesahan) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'PertanyaanPinjaman_WS.asmx/Save_Pengesahan',
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
          //function getDateTimeMesyuarat() {
          //    var tarikhMesyuaratInput = document.getElementById("tarikhMesyuarat").value;
          //    var date = new Date(tarikhMesyuaratInput);
          //    var year = date.getFullYear();
          //    var month = (date.getMonth() + 1).toString().padStart(2, '0');
          //    var day = date.getDate().toString().padStart(2, '0');
          //    var hours = date.getHours().toString().padStart(2, '0');
          //    var minutes = date.getMinutes().toString().padStart(2, '0');
          //    var seconds = date.getSeconds().toString().padStart(2, '0');

          //    return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
          //}


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

              var msg = "<textarea class='form-control' id='confirmationText2' placeholder='Ulasan'></textarea>";
              $('#confirmationMessage2').html(msg);
              $('#saveConfirmationModal2').modal('show');

              $('#confirmSaveButton2').off('click').on('click', async function () {
                  $('#saveConfirmationModal2').modal('hide');

                  var confirmationText = $('#confirmationText2').val();

                  var newPengesahan = {
                      mohonPengesahan: {
                          setujuPengesahan: confirmationText,
                          tarikhPengesahan: getCurrentDateTime(),
                          /*skimPengesahan: $('#skimPinjaman').val(),*/
                          /*tempatPengesahan: $('#tempatMesyuarat').val(),*/
                          /*tarikhmesyuaratPengesahan: getDateTimeMesyuarat(),*/
                          amaunPengesahan: $('#amaun').val().replace(/,/g, ''),
                          /*tempohPengesahan: $('#tempohPinjaman').val(),*/
                          /*bilPengesahan: $('#bilMesyuarat').val(),*/
                          /*filePengesahan: $('#failRujukan').val(),*/
                          confirmPengesahan: $('#confirmSaveButton2').val(),
                          novotPengesahan: $('#ddlCOA').val(),
                          ptjPengesahan: $('.Hid-ptj-list').eq(0).html(),
                          kumpulanwangPengesahan: $('.Hid-kw-list').eq(0).html(),
                          operasiPengesahan: $('.Hid-ko-list').eq(0).html(),
                          projekPengesahan: $('.Hid-kp-list').eq(0).html(),
                          nopinjamanPengesahan: sessionStorage.getItem('NoPinjaman'),
                          nofailrujukanPengesahan: sessionStorage.getItem('NoFailRujukan'),
                          kodpemiutangPengesahan: sessionStorage.getItem('KodPemiutang'),
                      }
                  }
                  console.log(newPengesahan)

                  var result = JSON.parse(await ajaxSavePengesahan(newPengesahan));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                      tbl11.ajax.reload();
                  }
                  else {
                      showModal1("Error", result.Message, "error");
                  }
              });
          });


          //async function ajaxSavePengesahan(mohonPengesahan) {
          //    return new Promise((resolve, reject) => {
          //        $.ajax({
          //            url: 'KelulusanPinjaman_WS.asmx/Save_Pengesahan2',
          //            method: 'POST',
          //            data: JSON.stringify(mohonPengesahan),
          //            dataType: 'json',
          //            contentType: 'application/json; charset=utf-8',
          //            success: function (data) {
          //                resolve(data.d);
          //            },
          //            error: function (xhr, textStatus, errorThrown) {
          //                console.error('Error:', errorThrown);
          //                reject(false);
          //            }
          //        });
          //    });
          //}

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
          //document.addEventListener("DOMContentLoaded", function () {
          //    // Get the initial value from amaunMohon and set it to the input with id amaun
          //    document.getElementById("amaun").value = document.getElementById("amaunMohon2").value;

          //    // Update the value every 1 second
          //    setInterval(function () {
          //        // Update the value of the input with id amaun
          //        document.getElementById("amaun").value = document.getElementById("amaunMohon2").value;
          //    }, 1);

          //    // Add event listener to update amaunMohon when amaun changes
          //    document.getElementById("amaun").addEventListener("input", function () {
          //        // Update the value of the input with id amaunMohon
          //        document.getElementById("amaunMohon2").value = this.value;
          //    });
          //});

          //document.addEventListener('DOMContentLoaded', function () {
          //    var amaunInput = document.getElementById('amaun');
          //    var votAmaunInput = document.getElementById('votAmaun');

          //    amaunInput.addEventListener('input', function () {
          //        votAmaunInput.value = amaunInput.value;
          //    });

          //    // Update votAmaunInput every 1000 milliseconds (1 second)
          //    setInterval(function () {
          //        votAmaunInput.value = amaunInput.value;
          //    }, 1);
          //});

          document.getElementById('refreshButton').addEventListener('click', function () {
              show_loader()
              location.reload(true); // Hard refresh
              close_loader()
          });

          document.getElementById('refreshButton2').addEventListener('click', function () {
              show_loader()
              location.reload(true); // Hard refresh
              close_loader()
          });

          document.getElementById('refreshButton3').addEventListener('click', function () {
              show_loader()
              location.reload(true); // Hard refresh
              close_loader()
          });

          //document.getElementById('amaun').addEventListener('input', function (e) {
          //    // Remember cursor position
          //    let start = e.target.selectionStart;
          //    let end = e.target.selectionEnd;

          //    // Remove non-numeric characters except period
          //    let inputValue = e.target.value.replace(/[^\d.]/g, '');

          //    let parts = inputValue.split('.');
          //    let integerPart = parts[0];
          //    let decimalPart = parts[1];

          //    integerPart = integerPart.replace(/\B(?=(\d{3})+(?!\d))/g, ',');

          //    if (decimalPart !== undefined) {
          //        decimalPart = decimalPart.slice(0, 2); // Keep only first two digits
          //    } else {
          //        decimalPart = '00'; // Add .00 if no decimal part
          //    }

          //    e.target.value = integerPart + '.' + decimalPart;

          //    e.target.setSelectionRange(start, end);
          //    e.target.setSelectionRange(start, end);
          //});

          // Get the value from input field with id "amaunMohon"
          var amaunMohonValue = document.getElementById('amaunMohon').value;

          async function loadSenarai() {
              var startDate = $('#txtTarikhStart').val();
              var endDate = $('#txtTarikhEnd').val();

              var postDt = {
                  category_filter: $('#categoryFilter').val(),
                  isClicked7: isClicked7,
                  tkhMula: startDate,
                  tkhTamat: endDate
              }

              var data = await ajaxPost("PertanyaanPinjaman_WS.asmx/LoadIndividu", postDt, true);

              if (isSet(data)) {
                  tbl.clear();
                  tbl.rows.add(data.Payload).draw();
                  //var rowCount = tbl.rows().count();
              }
          }

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

          // Set the value to the input field with id "amaun"
          /*document.getElementById('amaun').value = amaunMohonValue;*/
      </script>
      <!------------------------------------------------------------------- SCRIPT END ------------------------------------------------------------------------->
</asp:Content>