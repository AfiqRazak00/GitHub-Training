<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master"
    CodeBehind="PENGESAHAN_BAUCAR.aspx.vb" Inherits="SMKB_Web_Portal.PENGESAHAN_BAUCAR" %>


    <asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

        <contenttemplate>
            <%--<form id="form1" runat="server">--%>
                <%--<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>--%>
                    <style>
                        .hidden-option {
                            display: none;
                        }

                        #permohonan .modal-body {
                            max-height: 70vh;
                             /*Adjust height as needed to fit your layout */
                            min-height: 70vh;
                            overflow-y: scroll;
                            scrollbar-width: thin;
                        }

                        #subTab a {
                            cursor: pointer;
                        }

                        .data-penerima {
                            overflow-y: hidden;
                        }

                        .data-penerima::-webkit-scrollbar {
                            height: 1px;
                        }
 

                        .subpage {
                            padding: 1cm;
                            height: 100%;
                        }

                        #printable {
                            display: none;
                        }

                        .tblPrint {
                            font-size: 12px;
                            width: 100%;
                        }

                        .tblPrint th,
                        .tblPrint td {
                            border: 1px solid black;
                            border-collapse: collapse;
                            text-align: center;
                        }
                        @page {
                            size: A4;
                            margin: 0;
                          }
                        @media print { 
                            .modul-header,.tab,.sub-modul-title,.modal,.modal-dialog,#PermohonanTab,#sidebar{
                                display: none !important;
                            }
                            #printable {
                                /*display: block;*/ 
                                width: 100%;
                                height: 100%;  
                            }  
                        }
                    </style>
                    <link rel="stylesheet" href="../style.css" />
                    <div id="PermohonanTab" class="tabcontent" style="display: block;height:100%">
                        <%-- DIV PENDAFTARAN INVOIS --%>
                            <div id="divpendaftaraninv" runat="server" visible="true">
                                <div class="modal-body">
                                    <%--<div class="table-title">
                                        <h6></h6>
                                        <div class="btn btn-primary btnPapar" onclick="ShowPopup('2')">
                                            <i class="fa fa-plus"></i>Senarai Invois
                                        </div>
                                </div>--%>
                                <div>
                                    <hr />
                                    <h6>Senarai Invois</h6>
                                    <hr /> 
                                    <div class="search-filter">
                                        <div class="form-row justify-content-center">
                                            <div class="form-group row col-md-6">
                                                <label for="inputEmail3" class="col-sm-2 col-form-label"
                                                    style="text-align: right">Carian :</label>
                                                <div class="col-sm-8">
                                                    <div class="input-group">
                                                        <select id="invoisDateFilter" class="custom-select"
                                                            onchange="dateFilterHandler(event)">
                                                            <option value="all">SEMUA</option>
                                                            <option value="0" selected="selected">Hari Ini</option>
                                                            <option value="1">Semalam</option>
                                                            <option value="7">7 Hari Lepas</option>
                                                            <option value="30">30 Hari Lepas</option>
                                                            <option value="60">60 Hari Lepas</option>
                                                            <option value="select">Pilih Tarikh</option>
                                                        </select>
                                                        <button id="btnSearch" class="btn btnSearch btn-outline"
                                                            type="button" onclick="loadInvois()">
                                                            <i class="fa fa-search"></i>Cari
                                                        </button>
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div class="form-row">
                                                        <div class="form-group col-md-5">
                                                            <br />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-11" id="specificDateFilter" style="display: none">
                                                    <div class="form-row">
                                                        <div class="form-group col-md-1">
                                                            <label id="lblMula" style="text-align: right;">Mula:</label>
                                                        </div>

                                                        <div class="form-group col-md-4">
                                                            <input type="date" id="txtTarikhStart" name="txtTarikhStart"
                                                                class="form-control input-sm date-range-filter">
                                                        </div>
                                                        <div class="form-group col-md-1">
                                                        </div>
                                                        <div class="form-group col-md-1">
                                                            <label id="lblTamat"
                                                                style="text-align: right;">Tamat:</label>
                                                        </div>
                                                        <div class="form-group col-md-4">
                                                            <input type="date" id="txtTarikhEnd" name="txtTarikhEnd"
                                                                class="form-control input-sm date-range-filter">
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="transaction-table table-responsive">
                                                <table id="tblSenaraiInvois" class="table table-striped"
                                                    style="width: 99%">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Kod Rujukan</th>
                                                            <th scope="col">No. Invois</th>
                                                            <th scope="col">Nama Penerima</th>
                                                            <th scope="col">Jenis Invois</th>
                                                            <th scope="col">Tarikh Daftar</th>
                                                            <th scope="col">Tarikh Invois</th>
                                                            <th scope="col">Tarikh Terima Ivois</th>
                                                            <th scope="col">Jenis Bayar</th>
                                                            <th scope="col">Tujuan</th>
                                                            <th scope="col">Status</th>
                                                            <th scope="col">Jumlah (RM)</th>
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
                    <!-- Modal -->
                    <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
                        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered modal-xl" style="min-width: 80%" role="document">
                            <div class="modal-content">
                                <div class="modal-header modal-header--sticky">

                                    <div class="container-fluid mt-3">
                                        <ul class="nav nav-tabs" id="subTab" role="tablist">
                                            <li class="nav-item" role="presentation" onclick="subTabChange(event)"
                                                data-tab="ALL">
                                                <a class="nav-link active" tabindex="-1" data-tab="ALL"
                                                    aria-disabled="true">Maklumat Baucar</a>
                                            </li>
                                            <li class="nav-item" role="presentation" onclick="subTabChange(event)"
                                                data-tab="PNM">
                                                <a class="nav-link " tabindex="-1" data-tab="TRK"
                                                    aria-disabled="true">Maklumat Transaksi</a>
                                            </li>
                                            <li class="nav-item" role="presentation" onclick="subTabChange(event)"
                                                data-tab="TRK">
                                                <a class="nav-link " tabindex="-1" data-tab="LJR"
                                                    aria-disabled="true">Maklumat Lejar</a>
                                            </li>
                                        </ul>
                                    </div>


                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">



                                    <div id="BCR" class="modal-sub-tab">
                                        <div class="col-md-12 mt-4 mb-2 pt-2  border-top">

                                            <h5>Baucar</h5>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="input-group">

                                                    <input type="text" class=" input-group__input form-control"
                                                        id="txtIDRujukan" readonly />
                                                    <label for="txtIDRujukan" class="input-group__label">ID
                                                        Rujukan</label>
                                                </div>

                                            </div>
                                            <div class="col-md-3">
                                                <div class="input-group">
                                                    <input type="text" class="input-group__input form-control"
                                                        id="txtJenInvois" readonly />
                                                    <label for="txtJenInvois" class="input-group__label">Jenis
                                                        Invois</label>

                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="input-group">

                                                    <input type="text" class="input-group__input form-control"
                                                        id="txtJenByr" readonly />
                                                    <label for="txtJenByr" class="input-group__label">Jenis
                                                        Bayaran</label>
                                                </div>

                                            </div>
                                            <div class="col-md-3">
                                                <div class="input-group">
                                                    <input type="text" class="input-group__input form-control"
                                                        id="txtNoBaucar" readonly />

                                                    <label for="txtNoBaucar" class="input-group__label">No
                                                        Baucar</label>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="row mt-3">
                                            <div class="col-md-3">

                                                <div class="input-group">
                                                    <input type="text" class="input-group__input form-control"
                                                        id="txtTarikhBaucar" readonly />

                                                    <label for="txtTarikhBaucar" class="input-group__label">Tarikh Draf
                                                        Baucar</label>
                                                </div>
                                            </div>
                                            <div class="col-md-3">

                                                <div class="input-group">

                                                    <input type="text" class="input-group__input form-control"
                                                        id="txtBank" readonly />
                                                    <label for="ddlBank" class="input-group__label">Bank</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="input-group">
                                                    <textarea id="txtButiranBaucar"
                                                        class="input-group__input form-control" name="message" rows="1"
                                                        readonly></textarea>

                                                    <label for="txtButiranBaucar"
                                                        class="input-group__label">Butiran</label>
                                                </div>
                                            </div>

                                        </div>

                                    </div>
                                    <div id="TRK" class="modal-sub-tab">
                                        <!--Penemrima-->
                                        <div class="row">
                                            <div class="col-md-12 mt-4 mb-2 pt-2 border-top">

                                                <h5>Transaksi</h5>
                                            </div>

                                            <div class="col-md-12 mt-3">
                                                <div class="transaction-table table-responsive">
                                                    <table id="tblPenerimaBaucar" class="table table-striped"
                                                        style="width: 99%">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">Penerima</th>
                                                                <th scope="col">Vot</th>
                                                                <th scope="col">PTJ</th>
                                                                <th scope="col">Kumpulan Wang</th>
                                                                <th scope="col">Kod Operasi</th>
                                                                <th scope="col">Kod Projek</th>
                                                                <th scope="col">Jumlah Bayar (RM)</th>
                                                                <th scope="col">Kod Cukai</th>
                                                                <th scope="col">Cara Bayar</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="tbdPenerimaBaucar">
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="sticky-footer">
                                            <br />
                                            <div class="form-row">
                                                <div class="form-group col-md-12">
                                                    <div class="float-right">
                                                        <span
                                                            style="font-family: roboto!important; font-size: 18px!important"><b>Jumlah
                                                                (<span id="result" style="margin-right: 5px">0</span>
                                                                item) :RM <span id="stickyJumlah"
                                                                    style="margin-right: 5px">0.00</span></b></span>
                                                        <button type="button" class="btn" id="showModalButton"><i
                                                                class="fas fa-angle-up"></i></button>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div id="LJR" class="modal-sub-tab">

                                        <div class="col-md-12 mt-4 mb-2 pt-2 border-top">

                                            <h5>Lejar</h5>
                                        </div>

                                        <div class="col-md-12 mt-3">
                                            <table class="table table-striped border-bottom" id="tblLejar"
                                                style="width: 100%;">
                                                <thead>
                                                    <tr style="width: 100%; text-align: center">
                                                        <th scope="col">Penerima</th>
                                                        <th scope="col">Vot</th>
                                                        <th scope="col">Kod PTJ</th>
                                                        <th scope="col">Kumpulan Wang</th>
                                                        <th scope="col">Kod Operasi</th>
                                                        <th scope="col">Kod Projek</th>
                                                        <th scope="col">Debit (RM)</th>
                                                        <th scope="col">Kredit (RM)</th>
                                                        <th scope="col">Baki Peruntukan (RM)</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tbdId">
                                                </tbody>
                                                <tfoot>
                                                    <!--
                                            <tr style="width: 100%; text-align: center" id="lejarLast">
                                                <th scope="col"></th>
                                                <th scope="col"></th>
                                                <th scope="col"></th>
                                                <th scope="col"></th>
                                                <th scope="col"></th>
                                                <th scope="col"></th>  
                                                <th scope="col"></th>
                                                <th scope="col"></th>
                                                <th scope="col"></th>
                                            </tr>-->
                                                    <tr style="width: 100%; text-align: center;">
                                                        <th scope="col"></th>
                                                        <th scope="col"></th>
                                                        <th scope="col"></th>
                                                        <th scope="col"></th>
                                                        <th scope="col"></th>
                                                        <th scope="col">Jumlah Besar</th>
                                                        <th scope="col" id="lejarTD"></th>
                                                        <th scope="col" id="lejarTC"></th>
                                                        <th scope="col"></th>
                                                    </tr>

                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>

                                </div>

                                <div class="modal-footer">
                                    <div class="form-group col-md-12" align="right">
                                        <button type="button" onclick="printBaucar(event)" class="btn btn-primary" data-toggle="tooltip"
                                            data-placement="bottom" title="Cetak">Cetak</button>
                                        <button type="button" class="btn btn-danger btnXLulus" data-toggle="tooltip"
                                            data-placement="bottom" title="Batal">Tidak Lulus</button>
                                        <button type="button" onclick="lulusBaucar()" class="btn btn-success btnLulus"
                                            data-toggle="tooltip" data-placement="bottom" title="Lulus">Lulus</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>



                    <!--modal penerima-->
                    <div class="modal fade" id="modalPenerima" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog  modal-dialog-centered modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Maklumat Penerima</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="input-group">
                                                <div class=" input-group__input form-control data-penerima"
                                                    name="Nama_Pemiutang" readonly></div>
                                                <label class="input-group__label">Nama </label>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="input-group">

                                                        <div class="input-group__input form-control  data-penerima"
                                                            name="Kategori_Pemiutang" readonly></div>
                                                        <label class="input-group__label">Kategori</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="input-group">

                                                        <div class="input-group__input form-control  data-penerima"
                                                            name="Kod_Pemiutang" readonly></div>

                                                        <label class="input-group__label">ID Penerima</label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">

                                                    <div class="input-group">
                                                        <div class=" input-group__input  form-control  data-penerima"
                                                            name="Emel" readonly></div>
                                                        <label class="input-group__label">Email</label>

                                                    </div>
                                                </div>
                                                <div class="col-md-6">

                                                    <div class="input-group">
                                                        <div class=" input-group__input  form-control  data-penerima"
                                                            name="Tel_Bimbit" readonly></div>
                                                        <label class="input-group__label">No Telefon</label>

                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-6">

                                                    <div class="input-group">

                                                        <div class=" input-group__input form-control  data-penerima"
                                                            name="Bank_Detail" readonly></div>
                                                        <label class="input-group__label">Bank Penerima</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="input-group">

                                                        <div class=" input-group__input form-control data-penerima"
                                                            name="No_Akaun" readonly></div>
                                                        <label class="input-group__label ">No Akaun</label>
                                                    </div>

                                                </div>
                                            </div>

                                        </div>
                                        <div class="col-md-6">
                                            <div class="input-group">

                                                <div class="input-group__input form-control  data-penerima"
                                                    name="Alamat_1" readonly></div>
                                                <label class="input-group__label">Alamat 1</label>
                                            </div>
                                            <div class="input-group">
                                                <div class="input-group__input form-control  data-penerima"
                                                    name="Alamat_2" readonly></div>
                                                <label class="input-group__label ">Alamat 2</label>

                                            </div>
                                            <div class="input-group">

                                                <div class="input-group__input form-control  data-penerima"
                                                    name="Bandar_Detail" readonly></div>
                                                <label class="input-group__label">Bandar</label>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="input-group">
                                                        <div class="input-group__input form-control  data-penerima"
                                                            name="Poskod" readonly></div>
                                                        <label class="input-group__label">Poskod</label>

                                                    </div>

                                                </div>
                                                <div class="col-md-6">
                                                    <div class="input-group">
                                                        <div class="input-group__input form-control  data-penerima"
                                                            name="Negeri_Detail" readonly></div>
                                                        <label class="input-group__label">Negeri</label>

                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="modal-footer">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--modal penerima end-->
                    <!--modal total-->
                    <div class="modal fade" id="detailTotal" tabindex="-1" aria-labelledby="showDetails"
                        aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Jumlah Terperinci</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div class="row justify-content-end mt-2">
                                        <div class="col-md-6 text-right">
                                            <label class="col-form-label ">Jumlah Perlu Bayar (RM)</label>

                                        </div>
                                        <div class="col-md-6">

                                            <input type="text" class="form-control text-right" id="txtJumlahPerluBayar"
                                                readonly />
                                        </div>
                                    </div>
                                    <div class="row justify-content-end mt-2">
                                        <div class="col-md-6 text-right">
                                            <label class="col-form-label ">Jumlah Bayaran (RM)</label>

                                        </div>
                                        <div class="col-md-6">
                                            <input type="text" class="form-control text-right" id="txtJumlahBayaran"
                                                readonly />

                                        </div>
                                    </div>
                                    <div class="row justify-content-end mt-2">
                                        <div class="col-md-6 text-right">
                                            <label class="col-form-label ">Baki Bayaran (RM)</label>

                                        </div>
                                        <div class="col-md-6">
                                            <input type="text" class="form-control text-right" id="txtBakiBayaran"
                                                readonly />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--modal total end-->

                    <!-- Modal dialog confirm -->
                    <div class="modal fade" id="modalDialogConfirm" tabindex="-1" aria-hidden="true"
                        style="z-index: 1060;">
                        <div class="modal-dialog ">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title  ">Pengesahan</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div id="dialogConfirmContent"></div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger  " data-dismiss="modal">Tidak</button>
                                    <button type="button" class="btn btn-secondary  " data-dismiss="modal"
                                        id="btnDialogModalConfirm">Ya</button>

                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Modal dialog info -->
                    <div class="modal fade" id="modalDialogInfo" tabindex="-1" aria-hidden="true"
                        style="z-index: 1060;">
                        <div class="modal-dialog ">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Makluman</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <div id="dialogInfoContent"></div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div id="printable">
                        <div class="page" style="width:100%">
                            <div class="subpage">
                                <div class="row">

                                    <img src="utem.jpg">
                                    <div>
                                        <br>
                                        <b>UNIVERSITI TEKNIKAL MALAYSIA MELAKA</b><br>
                                        Hang Tuah Jaya, 76100 Durian Tunggal, Melaka <br>
                                        Tel : 606 - 331 6159 Fax : 606 - 331 6115
                                    </div>
                                </div>
                                <div class="text-center" style="width: 100%;">
                                    <b>BAUCAR PEMBAYARAN</b>
                                </div>
                                <div class="row">
                                    <i style="font-size: 10px;">Perbelanjaan berikut dibenarkan mengikut Arahan
                                        Perbendaharaan 102.<br>
                                        Semua dokumen berkaitan dilampirkan mengikut Arahan Perbendaharaan 99.
                                    </i>
                                </div>
                                <br>
                                <div style="width: 100%;">
                                    <table class="tblPrint">
                                        <thead>
                                            <tr>
                                                <th style="width: 10%">KW</th>
                                                <th style="width: 15%;">PTj</th>
                                                <th style="width: 15%">Kod Lejar</th>
                                                <th style="width: 20%">No. Rujukan</th>
                                                <th style="width: 20%">Debit (RM)</th>
                                                <th style="width: 20%">Kredit (RM)</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblLejarPrint">

                                        </tbody>
                                    </table>
                                </div>
                                <br>

                                <div class="text-right" style="width: 100%;">
                                    <b>Jumlah Perlu Bayar </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span
                                        id="printJumlahByr">0</span>
                                </div>
                                <div style="width: 100%;">
                                    <b><i>RINGGIT MALAYSIA : </i></b> <span style="font-size: 10px;" id="printRinggitText"></span>
                                </div>

                                <div style="width: 100%;">
                                    <table class="tblPrint">
                                        <thead>
                                            <tr>
                                                <th style="width: 25%">Disediakan</th>
                                                <th style="width: 25%">Diluluskan I</th>
                                                <th style="width: 25%">Diluluskan II</th>
                                                <th style="width: 25%">Penandatangan Cek/E-Banker</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblLejarPrint">
                                            <td style="text-align: left;" id="printStatus08"></td>
                                            <td style="text-align: left;" id="printStatus11"></td>
                                            <td style="text-align: left;" id="printStatus12"></td>
                                            <td style="text-align: left;" id="printStatus"></td>
                                        </tbody>
                                    </table>
                                </div>
                                <div style="width: 100%;">
                                    <table style="width: 100%;font-size:12px">
                                        <tr style="position: relative; width:100%">
                                            <td style="width: 20%;">
                                                <b>No. Baucar</b>
                                            </td>
                                            <td>:</td>
                                            <td id="printBaucarNo"></td>
                                            <td style="right: 0; position:absolute">
                                                <b>Tarikh</b> : <span id="printBcrTarikh"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20%;">
                                                <b>No. Permohonan</b>
                                            </td>
                                            <td>:</td>
                                            <td id="printInvRujukan"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20%;">
                                                <b>No. Invois</b>
                                            </td>
                                            <td>:</td>
                                            <td id="printInvNo"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20%;">
                                                <b>Tujuan Bayaran</b>
                                            </td>
                                            <td>:</td>
                                            <td  id="printTujuan">T</td>
                                        </tr>
                                    </table>
                                </div>

                                <div style="width: 100%;">
                                    <table class="tblPrint">
                                        <thead>
                                            <tr>
                                                <th style="width: 10%">No. Cek/Rujukan</th>
                                                <th style="width: 70%;text-align:left">Nama Penerima</th>
                                                <th style="width: 10%">Jumlah</th>
                                                <th style="width: 10%">Kod Cukai</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tblPenerimaPrint">

                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script type="text/javascript" src="../../../Content/js/SharedFunction.js"></script> 
                    <script type="text/javascript">

                        // print

                        function printBaucar(e){
                            e.preventDefault()
                            $("#permohonan").modal('hide')
                            $("#permohonan").on('hidden.bs.modal', printB);
                        }
                        function printB() { 
                            $("#permohonan").pageYOffset
                            window.print()
                            
                            setTimeout(function () { window.close(); }, 100);
                            $("#permohonan").modal('show')
                            $("#permohonan").off('hidden.bs.modal', printB) 

                        }
                        function priceText(val) {
                            // val should be float
                            let txt = ""
                            let arrDigit = ["", "SATU", "DUA", "TIGA", "EMPAT", "LIMA", "ENAM", "TUJUH", "LAPAN", "SEMBILAN"]
                            let arrPlace = ["SEN", "PULUH", "RINGGIT", "PULUH", "RATUS", "RIBU", "PULUH RIBU", "RATUS RIBU", "JUTA"]
                            try {
                                let strval = val.toFixed(2).toString().replace('.', '')
                                for (let i = 0; i < strval.length; i++) {
                                    console.log('i', strval.charAt(-1 - i))
                                    let digit = arrDigit[parseInt(strval.charAt(strval.length - 1 - i))]
                                    if (digit != "") {
                                        txt = digit + " " + arrPlace[i] + " " + txt
                                    }
                                    else {
                                        if (i == 0 || i == 2) { //sen ringgit
                                            txt = arrPlace[i] + " " + txt
                                        }
                                    }

                                } 
                            } catch (e) {

                            }
                            txt = txt.trim()
                            txt = txt.replace('RINGGIT SEN', 'RINGGIT KOSONG SEN')
                            if (txt.startsWith('RINGGIT')) {
                                txt = "KOSONG " + txt
                            }
                            return txt

                        }

                        function getKelulusan(No_Baucar){
                            
                            return new Promise(function (resolve, reject) {
                                $.ajax({
                                    url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Baucar_WS.asmx/getKelulusan") %>',
                                    method: "POST",
                                    data: JSON.stringify({
                                        "No_Baucar": No_Baucar
                                    }),
                                    dataType: "json",
                                    contentType: "application/json;charset=utf-8",
                                    success: function (data) {
                                        data = JSON.parse(data.d)
                                        console.log("lulis",data) 
                                        data.Payload.forEach(k=>{
                                            try{
                                                let tarikh = new Date(k.Tarikh)
                                                let local =   tarikh.toLocaleString('en-GB', {
                                                    hour: 'numeric',
                                                    minute: 'numeric',
                                                    hour12: true,
                                                    day: 'numeric',
                                                    month: 'numeric',
                                                    year: 'numeric'
                                                })
                                                
                                                let str = k.Nama_Pemiutang + "<br>" + local
                                                $("#printStatus" + k.Kod_Status_Dok).html(str)
                                            }catch(e){

                                            } 
                                        })
                                        resolve()
                                    },
                                    error: function (xhr, status, error) {
                                        console.error(error);
                                        reject(error)
                                    }
                                })
                            })
                        }

                        function printClearRow() {
                            $("#tblLejarPrint").html("")
                        }
                        function printAddRow(rowdata) {
                            let html = '<td>' + rowdata.Kod_Kump_Wang + '</td>'
                                + ' <td>' + rowdata.Kod_PTJ + '</td>'
                                + ' <td>' + rowdata.Kod_Vot + '</td>'
                                + ' <td></td>';
                            if (rowdata.credit) {
                                html += '<td></td><td>' + formatPrice(rowdata.Jumlah_Perlu_Bayar) + '</td>'
                            }
                            else {
                                html += '<td>' + formatPrice(rowdata.Jumlah_Perlu_Bayar) + '</td><td></td>'

                            }
                            console.log('rdata', rowdata)
                            $("#tblLejarPrint").append("<tr>" + html + "</tr>")
                        }
                        function printClearRowPenerima(){
                            $("#tblPenerimaPrint").html("")

                        }
                        function printAddRowPenerima(Kod_Pemiutang,PMINFO) {
                            console.log(Kod_Pemiutang)
                            let pm = getPemiutang(Kod_Pemiutang)
                            console.log('pm',pm)
                            let html = '<td></td>'
                                + ' <td style="text-align:left">' + pm.Nama_Pemiutang + '<br><br>'
                                    + pm.Alamat_1 + '<br>'
                                    + pm.Alamat_2 + '<br>'
                                    + pm.Poskod + ', '
                                    + pm.Bandar_Detail + '<br>'
                                    + pm.Negeri_Detail + ', ' + pm.Negara_Detail + '<br>'
                                    + 'No. Akaun: ' + pm.No_Akaun
                                    + '</td>'
                                + ' <td>' + formatPrice(PMINFO.Jumlah_Bayar) + '</td>'
                                + ' <td>' + PMINFO.Kod_Cukai + '</td>';  
                            $("#tblPenerimaPrint").append("<tr>" + html + "</tr>")
                        }
                        function printLoadHdr(bcrData){
                            console.log('baucar',bcrData)
                            $("#printBaucarNo").html(bcrData.No_Baucar)
                            $("#printInvRujukan").html(bcrData.ID_Rujukan)
                            $("#printBcrTarikh").html(bcrData.Tarikh_Localized)

                        }
                        // print

                        // jumlah terperinci

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
                        ///////

                        //modal stacking
                        $(document).on('show.bs.modal', '.modal', function (event) {
                            var zIndex = 1040 + (10 * $('.modal:visible').length);
                            $(this).css('z-index', zIndex);
                            setTimeout(function () {
                                $('.modal-backdrop').not('.modal-stack').css('z-index', zIndex - 1).addClass('modal-stack');
                            }, 0);
                        });
                        //modal stacing end

                        // modal penerima code
                        function showPenerima(e) {
                            console.log('clicked', e)
                            console.log(e.dataset.kp)
                            showModalMaklumatPenerima(e.dataset.kp)
                        }
                        function showModalMaklumatPenerima(kod_pemiutang) {
                            console.log('kp', kod_pemiutang)
                            let pm = getPemiutang(kod_pemiutang)

                            $("#modalPenerima").find('.data-penerima').each(function () {
                                $(this).html('')
                                let name = $(this).attr("name")
                                if (name) {
                                    if (pm[name]) {
                                        if (name == "Jumlah_Bayar") {

                                            $(this).html(formatPrice(pm[name]))
                                        }
                                        else {

                                            $(this).html(pm[name])
                                        }
                                    }
                                }
                            })
                            $("#modalPenerima").modal("show")
                        }
                        // modal penerima code end


                        //Take the category filter drop down and append it to the datatables_filter div. 
                        //You can use this same idea to move the filter anywhere withing the datatable that you want.
                        $("#tblSenaraiInvois_filter.dataTables_filter").append($("#ddlJenInv"));

                        var tbl = null
                        var cacheJenByr = null
                        var cacheJenInvois = null
                        var cacheBank = null
                        var cacheKodCukai = null
                        var cacheCaraBayar = null
                        var tblPenerima

                        var coaVotKeyCache = []
                        var coaVotValueCache = []
                        var pemiutangKeyCache = []
                        var pemiutangValueCache = []
                        var tblLejar

                        var cacheKodPair = []


                        async function lulusBaucar() {
                            let save = await dialogPengesahan("Lulus  Baucar?")
                            if (!save) {
                                return
                            }
                            var errors = []
                            console.log('simpan baucar')
                            // prepare data

                            // baucar hdr
                            var baucar = {}
                            baucar["No_Baucar"] = cacheBaucar["No_Baucar"]

                            show_loader()
                            console.log('invois hdr')
                            console.log(cacheInvoisHdr)
                            var hdrStatus = await postLulusBaucar(baucar).catch(function (err) {
                                dialogMakluman("Baucar gagal diluluskan: " + err)
                            })
                            close_loader()
                            if (hdrStatus) {
                                dialogMakluman("Baucar Berjaya diluluskan")
                                $("#permohonan").modal("hide")
                                $("#btnSearch").click()
                            }

                            console.log(baucar)
                        }

                        function postLulusBaucar(baucar) {
                            return new Promise(function (resolve, reject) {
                                $.ajax({
                                    url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Baucar_WS.asmx/lulusBaucar1") %>',
                                    method: "POST",
                                    data: JSON.stringify({
                                        "baucar": baucar
                                    }),
                                    dataType: "json",
                                    contentType: "application/json;charset=utf-8",
                                    success: function (data) {
                                        console.log("simpan")
                                        console.log(data)
                                        var jsondata = JSON.parse(data.d)
                                        if (jsondata.Code == "200") {
                                            resolve(true)
                                        }
                                        else {
                                            reject(jsondata.Message)
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        console.error(error);
                                        reject(error)
                                    }
                                })
                            })
                        }
                        // page load
                        $(document).ready(function () {





                            var today = toSqlDateString(new Date())

                            document.getElementById('txtTarikhStart').setAttribute('max', today);
                            document.getElementById('txtTarikhEnd').setAttribute('max', today);

                            // data table set up

                            tblPenerima = $("#tblPenerimaBaucar").DataTable({
                                "responsive": true,
                                "paging": false,
                                "searching": false,
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
                                    "sInfo": "",
                                    "sInfoEmpty": "",
                                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                                    "sEmptyTable": "Tiada rekod.",
                                    "sSearch": "Carian"
                                },
                                columnDefs: [
                                    { targets: 0, width: '10%' },
                                    { targets: 1, width: '10%' },
                                    { targets: 2, width: '5%' },
                                    { targets: 3, width: '5%' },
                                    { targets: 4, width: '5%' },
                                    { targets: 5, width: '5%' },
                                    { targets: 6, width: '15%' },
                                    { targets: 7, width: '15%' },
                                    { targets: 8, width: '15%' },
                                    { targets: 6, className: 'text-right' }
                                ],
                                columns: [
                                    {
                                        "data": "Kod_Pemiutang",
                                        render: function (data, type, row) {
                                            let txt = ""
                                            if (row.PMINFO) {
                                                txt += (row.PMINFO.Kategori_Pemiutang != null) ? row.PMINFO.Kategori_Pemiutang : ""
                                                txt += " - "
                                                txt += (row.PMINFO.Nama_Pemiutang != null) ? row.PMINFO.Nama_Pemiutang : ""
                                            }
                                            return '<span style="cursor: help;" data-kp="' + data + '" onclick="showPenerima(this)">' + data
                                                + '&nbsp<i class="fa fa-info-circle" aria-hidden="true"></i>'
                                                + '<br><span class="additional-info">' + txt + "</span></span>"
                                        }
                                    },
                                    {
                                        data: 'Kod_Vot',
                                        render: function (data, type, row) {
                                            let txt = ""
                                            if (row.VOTINFO) {
                                                txt = (row.VOTINFO.VOT != null) ? row.VOTINFO.VOT : ""
                                            }
                                            return data + "<br>" + txt
                                        }
                                    },
                                    {
                                        data: 'Kod_PTJ',
                                        render: function (data, type, row) {
                                            let txt = ""
                                            if (row.VOTINFO) {
                                                txt = (row.VOTINFO.PTJ != null) ? row.VOTINFO.PTJ : ""
                                            }
                                            return data + "<br>" + txt
                                        }
                                    },
                                    {
                                        data: 'Kod_Kump_Wang',
                                        render: function (data, type, row) {
                                            let txt = ""
                                            if (row.VOTINFO) {
                                                txt = (row.VOTINFO.KW != null) ? row.VOTINFO.KW : ""
                                            }
                                            return data + "<br>" + txt
                                        }
                                    },
                                    {
                                        data: 'Kod_Operasi',
                                        render: function (data, type, row) {
                                            let txt = ""
                                            if (row.VOTINFO) {
                                                txt = (row.VOTINFO.KO != null) ? row.VOTINFO.KO : ""
                                            }
                                            return data + "<br>" + txt
                                        }
                                    },
                                    {
                                        data: 'Kod_Projek',
                                        render: function (data, type, row) {
                                            let txt = ""
                                            if (row.VOTINFO) {
                                                txt = (row.VOTINFO.KP != null) ? row.VOTINFO.KP : ""
                                            }
                                            return data + "<br>" + txt
                                        }
                                    },
                                    {
                                        data: 'Jumlah_Bayar',
                                        render: function (data, type, row) {
                                            return formatPrice(data)

                                        }
                                    },
                                    {
                                        data: 'Kod_Cukai',
                                        render: function (data, type, row) {
                                            return (cacheKodCukai[data]) ? data + " - " + cacheKodCukai[data] : '';
                                        }
                                    },
                                    {
                                        data: 'Cara_Bayar',
                                        render: function (data, type, row) {
                                            return (cacheCaraBayar[data]) ? data + " - " + cacheCaraBayar[data] : '';
                                        }
                                    }
                                ],
                                createdRow: function (row, data, index) {
                                    row.id = data.No_Baucar + data.Kod_Pemiutang
                                }

                            })

                            $('#tblPenerimaBaucar').on('keyup', 'input:not(.search)', function () {

                                var row = tblPenerima.row($(this).closest('tr'));
                                var rowData = row.data();
                                var keyName = $(this).attr('name');
                                if (keyName == "Jumlah_Bayar") {
                                    formatPriceKeyUp(this)
                                    let max = formattedPriceToFloat($(this).attr('max'))
                                    let value = formattedPriceToFloat($(this).val())
                                    console.log("val", value)
                                    if (max != 0 && value > max) {
                                        console.log("max", max)
                                        $(this).val(formatPrice(max))

                                        let elem = $(this)[0]
                                        elem.selectionStart = 0
                                        elem.selectionEnd = 0
                                    }

                                    rowData[keyName] = $(this).val();
                                    calculateTotalPayment()
                                    console.log(tblLejar.rows().data())
                                    calcSumCredit()
                                }
                                else {

                                    rowData[keyName] = $(this).val();
                                }
                                //calculate sini nanti
                            });

                            tbl = $("#tblSenaraiInvois").DataTable({
                                "responsive": true,
                                "searching": true,
                                "rowCallback": function (row, data) {
                                    // Add hover effect
                                    $(row).hover(function () {
                                        $(this).addClass("hover pe-auto bg-warning");
                                    }, function () {
                                        $(this).removeClass("hover pe-auto bg-warning");
                                    });
                                },
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
                                columnDefs: [
                                    { "visible": false, "targets": [0, 5, 6] },
                                    { targets: [10], className: 'text-right' },
                                    { targets: [8, 2], width: '20%' },
                                    { targets: [1, 3, 4, 8, 9, 10], width: '10%' }
                                ],
                                "columns": [
                                    { "data": "ID_Rujukan" },
                                    { "data": "No_Invois" },
                                    { "data": "Nama_Pemiutang" },
                                    { "data": "Jenis_Invois" },
                                    {
                                        "data": "Tarikh_Daftar",
                                        render: function (data, type, row) {
                                            if (!data) {

                                                return ''
                                            }
                                            var dateParts = data.split('T')[0].split('-');
                                            return dateParts[2] + '/' + dateParts[1] + '/' + dateParts[0];
                                        }
                                    },
                                    {
                                        "data": "Tarikh_Invois",
                                        render: function (data, type, row) {
                                            if (!data) {

                                                return ''
                                            }
                                            var dateParts = data.split('T')[0].split('-');
                                            return dateParts[2] + '/' + dateParts[1] + '/' + dateParts[0];
                                        }
                                    },
                                    {
                                        "data": "Tarikh_Terima_Invois",
                                        render: function (data, type, row) {
                                            if (!data) {

                                                return ''
                                            }
                                            var dateParts = data.split('T')[0].split('-');
                                            return dateParts[2] + '/' + dateParts[1] + '/' + dateParts[0];
                                        }
                                    },
                                    { "data": "Jenis_Bayar" },
                                    { "data": "Tujuan" },
                                    { "data": "Status" },
                                    {
                                        "data": "Jumlah",
                                        render: function (data, type, row) {
                                            return formatPrice(data)
                                        }
                                    }
                                ],
                                createdRow: function (row, data, dataIndex) {
                                    // row.dataset.jenisinvois = data["Jenis_Invois"];
                                    row.dataset.idrujukan = data["ID_Rujukan"]
                                    row.onclick = showModalBaucar
                                }

                            });

                            //  loadInvoisList(today) 

                            //load cara bayar cache to display in baucr modal   <>
                            $.ajax({
                                url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Baucar_WS.asmx/getSenaraiCaraBayar") %>',
                                method: "POST",
                                data: JSON.stringify({
                                    q: ""
                                }),
                                dataType: "json",
                                contentType: "application/json;charset=utf-8",
                                success: function (data) {
                                    data = JSON.parse(data.d)
                                    cacheCaraBayar = {}
                                    data.Payload.forEach(d => {
                                        cacheCaraBayar[d.Kod_Detail] = d.Butiran
                                    })
                                    console.log("cara bayar", cacheCaraBayar)
                                },
                                error: function (xhr, status, error) {
                                    console.error(error);
                                }
                            })
                            //load kod cukai cache to display in baucr modal  
                            $.ajax({
                                url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Baucar_WS.asmx/getSenaraiKodCukai") %>',
                                method: "POST",
                                data: JSON.stringify({
                                    q: ""
                                }),
                                dataType: "json",
                                contentType: "application/json;charset=utf-8",
                                success: function (data) {
                                    data = JSON.parse(data.d)
                                    cacheKodCukai = {}
                                    data.Payload.forEach(d => {
                                        cacheKodCukai[d.Kod_Detail] = d.Butiran
                                    })
                                    console.log("cukai", cacheKodCukai)
                                },
                                error: function (xhr, status, error) {
                                    console.error(error);
                                }
                            })


                            //load jenis bank cache to display in baucr modal  
                            $.ajax({
                                url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Baucar_WS.asmx/getSenaraiBank") %>',
                                method: "POST",
                                data: JSON.stringify({
                                    q: ""
                                }),
                                dataType: "json",
                                contentType: "application/json;charset=utf-8",
                                success: function (data) {
                                    data = JSON.parse(data.d)
                                    cacheBank = {}
                                    data.Payload.forEach(d => {
                                        cacheBank[d.Kod_Bank] = d.Nama_Bank
                                    })
                                    console.log("bank", cacheBank)
                                },
                                error: function (xhr, status, error) {
                                    console.error(error);
                                }
                            })

                            //load jenis bayar to display in baucr modal
                            $.ajax({
                                url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/INVOIS/Transaksi_InvoisWS.asmx/GetJenByrList") %>',
                                method: "POST",
                                data: JSON.stringify({
                                    q: ""
                                }),
                                dataType: "json",
                                contentType: "application/json;charset=utf-8",
                                success: function (data) {
                                    jsondata = JSON.parse(data.d)
                                    cacheJenByr = {}
                                    jsondata.forEach(d => {
                                        cacheJenByr[d.value] = d.text
                                    })
                                    console.log(cacheJenByr)
                                },
                                error: function (xhr, status, error) {
                                    console.error(error);
                                }
                            })
                            // cache jenis invois to display in baucr modal
                            $.ajax({
                                url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/INVOIS/Transaksi_InvoisWS.asmx/GetJenInvList") %>',
                                method: "POST",
                                data: JSON.stringify({
                                    q: ""
                                }),
                                dataType: "json",
                                contentType: "application/json;charset=utf-8",
                                success: function (data) {
                                    jsondata = JSON.parse(data.d)
                                    cacheJenInvois = {}
                                    jsondata.forEach(d => {
                                        cacheJenInvois[d.value] = d.text
                                    })
                                    console.log(cacheJenInvois)
                                },
                                error: function (xhr, status, error) {
                                    console.error(error);
                                }
                            })

                            //trigger dropdown first loads
                            $('#ddlJenInv').dropdown('show');
                            $('#ddlJenInv').dropdown('hide');
                            $("#ddlJenInv").dropdown('set selected', '');




                            tblLejar = $("#tblLejar").DataTable({
                                "responsive": true,
                                "searching": false, ordering: true,
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
                                "columns":
                                    [
                                        {
                                            "data": "Kod_Pemiutang"
                                        },
                                        {
                                            data: 'Kod_Vot',
                                            render: function (data, type, row) {
                                                if (!data) {
                                                    data = ""
                                                }

                                                return (row.votBank) ? row.votBank : data
                                            }
                                        },
                                        {
                                            data: 'Kod_PTJ',
                                            render: function (data, type, row) {

                                                return (row.votBank) ? "500000" : data  //<hc>  ptj  default
                                            }
                                        },
                                        {
                                            data: 'Kod_Kump_Wang'
                                        },
                                        {
                                            data: 'Kod_Operasi'
                                        },
                                        {
                                            data: 'Kod_Projek'
                                        },
                                        {
                                            "data": "Jumlah_Perlu_Bayar",
                                            render: function (data, type, row) {

                                                return (row.debit) ? formatPrice(data) : ''
                                            }
                                        },
                                        {
                                            "data": "Jumlah_Bayar",
                                            render: function (data, type, row) {
                                                console.log('redraw', data)
                                                return (row.credit) ? formatPrice(data) : ''
                                            }

                                        },
                                        { //placeholder data  
                                            "data": "Kadar_Harga",
                                            render: function (data, type, row) {
                                                return ''
                                            }
                                        }
                                    ],
                                columnDefs: [
                                    //   { targets: 0, width: '15%' },
                                    //    { targets: 1, width: '15%' },
                                    //    { targets: 2, width: '5%' },
                                    //    { targets: 3, width: '5%' },
                                    //     { targets: 4, width: '5%' }
                                    //    { targets: 5, width: '5%' },
                                    //    { targets: 6, width: '10%' },
                                    //      { targets: 7, width: '5%' },
                                    //    { targets: 8, width: '10%' }
                                    //     { targets: 9, width: '6%' },
                                    //      { targets: 10, width: '6%' },
                                    //    { targets: 11, width: '10%' }
                                    { targets: [6, 7, 8], className: 'text-right' }
                                ],
                                createdRow: function (row, data, dataIndex) {
                                    row.dataset.noitem = data["No_Item"];

                                    $(row).find('.additional-info').hide();
                                }

                            });

                        });


                        // page load end



                        function applyChangeToLejar() {
                            tblLejar
                                .rows()
                                .invalidate()
                                .draw();

                        }
                        function changeLejarVotBank(votbank) {
                            tblLejar.rows().data().each(function (rowdata) {
                                if (rowdata.credit) {
                                    rowdata.votBank = votbank
                                }
                            })
                            applyChangeToLejar()
                        }
                        function calcSumCredit() {
                            let totalcredit = 0
                            tblLejar.rows().data().each(function (rowdata) {
                                if (rowdata.credit) {
                                    totalcredit += formattedPriceToFloat(rowdata.Jumlah_Bayar)
                                }
                            })
                            $("#lejarTC").html(formatPrice(totalcredit))
                            applyChangeToLejar()
                        }

                        function saveKodPair(kw, ko, kp, val) {
                            //kod vot yang belum search je
                            //filter return yg sama, kalau sama ==0 then belum ada so add

                            let found = false
                            cacheKodPair.forEach(vp => {
                                if (
                                    vp.Kod_Kump_Wang === kw &&
                                    vp.Kod_Operasi === ko &&
                                    vp.Kod_Projek === kp
                                ) {

                                    vp.Jumlah_Perlu_Bayar += parseFloat(val)
                                    found = true
                                } else {

                                }
                            })
                            if (!found)
                                cacheKodPair.push(newKodPair(kw, ko, kp, parseFloat(val)))
                        }

                        function newKodPair(kw, ko, kp, val) {
                            return {
                                Kod_Kump_Wang: kw,
                                Kod_Operasi: ko,
                                Kod_Projek: kp,
                                Jumlah_Perlu_Bayar: val
                            }
                        }


                        function subTabChange(e) {
                            e.preventDefault()
                            Array.from(e.target.parentElement.parentElement.getElementsByClassName("active")).forEach(e => {
                                e.classList.remove("active")
                            })
                            e.target.classList.add("active")
                            console.log(e.target)
                            showTab(e.target.dataset.tab)
                        }

                        function showTab(id) {
                            $(".modal-sub-tab").hide()
                            if (id == "ALL") {
                                $(".modal-sub-tab").show()
                                return

                            }
                            $("#" + id).show()

                        }


                        function getCOAVot(VOT, PTJ, KW, KP, KO) {
                            return coaVotValueCache.filter(item =>
                                item.KodVOT === VOT &&
                                item.KodPTJ === PTJ &&
                                item.KodKW === KW &&
                                item.KodKO === KO &&
                                item.KodKP === KP
                            )[0]
                        }

                        function getCOAVotNovot(VOT, PTJ, KW, KP, KO) {
                            return coaVotValueCache.filter(item =>
                                item.KodPTJ === PTJ &&
                                item.KodKW === KW &&
                                item.KodKO === KO &&
                                item.KodKP === KP
                            )[0]

                        }
                        function searchCOAVot(arrVot) {
                            //kod vot yang belum search je
                            let filter = arrVot.filter(value => !coaVotKeyCache.includes(value));
                            return loadCOAVot(filter)
                        }


                        function loadCOAVot(arrVot) {

                            return new Promise(function (resolve, reject) {
                                if (arrVot.length > 0) {

                                    $.ajax({
                                        url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Invois_WS.asmx/GetVotCOASpecific") %>',
                                        method: "POST",
                                        data: JSON.stringify({ Kod: arrVot }),
                                        dataType: "json",
                                        contentType: "application/json;charset=utf-8",
                                        success: function (data) {
                                            if (data.d) {
                                                data = JSON.parse(data.d)
                                                console.log('coa')
                                                console.log(data)
                                                coaVotValueCache.push(...data)
                                                coaVotKeyCache.push(...arrVot)
                                                console.log(coaVotKeyCache)
                                                console.log(coaVotValueCache)
                                            }
                                            resolve(true)

                                        },
                                        error: function (xhr, status, error) {
                                            console.error(error);
                                            reject()
                                        }
                                    })

                                }
                                else {
                                    resolve(true)
                                }
                            })
                        }

                        ///////// senarai invois
                        function loadInvoisLists(dateStart, dateEnd) {
                            console.log('newing')
                            if (!dateEnd) {
                                dateEnd = ""
                            }
                            if (!dateStart) {
                                dateStart = ""
                            }
                            show_loader()
                            $.ajax({
                                url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Baucar_WS.asmx/getInvoisBaucarKemaskini") %>',
                                method: "POST",
                                data: JSON.stringify({
                                    DateStart: dateStart,
                                    DateEnd: dateEnd
                                }),
                                dataType: "json",
                                contentType: "application/json;charset=utf-8",
                                success: function (data) {
                                    close_loader()
                                    data = JSON.parse(data.d)
                                    //     tbl.clear()
                                    //     tbl.rows.add(data).draw() 
                                    tbl.clear()
                                    tbl.rows.add(data.Payload).draw()
                                },
                                error: function (xhr, status, error) {
                                    close_loader()
                                    console.error(error);
                                }
                            })
                        }

                        function dateFilterHandler(e) {
                            if (e.target.value == "select") {
                                $("#specificDateFilter").show()
                            }
                            else {
                                $("#specificDateFilter").hide()
                            }
                        }

                        function loadInvois() {

                            if ($("#invoisDateFilter").val() == "select") {
                                let dateStart = $("#txtTarikhStart").val()
                                let dateEnd = $("#txtTarikhEnd").val()
                                if (dateStart == "") {
                                    dialogMakluman("sila pilih tarikh carian")
                                    return
                                }
                                loadInvoisLists(dateStart, dateEnd)
                            }
                            else if ($("#invoisDateFilter").val() == "all") {
                                loadInvoisLists()

                            }
                            else {
                                let days = $("#invoisDateFilter").val()
                                let dateString = toSqlDateString(getDateBeforeDays(days))
                                loadInvoisLists(dateString, "")
                            }
                        }

                        ///////// senarai invois end


                        var cacheInvoisHdr
                        var cacheBaucar
                        function showModalBaucar(e) {
                            var target = e.target
                            if (target.tagName == "TD") {
                                target = target.parentElement
                            }
                            show_loader()

                            $('#permohonan input').val('');
                            $(".modal-body div").val("");

                            let idrujukan = target.dataset.idrujukan
                            $.ajax({
                                url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Baucar_WS.asmx/getBaucarByIDRujukan") %>',
                                method: "GET",
                                dataType: "json",
                                data: {
                                    ID_Rujukan: '"' + idrujukan + '"'
                                },
                                contentType: "application/json;charset=utf-8",
                                success: async function (data) {
                                    var jsonData = JSON.parse(data.d)
                                    console.log('sni')
                                    console.log(jsonData)
                                    //  console.log(jsonData.Payload)
                                    console.log('sni')
                                    if (jsonData.Payload[0]) {

                                        cacheBaucar = jsonData.Payload[0]
                                    }
                                    else {
                                        cacheBaucar = jsonData.Payload
                                    }
                                    await loadInvoisHdr(idrujukan)
                                    await loadBaucarIntoModal(cacheBaucar)
                                    await loadBaucarDTLIntoModal(cacheBaucar.No_Baucar)
                                    await getKelulusan(cacheBaucar.No_Baucar)
                                    close_loader()
                                    $("#permohonan").modal("show")

                                    $('#permohonan').one('hidden.bs.modal', function () {
                                        //clear cache on modal close
                                        cacheInvoisHdr = null
                                        cacheBaucar = null
                                    });
                                },
                                error: function (xhr, status, error) {
                                    console.error(error);
                                    close_loader()
                                }
                            })
                        }

                        function loadInvoisHdr(idrujukan) {
                            return new Promise(function (resolve, reject) {

                                $.ajax({
                                    url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Invois_WS.asmx/getInvoisHeader") %>',
                                    method: "GET",
                                    dataType: "json",
                                    data: {
                                        ID_Rujukan: '"' + idrujukan + '"'
                                    },
                                    contentType: "application/json;charset=utf-8",
                                    success: function (data) {
                                        var jsonData = JSON.parse(data.d)
                                        if (jsonData.Code == "200") {
                                            cacheInvoisHdr = jsonData.Payload[0]
                                            loadInvoisHdrIntoModal(cacheInvoisHdr)
                                            resolve()
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        console.error(error);
                                        reject()
                                    }
                                })
                            })
                        }

                        function loadInvoisHdrIntoModal(invHdr) {
                            $("#printTujuan").html(invHdr.Tujuan)
                            $("#printInvNo").html(invHdr.No_Invois)

                            $("#txtJenByr").val((cacheJenByr[invHdr.Jenis_Bayar]) ? cacheJenByr[invHdr.Jenis_Bayar] : invHdr.Jenis_Bayar);
                            $("#txtJenInvois").val((cacheJenInvois[invHdr.Jenis_Invois]) ? cacheJenInvois[invHdr.Jenis_Invois] : invHdr.Jenis_Invois);
                            $("#txtIDRujukan").val(invHdr.ID_Rujukan)
                            $("#txtJumlahPerluBayar").val(formatPrice(invHdr.Jumlah_Sebenar))
                            calculateTotalPayment()

                        }

                        function loadBaucarIntoModal(baucar) {
                            console.log(baucar)
                            if (baucar.No_Baucar) {
                                $("#txtNoBaucar").val(baucar.No_Baucar);
                            }
                            if (baucar.Tarikh) {
                                let tarikh = new Date(baucar.Tarikh)
                                baucar.Tarikh_Localized = tarikh.toLocaleString('en-GB', {
                                    hour: 'numeric',
                                    minute: 'numeric',
                                    hour12: true,
                                    day: 'numeric',
                                    month: 'numeric',
                                    year: 'numeric'
                                })
                                $("#txtTarikhBaucar").val(baucar.Tarikh_Localized);
                            }
                            $("#txtButiranBaucar").val(baucar.Butiran);

                            if (baucar.Kod_Bank) {
                                $("#txtBank").val(baucar.Kod_Bank + " - " + cacheBank[baucar.Kod_Bank])
                            }
                            else {
                                $("#txtBank").val('')

                            }
                            printLoadHdr(baucar)

                        }

                        function loadBaucarDTLIntoModal(No_Baucar) {
                            return new Promise(function (resolve, reject) {
                                console.log(No_Baucar)
                                $.ajax({
                                    url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Baucar_WS.asmx/getBaucarDtl") %>',
                                    method: "POST",
                                    data: JSON.stringify({
                                        No_Baucar: No_Baucar
                                    }),
                                    dataType: "json",
                                    contentType: "application/json;charset=utf-8",
                                    success: async function (data) {
                                        console.log('dtl')
                                        data = JSON.parse(data.d)
                                        console.log(data)
                                        let arrvot = []
                                        let arrpm = []
                                        data.forEach(dtl => {
                                            arrvot.push(dtl.Kod_Vot)
                                            arrpm.push(dtl.Kod_Pemiutang)
                                        })
                                        let coaload = await searchCOAVot(arrvot).catch(function (err) {
                                            console.log(err)
                                        })
                                        if (!coaload) {
                                            dialogMakluman("masalah dalam mendapatkan data vot dari server")
                                        }
                                        let pmload = await searchPemiutang(arrpm).catch(function (err) {
                                            console.log(err)
                                        })
                                        if (!pmload) {
                                            dialogMakluman("masalah dalam mendapatkan data pemiutang dari sistem")
                                        }

                                        let tmpKodPemiutang = {}

                                        let gJumplahPB = 0

                                        cacheKodPair = []
                                        let dtlCount = 0;
                                        printClearRow()
                                        data.forEach(dtl => {
                                            dtlCount++;
                                            dtl.VOTINFO = getCOAVot(dtl.Kod_Vot, dtl.Kod_PTJ, dtl.Kod_Kump_Wang, dtl.Kod_Projek, dtl.Kod_Operasi)
                                            dtl.PMINFO = getPemiutang(dtl.Kod_Pemiutang)
                                            dtl.credit = true
                                            let jumlah_raw = parseNumber(dtl.Kadar_Harga) * parseNumber(dtl.Kuantiti_Sebenar)
                                            let jumlah_cukai = parseNumber(dtl.Cukai) / 100 * jumlah_raw
                                            let jumlah_diskaun = parseNumber(dtl.Diskaun) / 100 * jumlah_raw
                                            let Jumlah_Perlu_Bayar = jumlah_raw + jumlah_cukai - jumlah_diskaun
                                            dtl.Jumlah_Perlu_Bayar = to2Decimal(Jumlah_Perlu_Bayar)
                                            if (!dtl.Jumlah_Bayar || dtl.Jumlah_Bayar == 0) {
                                                dtl.Jumlah_Bayar = Jumlah_Perlu_Bayar
                                            }
                                            saveKodPair(dtl.Kod_Kump_Wang, dtl.Kod_Operasi, dtl.Kod_Projek, dtl.Jumlah_Perlu_Bayar)
                                            gJumplahPB += Jumlah_Perlu_Bayar
                                            dtl.Kadar_Harga = to2Decimal(dtl.Kadar_Harga)
                                            dtl.votBank = cacheBaucar.Kod_Bank

                                            if (tmpKodPemiutang[dtl.Kod_Pemiutang]) {
                                                //kalau ada tambah
                                                tmpKodPemiutang[dtl.Kod_Pemiutang].Jumlah_Bayar = parseFloat(tmpKodPemiutang[dtl.Kod_Pemiutang].Jumlah_Bayar) + parseFloat(dtl.Jumlah_Perlu_Bayar)
                                            }
                                            else {
                                                //kalau xde masukkan 
                                                tmpKodPemiutang[dtl.Kod_Pemiutang] = {Jumlah_Bayar:parseFloat(dtl.Jumlah_Perlu_Bayar) , Kod_Cukai:dtl.Kod_Cukai} 

                                            }
                                            printAddRow(dtl)
                                        })
                                        printClearRowPenerima()
                                        for (let kod in tmpKodPemiutang) {
                                            printAddRowPenerima(kod,tmpKodPemiutang[kod])
                                        }

                                        $("#result").html(dtlCount)

                                        let debitdtl = []
                                        let hcptj = "500000" //hardcode, mana nk dpt kalau dari table vot bole skalikn dlm query pilihan
                                        let votbank = cacheBaucar.Kod_Bank
                                        votbank = (votbank) ? votbank : ""

                                        cacheKodPair.forEach(kp => {
                                            let vtinfo = getCOAVotNovot(hcptj, kp.Kod_Kump_Wang, kp.Kod_Projek, kp.Kod_Operasi)
                                            let tmpdtl = {
                                                Kod_Pemiutang: '',
                                                Kod_Vot: cacheInvoisHdr.Kod_Vot,
                                                Kod_PTJ: hcptj,
                                                Kod_Kump_Wang: kp.Kod_Kump_Wang,
                                                Kod_Operasi: kp.Kod_Operasi,
                                                Kod_Projek: kp.Kod_Projek,
                                                debit: true,
                                                Jumlah_Perlu_Bayar: kp.Jumlah_Perlu_Bayar,
                                                VOTINFO: vtinfo

                                            }
                                            debitdtl.push(tmpdtl)

                                            printAddRow(tmpdtl)
                                        })



                                        tblPenerima.clear()
                                        tblPenerima.rows.add(data).draw()


                                        let datalejar = data
                                        datalejar.push(...debitdtl)

                                        tblLejar.clear()
                                        tblLejar.rows.add(datalejar).draw()

                                        $("#lejarTD").html(formatPrice(gJumplahPB))

                                        calculateTotalPayment()
                                        calcSumCredit()

                                        resolve()
                                    },
                                    error: function (xhr, status, error) {
                                        console.error(error);
                                        reject()
                                    }
                                })

                            })
                        }

                        function calculateTotalPayment() {
                            console.log("calc")

                            var total = 0
                            var totaltobepayed = 0
                            tblPenerima.data().toArray().forEach(dtl => {
                                total += formattedPriceToFloat(dtl.Jumlah_Bayar)
                                totaltobepayed += formattedPriceToFloat(dtl.Jumlah_Perlu_Bayar)
                            })
                            $("#txtJumlahPerluBayar").val(formatPrice(totaltobepayed))
                            $("#txtJumlahBayaran").val(formatPrice(total))
                            $("#txtBakiBayaran").val(formatPrice(totaltobepayed - total))
                            $("#stickyJumlah").html(formatPrice(total))
                            $("#printJumlahByr").html(formatPrice(totaltobepayed))
                            $("#printRinggitText").html(priceText(totaltobepayed))
                            console.log(total)
                        }
                        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


                        function showError(errors) {
                            let msg = ""
                            errors.forEach(e => {
                                msg += e + "<br>"
                            })
                            dialogMakluman(msg)
                        }


                        function dialogPengesahan(msg) {
                            $("#dialogConfirmContent").html(msg)
                            var decision = false

                            return new Promise(function (resolve) {
                                $("#modalDialogConfirm").modal('show')

                                $('#btnDialogModalConfirm').on('click', function () {
                                    decision = true // Confirm button clicked
                                });
                                $('#modalDialogConfirm').on('hidden.bs.modal', function (e) {
                                    resolve(decision); // Modal closed without confirming
                                });

                            });
                        }

                        var queueMakluman = []
                        function dialogMakluman(msg) {
                            queueMakluman.push(msg)
                            if (!$('#modalDialogInfo').hasClass('show')) {
                                showDialogMakluman();
                            }

                        }

                        function showDialogMakluman() {
                            console.log(queueMakluman)
                            if (queueMakluman.length > 0) {
                                var msg = queueMakluman.shift()
                                $("#dialogInfoContent").html(msg)
                                $('#modalDialogInfo').modal('show');

                                $('#modalDialogInfo').one('hidden.bs.modal', function () {
                                    showDialogMakluman(); // Process the next alert after the modal is closed 
                                });
                            }
                        }

                        function toSqlDateString(date) {
                            let dd = date.getDate();
                            let mm = date.getMonth() + 1; // January is 0!
                            let yyyy = date.getFullYear();

                            if (dd < 10) {
                                dd = '0' + dd;
                            }

                            if (mm < 10) {
                                mm = '0' + mm;
                            }

                            return yyyy + '-' + mm + '-' + dd;
                        }

                        function getDateBeforeDays(days) {
                            let pastDate = new Date();
                            pastDate.setDate(pastDate.getDate() - days);
                            return pastDate;
                        }

                        function parseNumber(val) {
                            try {
                                const parsedValue = parseFloat(val);
                                console.log(parsedValue)
                                if (!isNaN(parsedValue)) {
                                    return parsedValue;
                                } else {
                                    return 0;
                                }
                            } catch (error) {
                                console.log('err' + error)
                                return 0;
                            }
                        }
                        function getPemiutang(kod) {
                            return pemiutangValueCache.filter(item =>
                                item.Kod_Pemiutang === kod
                            )[0]
                        }
                        function searchPemiutang(arrKod) {
                            //kod vot yang belum search je
                            let filter = arrKod.filter(value => !pemiutangKeyCache.includes(value));
                            return loadPemiutang(filter)
                        }

                        function loadPemiutang(arrKod) {
                            return new Promise(function (resolve, reject) {
                                if (arrKod.length > 0) {

                                    $.ajax({
                                        url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Invois_WS.asmx/getSpecificPemiutang") %>',
                                        method: "POST",
                                        data: JSON.stringify({ Kod: arrKod }),
                                        dataType: "json",
                                        contentType: "application/json;charset=utf-8",
                                        success: function (data) {
                                            if (data.d) {
                                                data = JSON.parse(data.d)
                                                data.forEach(d => {
                                                    let butiranAlamat = d.Butiran_Kod_Alamat
                                                    try {
                                                        d.Negeri_Detail = butiranAlamat.split('|')[1].split('--')[1]
                                                        d.Bandar_Detail = butiranAlamat.split('|')[2].split('--')[1]
                                                        d.Negara_Detail = butiranAlamat.split('|')[0].split('--')[1]

                                                    }
                                                    catch (e) {

                                                    }

                                                })

                                                pemiutangValueCache.push(...data)
                                                pemiutangKeyCache.push(...arrKod)
                                            }
                                            resolve(true)

                                        },
                                        error: function (xhr, status, error) {
                                            console.error(error);
                                            reject()
                                        }
                                    })

                                }
                                else {
                                    resolve(true)
                                }
                            })
                        }
                    </script>
        </contenttemplate>
    </asp:Content>