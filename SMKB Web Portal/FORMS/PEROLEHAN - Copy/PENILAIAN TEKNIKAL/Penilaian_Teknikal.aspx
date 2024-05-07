<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Penilaian_Teknikal.aspx.vb" Inherits="SMKB_Web_Portal.Penilaian_Teknikal" %>
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
        }

        .nav-tabs .nav-link {
            padding: 0.25rem 0.5rem;
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
      #ddlTahun {
      display: none;
      }      
      #tblKelulusan td:hover {
      cursor: pointer;
      }
      #tblKelulusan2 td:hover {
      cursor: pointer;
      }
      #tblKelulusan3 td:hover {
      cursor: pointer;
      }
      #spekfikasi-table td:hover {
      cursor: pointer;
      }
      #tblSenaraiHadir td:hover {
      cursor: pointer;
      } 
      #spekfikasi-tek-table td:hover {
      cursor: pointer;
      } 
      #spekfikasi-am-table td:hover {
      cursor: pointer;
      }
      .fix-hade{
      top: 0;
      position: sticky;
      background:white;
      }
   </style>
   <div id="PermohonanTab" class="tabcontent" style="display: block">
      <!-- Modal -->
      <div id="permohonan">
         <div >
            <div class=" " >
               <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Mesyuarat Penilaian Teknikal Sebut Harga / Tender Universiti</h5>
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
                  </div>
               </div>
               <div class="row">
                  <div class="col-md-12">
                     <div class="transaction-table table-responsive">
                        <table id="tblKelulusan" class="table table-striped">
                           <thead>
                              <tr style="width: 100%">
                                 <th scope="col" style="width: 5%">Bil</th>
                                 <th scope="col" style="width: 25%">ID Mesyuarat</th>
                                 <th scope="col" style="width: 25%">Jawatankuasa</th>
                                 <th scope="col" style="width: 25%">Tempat Mesyuarat</th>
                                 <th scope="col" style="width: 25%">Tarikh Mesyuarat</th>
                              </tr>
                           </thead>
                           <tbody id="" >
                              <tr style=" width: 100%" class="table-list">
                                 <td style="width: 10%">
                                 </td>
                                 <td style="width: 15%">
                                 </td>
                                 <td style="width: 30%">
                                 </td>
                                 <td style="width: 25%">
                                 </td>
                                 <td style="width: 15%">
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
                                 <label class="input-group__label" for="lblStatus3">Tarikh Masa</label>
                     </div>
                  </div>
                  <br />
                  <div class="form-row">
                      <div class="form-group col-md-6">
                        <label class="input-group__label"><u>Senarai Proses Penilaian Teknikal</u></label>
                     </div>
                     <br /><br />
                     <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                             <div style="max-height: 400px; overflow-y: auto;">
                           <table id="tblKelulusan2" class="table table-striped" style="width: 100%">
                              <thead class="fix-hade">
                                 <tr>
                                    <th scope="col" style="width: 5%">Bil</th>
                                    <th scope="col" style="width: 25%">No Perolehan</th>
                                    <th scope="col" style="width: 25%">No Sebut Harga/Tender</th>
                                    <th scope="col" style="width: 25%">Tujuan</th>
                                    <th scope="col" style="width: 25%">Kategori</th>
                                    <th scope="col" style="width: 25%">No Naskah Jualan</th>
                                    <%--th scope="col" style="width: 25%">Status Penilaian</th>--%>
                                 </tr>
                              </thead>
                              <tbody id="" onclick="ShowPopup('2','1')">
                              </tbody>
                           </table></div>
                        </div>
                     </div>
                  </div>
                  <br />
                  <div class="form-row">
                     <div class="form-group col-md-6">
                        <label class="input-group__label"><u>Senarai Kehadiran & Pengesahan Penilaian Teknikal</u></label>
                     </div>
                     <br /><br />
                     <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                             <div style="max-height: 500px; overflow-y: auto;">
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
                           </table></div>
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
      <!-- modal teknikal start -->
      <div class="modal fade" id="maklumatPermohonanModal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-xl" style="max-width: 80%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
<%--                  <button type="button" class="btn btn-secondary" onclick="goBackmodal()">Kembali</button>&nbsp;&nbsp;<br />--%>
                  <h5 class="modal-title">Ringkasan Penilaian Teknikal</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <div class="modal-body">
                  <div class="form-row" >
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="txtNoJualan" type="text" placeholder="&nbsp;" name="txtNoJualan" readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="txtNoJualan">No Jualan Naskah :	</label>
                        </div>
                     </div>
                       <div class="col-md-4">
                        <div class="form-group">
                            <input class="input-group__input " id="noMohonValue" type="hidden" placeholder="&nbsp;" name="noMohonValue" readonly style="background-color: #f0f0f0"/>
                            <input class="input-group__input " id="noPerolehan" type="text" placeholder="&nbsp;" name="noPerolehan" readonly style="background-color: #f0f0f0"/>
                            <label class="input-group__label" for="noPerolehan">No Perolehan :	</label>
                        </div>
                     </div>
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="txtStatus" type="text" placeholder="&nbsp;" name="txtStatus" style="background-color: #f0f0f0"/>                                                     
                           <label class="input-group__label" for="txtStatus"> Status :</label>
                        </div>
                     </div>
                  </div>
                  <div class="form-row">
                     <div class="col-md-12">
                        <div class=" form-group">
                           <textarea class="input-group__input"  id="tujuanValue" readonly style="background-color: #f0f0f0; height:auto"  rows="4"></textarea>
                           <label class="input-group__label" for="tujuanValue">Tujuan :</label>
                        </div>
                     </div>
                  </div>
                  <div class="form-row" >
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="KategoriValue" type="text" placeholder="&nbsp;" name="KategoriValue" readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="KategoriValue">Kategori Perolehan :</label>
                        </div>
                     </div>
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="txtKaedahPerolehan" type="text" placeholder="&nbsp;" name="txtKaedahPerolehan" readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="txtKaedahPerolehan">Kaedah Perolehan :</label>
                        </div>
                     </div>
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="ddlPTJPemohon" type="text" placeholder="&nbsp;" name="ddlPTJPemohon"  readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="ddlPTJPemohon">PTJ :</label>
                        </div>
                     </div>
                  </div>
                  <div class="form-row" >
                     <div class="col-md-4">
                        <div class="form-group">
                           <input class="input-group__input " id="txtNoSebutHarga" type="text" placeholder="&nbsp;" name="txtNoSebutHarga" readonly style="background-color: #f0f0f0"/>
                           <label class="input-group__label" for="txtNoSebutHarga">No Sebut Harga / Tender :</label>
                        </div>
                     </div>
                     <div class="col-md-4">
                         <div class="form-group">
                            <input class="input-group__input " id="jumHargaValue" type="text" placeholder="&nbsp;" name="jumHargaValue" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="jumHargaValue">Anggaran Harga (RM) :</label>
                         </div>
                     </div>
                     <div class="col-md-4">
                           <div class="form-group">
                             <input class="input-group__input " id="txtTkhTmtPerolehan" type="text" placeholder="&nbsp;" name="txtTkhTmtPerolehan" readonly style="background-color: #f0f0f0" />
                              <label class="input-group__label" for="txtTkhTmtPerolehan">Tarikh Tamat Perolehan :</label>
                           </div>
                    </div>
                  </div>

                   <div class="card card-body">
                       <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Lampiran :</h6>
                           <%-- <div class="form-group col-md-2">
                                <label class="input-group__label" for="sah">Lampiran:</label>
                            </div>
                            <br />--%>
                            <div class="form-group col-md-12">
                                <label class="input-group__label" style="color: black;">Jenis Dokumen</label><br />
                                <div class="radio-btn-form d-flex " id="rdKontrak" name="rdKontrak">
                                    <div class="form-check form-check-inline">
                                        <input type="radio" id="rdLPH" name="inlineRadioOptions" value="rdLPH" class="w-200" />
                                        <label class="form-check-label" for="rdLPH">&nbsp;&nbsp;Laporan Penilaian Harga</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input type="radio" id="rdJPH" name="inlineRadioOptions" value="rdJPH" class="w-200" />
                                        <label class="form-check-label" for="rdJPH">&nbsp;&nbsp;Jadual Perbandingan Harga</label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-2">
                                        <div class="form-inline">
                                            <input id="dokumenType" type="hidden" name="dokumenType" value="PH">
                                            <input type="file" id="uploadDokumen" class="form-control-file" />
                                            <small class="form-text text-muted">Jenis fail yang dibenarkan: .pdf only <br />(Saiz Maksimum: 5MB)</small>
                                            <input type="hidden" id="namaFail" name="namaFail" />
                                        </div>
                                    </div>
                                    <div class="form-group col-md-2">
                                        <div class="form-inline ml-auto" style="margin-left: 0;">
                                            <button class="btn btn-secondary" id="savedokumen" onclick="uploadFile()">Muat Naik</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-12">
                                        <table id="tblTeknikalUpload" class="table table-striped" style="width:100%">
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
                   <br /><br />
                  <!--- datatable display senarai teknikal START syarikat --->
                  <div class="form-row" >
                    <br /><br />
                     <div class="col-md-12">
                             <div class="transaction-table table-responsive">
                           <table id="spekfikasi-table" class="table table-striped" style="width: 99%">
                              <thead class="fix-hade">
                                 <tr style="background-color:#FFC83D">
                                    <th scope="col" style="width: 5%">Bil</th>
                                    <th scope="col" style="width: 5%">Kod</th>
                                    <th scope="col" style="width: 5%">Syor</th>
                                    <th scope="col" style="width: 5%">Ulasan Syor</th>
                                    <th scope="col" style="width: 5%">Peratus Am</th>
                                    <th scope="col" style="width: 5%">Am</th>
                                    <th scope="col" style="width: 5%">Peratus Teknikal</th>
                                    <th scope="col" style="width: 5%">Teknikal</th>
                                 </tr>
                              </thead>
                              <tbody id="">
                                 <tr style=" width: 100%" class="table-list">
                                 </tr>
                              </tbody>
                           </table></div>
                     </div>
                  </div>


                     <!-- Modal Delete Result -->
  
                  <!--- datatable display senarai teknikal end syarikat--->
                   <br />
                  <!-------------------------------tab spek am dan teknikal mula---------------------------------------->
                      <%--  <div class="form-row penilaian-teknikal tabcontent" >
                     <div class="col-md-12">
                        <ul class="nav nav-tabs" id="myTab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link btnSearchteknikal active" id="AmSpekTabs" data-toggle="tab" data-target="#AmSpekTab" type="button" role="tab">Spesifikasi Am</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link btnSearchAmteknikal"  id="TeknikalSpekTabs" data-toggle="tab" data-target="#TeknikalSpekTab" type="button" role="tab">Spesifikasi Teknikal</button>
                            </li>
                        </ul>
                     </div>
                  </div>--%>
            <!-------------------------------tab spek am dan teknikal tamat---------------------------------------->

                    <%--//tab start--%>
        <%--            <div id="PenilaianTeknikalTab" class="tabcontent" style="display: block">
                      <div class="tab-content" id="myTabContent">
                         <div class="tab-pane fade show active" id="AmSpekTab" role="tabpanel">
                    <!-- tab 1 (Maklumat Am) -->

                    <div id="penteknikaldiv" runat="server" visible="true">
                        <div class="modal-body">
                         <table id="spekfikasi-table-am" class="table table-striped" border="1" width="100%">
                            <thead class="fix-hade">
                                 <tr style="width:100%; background-color:#FFC83D">
                                    <th scope="col" style="width: 5%">Kod</th>
                                    <th scope="col" style="width: 5%">Peratus Am</th>
                                    <th scope="col" style="width: 5%">Am</th>
                                    <th scope="col" style="width: 10%">Peratus Teknikal</th>
                                 </tr>
                              </thead>
                            <tbody>
                            </tbody>
                        </table>
                        </div>
                    </div>
                </div>

                <!-- End of Maklumat Am -->

                 <!-- tab 2 (Maklumat teknikal) -->
                <div class="tab-pane fade " id="TeknikalSpekTab" role="tabpanel">                   
                    <div class="modal-body">     
                           <table id="spekfikasi-table-teknikal" class="table table-striped" border="1" width="100%">
                                 <thead class="fix-hade">
                                     <tr style="background-color: #FFC83D">
                                         <th style="width: 5%"></th>
                                         <th style="width: 25%; text-align: center">Barang / Perkara</th>
                                         <th style="width: 25%; text-align: center">Kuantiti</th>
                                         <th style="width: 55%; text-align: center">Ukuran</th>
                                     </tr>
                                 </thead>
                                 <tbody></tbody>
                          </table>
                    </div>
                  </div>
               </div>                  
            </div>--%>
                <!----------------------------------------------------------------------->
               </div>                  
                <div class="col text-center m-3">
                    <button type="button" class="btn btn-secondary simpanSpekModal" data-placement="bottom" title="Simpan" id="simpanSpekModal">Hantar</button>
                    <%--<button type="button" class="btn btn-secondary simpanSpekModal2" data-toggle="tooltip" data-placement="bottom" title="Simpan" id="simpanSpekModal2">test</button>--%>
                </div>
            </div>
         </div>
      </div>
      <!-- modal teknikal end -->

      <!-- modal teknikal penilaian start-->
      <div class="modal fade" id="exampleModalTeknikal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-xl" style="max-width: 50%;" role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Penilaian Teknikal</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <!-- tab 2 (Maklumat Spesifikasi Teknikal) -->
               <div class="modal-body">
                  <input class="input-group__input" name="No Permohonan" id="txtNoMohon" type="hidden" />
                  <select class="input-group__label" name="Tahun Perolehan" id="ddlTahun" placeholder="&nbsp;"></select>
                  <table id="spekfikasi-tek-table" class="table table-striped" border="1" width="100%">
                     <thead>
                        <tr style="background-color:#FFC83D">
                           <th style="width:5%"></th>
                           <th style="width:25%;text-align:center"">Barang / Perkara</th>
                           <th style="width:55%;text-align:center">Jenama</th>
                           <th style="width:25%;text-align:center"">Model</th>
                           <th style="width:55%;text-align:center">Negara Pembuat</th>
                           <th style="width:25%;text-align:center"">Kuantiti</th>
                           <th style="width:25%;text-align:center"">Ukuran</th>
                           <th style="width:25%;text-align:center"">Skor</th>
                        </tr>
                     </thead>
                     <tbody>
                     </tbody>
                  </table>
                        <%-- <div class="col text-center m-3">
                        <button type="button" class="btn btn-secondary simpanTeknikalSkor" data-toggle="tooltip" data-placement="bottom" title="Simpan" id="simpanTeknikalSkor">Simpan</button>
                        </div>--%>
               </div>
            </div>
         </div>
      </div>
      <!-- modal teknikal penilaian end -->

      <!-- modal am penilaian start-->
      <div class="modal fade" id="exampleModalAm" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-xl"  role="document">
            <div class="modal-content">
               <div class="modal-header modal-header--sticky">
                  <h5 class="modal-title">Penilaian Am</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                  </button>
               </div>
               <!-- tab 2 (Maklumat Spesifikasi Teknikal) -->
               <div class="modal-body">
                  <select class="input-group__label" name="Tahun Perolehan" id="ddlTahun" placeholder="&nbsp;"></select>
                  <table id="spekfikasi-am-table" class="table table-striped" border="1" width="100%">
                     <thead>
                        <tr style="background-color:#FFC83D">
                           <th style="width:5%"></th>
                           <th style="width:25%;text-align:center"">Kod</th>
                           <th style="width:25%;text-align:center">Jenama</th>
                           <th style="width:25%;text-align:center"">Total Skor</th>
                        </tr>
                     </thead>
                     <tbody>
                     </tbody>
                  </table>
                    <%-- <div class="col text-center m-3">
                    <button type="button" class="btn btn-secondary simpanAmSkor" data-toggle="tooltip" data-placement="bottom" title="Simpan" id="simpanAmSkor">Simpan</button>
                    </div>--%>
               </div>

            </div>
         </div>
      </div>
      <!-- modal am penilaian end -->

     <!-- modal teknikal tab penilaian start-->
      <div class="modal fade" id="teknikalTabModal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-lg" style="max-width: 30%;" role="document">
            <div class="modal-content">
               <!-- tab 2 (Maklumat Spesifikasi Teknikal) -->
               <div class="modal-body">
                       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                           <span aria-hidden="true">&times;</span>
                           </button>
                            <table id="tblTeknikalSkor" class="table table-striped" style="width: 100%">
                               <thead class="fix-hade">
                                   <tr style="width: 100%">
                                       <th scope="col">Bil</th>
                                       <th scope="col">Jawapan</th>
                                       <th scope="col">Tetap Wajaran</th>
                                       <th scope="col">Skor</th>
                                    </tr>
                                </thead>
                                <tbody id=""></tbody>
                           </table>

                        <div class="col text-center m-3">
                            <button type="button" class="btn btn-secondary saveSkorTeknikal" data-toggle="tooltip" data-placement="bottom" title="Simpan" id="saveSkorTeknikal">Simpan</button>
                        </div>
               </div>
                <!-- Modal Delete Pengesahan-->
                     <div class="modal fade" id="saveConfirmationModalteknikal" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                        <div class="modal-dialog " role="document">
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title" id="saveConfirmationModalLabelModalteknikal">Pengesahan</h5>
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true">&times;</span>
                                 </button>
                              </div>
                              <div class="modal-body">
                                 <p id="confirmationMessageModalteknikal"></p>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                                 <button type="button" class="btn btn-secondary" id="confirmSaveButtonModalteknikal">Ya</button>
                              </div>
                           </div>
                        </div>
                     </div>
                     <!-- Modal Delete Result -->
                     <div class="modal fade" id="resultModalModalteknikal" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title" id="resultModalLabelModalteknikal">Makluman</h5>
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true">&times;</span>
                                 </button>
                              </div>
                              <div class="modal-body">
                                 <p id="resultModalMessageModalteknikal"></p>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                              </div>
                           </div>
                        </div>
                     </div>
            </div>
         </div>
      </div>
      <!-- modal teknikal tab penilaian end -->

         <!-- modal am tab penilaian start-->
      <div class="modal fade" id="amTabModal" data-backdrop="static" tabindex="-1" role="dialog"
         aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
         <div class="modal-dialog modal-dialog-centered modal-xl" style="max-width: 50%;" role="document">
            <div class="modal-content">
               <!-- tab 2 (Maklumat Spesifikasi Teknikal) -->
               <div class="modal-body">
                       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                           <span aria-hidden="true">&times;</span>
                           </button>
                            <table id="tblAmSkor" class="table table-striped" style="width: 100%">
                               <thead class="fix-hade">
                                  <tr style="background-color: #FFC83D">
                                       <th style="width: 5%"></th>
                                       <th style="width: 25%; text-align: center">Kod</th>
                                       <th style="width: 25%; text-align: center">Jenama</th>
                                       <th style="width: 25%; text-align: center">Wajaran</th>
                                       <th style="width: 55%; text-align: center">Skor</th>
                                    </tr>
                                </thead>
                                <tbody id=""></tbody>
                           </table>
                        <div class="col text-center m-3">
                            <button type="button" class="btn btn-secondary simpanTabAmSkor" data-toggle="tooltip" data-placement="bottom" title="Simpan" id="simpanTabAmSkor">Simpan</button>
                        </div>
               </div>
                <!-- Modal Delete Pengesahan-->
                     <div class="modal fade" id="saveConfirmationModalam" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                        <div class="modal-dialog " role="document">
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title" id="saveConfirmationModalLabelModalam">Pengesahan</h5>
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true">&times;</span>
                                 </button>
                              </div>
                              <div class="modal-body">
                                 <p id="confirmationMessageModalam"></p>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                                 <button type="button" class="btn btn-secondary" id="confirmSaveButtonModalam">Ya</button>
                              </div>
                           </div>
                        </div>
                     </div>
                     <!-- Modal Delete Result -->
                     <div class="modal fade" id="resultModalModalam" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title" id="resultModalLabelModalam">Makluman</h5>
                                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                 <span aria-hidden="true">&times;</span>
                                 </button>
                              </div>
                              <div class="modal-body">
                                 <p id="resultModalMessageModalam"></p>
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                              </div>
                           </div>
                        </div>
                     </div>
            </div>
         </div>

      </div>
      <!-- modal teknikal tab penilaian end -->
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
<%--   </div>--%>
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
   <script>


       $(document).ready(function () {
           // Update password field on input change
           $("#exampleInputEmail1, #exampleInputEmail2").on('input', function () {
               var number1 = parseFloat($("#exampleInputEmail1").val()) || 0;  // Convert to number, default to 0 if not a valid number
               var number2 = parseFloat($("#exampleInputEmail2").val()) || 0;  // Convert to number, default to 0 if not a valid number
               $("#exampleInputPassword1").val(number1 + number2);
           });
       });
       //hidden select ddltahun
       var hiddenOption = document.createElement("option");
       hiddenOption.text = "This is a hidden option";
       hiddenOption.value = "hidden";
       hiddenOption.style.display = "none";
       document.getElementById("ddlTahun").add(hiddenOption);

       //back button
       function goBackmodal() {
           // Close the current modal
           $('#maklumatPermohonanModal').modal('hide');

           // Open the senaraiHargaModal
           $('#senaraiHargaModal').modal('show');
       }

       var rowData3 = '';
       var rowData4 = '';
       function ShowPopup(elm, rowData) {
           console.log('rowData=', rowData)
           if (elm == "1") {

               $('#senaraiHargaModal').modal('toggle');


           }
           else if (elm == "2") {

               $('#senaraiHargaModal').modal('toggle');
               $('#maklumatPermohonanModal').modal('toggle');

           }
           else if (elm == "3") {

               $('#maklumatPermohonanModal').modal('toggle');
               $('#exampleModalTeknikal').modal('toggle');
               rowData3 = rowData;
               console.log('rowData3=', rowData3)
           }
           else if (elm == "4") {

               $('#maklumatPermohonanModal').modal('toggle');
               $('#exampleModalAm').modal('toggle');
               rowData4 = rowData;
               console.log('rowData4=', rowData4)
           }
           else if (elm == "5") {

               $('#maklumatPermohonanModal').modal('toggle');
               $('#teknikalTabModal').modal('toggle');

           }
           else if (elm == "6") {

               $('#maklumatPermohonanModal').modal('toggle');
               $('#amTabModal').modal('toggle');

           }

       }

       // Add an event listener for when the teknikalTabModal is hidden
       $('#exampleModalTeknikal').on('hidden.bs.modal', function () {
           // Show the maklumatPermohonanModal when teknikalTabModal is hidden
           $('#maklumatPermohonanModal').modal('show');
       });

       // Add an event listener for when the teknikalTabModal is hidden
       $('#exampleModalAm').on('hidden.bs.modal', function () {
           // Show the maklumatPermohonanModal when teknikalTabModal is hidden
           $('#maklumatPermohonanModal').modal('show');
       });

       // Add an event listener for when the teknikalTabModal is hidden
       $('#teknikalTabModal').on('hidden.bs.modal', function () {
           // Show the maklumatPermohonanModal when teknikalTabModal is hidden
           $('#maklumatPermohonanModal').modal('show');
       });

       // Add an event listener for when the teknikalTabModal is hidden
       $('#amTabModal').on('hidden.bs.modal', function () {
           // Show the maklumatPermohonanModal when teknikalTabModal is hidden
           $('#maklumatPermohonanModal').modal('show');
       });

       // Add an event listener for when the maklumatPermohonanModal is hidden
       $('#maklumatPermohonanModal').on('hidden.bs.modal', function () {
           // Reset any state or perform additional actions if needed
       });

       // Function to show teknikalTabModal
       function showTeknikalTabModal() {
           // Hide the maklumatPermohonanModal
           $('#maklumatPermohonanModal').modal('hide');
           // Show the teknikalTabModal
           $('#teknikalTabModal').modal('show');
       }

       // Function to show amTabModal
       function showAmTabModal() {
           // Hide the maklumatPermohonanModal
           $('#maklumatPermohonanModal').modal('hide');
           // Show the amTabModal
           $('#amTabModal').modal('show');
       }

       // Function to show teknikalTabModal
       function showSpekAmModal() {
           // Hide the maklumatPermohonanModal
           $('#maklumatPermohonanModal').modal('hide');
           // Show the teknikalTabModal
           $('#exampleModalAm').modal('show');
       }

       // Function to show amTabModal
       function showSpekTeknikalModal() {
           // Hide the maklumatPermohonanModal
           $('#maklumatPermohonanModal').modal('hide');
           // Show the amTabModal
           $('#exampleModalTeknikal').modal('show');
       }

       // Function to show maklumatPermohonanModal
       function showMaklumatPermohonanModal() {
           // Hide the teknikalTabModal
           $('#teknikalTabModal').modal('hide');
           // Hide the teknikalTabModal
           $('#amTabModal').modal('hide');
           // Hide the exampleModalTeknikal
           $('#exampleModalTeknikal').modal('hide');
           // Hide the exampleModalAm
           $('#exampleModalAm').modal('hide');
           // Show the maklumatPermohonanModal
           $('#maklumatPermohonanModal').modal('show');
       }

       var prevRow = null;
       var childTable = null;
       var no_mohon = "";
       var noMohonValue = "";
       var No_Lantik = "";
       var IDMesy = "";
       var txtNoLantikan = "";

       var tbl = null;
       var tbl2 = null;

       var isClicked3 = false;
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
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/LoadSenarai_SahPembuka_Teknikal")%>',
                   //"url": "PermohonanPoWS.asmx/LoadKelulusanPo",
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
                           isClicked3: isClicked3,
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
                       tbl4.ajax.reload();
                       ShowPopup(1, data.IDMesy);
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
                       "data": "IDMesy",
                       "width": "10%"
                   },
                   {
                       "data": "Butiran",
                       "width": "20%"
                   },
                   {
                       "data": "Tempat",
                       "width": "20%"
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
               return `${dd}/${mm}/${yyyy}`;
           }

           $('.btnSearch').click(async function () {

               //load_loader();
               isClicked3 = true;
               tbl.ajax.reload();
               //    close_loader();
           })
           //searching cat. filter
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


       /////

       $(document).ready(function () {
           tbl2 = $("#tblKelulusan2").DataTable({
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
                   //url: '</%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/LoadKelulusan") %>',
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/LoadMesyPenilaianHarga") %>',
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
                       IDMesy = rowData.IDMesy;
                       no_mohon = rowData.No_Mohon;
                       noMohonValue = rowData.No_Mohon;
                       // untuk keluarkan data sahaja dari db
                       $("#noMohonValue").val(rowData.No_Mohon);
                       $("#noPerolehan").val(rowData.No_Perolehan);
                       $("#KategoriValue").val(rowData.kategori_butiran)
                       $("#tujuanValue").val(rowData.Tujuan);
                       $("#justifikasiValue").val(rowData.Justifikasi);
                       $("#jumHargaValue").val(rowData.Total_Harga);
                       $("#txtKaedahPerolehan").val(rowData.Kaedah);
                       $("#txtNoSebutHarga").val(rowData.No_Sebut_Harga);
                       $("#txtNoJualan").val(rowData.Id_Jualan);
                       $("#txtStatus").val(rowData.Butiran);
                       $("#ddlPTJPemohon").val(rowData.Ptj_Mohon);

                       // Assuming rowData.Tarikh_Masa_Tamat_Perolehan is in the format "YYYY-MM-DDTHH:mm:ss"
                       var dateFromRowData = rowData.Tarikh_Masa_Tamat_Perolehan;

                       // Format the date using moment.js
                       //var formattedDate = moment(dateFromRowData).format('DD-MM-YYYY HH:mm:ss');
                       var formattedDate = moment(dateFromRowData).format('DD-MM-YYYY');

                       // Set the formatted date to the input field using jQuery
                       $("#txtTkhTmtPerolehan").val(formattedDate);
                       //console.log("dd", noMohonValue);
                       tblUpload.ajax.reload();
                       tbl_tab3.ajax.reload();
                       tbl3.ajax.reload();
                       /*tblWajaranSkor.ajax.reload();*/
                       tblTeknikalAm.ajax.reload();
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
                       "width": "10%"
                   },
                   {
                       "data": "Tujuan",
                       "width": "20%"
                   },
                   {
                       "data": "Tujuan",
                       "width": "20%"
                   },
                   {
                       "data": "kategori_butiran",
                       "width": "20%"
                   },
                   {
                       "data": "Id_Jualan",
                       "width": "10%"
                   },
               ]
           });
       });


       //table Senarai kehadiran
       var tbl4 = null;
       $(document).ready(function () {
           tbl4 = $("#tblSenaraiHadir").DataTable({
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
                           //return '<input type="checkbox" name="inlineCheckOptions" title="Sila check jika hadir"> <input type="text" id="PembukaID" name="PembukaID" readonly>';
                           /* return '<input type="checkbox" name="inlineCheckOptions" id="inlineCheckOptions_' + meta.row + '" title="Sila check jika hadir">';*/
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
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanFlag_PenilaianTeknikal") %>',
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

       //JIKA PENILAIAN ADALAH SYARIKAT START-------------------------------------------------
       //table Senarai Petender
       var tbl3 = null;
       var currentRow = 0;
       $(document).ready(function () {
           tbl3 = $("#spekfikasi-table").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
               "ordering": false,
               "info": false,
               stateSave: true,
               "ajax": {
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetPenilaian_Teknikal") %>',
                   "method": 'POST', // Moved method to a separate property
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       //console.log("Sending AJAX request with No mOhon bbbb:", noMohonValue);
                       return JSON.stringify({ noMohonValue: noMohonValue });
                   },
                   "dataSrc": function (json) {
                       //console.log("test spekfikasi");
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
                       kodSyarikat = rowData.ID_Syarikat;
                       idPembelian = rowData.ID_Pembelian;
                       // Update the modal content with the No_Mohon and Tujuan values
                       $("#noMohonValue").val(rowData.No_Mohon);
                       //console.log("ID_SyarikatID_SyarikatID_SyarikatID_SyarikatID_Syarikat", kodSyarikat);
                       $("#kodSyarikat").val(rowData.ID_Syarikat);
                       console.log("rowDatarowData=", rowData)
                       currentRow = row._DT_RowIndex;
                       console.log("currentRow currentRowcurrentRow=", currentRow)
                       tbl_tab3.ajax.reload();
                       tbl_tab2.ajax.reload();
                       //childTableTeknikal.ajax.reload();
                       childTableTek.ajax.reload();

                   });
               },
               "columns": [
                   {   //BIL
                       data: null,
                       "width": "10%",
                       "render": function (data, type, row, meta) {
                           // Render the index/bil as row number
                           return meta.row + 1;
                       },
                   },
                   {   //KOD PETENDER
                       "data": null,
                       "width": "10%", "className": "text-center",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input class="noMohonValue" id="noMohonValue" type="hidden" value="${data.No_Mohon}" /><input class="idPembelian" id="idPembelian" type="hidden" value="${data.ID_Pembelian}" /><input class="kodPembuka" id="kodPembuka" type="hidden" value="${data.Kod_Pembuka}" />${data.Kod_Pembuka}`;
                       },
                   },
                   {   //SYOR TICK
                       "data": null,
                       "width": "10%", "className": "text-center",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }
                           return `<input type = 'checkbox' class = 'chkpilihSyorDetail'/> `;
                       },
                   },
                   {   //ULASAN SYOR
                       "data": null,
                       "width": "30%",
                       "render": function (data, type, row, meta) {
                           if (data !== null && data.Ulasan_Teknikal !== null) {
                               return `<textarea rows="4" cols="40" class="txtUlasanTeknikal" id="txtUlasanTeknikal" name="txtUlasanTeknikal">${data.Ulasan_Teknikal}</textarea><input class = 'kodSyarikat' id='kodSyarikat' type="hidden" value='${data.Kod_Syarikat}'/><input class = 'kodSyarikat' id='kodSyarikat' type="hidden" value='${data.Kod_Syarikat}'/>`;
                           } else {
                               return `<textarea rows="4" cols="40" class="txtUlasanTeknikal" id="txtUlasanTeknikal" name="txtUlasanTeknikal"></textarea><input class = 'kodSyarikat' id='kodSyarikat' type="hidden" value='${data.Kod_Syarikat}'/>`;
                           }
                       }
                       //"render": function (data, type, row, meta) {
                       //    return `<textarea rows="4" cols="40" class="txtUlasanTeknikal" id="txtUlasanTeknikal" name="txtUlasanTeknikal">${data.Ulasan_Teknikal}</textarea><input class = 'kodSyarikat' id='kodSyarikat' type="hidden" value='${data.Kod_Syarikat}'/>`;
                       //},
                   },
                   {   //PERATUS AM
                       "data": "Peratus_Am",
                       //"data": 0,
                       "width": "10%",
                       "render": function (data, type, row, meta) {
                           console.log("Current row Peratus_Am:", row);
                           if (data !== undefined && data !== null) {
                               return data + '%';
                           } else {
                               return '0.00%';
                           }
                       },
                   },
                   {   //AM
                       "data": "Tempoh",
                       "width": "10%", "className": "text-center",
                       "render": function (data, type, row, meta) {
                           return `
                           <div class="row">
                            <div class="col-md-2">
                               <button type="button" class="btn btnAm" onclick="ShowPopup(4, ${JSON.stringify(meta.row)})" style="padding:0px 0px 0px 0px" title="Papar">
                                <i class="fa fa-file center fa-lg"></i>
                            </button>
                            </div>`;
                       }
                   },
                   {   //PERATUS TEKNIKAL
                       //"PERATUS TEK": 0,
                       "data": "Peratus_Teknikal",
                       "width": "10%",
                       "className": "text-center",
                       "render": function (data, type, row, meta) {
                           console.log("Current row Peratus_Teknikal:", row);
                           console.log("Current data:", data);
                           if (data !== undefined && data !== null) {
                               return data + '%';
                           } else {
                               return '0.00%';
                           }
                       },
                   },
                   {   //TEKNIKAL
                       "data": null,
                       "width": "10%", "className": "text-center",
                       "render": function (data, type, row, meta) {
                           return `
                           <div class="row">
                            <div class="col-md-2">
                               <button type="button" class="btn btnTeknikal" onclick="ShowPopup(3,${JSON.stringify(meta.row)})" style="padding:0px 0px 0px 0px" title="Papar">
                                    <i class="fa fa-file center fa-lg"></i>
                                </button>
                            </div>`;
                       }
                   },
               ],
           });

       });

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

       //save data if teknikal is by item ----start
       $('#simpanSpekModal').click(async function (evt) {
           evt.preventDefault();

           $('#maklumatPermohonanModal').modal('hide');
           $('#saveConfirmationModal10').modal('show');

           // var msg = "";
           var msg = "Anda pasti ingin menyimpan rekod ini?";
           $('#confirmationMessage10').text(msg);

           var noMohonValueValue = $('.noMohonValue').val();

           $('#confirmSaveButton10').off('click').on('click', async function () {
               $('#saveConfirmationModal10').modal('hide');

               var param = {
                   spekList: []
               };

               $('.chkpilihSyorDetail').each(async function (ind, obj) {
                   if (obj.checked === false) {
                       return;
                   }

                   // Retrieve value
                   var row = $(this).closest('tr'); // Get the current row

                   var kodPembukaValue = $('.kodPembuka').eq(ind).val();
                   var idPembelianValue = $('.idPembelian').eq(ind).val();
                   var peratusTeknikalValue = parseFloat($('td:eq(6)', row).text());
                   var peratusAmValue = parseFloat($('td:eq(4)', row).text());
                   var txtUlasanTeknikalValue = $('.txtUlasanTeknikal').eq(ind).val();

                   //console.log("percentAmValue", percentAmValue);
                   var newJawatanKuasaList = {
                       Perolehan_Mesyuarat_JKD: {
                           noMohonValue: noMohonValueValue,
                           idPembelian: idPembelianValue,
                           //txtUlasanTeknikal: $('.txtUlasanTeknikal').eq(ind).val(),
                           txtUlasanTeknikal: txtUlasanTeknikalValue,
                           kodPembuka: kodPembukaValue,  // Add kodPembuka to the object
                           /*   percentAm: extractPercentageFromRowAm(ind), // Extract percentage data from the row*/
                           percentTek: peratusTeknikalValue,
                           percentAm: peratusAmValue,
                       }
                   }


                   try {
                       var result = JSON.parse(await beginSaveSpekDetail(newJawatanKuasaList));
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

                   //var result = JSON.parse(await beginSaveSpekDetail(newJawatanKuasaList));
                   //console.log("result=,", result)
                   //console.log("result111=,", newJawatanKuasaList)
                   //if (result.Status === true) {
                   //    showModalDelete4("Success", result.Message, "success");
                   //}
                   //else {
                   //    showModalDelete4("Error", result.Message, "error");
                   //}
               });
           });

       })

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

       function extractPercentageFromRowAm(rowIndex) {
           // Get the DataTable instance
           var dataTable = $('#spekfikasi-table').DataTable();

           // Get data for the specified row index
           var rowData = dataTable.row(rowIndex).data();

           // Assuming '0' is the index of the PERATUS AM column
           var peratusAm = rowData['0'];
           console.log("peratusAm:", peratusAm);

           return peratusAm;
       }
       //save data if teknikal is by item ----end

       async function beginSaveSpekDetail(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanTeknikalDetail") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
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

       /// ---------------------------table ------------------------ ///
       //tbl spek Am - utk collpse table +- row
       var tbl_tab3 = null;
       var childAmTable = null;
       var totalSkorAm = 0;
       var inputValues = [];
       var $tblListSpekAm = null;
       var kodSpekAm = "";
       var IdAmJawapan = "";
       var txtKodSpek = "";
       var kodSyarikat = "";

       $(document).ready(function () {
           tbl_tab3 = $("#spekfikasi-am-table").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
               "ordering": false,
               "info": false,
               stateSave: true,
               "ajax": {
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetSpeksifikasiAmSyarikat") %>',
                   "method": 'POST', // Moved method to a separate property
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       return JSON.stringify({ noMohonValue: noMohonValue, IdAmJawapan: IdAmJawapan, txtKodSpek: txtKodSpek, kodSyarikat: kodSyarikat, idPembelian: idPembelian });

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
                       IdAmJawapan = moment(rowData.Id_Am_Jawapan).format('YYYY-MM-DD HH:mm:ss');
                       // Update the modal content with the No_Mohon and Tujuan values
                       $("#noMohonValue").val(rowData.No_Mohon);
                       $("#IdAmJawapan").val(IdAmJawapan);
                       //console.log("test12vvvv=", noMohonValue);
                       console.log("Id_Am=", IdAmJawapan);
                       kodSyarikat = kodSyarikat;
                       console.log("kodSyarikat -->", kodSyarikat);
                       //console.log("txtKodSpek=", txtKodSpek);
                       //console.log("Sending AJAX request with No mOhon vvvv:", noMohonValue);
                       currentRowtxt = txtKodSpek;
                       currentRow = row._DT_RowIndex;
                       console.log("currentRow currentRowcurrentRow=", currentRowtxt)
                       console.log("currentRow=", currentRow)
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
                           return `<input class = 'noMohonValue' type="hidden" value='${data.No_Mohon}'/>${data.Kod_Spesifikasi}`;

                       },
                   },
                   {   //jenama
                       "data": "Butiran",
                       "width": "25%", "className": "text-center",
                   },
                   {   //skor
                       "data": null,
                       "width": "25%",
                       "className": "text-center",
                       "render": function (data, type, row, meta) {
                           if (type === "display") {
                               return `<span id="totalAmSkor${meta.row}" name="totalAmSkor" class="skor-am-total">${data.JumSkor}</span>`;
                           }
                           return data.JumSkor;
                       },
                   },
                   //{   //skor
                   //    "data": null,
                   //    "width": "25%",
                   //    "className": "text-center",
                   //    "render": function (data, type, row, meta) {
                   //        /*console.log("Current row index:", meta.row);*/
                   //        if (type === "display") {
                   //            return '<span id="totalAmSkor' + meta.row + '" name="totalAmSkor" class="skor-am-total">0</span>';
                   //        }
                   //        return data;
                   //    },
                   //},
               ]
           });

           //// Assuming there's a click event on table rows in tbl3
           //$('#tbl3 tbody').on('click', 'tr', function () {
           //    // Get the index of the clicked row
           //    var rowIndex = $(this).index();

           //    // Update the 4th column of the clicked row with PercentAm value
           //    tbl3.cell(rowIndex, 4).data(PercentAm.toFixed(2));

           //    // Redraw the table after updating the row
           //    tbl3.draw();
           //});

           $(document).on('input', '.skor-am-cal', function () {
               calculateSkorSpekAm();
           });

           /*var currentRow = 0;*/

           // Function to calculate the sum of 'skorSpekAm' class inputs
           function calculateSkorSpekAm() {
               let sumSkorSpekAm = 0;
               let totalSkorAm = 0;

               //original
               $('.skor-am-cal').each(function () {
                   if ($.isNumeric($(this).val())) {
                       sumSkorSpekAm += parseFloat($(this).val());
                   }
               });

               $('.skor-am-total').each(function () {
                   let skor = parseFloat($(this).text());
                   if (!isNaN(skor) && skor > 0) {
                       totalSkorAm += skor;
                   }
               });

               console.log("totalSkorAm test check value", totalSkorAm);

               totalSkorAm = sumSkorSpekAm;
               $('#totalAmSkor' + currentRow).text(totalSkorAm);
               console.log("wujud ker", currentRow);

               // Assuming txtTotalWajaran holds the value of rowData.Total_Wajaran
               let totalWajaran = parseFloat($('.txtTotalWajaran').val());

               // Calculate the result
               let PercentAm = (totalSkorAm / totalWajaran) * 100;

               // Display the result where desired
               console.log("Result percentage: " + PercentAm); // Change this to display the result where you want

               // Sum all totalAmSkor values after updating
               let sum = sumTotalAmSkor();
               console.log('Sum of totalAmSkor:', sum);

           }

           // Function to sum all totalAmSkor values
           function sumTotalAmSkor() {
               let total = 0;
               $('#spekfikasi-am-table tbody tr').each(function () {
                   let totalAmSkorElement = $(this).find('[id^="totalAmSkor"]');
                   total += parseFloat(totalAmSkorElement.text()) || 0;
               });

               let totalWajaran = parseFloat($('.txtTotalWajaran').val());
               let PercentAm = (total / totalWajaran) * 100;

               // Display di tbl 3
               tbl3.cell(rowData4, 4).data(PercentAm.toFixed(2));

               tbl3.draw();

               //// Display in tbl3 cell with class btnAm
               //$(".btnAm").each(function () {
               //    $(this).closest("tr").find("td:eq(4)").text(PercentAm.toFixed(2));
               //});

               console.log("Result percentagedddddd: " + PercentAm);
               return PercentAm.toFixed(2);

               /* return total;*/
           }

       });


       //detail Speksifikasi am
       $('#spekfikasi-am-table').on('click', '.btnDetailsAm', function (evt) {
           evt.preventDefault();

           classSelectedSpekDetails = $(this).attr("class")
           var tr = $(this).closest('tr');
           var row = tbl_tab3.row(tr);
           var rowData = row.data();

           var pickedJawapanKod = moment(rowData.Id_Am_Jawapan).format('YYYY-MM-DD HH:mm:ss');
           idAm = rowData.Id_Jawapan_Teknikal;
           var idPembelian = rowData.Id_Pembelian;
           var pickedSyarikatKod = rowData.No_Mohon;
           var pickedKodSpec = rowData.Kod_Spesifikasi;
           //console.log("Id_Amsss=", pickedSyarikatKod);
           //console.log("pickedSyarikatKodJpn=", pickedJawapanKod);
           //console.log("Kod_Spesifikasi=", pickedKodSpec);
           if (row.child.isShown()) {
               // This row is already open - close it
               row.child.hide();
               tr.removeClass('shown');
               $(this).html('<i class="fas fa-plus"></i>');
               // Destroy the Child Datatable
               //childAmTable = null;
               //$('#childAm' + pickedKodvot).DataTable().destroy();

               // Restore input values when expanding the row
               $.each(inputValues[pickedSyarikatKod], function (index, value) {
                   $('#childAm' + pickedSyarikatKod + ' .skor-am-cal').eq(index).val(value);
               });
           }
           else {

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

               // Store input values before collapsing
               inputValues[pickedSyarikatKod] = [];
               $('#childAm' + pickedSyarikatKod + ' .skor-am-cal').each(function (index) {
                   inputValues[pickedSyarikatKod][index] = $(this).val();
               });

               $(this).html('<i class="fas fa-minus"></i>');

               //row.child(format(pickedKodvot)).show();
               row.child(formatAm(pickedSyarikatKod)).show();
               //var id = rowData.kod;

               //console.log("Making AJAX request with No on child:", noMohonValue);
               //console.log("Sending AJAX request with IdAmJawapan before:", pickedSyarikatKod);
               //console.log("Sending AJAX request with pickedJawapanKod before:", pickedJawapanKod);
               //console.log("Sending AJAX request with pickedKodSpec before:", pickedKodSpec);
               childAmTable = $('#childAm' + pickedSyarikatKod).DataTable({
                   dom: "t",
                   paging: false,
                   stateSave: true,
                   ajax: {
                       url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetSpeksifikasiAmChildSyarikat") %>',
                       type: 'POST',
                       contentType: 'application/json; charset=utf-8',
                       dataType: 'json',
                       data: function (d) {
                           //console.log("Inside data function");
                           //console.log("Sending AJAX request with noMohonValue:", pickedSyarikatKod);
                           //console.log("Sending AJAX request with pickedJawapanKod:", pickedJawapanKod);
                           console.log("Sending AJAX request kodSyarikat kodSyarikat xx22:", kodSyarikat);
                           console.log("Sending AJAX request kodSyarikat idPembelian VV44:", idPembelian);
                           console.log("Sending AJAX request kodSyarikat idPembelian VV77:", noMohonValue);
                           console.log("Sending AJAX request kodSyarikat idPembelian NN99:", txtKodSpek);
                           return JSON.stringify({ noMohonValue: pickedSyarikatKod, IdAmJawapan: pickedJawapanKod, txtKodSpek: pickedKodSpec, kodSyarikat: $('#kodSyarikat').val(), idPembelian: $('#idPembelian').val() });
                           //return JSON.stringify({ IdAmJawapan: pickedSyarikatKod });
                           /*return "{ kod: '" + pickedKodvot + "'}"*/
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
                           txtTotalWajaran = rowData.Total_Wajaran;
                           idAm = rowData.Id_Jawapan_Am;
                           /*console.log("txtTotalWajaran=", txtTotalWajaran);*/
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
                       {   // tetapan wajaran
                           "data": null,
                           "width": "5%", "className": "text-center",
                           "render": function (data, type, row, meta) {
                               return `<input class = 'txtTotalWajaran' type="hidden" value='${data.Total_Wajaran}'/>${data.Wajaran}`;
                           },
                       },
                       {
                           "data": null, "className": "text-center",
                           "render": function (data, type, row, meta) {
                               return `<input id="skorSpekAm" class="skorSpekAm sequence form-control underline-input Debit m-1 skor-am-cal" minlength="1" maxlength="2" size="1" name="skorSpekAm" value="${data.Skor}" type="text" style="width: 60%;"  onchange="updateSkorSpekAm(this.value, idAm)" AutoPostBack="true"/>`;
                               //return `<input id="skorSpekAm" class="sequence form-control underline-input Debit m-1 skor-am-cal" minlength="1" maxlength="2" size="1" name="skorSpekAm" value="" type="text" style="width: 40%;"/>`;
                           },
                           "width": "5%"
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

               childAmTable.on('draw.dt', function () {

                   var totalAmSkor = 0;
                   $(prevId).find("tbody tr").each(function (ind, obj) {
                       totalAmSkor += parseFloat($(this).find('[id^="totalAmSkor"]').text()) || 0;
                   });

                   var $parentTotalWajaran = $(prevRow).find("#totalAmSkor");
                   $parentTotalWajaran.html("Jumlah Skor : " + totalAmSkor);

                   var percentAm = sumTotalAmSkor();

                   console.log("Result percentagedddddd: " + percentAm);
               });


               tr.addClass('shown');


           }

           return false;
       });

       function formatAm(id) {

           // Store input values before collapsing
           inputValues[id] = [];
           $('#childAm' + id + ' .skor-am-cal').each(function (index) {
               inputValues[id][index] = $(this).val();
           });

           childAmTable = '<table id="childAm' + id + '" class="compact w-100" width="100%">' +
               '<thead style="color: black">' +
               '<tr>' +
               '<td></td>' +
               '<td>Bil</td>' +
               '<td>Butiran</td>' +
               '<td>Jawapan</td>' +
               '<td>Tetapan Wajaran</td>' +
               '<td>Skor</td>' +
               '</tr>' +
               '</thead>' +
               '</table>';
           return $(childAmTable).toArray();
       }

       function updateSkorSpekAm(updatedValue2, idAm) {

           //var IdAmJawapan = $('.IdAmJawapan').val();

           //console.log("jjjj " + updatedValue, IdAmJawapan);
           // Perform AJAX request to update Skor value in the server
           $.ajax({
               type: 'POST',
               url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/TxtIdTextChanged") %>',
               data: JSON.stringify({ skorSpekAm: updatedValue2, idAm: idAm }),
               contentType: 'application/json; charset=utf-8',
               dataType: 'json',
               success: function (response) {
                   // Optionally handle success response
               },
               error: function (xhr, status, error) {
                   // Optionally handle error response
               }

           });
       }

       function updateSkorSpekTeknikal(updatedValue, idTeknikal) {

           //var idTeknikal = $('.idTeknikal').val();

           //console.log("vvv " + updatedValue, idTeknikal);
           // Perform AJAX request to update Skor value in the server
           $.ajax({
               type: 'POST',
               url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/TxtIdChangedText") %>',
               data: JSON.stringify({ skorSpekTeknikal: updatedValue, idTeknikal: idTeknikal }),
               contentType: 'application/json; charset=utf-8',
               dataType: 'json',
               success: function (response) {
                   // Optionally handle success response
               },
               error: function (xhr, status, error) {
                   // Optionally handle error response
               }

           });
       }

       $('#simpanAmSkor').click(async function (evt) {
           evt.preventDefault();
           $('.skor-am-cal').each(async function (ind, obj) {
              
               // Retrieve kodPembuka value
               var IdAmJawapanValue = $('.IdAmJawapan').eq(ind).val();
               var skorSpekAmValue = $('.skorSpekAm').eq(ind).val();

               console.log("IdAmJawapanValue=,", IdAmJawapanValue);
               console.log("skorSpekAmValue=,", skorSpekAmValue);

               var newAmList = {
                   Perolehan_Mesyuarat_JKD: {
                       IdAmJawapan: IdAmJawapanValue,
                       skorSpekAm: skorSpekAmValue,
                   }
               };

               var result = JSON.parse(await beginSaveAmkDetail(newAmList));
               console.log("result=,", result)
               console.log("result111=,", newAmList)
               //if (result.Status === true) {
               //    showModalDelete4("Success", result.Message, "success");
               //}
               //else {
               //    showModalDelete4("Error", result.Message, "error");
               //}
           });

       })


       async function beginSaveAmkDetail(Perolehan_Mesyuarat_JKD) {
           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanTeknikalDetailQA") %>',
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: JSON.stringify(Perolehan_Mesyuarat_JKD),
                   success: function (data) {
                       resolve(data.d); // Don't need to parse here
                       console.log("ajax am read here ...")
                   },
                   error: function (xhr, status, error) {
                       console.log("AJAX Error:", status, error);
                       console.log("AJAX am is GAGAGL ...");
                       reject(false);
                   }
               });
           })
       }

       ///-----------------------------
       //tbl spek tek - utk collpse table +- row
       var tbl_tab2 = null;
       var childTableTeknikal = null;
       var totalSkorTeknikal = 0;
       var jumSkorTeknikalDtl = 0;
       var inputValuesTek = [];
       var isClicked = false;
       var $tblListSpek = null;
       var kodSpek = "";
       var childTableTek = null;
       var idMohonDtl = "";
       var idTeknikal = "";
       var IDPembelianDtl = "";
       var idPembelian = "";
       
       $(document).ready(function () {
           tbl_tab2 = $("#spekfikasi-tek-table").DataTable({
               "responsive": true,
               "searching": false,
               "paging": false,
               "ordering": false,
               "info": false,
               stateSave: true,
               "ajax": {
                   "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetSpeksifikasi_TeknikalSyarikat") %>',
                   "method": 'POST', // Moved method to a separate property
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function (d) {
                       //return JSON.stringify({ id: $('#kodSyarikat').val() });
                       //return JSON.stringify({ ids: $('#idPembelian').val() });
                       return JSON.stringify({ noMohonValue: noMohonValue, kodSyarikat: kodSyarikat, idPembelian: idPembelian });
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
                       kodSyarikat = kodSyarikat;
                       idPembelian = rowData.Id_Pembelian;
                       console.log("noMohonValue -->", noMohonValue);
                       console.log("idPembelian -->", idPembelian);
                       console.log("kodSyarikat -->", kodSyarikat);
                       console.log("idMohonDtl -->", idMohonDtl);
                      /* currentRowtxt = Id_Teknikal;*/
                       currentRow = row._DT_RowIndex;
                       /*console.log("currentRow currentRowcurrentRow=", currentRowtxt)*/
                       console.log("currentRow currentRowcurrentRow=", currentRow)
                       //childTableTeknikal.ajax.reload();
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
                   {   // kuantiti
                       "data": "Kuantiti",
                       "width": "25%", "className": "text-center",
                   },
                   //{   // ukuran
                   //    "data": "Ukuran_Nama",
                   //    "width": "25%",
                   //    "className": "text-center",
                   //},
                   { //JAWAPAN
                       "data": null,
                       "width": "25%",
                       "className": "text-center",
                       "render": function (data, type, row, meta) {
                           if (type !== "display") {
                               return data;
                           }

                           return `${data.Ukuran}`;

                       },
                   },
                   {   //skor
                       "data": null,
                       "width": "25%",
                       "className": "text-center",
                       "render": function (data, type, row, meta) {
                           if (type === "display") {
                               if (data.JumSkorTek === null || data.JumSkorTek === "") {
                                   data.JumSkorTek = 0;
                               }
                               return `<span id="totalTeknikalSkor${meta.row}" name="totalTeknikalSkor" class="skor-teknikal-total">${data.JumSkorTek}</span>`;
                           }
                           return data.JumSkorTek;
                       },
                   },

                   //{   //skor
                   //    "data": null,
                   //    "width": "25%",
                   //    "className": "text-center",
                   //    "render": function (data, type, row, meta) {
                   //        /*console.log("Current row index:", meta.row);*/
                   //        if (type === "display") {
                   //            return '<span id="totalTeknikalSkor' + meta.row + '" name="totalTeknikalSkor" class="skor-teknikal-total">0</span>';
                   //        }
                   //        return data;
                   //    },
                   //},
                   //{   // skor
                   //    "data": "Skor",
                   //    "width": "25%",
                   //},
               ]
           });

           $(document).on('input', '.skor-teknikal-cal', function () {
               calculateSkorSpekTeknikal();
           });

           /*var currentRow = 0;*/

           // Function to calculate the sum of 'skorSpekTeknikal' class inputs
           function calculateSkorSpekTeknikal() {
               let sumSkorSpekTeknikal = 0;
               let totalSkorTeknikal = 0;

               //original
               $('.skor-teknikal-cal').each(function () {
                   if ($.isNumeric($(this).val())) {
                       sumSkorSpekTeknikal += parseFloat($(this).val());
                   }
               });

               $('.skor-teknikal-total').each(function () {
                   let skor = parseFloat($(this).text());
                   if (!isNaN(skor) && skor > 0) {
                       totalSkorTeknikal += skor;
                   }
               });

               console.log("totalSkorTeknikal test check value", totalSkorTeknikal);

               totalSkorTeknikal = sumSkorSpekTeknikal;
               $('#totalTeknikalSkor' + currentRow).text(totalSkorTeknikal);
               console.log('Sum of totalSkorTeknikal:', totalSkorTeknikal);

               // Assuming jumTotalWajaran holds the value of rowData.Total_Wajaran
               let totalWajaranTek = parseFloat($('.jumTotalWajaran').val());
               console.log('Sum of totalWajaranTek:', totalWajaranTek);
               console.log('Sum of sumSkorSpekTeknikalsumSkorSpekTeknikalsumSkorSpekTeknikal:', sumSkorSpekTeknikal);
               console.log('Sum of totalSkorTeknikaltotalSkorTeknikal:', totalSkorTeknikal);

               // Calculate the result
               let PercentTeknikal = (totalSkorTeknikal / totalWajaranTek) * 100;
               console.log("Result percentage: " + PercentTeknikal);
               console.log("Result totalSkorTeknikaltotalSkorTeknikalsssss: " + totalSkorTeknikal);
               console.log("Result totalWajaranTektotalWajaranTektotalWajaranTekwwww: " + totalWajaranTek);

               // Display the result where desired
               console.log("Result percentage: " + PercentTeknikal); // Change this to display the result where you want

               // Sum all totalTeknikalSkor values after updating
               let sum = sumTotalTeknikalSkor();
               console.log('Sum of totalTeknikalSkor:', sum);

           }

           // Function to sum all totalTeknikalSkor values
           function sumTotalTeknikalSkor() {
               let total = 0;
               $('#spekfikasi-tek-table tbody tr').each(function () {
                   let totalTeknikalSkorElement = $(this).find('[id^="totalTeknikalSkor"]');
                   total += parseFloat(totalTeknikalSkorElement.text()) || 0;
               });

               let totalWajaranTek = parseFloat($('.jumTotalWajaran').val());
               let PercentTeknikal = (total / totalWajaranTek) * 100;
               console.log('Sum of totalWajaranTek:', totalWajaranTek);

               // Display di tbl 3
               tbl3.cell(rowData3, 6).data(PercentTeknikal.toFixed(2));

               tbl3.draw();


               console.log("Result PercentTeknikalPercentTeknikal: " + PercentTeknikal);
               return PercentTeknikal.toFixed(2);

               /* return total;*/
           }

       });

       //detail Speksifikasi teknikal
       $('#spekfikasi-tek-table').on('click', '.btnDetailsTek', function (evt) {
           evt.preventDefault();

           classSelectedSpekDetails = $(this).attr("class")
           var tr = $(this).closest('tr');
           var row = tbl_tab2.row(tr);
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

               // Restore input values when expanding the row
               $.each(inputValuesTek[pickedSyarikatKod], function (index, value) {
                   $('#childTeknikal' + pickedSyarikatKod + ' .skor-teknikal-cal').eq(index).val(value);
               });
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

               // Store input values before collapsing
               inputValuesTek[pickedSyarikatKod] = [];
               $('#childTeknikal' + pickedSyarikatKod + ' .skor-teknikal-cal').each(function (index) {
                   inputValuesTek[pickedSyarikatKod][index] = $(this).val();
               });

               $(this).html('<i class="fas fa-minus"></i>');

               row.child(formatTeknikal(pickedSyarikatKod)).show();
               //var id = rowData.kod;

               childTableTek = $('#childTeknikal' + pickedSyarikatKod).DataTable({
                   dom: "t",
                   paging: false,
                   ajax: {
                       url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/GetSkor_SyarikatTeknikalDtl") %>',
                       type: 'POST',
                       "data": function (d) {
                           //console.log("Sending AJAX request with noMohonValue:", noMohonValue);
                           //console.log("Sending AJAX request with No IS SYARIKAT zxswedcvv:", kodSyarikat);
                           //console.log("Sending AJAX request with idPembelian GERERER:", idPembelian);
                           //console.log("Sending AJAX request with idMohonDtl QQQQQQQ:", idMohonDtl);
                           console.log("Sending AJAX request with idTeknikal:", idTeknikal);
                           //return JSON.stringify({ id: $('#kodSyarikat').val() });
                           //return JSON.stringify({ id: $('#noMohonValue').val() });
                           //return JSON.stringify({ id: $('#idPembelian').val() });
                           /*return JSON.stringify({ noMohonValue: noMohonValue, idPembelian: idPembelian});*/
                           return JSON.stringify({ idTeknikal: $('#idTeknikal').val(), noMohonValue: noMohonValue, idPembelian: idPembelian, kodSyarikat: $('#kodSyarikat').val(), idMohonDtl: idMohonDtl });
                           //return JSON.stringify({ noMohonValue: pickedSyarikatKod, idPembelian: idPembelian, kodSyarikat: kodSyarikat ,idTeknikal: idTeknikal });
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
                       { //JAWAPAN
                           "data": null,
                           "width": "25%", "className": "text-center",
                           "render": function (data, type, row, meta) {
                               if (data.Jawapan !== null) {
                                   return `<input class = 'idPembelian' type="hidden" value='${data.Id_Pembelian}'/><input class = 'idTeknikal' type="hidden" value='${data.Id_Jawapan_Teknikal}'/>${data.Jawapan}`;
                               } else {
                                   return `<input class = 'idPembelian' type="hidden" value='${data.Id_Pembelian}'/><input class='idAm' type="hidden" value='${data.Id_Teknikal}'/><input class = 'idTeknikal' type="hidden" value='${data.Id_Jawapan_Teknikal}'/>TIDAK DIJAWAB OLEH PEMBEKAL`;
                               }

                               console.log("jawapan1", data)
                               console.log("jawapan2", type)
                               console.log("jawapan3", row)
                               console.log("jawapan4", meta)

                           },
                           //"render": function (data, type, row, meta) {
                           //    if (type !== "display") {
                           //        return data;
                           //    }
                           //    //return `<input class = 'idTeknikal' type="text" value='${data.Id_Teknikal}'/>${data.Jawapan}`;
                           //    return `<input class = 'idPembelian' type="hidden" value='${data.Id_Pembelian}'/><input class = 'idTeknikal' type="hidden" value='${data.Id_Jawapan_Teknikal}'/>${data.Jawapan}`;

                           //},
                       },
                       {   // tetapan wajaran
                           "data": null,
                           "width": "5%", "className": "text-center",
                           "render": function (data, type, row, meta) {
                               return `<input class = 'jumTotalWajaran' type="hidden" value='${data.Total_Wajaran}'/>${data.Wajaran}`;
                           },
                       },
                       {
                           "data": null, "className": "text-center",
                           "render": function (data, type, row, meta) {
                               let skorValue = data.Skor ? data.Skor : 0;
                               return `<input id="skorSpekTeknikal" class="skorSpekTeknikal sequence form-control underline-input Debit m-1 skor-teknikal-cal" minlength="1" maxlength="2" size="1" name="skorSpekTeknikal" type="text" value="${skorValue}" style="width: 50%;" onchange="updateSkorSpekTeknikal(this.value, idTeknikal)" AutoPostBack="true"/>`;
                           },
                           //"render": function (data, type, row, meta) {
                           //    return `<input id="skorSpekTeknikal" class="skorSpekTeknikal sequence form-control underline-input Debit m-1 skor-teknikal-cal" minlength="1" maxlength="2" size="1" name="skorSpekTeknikal" type="text" value="${data.Skor}" style="width: 40%;" onchange="updateSkorSpekTeknikal(this.value, idTeknikal)" AutoPostBack="true"/>`;
                           //},
                           "width": "5%"
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

               childTableTek.on('draw.dt', function () {

                   var totalTeknikalSkor = 0;
                   $(prevId).find("tbody tr").each(function (ind, obj) {
                       totalTeknikalSkor += parseFloat($(this).find('[id^="totalTeknikalSkor"]').text()) || 0;
                   });

                   var $parentTotalWajaran = $(prevRow).find("#totalTeknikalSkor");
                   $parentTotalWajaran.html("Jumlah Skor : " + totalTeknikalSkor);

                   var PercentTeknikal = sumTotalTeknikalSkor();

                   console.log("Result percentagedddddd: " + PercentTeknikal);
               });


               tr.addClass('shown');


           }

           return false;
       });

       function formatTeknikal(id) {

           // Store input values before collapsing
           inputValuesTek[id] = [];
           $('#childTeknikal' + id + ' .skor-teknikal-cal').each(function (index) {
               inputValuesTek[id][index] = $(this).val();
           });

           childTableTek = '<table id="childTeknikal' + id + '" class="compact w-100" width="100%">' +
                           '<thead style="color: black">' +
                           '<tr>' +
                           '<td></td>' +
                           '<td>Bil</td>' +
                           '<td>Butiran</td>' +
                           '<td>Jawapan</td>' +
                           '<td>Tetapan Wajar</td>' +
                           '<td>Skor</td>' +
                           '</tr>' +
                           '</thead>' +
                           '</table>';
           return $(childTableTek).toArray();
       }

       $('#simpanTeknikalSkor').click(async function (evt) {
           evt.preventDefault();
           $('.skor-teknikal-cal').each(async function (ind, obj) {

               // Retrieve kodPembuka value
               var IdTeknikalJawapanValue = $('.idTeknikal').eq(ind).val();
               var skorSpekTeknikalValue = $('.skorSpekTeknikal').eq(ind).val();

               console.log("IdTeknikalJawapanValue=,", IdTeknikalJawapanValue);
               console.log("skorSpekTeknikalValue=,", skorSpekTeknikalValue);

               var newTeknikalList = {
                   Perolehan_Teknikal_Skor: {
                       idTeknikal: IdTeknikalJawapanValue,
                       skorSpekTeknikal: skorSpekTeknikalValue,
                   }
               };

               var result = JSON.parse(await beginSaveTeknikalDetail(newTeknikalList));
               console.log("result=,", result)
               console.log("result111=,", newTeknikalList)
               //if (result.Status === true) {
               //    showModalDelete4("Success", result.Message, "success");
               //}
               //else {
               //    showModalDelete4("Error", result.Message, "error");
               //}
           });

       })


       async function beginSaveTeknikalDetail(Perolehan_Teknikal_Skor) {
           return new Promise((resolve, reject) => {
               $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SimpanTeknikalDetailSkor") %>',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                       data: JSON.stringify(Perolehan_Teknikal_Skor),
                    success: function (data) {
                        resolve(data.d); // Don't need to parse here
                        console.log("ajax am read here ...")
                    },
                    error: function (xhr, status, error) {
                        console.log("AJAX Error:", status, error);
                        console.log("AJAX am is GAGAGL ...");
                        reject(false);
                    }
                });
            })
        }
    //JIKA PENILAIAN ADALAH SYARIKAT END-------------------------------------------------

       // -----------------file upload for penilaian teknikal
       var tblUpload = null;
       $(document).ready(function () {
           tblUpload = $("#tblTeknikalUpload").DataTable({
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
                   //    return JSON.stringify({ id: $('#txtNoMohon').val() });
                   //    console.log("aa=", id)
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
                               <div class="col-md-2">
                                    <button type="button" class="btn btnDelete" style="padding:0px 0px 0px 0px; color: red;" title="Padam">
                                       <i class="far fa-trash-alt fa-lg"></i>
                                    </button>
                               </div>
                           </div>`;
                       }
                   }
               ]

           });
       });

       //----------------------------- Delete test start
       $("#tblTeknikalUpload").off('click', '.btnDelete').on("click", ".btnDelete", function () {
           var row = $(this).closest('tr');
           var dataTable = $('#tblTeknikalUpload').DataTable();

           id_fail_hidden = dataTable.cell(row, 0).data(); //DELETE ROWS BASED ON THIS ID
           var noMohonValue = $("#noMohonValue").val();
           Nama_Fail_Pdf = dataTable.cell(row, 1).data();


           var msg = "Anda pasti ingin memadam rekod ini?";
           $('#confirmationMessageDelete4').text(msg);
           $('#saveConfirmationModalDelete4').modal('show');

           $('#confirmSaveButtonDelete4').off('click').on('click', async function () {
               $('#saveConfirmationModalDelete4').modal('hide'); // Hide the modal

               console.log('Before ajaxdeleteAttachment');
               console.log('id_fail_hidden:', id_fail_hidden);
               console.log('noMohonValue:', noMohonValue);
               console.log('Nama_Fail_Pdf:', Nama_Fail_Pdf);
               var result = JSON.parse(await ajaxdeleteAttachment(id_fail_hidden, noMohonValue, Nama_Fail_Pdf));
               console.log('After ajaxdeleteAttachment');

               // Check the result and other variables
               console.log('Result:', result);

               if (result.Status === true) {
                   showModalDelete4("Success", result.Message, "success");
                   tblUpload.ajax.reload();
                   $('#maklumatPermohonanModal').modal('show');
                   
               }
               else {
                   showModalDelete4("Error", result.Message, "error");
               }

           });
       });

       async function ajaxdeleteAttachment(id_fail_hidden, noMohonValue, Nama_Fail_Pdf) {

           return new Promise((resolve, reject) => {
               $.ajax({
                   type: "POST",
                   url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/DeleteAttachment") %>',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ id: id_fail_hidden, noMohonValue1: noMohonValue, NamaFailPdf: Nama_Fail_Pdf }),
                    success: function (data) {
                        console.log('AJAX Success:', data);
                        resolve(data.d);
                    },
                    error: function (xhr, status, error) {
                        console.log("Error: " + error);
                        console.log("salahh apa tuh");
                        reject(false);
                    }
                });
            })
       }

       function showModalLampiran(header, body) {
           $('#lampirantitle').text(header);
           $('#lampiranbody').text(body);
           $('#formatSimpanLampiran').modal('show');
       }

       //upload file
       $('#rdLPH').on('change', function () {
           if ($(this).is(':checked')) {
               // Set the value of fail_name to "Laporan Penilaian Harga"
               $('#dokumenType').val('LPH');
               // Set the value of namaFail input to "Laporan Penilaian Harga"
               $('#namaFail').val('Laporan Penilaian Harga');
           }
       });

       // When the radio button "Jadual Perbandingan Harga" is checked
       $('#rdJPH').on('change', function () {
           if ($(this).is(':checked')) {
               // Set the value of fail_name to "Jadual Perbandingan Harga"
               $('#dokumenType').val('JPH');
               // Set the value of namaFail input to "Jadual Perbandingan Harga"
               $('#namaFail').val('Jadual Perbandingan Harga');
           }
       });

       $("#savedokumen").on("click", function (evt) {
           evt.preventDefault();
           saveAndUploadFilePenilaianTeknikal();

       });

       function checkRadioAndUpload() {
           var rdLPH = document.getElementById("rdLPH");
           var rdJPH = document.getElementById("rdJPH");
           var uploadButton = document.getElementById("uploadButton");
           var namaFailValue = document.getElementById("namaFail").value; // Get the value of namaFail
           console.log("namaFailValue:", namaFailValue);

           if (rdLPH.checked) {
               // Save the selected radio button value to a hidden field
               document.getElementById("dokumenType").value = rdLPH.value;
               saveAndUploadFilePenilaianTeknikal(namaFailValue); // Pass namaFail to the function
           } else if (rdJPH.checked) {
               document.getElementById("dokumenType").value = rdJPH.value;
               saveAndUploadFilePenilaianTeknikal(namaFailValue); // Pass namaFail to the function
           } else {
               alert("Please select a document type before uploading.");
           }

       }

       function saveAndUploadFilePenilaianTeknikal(namaFailValue) {
           console.log("Function saveAndUploadFileUlasan Teknikal started");

           var fileInput = document.getElementById("uploadDokumen");
           var dokumenType = document.getElementById("dokumenType").value;
           var namaFailValue = document.getElementById("namaFail").value; // Get the value of namaFail
           console.log("namaFailValue:", namaFailValue);

           // Set the value of namaFail
           //namaFail.value = namaFailValue;

           var file = fileInput.files[0];
           console.log("file:", file);

           // Add this line to get the file name
           //var namaFail = file.name;

           var fileSize = file.size;
           var maxSize = 10 * 1024 * 1024; // Maximum size in bytes (5MB)

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
               fileName: fileName,
               //fileName: namaFail,
               namaFail: namaFailValue,
               dokumenType: dokumenType,
           };

           var formData = new FormData();
           formData.append("file", file);
           formData.append("fileName", fileName);
           //formData.append("fileName", namaFail);
           formData.append("dokumenType", dokumenType);
           formData.append("namaFail", namaFailValue);  // Add namaFailValue to the form data
           //formData.append("namaFail", namaFail.value);
           formData.append("noMohonValue", $('#noMohonValue').val());

           $.ajax({
               url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/SaveAndUploadFilePenilaianHarga") %>',
               data: formData,
               cache: false,
               contentType: false,
               type: 'POST',
               processData: false,
               success: function (response) {
                   console.log("Ajax request successful");
                   showModalLampiran("Berjaya Simpan", "Fail berjaya disimpan di pangkalan data.");
                   tblUpload.ajax.reload();
                   //tblLampiran.ajax.reload();
               },
               error: function () {
                   console.log("Ajax request failed");
                   showModalLampiran("Tidak Berjaya Simpan", "Sila cuba simpan semula.");

               }
           });

       }

       $("#tblTeknikalUpload").off('click', '.btnView').on("click", ".btnView", function (event) {
           var data = tblUpload.row($(this).parents('tr')).data();
           var fileName = data.Nama_Fail;
           var noMohonValue = $('#noMohonValue').val();

           // Call a function to open the PDF in a new tab
           openPDFInNewTab(fileName, noMohonValue);
       });

       function openPDFInNewTab(fileName, noMohonValue) {
           var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/PEROLEHAN/PENILAIAN_HARGA/") %>' + noMohonValue + '/' + fileName;
           window.open(pdfPath, '_blank');
       }

   </script>     
</asp:Content>