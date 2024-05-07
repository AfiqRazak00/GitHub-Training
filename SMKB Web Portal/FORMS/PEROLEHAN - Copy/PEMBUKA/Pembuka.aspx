<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pembuka.aspx.vb" Inherits="SMKB_Web_Portal.Pembuka" %>
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
      background-color:#ffc83d !important;
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
      background-color:#ffc83d !important;
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
      #tblKelulusan2 td:hover {
      cursor: pointer;
      }
      #tblSenaraiEP td:hover {
      cursor: pointer;
      } 
      #tblbuku1 td:hover {
      cursor: pointer;
      } 
      #tblbuku2 td:hover {
      cursor: pointer;
      }
      #tblSenaraiHadir td:hover {
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
            color:black;
            font-weight:bold;
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
            color:black;
            font-weight:bold;
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
      .fix-hade{
      top: 0;
      position: sticky;
      background:white;
      }
      .border-container {
    border: 2px solid #000;
    border-radius: 5px;
    padding: 1rem;
    max-width: 600px;
    margin: 0 auto;
    }

    .text-container {
        margin: 0 1rem;
    }

    h2 {
        border-bottom: 1px solid #000;
        margin-bottom: 1rem;
        padding-bottom: 0.5rem;
    }
     .text-container p {
        text-align: justify;
    }
   </style>
   <div id="PermohonanTab" class="tabcontent" style="display: block">
      <!-- Modal -->
      <div id="permohonan">
         <div >
            <div class=" " >
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Mesyuarat Pembuka Harga Sebut Harga / Tender Universiti</h5>
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
                        <table id="tblKelulusan2" class="table table-striped">
                           <thead>
                              <tr style="width: 100%">
                                 <th scope="col" style="width: 2%">Bil</th>
                                 <th scope="col" style="width: 8%">ID Mesyuarat</th>
                                 <th scope="col" style="width: 10%">Jawatankuasa</th>
                                 <th scope="col" style="width: 10%">Tempat Mesyuarat</th>
                                 <th scope="col" style="width: 5%">Tarikh Mesyuarat</th>
                              </tr>
                           </thead>
                           <tbody id=""></tbody>
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
                  <!--<button type="button" class="btn btn-secondary" onclick="goBack()">Kembali</button>&nbsp;&nbsp;<br />-->
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
                  </div><br />
                      <div class="form-row" >
                     <div class="col-md-6">
                     
                       <input class="input-group__input" name="lblStatus2" id="lblStatus2" type="text"  readonly style="background-color: #f0f0f0" />
                                 <label class="input-group__label" for="lblStatus2">Tempat</label>
                     </div>
                  </div><br />
                      <div class="form-row" >
                     <div class="col-md-6">

                       <input class="input-group__input" name="lblStatus3" id="lblStatus3" type="text"  readonly style="background-color: #f0f0f0" />
                                 <label class="input-group__label" for="lblStatus3">Tarikh Dan Masa Mesyuarat</label>
                     </div>
                  </div>
                  <br />
                  <div class="form-row">
                        <div class="form-group col-md-6">
                        <label class="input-group__label"><u>Proses Pembuka</u></label>
                     </div>
                     <br /><br />
                     <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                             <div style="max-height: 400px; overflow-y: auto;">
                           <table id="tblSenaraiEP" class="table table-striped" style="width: 100%">
                               <thead class="fix-hade">
                                 <tr>
                                    <th scope="col" style="width: 5%">Bil</th>
                                    <th scope="col" style="width: 10%">No Perolehan</th>
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
                           </table></div>
                        </div>
                     </div>
                  </div>
                  <br />
                  <div class="form-row">
                     <div class="form-group col-md-6">
                        <label class="input-group__label"><u>Senarai Kehadiran & Pengesahan Pembuka</u></label>
                     </div>
                     <br /><br />
                     <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                             <div style="max-height: 400px; overflow-y: auto;">
                            <input class="input-group__input " id="lblTarikhMasaTamat" type="hidden" placeholder="&nbsp;" name="lblTarikhMasaTamat" readonly style="background-color: #f0f0f0"/>
                            <input class="input-group__input " id="lblTarikhMasaHantar" type="hidden" placeholder="&nbsp;" name="lblTraikhMasaHantar" readonly style="background-color: #f0f0f0"/>
                            <input class="input-group__input " id="rkMasaSah" type="hidden" placeholder="&nbsp;" name="rkMasaSah" readonly style="background-color: #f0f0f0"/>
                           <table id="tblSenaraiHadir" class="table table-striped" style="width: 100%">
                               <thead class="fix-hade">
                                 <tr>
                                    <th scope="col" style="width: 5%">Bil</th>
                                    <th scope="col" style="width: 25%">No Staf</th>
                                    <th scope="col" style="width: 25%">Nama</th>
                                    <th scope="col" style="width: 25%">PTJ</th>
                                    <th scope="col" style="width: 25%">Jawatan</th>
                                    <th scope="col" style="width: 25%">Peranan</th>
                                    <th scope="col" style="width: 25%">Email</th>
                                    <th scope="col" style="width: 25%">Hadir?</th>
                                 </tr>
                              </thead>
                              <tbody id="">
                                 <tr style=" width: 100%" class="table-list">
                                 </tr>
                              </tbody>
                           </table></div>
                        </div>
                     </div>
                  </div>
               </div>
                  <div class="col text-center m-3">
                     <button type="button" class="btn btn-secondary btnSave" id="btnSave" data-placement="bottom" title="Simpan">Hantar</button>
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
<%--                  <button type="button" class="btn btn-secondary" onclick="goBackmodal()">Kembali</button>&nbsp;&nbsp;<br />--%>
                  <h5 class="modal-title">Proses Pembuka</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <div class="form-row" >
                     <div class="col-md-3">
                        <div class="form-group">
                            <%--//hidden input start--%>
                           <input class="input-group__input " id="txtNoStaf" type="hidden" placeholder="&nbsp;" name="txtNoStaf" readonly style="background-color: #f0f0f0"/>
                           <input class="input-group__input " id="txtNamaStaf" type="hidden" placeholder="&nbsp;" name="txtNamaStaf" readonly style="background-color: #f0f0f0"/>
                           <input class="input-group__input " id="txtPTJStaf" type="hidden" placeholder="&nbsp;" name="txtPTJStaf" readonly style="background-color: #f0f0f0"/>
                           <input class="input-group__input " id="txtJawStaf" type="hidden" placeholder="&nbsp;" name="txtJawStaf" readonly style="background-color: #f0f0f0"/>
                           <input class="input-group__input " id="txtEmailStaf" type="hidden" placeholder="&nbsp;" name="txtEmailStaf" readonly style="background-color: #f0f0f0"/>
                           <input class="input-group__input " id="lblTarikhMasaMula" type="hidden" placeholder="&nbsp;" name="lblTarikhMasaMula" readonly style="background-color: #f0f0f0"/>
                           <input class="input-group__input " id="lblMasaBuka" type="hidden" placeholder="&nbsp;" name="lblMasaBuka" readonly style="background-color: #f0f0f0"/>
                           <input class="input-group__input " id="txtDStafHantar" type="hidden" placeholder="&nbsp;" name="txtDStafHantar" readonly style="background-color: #f0f0f0"/>
                           <input class="input-group__input " id="lblTarikhMasaBuka" type="hidden" placeholder="&nbsp;" name="lblTarikhMasaBuka" readonly style="background-color: #f0f0f0"/> 
                            <%--//hidden input end--%>

                           <input class="input-group__input " id="txtNoJualan" type="text" placeholder="&nbsp;" name="txtNoJualan" style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="txtNoJualan">No Jualan Naskah :	</label>
                        </div>
                     </div>
                     <div class="col-md-3">
                        <div class="form-group">
                           <input class="input-group__input " id="txtStatus" type="text" placeholder="&nbsp;" name="txtStatus" readonly style="background-color: #f0f0f0"/>                                                     
                           <label class="input-group__label" for="txtStatus"> Status :</label>
                        </div>
                     </div>
                       <div class="col-md-3">
                        <div class="form-group">
                           <input class="input-group__input " id="noMohonValue" type="hidden" placeholder="&nbsp;" name="noMohonValue" readonly style="background-color: #f0f0f0"/>
                           <input class="input-group__input " id="noPerolehan" type="text" placeholder="&nbsp;" name="noPerolehan" readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="noPerolehan">No Perolehan :	</label>
                        </div>
                     </div>
                         <div class="col-md-3">
                        <div class="form-group">
                           <input class="input-group__input " id="txtNoSebutHarga" type="text" placeholder="&nbsp;" name="txtNoSebutHarga" readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="txtNoSebutHarga">No Sebut Harga / Tender :</label>
                        </div>
                     </div>
                  </div>
                  <div class="form-row" >
                     <div class="col-md-12">
                        <div class="form-group">
                           <textarea class="input-group__input"  id="tujuanValue" readonly style="background-color: #f0f0f0; height:auto"  rows="4"></textarea>
                           <label class="input-group__label" for="tujuanValue">Tujuan Perolehan :	</label>
                        </div>
                     </div>
                  </div>
                  <div class="form-row" >
                     <div class="col-md-2">
                        <div class="form-group">
                           <input class="input-group__input " id="KategoriValue" type="text" placeholder="&nbsp;" name="KategoriValue" readonly style="background-color: #f0f0f0"/>
                           <input class="input-group__input" name="txtTempat" id="txtTempat" type="hidden" style="background-color: #f0f0f0" />
                           <label class="input-group__label" for="KategoriValue">Kategori Perolehan :</label>
                        </div>
                     </div>
                       <div class="col-md-2">
                        <div class="form-group">
                           <input class="input-group__input " id="txtKaedahPerolehan" type="text" placeholder="&nbsp;" value="" name="txtKaedahPerolehan" readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="txtKaedahPerolehan">Kaedah Perolehan :	</label>
                        </div>
                     </div>
                      <div class="col-md-5">
                        <div class="form-group">
                            <input class="input-group__input " id="ddlPTJPemohon" type="text" placeholder="&nbsp;" name="ID Mesyuarat"  readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="ddlPTJPemohon">PTJ :</label>
                        </div>
                     </div>
                     <%-- <div class="col-md-2">
                        <div class="form-group">
                           <input class="input-group__input " id="txtNoSebutHarga" type="text" placeholder="&nbsp;" name="txtNoSebutHarga" readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="txtNoSebutHarga">No Sebut Harga / Tender :</label>
                        </div>
                     </div>--%>
                      <div class="form-group col-md-3 form-inline">
                            <label class="" for="rdKontrak">Jenis Penilaian :</label>
                                 <div class="radio-btn-form d-flex " id="rdJnsPenilaian1" name="rdKontrak1">
                                        <div class="form-check form-check-inline">
                                              <input class="form-check-input" id="rdSyarikat" type="radio" name="inlineRadioOptions" id="inlineRadio1" value="S">
                                              <label class="form-check-label" for="inlineRadio1">Syarikat</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                               <input class="form-check-input" id="rdItem" type="radio" name="inlineRadioOptions" id="inlineRadio2" value="I">
                                               <label class="form-check-label" for="inlineRadio2">Item</label>
                                        </div>
                               </div>
                     </div>
                  </div>
                  <!--- datatable display senarai petender --->
                  <div class="form-row" >
                     <div class="form-group col-md-2">
                        <label class="input-group__label"><u>Senarai Petender</u></label>
                     </div>
                     <br /><br />
                     <div class="col-md-12">
                        <%--<div class="secondaryContainer transaction-table table-responsive">--%>
                           <table id="tblSenaraiPetender" class="table table-striped" style="width: 100%">
                              <thead class="fix-hade">
                                 <tr style="width:100%; background-color:#FFC83D">
                                    <th scope="col">Bil</th>
                                    <th scope="col">Kod</th>
                                    <th scope="col">Gred</th>
                                    <th scope="col">Harga Tawaran (RM)</th>
                                    <th scope="col">Tempoh Siap</th>
                                    <th scope="col">Ulasan</th>
                                    <%--<th scope="col">Muat Naik Ulasan (Jika ada)</th>--%>
                                     <th scope="col">Muat Naik Ulasan (Jika ada) 
                                        <span data-toggle="tooltip" title="Jenis fail yang dibenarkan: .pdf only (Saiz Maksimum: 5MB)">
                                            <i class="fa fa-info-circle" aria-hidden="true" style="color: black;"></i>
                                        </span>
                                    </th>
                                    <th scope="col">Semakan Buku 1</th>
                                    <th scope="col">Semakan Buku 2</th>
                                    <th scope="col">Semakan Selesai</th>
                                    <th scope="col"></th>
                                 </tr>
                              </thead>
                              <tbody id="tableID_Senarai" style="cursor:pointer;overflow:auto; ">
                              </tbody>
                           </table>
                        <%--</div>--%>
                     </div>
                  </div>
                  <!--- datatable display senarai petender end--->
               </div>
                  <div class="col text-center m-3">
                     <button type="button" class="btn btn-secondary btnSimpan" data-placement="bottom" title="Hantar">Simpan</button>
                      <%--<button type="button" class="btn btn-secondary btnKeep" data-toggle="tooltip" data-placement="bottom" title="Simpan" id="btnKeep">Save Kod</button>--%>
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
                <div class="col text-center m-3"> 
                        <%--<button id="selesaiButton1" type="button" class="btn btn-secondary selesaiButton1" data-dismiss="modal" onclick="changeIcon1()">Selesai</button>--%>
                    <button id="selesaiButton1" type="button" class="btn btn-secondary selesaiButton1" data-dismiss="modal">Selesai</button>
                </div>
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
                <div class="col text-center m-3"> 
                    <%--<button id="selesaiButton2" type="button" class="btn btn-secondary selesaiButton2" data-dismiss="modal" onclick="changeIcon2()">Selesai</button>--%>
                    <button id="selesaiButton2" type="button" class="btn btn-secondary selesaiButton2" data-dismiss="modal">Selesai</button>
                </div>
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

                   <div style="text-align: center; margin-top: 20px;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox1" name="pengesahanCheckbox1" class="pengesahanCheckbox1" onchange="checkAndChangeIcon1()">
                        <label for="pengesahanCheckbox1">Disemak.</label>
                    </div>
               </div>
               <div class="col text-center m-3"> 
                    <button id="submitProfilSya" type="button" class="btn btn-secondary submitProfilSya" data-dismiss="modal">Simpan</button>
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
                    <div style="text-align: center; margin-top: 20px; margin-bottom: 0; font-weight: bold;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox2" name="pengesahanCheckbox2" onchange="checkAndChangeIcon2()">
                        <label for="pengesahanCheckbox2" style="margin: 0;">Disemak.</label>
                    </div>
               </div>
               <div class="col text-center m-3" style="margin-top: 0; padding-top: 0;">
                    <button id="submitSyaratAm" type="button" class="btn btn-secondary submitSyaratAm" data-dismiss="modal" >Simpan</button>
               </div>
            </div>
         </div>
         </div>
        <%--//syaratam END--%>

         <%--//jadualharga start--%>
           <div class="modal fade" id="jadualHargaModal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 100%;" role="document">
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
                  <div style="text-align: center; margin-top: 20px;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox3" name="pengesahanCheckbox3" onchange="checkAndChangeIcon3()">
                        <label for="pengesahanCheckbox3">Disemak.</label>
                    </div>
               </div>
                <div class="col text-center m-3" style="margin-top: 0; padding-top: 0;">
                    <button id="submitJadualHarga" type="button" class="btn btn-secondary submitJadualHarga" data-dismiss="modal" >Simpan</button>
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
                   <div style="text-align: center; margin-top: 20px; margin-bottom: 0; font-weight: bold;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox4" name="pengesahanCheckbox4" onchange="checkAndChangeIcon4">
                        <label for="pengesahanCheckbox4" style="margin: 0;">Disemak.</label>
                    </div>
               </div>
                 <div class="col text-center m-3" style="margin-top: 0; padding-top: 0;">
                    <button id="submitJaminanPembekal" type="button" class="btn btn-secondary" data-dismiss="modal" >Simpan</button>
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
                   <div style="text-align: center; margin-top: 20px; margin-bottom: 0; font-weight: bold;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox5" name="pengesahanCheckbox5" onchange="checkAndChangeIcon5">
                        <label for="pengesahanCheckbox5" style="margin: 0;">Disemak.</label>
                    </div>
               </div>
                 <div class="col text-center m-3" style="margin-top: 0; padding-top: 0;" >
                    <button id="submitAkuanPembida" type="button" class="btn btn-secondary submitAkuanPembida" data-dismiss="modal" >Simpan</button>
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
                   <div style="text-align: center; margin-top: 20px;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox6" name="pengesahanCheckbox6" onchange="checkAndChangeIcon6">
                        <label for="pengesahanCheckbox6">Disemak.</label>
                    </div>
               </div>
                 <div class="col text-center m-3"> 
                    <button id="submitPengalamanSya" type="button" class="btn btn-secondary submitPengalamanSya" data-dismiss="modal" >Simpan</button>
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

                     <div style="text-align: center; margin-top: 20px;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox7" name="pengesahanCheckbox7" onchange="checkAndChangeIcon7">
                        <label for="pengesahanCheckbox7">Disemak.</label>
                    </div>
               </div>
                <div class="col text-center m-3" style="margin-top: 0; padding-top: 0;">
                    <button id="submitMTD" type="button" class="btn btn-secondary submitMTD" data-dismiss="modal" >Simpan</button>
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

                   <div style="text-align: center; margin-top: 20px;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox8" name="pengesahanCheckbox8" onchange="checkAndChangeIcon8">
                        <label for="pengesahanCheckbox8">Disemak.</label>
                    </div>
               </div>
               <div class="col text-center m-3"> 
                    <button id="submitSijilTerkini" type="button" class="btn btn-secondary submitSijilTerkini" data-dismiss="modal">Simpan</button>
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
                     <div style="text-align: center; margin-top: 20px;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox13" name="pengesahanCheckbox13" onchange="checkAndChangeIcon13">
                        <label for="pengesahanCheckbox13">Disemak.</label>
                    </div>
                </div>
                <div class="col text-center m-3"> 
                    <button id="submitBorangTeknikal" type="button" class="btn btn-secondary submitBorangTeknikal" data-dismiss="modal">Simpan</button>
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
                  <h5 class="modal-title">Jadual Perancangan Kerja</h5>
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
                   <div style="text-align: center; margin-top: 20px;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox9" name="pengesahanCheckbox9" onchange="checkAndChangeIcon9">
                        <label for="pengesahanCheckbox9">Disemak.</label>
                    </div>
               </div>
                <div class="col text-center m-3"> 
                    <button id="submitJadualKerja" type="button" class="btn btn-secondary submitJadualKerja" data-dismiss="modal" >Simpan</button>
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
                   <div style="text-align: center; margin-top: 20px;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox10" name="pengesahanCheckbox10" onchange="checkAndChangeIcon10">
                        <label for="pengesahanCheckbox10">Disemak.</label>
                    </div>
               </div>
               <div class="col text-center m-3"> 
                    <button id="submitAuthLetter" type="button" class="btn btn-secondary submitAuthLetter" data-dismiss="modal" >Simpan</button>
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
                   <div style="text-align: center; margin-top: 20px;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox11" name="pengesahanCheckbox11" onchange="checkAndChangeIcon11">
                        <label for="pengesahanCheckbox11">Disemak.</label>
                    </div>
               </div>
                 <div class="col text-center m-3"> 
                    <button id="submitKatalog" type="button" class="btn btn-secondary submitKatalog" data-dismiss="modal" >Simpan</button>
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
                   <div style="text-align: center; margin-top: 20px;">
                        PENGESAHAN SYARIKAT
                        <br>
                        <input type="checkbox" id="pengesahanCheckbox12" name="pengesahanCheckbox12" onchange="checkAndChangeIcon12">
                        <label for="pengesahanCheckbox12">Disemak.</label>
                    </div>
               </div>
                   <div class="col text-center m-3"> 
                    <button id="submitSample" type="button" class="btn btn-secondary submitSample" data-dismiss="modal" >Simpan</button>
               </div>
            </div>
         </div>
      </div>
       <%--//sample end--%>

       
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
         </div>  <!-- Modal Pengesahan-->
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
                     <p id="resultModalMessage1"></p>
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                  </div>
               </div>
            </div>
         </div>
         <!-- modal lampiran start -->
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

          <div class="modal fade" id="displayMakluman" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-center" id="displayMaklumanTitle">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="displayMaklumanBody">Buku selesai disemak</p>
                    </div>
                    <div class="modal-footer" style="padding:2px"> 
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">OK</button>
                    </div>
                </div>
            </div>
        </div>

         <div class="modal fade" id="displayMaklumanError" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title text-center" id="displayMaklumanTitleError">Makluman</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="displayMaklumanBodyError">Buku gagal disemak</p>
            </div>
            <div class="modal-footer" style="padding:2px"> 
                <button type="button" class="btn btn-secondary" data-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

        <!-- modal lampiran end -->

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
       //popup
       var tempArrChecklist = {};

       var kodPembukaValue = $('.kodPembuka').val();

       function ShowPopup(elm) {

           if (elm == "1") {
               $('#senaraiHargaModal').modal('toggle');
           }
           else if (elm == "2") {
               $('#senaraiHargaModal').modal('toggle');
               $('#maklumatPermohonanModal').modal('toggle');
           }
           //else if (elm == "3") {
           //    $('#maklumatPermohonanModal').modal('toggle');
           //    $('#maklumatPermohonanModal3').modal('toggle');
           //}
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

       //back button
       function goBack() {
           // Close the current modal
           $('#senaraiHargaModal').modal('hide');

           // Open the senaraiHargaModal
           $('#exampleModalCenterTitle').modal('show');
       }

       //back button
       function goBackmodal() {
           // Close the current modal
           $('#maklumatPermohonanModal').modal('hide');

           // Open the senaraiHargaModal
           $('#senaraiHargaModal').modal('show');
       }

       //Dapatkan tarikh semasa
       var todaydate = new Date();
       var day = todaydate.getDate();
       var month = (todaydate.getMonth() + 1).toString().padStart(2, '0');
       var year = todaydate.getFullYear();
       var datestring = day + "/" + month + "/" + year;

       //Dapatkan waktu semasa
       var todaydate = new Date();
       var hours = todaydate.getHours().toString().padStart(2, '0');
       var minutes = todaydate.getMinutes().toString().padStart(2, '0');
       var seconds = todaydate.getSeconds().toString().padStart(2, '0');
       var timestring = hours + ":" + minutes + ":" + seconds;

       var datetimeString = datestring + " " + timestring;

       window.onload = function () {
           //Dapatkan tarikh semasa
           document.getElementById("lblTarikhMasaMula").value = datestring;
           document.getElementById("lblTarikhMasaBuka").value = datestring;
           document.getElementById("lblMasaBuka").value = timestring;
           //document.getElementById("rkMasaSah").value = timestring;
           //document.getElementById("rkMasaSah").value = datestring + " " + timestring;
           document.getElementById("rkMasaSah").value = datetimeString;
           document.getElementById("lblTarikhMasaTamat").value = datestring + " " + timestring;
           document.getElementById("lblTarikhMasaHantar").value = datestring + " " + timestring;

           //Display session on form 
           document.getElementById("txtNoStaf").value = '<%= Session("ssusrName") %>';  //ssusrName
           document.getElementById("txtDStafHantar").value = '<%= Session("ssusrName") %>';  //ssusrName
           //document.getElementById("txtPemohon").value = <//%= Session("ssusrKodPTj") %>;   //ssusrName
       };

       var htmlContent = '';
       var IDMesy = "";
       //table MesyPembuka
       var tbl = null;
       var isClicked7 = false;
       $(document).ready(function () {
           tbl = $("#tblKelulusan2").DataTable({
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
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/LoadSenaraiMesy")%>',
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
                           isClicked7: isClicked7,
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
                       $("#lblStatus4").val(rowData.TarikhDaftar);
                       tbl2.ajax.reload();
                       tbl3.ajax.reload();
                       ShowPopup(1, data.IDMesy);


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
                               //console.log("TarikhMasa:", row.TarikhDaftar);
                               //console.log("TarikhMasa:", row.TarikhMasa);

                               // Combine the formatted values
                               var combinedValue = `${formattedTarikhDaftar} ${row.TarikhMasa}`;

                               data = combinedValue;
                           }
                           return data;
                       }
                   }
                   //{
                   //    "data": null,
                   //    "defaultContent": '<i onclick="ShowPopup(1)" class="fa fa-ellipsis-h fa-lg"></i>',
                   //    "className": "text-center", // Center the icon within the cell
                   //    "width": "5%"
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
               return `${dd}/${mm}/${yyyy}`;
           }

           $('.btnSearch').click(async function () {

               //load_loader();
               isClicked7 = true;
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
                       $("#noMohonValue").val(rowData.No_Mohon); // id
                       $("#noPerolehan").val(rowData.No_Perolehan);
                       $("#tujuanValue").val(rowData.Tujuan);
                       $("#ddlPTJPemohon").val(rowData.Ptj_Mohon);
                       $("#KategoriValue").val(rowData.kategori_butiran);
                       $("#txtKaedahPerolehan").val(rowData.Kaedah);
                       $("#txtNoSebutHarga").val(rowData.No_Sebut_Harga);
                       $("#txtNoJualan").val(rowData.Id_Jualan);
                       $("#txtStatus").val(rowData.Butiran);
                       $("#IDMesy").val(rowData.ID_Mesy);

                       // Display values in HTML
                       var txtNoSebutHarga = $("#txtNoSebutHarga").val();

                       // Update the HTML content
                       var htmlContent = txtNoSebutHarga;
                       $(".form-group h5").text(htmlContent);

                       tbl4.ajax.reload();


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
                               return moment(data).format('DD/MM/YYYY HH:mm:ss');
                           }
                           return data;
                       }
                   },
                   {
                       "data": "Tarikh_Masa_Tamat_Perolehan",
                       "width": "20%",
                       "render": function (data, type, row) {
                           if (type === 'display' || type === 'filter') {
                               return moment(data).format('DD/MM/YYYY HH:mm:ss');
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

                   // Add click event
                   $(row).on("click", function () {
                       console.log(data);
                       var rowData = data;
                       $("#txtNoStaf").val(rowData.NoStaf); // nostaf
                       $("#txtNamaStaf").val(rowData.NamaStaf); // namastaf
                       $("#txtJawStaf").val(rowData.JawStaf); // jawstaf
                       $("#txtPTJStaf").val(rowData.PTJStaf); // ptjstaf
                       $("#txtEmailStaf").val(rowData.EmailStaf); // ptjstaf


                       // Use the no_mohon variable if needed globally
                       txtNoLantikan = rowData.Kod_JK;
                       console.log("txtNoLantikantxtNoLantikantxtNoLantikan", txtNoLantikan)

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
                           return `<input class = 'txtNoLantikan' type="hidden" value='${data.Kod_JK}'/><input class = 'txtNamaStaf' type="hidden" value='${data.Nama}'/>${data.Nama}`;

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
                           //return '<input type="checkbox" name="inlineCheckOptions" title="Sila check jika hadir"> <input type="text" id="PembukaID" name="PembukaID" readonly>';
                           /* return '<input type="checkbox" name="inlineCheckOptions" id="inlineCheckOptions_' + meta.row + '" title="Sila check jika hadir">';*/
                           return `<input type = 'checkbox' title='Sila check jika hadir' class = 'chkpilihSpekDetail'/> `;
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

           $('#btnSave').click(async function (evt) {
               evt.preventDefault();


           })
           /*console.log("vbvbv")*/
           //console.log("- KodJawatanKuas =", KodJawatanKuas)

       });

       //Save button click event handler   --save kehadiran start
       $('#btnSave').off('click').on('click', async function () {

           var msg = "Anda pasti ingin menyimpan rekod ini?";
           var lblMasaSahValue = $('#rkMasaSah').val();
           var lblTarikhPOValue3 = $('#lblTarikhMasaTamat').val();
           var lblTarikhPOValue4 = $('#lblTarikhMasaHantar').val();
           $('#confirmationMessage2').text(msg);
           $('#senaraiHargaModal').modal('hide');
           $('#saveConfirmationModal2').modal('show');

           $('#confirmSaveButton2').off('click').on('click', async function () {
               $('#saveConfirmationModal2').modal('hide'); // Hide the modal

               var param = {
                   JawatanKuasaList: []
               };

               $('.chkpilihSpekDetail').each(async function (ind, obj) {
                   if (obj.checked === false) {
                       return;
                   }
                   var newJawatanKuasaList = {
                       Perolehan_Mesyuarat_JKD: {
                           txtNoStaf: $('.txtNoStaf').eq(ind).val(),
                           txtNamaStaf: $('.txtNamaStaf').eq(ind).val(),
                           txtJawStaf: $('.txtJawStaf').eq(ind).val(),
                           txtEmailStaf: $('.txtEmailStaf').eq(ind).val(),
                           txtKodPTjStaf: $('.txtKodPTjStaf').eq(ind).val(),
                           txtNoJualan: txtNoJualanValue,
                           //txtNoJualan: newPermohonanPoDetailTest.mohonPoTest.txtNoJualan,
                           rkMasaSah: lblMasaSahValue,
                           lblTarikhMasaTamat: lblTarikhPOValue3,
                           lblTarikhMasaHantar: lblTarikhPOValue4,
                       }
                   }

                   console.log("test =", newJawatanKuasaList)
                   console.log("txtNoJualan after insert: ", txtNoJualanValue);
                   //console.log("txtNoJualan after insert: ", newPermohonanPoDetailTest.mohonPoTest.txtNoJualan);
                   var result = JSON.parse(await beginSaveJawatanKuasaListDetail(newJawatanKuasaList));

                   if (result.Status === true) {
                       showModal2("Success", result.Message, "success");
                       tbl.ajax.reload();

                   }
                   else {
                       showModal2("Error", result.Message, "error");
                   }
               });

           });


       });

       async function beginSaveJawatanKuasaListDetail(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Load_SaveKehadiran") %>',
                   method: 'POST',
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
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
       //--save kehadiran end


       //// Function to change the icon
       //function changeIcon1() {

       //    var iconElement = document.getElementById('icon-buku1');
       //    iconElement.className = 'fa fa-check';
       //    iconElement.style.color = 'green';
       //}

       //function displayMaklumanModal(header, body) {
       //    $('#displayMaklumanTitle').text(header);
       //    $('#displayMaklumanBody').text(body);
       //    $('#displayMakluman').modal('show');
       //}

       function displayMaklumanModal(title, message, type) {
           $('#displayMaklumanTitle').text(title);
           $('#displayMaklumanBody').text(message);
           if (type === "success") {
               $('#displayMakluman').removeClass("modal-error").addClass("modal-success");
           } else if (type === "error") {
               $('#displayMakluman').removeClass("modal-success").addClass("modal-error");
           }
           $('#displayMakluman').modal('show');
       }

       //function displayMaklumanErrorModal(title, message, type) {
       //    $('#displayMaklumanTitleError').text(title);
       //    $('#displayMaklumanBodyError').text(message);
       //    if (type === "success") {
       //        $('#displayMaklumanError').removeClass("modal-error").addClass("modal-success");
       //    } else if (type === "error") {
       //        $('#displayMaklumanError').removeClass("modal-success").addClass("modal-error");
       //    }
       //    $('#displayMaklumanError').modal('show');
       //}

       //---------------------

       var idPembelianValueE = '';
       $('#selesaiButton1').click(async function (evt) {
           evt.preventDefault();

           var idPembelianValueE = idPembelian;
           console.log("idPembelian selesaiii PembelianValueE", idPembelianValueE);

           var response = await updateAndChangeIconBuku1(idPembelianValueE);
           console.log("Response from server:", response);
           if (response.Status === true) {
               tbl4.ajax.reload();
               displayMaklumanModal("Success", response.Message, "success")

           }
           else {
               displayMaklumanErrorModal("Error", response.Message, "error");
           }
       });

       async function updateAndChangeIconBuku1(idPembelianValueE) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_Buku1") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify({ idPembelian: idPembelianValueE }),
                   success: function (data) {
                       resolve(data);
                       tbl4.ajax.reload();// Resolve with the received data
                       console.log("berjaya save");
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(error); // Reject with the error object
                   }
               });
           });
       }
       //---------------------------

       //// Function to change the icon
       //function changeIcon2() {

       //    var iconElement2 = document.getElementById('icon-buku2');
       //    iconElement2.className = 'fa fa-check';
       //    iconElement2.style.color = 'green';
       //}

       //---------------------
       $('#selesaiButton2').click(async function (evt) {
           evt.preventDefault();

           var idPembelianValueE = idPembelian;
           console.log("idPembelian selesaiii PembelianValueE", idPembelianValueE);

           try {
               var response = await updateAndChangeIconBuku2(idPembelianValueE);
               console.log("Response from server:", response);

               if (response.Code == "00") {
                   displayMaklumanModal(response.Message);
               } else {
                   displayMaklumanErrorModal(response.Message);
               }
           } catch (error) {
               console.error("Error during AJAX call:", error);
               // Handle error here, if needed
           }
       });

       async function updateAndChangeIconBuku2(idPembelianValueE) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_Buku2") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify({ idPembelian: idPembelianValueE }),
                   success: function (data) {
                       resolve(data);
                       tblbuku2.ajax.reload();// Resolve with the received data
                       tbl4.ajax.reload();// Resolve with the received data
                       console.log("berjaya save");
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(error); // Reject with the error object
                   }
               });
           });
       }


       //---------------------------
       var kodPembuka = '';
       var idPembelian = '';
       var SyarikatKod = '';

       var arrayKod = {};

       //table Senarai Petender
       var tbl4 = null;
       $(document).ready(function () {
           tbl4 = $("#tblSenaraiPetender").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
               "info": true,
               //stateSave: true,
               "ajax": {
                   <%--url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetSpeksifikasi_Pembuka") %>',--%>
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetSpeksifikasi_Pembuka") %>',
                   //"url": "PermohonanPoWS.asmx/LoadKelulusanPo",
                   "method": 'POST', // Moved method to a separate property
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       console.log("Sending AJAX request with No mOhon bbbb:", noMohonValue);
                       //console.log("Sending AJAX request with No mOhon bbbb:", kodPembuka);
                       return JSON.stringify({ noMohonValue: $('#noMohonValue').val() });

                   },
                   "dataSrc": function (json) {
                       arrayKod = {};
                       $.each(JSON.parse(json.d), function (index, value) {
                           arrayKod[index] = '';

                       });
                       console.log("helloworld", arrayKod)
                       return JSON.parse(json.d);
                   }
               },
               "rowCallback": function (row, data, index) {
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

                       /*noMohon = rowData.No_Mohon;*/
                       noMohonValue = rowData.No_Mohon;
                       noSyarikat = rowData.ID_Syarikat;
                       kodSyarikat = rowData.No_Sykt;
                       idPembelian = rowData.Id_Pembelian;
                       SyarikatKod = rowData.No_Sykt;
                       console.log("noSyarikat=", noSyarikat);
                       console.log("kodSyarikat apa=", kodSyarikat);
                       console.log("idPembelian zaq=", idPembelian);
                       console.log("SyarikatKod zaq=", SyarikatKod);
                       kodPembuka = rowData.Kod_Pembuka;
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
                       //console.log("currentRow main=", currentRow)

                       $('input.ckh_kod', row).on('change', function () {
                           var checkedCheckboxes = $(".ckh_kod:checked");
                           var uncheckedCheckboxes = $(".ckh_kod:not(:checked)");

                           if (this.checked) {
                               // Calculate and set the sequence number as the fraction of total rows minus current row index to total rows
                               var totalRows = $(".ckh_kod").length;
                               var totalChecked = checkedCheckboxes.length;
                               var fraction = totalChecked + "/" + totalRows;

                               arrayKod[index] = fraction;
                               //console.log("worldhello", arrayKod);
                               $('input.sequence', row).val(arrayKod[index]);

                               console.log("checkedCheckboxes=", arrayKod);
                           } else {
                               $('input.sequence', row).val('');
                               $('input.sequence').each(function () {

                               });

                           }

                       });


                   });
               },
               "columns": [
                   {   //BIL
                       data: null,
                       "width": "5%",
                       "render": function (data, type, row, meta) {
                           // Render the index/bil as row number
                           return meta.row + 1;
                       },
                   },
                   {
                       "data": null,
                       "title": "Kod",
                       "render": function (data, type, row, meta) {
                           return `<input id="sequentData" class="sequence form-control underline-input Debit m-1" minlength="1" maxlength="3 size="1" name="sequentData" type="text" /><input class = 'noMohonValue' id='noMohonValue' type="hidden" value='${data.No_Mohon}'/><input class = 'idPembelian' id='idPembelian' type="hidden" value='${data.Id_Pembelian}'/>`;
                       },
                       "width": "10%"
                   },
                   {
                       "data": 0,
                       "title": "Gred",
                       "width": "5%",
                       "render": function (data, type, row) {
                           //if (type === "display") {
                           //    return row.Kod_Gred;
                           //}
                           return 'TIADA';
                       },
                   },
                   { "data": "Total_Jumlah_Harga", "title": "Harga Tawaran (RM)", "width": "5%" },
                   {   //TEMPOH
                       "data": null,
                       "width": "25%", "className": "text-center",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `${row.Tempoh} ${row.Jenis_Tempoh}`;
                       },
                   },
                   {   //ULASAN SYOR
                       "data": null,
                       "width": "10%",
                       "render": function (data, type, row, meta) {
                           if (data !== null && data.Ulasan_Pembuka !== null) {
                               return `<textarea rows="4" cols="40" class="txtUlasanPembuka" id="txtUlasanPembuka" name="txtUlasanPembuka">${data.Ulasan_Pembuka}</textarea><input class = 'kodPembuka' id='kodPembuka' type="hidden" value='${data.Kod_Pembuka}'/><input class = 'noSyarikat' type="hidden" id='noSyarikat' type="text" value='${data.ID_Syarikat}'/>`;
                           } else {
                               return `<textarea rows="4" cols="40" class="txtUlasanPembuka" id="txtUlasanPembuka" name="txtUlasanPembuka"></textarea><input class = 'kodPembuka' id='kodPembuka' type="hidden" value='${data.Kod_Pembuka}'/><input class = 'noSyarikat' id='noSyarikat' type="hidden" value='${data.ID_Syarikat}'/>`;
                           }
                       }
                       //"render": function (data, type, row, meta) {
                       //    return `<textarea rows="4" cols="40" class="txtUlasanPembuka" id="txtUlasanPembuka" name="txtUlasanPembuka">${data.Ulasan_Pembuka}</textarea><input class = 'kodSyarikat' id='kodSyarikat' type="hidden" value='${data.ID_Syarikat}'/><input class = 'noSyarikat' id='noSyarikat' type="hidden" value='${data.No_Sykt}'/>`;
                       //},
                   },
                   {
                       "data": null,
                       "render": function (data, type, row) {
                           // Assuming No_Mohon is the identifier for the row, use it to create unique input IDs
                           var uploadId = "uploadDokumen_" + row.No_Mohon; // Unique ID based on row identifier
                           return '<input type="file" id="' + uploadId + '" class="uploadDokumen form-control-file" />';
                       },
                       "width": "10%"
                   },
                   {
                       "data": "Semak_Buku1",
                       "width": "5%", "className": "text-center",
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
                       "width": "5%", "className": "text-center",
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
                   {
                       "data": null,
                       "title": "Semakan Selesai",
                       "render": function (data, type, row) {
                           return '<input class="ckh_kod" id="ckh_kod" value="1" type="checkbox" aria-label="" class="ckh_kod">';
                       },
                       "width": "5%"
                   },
                   {
                       "data": null,
                       "title": "",
                       "render": function (data, type, row) {
                           return `
                        <div class="row">
                            <div class="col-md-2">
                                <button id="btnUpdate" class="btn btnUpdate" style="padding:0px 0px 0px 0px" title="Kemaskini">
                                   <i class="far fa-edit fa-lg"></i>
                                </button>
                            </div>
                        </div>`;
                       },
                       "width": "5%"
                   },
               ],
           });

           $('#tblSenaraiPetender tbody').on('click', 'td:nth-child(8)', function () {
               var rowData = tbl4.row($(this).closest('tr')).data(); // Get data of the clicked row
               ShowPopup(4); // Call ShowPopup function with parameter 4
           });

           $('#tblSenaraiPetender tbody').on('click', 'td:nth-child(9)', function () {
               var rowData = tbl4.row($(this).closest('tr')).data(); // Get data of the clicked row
               ShowPopup(5); // Call ShowPopup function with parameter 4
           });


       });
       //---------------------------

       var rowData = '';
       var txtTempat;

       $('#tblKelulusan2').on('click', 'tr', function () {
           var rowData = $('#tblKelulusan2').DataTable().row(this).data();
           $("#txtTempat").val(rowData.Tempat);
           txtTempat = rowData.Tempat;
       });

       $('.btnSimpan').off('click').on('click', async function () {

           $('#maklumatPermohonanModal').modal('hide');
          $('#saveConfirmationModal10').modal('show');

          // var msg = "";
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage10').text(msg);
           

           var lblTarikhPOValue = $('#lblTarikhMasaMula').val();
           var lblTarikhPOValue2 = $('#lblTarikhMasaBuka').val();
           var lblMasaPOValue = $('#lblMasaBuka').val();
           var parts = lblTarikhPOValue.split('/');
           var lblTarikhPOFormatted = parts[2] + '-' + parts[1] + '-' + parts[0];
           var parts2 = lblTarikhPOValue2.split('/');
           var lblTarikhPOFormatted2 = parts2[2] + '-' + parts2[1] + '-' + parts2[0];

           $('#confirmSaveButton10').off('click').on('click', async function () {
               $('#saveConfirmationModal10').modal('hide');

               // Include selected values in the object
               var newPermohonanPoDetailTest = {
                   mohonPoTest: {
                       noMohonValue: $('#noMohonValue').val(),
                       txtNoJualan: $('#txtNoJualan').val(),
                       lblTarikhMasaMula: lblTarikhPOFormatted,
                       lblMasaBuka: lblMasaPOValue,
                       lblTarikhMasaBuka: lblTarikhPOFormatted2,
                       txtTempat: $('#txtTempat').val(),
                       JnsPenilaian: $("input[name='inlineRadioOptions']:checked").val(),

                   }
               }

               //console.log(newPermohonanPoDetailTest.mohonPoTest.txtTempat);
               console.log("txtNoJualan after insert: ", newPermohonanPoDetailTest.mohonPoTest.txtNoJualan);
               txtNoJualanValue = newPermohonanPoDetailTest.mohonPoTest.txtNoJualan;

               var result = JSON.parse(await ajaxSavePermohonanPoHeader(newPermohonanPoDetailTest));

               // Integration of btnKeep functionality
               $('.ckh_kod:checked').each(async function (ind, obj) {
                   if (obj.checked === false) {
                       return;
                   }

                   // Retrieve kodPembuka value
                   var noSyarikatValue = $('#noSyarikat').eq(ind).val();
                   var idPembelianValue = $('#idPembelian').eq(ind).val();
                   //var kodPembukaValue = $('#kodPembuka').val();

                   var newKodList = {
                       Perolehan_Mesyuarat_JKD: {
                           sequenceNumber: $('input.sequence').eq(ind).val(),
                           txtUlasanPembuka: $('.txtUlasanPembuka').eq(ind).val(),
                           noSyarikat: noSyarikatValue,  // Add kodPembuka to the object
                           idPembelian: idPembelianValue,  
                       }
                   }

                   try {
                       var result = JSON.parse(await beginSaveKod(newKodList));
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

               });
           });
       });

       async function ajaxSavePermohonanPoHeader(mohonPoTest) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Save_Test") %>',
                   method: 'POST',
                   data: JSON.stringify(mohonPoTest),
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
       //--save maklumat penilaian  end


       //upload Ulasan Pembuka
       function showModalLampiran(header, body) {
           $('#lampirantitle').text(header);
           $('#lampiranbody').text(body);
           $('#formatSimpanLampiran').modal('show');
       }


       $(document).on("click", "#btnUpdate", function (evt) {
           console.log("Button clicked");
           evt.preventDefault();
           var row = $(this).closest('tr'); // Get the closest row
           saveAndUploadFilePembuka(row); // Pass the row to the function
       });

       function saveAndUploadFilePembuka(row) {
           //console.log("Function saveAndUploadFileUlasan Pembuka started");

           var fileInput = row.find(".uploadDokumen"); // Find the file input within the row

           var file = fileInput[0].files[0];
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

           if (fileExtension !== 'pdf') {
               showModalLampiran("Fail Salah Format", "Hanya format PDF sahaja dibenarkan.");
               return;
           }

           var formData = new FormData();
           formData.append("file", file);
           formData.append("fileName", fileName);
           formData.append("noMohonValue", row.find('.noMohonValue').val()); // Assuming you have an input with class 'noMohonValue'

           $.ajax({
               url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SaveAndUploadFileUlasan") %>',
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

       async function beginSaveKod(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanPembukaDetail") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       resolve(data.d); // Don't need to parse here
                       console.log("ajax read here  SimpanPembukaDetail...")
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       console.log("AJAX GAGAGL ...");
                       reject(false);
                   }
               });
           })
       }

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
                        tblPengalaman.ajax.reload();
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
           //console.log("Data received:", data); // Check data received

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
                       return JSON.stringify({ noMohonValue: $('#noMohonValue').val(), noSyarikat: noSyarikat, kodSyarikat: kodSyarikat, idPembelian:idPembelian });
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

       //---------------------
       $('#submitProfilSya').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;
           //console.log("idPembelian selesaiii PembelianValueE", idPembelianValueE);

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku1.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_ProfilSya") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                       resolve(true);
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon1() {
           var checkbox = document.getElementById('pengesahanCheckbox1');
           if (checkbox.checked) {

           }
       }
       //---------------------------

       //---------------------submitSyaratAm
       $('#submitSyaratAm').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;
           //console.log("idPembelian selesaiii PembelianValueE", idPembelianValueE);

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon2(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku1.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon2(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_SyaratAm") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon2() {
           var checkbox = document.getElementById('pengesahanCheckbox2');
           if (checkbox.checked) {
           }
       }
       //---------------------------

       //---------------------submitJadualHarga
       $('#submitJadualHarga').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon3(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku1.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon3(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_JadualHarga") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon3() {
           var checkbox = document.getElementById('pengesahanCheckbox3');
           if (checkbox.checked) {
           }
       }
       //---------------------------

       //---------------------submitJaminanPembekal
       $('#submitJaminanPembekal').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon4(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModalDelete4("Success", result.Message, "success");
                   tblbuku1.ajax.reload();
               } else {
                   showModalDelete4("Error", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon4(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_JaminanPembekal") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon4() {
           var checkbox = document.getElementById('pengesahanCheckbox4');
           if (checkbox.checked) {
           }
       }
       //---------------------------

       //---------------------submitAkuanPembida
       $('#submitAkuanPembida').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon5(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku1.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon5(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_AkuanPembida") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon5() {
           var checkbox = document.getElementById('pengesahanCheckbox5');
           if (checkbox.checked) {

           }
       }
       //---------------------------

       //---------------------submitPengalamanSya
       $('#submitPengalamanSya').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon6(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku1.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon6(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_PengalamanSya") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon6() {
           var checkbox = document.getElementById('pengesahanCheckbox6');
           if (checkbox.checked) {
           }
       }
        //---------------------------

       //---------------------submitMTD
           $('#submitMTD').click(async function (evt) {
               evt.preventDefault();

               // Set message in the modal
               var msg = "Anda pasti ingin menyimpan rekod ini?";
               $('#confirmationMessage1').text(msg);
               // Open the Bootstrap modal
               $('#saveConfirmationModal1').modal('show');

               $('#confirmSaveButton1').off('click').on('click', async function () {
                   $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon7(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku1.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
                   }
               });
       });

       async function updateAndChangeIcon7(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_MTD") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon7() {
           var checkbox = document.getElementById('pengesahanCheckbox7');
           if (checkbox.checked) {
           }
       }
        //---------------------------

       //---------------------submitSijilTerkini
       $('#submitSijilTerkini').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon8(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku1.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon8(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_SijilTerkini") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon8() {
           var checkbox = document.getElementById('pengesahanCheckbox8');
           if (checkbox.checked) {
           }
       }
        //---------------------------

       //---------------------submitBorangTeknikal
       $('#submitBorangTeknikal').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon13(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku2.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon13(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_BorangTeknikal") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon13() {
           var checkbox = document.getElementById('pengesahanCheckbox13');
           if (checkbox.checked) {
           }
       }
        //---------------------------

       //---------------------submitJadualKerja
       $('#submitJadualKerja').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon9(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku2.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon9(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_JadualKerja") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon9() {
           var checkbox = document.getElementById('pengesahanCheckbox9');
           if (checkbox.checked) {
           }
       }
        //---------------------------

       //---------------------submitAuthLetter
       $('#submitAuthLetter').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon10(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku2.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon10(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_AuthLetter") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       tblbuku2.ajax.reload();
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon10() {
           var checkbox = document.getElementById('pengesahanCheckbox10');
           if (checkbox.checked) {
           }
       }
        //---------------------------

       //---------------------submitKatalog
       $('#submitKatalog').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon11(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku2.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon11(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_Katalog") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon11() {
           var checkbox = document.getElementById('pengesahanCheckbox11');
           if (checkbox.checked) {
           }
       }
       //---------------------------

       //---------------------submitSample
       $('#submitSample').click(async function (evt) {
           evt.preventDefault();

           // Set message in the modal
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage1').text(msg);
           // Open the Bootstrap modal
           $('#saveConfirmationModal1').modal('show');

           $('#confirmSaveButton1').off('click').on('click', async function () {
               $('#saveConfirmationModal1').modal('hide'); // Hide the modal

           var idPembelianValueE = idPembelian;

           var newJawatanKuasaList = {
               Perolehan_Mesyuarat_JKD: {
                   idPembelian: idPembelianValueE,
               }
           };

           try {
               var result = await updateAndChangeIcon12(newJawatanKuasaList);
               console.log("result=", result);
               console.log("result111=", newJawatanKuasaList);
               if (result.Status === true) {
                   showModal2("Rekod berjaya disimpan", result.Message, "success");
                   tblbuku2.ajax.reload();
               }
               else {
                   showModal2("Gagal Menyimpan", result.Message, "error");
               }
           } catch (error) {
               console.error(error);
               }
           });
       });

       async function updateAndChangeIcon12(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanChecking_Sample") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       console.log('BERJAYA MASUK DATA KE DB');
                       resolve({ Status: true, Message: "Rekod berjaya disimpan" });
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       reject(false);
                   }
               });
           });
       }

       function checkAndChangeIcon12() {
           var checkbox = document.getElementById('pengesahanCheckbox12');
           if (checkbox.checked) {
           }
       }

       //--------------------------- MODAL SPEK AM DAN TEKNIKAL -------------------------

       var prevRow = null;
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
               console.log("prevRow1", prevRow);
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
                           //return `<button class="btnDetailsAm btndt${data.Kod_Spesifikasi}" data-level="2" data-kod = "' + data + '"><i class="fas fa-plus"></i></button>`;

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
               //console.log("prevRow",prevRow);
               if (prevRow !== null) {
                   // This row is already open - close it
                   prevRow.child.hide();
                   prevTr.removeClass('shown');
                   prevBtn.html('<i class="fas fa-plus"></i>');
                   // Destroy the Child Datatable
                   //$(prevId).DataTable().destroy();
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