<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Permohonan_Bajet.aspx.vb" Inherits="SMKB_Web_Portal.Permohonan_Bajet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <style>
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

      /*  #tblDataSenarai_trans td:hover {
            cursor: pointer;
        }*/


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
        <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Papar Permohonan Bajet</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
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
                     <div style="text-align: left" class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-1">
                                            <label>Penyokong:</label></div>
                                        <div class="form-group col-md-5">
                                            <select id="ddlPenyokong" name="ddlPenyokong"  class="custom-select" style="width: 20%"></select></div>
                                        <div class="form-group col-md-3">
                                            <button type="button" class="btn btn-success btnHantar">Hantar Permohonan</button></div>
                                    </div>
                                </div>               
                 
                    <div class="modal-body">       
                        
                            <div class="transaction-table table-responsive"><div class="col-md-12">
                                <table id="tblDataSenarai_trans" class="table table-striped" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th scope="col"><input type="checkbox" name="selectAll" id="selectAll" /></th>
                                            <th scope="col">No. Mohon</th>
                                            <th scope="col">Program</th>
                                            <th scope="col">Justifikasi</th>
                                            <th scope="col">Jumlah (RM)</th>
                                            <th scope="col">Tarikh Transaksi</th>
                                            <th scope="col">Status</th>
                                            <th scope="col">Tindakan</th>

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



        <div class="modal-body">
            <div class="table-title">
                <h5>Permohonan Bajet</h5>
                <div class="btn btn-primary btnPapar" onclick="ShowPopup('2')">
                    Senarai Permohonan Bajet  
                </div>

            </div>

            <hr>
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

                        <div class="form-group col-md-3"> <select class="input-group__select ui search dropdown" name="ddlBahagian" id="ddlBahagian" placeholder="&nbsp;">
                      
                        </select>
                        <label class="input-group__label" for="ddlBahagian">Bahagian</label>
                        </div>

                        <div class="form-group col-md-3">
                         <select class="input-group__select ui search dropdown ListUnit" name="ddlUnit" id="ddlUnit" >

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
        </div>
        <h6>Butiran Permohonan</h6>

        <div class="secondaryContainer transaction-table table-responsive">

            <table id="tblData" class="table table-striped">
                <thead>
                    <tr>
                        <th scope="col">Vot</th>
                        <th scope="col">Butiran</th>
                        <th scope="col">Jumlah (RM)</th>
                        <th scope="col">Tindakan</th>

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
                        <%--<td style="width: 26%">
                                    <input id="UploadDok" name="UploadDok" runat="server" type="file" class="form-control underline-input UploadDok" style="text-align: left" width="60%" />
                                </td>--%>
                        <td style="width: 10%">
                            <input id="Jumlah" name="Jumlah" runat="server" type="number" class="form-control underline-input Jumlah" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" style="text-align: right" width="10%" value="0.00" /></td>

                        <td style="width: 4%">
                            <button id="lbtnCari" runat="server" class="btn btnDelete" type="button" style="color: red">
                                <i class="fa fa-trash"></i>
                            </button>
                        </td>

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
                            <div class="btn-group">
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
                    <tr>
                        <td colspan="9" style="text-align: right;">
                            <button type="button" class="btn btn-setsemula btnSet">Rekod Baru</button>                            
                            <button type="button" class="btn btn-secondary btnSimpan" id="btnSimpan" name="btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                    </tr>


                </tfoot>
            </table>
        </div>


        <!-- Confirmation Modal  -->
        <div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog"
            aria-labelledby="confirmationModalLabel" aria-hidden="true">
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
                        Anda pasti ingin menyimpan rekod ini?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger"
                            data-dismiss="modal">
                            Tidak</button>
                        <button id="EmailJurnal3" runat="server" type="button" class="btn default-primary btnYa_Hantar">Ya</button>
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
                            data-dismiss="modal">
                            Tutup</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Makluman Modal Bil -->
        <div class="modal fade" id="maklumanModalBil" tabindex="-1" role="dialog"
            aria-labelledby="maklumanModalLabelBil" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="maklumanModalLabelBil">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <span id="detailMaklumanBil"></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn default-primary" id="tutupMaklumanBil"
                            data-dismiss="modal">
                            Tutup</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Message Box -->
        <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Tolong Sahkan?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Adakah anda pasti mahu menambah modul?
                               
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" data-toggle="modal"
                            data-target="#ModulForm" data-dismiss="modal">
                            Ya</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script>



        function handleInputChange(inputElement) {
            const labelElement = inputElement.nextElementSibling; // Get the label element

            if (inputElement.value === '') {
                labelElement.classList.remove('input-group__label-floated');
            } else {
                labelElement.classList.add('input-group__label-floated');
            }
        }

        function ShowDetails(id, status) {
            if (id !== "") {
                if (status !== "") {
                    if (status == "NOTDONE") {
                        location.replace('<%=ResolveClientUrl("~/FORMS/AKAUN PENERIMA/Terimaan/Terima_Terperinci.aspx")%>?kodpenghutang=' + id + '&status=03', '_blank');
                    } else if (status == "DONE") {
                                location.replace('<%=ResolveClientUrl("~/FORMS/AKAUN PENERIMA/Terimaan/Terima_Terperinci.aspx")%>?kodpenghutang=' + id + '&status=04', '_blank');
                            }

                        }
                    }

                }
    </script>


    <script type="text/javascript">


        function ShowPopup(elm) {

            if (elm == "1") {

                $('#permohonan').modal('toggle');

            }
            else if (elm == "2") {

                $(".modal-body div").val("");
                $('#permohonan').modal('toggle');

            }
        }

        //$(document).ready(function () {

            
        //    getDateNow();
        //    getPTJ();

        //    initDDLBahagian()
        //    initDDLKW()
        //    initDDLKO()
        //    initDDLKP()
        //    initDDLDasar()
        //    initDDLPTJPusat()
        //    initDDLPenyokong();
            
       

        //    function initDDLBahagian() {
        //        $.ajax({
        //            url: 'Awal_Tahun_WS.asmx/GetListBahagian?q={query}',
        //            method: "POST",
        //            data: JSON.stringify({
        //                q: ''
        //            }),
        //            dataType: "json",
        //            contentType: "application/json;charset=utf-8",
        //            success: function (data) {
        //                data = JSON.parse(data.d)
        //                let list = $('#ddlBahagian')
        //                $(list).html('');
        //                let parsed = []
        //                data.forEach(d => {
        //                    $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
        //                })

        //                $("#ddlBahagian").dropdown('clear');
        //            }
        //        })
        //    }

        //    function initDDLKW() {
        //        $.ajax({
        //            url: 'Awal_Tahun_WS.asmx/GetListKW?q={query}',
        //            method: "POST",
        //            data: JSON.stringify({
        //                q: ''
        //            }),
        //            dataType: "json",
        //            contentType: "application/json;charset=utf-8",
        //            success: function (data) {
        //                data = JSON.parse(data.d)
        //                let list = $('#ddlKW')
        //                $(list).html('');
        //                let parsed = []
        //                data.forEach(d => {
        //                    $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
        //                })

        //                $("#ddlKW").dropdown('clear');
        //            }
        //        })
        //    }

        //    function initDDLPenyokong() {
        //        $.ajax({
        //            url: 'Awal_Tahun_WS.asmx/GetListPenyokong?q={query}',
        //            method: "POST",
        //            data: JSON.stringify({
        //                q: ''
        //            }),
        //            dataType: "json",
        //            contentType: "application/json;charset=utf-8",
        //            success: function (data) {
        //                data = JSON.parse(data.d)
        //                let list = $('#ddlPenyokong')
        //                $(list).html('');
        //                let parsed = []
        //                data.forEach(d => {
        //                    $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
        //                })

        //                $("#ddlPenyokong").dropdown('clear');
        //            }
        //        })
        //    }           

        //    function initDDLKO() {
        //        $.ajax({
        //            url: 'Awal_Tahun_WS.asmx/GetListKO?q={query}',
        //            method: "POST",
        //            data: JSON.stringify({
        //                q: ''
        //            }),
        //            dataType: "json",
        //            contentType: "application/json;charset=utf-8",
        //            success: function (data) {
        //                data = JSON.parse(data.d)
        //                let list = $('#ddlKO')
        //                $(list).html('');
        //                let parsed = []
        //                data.forEach(d => {
        //                    $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
        //                })

        //                $("#ddlKO").dropdown('clear');
        //            }
        //        })
        //    }
          

        //    function initDDLKP() {
        //        $.ajax({
        //            url: 'Awal_Tahun_WS.asmx/GetListKP?q={query}',
        //            method: "POST",
        //            data: JSON.stringify({
        //                q: ''
        //            }),
        //            dataType: "json",
        //            contentType: "application/json;charset=utf-8",
        //            success: function (data) {
        //                data = JSON.parse(data.d)
        //                let list = $('#ddlKP')
        //                $(list).html('');
        //                let parsed = []
        //                data.forEach(d => {
        //                    $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
        //                })

        //                $("#ddlKP").dropdown('clear');
        //            }
        //        })
        //    }

        //    function initDDLDasar() {
        //        $.ajax({
        //            url: 'Awal_Tahun_WS.asmx/GetListDasar?q={query}',
        //            method: "POST",
        //            data: JSON.stringify({
        //                q: ''
        //            }),
        //            dataType: "json",
        //            contentType: "application/json;charset=utf-8",
        //            success: function (data) {
        //                data = JSON.parse(data.d)
        //                let list = $('#ddlDasar')
        //                $(list).html('');
        //                let parsed = []
        //                data.forEach(d => {
        //                    $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
        //                })

        //                $("#ddlDasar").dropdown('clear');
        //            }
        //        })
        //    }
          

        //    $('#ddlUnit').dropdown({
        //        selectOnKeydown: true,
        //        fullTextSearch: true,
        //        apiSettings: {
        //            url: 'Awal_Tahun_WS.asmx/GetListUnit?q={query}',
        //            method: 'POST',
        //            dataType: "json",
        //            contentType: 'application/json; charset=utf-8',
        //            cache: false,
        //            beforeSend: function (settings) {
        //                // Replace {query} placeholder in data with user-entered search term
        //                settings.data = JSON.stringify({
        //                    kod: settings.urlData.query,
        //                    category: $('#ddlBahagian').val()
        //                });
        //                //searchQuery = settings.urlData.query;
        //                return settings;
        //            },
        //            onchange: function (settings) {
        //                // Replace {query} placeholder in data with user-entered search term
        //                settings.data = JSON.stringify({
        //                    kod: settings.urlData.query,
        //                    category: $('#ddlBahagian').val()
        //                });
        //                //searchQuery = settings.urlData.query;
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
        //                    $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
        //                });

        //                //if (searchQuery !== oldSearchQuery) {
        //                //$(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
        //                //}

        //                //oldSearchQuery = searchQuery;

        //                // Refresh dropdown
        //                $(obj).dropdown('refresh');

        //                if (shouldPop === true) {
        //                    $(obj).dropdown('show');
        //                }
        //            }
        //        }
        //    });

        //    function initDDLPTJPusat() {
        //        $.ajax({
        //            url: 'Awal_Tahun_WS.asmx/GetListPTJPusat?q={query}',
        //            method: "POST",
        //            data: JSON.stringify({
        //                q: ''
        //            }),
        //            dataType: "json",
        //            contentType: "application/json;charset=utf-8",
        //            success: function (data) {
        //                data = JSON.parse(data.d)
        //                let list = $('#ddlPTJPusat')
        //                $(list).html('');
        //                let parsed = []
        //                data.forEach(d => {
        //                    $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
        //                })

        //                $("#ddlPTJPusat").dropdown('clear');
        //            }
        //        })
        //    }
                       
        //});

        $(document).ready(function () {
            getDateNow();
            getPTJ();
            /*generateDropdown("id", "path", "place holder", "flag send data to web services or either", "parent dropdown (dependable)","function after ajax success");*/
            generateDropdown("ddlBahagian", "Awal_Tahun_WS.asmx/GetListBahagian", null, false, null);
            generateDropdown("ddlKW", "Awal_Tahun_WS.asmx/GetListKW", null, false, null);
            generateDropdown("ddlPenyokong", "Awal_Tahun_WS.asmx/GetListPenyokong", null, false, null);
            generateDropdown("ddlKO", "Awal_Tahun_WS.asmx/GetListKO", null, false, null);
            generateDropdown("ddlKP", "Awal_Tahun_WS.asmx/GetListKP", null, false, null);
            generateDropdown("ddlDasar", "Awal_Tahun_WS.asmx/GetListDasar", null, true, null);
            generateDropdown("ddlUnit", "Awal_Tahun_WS.asmx/GetListUnit", null, true, "ddlBahagian");
            generateDropdown("ddlPTJPusat", "Awal_Tahun_WS.asmx/GetListPTJPusat", null, false, null);
        });

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
                    "url": "Awal_Tahun_WS.asmx/LoadOrderRecord_SenaraiTransaksiBajet",
                    "method": 'POST',
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

                    //// Add click event
                    //$(row).on("click", function () {
                    //    rowClickHandler(data.No_Mohon);

                    //});
                },
                "columns": [
                    {
                        "data": "Kod_Status_Dok",
                       
                        render: function (data, type, row, meta) {

                            if (type !== "display") {
                                return data;
                            }                                                        

                            
                            if (data != "DAFTAR BAJET") {
                                var link = ` <input type="checkbox" name="checkROC" class = "checkROC" id="checkROC" class="checkSingle" disabled/>`;
                            }
                            else {
                                var link = ` <input type="checkbox" name="checkROC" class = "checkROC" id="checkROC" class="checkSingle" />`;
                            }
                                                      

                            return link;
                        }
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
                    { "data": "Program" },
                    { "data": "Justifikasi" },
                    { "data": "Jumlah_Mohon", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "text-right" },
                    { "data": "Tkh_Transaksi" },
                    {
                        "data": "Kod_Status_Dok",
                        render: function (data2, type, row, meta) {

                            var link

                            if (data2 ===  "DAFTAR BAJET") {
                                link = `<td style="width: 10%" >
                                                <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data2}" style="color:red;" >${data2}</p>
                                            </td>`;

                            }
                       
                            else {
                                link = `<td style="width: 10%" >
                                                <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data2}" style="color:blue;" >${data2}</p>                                              
                                            </td>`;
                            }


                            return link;
                        }
                    },
                    {
                        className: "btnView",
                        "data": "No_Mohon",
                        render: function (data, type, row, meta) {

                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnView" runat="server" class="btn btnView" value="${data}" type="button" data-toggle="tooltip" data-placement="top" title="Kemaskini" onclick="rowClickHandler('${data}')">
                                                    <i class="fa fa-edit"></i>
                                        </button>`;
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

        //$('.btnPapar').click(async function () {
        //    tbl.ajax.reload();
        //});


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

      


        $('.btnSearch').click(async function () {
           // show_loader();
            isClicked = true;
            tbl.ajax.reload();
            //close_loader();

        })

        //$(document).ready(function () {
        //    // alert("test")
        //    $('#categoryFilter').dropdown({
        //        fullTextSearch: false,
        //        apiSettings: {
        //            url: 'Transaksi_WS.asmx/GetJenisStatus?q={query}',
        //            method: 'POST',
        //            dataType: "json",
        //            contentType: 'application/json; charset=utf-8',
        //            cache: false,
        //            beforeSend: function (settings) {
        //                // Replace {query} placeholder in data with user-entered search term
        //                settings.data = JSON.stringify({ q: settings.urlData.query });
        //                searchQuery = settings.urlData.query;
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
        //                    $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
        //                });

        //                //if (searchQuery !== oldSearchQuery) {
        //                // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
        //                //}

        //                //oldSearchQuery = searchQuery;

        //                // Refresh dropdown
        //                $(obj).dropdown('refresh');

        //                if (shouldPop === true) {
        //                    $(obj).dropdown('show');
        //                }
        //            }
        //        }
        //    });
        //});
        $(function () {
            $('.btnAddRow.five').click();
        });

        $('.btnHantar').click(async function () {
           // console.log("test")
            $('#confirmationModal_Hantar').modal('toggle');

 
        });

        $('.btnYa_Hantar').click(async function () {

            //$('#confirmationModal_Hantar').modal('toggle');


           // $('.btnHantar').click(function () {
                var data = {
                    data: []
                };
                $('.checkROC:checked').each(function () {
                    var tr = $(this).closest("tr");
                    var senPenyokong = $('#ddlPenyokong').val();

                    data.data.push({ NoMohon: tr.find(".lblNo").text(), SenaraiPenyokong: senPenyokong})

                   
                });

                if (data.data.length === 0) {
                    return false;
                }
                //show_loader();

            var result = JSON.parse(await ajaxSaveOrder_Hantar(data));

            if (result.Status !== "Failed") {
                //$('#modalPenghutang').modal('toggle');
                // open modal makluman and show message
                $('#maklumanModalBil_Hantar').modal('toggle');
                $('#detailMaklumanBil_Hantar').html(result.Message);
                //clearAllFields();
                // refresh page after 2 seconds
                //alert("a")

                
            } else {
                //alert("b")
                // open modal makluman and show message
                $('#maklumanModalBil_Hantar').modal('toggle');
                $('#detailMaklumanBil_Hantar').html(result.Message);

            }

          
            //});


        });

        async function ajaxSaveOrder_Hantar(data) {
            //console.log(order)
            return new Promise((resolve, reject) => {
                $.ajax({
                    "url": "Awal_Tahun_WS.asmx/HantarPermohonan",
                    method: 'POST',
                    data: JSON.stringify(data),
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
        $('.btnSet').click(async function () {
            //$('#lblNoJurnal').val("");
            //$('#ddlJenTransaksi').dropdown('clear');
            //$('#ddlJenTransaksi').dropdown('refresh');

            await clearAllRows();
            await clearAllRowsHdr();
            await clearHiddenButton();
            AddRow(5);
        })


        async function generateDropdown(id, url, plchldr, send2ws, sendData, fn) {
           //console.log("a")
            var param = '';
            (sendData !== null && sendData !== undefined) ? param = '' : param = '?q={query}';

            $('#' + id).dropdown({
                selectOnKeydown: true,
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

                        if (listOptions.length === 0) {
                            $(objItem).html('<div class="message">Rekod Tidak Dijumpai.</div>');
                            return false;
                        }

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
        $('.btnSimpan').click(async function () {
            //// check every required field
            //if ($('#ddlKategoriPenghutang').val() == "" || $('#ddlUrusniaga').val() == "" || $('#ddlPenghutang').val() == "" || $("input[name='inlineRadioOptions']:checked").val() == "" || $('#txtTujuan').val() == "") {
            //    // open modal makluman and show message
            //    $('#maklumanModalBil').modal('toggle');
            //    $('#detailMaklumanBil').html("Sila isi semua ruangan yang bertanda *");
            //} else {
            // open modal confirmation
            $('#confirmationModal').modal('toggle');
            //}
        })

        $('.btnYa').click(async function () {

            $('#confirmationModal').modal('toggle');
           
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
                    PTJPusatBajet: $('#ddlPTJPusat').val(),
                    Dasar: $('#ddlDasar').val(),
                    KumpWang: $('#ddlKW').val(),
                    KodKO: $('#ddlKO').val(),
                    KodKP: $('#ddlKP').val(),
                    Program: $('#txtProgram').val(),
                    Justifikasi: $('#txtJustifikasi').val(), 
                    Jumlah: $('#totalJumlah').val().replace(/,/g, ''), // Remove commas,
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

           
            var result = JSON.parse(await ajaxSaveOrder(newOrder));

            if (result.Status !== "Failed") {
                //$('#modalPenghutang').modal('toggle');
                // open modal makluman and show message
                $('#maklumanModalBil').modal('toggle');
                $('#detailMaklumanBil').html(result.Message);
                //clearAllFields();

                $('#ddlBahagian').dropdown('clear');
                $('#ddlBahagian').dropdown('refresh');

                $('#ddlUnit').dropdown('clear');
                $('#ddlUnit').dropdown('refresh');

                $('#ddlPTJPusat').dropdown('clear');
                $('#ddlPTJPusat').dropdown('refresh');

                $('#ddlDasar').dropdown('clear');
                $('#ddlDasar').dropdown('refresh');

                $('#ddlKW').dropdown('clear');
                $('#ddlKW').dropdown('refresh');

                $('#ddlKO').dropdown('clear');
                $('#ddlKO').dropdown('refresh');

                $('#ddlKP').dropdown('clear');
                $('#ddlKP').dropdown('refresh');

                $('#lblNoMohon').val("");

                await clearAllRowsHdr();
                await clearAllRows();                
                await clearHiddenButton();
                AddRow(5);

                // refresh page after 2 seconds


                setTimeout(function () {
                    tbl.ajax.reload();
                }, 2000);
            } else {
                // open modal makluman and show message
                $('#maklumanModalBil').modal('toggle');
                $('#detailMaklumanBil').html(result.Message);



            }

            //alert(result.Message)
            //$('#orderid').val(result.Payload.OrderID)

            //loadExistingRecords();
            //await clearAllRows();
            // AddRow(5);



        });

        //$('.btn-danger').click(async function () {
        //    $('#lblNoJurnal').val("")
        //    await clearAllRows();
        //    await clearAllRowsHdr();
        //    await clearHiddenButton();
        //    AddRow(5);
        //});

        //$('.btnPapar').click(async function () {
        //    var record = await AjaxLoadOrderRecord_Senarai("");
        //    //$('#lblNoJurnal').val("")
        //    await clearAllRows_senarai();
        //    await paparSenarai(null, record);

        //    //tblDataSenarai.draw();
        //});

        $("#ddlBahagian").on('change', function () {

            generateDropdown("ddlUnit", "Awal_Tahun_WS.asmx/GetListUnit", null, true, "ddlBahagian");
        });

        $('.btnLoad').on('click', async function () {
            loadExistingRecords();
        });

        async function loadExistingRecords() {
            var record = await AjaxLoadOrderRecord($('#lblNoMohon').val());
            await clearAllRows();
            await AddRow(null, record);
        }

        async function clearAllRows() {
            $(tableID + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
            $(totalJumlah).val("0.00");
         
        }

        async function clearAllRowsHdr() {

            $('#lblNoMohon').val("");           
            $('#ddlBahagian').dropdown('clear');
            $('#ddlBahagian').dropdown('refresh');

            $('#ddlUnit').dropdown('clear');
            $('#ddlUnit').dropdown('refresh')

            $('#ddlPTJPusat').dropdown('clear');
            $('#ddlPTJPusat').dropdown('refresh')

            $('#ddlDasar').dropdown('clear');
            $('#ddlDasar').dropdown('refresh')

            $('#ddlKW').dropdown('clear');
            $('#ddlKW').dropdown('refresh')

            $('#ddlKO').dropdown('clear');
            $('#ddlKO').dropdown('refresh')

            $('#ddlKP').dropdown('clear');
            $('#ddlKP').dropdown('refresh')
;
            $('#txtProgram').val("");
            $('#txtJustifikasi').val("");
            $('#txtPerihal').val("");
           

        }

        async function clearHiddenButton() {

            $('.btnSimpan').show();
            $('.btnHantar').show();
            $('.btnAddRow').show();

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
            //console.log(order)
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Awal_Tahun_WS.asmx/SaveOrders_Bajet',
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
                const response = await fetch('Transaksi_WS.asmx/LoadOrderRecord_SenaraiTransaksiJurnal', {
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


        $(tableID).on('keyup', '.Jumlah', async function () {


            var curTR = $(this).closest("tr");
        
            var debit_ = $(curTR).find("td > .Jumlah");            
            var totalDebit = NumDefault(debit_.val())
           


            calculateGrandTotal();

            //START BIL COUNT DATATABLE...
            var columnIndexToCount = 3; // Change this to the desired column index (0-based)
            var rowCount = 0;

            $("#tableID").find("tr").each(function () {
                var cellValue = $(this).find("td:eq(" + columnIndexToCount + ")").text();

                // Check if the cell has data
                if (cellValue.trim() !== "") {
                    rowCount++;
                }
            });

            //console.log("Number of rows with data in column " + columnIndexToCount + ": " + rowCount);
            document.getElementById('result').textContent = rowCount + " Item :";

            //END BIL COUNT


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

        $('.btnAddRow').click(async function () {
            var totalClone = $(this).data("val");

           await AddRow(totalClone);
        });

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
            //console.log("aa" +objOrder)
            while (counter <= totalClone) {

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
                        //console.log("aa" + objOrder.Payload[counter - 1])
                        await setValueToRow_Transaksi(row, objOrder.Payload[counter - 1]);

                    }
                }
                counter += 1;
            }
        }

        async function initDropdownObjAm(id) {

            $('#' + id).dropdown({
                selectOnKeydown: true,
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

                        if (listOptions.length === 0) {
                            $(objItem).html('<div class="message">Rekod Tidak Dijumpai.</div>');
                            return false;
                        }

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

        async function setValueToRow_HdrBajet(orderDetail) {          
            //console.log(orderDetail.Kod_Kump_Wang)
            $('#lblNoMohon').val(orderDetail.No_Mohon)
            $('#txtTarikh').val(orderDetail.Tkh_Transaksi)

            $('#txtProgram').val(orderDetail.Program)
            $('#txtJustifikasi').val(orderDetail.Justifikasi)


            buildDdl('ddlBahagian', orderDetail.Kod_Bahagian, orderDetail.Butir_Kod_Bahagian);
            buildDdl('ddlUnit', orderDetail.Kod_Unit, orderDetail.Butir_Kod_Unit);
            buildDdl('ddlKW', orderDetail.Kod_Kump_Wang, orderDetail.Butir_Kod_Kump_Wang);
            buildDdl('ddlKO', orderDetail.Kod_Operasi, orderDetail.Butir_Kod_Operasi);
            buildDdl('ddlKP', orderDetail.Kod_Projek, orderDetail.Butir_Kod_Projek);
            buildDdl('ddlDasar', orderDetail.Kod_Dasar, orderDetail.Butir_Kod_Dasar);
            buildDdl('ddlPTJPusat', orderDetail.PTJ_Pusat, orderDetail.Butir_PTJ_Pusat);

            ////alert(orderDetail.Kod_Dasar +" ptjpusat " + orderDetail.PTJ_Pusat)
            //$("#ddlKW").dropdown('set selected', orderDetail.Kod_Kump_Wang)
            //$("#ddlKO").dropdown('set selected', orderDetail.Kod_Operasi)
            //$("#ddlKP").dropdown('set selected', orderDetail.Kod_Projek)
            //$("#ddlDasar").dropdown('set selected', orderDetail.Kod_Dasar)
            //$("#ddlPTJPusat").dropdown('set selected', orderDetail.PTJ_Pusat)
            //alert(orderDetail.Status_Dok)
            if (orderDetail.Status_Dok !== "01") {
                $('.btnSimpan').hide();
                $('.btnAddRow').hide();
                $('.btnDelete').prop('disabled', true).show();
            }
            else {
                $('.btnSimpan').show();
                $('.btnAddRow').show();
                $('.btnDelete').prop('disabled', false).show();
                
            }
        }

        function buildDdl(id, kodVal, ButirVal) {

            //    //var getName0 = getBahagian_Name(kodVal)
            ////if (id = "ddlKW") {
            ////    //alert("if " + kodVal)
            ////    var getName1 = getKW_Name(kodVal)
            ////}

            //if (id = "ddlKO") {
            //    //alert("if " + kodVal)
            //    var getName2 = getKo_Name(kodVal)
            //}

            //if (id = "ddlKP") {
            //    //alert("if " + kodVal)
            //    var getName3 = getKp_Name(kodVal)
            //}
            //    //var getName2 = getKo_Name(kodVal)
            //    //var getName3 = getKp_Name(kodVal)
            //    //var getName4 = getDasar_Name(kodVal)

            //if (id = "ddlDasar") {
            //    //alert("if " + kodVal)
            //    var getName5 = getDasar_Name(kodVal)
            //}
                
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


            var no = $(row).find("td > .lblNo");
            var no1 = $(row).find("td > .lblNo");
            var rujukan = $(row).find("td > .lblRujukan");
            var butiran = $(row).find("td > .lblButiran");
            var jumlah = $(row).find("td > .lblJumlah");
            var tarikh = $(row).find("td > .lblTkh");
            var statusDok = $(row).find("td > .lblStatusDok");


            no.html(orderDetail.No_Jurnal);
            no1.val(orderDetail.No_Jurnal);
            rujukan.html(orderDetail.No_Rujukan);
            butiran.html(orderDetail.Butiran);
            jumlah.html(orderDetail.Jumlah);
            tarikh.html(orderDetail.Tkh_Transaksi);
            statusDok.html(orderDetail.Kod_Status_Dok);


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

        // add clickable event in DataTable row
        async function rowClickHandler(id) {
            if (id !== "") {
                // modal dismiss
                $('#permohonan').modal('toggle');                

                //BACA HEADER JURNAL
                var recordHdr = await AjaxGetRecordHdrBajet(id);
                //console.log("aa " + recordHdr);
                await AddRowHeader(null, recordHdr);

                //BACA DETAIL JURNAL
                var record = await AjaxGetRecordBajet(id);
                //console.log("aa " + record);
                await clearAllRows();
                await AddRow(null, record);


            }
        }


        async function AddRowHeader(totalClone, objOrder) {
            var counter = 1;
            //var table = $('#tblDataSenarai');

            //console.log(" counter " + objOrder)

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;

                //console.log("AddRowHeader 1" + objOrder.Payload.length);
            }
        

            if (counter <= objOrder.Payload.length) {
                await setValueToRow_HdrBajet(objOrder.Payload[counter - 1]);

                //console.log("AddRowHeader2");
            }
          
        }


        async function AjaxGetRecordBajet(id) {

            try {

                const response = await fetch('Awal_Tahun_WS.asmx/LoadRecordBajet', {
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
            //console.log("id "+id)
            try {

                const response = await fetch('Awal_Tahun_WS.asmx/LoadHdrBajet', {
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

        function getDateNow() {
            //Cara Pertama

            fetch('Awal_Tahun_WS.asmx/LoadDateNow', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                body: JSON.stringify()
            })
                .then(response => response.json())
                .then(data => setDateNow(data.d))

        }

        function setDateNow(data) {

            data = JSON.parse(data);

            if (data.curDateNow === "") {
                alert("Tiada data");
                return false;
            }

            // Assuming data[0].curDateNow is in format YYYY-MM-DD (e.g., "2024-02-22")
            var curDate = new Date(data[0].curDateNow);
            var day = curDate.getDate();
            var month = curDate.getMonth() + 1; // Month is zero-based, so we add 1
            var year = curDate.getFullYear();

            // Formatting day and month to ensure they have leading zeros if necessary
            day = (day < 10 ? '0' : '') + day;
            month = (month < 10 ? '0' : '') + month;

            // Creating the date string in the desired format
            var formattedDate = day + '-' + month + '-' + year;

            // Setting the value of the input element
            document.getElementById("txtTarikh").value = formattedDate;

        }

        function getPTJ() {
            //Cara Pertama

            fetch('Awal_Tahun_WS.asmx/LoadPTJ', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                body: JSON.stringify()
            })
                .then(response => response.json())
                .then(data => setPTJ(data.d))

        }

        function setPTJ(data) {

            data = JSON.parse(data);

            if (data.KodPejPBU === "") {
                alert("Tiada data");
                return false;
            }

            document.getElementById("txtPTJ").value = data[0].KodPejPBU + " - " + data[0].Pejabat;           
            document.getElementById("Hid-ptj-list").innerHTML = data[0].KodPejPBU;
        }

        function getPTJ_Pusat() {
            //Cara Pertama

            fetch('Awal_Tahun_WS.asmx/LoadPTJ', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                body: JSON.stringify()
            })
                .then(response => response.json())
                .then(data => setPTJ_Pusat(data.d))

        }

        function setPTJ_Pusat(data) {
         
            data = JSON.parse(data);

            if (data.KodPejPBU === "") {
                alert("Tiada data");
                return false;
            }

            else {
                return data[0].KodPejPBU;
            }

          
        }

        function getKW_Name(KodKW) {
                      
            fetch('Awal_Tahun_WS.asmx/LoadKW', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },             
                body: JSON.stringify({ KodKW: KodKW })
            })
                .then(response => response.json())
                .then(data => setKW_Nama(data.d))

        }

        function setKW_Nama(data) {

            data = JSON.parse(data);
            //alert("vv " + data[0].NamaKW)
            if (data.NamaKW === "") {
                alert("Tiada data");
                return false;
            }

            else {
              
                $("#ddlKW").html("<option value = '" + data[0].KodKW + "'>" + data[0].NamaKW  + "</option>")
            }


        }

        function getKo_Name(KodKO) {

            fetch('Awal_Tahun_WS.asmx/LoadKO', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                body: JSON.stringify({ KodKO: KodKO })
            })
                .then(response => response.json())
                .then(data => setKo_Nama(data.d))

        }

        function setKo_Nama(data) {

            data = JSON.parse(data);
            //alert("vv " + data[0].NamaKo)
            if (data.NamaKo === "") {
                alert("Tiada data");
                return false;
            }

            else {

                $("#ddlKO").html("<option value = '" + data[0].KodKo + "'>" + data[0].NamaKo + "</option>")
            }


        }

        function getKp_Name(KodKP) {

            fetch('Awal_Tahun_WS.asmx/LoadKP', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                body: JSON.stringify({ KodKP: KodKP })
            })
                .then(response => response.json())
                .then(data => setKp_Nama(data.d))

        }

        function setKp_Nama(data) {

            data = JSON.parse(data);
            //alert("vv " + data[0].NamaKo)
            if (data.NamaKp === "") {
                alert("Tiada data");
                return false;
            }

            else {

                $("#ddlKP").html("<option value = '" + data[0].KodKp + "'>" + data[0].NamaKp + "</option>")
            }


        }

        function getDasar_Name(KodDasar) {
            //alert("KodDasar " + KodDasar)
            fetch('Awal_Tahun_WS.asmx/LoadDasar', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                body: JSON.stringify({ KodDasar: KodDasar })
            })
                .then(response => response.json())
                .then(data => setDasar_Nama(data.d))

        }

        function setDasar_Nama(data) {

            data = JSON.parse(data);
            //alert("vv " + data[0].NamaKo)
            if (data.NamaDasar === "") {
                alert("Tiada data");
                return false;
            }

            else {

                $("#ddlDasar").html("<option value = '" + data[0].KodDasar + "'>" + data[0].NamaDasar + "</option>")
            }


        }

        function getPTJPusat_Name(Kod) {
        //alert("pusat "+Kod)
            fetch('Awal_Tahun_WS.asmx/LoadPTJ_Pusat', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                body: JSON.stringify({ Kod: Kod })
            })
                .then(response => response.json())
                .then(data => setPTJPusat_Nama(data.d))

        }

        function setPTJPusat_Nama(data) {

            data = JSON.parse(data);
            //alert("vv " + data[0].text)
            if (data.text === "") {
                alert("Tiada data");
                return false;
            }

            else {

                $("#ddlPTJPusat").html("<option value = '" + data[0].value + "'>" + data[0].text + "</option>")
            }


        }
    </script>

</asp:Content>
