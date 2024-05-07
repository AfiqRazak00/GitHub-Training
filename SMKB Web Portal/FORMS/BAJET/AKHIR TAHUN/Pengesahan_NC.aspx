<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pengesahan_NC.aspx.vb" Inherits="SMKB_Web_Portal.Pengesahan_NC" %>

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
            background-color: #ffc83d !important;
        }

        #tblDataSenarai_trans td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        #tblDataSenarai_trans th {
            border: 1px solid #ddd;
            background-color: #f2f2f2;
            text-align: left;
            padding: 8px;
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

        .auto-style3 {
            width: 93px;
        }

        .auto-style4 {
            width: 89px;
        }
    </style>


    <div id="PermohonanTab" class="tabcontent" style="display: block">

        <!-- Modal -->
       
        <div class="container-fluid">
            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item active" role="presentation"><a class="nav-link active" data-toggle="tab" id="tab-pemohon" href="#home">Senarai Permohonan</a></li>
                <li class="nav-item" role="presentation" style="visibility:hidden"><a class="nav-link" data-toggle="tab" id="tab-abm" href="#menu1">ABM</a></li>
            </ul>
            <div class="tab-content">
                <div id="home" class="tab-pane fade in active show">

                    <asp:Panel ID="Panel1" runat="server">
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
                                                    <button id="btnSearch_Mohon" runat="server" class="btn btn-outline btnSearch_Mohon" type="button">
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
                                <table id="tblDataSenarai_trans_" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>                                          
                                            <th scope="col">No. Mohon</th>
                                            <th scope="col">Program</th>
                                            <th scope="col">Justifikasi</th>
                                            <th scope="col">Jumlah (RM)</th>
                                            <th scope="col">Tarikh Transaksi</th>
                                           <%-- <th scope="col">Status</th>                 --%>                           

                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_trans_" style="cursor:pointer">
                                    </tbody>

                                </table>

                            </div>
                        </div>
                    </div>
                    </asp:Panel>
                </div>
                <div id="menu1" class="tab-pane fade in " role="tabpanel">
                    <asp:Panel ID="Panel2" runat="server">
                         <div id="permohonan">
            <div >     
                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
                                <label for="inputEmail3" class="col-sm-3 col-form-label" style="text-align: right">Kumpulan Wang:</label>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <select id="categoryKW" name="categoryKW" class="input-group__select ui search dropdown">
                                        </select>
                                        <div class="input-group-append">
                                            <button id="btnSearch" runat="server" class="btn btn-outline btnSearch" type="button">
                                                <i class="fa fa-search"></i>
                                                Cari
                                            </button>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
              
            </div>
        </div>
                          <div class="modal-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataSenarai_trans" class="table table-striped" style="width: 99%">
                                    <thead>
                                        <tr>
                                            <th scope="col" colspan ="2"></th>
                                            <th scope="col" colspan ="2" style="text-align: center;">VOT 10000</th>
                                            <th scope="col" colspan ="2" style="text-align: center;">VOT 20000</th>
                                            <th scope="col" colspan ="2" style="text-align: center;">VOT 30000</th>
                                            <th scope="col" colspan ="2" style="text-align: center;">VOT 40000</th>
                                            <th scope="col" colspan ="2" style="text-align: center;">VOT 50000</th>
                                            <th scope="col" colspan ="3"></th>
                                        </tr>
                                        <tr>                                          
                                            <th scope="col" style="text-align: center;">Bil.</th>
                                            <th scope="col" style="text-align: center;" class="auto-style4" >Bahagian</th>
                                            <th scope="col" style="text-align: center;">Operasi (RM)</th>
                                            <th scope="col" style="text-align: center;">Komited (RM)</th>
                                            <th scope="col" style="text-align: center;">Operasi (RM)</th>
                                            <th scope="col" style="text-align: center;" class="auto-style3">Komited (RM)</th>  
                                            <th scope="col" style="text-align: center;">Operasi (RM)</th>
                                            <th scope="col" style="text-align: center;">Komited (RM)</th> 
                                            <th scope="col" style="text-align: center;">Operasi (RM)</th>
                                            <th scope="col" style="text-align: center;">Komited (RM)</th> 
                                            <th scope="col" style="text-align: center;">Operasi (RM)</th>
                                            <th scope="col" style="text-align: center;">Komited (RM)</th> 
                                            <th scope="col" style="text-align: center;">Jumlah Operasi (RM)</th> 
                                            <th scope="col" style="text-align: center;">Jumlah Komited (RM)</th> 
                                            <th scope="col" style="text-align: center;">Jumlah Permohonan (RM)</th> 
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_trans" >
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <th colspan="2" style="text-align: right">Jumlah Besar (RM)</th>
                                            <th style="text-align: right"></th>
                                            <th style="text-align: right"></th>
                                            <th style="text-align: right"></th>
                                            <th style="text-align: right" class="auto-style3"></th>
                                            <th style="text-align: right"></th>
                                            <th style="text-align: right"></th>
                                            <th style="text-align: right"></th>
                                            <th style="text-align: right"></th>
                                            <th style="text-align: right"></th>
                                            <th style="text-align: right"></th>
                                            <th style="text-align: right"></th>
                                            <th style="text-align: right"></th>
                                            <th style="text-align: right"></th>                                            
                                        </tr>
                                        
                                    </tfoot>
                                </table>

                            </div>
                        </div>
                    </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
          <div class="modal fade" id="modalInvoisData" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" style="min-width: 80%" id="modalInvoisDataP" role="document">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky" style="border-bottom: none !important">


                        <div class="container-fluid mt-3">
                            <ul class="nav nav-tabs" id="subTab" role="tablist">
                                <li class="nav-item" role="presentation" onclick="subTabChange(event)" data-tab="ALL">
                                    <a class="nav-link active" tabindex="-1" data-tab="ALL" aria-disabled="true">Maklumat Agihan</a>
                                </li>
                                <li class="nav-item" role="presentation" onclick="subTabChange(event)" data-tab="Sbg">
                                    <a class="nav-link " tabindex="-1" data-tab="Sbg" aria-disabled="true">Butiran Permohonan</a>
                                </li>
                                <li class="nav-item" role="presentation" onclick="subTabChange(event)" data-tab="Dtl">
                                    <a class="nav-link " tabindex="-1" data-tab="Dtl" aria-disabled="true">Maklumat Lanjut Permohonan</a>
                                </li>
                            </ul>
                        </div>


                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="ALL" class="modal-sub-tab mt-2">
                            <div  class="modal-body">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="col-md-2">
                                            <input type="text" class=" input-group__input  form-control input-sm " placeholder="&nbsp;" id="txtTahunBajet" name="txtTahunBajet" readonly />
                                            <label class="input-group__label">Tahun Bajet</label>
                                        </div>
                                        <div class="col-md-4">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="&nbsp;" name="txtKW" id="txtKW" readonly>
                                            <label class="input-group__label">Kumpulan Wang</label>
                                        </div>
                                        <div class="col-md-3">
                                            <input type="text" class="input-group__input form-control input-sm  " placeholder="&nbsp;" id="txtKO" name="txtKO" readonly>
                                            <label class="input-group__label">Kod Operasi</label>
                                        </div>
                                        <div class="col-md-3">
                                            <input type="text" class="input-group__input form-control input-sm  " placeholder="&nbsp;" id="txtBahagian" name="txtBahagian" readonly>
                                            <label class="input-group__label">Bahagaian</label>
                                        </div>
                                    </div>
                                </div>
                        
                            </div>   
                          
                            <div class="modal-body">
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblDataObjekAm" class="table table-striped;" style="width: 99%"  >
                                            <thead>
                                                <tr>
                                                    <th scope="col" colspan="1" style="text-align: center; ">Bil.</th>
                                                    <th scope="col" colspan="4" style="text-align: center; " >Vot Sebagai</th>
                                                    <th scope="col" colspan="4" style="text-align: center; ">Mohon (RM)</th>
                                                    <th scope="col" colspan="1" style="text-align: center; ">Papar</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tableID_Senarai_ObjekAm">
                                                <tr style="display: none; width: 100% " >
                                                    <td colspan="1" style="text-align: center;  ">
                                                        <label id="RowCountBil" name="RowCountBil" runat="server" class="RowCountBil" style="text-align: left" width="60%" />
                                                    </td>
                                                    <td colspan="4" style="text-align: left; ">
                                                        <label id="ObjSebagai" name="ObjSebagai" runat="server" class="ObjSebagai"  width="60%" />
                                                    </td>
                                                     <td colspan="4" style="text-align: right; ">
                                                       <label id="JumlahSbg" name="JumlahSbg" runat="server" class="JumlahSbg"  width="60%" />
                                                     </td>
                                                    <td colspan="1" style="text-align: center;  ">
                                                        <button id="ObjSebagaiAll" class="btn ObjSebagaiAll" name="ObjSebagaiAll" type="button" data-toggle="tooltip" data-placement="top" onClick="ShowDetails_Sbg(this)">                                                   
                                                            <i class="fa fa-search"></i>
                                                         </button>                                                        
                                                      
                                                    </td>
                                                </tr>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th colspan="5" style="text-align: right">Jumlah Besar (RM)</th>
                                                    <th style="text-align: right"><label id="JumlahAm" name="JumlahAm" runat="server" class="JumlahAm"  width="60%" /></th>
                                                </tr>
                                            </tfoot>
                                        </table>

                                    </div>
                                </div>
                            </div>                                          
                             </div>            

                        <div id="Sbg" class="modal-sub-tab mt-2">
                              <div  class="modal-body" >
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="col-md-1">
                                            <input type="text" class=" input-group__input  form-control input-sm " placeholder="&nbsp;" id="txtObjSbg" name="txtObjSbg" readonly />
                                            <label class="input-group__label">Objek sebagai</label>
                                        </div>
                                      <div class="col-md-3">
                                            <input type="text" class=" input-group__input  form-control input-sm " placeholder="&nbsp;" id="txtButiranSbg" name="txtButiranSbg" readonly />
                                            <label class="input-group__label">Butiran</label>
                                        </div>
                                    </div>
                                </div>
                        
                            </div>
                      
                            <div class="modal-body">
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblDataPaparPermohonan" class="table table-striped" style="width: 99%"  >
                                            <thead>
                                                <tr>
                                                    <th scope="col" colspan="1" style="text-align: center;">Bil.</th>
                                                    <th scope="col" colspan="4" style="text-align: center;">Program</th>
                                                    <th scope="col" colspan="4" style="text-align: center;">Butiran</th>
                                                    <th scope="col" colspan="4" style="text-align: center;">Mohon (RM)</th>
                                                    <th scope="col" colspan="1" style="text-align: center;">Papar</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tableID_DataPaparPermohonan" class="table table-striped" > 
                                                <tr style="display: none; width: 100%" >                                                   
                                                    <td colspan="1" style="text-align: left;">
                                                        <label id="RowCountProgram" name="RowCountProgram" runat="server" class="RowCountProgram" style="text-align: left" width="60%" />
                                                    </td>
                                                    <td colspan="4" style="text-align: left;">
                                                        <label id="Program" name="Program" runat="server" class="Program"  width="60%" />
                                                    </td>
                                                     <td colspan="4" style="text-align: left;">
                                                       <label id="Butiran1" name="Butiran1" runat="server" class="Butiran1"  width="60%" />
                                                     </td>
                                                    <td colspan="4" style="text-align: right;">
                                                       <label id="Jumlah1" name="Jumlah1" runat="server" class="Jumlah1"  width="60%" />
                                                     </td>
                                                     <td colspan="1" style="text-align: center;">
                                                        <button id="paparPermohonan" class="btn paparPermohonan" name="paparPermohonan" type="button" data-toggle="tooltip" data-placement="top" onClick="ShowDetails_Permohonan(this)">                                                   
                                                            <i class="fa fa-search"></i>
                                                         </button>                                                        
                                                      
                                                    </td>
                                                </tr>
                                            </tbody>
                                           <tfoot>
                                                <tr>
                                                    <th colspan="10" style="text-align: right">Jumlah Besar (RM)</th>
                                                    <th style="text-align: right"><label id="TotalJumlahSbg" name="TotalJumlahSbg" runat="server" class="TotalJumlahSbg"  width="60%" /></th>
                                                </tr>
                                            </tfoot>
                                        </table>

                                    </div>
                                </div>
                            </div> 
                        </div>

                        <div id="Dtl" class="modal-sub-tab mt-2">
                           <div id="transaksi" >
                <div>
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
                        <select class="input-group__select ui search dropdown" name="ddlBahagian" id="ddlBahagian" placeholder="&nbsp;">
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
                                <th scope="col">Dokumen (PDF)</th>
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
                                    <input id="Text1" name="Butiran" runat="server" type="text" class="form-control underline-input Butiran" style="text-align: left" width="60%" />
                                </td>
                               <td style="width: 26%">
                                    <input id="File1" name="UploadDok" runat="server" type="file" class="form-control underline-input UploadDok" style="text-align: left" width="60%" />
                                </td>
                                <td style="width: 10%">
                                    <input id="Number1" name="Jumlah" runat="server" type="number" class="form-control underline-input Jumlah" style="text-align: right" width="10%" value="0.00" /></td>
                               
                                <td style="width: 4%">
                                    <button id="Button1" runat="server" class="btn btnDelete" type="button" style="color: red">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </td>

                            </tr>
                        </tbody>
                        <tfoot class="sticky-footer">
                            <tr>
                                <td colspan="3"></td>
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

                        </tfoot>
                    </table>
        </div>
                                </div>
                            </div>
                                <div class="modal-footer modal-footer--sticky" style="padding:0px!important">
                                <%--<button type="button" class="btn btn-danger">Padam</button>
                                <button type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                                <button type="button" class="btn btn-success btnHantar" data-toggle="tooltip" data-placement="bottom" title="Simpan dan Hantar">Hantar</button>--%>
                                <button type="button" class="btn btn-setsemula btnXLulus" data-toggle="tooltip" data-placement="bottom" >Hapus</button>
                                <button type="button" class="btn btn-success btnLulus" data-toggle="tooltip" data-placement="bottom" >Simpan</button>
                                

                        </div>
                    </div>
                </div>
            </div>
        </div>
                        </div>
                    </div>
              
                </div>
            </div>
        </div>
    


     <div class="modal fade" id="transaksi_mohon" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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
                         <label id="Hid-ptj-list_mhn" name="Hid-ptj-list_mhn" class="Hid-ptj-list_mhn" style="display: none;"></label>
                        <div class="form-group col-md-3">
                        <input class="input-group__input" id="lblNoMohon_mhn" type="text" placeholder="&nbsp;" name="No. Mohon"  readonly style="background-color: #f0f0f0"/>
                        <label class="input-group__label" for="No. Mohon">No. Mohon</label>
                        </div>

              
                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="txtTarikh_mhn" type="text" placeholder="&nbsp;" name="Tarikh Transaksi" readonly style="background-color: #f0f0f0"/>
                        <label class="input-group__label" for="Tarikh Mohon">Tarikh Mohon</label>
                        </div>

                        <div class="form-group col-md-6" ">
                            <input class="input-group__input" id="txtPTJ_mhn" type="text" placeholder="&nbsp;" name="PTj/PBU" readonly style="background-color: #f0f0f0"/>
                            
                        <label class="input-group__label" for="PTJ">PTj/PBU</label>
                        </div>

                    </div>
                </div>

                <div class="col-md-12" style="margin-top:5px">
                    <div class="form-row">

                        <div class="form-group col-md-3">
                        <select class="input-group__select ui search dropdown" name="ddlBahagian_mhn" id="ddlBahagian_mhn" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlBahagian_mhn">Bahagian</label>
                        </div>

                        <div class="form-group col-md-3">
                         <select class="input-group__select ui search dropdown ListUnit" name="ddlUnit_mhn" id="ddlUnit_mhn" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlUnit_mhn">Unit</label>
                        </div>

                        <div class="form-group col-md-6">
                          <select class="input-group__select ui search dropdown ListPTJPusat" name="ddlPTJPusat_mhn" id="ddlPTJPusat_mhn" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlPTJPusat_mhn">Bajet PTJ Berpusat (Sekiranya Ada)</label>
                        </div>
             </div>
                </div>
                <div class="col-md-12" style="margin-top: 5px">
                    <div class="form-row">                         
                        <div class="form-group col-md-3">
                        <select class="input-group__select ui search dropdown ListKW" name="ddlKW_mhn" id="ddlKW_mhn" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlKW_mhn">Kumpulan Wang</label>
                        </div>
                        <div class="form-group col-md-3">
                        <select class="input-group__select ui search dropdown ListOperasi" name="ddlKO_mhn" id="ddlKO_mhn" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlKO_mhn">Kod Operasi</label>
                        </div>
                        <div class="form-group col-md-3">
                        <select class="input-group__select ui search dropdown ListKp" name="ddlKP_mhn" id="ddlKP_mhn" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlKP_mhn">Kod Projek</label>
                        </div>
                        <div class="form-group col-md-3">
                        <select class="input-group__select ui search dropdown ListDasar" name="ddlDasar_mhn" id="ddlDasar_mhn" placeholder="&nbsp;">
                                </select>
                                <label class="input-group__label" for="ddlDasar_mhn">Dasar</label>
                        </div>
                    </div>
                </div>
                <div class="col-md-12" style="margin-top: 5px">
                    <div class="form-row">
                        <div class="form-group col-md-12">
                            <textarea class="input-group__input" id="txtProgram_mhn" type="text" rows="2" placeholder="&nbsp;" name="Program / Aktiviti"></textarea><label class="input-group__label" for="Program / Aktiviti">Program / Aktiviti</label>
                        </div>
                    </div>
                </div>
                 <div class="col-md-12" style="margin-top: 5px">
                    <div class="form-row">
                        <div class="form-group col-md-12">
                             <textarea class="input-group__input " id="txtJustifikasi_mhn" type="text" placeholder="&nbsp;" name="Justifikasi"></textarea>
                        <label class="input-group__label" for="Justifikasi">Justifikasi</label>
                        </div>
                    </div>
                </div>
            </div>


                            <hr>
                            <div class="form-row">

   <h6>Butiran Permohonan</h6>

        <div class="secondaryContainer transaction-table table-responsive">

            <table  id="tblData_mhn"  class="table table-striped">
                        <thead>
                            <tr>
                                <th scope="col">Vot</th>                             
                                <th scope="col">Butiran</th>
                              <%--  <th scope="col">Dokumen (PDF)</th>--%>
                                <th scope="col">Jumlah (RM)</th>
                                <th scope="col">Tindakan</th>

                            </tr>
                        </thead>
                        <tbody id="tableID_mhn">
                            <tr style="display: none; width: 100%" class="table-list">
                                <td style="width: 20%">
                                    <select class="ui search dropdown ObjAm-list_mhn" name="ddlObjAm" id="ddlObjAm_mhn"></select>
                                    <input type="hidden" class="data-id" value="" />
                                    <label id="hidObgAm_mhn" name="hidObjAm" class="Hid-objAm-list_mhn" style="display: none;"></label>
                                </td>
                              
                                <td style="width: 45%">
                                    <input id="Butiran_mhn" name="Butiran_mhn" runat="server" type="text" class="form-control underline-input Butiran_mhn" style="text-align: left" width="60%" />
                                </td>
                             <%--  <td style="width: 26%">
                                    <input id="UploadDok_mhn" name="UploadDok_mhn" runat="server" type="file" class="form-control underline-input UploadDok_mhn" style="text-align: left" width="60%" />
                                </td>--%>
                                <td style="width: 10%">
                                    <input id="Jumlah_mhn" name="Jumlah_mhn" runat="server" type="number" class="form-control underline-input Jumlah_mhn" style="text-align: right" width="10%" value="0.00" /></td>
                               
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
                                    <input class="form-control underline-input" id="totalJumlah_mhn" name="totalJumlah_mhn" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly /></td>
                                
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

                        </tfoot>
                    </table>
        </div>
                                </div>
                            </div>
                                <div class="modal-footer modal-footer--sticky" style="padding:0px!important">
                                <%--<button type="button" class="btn btn-danger">Padam</button>
                                <button type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                                <button type="button" class="btn btn-success btnHantar" data-toggle="tooltip" data-placement="bottom" title="Simpan dan Hantar">Hantar</button>--%>
                                <button type="button" class="btn btn-setsemula btnXLulus_mhn" data-toggle="tooltip" data-placement="bottom" >Tidak Lulus</button>
                                <button type="button" class="btn btn-success btnLulus_mhn" data-toggle="tooltip" data-placement="bottom" >Lulus</button>
                                

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
                                Anda pasti ingin simpan rekod ini?
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

            function ShowDetails(tahun, kw, ko, kp, ptj, votam) {
                if (tahun !== "") {

                      <%--  if (status == "NOTDONE") {
                            location.replace('<%=ResolveClientUrl("~/FORMS/BAJET/Terimaan/Terima_Terperinci.aspx")%>?kodpenghutang=' + id + '&status=03', '_blank');
                        } else if (status == "DONE") {
                            $('#modalInvoisData').modal('toggle');
                            showTab("ALL")
                        }--%>

                    showInvoisData(tahun, kw, ko, kp, ptj, votam)

                }

            }

            async function ShowDetails_Sbg(obj) {

                var valKodVotSbg = $(obj).data("kodvot")
                var valkw = $(obj).data("kodkw")
                var valko = $(obj).data("kodko")

               // var $row = $(obj).closest("tr");
                //var txtbox = $($row).find(".ObjSebagai");
               // alert("test " + valKodVot)
                //var $cell = $row.eq("0");

               // location.replace('<%=ResolveClientUrl("~/FORMS/BAJET/AWAL TAHUN/Semakan_PTJ.aspx")%>?Semakan_PTJ=' + valKodVot);

                //onclick = "rowClickHandlerABM('${valtahun}','${valkw}','${valko}','${valkp}','${valPtj}','${valVotAm}')" > ${ data }

                var valtahun = $('#txtTahunBajet').val();


                var valkp = "0000000"
                var valPtj = $('#txtBahagian').val();
                var kodTab = "2"


                await rowClickHandlerABM(valtahun, valkw, valko, valkp, valPtj, valKodVotSbg, kodTab);

            }

            async function ShowDetails_Permohonan(obj) {

                var valNoMohon = $(obj).data("NoMohon")

                await rowClickHandlerPapar(valNoMohon);

            }

            var tbl_ = null
            var isClicked_ = false;
            $(document).ready(function () {

                tbl_ = $("#tblDataSenarai_trans_").DataTable({
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
                        "url": "Akhir_Tahun_WS.asmx/LoadOrderRecord_SenaraiMohonBajet_NC",
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
                                isClicked: isClicked_,
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
                            rowClickHandler_Kew(data.No_Mohon);

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
                        { "data": "Jumlah", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },

                        { "data": "Tkh_Transaksi" },
                        //{
                        //    "data": "Kod_Status_Dok",
                        //    render: function (data, type, row, meta) {

                        //        var link

                        //        if (data === "SELESAI KELULUSAN") {
                        //            link = `<td style="width: 10%" >
                        //                        <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:blue;" >${data}</p>                                              
                        //                    </td>`;

                        //        }
                        //        else if (data === "GAGAL KELULUSAN") {
                        //            link = `<td style="width: 10%" >
                        //                        <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:blue;" >${data}</p>                                              
                        //                    </td>`;

                        //        }
                        //        else {
                        //            link = `<td style="width: 10%" >
                        //                        <p id="lblStatus" name="lblStatus" class="lblStatus" value="${data}" style="color:red;" >${data}</p>                                              
                        //                    </td>`;
                        //        }


                        //        return link;
                        //    }
                        //}



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

            //var tbl = null
            //var isClicked = false;
            //$(document).ready(function () {

            //    tbl = $("#tblDataSenarai_trans").DataTable({
            //        "responsive": true,
            //        "searching": false,
            //        "paging": false,
            //        "sPaginationType": false,
            //        "ordering": false,
            //        "info": false,
            //        "ajax": {
            //            "url": "Awal_Tahun_WS.asmx/LoadSummaryKewPTJ",
            //            method: 'POST',
            //            "contentType": "application/json; charset=utf-8",
            //            "dataType": "json",
            //            "dataSrc": function (json) {
            //                return JSON.parse(json.d);
            //            },
            //            "data": function () {

            //                var category_KW = $('#categoryKW').val()
            //                var tahunMohon = "2024"
            //                return JSON.stringify({
            //                    category_KW: category_KW,
            //                    isClicked: isClicked,
            //                    tahun: tahunMohon
            //                })
            //                //akhir sini
            //            }

            //        },

            //        "columns": [
            //            {
            //                "data": "Bil",
            //                "className": "text-center",
            //                "width": "2%",
            //                render: function (data, type, row, meta) {
            //                    if (type !== "display") {
            //                        return data;
            //                    }
            //                    // Adding <b> tags to bold the 'Bil' data
            //                    return `<b>${data}.</b>`;

            //                }
            //            },
            //            {
            //                "data": "Kod_Bahagian",
            //                "width": "10%",
            //                render: function (data, type, row, meta) {

            //                    if (type !== "display") {

            //                        return data;
            //                    }

            //                    var link = `<td style="width: 10%" >
            //                                    <label runat="server" id="lblNo1" name="lblNo1" class="lblNo1" value="${data}" >${data}</label>
            //                                </td>`;
            //                    return link;
            //                }
            //            },
            //            {
            //                "data": "Operasi_10000",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    //if (type === 'display') {
            //                    //    return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    //}
            //                    //return data;


            //                    var valtahun = row.Tahun_Bajet
            //                    var valkw = row.Kod_Kump_Wang
            //                    var valko = row.Kod_Operasi
            //                    var valkp = row.Kod_Projek
            //                    var valPtj = row.Kod_Bahagian
            //                    var valVotAm = "10000"
            //                    var KodTab = "1"

            //                    //combinedData = `${valtahun} - ${valkw} - ${valko}`;

            //                    var link = `
            //                        <td style="width: 10%" >
            //                        <label  data-toggle="tooltip" data-placement="top" title="Vot 10000" style="cursor: pointer;" onclick="rowClickHandlerABM('${valtahun}','${valkw}','${valko}','${valkp}','${valPtj}','${valVotAm}','${KodTab}')">${data}</label>
            //                        </td>`;
            //                    return link;

            //                }
            //            },
            //            {
            //                "data": "Komited_10000",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    //if (type === 'display' || type === 'filter') {
            //                    //    return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    //}
            //                    //return data;\

            //                    var valtahun = row.Tahun_Bajet
            //                    var valkw = row.Kod_Kump_Wang
            //                    var valko = row.Kod_Operasi
            //                    var valkp = row.Kod_Projek
            //                    var valPtj = row.Kod_Bahagian
            //                    var valVotAm = "10000"
            //                    var KodTab = "1"

            //                    //console.log(row.Kod_Operasi)
            //                    //combinedData = `${valtahun} - ${valkw} - ${valko}`;

            //                    var link = `
            //                        <td style="width: 10%" >
            //                        <label  data-toggle="tooltip" data-placement="top" title="Vot 10000" style="cursor: pointer;" onclick="rowClickHandlerABM('${valtahun}','${valkw}','${valko}','${valkp}','${valPtj}','${valVotAm}','${KodTab}')">${data}</label>
            //                        </td>`;
            //                    return link;

            //                }
            //            },
            //            {
            //                "data": "Operasi_20000",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    //if (type === 'display' || type === 'filter') {
            //                    //    return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    //}
            //                    //return data;
            //                    var valtahun = row.Tahun_Bajet
            //                    var valkw = row.Kod_Kump_Wang
            //                    var valko = row.Kod_Operasi
            //                    var valkp = row.Kod_Projek
            //                    var valPtj = row.Kod_Bahagian
            //                    var valVotAm = "20000"
            //                    var KodTab = "1"

            //                    //combinedData = `${valtahun} - ${valkw} - ${valko}`;

            //                    var link = `
            //                        <td style="width: 10%" >
            //                        <label  data-toggle="tooltip" data-placement="top" title="Vot 20000" style="cursor: pointer;" onclick="rowClickHandlerABM('${valtahun}','${valkw}','${valko}','${valkp}','${valPtj}','${valVotAm}','${KodTab}')">${data}</label>
            //                        </td>`;
            //                    return link;
            //                }
            //            },
            //            {
            //                "data": "Komited_20000",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    //if (type === 'display' || type === 'filter') {
            //                    //    return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    //}
            //                    //return data;

            //                    var valtahun = row.Tahun_Bajet
            //                    var valkw = row.Kod_Kump_Wang
            //                    var valko = row.Kod_Operasi
            //                    var valkp = row.Kod_Projek
            //                    var valPtj = row.Kod_Bahagian
            //                    var valVotAm = "20000"
            //                    var KodTab = "1"

            //                    //combinedData = `${valtahun} - ${valkw} - ${valko}`;

            //                    var link = `
            //                        <td style="width: 10%" >
            //                        <label  data-toggle="tooltip" data-placement="top" title="Vot 20000" style="cursor: pointer;" onclick="rowClickHandlerABM('${valtahun}','${valkw}','${valko}','${valkp}','${valPtj}','${valVotAm}','${KodTab}')">${data}</label>
            //                        </td>`;
            //                    return link;
            //                }
            //            },
            //            {
            //                "data": "Operasi_30000",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    //if (type === 'display' || type === 'filter') {
            //                    //    return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    //}
            //                    //return data;
            //                    var valtahun = row.Tahun_Bajet
            //                    var valkw = row.Kod_Kump_Wang
            //                    var valko = row.Kod_Operasi
            //                    var valkp = row.Kod_Projek
            //                    var valPtj = row.Kod_Bahagian
            //                    var valVotAm = "30000"
            //                    var KodTab = "1"

            //                    //combinedData = `${valtahun} - ${valkw} - ${valko}`;

            //                    var link = `
            //                        <td style="width: 10%" >
            //                        <label  data-toggle="tooltip" data-placement="top" title="Vot 20000" style="cursor: pointer;" onclick="rowClickHandlerABM('${valtahun}','${valkw}','${valko}','${valkp}','${valPtj}','${valVotAm}','${KodTab}')">${data}</label>
            //                        </td>`;
            //                    return link;
            //                }
            //            },
            //            {
            //                "data": "Komited_30000",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    //if (type === 'display' || type === 'filter') {
            //                    //    return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    //}
            //                    //return data;
            //                    var valtahun = row.Tahun_Bajet
            //                    var valkw = row.Kod_Kump_Wang
            //                    var valko = row.Kod_Operasi
            //                    var valkp = row.Kod_Projek
            //                    var valPtj = row.Kod_Bahagian
            //                    var valVotAm = "30000"
            //                    var KodTab = "1"

            //                    //combinedData = `${valtahun} - ${valkw} - ${valko}`;

            //                    var link = `
            //                        <td style="width: 10%" >
            //                        <label  data-toggle="tooltip" data-placement="top" title="Vot 20000" style="cursor: pointer;" onclick="rowClickHandlerABM('${valtahun}','${valkw}','${valko}','${valkp}','${valPtj}','${valVotAm}','${KodTab}')">${data}</label>
            //                        </td>`;
            //                    return link;
            //                }
            //            },
            //            {
            //                "data": "Operasi_40000",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    //if (type === 'display' || type === 'filter') {
            //                    //    return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    //}
            //                    //return data;
            //                    var valtahun = row.Tahun_Bajet
            //                    var valkw = row.Kod_Kump_Wang
            //                    var valko = row.Kod_Operasi
            //                    var valkp = row.Kod_Projek
            //                    var valPtj = row.Kod_Bahagian
            //                    var valVotAm = "40000"
            //                    var KodTab = "1"

            //                    //combinedData = `${valtahun} - ${valkw} - ${valko}`;

            //                    var link = `
            //                        <td style="width: 10%" >
            //                        <label  data-toggle="tooltip" data-placement="top" title="Vot 20000" style="cursor: pointer;" onclick="rowClickHandlerABM('${valtahun}','${valkw}','${valko}','${valkp}','${valPtj}','${valVotAm}','${KodTab}')">${data}</label>
            //                        </td>`;
            //                    return link;
            //                }
            //            },
            //            {
            //                "data": "Komited_40000",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    //if (type === 'display' || type === 'filter') {
            //                    //    return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    //}
            //                    //return data;

            //                    var valtahun = row.Tahun_Bajet
            //                    var valkw = row.Kod_Kump_Wang
            //                    var valko = row.Kod_Operasi
            //                    var valkp = row.Kod_Projek
            //                    var valPtj = row.Kod_Bahagian
            //                    var valVotAm = "40000"
            //                    var KodTab = "1"

            //                    //combinedData = `${valtahun} - ${valkw} - ${valko}`;

            //                    var link = `
            //                        <td style="width: 10%" >
            //                        <label  data-toggle="tooltip" data-placement="top" title="Vot 20000" style="cursor: pointer;" onclick="rowClickHandlerABM('${valtahun}','${valkw}','${valko}','${valkp}','${valPtj}','${valVotAm}','${KodTab}')">${data}</label>
            //                        </td>`;
            //                    return link;
            //                }
            //            },
            //            {
            //                "data": "Operasi_50000",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    if (type === 'display' || type === 'filter') {
            //                        return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    }
            //                    return data;
            //                }
            //            },
            //            {
            //                "data": "Komited_50000",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    if (type === 'display' || type === 'filter') {
            //                        return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    }
            //                    return data;
            //                }
            //            },
            //            {
            //                "data": "Operasi_All",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    if (type === 'display' || type === 'filter') {
            //                        return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    }
            //                    return data;
            //                }
            //            },
            //            {
            //                "data": "Komited_All",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    if (type === 'display' || type === 'filter') {
            //                        return parseFloat(data).toFixed(2); // Format to two decimal places
            //                    }
            //                    return data;
            //                }
            //            },
            //            {
            //                "data": "Jumlah_Permohonan",
            //                "className": "text-right",
            //                "width": "5%",
            //                "render": function (data, type, row) {
            //                    if (type === 'display' || type === 'filter') {
            //                        return parseFloat(data).toFixed(2); // Format to two decimal placestblDataSenarai_trans
            //                    }
            //                    return data;
            //                }
            //            }

            //        ],
            //        createdRow: async function (row, data, dataIndex) {
            //            var butiranDetail = await GetButiranKod(data.Kod_Bahagian);
            //            butiranDetail = JSON.parse(butiranDetail)

            //            //console.log("a " + butiranDetail.Payload.Nama)
            //            // Assuming butiranDetail is an object with a "Nama" property
            //            //var namaValue = butiranDetail.Payload.Nama;

            //            // Set the HTML content of elements with the class "lblNo" to the "Nama" value
            //            // Check if "Nama" exists in the Payload before updating the HTML

            //            $(row).find('.lblNo1').html(butiranDetail[0].Nama);

            //        }
            //        , footerCallback: function (row, data, start, end, display) {
            //            let api = this.api();

            //            let columnsToSum = [];

            //            for (let i = 2; i <= 14; i++) {
            //                columnsToSum.push(i);
            //            }

            //            // Remove the formatting to get integer data for summation
            //            let intVal = function (i) {
            //                return typeof i === 'string'
            //                    ? i.replace(/[\$,]/g, '') * 1
            //                    : typeof i === 'number'
            //                        ? i
            //                        : 0;
            //            };

            //            // Loop through the specified columns and calculate the total for each
            //            columnsToSum.forEach(columnIndex => {
            //                let total = api.column(columnIndex).data().reduce((a, b) => intVal(a) + intVal(b), 0);

            //                // Total over this page for the current column
            //                let columnTotal = api.column(columnIndex, { page: 'current' }).data().reduce((a, b) => intVal(a) + intVal(b), 0);

            //                // Update the footer for the current column
            //                api.column(columnIndex).footer().innerHTML = parseFloat(columnTotal).toFixed(2);
            //            });
            //        }





            //    });



            //    async function GetButiranKod(Kod_Bahagian) {

            //        return new Promise((resolve, reject) => {
            //            $.ajax({
            //                url: "Awal_Tahun_WS.asmx/LoadBahagian",
            //                method: "POST",
            //                data: JSON.stringify({ Kod_Bahagian: Kod_Bahagian }),
            //                dataType: "json", //expected data from server
            //                contentType: 'application/json; charset=utf-8', //expected format of parameter send to server
            //                success: function (data) {
            //                    resolve(data.d);
            //                },
            //                error: function (xhr, textStatus, errorThrown) {
            //                    reject(false);
            //                }
            //            });

            //            //console.log("b")
            //        });
            //    }

            //    //$("#categoryFilter").change(function (e) {

            //    //    var selectedItem = $('#categoryFilter').val()
            //    //    if (selectedItem == "6") {
            //    //        $('#txtTarikhStart').show();
            //    //        $('#txtTarikhEnd').show();

            //    //        $('#lblMula').show();
            //    //        $('#lblTamat').show();

            //    //        $('#txtTarikhStart').val("")
            //    //        $('#txtTarikhEnd').val("")
            //    //    }
            //    //    else {
            //    //        $('#txtTarikhStart').hide();
            //    //        $('#txtTarikhEnd').hide();

            //    //        $('#txtTarikhStart').val("")
            //    //        $('#txtTarikhEnd').val("")

            //    //        $('#lblMula').hide();
            //    //        $('#lblTamat').hide();

            //    //    }
            //    //});
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

            $(document).ready(function () {

                $('#categoryKW').dropdown({
                    apiSettings: {
                        url: 'Awal_Tahun_WS.asmx/GetJenisKW?q={query}',
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

            

           

            $(function () {
                $('.btnAddRow.five').click();
            });

            $('.btnHantar').click(async function () {
                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";
                var newOrder = {
                    order: {
                        OrderID: $('#lblNoJurnal').val(),
                        NoRujukan: $('#txtNoRujukan').val(),
                        Perihal: $('#txtPerihal').val(),
                        Tarikh: $('#txtTarikh').val(),
                        JenisTransaksi: $('#ddlJenTransaksi').val(),
                        JumlahDebit: $('#totalDbt').val(),
                        Jumlahkredit: $('#totalkt').val(),
                        JumlahBeza: $('#totalBeza').val(),
                        OrderDetails: []
                    }

                }




                //console.log(newOrder.order);

                msg = "Anda pasti ingin menghantar " + acceptedRecord + " rekod ini?"

                if (!confirm(msg)) {
                    return false;
                }

                var result = JSON.parse(await ajaxSubmitOrder(newOrder));
                alert(result.Message)
                //$('#orderid').val(result.Payload.OrderID)

                //loadExistingRecords();
                //await clearAllRows();
                // AddRow(5);

            });

            $('.btnLulus').click(async function () {
                //console.log("test")
                $('#confirmationModal_Hantar').modal('toggle');


            });

            $('.btnLulus_mhn').click(async function () {
                //console.log("test")
                $('#confirmationModal_Hantar').modal('toggle');


            });

            //$('.btnYa_Hantar').click(async function () {
            //    $('#maklumanModalBil_Hantar').modal('hide');


            //    var jumRecord = 0;
            //    var acceptedRecord = 0;
            //    var msg = "";
            //    var newOrder = {
            //        order: {
            //            OrderID: $('#lblNoJurnal').val(),
            //            NoRujukan: $('#txtNoRujukan').val(),
            //            Perihal: $('#txtPerihal').val(),
            //            Tarikh: $('#txtTarikh').val(),
            //            JenisTransaksi: $('#ddlJenTransaksi').val(),
            //            JumlahDebit: $('#totalDbt').val(),
            //            Jumlahkredit: $('#totalkt').val(),
            //            JumlahBeza: $('#totalBeza').val(),
            //            OrderDetails: []
            //        }

            //    }




            //    //msg = "Anda pasti ingin meluluskan jurnal ini?"

            //    //if (!confirm(msg)) {
            //    //    return false;
            //    //}

            //    var result = JSON.parse(await ajaxSaveOrderLulus(newOrder));
            //   // alert(result.Message)


            //    if (result.Status !== "Failed") {
            //        //$('#modalPenghutang').modal('toggle');
            //        // open modal makluman and show message

            //        $('#detailMaklumanBil_Hantar').html(result.Message);
            //        //clearAllFields();

            //        $(".modal-body div").val("");
            //        $('#transaksi').modal('toggle');

            //        tbl.ajax.reload();

            //        // refresh page after 2 seconds


            //        setTimeout(function () {
            //            tbl.ajax.reload();
            //        }, 2000);
            //    } else {
            //        // open modal makluman and show message

            //        $('#detailMaklumanBil_Hantar').html(result.Message);



            //    }



            //});


            $('.btnXLulus').click(async function () {
                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";
                var newOrder = {
                    order: {
                        OrderID: $('#lblNoJurnal').val(),
                        NoRujukan: $('#txtNoRujukan').val(),
                        Perihal: $('#txtPerihal').val(),
                        Tarikh: $('#txtTarikh').val(),
                        JenisTransaksi: $('#ddlJenTransaksi').val(),
                        JumlahDebit: $('#totalDbt').val(),
                        Jumlahkredit: $('#totalkt').val(),
                        JumlahBeza: $('#totalBeza').val(),
                        OrderDetails: []
                    }

                }





                msg = "Anda pasti ingin TIDAK meluluskan jurnal ini?"

                if (!confirm(msg)) {
                    return false;
                }

                var result = JSON.parse(await ajaxSaveOrderXLulus(newOrder));
                alert(result.Message)


                $(".modal-body div").val("");
                $('#transaksi').modal('toggle');

                tbl.ajax.reload();

            });

            $('.btnSearch').click(async function () {

                load_loader();

                isClicked = true;
                tbl.ajax.reload();

                close_loader();
            })

            $('.btnSearch_Mohon').click(async function () {

                load_loader();
                isClicked_ = true;
                tbl_.ajax.reload();

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

            $('.btnYa_Hantar').click(async function () {
                $('#confirmationModal_Hantar').modal('hide');

                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";
                var newOrder = {
                    order: {
                        OrderID: $('#lblNoMohon_mhn').val(),
                        NoRujukan: $('#txtNoRujukan_mhn').val(),
                        Perihal: $('#txtPerihal_mhn').val(),
                        Tarikh: $('#txtTarikh_mhn').val()
                    }
                };

                var result = JSON.parse(await ajaxSaveOrderLulus(newOrder));

                if (result.Status !== "Failed") {
                   
                    $('#detailMaklumanBil_Hantar').html(result.Message);
                    // $('input[type="text"]').val(""); // Clearing text input fields

                    $('#transaksi_mohon').modal('toggle');
                    tbl_.ajax.reload();

                    setTimeout(function () {
                        tbl_.ajax.reload();
                    }, 2000);
                } else {
                    $('#detailMaklumanBil_Hantar').html(result.Message);
                }
            });



            async function loadExistingRecords() {
                var record = await AjaxLoadOrderRecord($('#lblNoJurnal').val());
                await clearAllRows();
                await AddRow(null, record);
            }

            async function clearAllRows_Kew() {
               
                $(("#tblData_mhn") + " > tbody > tr ").each(function (index, obj) {
                    if (index > 0) {
                        obj.remove();
                    }
                   
                })
                //$(totalDebit).val("0.00");
               //$(totalKredit).val("0.00");
                $("#totalJumlah_mhn").val("0.00"); //total beza
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
               // console.log(order)
                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: 'Akhir_Tahun_WS.asmx/Lulusorder_NC',
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
                        url: 'Awal_Tahun_WS.asmx/XLulusorder',
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

            async function calculateGrandTotal_Kew() {

                //Jumlah
                var grandTotal_Dt = $('#totalJumlah_mhn');
              
                var curTotal_Dt = 0;

                $('.Jumlah_mhn').each(function (index, obj) {
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
                    // modal dismiss
                    //$('#transaksi').modal('toggle');


                    //BACA HEADER JURNAL
                    var recordHdr = await AjaxGetRecordHdrBajet(id);
                    await AddRowHeader(null, recordHdr);

                    //BACA DETAIL JURNAL
                    var record = await AjaxGetRecordBajet(id);
                    await clearAllRows();
                    await AddRow(null, record);

                }
            }

            // add clickable event in DataTable row
            async function rowClickHandler_Kew(id) {

                if (id !== "") {

                    //initDDLBahagian_Kew();
                    //initDDLKW_Kew();
                    //initDDLKO_Kew();
                    //initDDLKP_Kew()
                    //initDDLDasar_Kew()
                    generateDropdown("ddlBahagian_mhn", "../Awal Tahun/Awal_Tahun_WS.asmx/GetListBahagian", null, false, null);
                    generateDropdown("ddlKW_mhn", "../Awal Tahun/Awal_Tahun_WS.asmx/GetListKW", null, false, null);
                    //generateDropdown("ddlPenyokong_mhn", "Awal_Tahun_WS.asmx/GetListPenyokong", null, false, null);
                    generateDropdown("ddlKO_mhn", "../Awal Tahun/Awal_Tahun_WS.asmx/GetListKO", null, false, null);
                    generateDropdown("ddlKP_mhn", "../Awal Tahun/Awal_Tahun_WS.asmx/GetListKP", null, false, null);
                    generateDropdown("ddlDasar_mhn", "../Awal Tahun/Awal_Tahun_WS.asmx/GetListDasar", null, true, null);
                    generateDropdown("ddlUnit_mhn", "../Awal Tahun/Awal_Tahun_WS.asmx/GetListUnit", null, true, "ddlBahagian");
                    generateDropdown("ddlPTJPusat_mhn", "../Awal Tahun/Awal_Tahun_WS.asmx/GetListPTJPusat", null, false, null);
                    //initDDLPTJPusat_Kew()
                    // modal dismiss
                    $('#transaksi_mohon').modal('toggle');


                    //BACA HEADER JURNAL
                    var recordHdr = await AjaxGetRecordHdrBajet_Kew(id);
                    await AddRowHeader_Kew(null, recordHdr);

                    //BACA DETAIL JURNAL
                    var record = await AjaxGetRecordBajet_Kew(id);
                    await clearAllRows_Kew();
                    await AddRow_Kew(null, record);

                }
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

            function initDDLKW_Kew() {
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
                        let list = $('#ddlKW_mhn')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                        $("#ddlKW_mhn").dropdown('clear');
                    }
                })
            }

            function initDDLBahagian_Kew() {
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
                        let list = $('#ddlBahagian_mhn')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                        $("#ddlBahagian_mhn").dropdown('clear');
                    }
                })
            }

            function initDDLKO_Kew() {
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
                        let list = $('#ddlKO_mhn')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                        $("#ddlKO_mhn").dropdown('clear');
                    }
                })
            }



            function initDDLDasar_Kew() {
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
                        let list = $('#ddlDasar_mhn')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                        $("#ddlDasar_mhn").dropdown('clear');
                    }
                })

            }

            function activateTab(id) {
                // Remove the 'active' class from all tab items
                /* const tabItems = document.querySelectorAll('.nav-item a');
                 tabItems.forEach(item => {
                     item.classList.remove('active');
                 });*/

                // Add the 'active' class to the second tab
                const secondTab = document.querySelector('[data-tab="' + id + '"] > a');
                secondTab.click();
                //console.log(secondTab);
                //secondTab.classList.add('active');


            }




            async function rowClickHandlerPapar(id) {
                // modal dismiss
                //$('#transaksi').modal('show');

                showTab("Dtl");
                activateTab("Dtl")


                //panggil ddl
                initDDLBahagian()
                initDDLKW()
                initDDLKO()
                initDDLKP()
                initDDLDasar()
                initDDLPTJPusat()


                //BACA HEADER JURNAL
                var recordHdr = await AjaxGetRecordHdrBajet(id);
                await AddRowHeader(null, recordHdr);

                //BACA DETAIL JURNAL
                var record = await AjaxGetRecordBajet(id);
                await clearAllRows();
                await AddRow(null, record);
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


            async function setValueToRow_HdrBajet(orderDetail) {

               // console.log("a");
                $('#lblNoMohon').val(orderDetail.No_Mohon);
                $('#txtTarikh').val(orderDetail.Tkh_Transaksi);

                $('#txtProgram').val(orderDetail.Program);
                $('#txtJustifikasi').val(orderDetail.Justifikasi);
                //console.log(orderDetail.Kod_Bahagian);
                //$('#txtPTJ').val(orderDetail.Kod_PTJ)
                getPTJ_Butiran(orderDetail.Kod_PTJ);

                //$("#ddlBahagian").dropdown('set selected', orderDetail.Kod_Bahagian);
                //$("#ddlKW").dropdown('set selected', orderDetail.Kod_Kump_Wang);
                //$("#ddlKO").dropdown('set selected', orderDetail.Kod_Operasi);
                //$("#ddlKP").dropdown('set selected', orderDetail.Kod_Projek);
                //$("#ddlDasar").dropdown('set selected', orderDetail.Kod_Dasar);
                //$("#ddlPTJPusat").dropdown('set selected', orderDetail.PTJ_Pusat);

                buildDdl('ddlBahagian_mhn', orderDetail.Kod_Bahagian, orderDetail.Butir_Kod_Bahagian);
                buildDdl('ddlUnit_mhn', orderDetail.Kod_Unit, orderDetail.Butir_Kod_Unit);
                buildDdl('ddlKW_mhn', orderDetail.Kod_Kump_Wang, orderDetail.Butir_Kod_Kump_Wang);
                buildDdl('ddlKO_mhn', orderDetail.Kod_Operasi, orderDetail.Butir_Kod_Operasi);
                buildDdl('ddlKP_mhn', orderDetail.Kod_Projek, orderDetail.Butir_Kod_Projek);
                buildDdl('ddlDasar_mhn', orderDetail.Kod_Dasar, orderDetail.Butir_Kod_Dasar);
                buildDdl('ddlPTJPusat_mhn', orderDetail.PTJ_Pusat, orderDetail.Butir_PTJ_Pusat);


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

            async function AddRowHeader_Kew(totalClone, objOrder) {
                var counter = 1;
                //var table = $('#tblDataSenarai');

                if (objOrder !== null && objOrder !== undefined) {
                    totalClone = objOrder.Payload.length;
                }



                if (counter <= objOrder.Payload.length) {
                    await setValueToRow_HdrBajet_Kew(objOrder.Payload[counter - 1]);
                }
                // console.log(objOrder)
            }


            async function setValueToRow_HdrBajet_Kew(orderDetail) {

                // console.log("a");
                $('#lblNoMohon_mhn').val(orderDetail.No_Mohon);
                $('#txtTarikh_mhn').val(orderDetail.Tkh_Transaksi);

                $('#txtProgram_mhn').val(orderDetail.Program);
                $('#txtJustifikasi_mhn').val(orderDetail.Justifikasi);
                //console.log(orderDetail.Kod_Bahagian);
                //$('#txtPTJ').val(orderDetail.Kod_PTJ)
                getPTJ_Butiran(orderDetail.Kod_PTJ);

                //$("#ddlBahagian_mhn").dropdown('set selected', orderDetail.Kod_Bahagian);
                //$("#ddlKW_mhn").dropdown('set selected', orderDetail.Kod_Kump_Wang);
                //$("#ddlKO_mhn").dropdown('set selected', orderDetail.Kod_Operasi);
                //$("#ddlKP_mhn").dropdown('set selected', orderDetail.Kod_Projek);
                //$("#ddlDasar_mhn").dropdown('set selected', orderDetail.Kod_Dasar);
                //$("#ddlPTJPusat_mhn").dropdown('set selected', orderDetail.PTJ_Pusat);

                buildDdl('ddlBahagian_mhn', orderDetail.Kod_Bahagian, orderDetail.Butir_Kod_Bahagian);
                buildDdl('ddlUnit_mhn', orderDetail.Kod_Unit, orderDetail.Butir_Kod_Unit);
                buildDdl('ddlKW_mhn', orderDetail.Kod_Kump_Wang, orderDetail.Butir_Kod_Kump_Wang);
                buildDdl('ddlKO_mhn', orderDetail.Kod_Operasi, orderDetail.Butir_Kod_Operasi);
                buildDdl('ddlKP_mhn', orderDetail.Kod_Projek, orderDetail.Butir_Kod_Projek);
                buildDdl('ddlDasar_mhn', orderDetail.Kod_Dasar, orderDetail.Butir_Kod_Dasar);
                buildDdl('ddlPTJPusat_mhn', orderDetail.PTJ_Pusat, orderDetail.Butir_PTJ_Pusat);


            }

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

            async function AddRow_Kew(totalClone, objOrder) {

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

                    var newId_coa = "ddlObjAm_mhn" + curNumObject;

                    var row = $('#tblData_mhn tbody>tr:first').clone();

                    var dropdown5 = $(row).find(".ObjAm-list_mhn").attr("id", newId_coa);

                    row.attr("style", "");
                    var val = "";

                    $('#tblData_mhn tbody').append(row);

                    await initDropdownObjAm(newId_coa)
                    $(newId_coa).api("query");



                    if (objOrder !== null && objOrder !== undefined) {

                        //await setValueToRow(row, objOrder.Payload.OrderDetails[counter - 1]);
                        if (counter <= objOrder.Payload.length) {
                            await setValueToRow_Transaksi_Kew(row, objOrder.Payload[counter - 1]);

                        }
                    }


                    counter += 1;
                }
            }

            async function setValueToRow_Transaksi_Kew(row, orderDetail) {
                //console.log("a " + orderDetail)
                var ddl = $(row).find("td > .ObjAm-list_mhn");
                var ddlSearch = $(row).find("td > .ObjAm-list_mhn > .search");
                var ddlText = $(row).find("td > .ObjAm-list_mhn > .text");
                var selectObj = $(row).find("td > .ObjAm-list_mhn > select");
                $(ddl).dropdown('set selected', orderDetail.ddlObjAm);
                selectObj.append("<option value = '" + orderDetail.ddlObjAm + "'>" + orderDetail.ddlObjAm + ' - ' + orderDetail.ButiranVot + "</option>")


                //var butirptj = $(row).find("td > .label-ptj-list");
                //butirptj.html(orderDetail.ButiranPTJ);


                var jumlah = $(row).find("td > .Jumlah_mhn");
                jumlah.val(orderDetail.Jumlah.toFixed(2));

                var Butiran = $(row).find("td > .Butiran_mhn");
                Butiran.val(orderDetail.Butiran);


                await calculateGrandTotal_Kew();

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
            async function AjaxGetRecordBajet_Kew(id) {

                try {

                    const response = await fetch('Akhir_Tahun_WS.asmx/LoadRecordBajet_Bend', {
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

            async function AjaxGetRecordHdrBajet_Kew(id) {

                try {

                    const response = await fetch('Akhir_Tahun_WS.asmx/LoadHdrBajet_Bend', {
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

            // add clickable event in DataTable row
            async function rowClickHandlerABM(tahun, kw, ko, kp, ptj, vot, kodTab) {

                //alert("kod " + kodTab)

                if (kodTab == "1") {
                    showTab("ALL");
                    activateTab("ALL")
                    await clearAllRowsABM();

                    ////pass val
                    $('#txtTahunBajet').val(tahun);
                    $('#txtBahagian').val(ptj);

                    getInfoKW(kw);
                    getInfoKO(ko);

                    $('#modalInvoisData').modal('show');


                    //BACA summary
                    var recordHdr = await AjaxGetRecordH1(tahun, kw, ko, kp, ptj, vot);

                    await AddRowHeaderH1(null, recordHdr);

                    await calculateGrandTotalAm();


                }
                else if (kodTab == "2") {
                    showTab("Sbg");
                    activateTab("Sbg")
                    await clearAllRowsSbg();

                    $('#txtObjSbg').val(vot);

                    getVotSbg(vot) //dapatkan nama butiran vot sbg

                    showTab("Sbg");
                    activateTab("Sbg")

                    // alert(tahun +  kw + ko + kp + ptj + vot)
                    //BACA summary
                    var recordHdr2 = await AjaxGetRecordH2(tahun, kw, ko, kp, ptj, vot);

                    await AddRowHeaderH2(null, recordHdr2);

                    await calculateGrandTotalSbg();

                } else if (kodTab == "3") {
                    showTab("Dtl");
                    activateTab("Dtl")


                };
            }

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

                        $("#ddlKW").dropdown('clear');
                    }
                })
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

                        $("#ddlBahagian").dropdown('clear');
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

                        $("#ddlKO").dropdown('clear');
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

                        $("#ddlDasar").dropdown('clear');
                    }
                })

            }

            async function calculateGrandTotalSbg() {

                //Jumlah
                var grandTotal_Sbg = $('.TotalJumlahSbg');

                var curTotal_Dt = 0;

                $('.Jumlah1').each(function (index, obj) {
                    curTotal_Dt += parseFloat(NumDefault($(obj).html()));

                });
                // alert("sum " + curTotal_Dt)
                grandTotal_Sbg.html(formatPrice(curTotal_Dt));


            }

            function getInfoKW(KodKW) {
                //Cara Pertama

                fetch('Awal_Tahun_WS.asmx/LoadKW', {
                    method: 'POST',
                    headers: {
                        'Content-Type': "application/json"
                    },
                    //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                    body: JSON.stringify({ KodKW: KodKW })
                })
                    .then(response => response.json())
                    .then(data => setInfoKW(data.d))

            }

            function setInfoKW(data) {
                //alert("dd " + data)
                data = JSON.parse(data);
                if (data.Butiran === "") {
                    alert("Tiada data");
                    return false;
                }
                $('#txtKW').val(data[0].Butiran);


            }

            function getVotSbg(kodSbg) {
                //Cara Pertama

                fetch('Awal_Tahun_WS.asmx/LoadSbg', {
                    method: 'POST',
                    headers: {
                        'Content-Type': "application/json"
                    },
                    //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                    body: JSON.stringify({ kodSbg: kodSbg })
                })
                    .then(response => response.json())
                    .then(data => setInfoSbg(data.d))

            }

            function setInfoSbg(data) {
                //alert("dd " + data)
                data = JSON.parse(data);
                if (data.Butiran === "") {
                    alert("Tiada data");
                    return false;
                }
                $('#txtButiranSbg').val(data[0].Butiran);


            }

            function getInfoKO(KodKO) {
                //Cara Pertama

                fetch('Awal_Tahun_WS.asmx/LoadKO', {
                    method: 'POST',
                    headers: {
                        'Content-Type': "application/json"
                    },
                    //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                    body: JSON.stringify({ KodKO: KodKO })
                })
                    .then(response => response.json())
                    .then(data => setInfoKO(data.d))

            }

            function setInfoKO(data) {
                //alert("KO " + data)
                data = JSON.parse(data);
                if (data.Butiran === "") {
                    alert("Tiada data");
                    return false;
                }
                $('#txtKO').val(data[0].Butiran);


            }

            async function clearAllRowsABM() {
                var tableID_Senarai = "#tblDataObjekAm";
                $(tableID_Senarai + " > tbody > tr ").each(function (index, obj) {
                    if (index > 0) {
                        obj.remove();
                    }
                })
            }

            async function clearAllRowsSbg() {
                var tableID_Senarai = "#tblDataPaparPermohonan";
                $(tableID_Senarai + " > tbody > tr ").each(function (index, obj) {
                    if (index > 0) {
                        obj.remove();
                    }
                })
            }

            async function AddRowHeaderH1(totalClone, objOrder) {
                var counter = 1;
                var table = $('#tblDataObjekAm');

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


                    var row = $('#tblDataObjekAm tbody>tr:first').clone();
                    row.attr("style", "");
                    var val = "";

                    $('#tblDataObjekAm tbody').append(row);



                    if (objOrder !== null && objOrder !== undefined) {
                        //await setValueToRow(row, objOrder.Payload.OrderDetails[counter - 1]);
                        if (counter <= objOrder.Payload.length) {
                            //console.log("aa" + objOrder.Payload[counter - 1])
                            await setValueToRow_HdrH1(row, objOrder.Payload[counter - 1]);

                        }
                    }
                    counter += 1;
                }
            }


            async function setValueToRow_HdrH1(row, orderDetail) {


                var RowCountBil = $(row).find("td > .RowCountBil");
                RowCountBil.html(orderDetail.RowCountBil);


                // Combine multiple data properties from orderDetail
                var combinedData = orderDetail.Kod_Vot_Sbg + " - " + orderDetail.ButiranSbg;

                var ObjSebagai = $(row).find("td > .ObjSebagai");
                ObjSebagai.html(combinedData);

                var Jumlah = $(row).find("td > .JumlahSbg");
                Jumlah.html(orderDetail.Jumlah.toFixed(2));

                var ObjSebagaiAll = $(row).find("td > .ObjSebagaiAll"); //button
                console.log(ObjSebagaiAll);

                var txtKWValue = $('#txtKW').val(); // Get the value from the "txtKW" input field
                var substringValueKW = txtKWValue.substring(0, 2); // This will get the substring from index 2 to 5

                var txtKOValue = $('#txtKO').val(); // Get the value from the "txtKW" input field
                var substringValueKO = txtKOValue.substring(0, 2); // This will get the substring from index 2 to 5


                $(ObjSebagaiAll).data("kodvot", orderDetail.Kod_Vot_Sbg);
                $(ObjSebagaiAll).data("kodkw", substringValueKW);
                $(ObjSebagaiAll).data("kodko", substringValueKO);
                //ObjSebagaiAll.val(orderDetail.Kod_Vot_Sbg);



            }

            async function AddRowHeaderH2(totalClone, objOrder) {
                var counter = 1;
                var table = $('#tblDataPaparPermohonan');

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


                    var row = $('#tblDataPaparPermohonan tbody>tr:first').clone();
                    row.attr("style", "");
                    var val = "";

                    $('#tblDataPaparPermohonan tbody').append(row);



                    if (objOrder !== null && objOrder !== undefined) {
                        //await setValueToRow(row, objOrder.Payload.OrderDetails[counter - 1]);
                        if (counter <= objOrder.Payload.length) {
                            //console.log("aa" + objOrder.Payload[counter - 1])
                            await setValueToRow_HdrH2(row, objOrder.Payload[counter - 1]);

                        }
                    }
                    counter += 1;
                }
            }

            async function setValueToRow_HdrH2(row, orderDetail) {


                var RowCountProgram = $(row).find("td > .RowCountProgram");
                RowCountProgram.html(orderDetail.RowCountBil);


                var Program = $(row).find("td > .Program");
                Program.html(orderDetail.Program);

                var Butiran1 = $(row).find("td > .Butiran1");
                Butiran1.html(orderDetail.Butiran);

                var Jumlah1 = $(row).find("td > .Jumlah1");
                Jumlah1.html(orderDetail.Jumlah.toFixed(2));

                //var ObjSebagaiAll = $(row).find("td > .ObjSebagaiAll"); //button
                //console.log(ObjSebagaiAll);

                $(paparPermohonan).data("NoMohon", orderDetail.No_Mohon);

                //ObjSebagaiAll.val(orderDetail.Kod_Vot_Sbg);



            }

            async function calculateGrandTotalAm() {

                //Jumlah
                var grandTotal_Dt = $('.JumlahAm');

                var curTotal_Dt = 0;

                $('.JumlahSbg').each(function (index, obj) {
                    curTotal_Dt += parseFloat(NumDefault($(obj).html()));

                });
                // alert("sum " + curTotal_Dt)
                grandTotal_Dt.html(formatPrice(curTotal_Dt));


            }

            async function AjaxGetRecordH1(tahun, kw, ko, kp, ptj, votam) {

                try {

                    const response = await fetch('Awal_Tahun_WS.asmx/LoadHdrH1', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            tahun: tahun,
                            kw: kw,
                            ko: ko,
                            kp: kp,
                            ptj: ptj,
                            votam: votam
                        })
                    });
                    const data = await response.json();
                    return JSON.parse(data.d);
                } catch (error) {
                    console.error('Error:', error);
                    return false;
                }
            }

            async function AjaxGetRecordH2(tahun, kw, ko, kp, ptj, votam) {
                //alert("testd " + tahun + "testd kw  " + kw + "testd ko " + ko + "testdkp  " + kp + "testd ptj " + ptj + "testd vot  "+ votam)
                try {

                    const response = await fetch('Awal_Tahun_WS.asmx/LoadHdrH2', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({
                            tahun: tahun,
                            kw: kw,
                            ko: ko,
                            kp: kp,
                            ptj: ptj,
                            votam: votam
                        })
                    });
                    const data = await response.json();
                    return JSON.parse(data.d);
                } catch (error) {
                    console.error('Error:', error);
                    return false;
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

            function initDDLKP_Kew() {
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
                        let list = $('#ddlKP_Kew')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                        // $("#ddlKP").dropdown('clear');
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

            function initDDLPTJPusat_Kew() {
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
                        let list = $('#ddlPTJPusat_Kew')
                        $(list).html('');
                        let parsed = []
                        data.forEach(d => {
                            $(list).append($('<option class="item" data-value="' + d.value + '" value="' + d.value + '">').html(d.text));
                        })

                        $("#ddlPTJPusat_Kew").dropdown('clear');
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

            async function initDropdownObjAm_Kew(id) {

                $('#' + id).dropdown({
                    fullTextSearch: true,
                    onChange: function (value, text, $selectedItem) {

                        //console.log($selectedItem);

                        var curTR = $(this).closest("tr");

                        var recordIDVotHd = curTR.find("td > .Hid-objAm-list_mhn");

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


                $("#ddlBahagian").dropdown('set selected', orderDetail.Kod_Bahagian)
                $("#ddlKW").dropdown('set selected', orderDetail.Kod_Kump_Wang)
                $("#ddlKO").dropdown('set selected', orderDetail.Kod_Operasi)
                $("#ddlKP").dropdown('set selected', orderDetail.Kod_Projek)
                $("#ddlDasar").dropdown('set selected', orderDetail.Kod_Dasar)
                $("#ddlPTJPusat").dropdown('set selected', orderDetail.PTJ_Pusat)


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

                fetch('../AWAL TAHUN/Awal_Tahun_WS.asmx/ViewPTJ', {
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

                document.getElementById("txtPTJ_mhn").value = data[0].KodPejPBU + " - " + data[0].Pejabat;
            }

            

            function subTabChange(e) {
                //alert("test "+e.target.parentElement.parentElement.getElementsByClassName("active"))
                e.preventDefault()
                Array.from(e.target.parentElement.parentElement.getElementsByClassName("active")).forEach(e => {
                    e.classList.remove("active")
                })
                e.target.classList.add("active")
                //console.log("test" + e.target.dataset.tab)
                showTab(e.target.dataset.tab)


            }

            function showTab(id) {
                $(".modal-sub-tab").hide()
                //if (id == "ALL") {
                //    $(".modal-sub-tab").show()
                //    return

                //}
                $("#" + id).show()

            }

            async function showInvoisData(tahun, kw, ko, kp, ptj, votam) {

                show_loader()
                let invHdr = await getInvoisHdr(tahun, kw, ko, kp, ptj, votam)
                close_loader()

                $("#modalInvoisData").modal('show')
            }




        </script>
 
</asp:Content>
