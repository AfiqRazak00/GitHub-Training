<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Kelulusan_KB.aspx.vb" Inherits="SMKB_Web_Portal.Kelulusan_KB" %>

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
            background-color:#ffc83d !important;
        }

        #tblDataSenarai_trans td:hover {
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
            color: white;
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
            font-size: 12PX;
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
          
            line-height: 10px;
            color: #01080D;
            opacity: 1;
        }
   </style>


    <div id="PermohonanTab" class="tabcontent" style="display: block">

        <!-- Modal -->
        <div id="permohonan">
            <div >
                <div class="modal-content" >
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Permohonan Bajet</h5>

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
                      
                    <div class="body-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataSenarai_trans" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr>                                          
                                            <th scope="col">No. Mohon</th>
                                            <th scope="col">Program</th>
                                            <th scope="col">Justifikasi</th>
                                            <th scope="col">Jumlah (RM)</th>
                                            <th scope="col">Tarikh Transaksi</th>
                                            <th scope="col">Status</th>                                            

                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_trans" style="cursor:pointer">
                                    </tbody>

                                </table>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
     

        <div class="modal fade" id="transaksi" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header modal-header--sticky">
                            <h5 class="modal-title">Papar Permohonan Bajet</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">          
                <div class="col-md-12">
                    <div class="form-row">
                         <label id="Hid-ptj-list" name="Hid-ptj-list" class="Hid-ptj-list" style="display: none;"></label>
                        <div class="form-group col-md-3">
                        <input class="input-group__input" id="lblNoMohon" type="text" placeholder="&nbsp;" name="No. Mohon"  readonly style="background-color: #f0f0f0"/>
                        <label class="input-group__label" for="No. Mohon">No. Mohon</label>
                        </div>

              
                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="txtTarikh" type="text" placeholder="&nbsp;" name="Tarikh Transaksi" readonly style="background-color: #f0f0f0"/>
                        <label class="input-group__label" for="Tarikh Mohon">Tarikh Mohon</label>
                        </div>

                        <div class="form-group col-md-6" ">
                            <input class="input-group__input" id="txtPTJ" type="text" placeholder="&nbsp;" name="PTj/PBU" readonly style="background-color: #f0f0f0"/>
                            
                        <label class="input-group__label" for="PTJ">PTj/PBU</label>
                        </div>

                    </div>
                </div>

                <div class="col-md-12" style="margin-top:5px">
                    <div class="form-row">

                        <div class="form-group col-md-3">
                        <select class="input-group__select ui search dropdown" name="ddlBahagian" id="ddlBahagian" placeholder="&nbsp;" >
                                </select>
                                <label class="input-group__label" for="ddlBahagian">Bahagian</label>
                        </div>

                        <div class="form-group col-md-3">
                         <select class="input-group__select ui search dropdown ListUnit" name="ddlUnit" id="ddlUnit" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlUnit">Unit</label>
                        </div>

                        <div class="form-group col-md-6">
                          <select class="input-group__select ui search dropdown ListPTJPusat" name="ddlPTJPusat" id="ddlPTJPusat" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlPTJPusat">Bajet PTJ Berpusat (Sekiranya Ada)</label>
                        </div>
             </div>
                </div>
                <div class="col-md-12" style="margin-top: 5px">
                    <div class="form-row">                         
                        <div class="form-group col-md-3">
                        <select class="input-group__select ui search dropdown ListKW" name="ddlKW" id="ddlKW" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlKW">Kumpulan Wang</label>
                        </div>
                        <div class="form-group col-md-3">
                        <select class="input-group__select ui search dropdown ListOperasi" name="ddlKO" id="ddlKO" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlKO">Kod Operasi</label>
                        </div>
                        <div class="form-group col-md-3">
                        <select class="input-group__select ui search dropdown ListKp" name="ddlKP" id="ddlKP" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlKP">Kod Projek</label>
                        </div>
                        <div class="form-group col-md-3">
                        <select class="input-group__select ui search dropdown ListDasar" name="ddlDasar" id="ddlDasar" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlDasar">Dasar</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-12" style="margin-top: 5px">
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <textarea class="input-group__input" id="txtProgram" type="text" rows="2" placeholder="&nbsp;" name="Program / Aktiviti"></textarea><label class="input-group__label" for="Program / Aktiviti">Program / Aktiviti</label>
                        </div>
                    </div>
                </div>
                 <div class="col-md-12" style="margin-top: 5px">
                    <div class="form-row">
                        <div class="form-group col-md-12">
                             <textarea class="input-group__input " id="txtJustifikasi" type="text" placeholder="&nbsp;" name="Justifikasi"></textarea>
                        <label class="input-group__label" for="Justifikasi">Justifikasi</label>
                        </div>
                    </div>
                </div>
            </div>


                            <hr>
                            <div class="form-row">

   <h6>Butiran Permohonan</h6>

        <div class="secondaryContainer transaction-table table-responsive">

            <table  id="tblData"  class="table table-striped">
                        <thead>
                            <tr>
                                <th scope="col">Vot</th>                             
                                <th scope="col">Butiran</th>
                               <%-- <th scope="col">Dokumen (PDF)</th>--%>
                                <th scope="col">Jumlah (RM)</th>
                              <%--  <th scope="col">Tindakan</th>--%>

                            </tr>
                        </thead>
                        <tbody id="tableID">
                            <tr style="display: none; width: 100%" class="table-list">
                                <td style="width: 20%">
                                    <select class="ui search dropdown ObjAm-list" name="ddlObjAm" id="ddlObjAm"></select>
                                    <input type="hidden" class="data-id" value="" />
                                    <label id="hidObgAm" name="hidObjAm" class="Hid-objAm-list" style="display: none;"></label>
                                </td>
                              
                                <td style="width: 45%">
                                    <input id="Butiran" name="Butiran" runat="server" type="text" class="form-control underline-input Butiran" style="text-align: left" width="60%" />
                                </td>
                              <%-- <td style="width: 26%">
                                    <input id="UploadDok" name="UploadDok" runat="server" type="file" class="form-control underline-input UploadDok" style="text-align: left" width="60%" />
                                </td>--%>
                                <td style="width: 10%">
                                    <input id="Jumlah" name="Jumlah" runat="server" type="number" class="form-control underline-input Jumlah" style="text-align: right" width="10%" value="0.00" /></td>
                               
                               <%-- <td style="width: 4%">
                                    <button id="lbtnCari" runat="server" class="btn btnDelete" type="button" style="color: red">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </td>--%>

                            </tr>
                        </tbody>
                        <tfoot class="sticky-footer">
                            <tr>
                                <td colspan="2"></td>
                                <td>
                                    <input class="form-control underline-input" id="totalJumlah" name="totalJumlah" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly /></td>
                                
                            </tr>
                            <tr>
                                <td colspan="1" style="text-align: left">
                                    <div class="btn-group" style="visibility:hidden">
                                        <button type="button" class="btn btn-warning btnAddRow One" data-val="1" value="1"><b>+ Tambah</b></button>
                                        <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                            <span class="sr-only">Toggle Dropdown</span>
                                        </button>
                                        <div class="dropdown-menu">
                                            <a class="dropdown-item btnAddRow five" value="5" data-val="5">Tambah 5</a>
                                            <a class="dropdown-item btnAddRow" value="10" data-val="10">Tambah 10</a>

                                        </div>
                                    </div>
                                </td>
                            </tr>

                        </tfoot>
                    </table>
        </div>
                                </div>
                            </div>
                                <div class="modal-footer modal-footer--sticky" style="padding:0px!important">
                                <%--<button type="button" class="btn btn-danger">Padam</button>
                                <button type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                                <button type="button" class="btn btn-success btnHantar" data-toggle="tooltip" data-placement="bottom" title="Simpan dan Hantar">Hantar</button>--%>
                                    <button type="button" class="btn btn-secondary btnReturn" data-toggle="tooltip" data-placement="bottom">Kembali Kepada Pemohon</button>
                                    <button type="button" class="btn btn-danger btnXLulus" data-toggle="tooltip" data-placement="bottom">Tidak Sokong</button>
                                    <button type="button" class="btn btn-success btnLulus" data-toggle="tooltip" data-placement="bottom">Sokong</button>
                                

                        </div>
                    </div>
                </div>
            </div>
        </div>
                   <!-- Confirmation Modal Hantar  -->
                <div class="modal fade" id="confirmationModal_Hantar" tabindex="-1" role="dialog"
                    aria-labelledby="confirmationModalLabelHantar" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmationModalLabel_Hantar">Pengesahan</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <span id="detailMakluman"></span>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger"
                                    data-dismiss="modal">Tidak</button>
                                <button type="button" class="btn default-primary btnYa_Hantar" runat="server" id="EmailJurnalLulus">Ya</button>
                            </div>
                        </div>
                    </div>
                </div>

                      <!-- Makluman Modal Bil -->
                <div class="modal fade" id="maklumanModalBil_Hantar" tabindex="-1" role="dialog"
                    aria-labelledby="maklumanModalLabelBil_Hantar" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="maklumanModalLabelBil_Hantar">Makluman</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <span id="detailMaklumanBil_Hantar"></span>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn default-primary" id="tutupMaklumanBil_Hantar"
                                    data-dismiss="modal">Tutup</button>
                            </div>
                        </div>
                    </div>
                </div>

                      <!-- Tidak Sokong Confirmation Modal Hantar  -->
                <div class="modal fade" id="confirmationModal_Hantar_X" tabindex="-1" role="dialog"
                    aria-labelledby="confirmationModalLabelHantar_X" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmationModalLabel_Hantar_X">Pengesahan</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <span id="detailMakluman_X"></span>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger"
                                    data-dismiss="modal">Tidak</button>
                                <button type="button" class="btn default-primary btnYa_Hantar_X" runat="server" id="Button1">Ya</button>
                            </div>
                        </div>
                    </div>
                </div>

                      <!-- Tidak Sokong Makluman Modal  -->
                <div class="modal fade" id="maklumanModalBil_Hantar_X" tabindex="-1" role="dialog"
                    aria-labelledby="maklumanModalLabelBil_Hantar_X" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="maklumanModalLabelBil_Hantar_X">Makluman</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <span id="detailMaklumanBil_Hantar_X"></span>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn default-primary" id="tutupMaklumanBil_Hantar_X"
                                    data-dismiss="modal">Tutup</button>
                            </div>
                        </div>
                    </div>
                </div>


                           <!-- Return Pemohon  Confirmation Modal Hantar  -->
                <div class="modal fade" id="confirmationModal_Hantar_Return" tabindex="-1" role="dialog"
                    aria-labelledby="confirmationModalLabelHantar_Return" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmationModalLabel_Hantar_Return">Pengesahan</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <span id="detailMakluman_Return"></span>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger"
                                    data-dismiss="modal">Tidak</button>
                                <button type="button" class="btn default-primary btnYa_Hantar_Return" runat="server" id="Button2">Ya</button>
                            </div>
                        </div>
                    </div>
                </div>

                      <!-- Return Pemohon Makluman Modal  -->
                <div class="modal fade" id="maklumanModalBil_Hantar_Return" tabindex="-1" role="dialog"
                    aria-labelledby="maklumanModalLabelBil_Hantar_X" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="maklumanModalLabelBil_Hantar_Return">Makluman</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <span id="detailMaklumanBil_Hantar_Return"></span>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn default-primary" id="tutupMaklumanBil_Hantar_Return"
                                    data-dismiss="modal">Tutup</button>
                            </div>
                        </div>
                    </div>
                </div>

        <script type="text/javascript">

            function ShowPopup(elm) {

                if (elm == "1") {

                    $('#transaksi').modal('toggle');


                }
                else if (elm == "2") {

                    $(".modal-body div").val("");
                    $('#transaksi').modal('toggle');

                }
            }

            var tbl = null
            var isClicked = false;
            $(document).ready(function () {

                tbl = $("#tblDataSenarai_trans").DataTable({
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
                        "url": "Awal_Tahun_WS.asmx/LoadOrderRecord_SenaraiMohonBajet_KB",
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
                                isClicked: isClicked,
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
                            rowClickHandler(data.No_Mohon);

                        });
                    },
                    "columns": [
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
                        { "data": "Program" },
                        { "data": "Justifikasi" },
                        { "data": "Jumlah", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "text-right" },
                        { "data": "Tkh_Transaksi" },
                        {
                            "data": "Kod_Status_Dok",
                            "className": "text-center",
                            render: function (data, type, row, meta) {

                                var link

                                if (data === "SELESAI KELULUSAN") {
                                    link = `<td style="width: 10%" >
                                                <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:blue;" >${data}</p>                                              
                                            </td>`;

                                }
                                else if (data === "GAGAL KELULUSAN") {
                                    link = `<td style="width: 10%" >
                                                <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:blue;" >${data}</p>                                              
                                            </td>`;

                                }
                                else {
                                    link = `<td style="width: 10%" >
                                                <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:red;" >${data}</p>                                              
                                            </td>`;
                                }


                                return link;
                            }
                        }



                    ]

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

            var searchQuery = "";
            var oldSearchQuery = "";
            var curNumObject = 0;
            var tableID = "#tblData";
            var tableID_Senarai = "#tblDataSenarai_trans";
            var shouldPop = true;
            var totalID = "#totalBeza";

            var totalDebit = "#totalDbt";
            var totalKredit = "#totalKt";

            var totalJumlah = "#totalJumlah";

            var objMetadata = [{
                "obj1": {
                    "id": "",
                    "oldSearchQurey": "",
                    "searchQuery": ""
                }
            }, {
                "obj2": {
                    "id": "",
                    "oldSearchQurey": "",
                    "searchQuery": ""
                }
            }]

            $(document).ready(function () {

                $('#ddlJenTransaksi').dropdown({
                    apiSettings: {
                        url: 'Transaksi_WS.asmx/GetJenisTransaksi?q={query}',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        beforeSend: function (settings) {
                            // Replace {query} placeholder in data with user-entered search term
                            settings.data = JSON.stringify({ q: settings.urlData.query });
                            searchQuery = settings.urlData.query;
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

                            //if (searchQuery !== oldSearchQuery) {
                            // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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
            });

            function initDDLKW() {
                $.ajax({
                    url: 'Awal_Tahun_WS.asmx/GetListKW?q={query}',
                    method: "POST",
                    data: JSON.stringify({
                        q: ''
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        data = JSON.parse(data.d)
                        let list = $('#ddlKW')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                       // $("#ddlKW").dropdown('clear');
                    }
                })
            }

            function initDDLKO() {
                $.ajax({
                    url: 'Awal_Tahun_WS.asmx/GetListKO?q={query}',
                    method: "POST",
                    data: JSON.stringify({
                        q: ''
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        data = JSON.parse(data.d)
                        let list = $('#ddlKO')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                        //$("#ddlKO").dropdown('clear');
                    }
                })
            }

            $(function () {
                $('.btnAddRow.five').click();
            });

            $('.btnHantar').click(async function () {
                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";
                var newOrder = {
                    order: {
                        OrderID: $('#lblNoMohon').val(),
                        Tarikh: $('#txtTarikh').val(),
                        PTJ: $('#Hid-ptj-list').html(),
                        Bahagian: $('#ddlBahagian').val(),
                        Unit: $('#ddlUnit').val(),
                        PTJPusat: $('#ddlPTJPusat').val(),
                        Dasar: $('#ddlDasar').val(),
                        KumpWang: $('#ddlKW').val(),
                        KodKO: $('#ddlKO').val(),
                        KodKP: $('#ddlKP').val(),
                        Program: $('#txtProgram').val(),
                        Justifikasi: $('#txtJustifikasi').val(),
                        Jumlah: $('#totalJumlah').val(),

                        OrderDetails: []
                    }

                }

                
                $('.ObjAm-list').each(function (index, obj) {

                    if (index > 0) {
                        var tcell = $(obj).closest("td");
                        //alert("ce;; "+tcell)
                        var orderDetail_Bajet = {
                            OrderID: $('#lblNoMohon').val(),
                            ddlObjAm: $(obj).dropdown("get value"),
                            Butiran: $('.Butiran').eq(index).val(),
                            Jumlah: $('.Jumlah').eq(index).val(),
                            id: $(tcell).find(".data-id").val()
                        };



                        //if (orderDetail.ddlPTJ === "" || orderDetail.ddlVot === "" || orderDetail.ddlKw === "" || orderDetail.ddlKo === "" || orderDetail.ddlKp === "" ||
                        //    orderDetail.debit === "" ||  orderDetail.kredit === "") {
                        //    return;
                        //}


                        acceptedRecord += 1;
                        newOrder.order.OrderDetails.push(orderDetail_Bajet);

                    }
                });
                //console.log(newOrder.order);

                //msg = "Anda pasti ingin menghantar " + acceptedRecord + " rekod ini?"

                //if (!confirm(msg)) {
                //    return false;
                //}

                var result = JSON.parse(await ajaxSubmitOrder(newOrder));
                alert(result.Message)
                //$('#orderid').val(result.Payload.OrderID)

                //loadExistingRecords();
                //await clearAllRows();
                // AddRow(5);

            });

            $('.btnLulus').click(async function () {
                //console.log("test")
                $('#detailMakluman').html("Anda pasti ingin menyokong permohonan ini?");
                $('#confirmationModal_Hantar').modal('toggle');
                


            });

            $('.btnYa_Hantar').click(async function () {
                $('#confirmationModal_Hantar').modal('hide');

                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";
                var newOrder = {
                    order: {
                        OrderID: $('#lblNoMohon').val(),
                        NoRujukan: $('#txtNoRujukan').val(),
                        Perihal: $('#txtPerihal').val(),
                        Tarikh: $('#txtTarikh').val()
                    }
                };

                var result = JSON.parse(await ajaxSaveOrderLulus(newOrder));
              
                if (result.Status !== false) {
                   
                    $('#maklumanModalBil_Hantar').modal('toggle');
                    $('#detailMaklumanBil_Hantar').html(result.Message);
                   // $('input[type="text"]').val(""); // Clearing text input fields

                    $('#transaksi').modal('toggle');
                    tbl.ajax.reload();

                    setTimeout(function () {
                        tbl.ajax.reload();
                    }, 2000);
                } else {
                    $('#maklumanModalBil_Hantar').modal('toggle');
                    $('#detailMaklumanBil_Hantar').html(result.Message);
                }
            });


            $('.btnXLulus').click(async function () {
                //console.log("test")
                $('#detailMakluman_X').html("Anda pasti tidak menyokong permohonan ini?");
                $('#confirmationModal_Hantar_X').modal('toggle');



            });

            $('.btnYa_Hantar_X').click(async function () {
                $('#confirmationModal_Hantar_X').modal('hide');

                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";
                var newOrder = {
                    order: {
                        OrderID: $('#lblNoMohon').val(),
                        NoRujukan: $('#txtNoRujukan').val(),
                        Perihal: $('#txtPerihal').val(),
                        Tarikh: $('#txtTarikh').val()
                    }
                };

                var result = JSON.parse(await ajaxSaveOrderXLulus(newOrder));

                if (result.Status !== false) {

                    $('#maklumanModalBil_Hantar_X').modal('toggle');
                    $('#detailMaklumanBil_Hantar_X').html(result.Message);
                    // $('input[type="text"]').val(""); // Clearing text input fields

                    $('#transaksi').modal('toggle');
                    tbl.ajax.reload();

                    setTimeout(function () {
                        tbl.ajax.reload();
                    }, 2000);
                } else {
                    $('#maklumanModalBil_Hantar_X').modal('toggle');
                    $('#detailMaklumanBil_Hantar_X').html(result.Message);
                }
            });


            $('.btnReturn').click(async function () {
                //console.log("test")
                $('#detailMakluman_Return').html("Anda pasti untuk kembalikan permohonan ini kepada pemohon?");
                $('#confirmationModal_Hantar_Return').modal('toggle');



            });

            $('.btnYa_Hantar_Return').click(async function () {
                $('#confirmationModal_Hantar_Return').modal('hide');

                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";
                var newOrder = {
                    order: {
                        OrderID: $('#lblNoMohon').val(),
                        NoRujukan: $('#txtNoRujukan').val(),
                        Perihal: $('#txtPerihal').val(),
                        Tarikh: $('#txtTarikh').val()
                    }
                };

                var result = JSON.parse(await ajaxSaveOrderLulus_Return(newOrder));

                if (result.Status !== false) {

                    $('#maklumanModalBil_Hantar_Return').modal('toggle');
                    $('#detailMaklumanBil_Hantar_Return').html(result.Message);
                    // $('input[type="text"]').val(""); // Clearing text input fields

                    $('#transaksi').modal('toggle');
                    tbl.ajax.reload();

                    setTimeout(function () {
                        tbl.ajax.reload();
                    }, 2000);
                } else {
                    $('#maklumanModalBil_Hantar_Return').modal('toggle');
                    $('#detailMaklumanBil_Hantar_Return').html(result.Message);
                }
            });


            $('.btnSearch').click(async function () {

                load_loader();

                isClicked = true;
                tbl.ajax.reload();

                close_loader();
            })


            $('.btn-danger').click(async function () {
                //alert("test");
                //var result = JSON.parse(await ajaxDeleteOrder($('#lblNoJurnal').val()))
                $('#lblNoJurnal').val("")
                await clearAllRows();
                await clearAllRowsHdr();
                AddRow(5);
            });

            //$('.btnPapar').click(async function () {
            //    var record = await AjaxLoadOrderRecord_Senarai("");
            //    $('#lblNoJurnal').val("")
            //    await clearAllRows_senarai();
            //    await paparSenarai(null, record);
            //});

            $('.btnLoad').on('click', async function () {
                loadExistingRecords();
            });


            //async function loadKelulusanRecords() {
            //    var record = await AjaxLoadOrderRecord_Senarai("");
            //    $('#lblNoJurnal').val("")
            //    await clearAllRows_senarai();
            //    await paparSenarai(null, record);
            //}

            async function loadExistingRecords() {
                var record = await AjaxLoadOrderRecord($('#lblNoJurnal').val());
                await clearAllRows();
                await AddRow(null, record);
            }

            async function clearAllRows() {
                $(tableID + " > tbody > tr ").each(function (index, obj) {
                    if (index > 0) {
                        obj.remove();
                    }
                })
                $(totalDebit).val("0.00");
                $(totalKredit).val("0.00");
                $(totalID).val("0.00"); //total beza
            }

            async function clearAllRowsHdr() {

                $('#lblNoJurnal').val("");
                $('#txtNoRujukan').val("");
                $('#txtTarikh').val("");
                $('#txtPerihal').val("");
                $('#ddlJenTransaksi').empty();


            }

            async function clearAllRows_senarai() {
                $(tableID_Senarai + " > tbody > tr ").each(function (index, obj) {
                    if (index > 0) {
                        obj.remove();
                    }
                })
            }

            $(tableID).on('click', '.btnDelete', async function () {
                event.preventDefault();
                var curTR = $(this).closest("tr");
                var recordID = curTR.find("td > .data-id");
                var bool = true;
                var id = setDefault(recordID.val());

                if (id !== "") {
                    bool = await DelRecord(id);
                }

                if (bool === true) {
                    curTR.remove();
                }

                calculateGrandTotal();
                return false;
            })

            async function ajaxSubmitOrder(order) {

                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: 'Transaksi_WS.asmx/SubmitOrders',
                        method: 'POST',
                        data: JSON.stringify(order),
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            resolve(data.d);
                            //alert(resolve(data.d));
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            console.error('Error:', errorThrown);
                            reject(false);
                        }

                    });
                })

            }

            async function ajaxSaveOrder(order) {

                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: 'Transaksi_WS.asmx/Lulusorder',
                        method: 'POST',
                        data: JSON.stringify(order),
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            resolve(data.d);
                            //alert(resolve(data.d));
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            console.error('Error:', errorThrown);
                            reject(false);
                        }

                    });
                })

            }

            async function ajaxSaveOrderLulus(order) {
             
                return new Promise((resolve, reject) => {
                  
                    $.ajax({                     
                        url: 'Awal_Tahun_WS.asmx/Lulusorder_KB',
                        method: 'POST',
                        data: JSON.stringify(order),
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            resolve(data.d);
                            //alert(resolve(data.d));
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            console.error('Error:', errorThrown);
                            reject(false);
                        }

                    });
                })

            }

            async function ajaxSaveOrderXLulus(order) {

                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: 'Awal_Tahun_WS.asmx/XLulusorder_KB',
                        method: 'POST',
                        data: JSON.stringify(order),
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            resolve(data.d);
                            //alert(resolve(data.d));
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            console.error('Error:', errorThrown);
                            reject(false);
                        }

                    });
                })

            }

            async function ajaxSaveOrderLulus_Return(order) {

                return new Promise((resolve, reject) => {

                    $.ajax({
                        url: 'Awal_Tahun_WS.asmx/Lulusorder_KB_Return',
                        method: 'POST',
                        data: JSON.stringify(order),
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            resolve(data.d);
                            //alert(resolve(data.d));
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            console.error('Error:', errorThrown);
                            reject(false);
                        }

                    });
                })

            }

            async function ajaxDeleteOrder(id) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: 'Transaksi_WS.asmx/DeleteOrder',
                        method: 'POST',
                        data: JSON.stringify({ id: id }),
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
            async function AjaxDelete(id) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: 'Transaksi_WS.asmx/DeleteRecord',
                        method: 'POST',
                        data: JSON.stringify({ id: id }),
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

            async function AjaxLoadOrderRecord(id) {

                try {
                    const response = await fetch('Transaksi_WS.asmx/LoadOrderRecord', {
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

            async function AjaxLoadOrderRecord_Senarai(id) {

                try {
                    const response = await fetch('Transaksi_WS.asmx/LoadOrderRecord_SenaraiLulusTransaksiJurnal', {
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
            async function DelRecord(id) {
                var bool = false;
                var result = JSON.parse(await AjaxDelete(id));

                if (result.Code === "00") {
                    bool = true;
                }

                return bool;
            }


            $(tableID).on('keyup', '.Debit , .Kredit', async function () {

                var curTR = $(this).closest("tr");

                var debit_ = $(curTR).find("td > .Debit");
                var totalDebit = NumDefault(debit_.val())

                var kredit_ = $(curTR).find("td > .Kredit");
                calculateGrandTotal();

                var totalKredit = NumDefault(kredit_.val())
                calculateGrandTotal();


            });

            async function calculateGrandTotal() {

                //Jumlah
                var grandTotal_Dt = $(totalJumlah);

                var curTotal_Dt = 0;

                $('.Jumlah').each(function (index, obj) {
                    curTotal_Dt += parseFloat(NumDefault($(obj).val()));
                });


                grandTotal_Dt.val(formatPrice(curTotal_Dt));

            }


            //async function calculateGrandBeza() {
            //    var grandTotal = $(totalID);

            //    var totalDebit = 0;
            //    var totalKredit = 0;

            //    var curTR = $(this).closest("tr");

            //    var debit_ = $(curTR).find("td > .totalDbt");
            //    var totalDebit = parseFloat(NumDefault(debit_.val()));


            //    var kredit_ = $(curTR).find("td > .totalKt");
            //    var totalKredit = parseFloat(NumDefault(kredit_.val()));

            //    alert("a " + totalDebit)
            //    grandTotal.val(totalDebit - totalKredit);

            //}

            function NumDefault(theVal) {

                return setDefault(theVal, 0)
            }

            function setDefault(theVal, defVal) {

                if (defVal === null || defVal === undefined) {
                    defVal = "";
                }

                if (theVal === "" || theVal === undefined || theVal === null) {
                    theVal = defVal;
                }
                return theVal;
            }

            async function initDropdownKw(id, idVot) {

                $('#' + id).dropdown({
                    fullTextSearch: true,
                    apiSettings: {
                        url: 'Transaksi_WS.asmx/GetKWList?q={query}&kodkw={kodkw}',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        beforeSend: function (settings) {
                            // Replace {query} placeholder in data with user-entered search term

                            var kodVot = $('#' + idVot).dropdown("get value");
                            settings.urlData.kodkw = kodVot;
                            settings.data = JSON.stringify({ q: settings.urlData.query, kodkw: settings.urlData.kodkw });
                            searchQuery = settings.urlData.query;
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

                            //if (searchQuery !== oldSearchQuery) {
                            // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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

            async function initDropdownKo(id, idKw) {


                $('#' + id).dropdown({
                    fullTextSearch: true,
                    apiSettings: {
                        url: 'Transaksi_WS.asmx/GetKoList?q={query}&kodko={kodko}',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        beforeSend: function (settings) {
                            // Replace {query} placeholder in data with user-entered search term
                            var kodkw = $('#' + idKw).dropdown("get value");
                            settings.urlData.kodko = kodkw;
                            settings.data = JSON.stringify({ q: settings.urlData.query, kodko: settings.urlData.kodko });
                            searchQuery = settings.urlData.query;
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

                            //if (searchQuery !== oldSearchQuery) {
                            // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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

            async function initDropdownKp(id, idKo) {

                $('#' + id).dropdown({
                    fullTextSearch: true,
                    apiSettings: {
                        url: 'Transaksi_WS.asmx/GetKpList?q={query}&kodko={kodko}',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        beforeSend: function (settings) {

                            var kodkp = $('#' + idKo).dropdown("get value");
                            settings.urlData.kodko = kodkp;
                            settings.data = JSON.stringify({ q: settings.urlData.query, kodko: settings.urlData.kodko });
                            searchQuery = settings.urlData.query;
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

                            //if (searchQuery !== oldSearchQuery) {
                            // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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

            // add clickable event in DataTable row
            async function rowClickHandler(id) {
                if (id !== "") {
                                    

                    //initDDLBahagian();
                    //initDDLKW();
                    //initDDLKO();
                    //initDDLKP()
                    //initDDLDasar()
                    //initDDLPTJPusat()

                    generateDropdown("ddlBahagian", "Awal_Tahun_WS.asmx/GetListBahagian", null, false, null);
                    generateDropdown("ddlKW", "Awal_Tahun_WS.asmx/GetListKW", null, false, null);
                    //generateDropdown("ddlPenyokong", "Awal_Tahun_WS.asmx/GetListPenyokong", null, false, null);
                    generateDropdown("ddlKO", "Awal_Tahun_WS.asmx/GetListKO", null, false, null);
                    generateDropdown("ddlKP", "Awal_Tahun_WS.asmx/GetListKP", null, false, null);
                    generateDropdown("ddlDasar", "Awal_Tahun_WS.asmx/GetListDasar", null, true, null);
                    generateDropdown("ddlUnit", "Awal_Tahun_WS.asmx/GetListUnit", null, true, "ddlBahagian");
                    generateDropdown("ddlPTJPusat", "Awal_Tahun_WS.asmx/GetListPTJPusat", null, false, null);

                    // modal dismiss
                    $('#transaksi').modal('toggle');
                                      

                    //BACA HEADER JURNAL
                    var recordHdr = await AjaxGetRecordHdrBajet(id);
                    await AddRowHeader(null, recordHdr);

                    //BACA DETAIL JURNAL
                    var record = await AjaxGetRecordBajet(id);
                    await clearAllRows();
                    await AddRow(null, record);
                    
                }
            }

            //$(tableID_Senarai).on('click', '.btnView', async function () {

            //    event.preventDefault();
            //    var curTR = $(this).closest("tr");
            //    var recordID = curTR.find("td > .lblNo");
            //    //var bool = true;
            //    var id = setDefault(recordID.html());


            //    if (id !== "") {

            //        //BACA HEADER JURNAL
            //        var recordHdr = await AjaxGetRecordHdrJurnal(id);
            //        await AddRowHeader(null, recordHdr);

            //        //BACA DETAIL JURNAL
            //        var record = await AjaxGetRecordJurnal(id);
            //        await clearAllRows();
            //        await AddRow(null, record);

            //    }

            //    return false;
            //})

            async function initDropdownVot(id, idPtj) {

                $('#' + id).dropdown({
                    fullTextSearch: true,
                    apiSettings: {
                        url: 'Transaksi_WS.asmx/GetVotList?q={query}&kodVot={kodVot}',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        beforeSend: function (settings) {
                            // Replace {query} placeholder in data with user-entered search term

                            var kodPtj = $('#' + idPtj).dropdown("get value");
                            settings.urlData.kodVot = kodPtj;
                            settings.data = JSON.stringify({ q: settings.urlData.query, kodVot: settings.urlData.kodVot });
                            searchQuery = settings.urlData.query;
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

                            //if (searchQuery !== oldSearchQuery) {
                            // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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

            async function generateDropdown(id, url, plchldr, send2ws, sendData, fn) {
                //console.log("a")
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

                            /*dependable ddl if sendata value == empty clear all option*/
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

            async function initDropdownPtj(id) {

                $('#' + id).dropdown({
                    fullTextSearch: true,
                    apiSettings: {
                        url: 'Transaksi_WS.asmx/GetVotPTJ?q={query}',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        beforeSend: function (settings) {
                            // Replace {query} placeholder in data with user-entered search term
                            settings.data = JSON.stringify({ q: settings.urlData.query });
                            searchQuery = settings.urlData.query;
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

                            //if (searchQuery !== oldSearchQuery) {
                            // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
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

            function initDDLKP() {
                $.ajax({
                    url: 'Awal_Tahun_WS.asmx/GetListKP?q={query}',
                    method: "POST",
                    data: JSON.stringify({
                        q: ''
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        data = JSON.parse(data.d)
                        let list = $('#ddlKP')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                       // $("#ddlKP").dropdown('clear');
                    }
                })
            }

            function initDDLDasar() {
                $.ajax({
                    url: 'Awal_Tahun_WS.asmx/GetListDasar?q={query}',
                    method: "POST",
                    data: JSON.stringify({
                        q: ''
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        data = JSON.parse(data.d)
                        let list = $('#ddlDasar')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                        //$("#ddlDasar").dropdown('clear');
                    }
                })
            }

            $('#ddlUnit').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'Awal_Tahun_WS.asmx/GetListUnit?q={query}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({
                            kod: settings.urlData.query,
                            category: $('#ddlBahagian').val()
                        });
                        //searchQuery = settings.urlData.query;
                        return settings;
                    },
                    onchange: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({
                            kod: settings.urlData.query,
                            category: $('#ddlBahagian').val()
                        });
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

            function initDDLPTJPusat() {
                $.ajax({
                    url: 'Awal_Tahun_WS.asmx/GetListPTJPusat?q={query}',
                    method: "POST",
                    data: JSON.stringify({
                        q: ''
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        data = JSON.parse(data.d)
                        let list = $('#ddlPTJPusat')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                        //$("#ddlPTJPusat").dropdown('clear');
                    }
                })
            }

            $('.btnAddRow').click(async function () {
                var totalClone = $(this).data("val");

                await AddRow(totalClone);
            });

            //async function AddRow(totalClone, objOrder) {
            //    var counter = 1;
            //    var table = $('#tblData');

            //    if (objOrder !== null && objOrder !== undefined) {
            //        //totalClone = objOrder.Payload.OrderDetails.length;
            //        totalClone = objOrder.Payload.length;

            //        //if (totalClone < 5) {
            //        //    totalClone = 5;
            //        //}
            //    }

            //    while (counter <= totalClone) {
            //        curNumObject += 1;
            //        var newId_kw = "ddlKW" + curNumObject;
            //        var newId_Ko = "ddlKo" + curNumObject;
            //        var newId_Kp = "ddlKp" + curNumObject;
            //        var newId_vot = "ddlVot" + curNumObject;
            //        var newId_ptj = "ddlPTJ" + curNumObject;

            //        var row = $('#tblData tbody>tr:first').clone();

            //        var dropdown = $(row).find(".kw-list").attr("id", newId_kw);
            //        var dropdown1 = $(row).find(".ko-list").attr("id", newId_Ko);
            //        var dropdown2 = $(row).find(".kp-list").attr("id", newId_Kp);
            //        var dropdown3 = $(row).find(".vot-list").attr("id", newId_vot);
            //        var dropdown4 = $(row).find(".ptj-list").attr("id", newId_ptj);

            //        row.attr("style", "");
            //        var val = "";

            //        $('#tblData tbody').append(row);

            //        await initDropdownPtj(newId_ptj)
            //        $(newId_ptj).api("query");


            //        await initDropdownVot(newId_vot, newId_ptj)
            //        $(newId_vot).api("query");

            //        await initDropdownKw(newId_kw, newId_vot)
            //        $(newId_kw).api("query");

            //        await initDropdownKo(newId_Ko, newId_kw)
            //        $(newId_Ko).api("query");

            //        await initDropdownKp(newId_Kp, newId_Ko)
            //        $(newId_Kp).api("query");


            //        if (objOrder !== null && objOrder !== undefined) {
            //            //await setValueToRow(row, objOrder.Payload.OrderDetails[counter - 1]);
            //            if (counter <= objOrder.Payload.length) {
            //                await setValueToRow_Transaksi(row, objOrder.Payload[counter - 1]);
            //            }
            //        }
            //        counter += 1;
            //    }
            //}

            async function AddRow(totalClone, objOrder) {

                var counter = 1;
                var table = $('#tblData');


                if (objOrder !== null && objOrder !== undefined) {
                    //totalClone = objOrder.Payload.OrderDetails.length;
                    totalClone = objOrder.Payload.length;

                    //if (totalClone < 5) {
                    //    totalClone = 5;
                    //}
                }

                //console.log(objOrder)

                while (counter <= totalClone) {

                    //console.log("totalClone " + counter + " " + totalClone)

                    curNumObject += 1;

                    var newId_coa = "ddlObjAm" + curNumObject;

                    var row = $('#tblData tbody>tr:first').clone();

                    var dropdown5 = $(row).find(".ObjAm-list").attr("id", newId_coa);

                    row.attr("style", "");
                    var val = "";

                    $('#tblData tbody').append(row);

                    await initDropdownObjAm(newId_coa)
                    $(newId_coa).api("query");



                    if (objOrder !== null && objOrder !== undefined) {

                        //await setValueToRow(row, objOrder.Payload.OrderDetails[counter - 1]);
                        if (counter <= objOrder.Payload.length) {
                            await setValueToRow_Transaksi(row, objOrder.Payload[counter - 1]);

                        }
                    }


                    counter += 1;
                }
            }

            async function initDropdownObjAm(id) {

                $('#' + id).dropdown({
                    fullTextSearch: true,
                    onChange: function (value, text, $selectedItem) {

                        //console.log($selectedItem);

                        var curTR = $(this).closest("tr");

                        var recordIDVotHd = curTR.find("td > .Hid-objAm-list");

                    },
                    apiSettings: {
                        url: 'Awal_Tahun_WS.asmx/GetObjAm?q={query}',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        fields: {

                            value: "value",      // specify which column is for data
                            name: "text"      // specify which column is for text


                        },
                        beforeSend: function (settings) {
                            // Replace {query} placeholder in data with user-entered search term

                            //settings.urlData.param2 = "secondvalue";

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
                                //$(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                                $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                            });


                            // Refresh dropdown
                            $(obj).dropdown('refresh');

                            if (shouldPop === true) {
                                $(obj).dropdown('show');
                            }
                        }
                    }



                });
            }

            $('.ObjAm-list').each(function (index, obj) {

                if (index > 0) {
                    var tcell = $(obj).closest("td");
                    //alert("ce;; "+tcell)
                    var orderDetail_Bajet = {
                        OrderID: $('#lblNoMohon').val(),
                        ddlObjAm: $(obj).dropdown("get value"),
                        Butiran: $('.Butiran').eq(index).val(),
                        Jumlah: $('.Jumlah').eq(index).val(),
                        id: $(tcell).find(".data-id").val()
                    };



                    //if (orderDetail.ddlPTJ === "" || orderDetail.ddlVot === "" || orderDetail.ddlKw === "" || orderDetail.ddlKo === "" || orderDetail.ddlKp === "" ||
                    //    orderDetail.debit === "" ||  orderDetail.kredit === "") {
                    //    return;
                    //}


                    acceptedRecord += 1;
                    newOrder.order.OrderDetails.push(orderDetail_Bajet);

                }

            });

            async function initDropdownCOA(id) {

                $('#' + id).dropdown({
                    fullTextSearch: true,
                    onChange: function (value, text, $selectedItem) {

                        //console.log($selectedItem);

                        var curTR = $(this).closest("tr");

                        var recordIDVotHd = curTR.find("td > .Hid-vot-list");
                        recordIDVotHd.html($($selectedItem).data("coltambah5"));

                        //var selectObj = $($selectedItem).find("td > .COA-list > select");
                        //selectObj.val($($selectedItem).data("coltambah5"));



                        var recordIDPtj = curTR.find("td > .label-ptj-list");
                        recordIDPtj.html($($selectedItem).data("coltambah1"));

                        var recordIDPtjHd = curTR.find("td > .Hid-ptj-list");
                        recordIDPtjHd.html($($selectedItem).data("coltambah5"));

                        var recordID_ = curTR.find("td > .label-kw-list");
                        recordID_.html($($selectedItem).data("coltambah2"));

                        var recordIDkwHd = curTR.find("td > .Hid-kw-list");
                        recordIDkwHd.html($($selectedItem).data("coltambah6"));

                        var recordID_ko = curTR.find("td > .label-ko-list");
                        recordID_ko.html($($selectedItem).data("coltambah3"));

                        var recordIDkoHd = curTR.find("td > .Hid-ko-list");
                        recordIDkoHd.html($($selectedItem).data("coltambah7"));

                        var recordID_kp = curTR.find("td > .label-kp-list");
                        recordID_kp.html($($selectedItem).data("coltambah4"));

                        var recordIDkpHd = curTR.find("td > .Hid-kp-list");
                        recordIDkpHd.html($($selectedItem).data("coltambah8"));


                    },
                    apiSettings: {
                        url: 'Transaksi_WS.asmx/GetVotCOA?q={query}',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        fields: {

                            value: "value",      // specify which column is for data
                            name: "text",      // specify which column is for text
                            colPTJ: "colPTJ",
                            colhidptj: "colhidptj",
                            colKW: "colKW",
                            colhidkw: "colhidkw",
                            colKO: "colKO",
                            colhidko: "colhidko",
                            colKp: "colKp",
                            colhidkp: "colhidkp",

                        },
                        beforeSend: function (settings) {
                            // Replace {query} placeholder in data with user-entered search term

                            //settings.urlData.param2 = "secondvalue";

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
                                //$(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                                $(objItem).append($('<div class="item" data-value="' + option.value + '" data-coltambah1="' + option.colPTJ + '" data-coltambah5="' + option.colhidptj + '" data-coltambah2="' + option.colKW + '" data-coltambah6="' + option.colhidkw + '" data-coltambah3="' + option.colKO + '" data-coltambah7="' + option.colhidko + '" data-coltambah4="' + option.colKp + '" data-coltambah8="' + option.colhidkp + '" >').html(option.text));
                            });

                            // Refresh dropdown
                            $(obj).dropdown('refresh');

                            if (shouldPop === true) {
                                $(obj).dropdown('show');
                            }
                        }
                    }



                });
            }

            async function paparSenarai(totalClone, objOrder) {
                var counter = 1;
                var table = $('#tblDataSenarai');

                if (objOrder !== null && objOrder !== undefined) {
                    totalClone = objOrder.Payload.length;

                }
                // console.log(objOrder)

                while (counter <= totalClone) {


                    var row = $('#tblDataSenarai tbody>tr:first').clone();
                    row.attr("style", "");
                    var val = "";

                    $('#tblDataSenarai tbody').append(row);

                    if (objOrder !== null && objOrder !== undefined) {

                        if (counter <= objOrder.Payload.length) {
                            await setValueToRow(row, objOrder.Payload[counter - 1]);
                        }
                    }

                    counter += 1;
                }
            }

            async function initDropdownCOA_trans(id) {

                $('#' + id).dropdown({
                    fullTextSearch: true,

                    apiSettings: {
                        url: 'Transaksi_WS.asmx/GetVotCOA?q={query}',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        fields: {

                            value: "value",      // specify which column is for data
                            name: "text"      // specify which column is for text


                        },
                        beforeSend: function (settings) {
                            // Replace {query} placeholder in data with user-entered search term

                            //settings.urlData.param2 = "secondvalue";

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
                                //$(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                                $(objItem).append($('<div class="item" data-value="' + option.value + '" data-coltambah1="' + option.colPTJ + '" data-coltambah5="' + option.colhidptj + '" data-coltambah2="' + option.colKW + '" data-coltambah6="' + option.colhidkw + '" data-coltambah3="' + option.colKO + '" data-coltambah7="' + option.colhidko + '" data-coltambah4="' + option.colKp + '" data-coltambah8="' + option.colhidkp + '" >').html(option.text));
                            });

                            // Refresh dropdown
                            $(obj).dropdown('refresh');

                            if (shouldPop === true) {
                                $(obj).dropdown('show');
                            }
                        }
                    }



                });
            }


            async function setValueToRow_HdrBajet(orderDetail) {

                

                $('#lblNoMohon').val(orderDetail.No_Mohon)
                $('#txtTarikh').val(orderDetail.Tkh_Transaksi)

                $('#txtProgram').val(orderDetail.Program)
                $('#txtJustifikasi').val(orderDetail.Justifikasi)

                //$('#txtPTJ').val(orderDetail.Kod_PTJ)
                getPTJ_Butiran(orderDetail.Kod_PTJ)

                buildDdl('ddlBahagian', orderDetail.Kod_Bahagian, orderDetail.Butir_Kod_Bahagian);
                buildDdl('ddlUnit', orderDetail.Kod_Unit, orderDetail.Butir_Kod_Unit);
                buildDdl('ddlKW', orderDetail.Kod_Kump_Wang, orderDetail.Butir_Kod_Kump_Wang);
                buildDdl('ddlKO', orderDetail.Kod_Operasi, orderDetail.Butir_Kod_Operasi);
                buildDdl('ddlKP', orderDetail.Kod_Projek, orderDetail.Butir_Kod_Projek);
                buildDdl('ddlDasar', orderDetail.Kod_Dasar, orderDetail.Butir_Kod_Dasar);
                buildDdl('ddlPTJPusat', orderDetail.PTJ_Pusat, orderDetail.Butir_Kod_Dasar);

                //$("#ddlBahagian").dropdown('set selected', orderDetail.Kod_Bahagian)                
                //$("#ddlKW").dropdown('set selected', orderDetail.Kod_Kump_Wang)
                //$("#ddlKO").dropdown('set selected', orderDetail.Kod_Operasi)
                //$("#ddlKP").dropdown('set selected', orderDetail.Kod_Projek)
                //$("#ddlDasar").dropdown('set selected', orderDetail.Kod_Dasar)
                //$("#ddlPTJPusat").dropdown('set selected', orderDetail.PTJ_Pusat)

                
            }

            function buildDdl(id, kodVal, ButirVal) {

                if (isSet(kodVal)) {
                    //alert(kodVal + " nn " + id)
                    $("#" + id).html("<option value = '" + kodVal + "'>" + ButirVal + "</option>")
                    $("#" + id).dropdown('set selected', kodVal);
                }
            }

            function isSet(value) {
                if (value === null || value === '' || value === undefined) {
                    return false;
                } else {
                    return true;
                }
            }

            async function setValueToRow(row, orderDetail) {

                //console.log(orderDetail.No_Jurnal)
                var no = $(row).find("td > .lblNo");
                var no1 = $(row).find("td > .lblNo");
                var rujukan = $(row).find("td > .lblRujukan");
                var butiran = $(row).find("td > .lblButiran");
                var jumlah = $(row).find("td > .lblJumlah");
                var tarikh = $(row).find("td > .lblTkh");

                no.html(orderDetail.No_Jurnal);
                no1.val(orderDetail.No_Jurnal);
                rujukan.html(orderDetail.No_Rujukan);
                butiran.html(orderDetail.Butiran);
                jumlah.html(orderDetail.Jumlah);
                tarikh.html(orderDetail.Tkh_Transaksi);



            }

            async function setValueToRow_Transaksi(row, orderDetail) {

                var ddl = $(row).find("td > .ObjAm-list");
                var ddlSearch = $(row).find("td > .ObjAm-list > .search");
                var ddlText = $(row).find("td > .ObjAm-list > .text");
                var selectObj = $(row).find("td > .ObjAm-list > select");
                $(ddl).dropdown('set selected', orderDetail.ddlObjAm);
                selectObj.append("<option value = '" + orderDetail.ddlObjAm + "'>" + orderDetail.ddlObjAm + ' - ' + orderDetail.ButiranVot + "</option>")


                //var butirptj = $(row).find("td > .label-ptj-list");
                //butirptj.html(orderDetail.ButiranPTJ);


                var jumlah = $(row).find("td > .Jumlah");
                jumlah.val(orderDetail.Jumlah.toFixed(2));

                var Butiran = $(row).find("td > .Butiran");
                Butiran.val(orderDetail.Butiran);


                await calculateGrandTotal();

            }



            async function AddRowHeader(totalClone, objOrder) {
                var counter = 1;
                //var table = $('#tblDataSenarai');

                if (objOrder !== null && objOrder !== undefined) {
                    totalClone = objOrder.Payload.length;
                }

                

                if (counter <= objOrder.Payload.length) {
                    await setValueToRow_HdrBajet(objOrder.Payload[counter - 1]);
                }
                // console.log(objOrder)
            }


            async function AjaxGetRecordBajet(id) {

                try {

                    const response = await fetch('Awal_Tahun_WS.asmx/LoadRecordBajet_KB', {
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

            async function AjaxGetRecordHdrBajet(id) {

                try {

                    const response = await fetch('Awal_Tahun_WS.asmx/LoadHdrBajet_KB', {
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


            function getPTJ_Butiran(val) {
                //Cara Pertama

                fetch('Awal_Tahun_WS.asmx/ViewPTJ', {
                    method: 'POST',
                    headers: {
                        'Content-Type': "application/json"
                    },
                    body: JSON.stringify({ val: val })
            })
                    .then(response => response.json())
                    .then(data => setPTJ_Butiran(data.d))

            }

            function setPTJ_Butiran(data) {

                data = JSON.parse(data);

                if (data.KodPejPBU === "") {
                    alert("Tiada data");
                    return false;
                }

                document.getElementById("txtPTJ").value = data[0].KodPejPBU + " - " + data[0].Pejabat;
                document.getElementById("Hid-ptj-list").innerHTML = data[0].KodPejPBU;
            }

            function initDDLBahagian() {
                $.ajax({
                    url: 'Awal_Tahun_WS.asmx/GetListBahagian?q={query}',
                    method: "POST",
                    data: JSON.stringify({
                        q: ''
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        data = JSON.parse(data.d)
                        let list = $('#ddlBahagian')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                        //$("#ddlBahagian").dropdown('clear');
                    }
                })
            }


        </script>
    </div>
</asp:Content>
