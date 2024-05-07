<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="LOKASI.aspx.vb" Inherits="SMKB_Web_Portal.LOKASI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <script type="text/javascript">
       function ShowPopup(elm) {
           if (elm == "1") {
               $('#permohonan').modal('toggle');
               
           }
           else if (elm == "2") {
               $('#permohonan2').modal('toggle');
               $('#txtTarikhStart').val("");
               $('#txtTarikhEnd').val("");
               $('#divDatePicker').removeClass("d-flex").addClass("d-none");
               $('#categoryFilter').val("");
               $('.btnSearch').click();
               $('.btnEmel').show();
               $('.btnCetak').show();
           } else if (elm == "3") {
               $('#permohonanAdd').modal('toggle');
               $('#txtTarikhStart').val("");
               $('#txtTarikhEnd').val("");
               $('#divDatePicker').removeClass("d-flex").addClass("d-none");
               $('#categoryFilter').val("");
               $('.btnSearch').click();
               $('.btnEmel').show();
               $('.btnCetak').show();
           } else if (elm == "4") {
               $('#permohonan2Add').modal('toggle');
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
       .disabled-dropdown {
    background-color: #f2f2f2; /* Change to the desired color */
    color: #808080; /* Change to the desired color */
    cursor: not-allowed;
}
      #kodLokasi1 {
      background-color: #f2f2f2; /* Set background color to grey */
      }
      #kodLokasi3 {
      background-color: #f2f2f2; /* Set background color to grey */
      }
      #KodLokasiDetail1 {
      background-color: #f2f2f2; /* Set background color to grey */
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

            .input-group_input:not(:placeholder-shown) + label, .input-group_input:focus + label {
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
   <!------------------------------------------------------------------- STYLE START -------------------------------------------------------------------------->
   <!------------------------------------------------------------------- STYLE START -------------------------------------------------------------------------->
   <contenttemplate>
      <!------------------------------------------------------------------- CODE START --------------------------------------------------------------------------->
      <div id="PermohonanTab" class="tabcontent" style="display: block">
         <ul class="nav nav-tabs" id="myTab">
            <li class="nav-item">
               <a class="nav-link active text-uppercase" data-toggle="tab" href="#spesifikasi-am">SENARAI LOKASI</a>
            </li>
            <li class="nav-item" role="presentation">
               <a class="nav-link text-uppercase" data-toggle="tab" href="#bajet-dan-spesifikasi">SENARAI LOKASI DETAIL</a>
            </li>
         </ul>
         <div class="tab-content" id="myTabContent">
            <!-- ~~~ TAB 1 START ~~~-->
            <div class="tab-pane fade show active" id="spesifikasi-am" role="tabpanel">
               <div class="modal-body">
                  <div class="modal-body">
                     <div class="table-title">
                        <h6>Senarai Lokasi</h6>
                        <div id="btnTambah" class="btn btn-primary" onclick="ShowPopup('3')">
                           <i class="fa fa-plus"></i>Tambah Lokasi
                        </div>
                     </div>
                     <div class="modal-body">
                        <div class="col-md-12">
                           <div class="transaction-table table-responsive">
                              <span style="display: inline-block; height: 100%;"></span>
                               <table id="tblLokasi" class="table table-striped">
                                   <thead>
                                       <tr>
                                           <th scope="col" style="text-align: center;">Bil</th>
                                           <th scope="col" style="text-align: center;">Kod Lokasi</th>
                                           <th scope="col" style="text-align: center;">Butiran</th>
                                           <th scope="col" style="text-align: center;">Pejabat</th>
                                           <th scope="col" style="text-align: center;">Kategori Stor</th>
                                           <th scope="col" style="text-align: center;">Status</th>
                                       </tr>
                                   </thead>
                                   <tbody id="" onclick="ShowPopup('1')">
                                       <tr style="width: 100%" class="table-list">
                                           <td style="width: 5%; text-align: center;"></td>
                                           <td style="width: 10%; text-align: center;"></td>
                                           <td style="width: 30%; text-align: center;"></td>
                                           <td style="width: 30%; text-align: center;"></td>
                                           <td style="width: 10%; text-align: center;"></td>
                                           <td style="width: 10%; text-align: center;"></td>
                                       </tr>
                                   </tbody>
                               </table>

                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <!-- ~~~ TAB 1 END   ~~~-->
            <!-- ~~~ TAB 2 START ~~~-->
            <div class="tab-pane fade" id="bajet-dan-spesifikasi" role="tabpanel" > 
               <div class="modal-body">
                  <div class="modal-body">
                     <div class="table-title">
                        <h6>Senarai Lokasi Detail</h6>
                        <div id="btnTambah2" class="btn btn-primary" onclick="ShowPopup('4')">
                           <i class="fa fa-plus"></i>Tambah Lokasi Detail
                        </div>
                     </div>
                     <div class="modal-body">
                        <div class="col-md-12">
                           <div class="transaction-table table-responsive" style="width: 100%;">
                              <table id="tblLokasi2" class="table table-striped" style="width: 100%;">
                                 <thead>
                                    <tr>
                                       <th scope="col" style="width: 5%;">Bil</th>
                                       <th scope="col" style="width: 20%;">Kod Lokasi</th>
                                       <th scope="col" style="width: 30%;">Kod Lokasi Detail</th>
                                       <th scope="col" style="width: 30%;">Butiran</th>
                                       <th scope="col" style="width: 15%;">Status</th>
                                    </tr>
                                 </thead>
                                 <tbody id="" onclick="ShowPopup('2')" style="width: 100%;">
                                    <tr class="table-list">
                                       <td style="width: 5% ; text-align: center;"></td>
                                       <td style="width: 20%; text-align: center;"></td>
                                       <td style="width: 30%; text-align: center;"></td>
                                       <td style="width: 30%; text-align: center;"></td>
                                       <td style="width: 15%; text-align: center;"></td>
                                    </tr>
                                 </tbody>
                              </table>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <!-- ~~~ TAB 2 END   ~~~-->
         </div>
         <!-- ~~~ Modal 1 EDIT START ~~~-->
         <div class="modal fade bd-example-modal-md" id="permohonan" tabindex="-1" role="document"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
               <div class="modal-content modal-md">
                  <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title"">Maklumat Lokasi</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                     </div>
                      <div class="modal-body">
                          <div class="row">
                              <div class="col-md-12">
                                  <div class="form-row">
                                      <div class="form-group col-md-6">
                                          <input class="input-group__input" id="kodLokasi1" placeholder="&nbsp;" name="Kod" readonly />
                                          <label class="input-group__label" for="Kod">Kod Lokasi</label>
                                      </div>
                                      <%--<div class="form-group col-md-6">
                                        <select class="ui search dropdown pejabatLokasi" name="pejabatLokasi" id="pejabatLokasi1"></select>
                                     </div>--%>
                                      <div class="form-group col-md-6">
                                          <div class="form-group input-group">
                                              <select class="input-group__select ui search dropdown" placeholder="" name="pejabatLokasi" id="pejabatLokasi1">
                                              </select>
                                              <label class="input-group__label" for="pejabatLokasi1">PTJ<span style="color: red">*</span></label>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                              <div class="col-md-12">
                                  <div class="form-row">
                                      <div class="form-group col-md-6">
                                          <input class="input-group__input" id="butiranLokasi1" placeholder="&nbsp;" name="butiranLokasi" />
                                          <label class="input-group__label" for="butiranLokasi">Butiran</label>
                                      </div>
                                      <div class="form-group col-md-6">
                                          <div class="form-group input-group">
                                              <select class="input-group__select ui search dropdown" placeholder="" name="kategoriStor" id="kategoriStor">
                                              </select>
                                              <label class="input-group__label" for="kategoriStor">Kategori Stor<span style="color: red">*</span></label>
                                          </div>
                                      </div>
                                      <%--<div class="form-group col-md-6">
                                        <select class="ui search dropdown kategoriStor" name="kategoriStor" id="kategoriStor"></select>
                                     </div>--%>
                                  </div>
                              </div>
                              <div class="form-group col-md-12">
                                  <label>Status</label>
                                  <div class="radio-btn-form" id="rdstatusBarang" name="rdAktif">
                                      <div class="form-check form-check-inline radio-size">
                                          <input type="radio" id="rdYa" name="inlineRadioOptions"
                                              value="1" />&nbsp; Aktif
                                      </div>
                                      <div class="form-check form-check-inline radio-size">
                                          <input type="radio" id="rdTidak"
                                              name="inlineRadioOptions" value="0" />&nbsp; Tidak
                                      </div>
                                  </div>
                              </div>
                          </div>
                          <div align="right">
                              <button type="button" class="btn btn-danger btnPadam" data-dismiss="modal">Tutup</button>
                              <button type="button" class="btn btn-secondary btnSimpan" id="btnSimpan"
                                  data-toggle="tooltip" data-placement="bottom" data-dismiss="modal"
                                  title="Draft">
                                  Simpan</button>
                          </div>
                      </div>
               </div>
            </div>
         </div>
             </div>
         <!-- ~~~ Modal 1 EDIT END   ~~~ -->
         <!-- ~~~ Modal 1 ADD START ~~~-->
         <div class="modal fade bd-example-modal-md" id="permohonanAdd" tabindex="-1" role="document"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
               <div class="modal-content modal-md">
                  <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title"">Maklumat Lokasi</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                     </div>
                     <div class="modal-body">
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                  <div class="form-group col-md-6">
                                      <div class="form-group input-group">
                                          <select class="input-group__select ui search dropdown" placeholder="" name="kategoriStor2" id="kategoriStor2">
                                          </select>
                                          <label class="input-group__label" for="kategoriStor2">Kategori Stor<span style="color: red">*</span></label>
                                      </div>
                                  </div>
                                  <div class="form-group col-md-6">
                                      <div class="form-group input-group">
                                          <select class="input-group__select ui search dropdown" placeholder="" name="pejabatLokasi" id="pejabatLokasi2">
                                          </select>
                                          <label class="input-group__label" for="pejabatLokasi2">PTJ<span style="color: red">*</span></label>
                                      </div>
                                  </div>
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-12">
                                    <input class="input-group__input" id="butiranLokasi2" placeholder="&nbsp;" name="butiranLokasi2" />
                                    <label class="input-group__label" for="butiranLokasi2">Butiran</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                         <%--<div class="form-group col-md-12">
                             <label>Status</label>
                             <div class="radio-btn-form" id="rdstatusBarang2" name="rdAktif">
                                 <div class="form-check form-check-inline radio-size">
                                     <input type="radio" id="rdYa2" name="inlineRadioOptions"
                                         value="1" checked/>&nbsp; Aktif
                                 </div>
                                 <div class="form-check form-check-inline radio-size">
                                     <input type="radio" id="rdTidak2"
                                         name="inlineRadioOptions" value="0" />&nbsp; Tidak
                                 </div>
                             </div>
                         </div>--%>
                         <div class="form-group col-md-12">
                             <label>Status</label>
                             <div class="radio-btn-form" id="rdstatusBarang2" name="rdAktif">
                                 <div class="form-check form-check-inline radio-size">
                                     <input type="radio" id="rdYa2" name="inlineRadioOptions"
                                         value="1" checked />&nbsp; Aktif 
                                 </div>
                                 <div class="form-check form-check-inline radio-size">
                                     <input type="radio" id="rdTidak2"
                                         name="inlineRadioOptions" value="0" />&nbsp; Tidak
                                 </div>
                             </div>
                         </div>
                         <div align="right">
                           <button type="button" class="btn btn-danger btnPadam" data-dismiss="modal">Tutup</button>
                           <button type="button" class="btn btn-secondary btnSimpan2" id="btnSimpan2"
                              data-toggle="tooltip" data-placement="bottom" data-dismiss="modal"
                              title="Draft">
                           Simpan</button>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 1 ADD END   ~~~ -->
         <!-- ~~~ Modal 2 EDIT START ~~~-->
         <div class="modal fade bd-example-modal-md" id="permohonan2" tabindex="-1" role="document"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
               <div class="modal-content modal-md">
                  <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title"">Maklumat Lokasi Detail</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                     </div>
                     <div class="modal-body">
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="kodLokasi3" placeholder="&nbsp;" name="Kod" readonly />
                                    <label class="input-group__label" for="Kod">Kod Lokasi </label>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" id="KodLokasiDetail1" placeholder="&nbsp;" name="Kod" />
                                    <label class="input-group__label" for="Kod">Kod Lokasi Detail</label>
                                 </div>
                              </div>
                               <div class="form-row">
                                 <div class="form-group col-md-12">
                                    <input class="input-group__input" id="butiranLokasi3" placeholder="&nbsp;" name="butiranLokasi" />
                                    <label class="input-group__label" for="butiranLokasi">Butiran</label>
                                 </div>
                              </div>
                           </div>
                        </div>
                        <div class="form-group col-md-12">
                           <label>Status</label>
                           <div class="radio-btn-form" id="rdstatusBarang3" name="rdAktif">
                              <div class="form-check form-check-inline radio-size">
                                 <input type="radio" id="rdYa3" name="inlineRadioOptions"
                                    value="1" />&nbsp; Aktif
                              </div>
                              <div class="form-check form-check-inline radio-size">
                                 <input type="radio" id="rdTidak3"
                                    name="inlineRadioOptions" value="0" />&nbsp; Tidak
                              </div>
                           </div>
                        </div>
                        <div align="right">
                           <button type="button" class="btn btn-danger btnPadam" data-dismiss="modal">Tutup</button>
                           <button type="button" class="btn btn-secondary btnSimpan3" id="btnSimpan3"
                              data-toggle="tooltip" data-placement="bottom" data-dismiss="modal"
                              title="Draft">
                           Simpan</button>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 2 EDIT END   ~~~ -->
         <!-- ~~~ Modal 2 ADD START ~~~-->
         <div class="modal fade bd-example-modal-md" id="permohonan2Add" tabindex="-1" role="document"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-md" role="document">
               <div class="modal-content modal-md">
                  <div class="modal-content">
                     <div class="modal-header">
                        <h5 class="modal-title"">Maklumat Lokasi Detail</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                        </button>
                     </div>
                     <div class="modal-body">
                        <div class="row">
                           <div class="col-md-12">
                              <div class="form-row">
                                  <div class="form-group col-md-12">
                                      <div class="form-group input-group">
                                          <select class="input-group__select ui search dropdown" placeholder="" name="kodLokasi4" id="kodLokasi4">
                                          </select>
                                          <label class="input-group__label" for="kodLokasi4">Kod Lokasi<span style="color: red">*</span></label>
                                      </div>
                                  </div><div class="form-group col-md-6">
                                    <input class="input-group__input" placeholder="&nbsp;" name="butiranLokasi" readonly />
                                    <label class="input-group__label" for="ddlJnsPnjmn">Kod Lokasi Detail<span style="color:red">*</span></label>
                                 </div>
                                 <div class="form-group col-md-6">
                                    <input class="input-group__input" placeholder="&nbsp;" name="Kod" />
                                    <label class="input-group__label" for="Kod">Kod Lokasi Detail</label>
                                 </div>
                              </div>
                               <div class="form-row">
                                   <div class="form-group col-md-12">
                                       <input class="input-group__input" id="butiranLokasi4" placeholder="&nbsp;" name="butiranLokasi" />
                                       <label class="input-group__label" for="butiranLokasi">Butiran</label>
                                   </div>
                               </div>
                           </div>
                        </div>
                        <div class="form-group col-md-12">
                           <label>Status</label>
                           <div class="radio-btn-form" id="rdstatusBarang4" name="rdAktif">
                              <div class="form-check form-check-inline radio-size">
                                 <input type="radio" id="rdYa4" name="inlineRadioOptions"
                                    value="1" checked/>&nbsp; Aktif 
                              </div>
                              <div class="form-check form-check-inline radio-size">
                                 <input type="radio" id="rdTidak4"
                                    name="inlineRadioOptions" value="0" />&nbsp; Tidak
                              </div>
                           </div>
                        </div>
                        <div align="right">
                           <button type="button" class="btn btn-danger btnPadam" data-dismiss="modal">Tutup</button>
                           <button type="button" class="btn btn-secondary btnSimpan4" id="btnSimpan4"
                              data-toggle="tooltip" data-placement="bottom" data-dismiss="modal"
                              title="Draft">
                           Simpan</button>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <!-- ~~~ Modal 2 ADD END   ~~~ -->
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
      <!------------------------------------------------------------------- CODE START --------------------------------------------------------------------------->
      <!------------------------------------------------------------------- SCRIPT START ------------------------------------------------------------------------->
      <script>
          // ---------------------- UNTUK TABLE1 START -----------------------
          var tbl11 = null;
          var isClicked6 = false;
          var shouldPop = true;

          $(document).ready(function () {
              show_loader();
              tbl11 = $("#tblLokasi").DataTable({

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
                      url: 'Lokasi_WS.asmx/LoadLokasiData',
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

                          $("#kodLokasi1").val(rowData.KodLokasi);
                          $("#butiranLokasi1").val(rowData.Butiran);

                          buildDdl("pejabatLokasi1", rowData.Kod_Ptj, rowData.Pejabat);
                          buildDdl("kategoriStor", rowData.Kat_Stor, rowData.ButiranKategoriStor);
                          console.log(rowData.KodPejabat)
                          
                          if (rowData.Status === '1') {
                              $('#rdYa').prop('checked', true);
                              $('#rdTidak').prop('checked', false);
                          } else if (rowData.Status === '0') {
                              $('#rdYa').prop('checked', false);
                              $('#rdTidak').prop('checked', true);
                          }
                      });
                  },
                  "columns": [
                      {
                          "data": "Bil",
                          "render": function (data, type, row, meta) {
                              return meta.row + meta.settings._iDisplayStart + 1;
                          },
                          "width": "5%",
                          "className": "dt-center"
                      },
                      {
                          "data": "KodLokasi",
                          "width": "10%",
                          "className": "dt-center"
                      },
                      {
                          "data": "Butiran",
                          "width": "20%",
                      },
                      {
                          "data": "Pejabat",
                          "width": "20%",
                      },
                      {
                          "data": "ButiranKategoriStor",
                          "width": "20%",
                          "className": "dt-center"
                      },
                      {
                          "data": "Status",
                          "render": function (data) {
                              if (data == 1) {
                                  return 'Aktif';
                              } else if (data == 0) {
                                  return 'Tak Aktif';
                              } else {
                                  return 'Data Error';
                              }
                          },
                          "width": "10%",
                          "className": "dt-center"
                      }
                  ]

              });

              $('.btnSearch').click(async function () {
                  isClicked6 = true;

                  tbl11.ajax.reload();
              })

              close_loader();
          });
          // ---------------------- UNTUK TABLE1 END -------------------------
          // ---------------------- UNTUK TABLE2 START -----------------------
          var tbl12 = null;
          var isClicked5 = false;
          var shouldPop = true;

          $(document).ready(function () {
              tbl12 = $("#tblLokasi2").DataTable({
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
                      url: 'Lokasi_WS.asmx/LoadLokasiData2',
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
                              isClicked5: isClicked6,
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

                          $("#kodLokasi3").val(rowData.KodLokasi2);
                          $('#kodLokasi4')
                              .dropdown('setup menu', {
                                  values: [
                                      {
                                          value: rowData.Kod_Lokasi,
                                          text: rowData.Kod_Lokasi,
                                      }
                                  ]
                              })
                              .dropdown('set selected', rowData.Kod_Lokasi)

                          $("#KodLokasiDetail1").val(rowData.KodLokasiDetail2);
                          $("#butiranLokasi3").val(rowData.Butiran2);

                          if (rowData.Status2 === '1') {
                              $('#rdYa3').prop('checked', true);
                              $('#rdTidak3').prop('checked', false);
                          } else if (rowData.Status2 === '0') {
                              $('#rdYa3').prop('checked', false);
                              $('#rdTidak3').prop('checked', true);
                          }
                      });
                  },
                  "columns": [
                      {
                          "data": "Bil",
                          "render": function (data, type, row, meta) {
                              return meta.row + meta.settings._iDisplayStart + 1;
                          },
                          "className": "dt-center"
                      },
                      {
                          "data": "KodLokasi2",
                          "className": "dt-center"
                      },
                      {
                          "data": "KodLokasiDetail2",
                          "className": "dt-center"
                      },
                      {
                          "data": "Butiran2",
                      },
                      {
                          "data": "Status2",
                          "render": function (data) {
                              if (data == 1) {
                                  return 'Aktif';
                              } else if (data == 0) {
                                  return 'Tak Aktif';
                              } else {
                                  return 'Data Error';
                              }
                          },
                          "className": "dt-center"
                      }
                  ]

              });

              $('.btnSearch').click(async function () {
                  isClicked5 = true;

                  tbl12.ajax.reload();

                  
              })
              close_Loader();
          });
          // ---------------------- UNTUK TABLE2 END -------------------------
          // ---------------------- UNTUK DROPDOWN INSERT START --------------
          var shouldPop = true;
          $(document).ready(function () {
              generateDropdown("pejabatLokasi1", "Lokasi_WS.asmx/GetLokasiPejabat", "Pejabat", false, null);
              generateDropdown("pejabatLokasi2", "Lokasi_WS.asmx/GetLokasiPejabat2", "Pejabat", false, null);
              generateDropdown("kategoriStor", "Lokasi_WS.asmx/GetKategoriStor", "Kategori", false, null);
              generateDropdown("kategoriStor2", "Lokasi_WS.asmx/GetKategoriStor", "Kategori", false, null, function () {
                  // Add change event listener to kategoriStor2 dropdown
                  $('#kategoriStor2').dropdown('setting', 'onChange', function (value, text, $selectedItem) {
                      if ($selectedItem.index() == 0) {
                          // Disable the pejabatLokasi2 dropdown
                          buildDdl('pejabatLokasi2', '50', 'BERPUSAT');
                          $('#pejabatLokasi2').parent().addClass('disabled');
                          $('#pejabatLokasi2').parent().parent().addClass('disabled-dropdown'); // Add this line
                      } else {
                          // Enable the pejabatLokasi2 dropdown
                          $('#pejabatLokasi2').parent().removeClass('disabled');
                          $('#pejabatLokasi2').removeClass('disabled-dropdown'); // Add this line
                      }
                  });
              });
              $('#kategoriStor2').trigger('change');
              generateDropdown("kodLokasi4", "Lokasi_WS.asmx/GetkodLokasi", "Kod Lokasi", false, null);
              /generateDropdown("id", "path", "place holder", "flag send data to web services or either", "parent dropdown (dependable)","function after ajax success");/
          });
          // ---------------------- UNTUK DROPDOWN INSERT END ---------------
          // ---------------------- UNTUK DROPDOWN DETAIL START -------------
          async function generateDropdown(id, url, plchldr, send2ws, sendData, fn) {

              var param = '';
              (sendData !== null && sendData !== undefined) ? param = '' : param = '?q={query}';

              $('#' + id).dropdown({
                  fullTextSearch: true,
                  placeholder: plchldr,
                  apiSettings: {
                      url: url + param,
                      method: 'POST',
                      dataType: "json",
                      contentType: 'application/json; charset=utf-8',
                      cache: false,
                      //onChange: function (value, text, $selectedItem) {
                      //    if (fn !== null && fn !== undefined) {
                      //        return fn();
                      //    }
                      //},
                      beforeSend: function (settings) {
                          if (send2ws) {
                              settings.data = JSON.stringify({
                                  q: settings.urlData.query,
                                  data: $('#' + sendData).val()
                              });
                              searchQuery = settings.urlData.query;
                              return settings;
                          } else {
                              // Replace {query} placeholder in data with user-entered search term
                              settings.data = JSON.stringify({ q: settings.urlData.query });
                              searchQuery = settings.urlData.query;
                              return settings;
                          }
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

                          if (fn !== null && fn !== undefined) {
                              fn();
                          }
                          
                          /dependable ddl if sendata value == empty clear all option/
                          if (sendData !== null && sendData !== undefined) {
                              var tempDt = $('#' + sendData).val();
                              if (tempDt == null && tempDt == undefined) {
                                  $('#' + id + ' .dropdown').addClass("disableDdlIcon");
                                  return false;
                              }
                          }

                          //if (searchQuery !== oldSearchQuery) {
                          //$(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
                          //}

                          //oldSearchQuery = searchQuery;

                          // Refresh dropdown
                          $(obj).dropdown('refresh');

                          if (shouldPop === true) {
                              $(obj).dropdown('show');
                          }
                      }
                  }
              });
          }
          // ---------------------- UNTUK DROPDOWN DETAIL END ---------------
          // ---------------------- UNTUK EDIT START ------------------------
          $('.btnSimpan').off('click').on('click', async function () {
              var msg = "";

              var msg = "Anda pasti ingin bersetuju?";
              $('#confirmationMessage1').text(msg);
              $('#saveConfirmationModal1').modal('show');

              $('#confirmSaveButton1').off('click').on('click', async function () {
                  $('#saveConfirmationModal1').modal('hide');

                  var statusValue = $("input[name='inlineRadioOptions']:checked").val();
                  var newPengesahan = {
                      mohonPengesahan: {
                          kodLokasiPengesahan: $('#kodLokasi1').val(),
                          pejabatLokasiPengesahan: $('#pejabatLokasi1').val(),
                          butiranLokasiPengesahan: $('#butiranLokasi1').val(),
                          kategoriStorPengesahan: $('#kategoriStor').val(),
                          statusLokasiPengesahan: statusValue,
                      }
                  }
                  console.log(newPengesahan)
                  var result = JSON.parse(await ajaxSavePengesahan1(newPengesahan));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                      //show_loader();
                      tbl11.ajax.reload();
                      close_loader();
                  }
                  else {
                      showModal1("Error", result.Message, "error");
                  }
              });
          });

          function buildDdl(id, kodVal, txtVal) {
              debugger;
              if (kodVal && txtVal) {
                  $("#" + id).dropdown('set selected', kodVal);
                  $("#" + id).html("<option value = '" + kodVal + "'>" + txtVal + "</option>");
              }
          }

          async function ajaxSavePengesahan1(mohonPengesahan) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'Lokasi_WS.asmx/Save_Pengesahan1',
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
          // ---------------------- UNTUK EDIT END --------------------------
          // ---------------------- UNTUK ADD START -------------------------
          $('.btnSimpan2').off('click').on('click', async function () {
              var msg = "";

              var msg = "Anda pasti ingin bersetuju?";
              $('#confirmationMessage1').text(msg);
              $('#saveConfirmationModal1').modal('show');

              $('#confirmSaveButton1').off('click').on('click', async function () {
                  $('#saveConfirmationModal1').modal('hide');

                  var statusValue = $("input[name='inlineRadioOptions']:checked").val();
                  var newPengesahan = {
                      mohonPengesahan: {
                          kodLokasiPengesahan: $('#kodLokasi2').val(),
                          pejabatLokasiPengesahan: $('#pejabatLokasi2').val(),
                          butiranLokasiPengesahan: $('#butiranLokasi2').val(),
                          kategoriStorPengesahan: $('#kategoriStor2').val(),
                          statusLokasiPengesahan: statusValue,
                      }
                  }
                  var result = JSON.parse(await ajaxSavePengesahahahahahaha(newPengesahan));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                      //show_loader();
                      tbl11.ajax.reload();
                      close_loader(); // Refresh the page
                  }
                  else {
                      showModal1("Error", result.Message, "error");
                  }
              });
          });


          async function ajaxSavePengesahahahahahaha(mohonPengesahan) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'Lokasi_WS.asmx/Save_Pengesahan2',
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
          // ---------------------- UNTUK ADD END ---------------------------
          // ---------------------- UNTUK EDIT2 START ------------------------
          $('.btnSimpan3').off('click').on('click', async function () {
              var msg = "";

              var msg = "Anda pasti ingin bersetuju?";
              $('#confirmationMessage1').text(msg);
              $('#saveConfirmationModal1').modal('show');

              $('#confirmSaveButton1').off('click').on('click', async function () {
                  $('#saveConfirmationModal1').modal('hide');

                  var statusValue = $("input[name='inlineRadioOptions']:checked").val();
                  var newPengesahan = {
                      mohonPengesahan: {
                          kodLokasiPengesahan: $('#kodLokasi3').val(),
                          KodLokasiDetailPengesahan: $('#KodLokasiDetail1').val(),
                          butiranLokasiPengesahan: $('#butiranLokasi3').val(),
                          statusLokasiPengesahan: statusValue,
                      }
                  }
                  console.log(newPengesahan)
                  var result = JSON.parse(await ajaxSavePengesahan3(newPengesahan));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                      //show_loader();
                      tbl11.ajax.reload();
                      close_loader();
                  }
                  else {
                      showModal1("Error", result.Message, "error");
                  }
              });
          });

          async function ajaxSavePengesahan3(mohonPengesahan) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'Lokasi_WS.asmx/Save_Pengesahan3',
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
          // ---------------------- UNTUK EDIT2 END --------------------------
          // ---------------------- UNTUK ADD2 START -------------------------
          $('.btnSimpan4').off('click').on('click', async function () {
              var msg = "";

              var msg = "Anda pasti ingin bersetuju?";
              $('#confirmationMessage1').text(msg);
              $('#saveConfirmationModal1').modal('show');

              $('#confirmSaveButton1').off('click').on('click', async function () {
                  $('#saveConfirmationModal1').modal('hide');

                  var statusValue = $("input[name='inlineRadioOptions']:checked").val();
                  var newPengesahan = {
                      mohonPengesahan: {
                          kodLokasiPengesahan: $('#kodLokasi4').val(),
                          butiranLokasiPengesahan: $('#butiranLokasi4').val(),
                          statusLokasiPengesahan: statusValue,
                      }
                  }
                  var result = JSON.parse(await ajaxSavePengesahahahahahaha2(newPengesahan));

                  if (result.Status === true) {
                      showModal1("Success", result.Message, "success");
                      //show_loader();
                      tbl11.ajax.reload();
                      close_loader(); // Refresh the page
                  }
                  else {
                      showModal1("Error", result.Message, "error");
                  }
              });
          });


          async function ajaxSavePengesahahahahahaha2(mohonPengesahan) {
              return new Promise((resolve, reject) => {
                  $.ajax({
                      url: 'Lokasi_WS.asmx/Save_Pengesahan4',
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
          // ---------------------- UNTUK ADD2 END ---------------------------
          document.addEventListener("DOMContentLoaded", function () {
              var tutupButton = document.querySelector('#resultModal1 .modal-footer .btn-secondary');

              tutupButton.addEventListener('click', function () {
                  var activeTab = document.querySelector('.nav.nav-tabs .nav-link.active');

                  var activeTabHref = activeTab.getAttribute('href');
                  window.location.href = window.location.origin + window.location.pathname + activeTabHref;

              });
          });
      </script>
      <!------------------------------------------------------------------- SCRIPT END ------------------------------------------------------------------------->
   </contenttemplate>
</asp:Content>