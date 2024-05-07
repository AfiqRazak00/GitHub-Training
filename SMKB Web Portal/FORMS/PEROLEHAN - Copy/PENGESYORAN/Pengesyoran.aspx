<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pengesyoran.aspx.vb" Inherits="SMKB_Web_Portal.Pengesyoran" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
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

           #tblDataSenarai td:hover {
               cursor: pointer;
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

           #tblDataSenarai td:hover {
               cursor: pointer;
           }

           .ui.search.dropdown {
               height: 40px;
           }

           .tabcontent {
               padding: 0px 20px 20px 20px !important;
           }

           .table-title {
               padding-top: 0px !important;
               padding-bottom: 0px !important;
           }

           .custom-table > tbody > tr:hover {
               background-color: #ffc83d !important;
           }

           #tblDataSenarai td:hover {
               cursor: pointer;
           }

           .default-primary {
               background-color: #007bff !important;
               color: white;
           }
           /*start sticky table tbody tfoot*/
           table {
               overflow: scroll;
               border-collapse: collapse;
               /*color: white;*/
           }

           .secondaryContainer {
               overflow: scroll;
               border-collapse: collapse;
               height: 500px;
               border-radius: 10px;
           }

           .sticky-footer {
               position: sticky;
               bottom: 0;
               background-color: white;
               z-index: 2;
           }

               .sticky-footer th,
               .sticky-footer td {
                   text-align: center; /* Center-align the content in footer cells */
                   border-top: 1px solid #ddd; /* Add a border at the top to separate from data rows */
                   padding: 10px; /* Adjust padding as needed */
               }

           #showModalButton:hover {
               background-color: #ffc107; /* Change background color on hover */
               color: #fff; /* Change text color on hover */
               border-color: #ffc107; /* Change border color on hover */
               cursor: pointer; /* Change cursor to indicate interactivity */
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

           #tblKelulusan td:hover {
               cursor: pointer;
           }

           #tblSenaraiEP td:hover {
               cursor: pointer;
           }

           #tblSenaraiHadir td:hover {
               cursor: pointer;
           }

           tblKelulusan3 td:hover {
               cursor: pointer;
           }

           tblbuku1 td:hover {
               cursor: pointer;
           }

           tblbuku2 td:hover {
               cursor: pointer;
           }

           .fix-hade {
               top: 0;
               position: sticky;
               background: white;
           }

           .smaller-font {
               font-size: 13px;
           }
   </style>
   <div id="PermohonanTab" class="tabcontent" style="display: block">
      <!-- Modal -->
      <div id="permohonan">
         <div >
            <div class=" " >
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Mesyuarat Pengesyoran Sebut Harga / Tender Universiti</h5>
               </div>
               <!-- Create the dropdown filter -->
               <div class="search-filter">
                  <div class="form-row justify-content-center">
                     <div class="form-group row col-md-6">
                        <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align:right">Carian :</label>
                        <div class="col-sm-8">
                           <div class="input-group">
                              <select id="categoryFilter" class="custom-select" >
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
                                 <label id="lblMula" style="text-align: right;display:none;"  >Mula: </label>
                              </div>
                              <div class="form-group col-md-4">
                                 <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display:none;" class="form-control date-range-filter">
                              </div>
                              <div class="form-group col-md-1">
                              </div>
                              <div class="form-group col-md-1">
                                 <label id="lblTamat" style="text-align: right;display:none;" >Tamat: </label>
                              </div>
                              <div class="form-group col-md-4">
                                 <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display:none;" class="form-control date-range-filter">
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="row">
                  <div class="col-md-12">
                     <div class="transaction-table table-responsive">
                        <table id="tblKelulusan" class="table table-striped">
                           <thead>
                              <tr style="width: 100%">
                                 <th scope="col" style="width: 2%">Bil</th>
                                 <th scope="col" style="width: 8%">ID Mesyuarat</th>
                                 <th scope="col" style="width: 10%">Jawatankuasa</th>
                                 <th scope="col" style="width: 10%">Tempat Mesyuarat</th>
                                 <th scope="col" style="width: 5%">Tarikh Mesyuarat</th>
                              </tr>
                           </thead>
                           <tbody id="" onclick="ShowPopup('1')">
                              <tr style=" width: 100%" class="table-list">
                                 <td style="width: 2%">
                                 </td>
                                 <td style="width: 8%">
                                 </td>
                                 <td style="width: 10%">
                                 </td>
                                 <td style="width: 10%">
                                 </td>
                                 <td style="width: 5%">
                                    <button id="Button1" runat="server" class="btn btnDelete" type="button" style="color: blue">
                                    <i class="fa fa-clipboard"></i>
                                    </button>
                                 </td>
                              </tr>
                           </tbody>
                        </table>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- Modal -->
      <div class="modal fade" id="senaraiHargaModal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-xl" style="max-width: 80%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Senarai Sebut Harga / Tender Universiti </h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <div class="form-row" >
                     <div class="col-md-6">
                        <input class="input-group__input" name="lblStatus1" id="lblStatus1" type="text"  readonly style="background-color: #f0f0f0" />
                        <label class="input-group__label" for="lblStatus1">ID Mesyuarat</label>
                     </div>
                  </div>
                  <br />
                  <div class="form-row" >
                     <div class="col-md-6">
                        <input class="input-group__input" name="lblStatus2" id="lblStatus2" type="text"  readonly style="background-color: #f0f0f0" />
                        <label class="input-group__label" for="lblStatus2">Tempat</label>
                     </div>
                  </div>
                  <br />
                  <div class="form-row" >
                     <div class="col-md-6">
                        <input class="input-group__input" name="lblStatus3" id="lblStatus3" type="text"  readonly style="background-color: #f0f0f0" />
                        <label class="input-group__label" for="lblStatus3">Tarikh Masa</label>
                     </div>
                  </div>
                  <br />
                  <div class="form-row">
                      <div class="form-group col-md-6">
                        <label class="input-group__label"><u>Senarai Proses Pengesyoran</u></label>
                     </div>
                     <br /><br />
                     <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                           <div style="max-height: 400px; overflow-y: auto;">
                              <table id="tblSenaraiEP" class="table table-striped" style="width: 100%">
                                 <thead class="fix-hade">
                                    <tr>
                                       <th scope="col" style="width: 5%">Bil</th>
                                       <th scope="col" style="width: 25%">No Perolehan</th>
                                       <th scope="col" style="width: 25%">No Sebut Harga/Tender</th>
                                       <th scope="col" style="width: 25%">Tujuan</th>
                                       <th scope="col" style="width: 25%">Kategori</th>
                                       <th scope="col" style="width: 25%">No Naskah Jualan</th>
                                       <th scope="col" style="width: 25%">Tarikh & Masa Mula Iklan</th>
                                       <th scope="col" style="width: 25%">Tarikh & Masa Tamat Perolehan</th>
                                    </tr>
                                 </thead>
                                 <tbody id="" onclick="ShowPopup('2')">
                                    <tr style=" width: 100%" class="table-list">
                                    </tr>
                                 </tbody>
                              </table>
                           </div>
                        </div>
                     </div>
                  </div>
                  <br />
                  <div class="form-row">
                     <div class="form-group col-md-6">
                        <label class="input-group__label"><u>Senarai Kehadiran & Pengesahan Pengesyoran</u></label>
                     </div>
                     <br /><br />
                     <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                           <div style="max-height: 400px; overflow-y: auto;">
                              <table id="tblSenaraiHadir" class="table table-striped" style="width: 100%">
                                 <thead class="fix-hade">
                                    <tr>
                                       <th scope="col" style="width: 5%">Bil</th>
                                       <th scope="col" style="width: 25%">No Staf</th>
                                       <th scope="col" style="width: 25%">Nama</th>
                                       <th scope="col" style="width: 25%">PTJ</th>
                                       <th scope="col" style="width: 25%">Jabatan</th>
                                       <th scope="col" style="width: 25%">Peranan</th>
                                       <th scope="col" style="width: 25%">Email</th>
                                       <th scope="col" style="width: 25%">Hadir?</th>
                                    </tr>
                                 </thead>
                                 <tbody id="">
                                    <tr style=" width: 100%" class="table-list">
                                    </tr>
                                 </tbody>
                              </table>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
               <div class="col text-center m-3">
                  <button type="button" class="btn btn-secondary btnSave" data-placement="bottom" title="Simpan" id="btnSave">Hantar</button>
               </div>
            </div>
         </div>
      </div>
      <!-- modal end -->
      <!-- modal start -->
      <div class="modal fade" id="maklumatPermohonanModal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-xl" style="max-width: 80%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <%--<button type="button" class="btn btn-secondary" onclick="goBackmodal()">Kembali</button>&nbsp;&nbsp;<br />--%>
                  <h5 class="modal-title">Ringkasan Pengesyoran</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <div class="form-row" >
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="txtIdMesy" type="text" placeholder="&nbsp;" name="ID Mesyuarat" value="NJ430000011123" readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="ID Mesyuarat">No Jualan Naskah :	</label>
                        </div>
                     </div>
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="noMohonValue" type="hidden" placeholder="&nbsp;" name="ID Mesyuarat" value="DS4300000000021123" readonly style="background-color: #f0f0f0"/>
                           <input class="input-group__input " id="noPerolehan" type="text" placeholder="&nbsp;" name="noPerolehan" readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="noPerolehan">No Perolehan :	</label>
                        </div>
                     </div>
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="ddlPTJPemohon" type="text" placeholder="&nbsp;" name="ID Mesyuarat"  readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="ID Mesyuarat">PTJ :</label>
                        </div>
                     </div>
                  </div>
                  <div class="form-row">
                     <div class="col-md-12">
                        <div class=" form-group">
                           <textarea class="input-group__input"  id="tujuanValue" readonly style="background-color: #f0f0f0; height:auto"  rows="4"></textarea>
                           <label class="input-group__label" for="floatingTextarea">Tujuan Perolehan :</label>
                        </div>
                     </div>
                  </div>
                  <div class="form-row" >
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="KategoriValue" type="text" placeholder="&nbsp;" name="ID Mesyuarat"  value="BEKALAN" readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="ID Mesyuarat">Kategori Perolehan :</label>
                        </div>
                     </div>
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="txtKaedahPerolehan" type="text" placeholder="&nbsp;" name="txtKaedahPerolehan"  readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="txtKaedahPerolehan">Kaedah Perolehan :	</label>
                        </div>
                     </div>
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="txtNoSebutHarga" type="text" placeholder="&nbsp;" name="txtNoSebutHarga"  readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="txtNoSebutHarga">No Sebut Harga/Tender :</label>
                        </div>
                     </div>
                  </div>
                  <div class="form-row" >
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="jumHargaValue" type="text" placeholder="&nbsp;" name="jumHargaValue"  readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="jumHargaValue">Anggaran Harga (RM) :</label>
                        </div>
                     </div>
                  </div>
                  <div class="card card-body">
                     <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Senarai Dokumen :</h6>
                     <div class="col-md-12">
                        <div class=" transaction-table table-responsive">
                           <table id="tblDokumen" class="table table-striped" style="width: 100%">
                              <thead class="fix-hade">
                                 <tr style="width: 100%">
                                    <th scope="col">Id_Upload</th>
                                    <th scope="col">File Path</th>
                                    <th scope="col">Bil</th>
                                    <th scope="col">Nama Fail</th>
                                    <th scope="col">Tindakan</th>
                                 </tr>
                              </thead>
                              <tbody id="">
                              </tbody>
                           </table>
                        </div>
                     </div>
                  </div>
                  <!--- datatable display senarai petender --->
                  <div class="modal-body">
                     <div class="form-row" >
                        <div class="col-md-12">
                           <div class="transaction-table table-responsive">
                           <div style="max-height: 500px; overflow-y: auto;">
                              <table id="tblSenaraiPetender" class="table table-striped" style="width: 100%">
                                 <thead class="fix-hade">
                                    <tr style="background-color: #FFC83D">
                                       <th style="width: 5%"></th>
                                       <th style="width: 5%; text-align: center">Bil</th>
                                       <th style="width: 5%; text-align: center">Kod</th>
                                       <th style="width: 10%; text-align: center">Tempoh Bekal/Siap</th>
                                       <th style="width: 10%; text-align: center">Harga Tawaran (RM)</th>
                                       <th style="width: 10%; text-align: center">Perbezaan Harga Tawaran (RM)</th>
                                       <th style="width: 10%; text-align: center">Peratusan Perbezaan</th>
                                       <th style="width: 5%; text-align: center">Syor P.Harga</th>
                                       <th style="width: 15%; text-align: center">Ulasan Syor Harga</th>
                                       <th style="width: 5%; text-align: center">Syor P.Teknikal</th>
                                       <th style="width: 10%; text-align: center">Ulasan Syor Teknikal</th>
                                       <th style="width: 5%; text-align: center">Peratus Am</th>
                                       <th style="width: 5%; text-align: center">Peratus Teknikal</th>
                                       <th style="width: 5%; text-align: center">Syor</th>
                                       <th style="text-align: center">Ulasan Syor</th>
                                       <th style="width: 5%; text-align: center">Status Buku1</th>
                                       <th style="width: 5%; text-align: center">Status Buku2</th>
                                       <%--<th style="width: 5%; text-align: center">e-Bidding</th>--%>
                                    </tr>
                                 </thead>
                                 <tbody id="" style="cursor:pointer;overflow:auto; ">
                                 </tbody>
                              </table>
                           </div>
                           </div>
                        </div>
                     </div>
                  </div>
                  <!--- datatable display senarai petender end--->
                   <div class="col-md-6">
                        <div class="form-group row">
                             <div class="col-md-3">
                                <h6 >Pemilihan :</h6>
                                 <small class="form-text text-muted">Permohonan ini akan dimasukkan ke e-Bidding</small>
                             </div>
                             <div class="col-md-9 radio-btn-form d-flex">
                                    <div class="form-check form-check-inline" style="margin-left: 10px">
                                     <input type="radio" id="rdBid" name="inlineRadioOptions" value="1" class="w-200" />
                                     <label class="form-check-label" for="rdBid" style="margin-left:5px;margin-bottom: 0;">&nbsp;&nbsp;e-Bidding</label>
                                </div>
                                <div class="form-check form-check-inline" style="margin-left: 40px">
                                      <%--<input type="radio" id="rdLntk" name="inlineRadioOptions" value="0" class="w-200" />--%>
                                    <%--<label class="form-check-label" for="rdBid" style="margin-left:5px;margin-bottom: 0;">&nbsp;&nbsp;Tidak Perlu</label>--%>
                                 </div>
                              </div>
                         </div>
                    </div>
                 <%--  <div class="col-md-12"><div class="card card-body">
                     <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Pemilihan Pengesyoran :</h6>
                          <div class="radio-btn-form d-flex " id="chkBid" name="chkBid">
                               <div class="form-check form-check-inline" style="margin-top: 10px; margin-left: 10px">
                                     <input type="radio" id="rdBid" name="inlineRadioOptions" value="0" class="w-200" />
                                     <label class="form-check-label" for="rdLPH">&nbsp;&nbsp;e-Bidding</label>
                                </div>
                                <div class="form-check form-check-inline" style="margin-top: 10px; margin-left: 40px">
                                      <input type="radio" id="rdLntk" name="inlineRadioOptions" value="1" class="w-200" />
                                      <label class="form-check-label" for="rdJPH">&nbsp;&nbsp;Perlantikan Vendor</label>
                                 </div>
                            </div>
                     </div>
                   </div>--%>
               </div>
               <div class="col text-center m-3">
                  <button type="button" class="btn btn-secondary btnSimpanSyor" data-placement="bottom" title="Simpan" id="btnSimpanSyor">Simpan</button>
               </div>
            </div>
         </div>
      </div>
      <!-- modal end -->
         <%--//semak buku1--%>
        <div class="modal fade" id="modalBuku1" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 50%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Semak Buku 1</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                    <table id="tblbuku1" class="table table-striped" style="width: 100%">
                          <thead>
                              <tr data-id="" style="width: 100%">
                                  <th scope="col" style="width: 5%;">Bil</th>
                                  <th scope="col" style="width: 90%;">Senarai Semak</th>
                                  <th scope="col" style="width: 5%; text-align: center;">Tindakan</th>
                              </tr>
                               </thead>
                              <tbody id=""></tbody>
                    </table>
               </div>
                <%--<div class="col text-center m-3"> 
                        <button id="selesaiButton1" type="button" class="btn btn-secondary selesaiButton1" data-dismiss="modal" onclick="changeIcon1()">Selesai</button>
                </div>--%>
            </div>
         </div>
      </div>
       <%--//semak buku1 end--%>

       <%--//semak buku2--%>
        <div class="modal fade" id="modalBuku2" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 50%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Semak Buku 2</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                   <table id="tblbuku2" class="table table-striped" style="width: 100%">
                         <thead>
                            <tr data-id="" style="width: 100%">
                                 <th scope="col" style="width: 5%;">Bil</th>
                                 <th scope="col" style="width: 90%;">Senarai Semak</th>
                                 <th scope="col" style="width: 5%; text-align: center;">Tindakan</th>
                             </tr>
                          </thead>
                          <tbody id=""></tbody>
                   </table>
               </div>
               <%-- <div class="col text-center m-3"> 
                        <button id="selesaiButton2" type="button" class="btn btn-secondary selesaiButton2" data-dismiss="modal" onclick="changeIcon2()">Selesai</button>
                </div>--%>
            </div>
         </div>
      </div>
        <%--//semak buku2 end--%>

         <%--//profilsyarikat start--%>
           <div class="modal fade" id="profilSyaModal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Profile Syarikat</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                   <table id="profilsyarikat" class="table table-striped" style="width: 99%">
                         <thead>
                            <tr data-id="" style="width: 100%">
                                 <th scope="col" style="width: 5%;">Id_Upload</th>
                                 <th scope="col" style="width: 5%;">File Path</th>
                                 <th scope="col" style="width: 5%;">Bil</th>
                                 <th scope="col" style="width: 80%;">Lampiran</th>
                                 <th scope="col" style="width: 5%; text-align: center;">Tindakan</th>
                             </tr>
                          </thead>
                          <tbody id=""></tbody>
                   </table>

               </div>
   
            </div>
         </div>
      </div>
       <%--//profilsyarikat end--%>

        <%--//syaratam start--%>
           <div class="modal fade" id="syaratAmModal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Syarat-syarat Am</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <p style="margin-bottom: 10px;">Tertakluk kepada apa-apa syarikat khas yang lain didalam pelawaan ini, syarat-syarat am yang dinyatakan seperti berikut hendaklah terpakai kepada pembekal.</p>
                     <div class="border-container" style="max-width: 100%;">
                        <div class="text-container" style="text-align: justify;">
                            <h6> 1.0 BORANG SEBUT HARGA</h6>
                            <p>Sebarang identiti pengenalan, tanda atau cap pembida adalah <b>TIDAK DIBENARKAN</b> dipamer dalam setiap helaian <b>BUKU 2</b>. Sekiranya berlaku, UTeM berhak untuk <b>MEMBATALKAN</b> sebut harga dan pembida tersebut</p>
                            
                            <h6> 2.0 KEADAAN BARANG</h6>
                            <p>Semua barangan hendaklah dalam keadaan selamat.</p>

                            <h6> 3.0 HARGA</h6>
                            <p>Sebut harga ditawarkan adalah harga bersih termasuk semua diskaun dan kos tambahan yang berkaitan. Jumlah sebut harga yang ditawarkan mestilah tidak melebihi RM500,000.00</p>

                            <h6> 4.0 HARGA</h6>
                            <ul>
                                <li>4.1 Sebut harga boleh ditawarkan bagi semua bilangan item atau sebahagian bialngan item.</li>
                                <li>4.2 UTeM tidak terikat untuk menerima tawaran terendah atau mana-mana tawaran. UTeM berhak menerima sebahagian tawaran daripada mana-mana petender/penyebutharga.</li>
                                <li>4.3 Petender/Penyebutharga boleh menawarkan tawaran untuk semua item atau sebahagian item. Setiap tawaran untuk setiap item akan dianggap sebagai tawaran berasingan.</li>
                            </ul>

                             <h6> 5.0 BARANG-BARANG SETARA</h6>
                            <p>Sebut harga boleh ditawarkan bagi barang-barang setara yang sesuai dengan syarat butir-butir penuh barang-barang setara diberikan.</p>
                        </div>
                    </div>
                   <div style="text-align: center; margin-top: 10px;">
                        <label style="font-weight: normal;">Saya/kami dengan ini menawarkan pembekalan / perkhidmatan diatas dengan harga dan syarat-syarat dinyatakan.</label>
                    </div>
                 
               </div>
            
            </div>
         </div>
         </div>
        <%--//syaratam END--%>

         <%--//jadualharga start--%>
           <div class="modal fade" id="jadualHargaModal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Jadual Harga</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                    <table id="jadualHarga" class="table table-striped" style="width: 100%">
                               <thead class="fix-hade">
                                 <tr>
                                    <th scope="col" style="width: 5%">Bil</th>
                                    <th scope="col" style="width: 25%">Speksifikasi Teknikal Fakulti/Jabatan</th>
                                    <th scope="col" style="width: 25%">Jenama</th>
                                    <th scope="col" style="width: 25%">Model</th>
                                    <th scope="col" style="width: 25%">Negara Pembuat</th>
                                    <th scope="col" style="width: 25%">Kuantiti</th>
                                    <th scope="col" style="width: 25%">Pembungkusan</th>
                                    <th scope="col" style="width: 25%">Harga Senit Bercukai [B] (RM)</th>
                                    <th scope="col" style="width: 25%">Harga Senit Tanpa Bercukai [C] (RM)</th>
                                    <th scope="col" style="width: 25%">Jumlah Harga Bercukai (RM)</th>
                                    <th scope="col" style="width: 25%">Jumlah Harga Tanpa Bercukai (RM)</th>
                                 </tr>
                              </thead>
                              <tbody id="">
                                 <tr style=" width: 100%" class="table-list">
                                 </tr>
                              </tbody>
                           </table>
            
               </div>
             
            </div>
         </div>
      </div>
       <%--//jadualharga end--%>

        <%--//jaminanpembekal start--%>
           <div class="modal fade" id="jaminanModal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Jaminan Pembekal</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                   <img src="../../../Images/logo.png" style="display: block; margin: 0 auto;"/>
                   <h5 style="text-align: center;"> UNIVERSITI TEKNIKAL MALAYSIA MELAKA</h5>
                   <div style="margin-top: 20px; margin-bottom: 10px; text-align: justify; padding-right: 30px; padding-left: 30px;">
                       <p>Saya dengan ini menawarkan untuk melaksanakan perolehan tersebut dengan segala penentuan dalam dokumen sebut harga:</p>
                       <ul style="list-style-type: decimal;">
                           <li>Tawaran sebanyak RM (Ringgit Malaysia).</li>
                           <li>Saya bersetuju untuk menyiapkan perolehan ini dalam tempoh dari Tarikh Surat Setuju Terima ditandatangani.</li>
                           <li>Saya bersetuju bahawa tempoh sah laku sebut harga ini akan dibuka selama 90 hari daripada sebut harga ini ditutup.</li>
                       </ul>
                   </div>
             
               </div>
               
            </div>
         </div>
      </div>
       <%--//jaminanpembekal end--%>

         <%--//suratpembida start--%>
           <div class="modal fade" id="suratPembidaModal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Surat Akaun Pembida</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                   <img src="../../../Images/logo.png" style="display: block; margin: 0 auto;"/>
                   <h5 style="text-align: center;"> UNIVERSITI TEKNIKAL MALAYSIA MELAKA</h5>
                   <div style="margin-top: 20px; margin-bottom: 10px; text-align: justify; padding-right: 10px; padding-left: 10px;">
                        <p>Saya yang mewakili syarikat bernombor pendaftaran dengan dengan ini mengisytiharkan bahawa saya atau mana-mana individu yang mewakili syarikat ini tidak akan menawarkan atau memberi rasuah kepada mana-mana individu dalam <b>Universiti Teknikal Malaysia Melaka</b> 
                           atau mana-mana individu lain sebagai ganjaran mendapatkan sebut harga seperti diatas. Bersama-sama ini dilampirkan Surat Perwakilan Kuasa bagi saya mewakili syarikat seperti tercatat diatas untuk membuat pengisytiharan ini.</p>
                       <ul style="list-style-type: lower-roman;">
                            <li>Penarikan balik tawaran kontrak bagi sebut harga diatas; atau </li>
                            <li>Penamatan kontrak bagi sebut harga diatas; dan </li>
                            <li>Lain-lain tindakan tatatertib mengikut peraturan perolehan Kerajaan.</li>
                        </ul>
                        <p>Sekiranya terdapat mana-mana individu cuba meminta rasuah daripada saya atau mana-mana individu yang berkaitan dengan syarikat ini sebagai ganjaran mendapatkan sebut harga seperti diatas, maka saya berjanji akan dengan segera melaporkan perbuatan tersebut kepada pejabat Suruhanjaya Perkhidmatan Rasuah Malaysia (SPRM) atau balai polis yang berhampiran.</p>
                   </div>
                
               </div>
                 
            </div>
         </div>
      </div>
       <%--//suratpembida end--%>

        <%--//borangpengalaman start--%>
           <div class="modal fade" id="BorangPengalaman" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Borang Pengalaman Pembekal</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                    <table id="pengalamanSyarikat" class="table table-striped" style="width: 99%">
                         <thead>
                            <tr data-id="" style="width: 100%">
                                 <th scope="col" style="width: 5%;">Bil</th>
                                 <th scope="col" style="width: 30%;">Tajuk Projek</th>
                                 <th scope="col" style="width: 30%;">Syarikat Yang Menawarkan Kerja</th>
                                 <th scope="col" style="width: 10%;">Tarikh Mula</th>
                                 <th scope="col" style="width: 10%;">Tarikh Tamat</th>
                                 <th scope="col" style="width: 10%;">Nilai Tawaran</th>
                                 <%--<th scope="col" style="width: 5%; text-align: center;">Tindakan</th>--%>
                             </tr>
                          </thead>
                          <tbody id=""></tbody>
                   </table>
                 
               </div>
                
            </div>
         </div>
      </div>
       <%--//borangpengalaman end--%>

         <%--//borangMulti start--%>
           <div class="modal fade" id="borangMultimodal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Borang Multimodal Transport</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                    <img src="../../../Images/logo.png" style="display: block; margin: 0 auto;"/>
                    <h5 style="text-align: center;"> UNIVERSITI TEKNIKAL MALAYSIA MELAKA</h5>
                   <div style="margin-top: 20px; margin-bottom: 10px; text-align: justify; padding-right: 30px; padding-left: 30px; font-weight: bold;">
                        <div class="form-group">
                               <h5 style="font-weight: bold;"><span id="txtNoSebutHarga"></span></h5>
                            <span style="font-style: italic; color: blue;">[Jika berkaitan sahaja]</span>
                         </div>

                        <div class="form-group">
                               <h6 style="font-weight: bold;">MAKLUMAT BERHUBUNG BARANGAN IMPORT YANG DITAWARKAN DALAM SEBUT HARGA</h6>
                         </div>
                       <%--form start--%>
             
                        <%--form end--%>

                   </div>
                    <div style="margin-top: 20px; margin-bottom: 10px; text-align: justify; padding-right: 30px; padding-left: 30px; font-weight: bold;">
                        MUSTAHAK:<br>
                        <p>Penyebut harga hendaklah mempastikan maklmat barangan yang diberikan adalah tepat dan lengkap bagi maksud sebut harga MTO. Kesilapan penyebut 
                            harga memberikan maklumat dengan betul menyebabkan penyebut harga akan dipertanggungjawabkan membayar tambang-tambang yang dituntut oleh MTO.</p>
                    </div>

                    <div style="margin-top: 10px; margin-bottom: 10px; text-align: justify; padding-right: 30px; padding-left: 30px;">
                        <p><b>Nota:</b> Maklumat para 4 sahaja boleh dikemaskini semula oleh penyebut harga yang berjaya dalam tempoh tidak lewat dari empat belas (14) hari dari tarikh surat setuju terima dikeluarkan.</p>
                    </div>

                    
               </div>
               
            </div>
         </div>
      </div>
       <%--//borangMulti end--%>

        <%--//sijilTerkini start--%>
           <div class="modal fade" id="sijilTerkini" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Salinan Sijil Terkini Syarikat</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
              <div class="modal-body">
                   <table id="sijilSyarikat" class="table table-striped" style="width: 100%">
                         <thead>
                            <tr data-id="" style="width: 100%">
                                 <th scope="col" style="width: 5%;">Id_Upload</th>
                                 <th scope="col" style="width: 5%;">File Path</th>
                                 <th scope="col" style="width: 5%;">Bil</th>
                                 <th scope="col" style="width: 80%;">Lampiran</th>
                                 <th scope="col" style="width: 5%; text-align: center;">Tindakan</th>
                             </tr>
                          </thead>
                          <tbody id=""></tbody>
                   </table>

                  
               </div>
               
            </div>
         </div>
      </div>
       <%--//sijilTerkini end--%>

        <%--//borangTeknikal start--%>
       <div class="modal fade" id="borangTeknikal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Borang Penentuan Teknikal</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
                 <div class="modal-body">

                    <ul class="nav nav-tabs" id="myTabs">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#spekAm">Maklumat Spesifikasi Am</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#spekTeknikal">Maklumat Spesifikasi Teknikal</a>
                        </li>
                    </ul>

                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="spekAm">
                            <div class="col-md-12">
                                <div class="panel-heading">
                                    <br />
                                    <h6 class="panel-title">Maklumat Spesifikasi Am</h6>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <!-- TblDataSpekAm-->
                                <div class="modal-body">
                                    <table id="spekfikasi-am-table" class="table table-striped" border="1" width="100%">
                                         <thead>
                                            <tr style="background-color:#FFC83D">
                                               <th style="width:5%"></th>
                                               <th style="width:25%;text-align:center"">Perkara</th>
                                            </tr>
                                         </thead>
                                         <tbody>
                                         </tbody>
                                      </table>
                                </div>
                            </div>
                        </div>

                        <!-- Borang Penentuan Teknikal -->
                        <div class="tab-pane fade" id="spekTeknikal">
                            <div class="col-md-12">
                                <div class="panel-heading">
                                    <br />
                                    <h6 class="panel-title">Maklumat Spesifikasi Teknikal</h6>
                                </div>
                            </div>
                              <div class="col-md-12">
                                <div class="modal-body">
                                             <table id="spekfikasi-tek-table" class="table table-striped" border="1" width="100%">
                                                 <thead>
                                                    <tr style="background-color:#FFC83D">
                                                       <th style="width:5%"></th>
                                                       <th style="width:25%;text-align:center"">Barang</th>
                                                       <th style="width:55%;text-align:center">Jenama</th>
                                                       <th style="width:25%;text-align:center"">Model</th>
                                                       <th style="width:55%;text-align:center">Negara</th>
                                                    </tr>
                                                 </thead>
                                                 <tbody>
                                                 </tbody>
                                              </table></div>
                            </div>
                        </div>
                    </div>
               
                </div>
             
            </div>
         </div>
      </div>
       <%--//borangTeknikal end--%>

        <%--//jadualKerja start--%>
         <div class="modal fade" id="jadualKerja" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Jadual Perancangan Kerja Pembekal</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                     <table id="kerjaJadual" class="table table-striped" style="width: 100%">
                         <thead>
                            <tr data-id="" style="width: 100%">
                                 <th scope="col" style="width: 5%;">Id_Upload</th>
                                 <th scope="col" style="width: 5%;">File Path</th>
                                 <th scope="col" style="width: 5%;">Bil</th>
                                 <th scope="col" style="width: 80%;">Nama Dokumen</th>
                                 <th scope="col" style="width: 5%; text-align: center;">Tindakan</th>
                             </tr>
                          </thead>
                          <tbody id=""></tbody>
                   </table>
         
               </div>
         
            </div>
         </div>
      </div>
       <%--//jadualKerja end--%>

        <%--//authLetter start--%>
           <div class="modal fade" id="authLetter" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Authorization Letter Dari Pembuat</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <table id="authorizeLetter" class="table table-striped" style="width: 100%">
                         <thead>
                            <tr data-id="" style="width: 100%">
                                 <th scope="col" style="width: 5%;">Id_Upload</th>
                                 <th scope="col" style="width: 5%;">File Path</th>
                                 <th scope="col" style="width: 5%;">Bil</th>
                                 <th scope="col" style="width: 10%;">Nama Projek</th>
                                 <th scope="col" style="width: 5%; text-align: center;">Tindakan</th>
                             </tr>
                          </thead>
                          <tbody id=""></tbody>
                   </table>
          
               </div>
         
            </div>
         </div>
      </div>
       <%--//authLetter end--%>

        <%--//katalog start--%>
           <div class="modal fade" id="katalog" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Katalog</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <table id="tblKatalog" class="table table-striped" style="width: 100%">
                         <thead>
                            <tr data-id="" style="width: 100%">
                                 <th scope="col" style="width: 5%;">Id_Upload</th>
                                 <th scope="col" style="width: 5%;">File Path</th>
                                 <th scope="col" style="width: 5%;">Bil</th>
                                 <th scope="col" style="width: 10%;">Nama Dokumen</th>
                                 <th scope="col" style="width: 5%; text-align: center;">Katalog</th>
                             </tr>
                          </thead>
                          <tbody id=""></tbody>
                   </table>

               </div>
             
            </div>
         </div>
      </div>
       <%--//katalog end--%>

        <%--//sample start--%>
           <div class="modal fade" id="sample" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 60%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Sample</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                     <table id="tblSample" class="table table-striped" style="width: 100%">
                         <thead>
                            <tr data-id="" style="width: 100%">
                                 <th scope="col" style="width: 5%;">Id_Upload</th>
                                 <th scope="col" style="width: 5%;">File Path</th>
                                 <th scope="col" style="width: 5%;">Bil</th>
                                 <th scope="col" style="width: 10%;">Nama Dokumen</th>
                                 <th scope="col" style="width: 5%; text-align: center;">Sample</th>
                             </tr>
                          </thead>
                          <tbody id=""></tbody>
                   </table>

               </div>

            </div>
         </div>
      </div>
       <%--//sample end--%>
            <!-- Modal Pengesahan start-->
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
          <!-- Modal Pengesahan end-->
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
       <!--end modal-->
   </div>

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
   <script>
       //back button
       function goBackmodal() {
           // Close the current modal
           $('#maklumatPermohonanModal').modal('hide');

           // Open the senaraiHargaModal
           $('#senaraiHargaModal').modal('show');
       }


       function ShowPopup(elm) {

           if (elm == "1") {

               $('#senaraiHargaModal').modal('toggle');


           }
           else if (elm == "2") {

               $('#senaraiHargaModal').modal('toggle');
               $('#maklumatPermohonanModal').modal('toggle');

           }
           else if (elm == "4") {
               $('#maklumatPermohonanModal').modal('toggle');
               $('#modalBuku1').modal('toggle');
           }
           else if (elm == "5") {
               $('#maklumatPermohonanModal').modal('toggle');
               $('#modalBuku2').modal('toggle');
           }
       }

       // Add an event listener for when the teknikalTabModal is hidden
       $('#modalBuku1').on('hidden.bs.modal', function () {
           // Show the maklumatPermohonanModal when teknikalTabModal is hidden
           $('#maklumatPermohonanModal').modal('show');
       });

       // Add an event listener for when the teknikalTabModal is hidden
       $('#modalBuku2').on('hidden.bs.modal', function () {
           // Show the maklumatPermohonanModal when teknikalTabModal is hidden
           $('#maklumatPermohonanModal').modal('show');
       });

       // Add an event listener for when the maklumatPermohonanModal is hidden
       $('#maklumatPermohonanModal').on('hidden.bs.modal', function () {
           // Reset any state or perform additional actions if needed
       });

       // Function to show amTabModal
       function showSpekTeknikalModal() {
           // Hide the maklumatPermohonanModal
           $('#maklumatPermohonanModal').modal('hide');
           $('#modalBuku1').modal('show');
           $('#modalBuku2').modal('show');
       }

       // Function to show maklumatPermohonanModal
       function showMaklumatPermohonanModal() {
           $('#modalBuku1').modal('hide');
       }

       // Function to show maklumatPermohonanModal
       function showMaklumatPermohonanModal() {
           $('#modalBuku2').modal('hide');
       }

       var no_mohon = "";

       var tbl = null;
       var isClicked1 = false;
       $(document).ready(function () {
           tbl = $("#tblKelulusan").DataTable({
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
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/LoadSenarai_Pengesyoran")%>',
                   type: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   "dataSrc": function (json) {
                       return JSON.parse(json.d);
                   },
                   "data": function () {
                       var startDate = $('#txtTarikhStart').val();
                       var endDate = $('#txtTarikhEnd').val();
                       return JSON.stringify({
                           category_filter: $('#categoryFilter').val(),
                           isClicked1: isClicked1,
                           tkhMula: startDate,
                           tkhTamat: endDate
                       })
                       console.log("Data sent to server:", data);
                       return JSON.stringify(data);
                   },
                   "error": function (xhr, error, thrown) {
                       console.log("Ajax error:", error);
                       //console.log("Details:", xhr.responseText); // Log the responseText for more details
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
                       console.log(data);
                       var rowData = data;
                       IDMesy = rowData.IDMesy;
                       txtNoLantikan = rowData.Kod_JK;
                       no_mohon = rowData.No_Mohon;

                       // Combine TarikhMasa and TarikhDaftar
                       var tarikhDaftar = new Date(rowData.TarikhDaftar);
                       var combinedDate = formatDate(tarikhDaftar) + ' ' + rowData.TarikhMasa;

                       // Update the modal content with the No_Mohon and Tujuan values
                       $("#lblStatus1").val(rowData.IDMesy); //BOLEH GUNA NO MOHON UNTUK KELUARKAN DATA
                       $("#lblStatus2").val(rowData.Tempat);
                       //$("#lblStatus3").val(rowData.TarikhMasa);
                       $("#lblStatus3").val(combinedDate);
                       //console.log("dd", IDMesy);
                       tbl2.ajax.reload();
                       tbl3.ajax.reload();
                       ShowPopup(1, data.IDMesy);

                       // Show the modal
                       // $('#ringkasanPoModal').modal('show');

                   });
               },
               "columns": [

                   {
                       "data": "Bil",
                       render: function (data, type, row, meta) {
                           return meta.row + meta.settings._iDisplayStart + 1;
                       },
                       "width": "2%"
                   },
                   {
                       "data": "IDMesy",
                       "width": "8%"
                   },
                   {
                       "data": "Butiran",
                       "width": "10%"
                   },
                   {
                       "data": "Tempat",
                       "width": "10%"
                   },
                   {
                       "data": null,
                       "width": "10%",
                       "render": function (data, type, row, meta) {
                           if (type === 'display') {
                               // Format TarikhMasa and TarikhDaftar
                               var formattedTarikhMasa = formatDateTime(row.TarikhMasa);
                               var formattedTarikhDaftar = formatDateString(row.TarikhDaftar);

                               // Log the value of TarikhMasa to the console
                               console.log("TarikhMasa:", row.TarikhDaftar);
                               console.log("TarikhMasa:", row.TarikhMasa);

                               // Combine the formatted values
                               var combinedValue = `${formattedTarikhDaftar} ${row.TarikhMasa}`;

                               data = combinedValue;
                           }
                           return data;
                       }
                   }
                   //{
                   //"data": null,
                   //"defaultContent": '<i onclick="ShowPopup(1)" class="fa fa-ellipsis-h fa-lg"></i>',
                   //"className": "text-center", // Center the icon within the cell
                   //"width": "5%"
                   //}
               ]
           });

           // Function to format date as dd/mm/yyyy
           function formatDate(date) {
               var dd = String(date.getDate()).padStart(2, '0');
               var mm = String(date.getMonth() + 1).padStart(2, '0'); // January is 0!
               var yyyy = date.getFullYear();
               return dd + '/' + mm + '/' + yyyy;
           }

           function formatDateTime(dateTimeString) {
               var time = new Date(dateTimeString);
               return ('0' + time.getHours()).slice(-2) + ':' + ('0' + time.getMinutes()).slice(-2) + ':' + ('0' + time.getSeconds()).slice(-2);
           }

           function formatDateString(dateString) {
               var date = new Date(dateString);
               return ('0' + date.getDate()).slice(-2) + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + date.getFullYear();
           }

           // Function to format date and time
           function formatDateTime(dateTimeString) {
               let date = new Date(dateTimeString);
               let hh = String(date.getHours()).padStart(2, '0');
               let min = String(date.getMinutes()).padStart(2, '0');
               let ss = String(date.getSeconds()).padStart(2, '0');
               return `${hh}:${min}:${ss}`;
           }

           // Function to format date string as dd-mm-yyyy
           function formatDateString(dateString) {
               let date = new Date(dateString);
               let dd = String(date.getDate()).padStart(2, '0');
               let mm = String(date.getMonth() + 1).padStart(2, '0');
               let yyyy = date.getFullYear();
               return `${dd}-${mm}-${yyyy}`;
           }

           $('.btnSearch').click(async function () {

               //load_loader();
               isClicked1 = true;
               tbl.ajax.reload();
               //    close_loader();
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


       /// --------------TABLE SENARAI SEBUT HARGA/TENDER-------------------- ///
       var tbl2 = null;
       var IDMesy = "";
       var txtNoLantikan = "";
       $(document).ready(function () {
           tbl2 = $("#tblSenaraiEP").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
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
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/LoadMesyPembuka") %>',
                   //"url": "PermohonanPoWS.asmx/LoadKelulusanPo",
                   type: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       //return JSON.stringify({ IDMesy: $('#lblStatus1').val() })
                       console.log("Sending AJAX request with IDMesy:", IDMesy);
                       return JSON.stringify({ IDMesy: IDMesy });

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
                       console.log(data);
                       var rowData = data;

                       noMohon = rowData.No_Mohon;
                       IDMesy = rowData.ID_Mesy;
                       noMohonValue = rowData.No_Mohon;
                       // Update the modal content with the No_Mohon and Tujuan values
                       $("#noMohonValue").val(rowData.No_Mohon);
                       $("#noPerolehan").val(rowData.No_Perolehan);
                       $("#KategoriValue").val(rowData.kategori_butiran);
                       $("#tujuanValue").val(rowData.Tujuan);
                       $("#justifikasiValue").val(rowData.Justifikasi);
                       $("#jumHargaValue").val(rowData.Total_Harga);
                       $("#txtKaedahPerolehan").val(rowData.Kaedah);
                       $("#txtNoSebutHarga").val(rowData.No_Sebut_Harga);
                       $("#txtNoJualan").val(rowData.Id_Jualan);
                       $("#txtStatus").val(rowData.Butiran);
                       $("#ddlPTJPemohon").val(rowData.Ptj_Mohon);
                       console.log("test3=", noMohon) //detect oleh console
                       console.log("IDMesy=", IDMesy)
                       console.log("test12=", noMohonValue)
                       //tbl4.ajax.reload();
                       tblSyor.ajax.reload();
                       tblDokumen.ajax.reload();
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
                       "data": "No_Perolehan",
                       "width": "5%"
                   },
                   {
                       "data": "No_Sebut_Harga",
                       "width": "5%"
                   },
                   {
                       "data": "Tujuan",
                       "width": "20%"
                   },
                   {
                       "data": "kategori_butiran",
                       "width": "5%"
                   },
                   {
                       "data": "Id_Jualan",
                       "width": "10%"
                   },
                   {
                       "data": "Tarikh_Masa_Mula_Iklan",
                       "width": "20%",
                       "render": function (data, type, row) {
                           if (type === 'display' || type === 'filter') {
                               return moment(data).format('DD-MM-YYYY HH:mm:ss');
                           }
                           return data;
                       }
                   },
                   {
                       "data": "Tarikh_Masa_Tamat_Perolehan",
                       "width": "20%",
                       "render": function (data, type, row) {
                           if (type === 'display' || type === 'filter') {
                               return moment(data).format('DD-MM-YYYY HH:mm:ss');
                           }
                           return data;
                       }
                   }
               ]
           });
       });

       //table Senarai kehadiran
       var tbl3 = null;
       $(document).ready(function () {
           tbl3 = $("#tblSenaraiHadir").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
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
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/LoadSenarai_PembukaJK") %>',
                   type: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   "data": function (d) {
                       console.log("Sending AJAX request with IDMesy Hadiran:", IDMesy);
                       console.log("Sending AJAX request with Kod_JK Hadiran:", txtNoLantikan);
                       //IDMesy: IDMesy // replace with actual value
                       //No_Lantik: No_Lantik // replace with actual value
                       return JSON.stringify({ IDMesy: IDMesy, txtNoLantikan: txtNoLantikan });
                       //return JSON.stringify({ IDMesy: IDMesy });
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
                   { "data": "Bilangan", "title": "Bil" }, // Empty column for index/bil
                   {
                       "data": null,
                       "width": "10%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'txtNoStaf' type="hidden" value='${data.No_Staf}' />${data.No_Staf}`;

                       },
                   },
                   {
                       "data": null,
                       "width": "25%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'txtNamaStaf' type="hidden" value='${data.Nama}'/>${data.Nama}`;

                       },
                   },

                   {
                       "data": null,
                       "width": "20%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'txtPTJStaf' type="hidden" value='${data.Pejabat}'/><input class = 'txtKodPTjStaf' type="hidden"  value='${data.KodPTj}'/>${data.Pejabat}`;
                       },
                   },

                   {
                       "data": null,
                       "width": "20%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'txtJawStaf' type="hidden" value='${data.Jawatan}'/>${data.Jawatan}`;
                       },
                   },
                   {
                       "data": null,
                       "width": "20%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'txtPeranan' type="hidden" value ='${data.Peranan}'/>${data.Peranan}`;
                       },
                   },
                   {
                       "data": null,
                       "width": "20%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'txtEmailStaf' type="hidden" value ='${data.Emel}'/>${data.Emel}`;
                       },
                   },
                   {
                       "data": null,
                       "render": function (data, type, row, meta) {
                           return `<input type = 'checkbox' title='Sila check jika hadir' class = 'chkpilihStafDetail'/> `;
                       },
                       "width": "5%"
                   },
               ],
               "columnDefs": [
                   {
                       "targets": 0,
                       "data": null,
                       "render": function (data, type, row, meta) {
                           // Render the index/bil as row number
                           return meta.row + 1;
                       }
                   },
               ]
           });
       });

       $('#btnSave').click(async function (evt) {
           evt.preventDefault();
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage2').text(msg);
           $('#senaraiHargaModal').modal('hide');
           $('#saveConfirmationModal2').modal('show');

           $('#confirmSaveButton2').off('click').on('click', async function () {
               $('#saveConfirmationModal2').modal('hide'); // Hide the modal

               // Assuming noMohonValue is defined elsewhere in your code
               var noMohonValue = $('#noMohonValue').val();
               console.log("noMohonValue:", noMohonValue);

               var newJawatanKuasaList = {
                   Perolehan_Mesyuarat_JKD: {
                       noMohonValue: noMohonValue,
                   }
               };

               try {
                   var result = JSON.parse(await beginSaveJawatanKuasaListDetail(newJawatanKuasaList));
                   console.log("result=", result);
                   if (result.Status === true) {
                       showModal2("Success", result.Message, "success");
                       tbl.ajax.reload();
                   } else {
                       showModal2("Error", result.Message, "error");
                   }
               } catch (error) {
                   console.error('Error:', error);
                   showModal2("Error", "An error occurred while saving data", "error");
               }
           });
       });

       async function beginSaveJawatanKuasaListDetail(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanFlag_Pengesyoran") %>',
                   method: 'POST',
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   dataType: 'json',
                   contentType: 'application/json; charset=utf-8',
                   success: function (data) {
                       resolve(data.d);
                       console.log("ajax here: ");
                   },
                   error: function (xhr, textStatus, errorThrown) {
                       console.error('Error:', errorThrown);
                       reject(false);
                   }
               });
           })
       }


       function showModal2(title, message, type) {
           $('#resultModalTitle2').text(title);
           $('#resultModalMessage2').text(message);
           if (type === "success") {
               $('#resultModal2').removeClass("modal-error").addClass("modal-success");
               tbl.ajax.reload();
           } else if (type === "error") {
               $('#resultModal2').removeClass("modal-success").addClass("modal-error");
           }
           $('#resultModal2').modal('show');
           tbl.ajax.reload();
       }

       /// ---------------------------table fail upload------------------------- ///
       var tblDokumen = null;
       $(document).ready(function () {
           tblDokumen = $("#tblDokumen").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
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
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/LoadAttachment_PenilaianHarga") %>',
                  type: 'POST',
                  "contentType": "application/json; charset=utf-8",
                  "dataType": "json",
                  //data: function (d) {
                  //    return JSON.stringify({
                  //        //id: $('#txtNoMohon').val()
                  //        id: $('#noMohonValue').val()
                  //    });
                  //    //});
                  //},
                  data: function (d) {
                      //return JSON.stringify({ IDMesy: $('#lblStatus1').val() })
                      console.log("Sending AJAX request with No mOhon:", noMohonValue);
                      return JSON.stringify({ noMohonValue: noMohonValue });

                  },
                  "dataSrc": function (json) {
                      var parsedData = JSON.parse(json.d);
                      /*  console.log("Parsed Data from Server:", parsedData);*/
                      return parsedData;
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
                               <div class="col-md-2">
                                  <button type="button" class="btn btnView" style="padding:0px 0px 0px 0px" title="Papar">
                                      <i class="fa fa-eye "></i>
                                   </button>
                               </div>
                          </div>`;
                      }
                  }
              ]

          });
      });

       $("#tblDokumen").off('click', '.btnView').on("click", ".btnView", function (event) {
           var data = tblDokumen.row($(this).parents('tr')).data();
           var fileName = data.Nama_Fail;
           var noMohonValue = $('#noMohonValue').val();

           // Call a function to open the PDF in a new tab
           openPDFInNewTab(fileName, noMohonValue);
       });

       function openPDFInNewTab(fileName, noMohonValue) {
           var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/PEROLEHAN/PENILAIAN_HARGA/") %>' + noMohonValue + '/' + fileName;
           window.open(pdfPath, '_blank');
       }

       //table Senarai Petender
       var tblSyor = null;
       var classSelectedSpekDetails = "";
       var prevRow = null;
       var childTable = null;
       var noMohonValue = "";
       var idPembelian = "";
       $(document).ready(function () {
           tblSyor = $("#tblSenaraiPetender").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
               "ordering": false,
               "info": false,
               stateSave: true,
               "ajax": {
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetPenilaian_Pengesyoran") %>',
                  "method": 'POST', // Moved method to a separate property
                  "contentType": "application/json; charset=utf-8",
                  "dataType": "json",
                  data: function (d) {
                      console.log("Sending AJAX request with No mOhon bbbb:", noMohonValue);
                      console.log("Sending AJAX request with No idPembelian bbbb:", idPembelian);
                      return JSON.stringify({ noMohonValue: noMohonValue, idPembelian: idPembelian });
                  },
                  "dataSrc": function (json) {
                      console.log("test spekfikasi");
                      //console.log("test spekfikasidd", json);
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
                      console.log(data);
                      var rowData = data;
                      noMohonValue = rowData.No_Mohon;
                      noSyarikat = rowData.ID_Syarikat;
                      //kodSyarikat = rowData.Kod_Syarikat;
                      kodSyarikat = rowData.No_Sykt;
                      IDPembelianDtl = rowData.ID_Pembelian;
                      idPembelian = rowData.ID_Pembelian;
                      $("#noMohonValue").val(rowData.No_Mohon);
                      tblbuku1.ajax.reload();
                      tblbuku2.ajax.reload();
                      tblLampiran.ajax.reload();
                      tblPengalaman.ajax.reload();
                      tblJadualHarga.ajax.reload();
                      tblSijilSyarikat.ajax.reload();
                      tblAuthorizeLetter.ajax.reload();
                      tblkerjaJadual.ajax.reload();
                      tblKatalog.ajax.reload();
                      tblSample.ajax.reload();
                      currentRow = row._DT_RowIndex;
                      console.log("currentRow main=", currentRow)
                      console.log("currentRow idPembelian=", idPembelian)
                      console.log("currentRow kodSyarikat=", kodSyarikat)
                      console.log("currentRow noMohonValue=", noMohonValue)
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
                      "width": "5%", "className": "text-center smaller-font",
                      "render": function (data, type, row, meta) {
                          // Render the index/bil as row number
                          return meta.row + 1;
                      },
                  },
                  {   //KOD PETENDER
                      "data": "Kod_Pembuka",
                      "width": "5%", "className": "text-center smaller-font",
                  },
                  {   //TEMPOH
                      "data": null,
                      "width": "10%", "className": "text-center smaller-font",
                      "render": function (data, type, row, meta) {
                          if (type !== "display") {
                              return data;
                          }
                          return `${row.Tempoh} ${row.Jenis_Tempoh}`;
                      },
                  },
                  {   //HARGA TAWARAN
                      "data": "Total_Jumlah_Harga",
                      "width": "10%",
                      "className": "text-right smaller-font"
                  },
                  {   //PERBEZAAN HARGA TAWARAN
                      "data": "Harga_Tolak",
                      "width": "10%",
                      "className": "text-right smaller-font"
                  },
                  {   //PERATUSAN PERBEZAAN
                      "data": "Harga_Percent",
                      "width": "10%",
                      "className": "text-center smaller-font",
                      "render": function (data, type, row) {
                          if (data !== null) {
                              if (type === "display") {
                                  return data + ' %';
                              }
                              return data;
                          } else {
                              return '0.00%';
                          }
                      }
                  },
                  {   //SYOR PHARGA TICK
                      "data": "Syor_Nilai_Harga",
                      "width": "5%",
                      "className": "text-center smaller-font",
                      "render": function (data, type, row, meta) {
                          if (type !== "display") {
                              return data;
                          }
                          let checked = (row.Syor_Nilai_Harga === '1') ? 'checked' : '';
                          let disabled = (row.Syor_Nilai_Harga === '1') ? 'disabled' : '';
                          return `<input type = 'checkbox' class = 'chksyorHarga' ${checked} ${disabled}/> `;
                      },
                  },
                  {   //SYOR P ULASAN HARGA
                      "data": "Ulasan_Harga",
                      "width": "10%",
                      "className": "text-center smaller-font",
                  },
                  {   //SYOR PTEKNIKAL TICK
                      "data": "Syor_Teknikal",
                      "width": "5%",
                      "className": "text-center smaller-font",
                      "render": function (data, type, row, meta) {
                          if (type !== "display") {
                              return data;
                          }
                          let checked = (row.Syor_Teknikal === '1') ? 'checked' : '';
                          let disabled = (row.Syor_Teknikal === '1') ? 'disabled' : '';
                          return `<input type = 'checkbox' class = 'chksyorTekniknal' ${checked} ${disabled}/> `;
                      },
                  },
                  {   //SYOR P ULASAN TEKNIKAL
                      "data": "Ulasan_Teknikal",
                      "width": "10%",
                      "className": "text-center smaller-font",
                  },
                  {   //PERATUS AM
                      "data": "Peratus_Am",
                      //"data": 0,
                      "width": "5%", "className": "text-center smaller-font",
                      "render": function (data, type, row, meta) {
                          if (data !== undefined && data !== null) {
                              return data + '%';
                          } else {
                              return '0.00%';
                          }
                      },
                  },
                  {   //PERATUS TEKNIKAL
                      //"PERATUS TEK": 0,
                      "data": "Peratus_Teknikal",
                      "width": "5%",
                      "className": "text-center smaller-font",
                      "render": function (data, type, row, meta) {
                          console.log("Current data:", data);
                          if (data !== undefined && data !== null) {
                              return data + '%';
                          } else {
                              return '0.00%';
                          }
                      },
                  },
                  {   //SYOR TICK
                      "data": null,
                      "width": "5%", "className": "text-center smaller-font",
                      "render": function (data, type, row, meta) {
                          if (type !== "display") {
                              return data;
                          }
                          return `<input type = 'checkbox' class = 'chkpilihSyor'/> `;
                      },
                  },
                  {   //ULASAN SYOR
                      "data": null,
                      "width": "10%", "className": "text-center smaller-font",
                      "render": function (data, type, row, meta) {
                          if (data !== null && data.Ulasan_Syor !== null) {
                              return `<textarea rows="3" cols="30" class="txtUlasanSyor" id="txtUlasanSyor" name="txtUlasanSyor">${data.Ulasan_Syor}</textarea><input class = 'kodPembuka' id='kodPembuka' type="hidden" value='${data.Kod_Pembuka}'/><input class = 'kodSyarikat' id='kodSyarikat' type="hidden" value='${data.Kod_Syarikat}'/><input class = 'noMohonValue' id='noMohonValue' type="hidden" value='${data.No_Mohon}'/><input class = 'idPembelian' id='idPembelian' type="hidden" value='${data.ID_Pembelian}'/>`;
                          } else {
                              return `<textarea rows="3" cols="30" class="txtUlasanSyor" id="txtUlasanSyor" name="txtUlasanSyor"></textarea><input class = 'kodPembuka' id='kodPembuka' type="hidden" value='${data.Kod_Pembuka}'/><input class = 'kodSyarikat' id='kodSyarikat' type="hidden" value='${data.Kod_Syarikat}'/><input class = 'noMohonValue' id='noMohonValue' type="hidden" value='${data.No_Mohon}'/><input class = 'idPembelian' id='idPembelian' type="hidden" value='${data.ID_Pembelian}'/>`;
                          }
                      }
                  },
                  { // BUKU 1
                      "data": "Semak_Buku1",
                      "width": "5%", "className": "text-center smaller-font",
                      "title": "Semakan Buku 1",
                      "render": function (data, type, row, meta) {
                          if (data === '1') {
                              return '<i class="fas fa-check-circle circle-icon" style="font-size: 30px; color:green;"></i>';
                          } else {
                              return '<i class="far fa-times-circle" style="font-size: 30px; color:red;"></i>';
                          }
                      },
                      "width": "5%"
                  },
                  {   // BUKU 2
                      "data": "Semak_Buku2",
                      "width": "5%", "className": "text-center smaller-font",
                      "title": "Semakan Buku 2",
                      "render": function (data, type, row, meta) {
                          if (data === '1') {
                              return '<i class="fas fa-check-circle circle-icon" style="font-size: 30px; color:green;"></i>';
                          } else {
                              return '<i class="far fa-times-circle" style="font-size: 30px; color:red;"></i>';
                          }
                      },
                      "width": "5%"
                  },
                  //{   //SYOR BID
                  //    "data": null,
                  //    "width": "5%", "className": "text-center smaller-font",
                  //    "render": function (data, type, row, meta) {
                  //        //if (type !== "display") {
                  //        //    return data;
                  //        //}
                  //        return `<input type = 'checkbox' class = 'chkpilihBid'/> `;
                  //    },
                  //},
              ],
          });

          $('#tblSenaraiPetender tbody').on('click', 'td:nth-child(16)', function () {
              var rowData = tblSyor.row($(this).closest('tr')).data(); // Get data of the clicked row
              ShowPopup(4); // Call ShowPopup function with parameter 4
          });

          $('#tblSenaraiPetender tbody').on('click', 'td:nth-child(17)', function () {
              var rowData = tblSyor.row($(this).closest('tr')).data(); // Get data of the clicked row
              ShowPopup(5); // Call ShowPopup function with parameter 4
          });

      });

       $('#tblSenaraiPetender').on('click', '.btnDetails', function (evt) {

           evt.preventDefault();
           classSelectedSpekDetails = $(this).attr("class")
           var tr = $(this).closest('tr');
           var row = tblSyor.row(tr);
           var rowData = row.data();

           //var pickedKodvot = rowData.Kod_Negara_Pembuat;
           var pickedIdPembelian = rowData.ID_Pembelian;
           var pickednoMohonValue = rowData.No_Mohon;
           var pickedIdSyarikat = rowData.ID_Syarikat;
           console.log("pickedIdPembelian=", pickedIdPembelian)
           if (row.child.isShown()) {
               // This row is already open - close it
               row.child.hide();
               tr.removeClass('shown');
               $(this).html('<i class="fas fa-plus"></i>');
               // Destroy the Child Datatable
               childTable = null;
               $('#childtbl' + pickednoMohonValue).DataTable().destroy();
               //$('#childtbl').DataTable().destroy();
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
               prevId = '#childtbl' + pickednoMohonValue;
               //prevId = '#childtbl';
               prevRow = row;

               $(this).html('<i class="fas fa-minus"></i>');

               //row.child(format()).show();
               row.child(format(pickednoMohonValue)).show();
               //var id = rowData.kod;

               childTable = $('#childtbl' + pickednoMohonValue).DataTable({
                   //childTable = $('#childtbl').DataTable({
                   dom: "t",
                   paging: false,
                   ajax: {
                     <%--//url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadOrderRecord_PNLDetail") %>',--%>
                      url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetSpeksifikasiDetail") %>',
                      type: 'POST',
                      data: function (d) {
                          console.log("Making AJAX request with No on child:", pickedIdPembelian);
                          console.log("Making AJAX request with No on IDPembelianDtl:", pickedIdPembelian);
                          console.log("Making AJAX request with No on pickedIdSyarikat:", pickedIdSyarikat);
                          return JSON.stringify({ IDPembelianDtl: pickedIdPembelian, IDSyarikat: pickedIdSyarikat, noMohonValue: pickednoMohonValue });
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
                              // Render the index/bil as row number
                              return meta.row + 1;
                          },
                      },
                      {   //butiran
                          "data": "Butiran",
                          "width": "5%", "className": "text-center",
                      },

                      {    //jenama
                          "data": "Jenama",
                          "width": "5%", "className": "text-center",
                      },

                      {    //model
                          "data": "Model",
                          "width": "5%", "className": "text-center",
                      },

                      {    //negara pembuat
                          "data": "ButiranNegara",
                          "width": "5%", "className": "text-center",
                      },

                      {   //kuantiti
                          //"data": null,
                          "data": "Kuantiti",
                          "width": "5%", "className": "text-center",

                      },

                      {    //ukuran
                          "data": "Ukuran",
                          "width": "5%", "className": "text-center",
                      },


                      {   //harga seunit w/ cukai
                          "data": "Harga_Seunit",
                          "width": "5%", "className": "text-right"
                      },


                      {   //harga seunit w/o cukai
                          "data": "Harga_Seunit",
                          "width": "5%", "className": "text-right"
                      },

                      {   //harga seunit w/o cukai
                          "data": "Harga_Seunit",
                          "width": "5%", "className": "text-right"
                      },

                  ],
                  columnDefs: [
                      {
                          "targets": 0,
                          visible: false,
                          searchable: false
                      },
                  ],

              });

              tr.addClass('shown');

          }

          return false;

      });


       function format(id) {
           childTable = '<table id="childtbl' + id + '" class="compact w-100" width="100%">' +
               '<thead style="color: black">' +
               '<tr>' +
               '<td></td>' + // Empty cell to align with the "Bil" column
               '<td>Bil</td>' +
               '<td>Barang/Perkara</td>' +
               '<td>Jenama</td>' +
               '<td>Model</td>' +
               '<td>Negara Pembuat</td>' +
               '<td>Kuantiti</td>' +
               '<td>Ukuran</td>' +
               '<td>Jenis Harga</td>' +
               '<td>Harga Seunit (RM)</td>' +
               '<td>Harga Harga (RM)</td>' +
               '</tr>' +
               '</thead>' +
               '</table>';
           return $(childTable).toArray();
       }

       $('#btnSimpanSyor').click(async function (evt) {
           evt.preventDefault();

           $('#maklumatPermohonanModal').modal('hide');
           $('#saveConfirmationModal10').modal('show');

           // var msg = "";
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage10').text(msg);

           //var checkedCount = $('.chkpilihSpekDetail:checked').length;
           var noMohonValueValue = $('.noMohonValue').val();

           // Retrieve the selected radio button value
           var bidSelection = $('input[name="inlineRadioOptions"]:checked').val();
           //if (checkedCount < 2) {
           //    alert("Sila tick syor lebih dari 2");
           //    return;
           //}

           $('#confirmSaveButton10').off('click').on('click', async function () {
               $('#saveConfirmationModal10').modal('hide');

           var param = {
               spekList: []
           };

           $('.chkpilihSyor').each(async function (ind, obj) {
               var chkSyorValue = obj.checked ? '1' : '0'; // Check if obj is checked

               // Retrieve other values
               var kodPembukaValue = $('.kodPembuka').eq(ind).val();
               var ulasanSyorValue = $('.txtUlasanSyor').eq(ind).val();
               var idPembelianValue = $('.idPembelian').eq(ind).val();

               //// Check the state of the additional checkbox
               //var chkpilihBidValue = $('.chkpilihBid').eq(ind).prop('checked') ? '0' : '1';

               console.log("kodPembukaValue=,", kodPembukaValue);
               console.log("ulasanSyorValue=,", ulasanSyorValue);
               console.log("idPembelianValue=,", idPembelianValue);

               var newSyorList = {
                   Perolehan_Syor: {
                       txtUlasanSyor: ulasanSyorValue,
                       noMohonValue: noMohonValueValue,
                       idPembelian: idPembelianValue,
                       kodPembuka: kodPembukaValue,
                       chkSyor: chkSyorValue, // Include Keputusan_Syor in the object
                       //chkBid: chkpilihBidValue // Include chkpilihBid in the object
                       chkBid: bidSelection // Include chkpilihBid in the object
                   }
               };

               try {
                   var result = JSON.parse(await beginSaveSyor(newSyorList));
                   if (result.Status === true) {
                       showModal10("Success", result.Message, "success");
                       $('#senaraiHargaModal').modal('show');

                   } else {
                       showModal10("Error", result.Message, "error");
                   }
               } catch (error) {
                   console.error('Error:', error);
                   showModal1("Error", "An error occurred during the request.", "error");
               }

               //var result = JSON.parse(await beginSaveSyor(newSyorList));
               //console.log("result=,", result)
               //console.log("result111=,", newSyorList)
               //if (result.Status === true) {
               //    showModalDelete4("Success", result.Message, "success");
               //} else {
               //    showModalDelete4("Error", result.Message, "error");
               //}
           });
         });


       })

       async function beginSaveSyor(Perolehan_Syor) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanSyorDetail") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Syor),
                   success: function (data) {
                       resolve(data.d); // Don't need to parse here
                       console.log("ajax read here ...")
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       console.log("AJAX GAGAGL ...");
                       reject(false);
                   }
               });
           })
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

       //---------------------------------buku 1 & buku 2 start
       //semak buku 1 start
       var tblbuku1 = null;
       $(document).ready(function () {
           /* show_loader();*/
           tblbuku1 = $("#tblbuku1").DataTable({
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
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetRecord_Buku1") %>',
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        //return JSON.stringify({ IDMesy: $('#lblStatus1').val() })
                        console.log("Sending AJAX request with IdPembelian:", idPembelian);
                        return JSON.stringify({ idPembelian: idPembelian });

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
                        //console.log("Row clicked. Data:", data);
                        var rowData = data;
                        idPembelian = rowData.Id_Pembelian;
                        console.log("test IdPembelian=", idPembelian);
                        //openPopupForm2(data);
                    });
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
                    { "data": "Butiran_Dokumen" },
                    {
                        "data": "Status_Pembuka", "className": "text-center",
                        "render": function (data, type, row, meta) {
                            if (data === '1') {
                                return '<i class="fas fa-check-circle circle-icon changeable-icon" style="font-size: 30px; color:green;"></i>';
                            } else {
                                return '<i class="far fa-times-circle" style="font-size: 30px; color:red;"></i>';
                            }
                        }
                    },
                ]
            });

            $('#tblbuku1 tbody').on('click', 'tr', function () {
                var data = tblbuku1.row(this).data();
                openPopupForm(data);
            });
        });
       //semak buku 1 end

       //semak buku 2 start
       var tblbuku2 = null;
       $(document).ready(function () {
           /* show_loader();*/
           tblbuku2 = $("#tblbuku2").DataTable({
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
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetRecord_Buku2") %>',
                   "method": 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       //return JSON.stringify({ IDMesy: $('#lblStatus1').val() })
                       console.log("Sending AJAX request with IdPembelian:", idPembelian);
                       return JSON.stringify({ idPembelian: idPembelian });

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
                       //console.log("Row clicked. Data:", data);
                       var rowData = data;
                       idPembelian = rowData.Id_Pembelian;
                       noMohonValue = rowData.No_Mohon;
                       console.log("test IdPembelian=", idPembelian);
                       console.log("test noMohonValue=", noMohonValue);
                       tblJawapanTeknikal.ajax.reload();
                       tblJawapanAm.ajax.reload();
                       //openPopupForm2(data);
                   });
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
                   { "data": "Butiran_Dokumen" },
                   {
                       "data": "Status_Pembuka", "className": "text-center",
                       "render": function (data, type, row, meta) {
                           if (data === '1') {
                               return '<i class="fas fa-check-circle circle-icon changeable-icon" style="font-size: 30px; color:green;"></i>';
                           } else {
                               return '<i class="far fa-times-circle" style="font-size: 30px; color:red;"></i>';
                           }
                       }
                   },
               ]
           });

           $('#tblbuku2 tbody').on('click', 'tr', function () {
               var data = tblbuku2.row(this).data();
               openPopupForm2(data);
           });
       });

       //semak buku 2 end

       ////////////////////////// OPEN FORM  //////////////////////////////////////
       //Open modal buku 1
       function openPopupForm(data) {

           if (data.Kod_Dokumen == 01) {
               $('#profilSyaModal').modal('toggle');
           }

           if (data.Kod_Dokumen == 02) {
               $('#syaratAmModal').modal('toggle');
           }

           if (data.Kod_Dokumen == 03) {
               $('#jadualHargaModal').modal('toggle');
           }

           if (data.Kod_Dokumen == 04) {
               $('#jaminanModal').modal('toggle');
           }

           if (data.Kod_Dokumen == 05) {
               $('#suratPembidaModal').modal('toggle');
           }

           if (data.Kod_Dokumen == 06) {
               $('#BorangPengalaman').modal('toggle');
           }

           if (data.Kod_Dokumen == 07) {
               $('#borangMultimodal').modal('toggle');
           }

           if (data.Kod_Dokumen == 08) {
               $('#sijilTerkini').modal('toggle');
           }
       }

       //Open modal Buku 2
       function openPopupForm2(data) {
           console.log("Data received:", data); // Check data received

           // Check comparison and toggle corresponding modal
           if (data.Kod_Dokumen == 09) {
               $('#jadualKerja').modal('show');
           }

           if (data.Kod_Dokumen == 10) {
               $('#authLetter').modal('show');
           }

           if (data.Kod_Dokumen == 11) {
               $('#katalog').modal('show');
           }

           if (data.Kod_Dokumen == 12) {
               $('#sample').modal('show');
           }

           if (data.Kod_Dokumen == 13) {
               $('#borangTeknikal').modal('show');
           }
       }

       var noSyarikat = '';
       var kodSyarikat = '';
       var SyarikatKod = '';
       var tblLampiran = null;
       $(document).ready(function () {
           tblLampiran = $("#profilsyarikat").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
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
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Display_ProfilSyarikat") %>',
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        console.log("Sending AJAX request with noMohonValue on PS:", noMohonValue);
                        console.log("Sending AJAX request with noSyarikat on PS:", noSyarikat);
                        console.log("Sending AJAX request with kodSyarikat on PS:", kodSyarikat);
                        /* return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), noSyarikat: $('#noSyarikat').val(), kodSyarikat: $('#kodSyarikat').val() });*/
                        return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), noSyarikat: noSyarikat, kodSyarikat: kodSyarikat });
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
                    { "data": "ID_Dok" }, //Hidden
                    { "data": "Nama_Dok" }, //Hidden
                    { "data": "Bil" }, // Empty column for index/bil
                    {
                        "data": null,
                        "width": "10%",
                        "render": function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }
                            return `<input class = 'noSyarikat' type="hidden" value='${data.ID_Sykt}' />${data.Nama_Dok}`;

                        },
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
                            <div class="row justify-content-center">
                                <div class="col-md-1">
                                    <button type="button" class="btn viewProfilSyarikat" style="padding:0px 0px 0px 0px" title="Papar">
                                       <i class="fa fa-eye "></i>
                                    </button>
                                </div>
                            </div>`;
                        }
                    }
                ]
            });

        });

       $("#profilsyarikat").off('click', '.viewProfilSyarikat').on("click", ".viewProfilSyarikat", function (event) {
           var data = tblLampiran.row($(this).parents('tr')).data();
           var fileName = data.Nama_Dok;
           var noSyarikat = $("#noSyarikat").val();

           // Call a function to open the PDF in a new tab
           openPDFInNewTabProfilSyarikat(fileName, noSyarikat);
       });

       function openPDFInNewTabProfilSyarikat(fileName, noSyarikat) {
           var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/MS/") %>' + noSyarikat + '/' + fileName;
           window.open(pdfPath, '_blank');
       }

       var tblPengalaman = null;
       $(document).ready(function () {
           tblPengalaman = $("#pengalamanSyarikat").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
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
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Display_PengalamanSyarikat") %>',
                   type: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       console.log("Sending AJAX request with noMohonValue on PGS:", noMohonValue);
                       console.log("Sending AJAX request with noSyarikat on PGS:", noSyarikat);
                       console.log("Sending AJAX request with idPembelian on PGS:", idPembelian);
                       console.log("Sending AJAX request with SyarikatKod on PGS:", SyarikatKod);
                       console.log("Sending AJAX request with kodSyarikat on PGS:", kodSyarikat);
                       //return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), noSyarikat: noSyarikat, kodSyarikat: kodSyarikat, idPembelian: idPembelian, syarikatCode: SyarikatKod });
                       return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), noSyarikat: noSyarikat, kodSyarikat: kodSyarikat, idPembelian: idPembelian, kodSyarikat: kodSyarikat });
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
                   { "data": "Tajuk_Projek" },
                   { "data": "Jabatan" },
                   {
                       "data": "Tkh_Mula",
                       "render": function (data, type, row) {
                           if (type === 'display' || type === 'filter') {
                               return moment(data).format('DD/MM/YYYY');
                           }
                           return data;
                       }
                   },
                   {
                       "data": "Tkh_Tamat",
                       "render": function (data, type, row) {
                           if (type === 'display' || type === 'filter') {
                               return moment(data).format('DD/MM/YYYY');
                           }
                           return data;
                       }
                   },
                   {
                       "data": "Nilai_Jualan", "className": "text-right",
                       "render": function (data, type, row) {
                           // Format the data as decimal and return
                           return parseFloat(data).toFixed(2); // Assuming data is a decimal value
                       }
                   },
                   /*{ "data": null, "title": "Tindakan" }*/
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

       //-------------------------TABLE JADUAL HARGA -------------------------------------------------

       var tblJadualHarga = null;
       $(document).ready(function () {
           tblJadualHarga = $("#jadualHarga").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
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
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Display_JadualHarga") %>',
                   type: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       console.log("Sending AJAX request with noMohonValue on PGS:", noMohonValue);
                       console.log("Sending AJAX request with noSyarikat on PGS:", noSyarikat);
                       console.log("Sending AJAX request with idPembelian on PGS:", idPembelian);
                       return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), noSyarikat: noSyarikat, kodSyarikat: kodSyarikat, idPembelian: idPembelian });
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
                   { "data": "Butiran" },
                   { "data": "Jenama" },
                   { "data": "Model" },
                   { "data": "ButiranNegara" },
                   { "data": "Kuantiti" },
                   { "data": "Ukuran" }, //Pembungkusan
                   { "data": "Harga_Seunit" },
                   { "data": "Harga_Seunit" },
                   { "data": "Jumlah_Harga" },
                   { "data": "Jumlah_Harga" },

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

       //-----------------------TABLE SIJIL SYARIKAT--------------------------------------------------
       var tblSijilSyarikat = null;
       $(document).ready(function () {

           tblSijilSyarikat = $("#sijilSyarikat").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
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
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Display_SijilSalinan") %>',
                   type: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       //console.log("Sending AJAX request with noMohonValue on SS:", noMohonValue);
                       console.log("Sending AJAX request with noSyarikat on SS:", noSyarikat);
                       console.log("Sending AJAX request with idPembelian on SS:", idPembelian);
                       console.log("Sending AJAX request with kodSyarikat on ss:", kodSyarikat);
                       return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), noSyarikat: noSyarikat, kodSyarikat: kodSyarikat, idPembelian: idPembelian });
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
                   {
                       "data": null,
                       "width": "10%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'idPembelian' type="hidden" value='${data.Id_Pembelian}' />${data.Id_Pembelian}`;

                       },
                   }, //Hidden
                   { "data": "Nama_Dok" }, //Hidden
                   { "data": "Bil" }, // Empty column for index/bil
                   { "data": "Nama_Dok" },
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
                            <div class="row justify-content-center">
                                <div class="col-md-1">
                                    <button type="button" class="btn viewSijilSyarikat" style="padding:0px 0px 0px 0px" title="Papar">
                                       <i class="fa fa-eye "></i>
                                    </button>
                                </div>
                            </div>`;
                       }
                   }
               ]
           });

       });

       $("#sijilSyarikat").off('click', '.viewSijilSyarikat').on("click", ".viewSijilSyarikat", function (event) {
           var data = tblSijilSyarikat.row($(this).parents('tr')).data();
           var fileName = data.Nama_Dok;
           var idPembelian = $("#idPembelian").val();

           // Call a function to open the PDF in a new tab
           openPDFInNewTabSijilSyarikat(fileName, idPembelian);
       });

       function openPDFInNewTabSijilSyarikat(fileName, idPembelian) {
           var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/BANK/") %>' + idPembelian + '/' + fileName;
           window.open(pdfPath, '_blank');
       }

       //-----------------------TABLE PENYATA BANK 3 BULAN--------------------------------------------------
       var tblkerjaJadual = null;
       $(document).ready(function () {
           tblkerjaJadual = $("#kerjaJadual").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
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
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Display_JadualKerja") %>',
                   type: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       console.log("Sending AJAX request with noSyarikat on JK:", noSyarikat);
                       console.log("Sending AJAX request with idPembelian on JK:", idPembelian);
                       console.log("Sending AJAX request with kodSyarikat on JK:", kodSyarikat);
                       return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), noSyarikat: noSyarikat, kodSyarikat: kodSyarikat, idPembelian: idPembelian });
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
                   {
                       "data": null,
                       "width": "10%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'idPembelian' type="hidden" value='${data.Id_Pembelian}' />${data.Id_Pembelian}`;

                       },
                   }, //Hidden
                   { "data": "Nama_Dok" }, //Hidden
                   { "data": "Bil" }, // Empty column for index/bil
                   { "data": "Nama_Dok" },
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
                   { "data": "Nama_Fail" },
                   {
                       "targets": 4, // Target the last column (Delete column)
                       "data": null,
                       "render": function (data, type, row) {
                           return `
                            <div class="row justify-content-center">
                                <div class="col-md-1">
                                    <button type="button" class="btn viewJadualKerja" style="padding:0px 0px 0px 0px" title="Papar">
                                       <i class="fa fa-eye "></i>
                                    </button>
                                </div>
                            </div>`;
                       }
                   }
               ]
           });

       });

       $("#kerjaJadual").off('click', '.viewJadualKerja').on("click", ".viewJadualKerja", function (event) {
           var data = tblkerjaJadual.row($(this).parents('tr')).data();
           var fileName = data.Nama_Dok;
           var idPembelian = $("#idPembelian").val();

           // Call a function to open the PDF in a new tab
           openPDFInNewTabJadualKerja(fileName, idPembelian);
       });

       function openPDFInNewTabJadualKerja(fileName, idPembelian) {
           var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/JK/") %>' + idPembelian + '/' + fileName;
           window.open(pdfPath, '_blank');
       }

       //-----------------------TABLE AUTHORIZATION LETTER --------------------------------------------------
       var tblAuthorizeLetter = null;
       $(document).ready(function () {

           tblAuthorizeLetter = $("#authorizeLetter").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
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
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Display_LetterAuth") %>',
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        //console.log("Sending AJAX request with noMohonValue on SS:", noMohonValue);
                        console.log("Sending AJAX request with noSyarikat on auth:", noSyarikat);
                        console.log("Sending AJAX request with kodSyarikat on auth:", kodSyarikat);
                        console.log("Sending AJAX request with idPembelian on auth:", idPembelian);
                        return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), noSyarikat: noSyarikat, kodSyarikat: kodSyarikat, idPembelian: idPembelian });
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
                   {
                       "data": null,
                       "width": "10%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'idPembelian' type="hidden" value='${data.Id_Pembelian}' />${data.Id_Pembelian}`;

                       },
                   }, //Hidden
                   { "data": "ID_Sykt" }, //Hidden
                   { "data": "Bil" }, // Empty column for index/bil
                   { "data": "Nama_Dok" },
                   //{ "data": null, "title": "Tindakan" }
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
                   { "data": "Nama_Dok" },
                   {
                       "targets": 4, // Target the last column (Delete column)
                       "data": null,
                       "render": function (data, type, row) {
                           return `
                            <div class="row justify-content-center">
                                <div class="col-md-1">
                                    <button type="button" class="btn viewAuthLetter" style="padding:0px 0px 0px 0px" title="Papar">
                                       <i class="fa fa-eye "></i>
                                    </button>
                                </div>
                            </div>`;
                       }
                   }
               ]
            });

       });

       $("#authorizeLetter").off('click', '.viewAuthLetter').on("click", ".viewAuthLetter", function (event) {
           var data = tblAuthorizeLetter.row($(this).parents('tr')).data();
           var fileName = data.Nama_Dok;
           var idPembelian = $("#idPembelian").val();

           // Call a function to open the PDF in a new tab
           openPDFInNewTabAuthLetter(fileName, idPembelian);
       });

       function openPDFInNewTabAuthLetter(fileName, idPembelian) {
           var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/AL/") %>' + idPembelian + '/' + fileName;
           window.open(pdfPath, '_blank');
       }

       //-----------------------TABLE KATALOG--------------------------------------------------
       var tblKatalog = null;
       $(document).ready(function () {
           tblKatalog = $("#tblKatalog").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
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
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Display_Katalog") %>',
                   type: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       console.log("Sending AJAX request with noSyarikat on katalog:", noSyarikat);
                       console.log("Sending AJAX request with kodSyarikat on katalog:", kodSyarikat);
                       console.log("Sending AJAX request with idPembelian on katalog:", idPembelian);
                       return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), noSyarikat: noSyarikat, kodSyarikat: kodSyarikat, idPembelian: idPembelian });
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
                   {
                       "data": null,
                       "width": "10%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'idPembelian' type="hidden" value='${data.Id_Pembelian}' />${data.Id_Pembelian}`;

                       },
                   }, //Hidden
                   { "data": "Nama_Dok" }, //Hidden
                   { "data": "Bil" }, // Empty column for index/bil
                   { "data": "Nama_Dok" },
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
                   { "data": "Nama_Dok" },
                   {
                       "targets": 4, // Target the last column (Delete column)
                       "data": null,
                       "render": function (data, type, row) {
                           return `
                            <div class="row justify-content-center">
                                <div class="col-md-1">
                                    <button type="button" class="btn viewKatalog" style="padding:0px 0px 0px 0px" title="Papar">
                                       <i class="fa fa-eye "></i>
                                    </button>
                                </div>
                            </div>`;
                       }
                   }
               ]
           });

       });

       $("#tblKatalog").off('click', '.viewKatalog').on("click", ".viewKatalog", function (event) {
           var data = tblKatalog.row($(this).parents('tr')).data();
           var fileName = data.Nama_Dok;
           var idPembelian = $("#idPembelian").val();

           // Call a function to open the PDF in a new tab
           openPDFInNewTabKatalog(fileName, idPembelian);
       });

       function openPDFInNewTabKatalog(fileName, idPembelian) {
           var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/KATALOG/") %>' + idPembelian + '/' + fileName;
           window.open(pdfPath, '_blank');
       }

       //-----------------------TABLE SAMPLE--------------------------------------------------
       var tblSample = null;
       $(document).ready(function () {
           tblSample = $("#tblSample").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
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
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Display_Sample") %>',
                   type: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       console.log("Sending AJAX request with noSyarikat on sample:", noSyarikat);
                       console.log("Sending AJAX request with kodSyarikat on sample:", kodSyarikat);
                       console.log("Sending AJAX request with idPembelian on sample:", idPembelian);
                       return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), noSyarikat: noSyarikat, kodSyarikat: kodSyarikat, idPembelian: idPembelian });
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
                   {
                       "data": null,
                       "width": "10%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'idPembelian' type="hidden" value='${data.Id_Pembelian}' />${data.Id_Pembelian}`;

                       },
                   }, //Hidden
                   { "data": "Nama_Dok" }, //Hidden
                   { "data": "Bil" }, // Empty column for index/bil
                   { "data": "Nama_Dok" },
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
                   // { "data": "Nama_Dok" },
                   { "data": "Nama_Dok" },
                   {
                       "targets": 4, // Target the last column (Delete column)
                       "data": null,
                       "render": function (data, type, row) {
                           return `
                            <div class="row justify-content-center">
                                <div class="col-md-1">
                                    <button type="button" class="btn viewSample" style="padding:0px 0px 0px 0px" title="Papar">
                                       <i class="fa fa-eye "></i>
                                    </button>
                                </div>
                            </div>`;
                       }
                   }
               ]
           });

       });

       $("#tblSample").off('click', '.viewSample').on("click", ".viewSample", function (event) {
           var data = tblSample.row($(this).parents('tr')).data();
           var fileName = data.Nama_Dok;
           var idPembelian = $("#idPembelian").val();

           // Call a function to open the PDF in a new tab
           openPDFInNewTabSample(fileName, idPembelian);
       });

       function openPDFInNewTabSample(fileName, idPembelian) {
           var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/SAMPLE/") %>' + idPembelian + '/' + fileName;
           window.open(pdfPath, '_blank');
       }

       //---------------------------------buku 1 & buku 2 end

       //--------------------------- MODAL SPEK AM DAN TEKNIKAL -------------------------

       var tblJawapanTeknikal = null;
       var childTableTek = null;
       var isClicked = false;
       var childTableTek = null;
       var idTeknikal = "";
       var idPembelian = "";
       var idMohonDtl = "";

       $(document).ready(function () {
           tblJawapanTeknikal = $("#spekfikasi-tek-table").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
               "ordering": false,
               "info": false,
               stateSave: true,
               "ajax": {
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetTeknikal_Buku2") %>',
                   "method": 'POST', // Moved method to a separate property
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       console.log("Sending AJAX request kodSyarikat idPembelian VV77:", noMohonValue);
                       return JSON.stringify({ noMohonValue: $('#noMohonValue').val() });
                   },
                   "dataSrc": function (json) {
                       /* console.log("test spekfikasi tek");*/
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
                       console.log(data);
                       var rowData = data;
                       noMohonValue = rowData.No_Mohon;
                       idMohonDtl = rowData.Id_Mohon_Dtl;
                       console.log("noMohonValue -->", noMohonValue);
                       console.log("idMohonDtl -->", idMohonDtl);
                       /* currentRowtxt = Id_Teknikal;*/
                       currentRow = row._DT_RowIndex;
                       /*console.log("currentRow currentRowcurrentRow=", currentRowtxt)*/
                       console.log("currentRow currentRowcurrentRow=", currentRow)
                       childTableTek.ajax.reload();
                   });
               },
               "columns": [
                   {
                       "data": null,
                       "width": "5%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<button class="btnDetailsTek btndt${data.kod}" data-level="2" data-kod = "' + data + '"><i class="fas fa-plus"></i></button>`;

                       },

                   },
                   {   // barang @ perkara
                       "data": "Butiran",
                       "width": "25%", "className": "text-center",
                   },
                   {   // jenama
                       "data": "Jenama",
                       "width": "25%", "className": "text-center",
                   },
                   {   // model
                       "data": "Model",
                       "width": "25%", "className": "text-center",
                   },
                   {   // negara pembuat
                       "data": "ButiranNegara",
                       "width": "25%", "className": "text-center",
                   },
               ]
           });

       });

       //detail Speksifikasi teknikal
       $('#spekfikasi-tek-table').on('click', '.btnDetailsTek', function (evt) {
           evt.preventDefault();

           classSelectedSpekDetails = $(this).attr("class")
           var tr = $(this).closest('tr');
           var row = tblJawapanTeknikal.row(tr);
           var rowData = row.data();

           var pickedSyarikatKod = rowData.No_Mohon;
           //var pickedIDSyarikat = rowData.ID_Syarikat;

           //idMohonDtl = moment(rowData.Id_Mohon_Dtl).format('YYYY-MM-DD HH:mm:ss');
           idMohonDtl = rowData.Id_Mohon_Dtl;
           //idTeknikal = rowData.Id_Teknikal;
           idTeknikal = rowData.Id_Jawapan_Teknikal;
           idPembelian = rowData.Id_Pembelian;
           //kodSyarikat = rowData.ID_Syarikat;
           //console.log("kodSyarikatkodSyarikatkodSyarikatkodSyarikat xx=", kodSyarikat);
           //console.log("pickedIDSyarikatpickedIDSyarikat xx=", pickedIDSyarikat);
           if (row.child.isShown()) {
               // This row is already open - close it
               row.child.hide();
               tr.removeClass('shown');
               $(this).html('<i class="fas fa-plus"></i>');

               // Destroy the Child Datatable
               childTableTek = null;
               //$('#childTeknikal' + pickedSyarikatKod).DataTable().destroy();
           }
           else {

               if (prevRow !== null) {
                   // This row is already open - close it
                   prevRow.child.hide();
                   prevTr.removeClass('shown');
                   prevBtn.html('<i class="fas fa-plus"></i>');
                   // Destroy the Child Datatable

               }

               prevBtn = $(this);
               prevTr = tr;
               prevId = '#childTeknikal' + pickedSyarikatKod;
               prevRow = row;

               $(this).html('<i class="fas fa-minus"></i>');

               row.child(formatTeknikal(pickedSyarikatKod)).show();
               //var id = rowData.kod;

               childTableTek = $('#childTeknikal' + pickedSyarikatKod).DataTable({
                   dom: "t",
                   paging: false,
                   ajax: {
                       url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetTeknikalDtl_Buku2") %>',
                       type: 'POST',
                       "data": function (d) {
                           console.log("Sending AJAX request with idMohonDtl:", idMohonDtl);
                           console.log("Sending AJAX request with noMohonValue:", noMohonValue);
                           return JSON.stringify({ idTeknikal: $('#idTeknikal').val(), noMohonValue: noMohonValue, idPembelian: idPembelian, kodSyarikat: $('#kodSyarikat').val(), idMohonDtl: idMohonDtl });
                       },
                       "contentType": "application/json; charset=utf-8",
                       "dataType": "json",
                       "dataSrc": function (json) {
                           return JSON.parse(json.d);
                       }
                   },
                   "rowCallback": function (row, data) {
                       // Add click event
                       $(row).on("click", function () {
                           console.log(data);
                           var rowData = data;
                           noMohonValue = rowData.No_Mohon;
                           idMohonDtl = rowData.Id_Mohon_Dtl;
                           idTeknikal = rowData.Id_Jawapan_Teknikal;
                           jumTotalWajaran = rowData.Total_Wajaran;
                           kodSyarikat = rowData.ID_Syarikat;
                           //IDPembelianDtl = rowData.Id_Pembelian;
                           console.log("kodSyarikatkodSyarikatkodSyarikatkodSyarikat cvcvcvcv=", kodSyarikat);
                           console.log("idTeknikalidTeknikalidTeknikal=", idTeknikal);
                       });
                   },
                   columns: [
                       {   //bil
                           data: null,
                           "width": "2%",
                       },
                       {   //bil
                           data: null,
                           "width": "5%",
                           "render": function (data, type, row, meta) {
                               // Render the index/bil as row number
                               return meta.row + 1;
                           },
                       },
                       {   // butiran
                           "data": "Butiran",
                           "width": "10%", "className": "text-center",
                       },
                       {
                           "data": "Sampel",
                           "width": "25%",
                           "className": "text-center",
                           "render": function (data, type, row, meta) {
                               if (data === '1') {
                                   return 'Ada';
                               } else {
                                   return 'Tiada';
                               }
                           },
                       },
                       {
                           "data": "Katalog",
                           "width": "25%",
                           "className": "text-center",
                           "render": function (data, type, row, meta) {
                               if (data === '1') {
                                   return 'Ada';
                               } else {
                                   return 'Tiada';
                               }
                           },
                       },
                   ],
                   columnDefs: [
                       {
                           "targets": 0,
                           visible: false,
                           searchable: false
                       },
                   ],
                   select: false,
               });

               tr.addClass('shown');


           }

           return false;
       });

       function formatTeknikal(id) {


           childTableTek = '<table id="childTeknikal' + id + '" class="compact w-100" width="100%">' +
               '<thead style="color: black">' +
               '<tr>' +
               '<td></td>' +
               '<td>Bil</td>' +
               '<td>Butiran</td>' +
               '<td>Sample</td>' +
               '<td>Katalog</td>' +
               '</tr>' +
               '</thead>' +
               '</table>';
           return $(childTableTek).toArray();
       }
    
       //--------------------------------------------------------------

       var tblJawapanAm = null;
       var childAmTable = null;
       var IdAmJawapan = "";
       var txtKodSpek = "";
       var kodSyarikat = "";

       $(document).ready(function () {
           tblJawapanAm = $("#spekfikasi-am-table").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
               "ordering": false,
               "info": false,
               stateSave: true,
               "ajax": {
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetAm_Buku2") %>',
                   "method": 'POST', // Moved method to a separate property
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), txtKodSpek: txtKodSpek});

                   },
                   "dataSrc": function (json) {
                       /*console.log("test spekfikasi am");*/
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
                       console.log(data);
                       var rowData = data;
                       noMohonValue = rowData.No_Mohon;
                       txtKodSpek = rowData.Kod_Spesifikasi;
                       console.log("kodSyarikat -->", kodSyarikat);
                       console.log("noMohonValue -->", txtKodSpek);
                       childAmTable.ajax.reload();
                   });
               },
               "columns": [
                   {
                       "data": null,
                       "width": "10%",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<button class="btnDetailsAm btndt${data.kod}" data-level="2" data-kod = "' + data + '"><i class="fas fa-plus"></i></button>`;

                       },
                   },
                   {
                       "data": null,
                       "width": "25%", "className": "text-center",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class = 'noMohonValue' type="hidden" value='${data.No_Mohon}'/><input class = 'txtKodSpek' type="hidden" value='${data.Kod_Spesifikasi}'/>${data.Butiran}`;

                       },
                   },
               ]
           });


       });


       //detail Speksifikasi am
       $('#spekfikasi-am-table').on('click', '.btnDetailsAm', function (evt) {
           evt.preventDefault();

           classSelectedSpekDetails = $(this).attr("class")
           var tr = $(this).closest('tr');
           var row = tblJawapanAm.row(tr);
           var rowData = row.data();

           var pickedSyarikatKod = rowData.No_Mohon;
           var pickedKodSpec = rowData.Kod_Spesifikasi;

           if (row.child.isShown()) {
               // This row is already open - close it
               row.child.hide();
               tr.removeClass('shown');
               $(this).html('<i class="fas fa-plus"></i>');

           }
           else {

               if (prevRow !== null) {
                   // This row is already open - close it
                   prevRow.child.hide();
                   prevTr.removeClass('shown');
                   prevBtn.html('<i class="fas fa-plus"></i>');
                   // Destroy the Child Datatable

               }

               prevBtn = $(this);
               prevTr = tr;
               prevId = '#childAm' + pickedSyarikatKod;
               prevRow = row;

               $(this).html('<i class="fas fa-minus"></i>');

               //row.child(format(pickedKodvot)).show();
               row.child(formatAm(pickedSyarikatKod)).show();

               childAmTable = $('#childAm' + pickedSyarikatKod).DataTable({
                   dom: "t",
                   paging: false,
                   stateSave: true,
                   ajax: {
                       url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetAmDtl_Buku2") %>',
                       type: 'POST',
                       contentType: 'application/json; charset=utf-8',
                       dataType: 'json',
                       data: function (d) {
                           console.log("Sending AJAX request kodSyarikat idPembelian VV77:", noMohonValue);
                           console.log("Sending AJAX request kodSyarikat idPembelian NN99:", txtKodSpek);
                           return JSON.stringify({ noMohonValue: pickedSyarikatKod, txtKodSpek: pickedKodSpec });

                       },
                       "dataSrc": function (json) {
                           return JSON.parse(json.d);
                       },
                   },
                   "rowCallback": function (row, data) {
                       // Add click event
                       $(row).on("click", function () {
                           console.log(data);
                           var rowData = data;
                           noMohonValue = rowData.No_Mohon;
                       });
                   },
                   columns: [
                       {   //bil
                           data: null,
                           "width": "2%",
                       },
                       {   //bil
                           data: null,
                           "width": "5%", "className": "text-center",
                           "render": function (data, type, row, meta) {
                               // Render the index/bil as row number
                               return meta.row + 1;
                           },
                       },
                       {   // butiran
                           "data": "Butiran",
                           "width": "10%", "className": "text-center",
                       },
                       { //JAWAPAN
                           "data": null,
                           "width": "25%", "className": "text-center",
                           "render": function (data, type, row, meta) {
                               if (type !== "display") {
                                   return data;
                               }
                               return `<input class = 'idAm' type="hidden" value='${data.Id_Jawapan_Am}'/>${data.Jawapan}`;

                           },
                       },
                   ],
                   columnDefs: [
                       {
                           "targets": 0,
                           visible: false,
                           searchable: false
                       },
                   ],
                   select: false,
               });


               tr.addClass('shown');


           }

           return false;
       });

       function formatAm(id) {


           childAmTable = '<table id="childAm' + id + '" class="compact w-100" width="100%">' +
               '<thead style="color: black">' +
               '<tr>' +
               '<td></td>' +
               '<td>Bil</td>' +
               '<td>Butiran</td>' +
               '<td>Jawapan</td>' +
               '</tr>' +
               '</thead>' +
               '</table>';
           return $(childAmTable).toArray();
       }

        //--------------------------- MODAL SPEK AM DAN TEKNIKAL END -------------------------

   </script>     
</asp:Content>