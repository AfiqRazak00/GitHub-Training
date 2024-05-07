﻿<%@ Page Title="" Language="vb" Async="true" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Terima_Terperinci.aspx.vb" Inherits="SMKB_Web_Portal.Terima_Terperinci" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <contenttemplate>
        <style>
            .default-primary {
                background-color: #007bff !important;
                color: white;
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
        </style>
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <div id="SenaraiKelulusan">
                <div>
                    <div class="modal-body">
                        <div class="modal-header" style="display:none">
                            <h5 class="modal-title">Senarai Bil</h5>
                        </div>
                        <!-- Create the dropdown filter -->
                        <div class="search-filter" style="display:none">
                            <div class="form-row justify-content-center">
                                 <div class="form-group row col-md-6">
                                    <label for="" class="col-sm-1 col-form-label">Carian:</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <select id="categoryFilter" class="custom-select">
                                                <option value="" selected>Semua</option>
                                                <option value="1">Hari Ini</option>
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
                                    <div class="col-sm-10 mt-4 d-none" id="divDatePicker">
                                        <div class="d-flex flex-row justify-content-around align-items-center">
                                            <div class="form-group row">
                                                <label class="col-sm-3 col-form-label text-nowrap">Mula:</label>
                                                <div class="col-sm-9">
                                                    <input type="date" id="txtTarikhStart" name="txtTarikhStart" class="form-control date-range-filter">
                                                </div>
                                            </div>

                                            <div class="form-group row ml-3">
                                                <label class="col-sm-3 col-form-label text-nowrap">Tamat:</label>
                                                <div class="col-sm-9">
                                                    <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" class="form-control date-range-filter">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <asp:Label id="lblhidkodpenghutang" name="lblhidkodpenghutang" runat="server" Visible="false"></asp:Label>
                                <div class="transaction-table table-responsive">
                                    <table id="tblDataSenarai" class="table table-striped">
                                        <thead>
                                            <tr style="width: 100%">
                                                <th scope="col" style="width: 10%" id="lblColumnBil">No. Bil</th>
                                                <th scope="col" style="width: 10%">Nama Penghutang</th>
                                                <th scope="col" style="width: 10%">Tarikh Mohon</th>
                                                <%--<th scope="col" style="width: 10%">Tarikh Mula</th>
                                                <th scope="col" style="width: 10%">Tarikh Tamat</th>--%>
                                                <th scope="col" style="width: 15%">Jenis Urusniaga</th>
                                                <th scope="col" style="width: 20%">Tujuan</th>
                                                <th scope="col" style="width: 10%">Jumlah (RM)</th>
                                            </tr>
                                        </thead>
                                        <tbody id=" ">
                                            <%--<tr style="display: none" class="table-list">

                                                <td>
                                                    <label id="lblNo" name="lblNo" class="lblNo"></label>
                                                </td>
                                                <td>
                                                    <label id="lblPenghutang" name="lblPenghutang" class="lblPenghutang"></label>
                                                </td>
                                                <td>
                                                    <label id="lblTkhMohon" name="lblTkhMohon" class="lblTkhMohon"></label>
                                                </td>
                                                <td>
                                                    <label id="lblTkhMula" name="lblTkhMula" class="lblTkhMula"></label>
                                                </td>
                                                <td>
                                                    <label id="lblTkhTamat" name="lblTkhTamat" class="lblTkhTamat"></label>
                                                </td>
                                                <td>
                                                    <label id="lblJnsUrus" name="lblJnsUrus" class="lblJnsUrus"></label>
                                                </td>
                                                <td>
                                                    <label id="lblTujuan" name="lblTujuan" class="lblTujuan"></label>
                                                </td>
                                                <td>
                                                    <label id="lblJumlah" name="lblJumlah" class="lblJumlah" style="text-align: right"></label>
                                                </td>
                          
                                            </tr>--%>
                                        </tbody>

                                    </table>

                                </div>
                            </div>
                        </div>
                        <div class="btn btn-primary btnKembali mt-4">
                            <i class="fa fa-arrow-left" aria-hidden="true"></i>
                            Kembali
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--modal--%>
        <div class="modal fade" id="Senarai" tabindex="-1" role="dialog"
            aria-labelledby="ModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title" id="ModalCenterTitle">Terimaan Bayaran</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" id="txtnoinv" name="txtnoinv" readonly />
                                        <label class="input-group__label" for="txtnoinv" id="lblModalBil">No. Bil</label>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" id="txtNamaPenghutang" name="txtNamaPenghutang" readonly />
                                        <label class="input-group__label" for="txtNamaPenghutang">Kepada</label>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" id="tkhMula" name="tkhMula" readonly />
                                        <label class="input-group__label" for="tkhMula">Tarikh Mula</label>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" id="tkhTamat" name="tkhTamat" readonly />
                                        <label class="input-group__label" for="tkhTamat">Tarikh Tamat</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-3">
                                        <label>Berkontrak</label>
                                        <div class="radio-btn-form" id="rdKontrak" name="rdKontrak" >
                                            <div class="form-check form-check-inline radio-size">
                                                <input type="radio" id="rdYa" name="inlineRadioOptions" value="1" />&nbsp;  Ya
                                            </div>
                                            <div class="form-check form-check-inline radio-size">
                                                <input type="radio" id="rdTidak" name="inlineRadioOptions" value="0" />&nbsp;  Tidak
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input type="text" class="form-control input-group__input" id="txtUrusniaga" name="txtUrusniaga" readonly />
                                        <label class="input-group__label" for="txtUrusniaga">Jenis Urusniaga</label>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <textarea class="input-group__input" name="txtTujuan" id="txtTujuan" readonly></textarea>
                                        <label class="input-group__label" for="txtTujuan">Tujuan</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <h6>Transaksi</h6>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table class="table table-striped" id="tblData" style="width: 100%;">
                                            <thead>
                                                <tr style="width: 100%; text-align: center;">
                                                    <th scope="col" style="width: 10%;vertical-align:middle">Vot</th>
                                                    <th scope="col" style="width: 10%;vertical-align:middle">Kod PTJ</th>
                                                    <th scope="col" style="width: 5%;vertical-align:middle">Kumpulan Wang</th>
                                                    <th scope="col" style="width: 5%;vertical-align:middle">Kod Operasi</th>
                                                    <th scope="col" style="width: 5%;vertical-align:middle">Kod Projek</th>
                                                    <th scope="col" style="width: 15%;vertical-align:middle">Perkara</th>
                                                    <th scope="col" style="width: 10%;vertical-align:middle">Kuantiti</th>
                                                    <th scope="col" style="width: 10%;vertical-align:middle">Harga Seunit (RM)</th>
                                                    <th scope="col" style="width: 10%;vertical-align:middle">Cukai (%)</th>
                                                    <th scope="col" style="width: 10%;vertical-align:middle">Diskaun (%)</th>
                                                    <th scope="col" style="width: 10%;vertical-align:middle">Jumlah (RM)</th>
                                                    <th scope="col" style="width: 10%;vertical-align:middle">Jumlah Dibayar (RM)</th>
                                                    <%--<th scope="col" style="width: 10%;vertical-align:middle">Jumlah (RM)</th>--%>
                                                    <%--<th scope="col" style="width: 3%">Tindakan</th>--%>
                                                </tr>
                                            </thead>
                                            <tbody id="tableID">
                                                <tr style="display: none; width: 100%">
                                                    <td>
                                                        <%-- kalau nak paparkan vot dropdown semula, kena buang div dibawah --%>
                                                        <div style="display:none">
                                                            <select class="ui search dropdown vot-carian-list" name="ddlVotCarian" id="ddlVotCarian">
                                                            </select>
                                                        </div>
                                                        <label id="lblvot" name="lblvot" class="label-vot-list"></label>
                                                        <label id="hidlblvot" name="hidlblvot" class="hid-vot-list" style="display:none"></label>
                                                        <input type="hidden" class="data-id" value="" />
                                                    </td>
                                                    <td>
                                                        <label id="lblPTj" name="lblPTj" class="label-ptj-list"></label>
                                                        <label id="HidlblPTj" name="HidlblPTj" class="Hid-ptj-list" style="visibility: hidden; display: none"></label>
                                                    </td>
                                                    <td>
                                                        <label id="lblKw" name="lblKw" class="label-kw-list"></label>
                                                        <label id="HidlblKw" name="HidlblKw" class="Hid-kw-list" style="visibility: hidden; display: none"></label>
                                                    </td>
                                                    <td>
                                                        <label id="lblKo" name="lblKo" class="label-ko-list"></label>
                                                        <label id="HidlblKo" name="HidlblKo" class="Hid-ko-list" style="visibility: hidden; display: none"></label>
                                                    </td>
                                                    <td>
                                                        <label id="lblKp" name="lblKp" class="label-kp-list"></label>
                                                        <label id="HidlblKp" name="HidlblKp" class="Hid-kp-list" style="visibility: hidden; display: none"></label>
                                                    </td>
                                                    <td>
                                                        <input class="form-control details" type="text" id="txtPerkara" name="txtPerkara" style="display:none" />
                                                        <label class="lblPerkaraDetails" id="lblPerkara" name="lblPerkara"></label>
                                                    </td>
                                                    <td >
                                                        <input type="number" class="form-control underline-input multi quantity" placeholder="0" id="quantity" name="quantity" style="text-align: center;display:none" />
                                                        <label class="lblKuantiti_" id="lblKuantiti" name="lblKuantiti" style="display:block;text-align:center"></label>
                                                    </td>
                                                    <td >
                                                        <input type="number" class="form-control underline-input multi price" placeholder="0.00" id="price" name="price" style="text-align: right;display:none" />
                                                        <label class="lblHarga_" id="lblHarga" name="lblHarga" style="display:block;text-align:right"></label>
                                                    </td>
                                                    
                                                    <td >
                                                        <input type="number" class="form-control underline-input multi cukai" placeholder="0.00" id="cukai" name="cukai" style="text-align: center;display:none" />
                                                        <label class="lblCukai_" id="lblCukai" name="lblCukai" style="display:block;text-align:center"></label>
                                                        <input type="number" class="form-control underline-input multi JUMcukai" placeholder="0.00" id="JUMcukai" name="JUMcukai" style="text-align: center;display: none" />
                                                    </td>
                                                    <td >
                                                        <input type="number" class="form-control underline-input multi diskaun" placeholder="0.00" id="diskaun" name="diskaun" style="text-align: center;display:none" />
                                                        <label class="lblDiskaun_" id="lblDiskaun" name="lblDiskaun" style="display:block;text-align:center"></label>
                                                        <input type="number" class="form-control underline-input multi JUMdiskaun" placeholder="0.00" id="JUMdiskaun" name="JUMdiskaun" style="text-align: center;display: none" />
                                                    </td>
                                                    <td >
                                                        <input class="form-control underline-input amount" id="amount" name="amount" style="text-align: right;display:none" placeholder="0.00" />
                                                        <label class="lblAmount_" id="lblAmount" name="lblAmount" style="display:block;text-align:right"></label>
                                                        <input class="form-control underline-input amountwocukai" id="amountwocukai" name="amountwocukai" style="text-align: right; display: none" placeholder="0.00" />
                                                    </td>
                                                    <td >
                                                        <input class="form-control underline-input amountBayar" id="amountBayar" name="amountBayar" style="text-align: right;display:none" placeholder="0.00" />
                                                        <label class="lblAmountBayar_" id="lblAmountBayar" name="lblAmountBayar" style="display:block;text-align:right"></label>
                                                    </td>
                                                    <%--<td>
                                                        <input class="form-control underline-input jumlahKredit" id="jumlahKredit" name="jumlahKredit" style="display:block;text-align:right" placeholder="0.00" />
                                                    </td>--%>
                                                    <%--<td class="tindakan">
                                                    <button class="btn btnDelete">
                                                        <i class="fa fa-trash" style="color: red"></i>
                                                    </button>
                                                    <button class="btn"><i class="fa fa-trash"></i> Trash</button>
                                                </td>--%>
                                                </tr>

                                            </tbody>
                                            <%--<tfoot >
                                            <tr>
                                                
                                                <td colspan="8" style="text-align: right; font-size: medium;border-right:hidden"><i>Jumlah Cukai (RM)</i></td>
                                                <td colspan="1" style="text-align:center;border-right:hidden">
                                                    <input class="form-control underline-input" id="TotalTax" name="TotalTax" style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00" readonly/>
                                                </td>
                                                <td colspan="1"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="10" style="text-align: right; font-size: medium;border-right:hidden"><i>Jumlah Diskaun (RM)</i></td>
                                                <td colspan="1" style="text-align:center;border-right:hidden">
                                                    <input class="form-control underline-input" id="TotalDiskaun" name="TotalDiskaun" style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00" readonly/>
                                                </td>
                                                <td colspan="1"></td>
                                            </tr>
                                            <tr>
                                                <th colspan="10" style="text-align: right; font-size: large;border-right:hidden" class="">JUMLAH (RM)</th>
                                                <td colspan="1" style="text-align:center;border-right:hidden">
                                                    <input class="form-control underline-input" id="total" name="total" style="text-align: right; font-size: large; font-weight: bold" placeholder="0.00" readonly/>
                                                </td>
                                                <td colspan="1"></td>
                                            </tr>
                                        </tfoot>--%>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modal-footer--sticky">
                        <div class="form-group col-md-12" align="right">
                            <%--<button type="button" class="btn btn-danger btnTidakLulus">Tidak Lulus</button>--%>
                            <span><b>Jumlah (<span id="stickyJumlahItem" style="margin-right:5px">0</span> item) :RM <span id="stickyJumlah"
                                        style="margin-right:5px">0.00</span></b></span>
                            <button type="button" class="btn" id="showModalButton"><i class="fas fa-angle-up"></i></button>
                            <button type="button" class="btn btn-secondary btnCetakResit" data-toggle="tooltip" data-placement="bottom" title="Cetak Resit"><i class="fa fa-print" aria-hidden="true"></i>Cetak Resit</button>
                            <button type="button" class="btn btn-secondary btnCetak" data-toggle="tooltip" data-placement="bottom" title="Cetak Bil"><i class="fa fa-print" aria-hidden="true"></i>Cetak Bil</button>
                            <button type="button" class="btn btn-success btnBayar" data-toggle="tooltip" data-placement="bottom" title="Buat Bayaran">Bayar</button>
                        </div>
                    </div>
                </div>
                </div>
            </div>
        </div>
        <!-- Detail Payment Modal-->
        <div class="modal fade" id="DetailPayment" tabindex="-1" role="dialog"
            aria-labelledby="DetailPaymentLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-m" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DetailPaymentLabel">Terimaan Bayaran</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row rowbody">
                            <div class="form-group col-sm-4 lblinput">
                                <label>Jumlah (RM)</label>
                            </div>
                            <div class="form-group col-sm-6">
                                <input class="form-control underline-input txtJumlahSbnr" id="txtJumlahSbnr" name="txtJumlahSbnr" style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00" readonly />
                            </div>
                        </div>

                        <div class="row rowbody">
                            <div class="form-group col-sm-4 lblinput">
                                <label class="lblinput">Mod Terimaan</label>
                            </div>
                            <div class="form-group col-sm-6">
                                <select class="ui search dropdown" name="ddlModTerimaan" id="ddlModTerimaan"></select>
                            </div>
                        </div>

                        <div class="row rowbody">
                            <div class="form-group col-sm-4 lblinput">
                                <label class="lblinput">Bank UTeM</label>
                            </div>
                            <div class="form-group col-sm-6">
                                <select class="ui search dropdown" name="ddlBankUTeM" id="ddlBankUTeM"></select>
                            </div>
                        </div>

                        <div class="row rowbody">
                            <div class="form-group col-sm-4 lblinput">
                                <label class="lblinput">Amaun Terima (RM)</label>
                            </div>
                            <div class="form-group col-sm-6">
                                <input id="txtAmaunTerima" name="txtAmaunTerima" type="text" class="form-control textinput txtAmaunTerima" enable="true" style="text-align: right" placeholder="0.00">
                            </div>
                        </div>

                        <div class="row rowbody">
                            <div class="form-group col-sm-4 lblinput1">
                                <label class="lblinput">Baki (RM)</label>
                            </div>
                            <div class="form-group col-sm-6">
                                <input id="txtAmaunBaki" name="txtAmaunBaki" type="text" class="form-control textinput txtAmaunBaki" enable="true" readonly style="text-align: right" placeholder="0.00">
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger"
                            data-dismiss="modal">Tutup</button>
                        <button type="button" class="btn default-primary btnSimpanPayment">Simpan</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Confirmation Modal-->
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
                            data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn default-primary btnYaLulus">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Confirmation Modal Tidak Lulus-->
        <div class="modal fade" id="confirmationModalxLulus" tabindex="-1" role="dialog"
            aria-labelledby="confirmationModalLabelxLulus" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmationModalLabelxLulus">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Anda pasti untuk tidak meluluskan rekod ini?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger"
                            data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn default-primary btnYaxLulus">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Makluman Modal-->
        <div class="modal fade" id="maklumanModal" tabindex="-1" role="dialog"
            aria-labelledby="maklumanModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="maklumanModalLabel">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <span id="detailMakluman"></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn default-primary" id="tutupMakluman"
                            data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Jumlah Detail Sticky Modal -->
        <div class="modal fade" id="detailTotal" tabindex="-1" aria-labelledby="showDetails" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Jumlah Terperinci</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="" style="width: 100%; border: none">
                            <tr>
                                <td class="pr-2" style="text-align: right; font-size: medium;">Jumlah<br />
                                </td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input" id="totalwoCukai" name="totalwoCukai"
                                        style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00"
                                        readonly />
                                </td>
                            </tr>
        
                            <tr style="border-top: none">
                                <td class="pr-2" style="text-align: right; font-size: medium;">Jumlah
                                    Cukai</td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input" id="TotalTax" name="TotalTax"
                                        style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00"
                                        readonly />
                                </td>
                            </tr>
        
                            <tr style="border-top: none">
                                <td class="pr-2" style="text-align: right; font-size: medium;">Jumlah
                                    Diskaun</td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input" id="TotalDiskaun" name="TotalDiskaun"
                                        style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00"
                                        readonly />
                                </td>
                            </tr>
        
                            <tr style="border-top: none">
                                <td class="pr-2" style="text-align: right; font-size: medium">Jumlah Dibayar (RM)
                                </td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input" id="totalDibayar" name="totalDibayar"
                                        style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00"
                                        readonly />
                                </td>
                            </tr>

                            <tr style="border-top: none">
                                <td class="pr-2" style="text-align: right; font-size: large">JUMLAH (RM)
                                </td>
                                <td style="text-align: right">
                                    <input class="form-control underline-input" id="total" name="total"
                                        style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00"
                                        readonly />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </contenttemplate>
    <script>
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
    </script>
    <script type="text/javascript">
        function ShowPopup(elm) {

            //alert("test");
            if (elm == "1") {

                $('#Senarai').modal('toggle');


            }
            else if (elm == "2") {

                $(".modal-body div").val("");
                $('#Senarai').modal('toggle');

            }
        }
        var tbl = null
        var isClicked = false;
        $(document).ready(function () {

            const searchParams = new URLSearchParams(window.location.search);
            var status = searchParams.get('status')
            if (status == "03") {
                $('#lblColumnBil').html('No. Bil')
                $('#lblModalBil').html('No. Bil')
            } else {
                $('#lblColumnBil').html('No. Resit')
                $('#lblModalBil').html('No. Resit')
            }

            tbl = $("#tblDataSenarai").DataTable({
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
                    "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                }, columnDefs: [
                    { targets: [5], className: 'text-right' },
                ],
                "ajax": {
                    "url": "TerimaWS.asmx/Load_MaklumatBilTerperinci",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter date bermula dari sini - 20 julai 2023
                        var kodpenghutang = searchParams.get('kodpenghutang')
                        //var status = searchParams.get('status')
                        var startDate = $('#txtTarikhStart').val()
                        var endDate = $('#txtTarikhEnd').val()
                        return JSON.stringify({
                            category_filter: $('#categoryFilter').val(),
                            isClicked: isClicked,
                            tkhMula: startDate,
                            tkhTamat: endDate,
                            custcode: kodpenghutang,
                            status: status
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
                        rowClickHandler(data.No_Invois);
                    });
                },
                "drawCallback": function (settings) {
                    // Your function to be called after loading data
                    close_loader();
                },
                "columns": [
                    { "data": "No_Invois" },
                    { "data": "Nama_Penghutang" },
                    { "data": "TKHMOHON" },
                    { "data": "UrusNiaga" },
                    { "data": "Tujuan" },
                    {
                        "data": "Jumlah",
                        render: function (data, type, row, meta) {
                            if (type !== "display") {

                                return data;

                            }
                            var Jumlah = data.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                            return Jumlah;
                        }
                    }
                ],
            });

            $('.btnKembali').click(async function () {
                var url = localStorage.getItem('redirectTerimaanUrl');
                location.replace(url, '_blank');
            })

            $('.btnSearch').click(async function () {
                show_loader();
                isClicked = true;
                tbl.ajax.reload();
            })

            $('.btnCetak').click(async function () {
                var params = `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;
                var txtbil = $('#txtnoinv').val();
                window.open('<%=ResolveClientUrl("~/FORMS/AKAUN PENERIMA/Invois/CetakBil.aspx")%>?bilid=' + txtbil, '_blank', params);

            });

            $('.btnCetakResit').click(async function () {
                var params = `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;
                var txtbil = $('#txtnoinv').val();
                window.open('<%=ResolveClientUrl("~/FORMS/AKAUN PENERIMA/Terimaan/CetakResit.aspx")%>?noResit=' + txtbil, '_blank', params);

            });

            $('.btnBayar').click(async function () {
                //alert("hai");
                $('#DetailPayment').modal('toggle');
            })

            $('#ddlModTerimaan').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'TerimaWS.asmx/GetModTerimaList',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({
                            kod: settings.urlData.query
                        });
                        //searchQuery = settings.urlData.query;
                        return settings;
                    },
                    onchange: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({
                            kod: settings.urlData.query
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

            $('#ddlBankUTeM').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'TerimaWS.asmx/GetKodBankList',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({
                            kod: settings.urlData.query
                        });
                        //searchQuery = settings.urlData.query;
                        return settings;
                    },
                    onchange: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({
                            kod: settings.urlData.query
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

            //$('#txtAmaunTerima').on('keyup', async function () {
            //    alert("hai");
            //    var JumlahSebenar = $('#txtJumlahSbnr');
            //    var amount = $('#txtAmaunTerima');

            //    //var totalPrice = NumDefault(quantity.val()) * NumDefault(price.val())
            //    //var amauncukai = NumDefault(cukai.val()) / 100
            //    //var total_cukai = totalPrice * amauncukai
            //    //var amaundiskaun = NumDefault(diskaun.val()) / 100
            //    //var total_diskaun = totalPrice * amaundiskaun
            //    //var amountxcukai = totalPrice - total_diskaun
            //    ////alert(amaundiskaun)
            //    //totalPrice = totalPrice + total_cukai - total_diskaun
            //    //amount.val(totalPrice.toFixed(2));
            //    //JUMcukai.val(total_cukai.toFixed(2));
            //    //JUMdiskaun.val(total_diskaun.toFixed(2));
            //    //amountwocukai.val(amountxcukai.toFixed(2));
            //    //calculateGrandTotal();
            //});
        });

        var searchQuery = "";
        var oldSearchQuery = "";
        var curNumObject = 0;
        var tableID = "#tblData";
        var shouldPop = true;
        var totalID = "#total";
        var totalSebenar = "#txtJumlahSbnr";
        var totalCukai = "#TotalTax";
        var totalDiskaun = "#TotalDiskaun";
        var totalwoCukai = "#totalwoCukai";
        var tableID_Senarai = "#tblDataSenarai";

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
            $('.txtAmaunTerima').change(function () {
                $(this).val(parseFloat($(this).val()).toFixed(2));
            });

            $(".txtAmaunTerima").keyup(function () {
                var JumlahSebenar = parseFloat($('#txtJumlahSbnr').val().replace(/,/g, '')); // Remove commas if present
                var amount = parseFloat($('#txtAmaunTerima').val().replace(/,/g, '')); // Remove commas if present

                // Calculate the balance as a float with two decimal places
                var baki = (JumlahSebenar - amount).toFixed(2);

                $('#txtAmaunBaki').val(baki);

                console.log(baki);
            });



            $('#ddlJenTransaksi').dropdown({
                fullTextSearch: false,
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

        async function clearAllRows_senarai() {
            $(tableID_Senarai + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
        }

        $("#categoryFilter").change(function (e) {
            var selectedItem = $('#categoryFilter').val()
            if (selectedItem == "6" && selectedItem !== "") {
                $('#divDatePicker').addClass("d-flex").removeClass("d-none");
                $('#txtTarikhStart').val("")
                $('#txtTarikhEnd').val("")
            }
            else {
                $('#divDatePicker').removeClass("d-flex").addClass("d-none");
                $('#txtTarikhStart').val("")
                $('#txtTarikhEnd').val("")
            }
        });

        async function paparSenarai(totalClone, objOrder) {
            var counter = 1;
            var table = $('#tblDataSenarai');
            //alert("hai")
            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.length;

            }
            console.log(objOrder)

            while (counter <= totalClone) {

                var row = $('#tblDataSenarai tbody>tr:first').clone();
                row.attr("style", "");
                var val = "";

                $('#tblDataSenarai tbody').append(row);

                if (objOrder !== null && objOrder !== undefined) {

                    if (counter <= objOrder.length) {
                        await setValueToRow(row, objOrder[counter - 1]);
                    }
                }

                counter += 1;
            }
        }

        async function setValueToRow(row, orderDetail) {
            var no = $(row).find("td > .lblNo");
            var Penghutang = $(row).find("td > .lblPenghutang");
            var TkhMohon = $(row).find("td > .lblTkhMohon");
            var TkhMula = $(row).find("td > .lblTkhMula");
            var TkhTamat = $(row).find("td > .lblTkhTamat");
            var JnsUrusNiaga = $(row).find("td > .lblJnsUrus");
            var Tujuan = $(row).find("td > .lblTujuan");
            var Jumlah = $(row).find("td > .lblJumlah");
            var jumlah_ = orderDetail.Jumlah;
            //console.log(jumlah_)
            if (jumlah_ !== null) {
                Jumlah.html(orderDetail.Jumlah.toFixed(2));
            } else {
                Jumlah.html(orderDetail.Jumlah);
            }
            no.html(orderDetail.No_Invois);
            Penghutang.html(orderDetail.Nama_Penghutang);
            TkhMula.html(orderDetail.Tkh_Mula);
            TkhTamat.html(orderDetail.Tkh_Tamat);
            JnsUrusNiaga.html(orderDetail.UrusNiaga);
            Tujuan.html(orderDetail.Tujuan);
            TkhMohon.html(orderDetail.TKHMOHON);

        }

        // add clickable event in DataTable row
        async function rowClickHandler(id) {
            event.preventDefault();
            const searchParams = new URLSearchParams(window.location.search);
            //var kodpenghutang = searchParams.get('kodpenghutang')
            var status = searchParams.get('status')
            if (status !== "") {
                if (status == "04") {
                    $('.btnCetak').hide();
                    $('.btnCetakResit').show();
                    $('.btnBayar').hide();
                } else {
                    $('.btnCetakResit').hide();
                    $('.btnCetak').show();
                    $('.btnBayar').show();
                }
            }
            if (id !== "") {
                // open modal
                $('#Senarai').modal('toggle');

                if (status == "03") {
                    //BACA HEADER JURNAL
                    var recordHdr = await AjaxGetRecordHdrJurnal(id);
                    await AddRowHeader(null, recordHdr);

                    //BACA DETAIL JURNAL
                    var record = await AjaxGetRecordJurnal(id);
                    await clearAllRows();
                    await AddRow(null, record);

                } else {
                    //BACA HEADER JURNAL
                    var recordHdr = await AjaxGetRecordHdrJurnalTerimaan(id);
                    await AddRowHeader(null, recordHdr);

                    //BACA DETAIL JURNAL
                    var record = await AjaxGetRecordJurnalTerimaan(id);
                    await clearAllRows();
                    await AddRow(null, record);
                }
            }
        }

        $(tableID_Senarai).on('click', '.btnView', async function () {

            event.preventDefault();
            var curTR = $(this).closest("tr");
            var recordID = curTR.find("td > .lblNo");

            //var bool = true;
            var id = recordID.html();
            //alert("hai");
            //console.log(id)
            if (id !== "") {
                if (status == "03") {
                    //BACA HEADER JURNAL
                    var recordHdr = await AjaxGetRecordHdrJurnal(id);
                    await AddRowHeader(null, recordHdr);

                    //BACA DETAIL JURNAL
                    var record = await AjaxGetRecordJurnal(id);
                    await clearAllRows();
                    await AddRow(null, record);

                } else {
                    //BACA HEADER JURNAL
                    var recordHdr = await AjaxGetRecordHdrJurnalTerimaan(id);
                    await AddRowHeader(null, recordHdr);

                    //BACA DETAIL JURNAL
                    var record = await AjaxGetRecordJurnalTerimaan(id);
                    await clearAllRows();
                    await AddRow(null, record);
                }
            }

            return false;
        })

        async function AjaxGetRecordHdrJurnal(id) {

            try {

                const response = await fetch('../Invois/SenaraiKelulusanWS.asmx/LoadHdrInvois', {
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

        async function AjaxGetRecordHdrJurnalTerimaan(id) {

            try {

                const response = await fetch('TerimaWS.asmx/LoadHdrInvois', {
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

        async function AddRowHeader(totalClone, objOrder) {
            var counter = 1;
            //var table = $('#tblDataSenarai');

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;
            }


            if (counter <= objOrder.Payload.length) {
                await setValueToRow_HdrJurnal(objOrder.Payload[counter - 1]);
            }
            // console.log(objOrder)
        }

        async function AjaxGetRecordJurnal(id) {

            try {

                const response = await fetch('../Invois/SenaraiKelulusanWS.asmx/LoadRecordInvoisTerimaanBayaran', {
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

        async function AjaxGetRecordJurnalTerimaan(id) {

            try {

                const response = await fetch('TerimaWS.asmx/LoadRecordInvoisTerimaanBayaran', {
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

        async function AddRow(totalClone, objOrder) {
            var counter = 1;
            var table = $('#tblData');

            if (objOrder !== null && objOrder !== undefined) {
                //totalClone = objOrder.Payload.OrderDetails.length;
                totalClone = objOrder.Payload.length;
                console.log(totalClone)
                //if (totalClone < 5) {
                //    totalClone = 5;
                //}
            }

            var totalItems = 0;

            while (counter <= totalClone) {
                curNumObject += 1;
                var newCarianVot = "ddlVotCarian" + curNumObject;

                var row = $('#tblData tbody>tr:first').clone();
                var votcarianlist = $(row).find(".vot-carian-list").attr("id", newCarianVot);
                console.log(row)
                row.attr("style", "");
                var val = "";

                $('#tblData tbody').append(row);


                await initCarianVot(newCarianVot)

                //$(newId).api("query");
                //(newVotID).api("query");
                //$(newKwID).api("query");
                //(newKOID).api("query");
                //$(newKPID).api("query");
                $(newCarianVot).api("query");

                if (objOrder !== null && objOrder !== undefined) {
                    //await setValueToRow(row, objOrder.Payload.OrderDetails[counter - 1]);
                    if (counter <= objOrder.Payload.length) {
                        await setValueToRow_Transaksi(row, objOrder.Payload[counter - 1]);

                        totalItems += 1;
                    }
                }
                counter += 1;
            }

            $('#stickyJumlahItem').text(totalItems);
        }

        async function setValueToRow_Transaksi(row, orderDetail) {

            //console.log(orderDetail)
            var ddl = $(row).find("td > .vot-carian-list");
            var ddlSearch = $(row).find("td > .vot-carian-list > .search");
            var ddlText = $(row).find("td > .vot-carian-list > .text");
            var selectObj = $(row).find("td > .vot-carian-list > select");
            $(ddl).dropdown('set selected', orderDetail.Kod_Vot);
            selectObj.append("<option value = '" + orderDetail.Kod_Vot + "'>" + orderDetail.ButiranVot + "</option>")

            var butirvot = $(row).find("td > .label-vot-list");
            butirvot.html(orderDetail.ButiranVot);

            var hidlblvot = $(row).find("td > .hid-vot-list");
            hidlblvot.html(orderDetail.Kod_Vot);

            var butirptj = $(row).find("td > .label-ptj-list");
            butirptj.html(orderDetail.ButiranPTJ);

            var hidbutirptj = $(row).find("td > .Hid-ptj-list");
            hidbutirptj.html(orderDetail.colhidptj);

            var butirKW = $(row).find("td > .label-kw-list");
            butirKW.html(orderDetail.colKW);

            var hidbutirkw = $(row).find("td > .Hid-kw-list");
            hidbutirkw.html(orderDetail.colhidkw);

            var butirKo = $(row).find("td > .label-ko-list");
            butirKo.html(orderDetail.colKO);

            var hidbutirko = $(row).find("td > .Hid-ko-list");
            hidbutirko.html(orderDetail.colhidko);

            var butirKp = $(row).find("td > .label-kp-list");
            butirKp.html(orderDetail.colKp);

            var hidbutirkp = $(row).find("td > .Hid-kp-list");
            hidbutirkp.html(orderDetail.colhidkp);

            var lblPerkara = $(row).find("td > .lblPerkaraDetails");
            lblPerkara.html(orderDetail.Perkara);

            var details = $(row).find("td > .details");
            details.val(orderDetail.Perkara);

            var lblKuantiti = $(row).find("td > .lblKuantiti_");
            lblKuantiti.html(orderDetail.Kuantiti);

            var quantity = $(row).find("td > .quantity");
            quantity.val(orderDetail.Kuantiti);

            var lblCukai = $(row).find("td > .lblCukai_");
            lblCukai.html(orderDetail.Cukai.toFixed(2));

            var cukai = $(row).find("td > .cukai");
            cukai.val(orderDetail.Cukai.toFixed(2));

            var lblHarga = $(row).find("td > .lblHarga_");
            lblHarga.html(orderDetail.Kadar_Harga.toFixed(2));

            var kdr_hrga = $(row).find("td > .price");
            kdr_hrga.val(orderDetail.Kadar_Harga.toFixed(2));

            var lblDiskaun = $(row).find("td > .lblDiskaun_");
            lblDiskaun.html(orderDetail.Diskaun.toFixed(2));

            var diskaun = $(row).find("td > .diskaun");
            diskaun.val(orderDetail.Diskaun.toFixed(2));

            var lblAmount = $(row).find("td > .lblAmount_");
            lblAmount.html(orderDetail.Jumlah.toFixed(2));

            var lblAmountBayar = $(row).find("td > .lblAmountBayar_");
            lblAmountBayar.html(orderDetail.Jumlah_Bayar.toFixed(2));

            var amountBayar = $(row).find("td > .amountBayar");
            amountBayar.val(orderDetail.Jumlah_Bayar.toFixed(2));

            var amount = $(row).find("td > .amount");
            amount.val(orderDetail.Jumlah.toFixed(2));

            var hddataid = $(row).find("td > .data-id");
            hddataid.val(orderDetail.dataid)

            //var quantity = $(curTR).find("td > .quantity");
            //var price = $(curTR).find("td > .price");
            //var amount = $(curTR).find("td > .amount");
            //var cukai = $(curTR).find("td > .cukai");
            var JUMcukai = $(row).find("td > .JUMcukai");
            //var diskaun = $(curTR).find("td > .diskaun");
            var JUMdiskaun = $(row).find("td > .JUMdiskaun");
            var amountwocukai = $(row).find("td > .amountwocukai");

            var totalPrice = NumDefault(quantity.val()) * NumDefault(kdr_hrga.val())
            var amauncukai = NumDefault(cukai.val()) / 100
            var total_cukai = totalPrice * amauncukai
            var amaundiskaun = NumDefault(diskaun.val()) / 100
            var total_diskaun = totalPrice * amaundiskaun
            var amountxcukai = totalPrice - total_diskaun
            //alert(amaundiskaun)

            totalPrice = totalPrice + total_cukai - total_diskaun
            amount.val(totalPrice.toFixed(2));
            JUMcukai.val(total_cukai.toFixed(2));
            JUMdiskaun.val(total_diskaun.toFixed(2));
            amountwocukai.val(amountxcukai.toFixed(2));
            calculateGrandTotal();

        }

        async function setValueToRow_HdrJurnal(orderDetail) {

            $('#txtnoinv').val(orderDetail.No_Bil)
            //$('#txtNoRujukan').val(orderDetail.No_Rujukan)
            $('#txtNamaPenghutang').val(orderDetail.Nama_Penghutang)

            $('#tkhMula').val(orderDetail.Tkh_Mula)
            $('#tkhTamat').val(orderDetail.Tkh_Tamat)
            //$('#rdKontrak').val(orderDetail.Kontrak)
            $('#txtUrusniaga').val(orderDetail.Butiran)
            $('#txtTujuan').val(orderDetail.Tujuan)

            var newId = $('#ddlJenTransaksi')

            //await initDropdownPtj(newId)
            //$(newId).api("query");

            var ddlPenghutang = $('#ddlPenghutang')
            var ddlSearchP = $('#ddlPenghutang')
            var ddlTextP = $('#ddlPenghutang')
            var selectObj_JenisTransaksiP = $('#ddlPenghutang')
            $(ddlPenghutang).dropdown('set selected', orderDetail.Kod_Penghutang);
            selectObj_JenisTransaksiP.append("<option value = '" + orderDetail.Kod_Penghutang + "'>" + orderDetail.Nama_Penghutang + "</option>")

            var ddlUrusniaga = $('#ddlUrusniaga')
            var ddlSearch = $('#ddlUrusniaga')
            var ddlText = $('#ddlUrusniaga')
            var selectObj_JenisTransaksi = $('#ddlUrusniaga')
            $(ddlUrusniaga).dropdown('set selected', orderDetail.Jenis_Urusniaga);
            selectObj_JenisTransaksi.append("<option value = '" + orderDetail.Jenis_Urusniaga + "'>" + orderDetail.Butiran + "</option>")

            if (orderDetail.Kontrak == '0') {
                //$('[id=rdTIDAK]')[0].checked = true
                $(':radio[name=inlineRadioOptions][value="0"]').prop('checked', true);
                $(':radio[name=inlineRadioOptions][value="1"]').prop('checked', false);
                //$('#rdTIDAK').val(':checked');
                //$('#rdTIDAK').is('checked:checked');
            } else {
                //$('#rdYA').is('checked:checked');
                $(':radio[name=inlineRadioOptions][value="1"]').prop('checked', true);
                $(':radio[name=inlineRadioOptions][value="0"]').prop('checked', false);
            }
        }

        async function clearAllRows() {
            $(tableID + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
            $(totalID).val("0.00");

        }

        async function initCarianVot(id) {
            $('#' + id).dropdown({
                fullTextSearch: true,
                apiSettings: {
                    url: '../Invois/SenaraiKelulusanWS.asmx/GetCarianVotList?q={query}',
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

        async function calculateGrandTotal() {
            var grandTotal = $(totalID);
            var totalCukai_ = $(totalCukai);
            var totalDiskaun_ = $(totalDiskaun);
            var totalwoCukai_ = $(totalwoCukai);
            var total_sebenar = $(totalSebenar);
            var curTotal = 0;
            var curCukai = 0;
            var curDiskaun = 0;
            var curwoCukai = 0;
            var curSebenar = 0;

            var curTotalDibayar = 0;

            $('.amount').each(function (index, obj) {
                curTotal += parseFloat(NumDefault($(obj).val()));
            });

            $('.amountBayar').each(function (index, obj) {
                curTotalDibayar += parseFloat(NumDefault($(obj).val()));
            });

            $('.JUMcukai').each(function (index, obj) {
                curCukai += parseFloat(NumDefault($(obj).val()));
            });

            $('.JUMdiskaun').each(function (index, obj) {
                curDiskaun += parseFloat(NumDefault($(obj).val()));
            });

            $('.amountwocukai').each(function (index, obj) {
                curwoCukai += parseFloat(NumDefault($(obj).val()));
            });

            //$("[id*=TotalCoreProd]").html(TotalCoreProd.toFixed(2));
            totalCukai_.val(curCukai.toFixed(2));
            totalDiskaun_.val(curDiskaun.toFixed(2));
            totalwoCukai_.val(curwoCukai.toFixed(2));

            $('#totalDibayar').val(curTotalDibayar.toFixed(2));

            var totalAfterDibayar = curTotal - curTotalDibayar;

            grandTotal.val(totalAfterDibayar.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }));
            total_sebenar.val(totalAfterDibayar.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }));

            //STICKYJUMLAH
            document.getElementById('stickyJumlah').textContent = totalAfterDibayar.toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
        }

        //btnBayar



        //$('.btnSimpanPayment').click(async function () {
        //    // check every required field
        //    //if ($('#ddlKategoriPenghutang').val() == "" || $('#ddlUrusniaga').val() == "" || $('#ddlPenghutang').val() == "" || $("input[name='inlineRadioOptions']:checked").val() == "" || $('#txtTujuan').val() == "") {
        //        // open modal makluman and show message
        //        //$('#maklumanModalBil').modal('toggle');
        //        //$('#detailMaklumanBil').html("Sila isi semua ruangan yang bertanda *");
        //    //} else {
        //        // open modal confirmation
        //        $('#confirmationModal').modal('toggle');
        //    //}
        //})

        $('.btnSimpanPayment').click(async function () {
            if ($('#txtAmaunTerima').val() > $('#ddlUrusniaga').val()) { 
                 //open modal makluman and show message
                $('#maklumanModal').modal('toggle');
                $('#maklumanModal').html("Amaun yang diterima hendaklah sama atau kurang daripada jumlah yang perlu dibayar");
            } 
            //close modal confirmation
            $('#DetailPayment').modal('toggle');
            $('#Senarai').modal('toggle');

            var jumRecord = 0;
            var acceptedRecord = 0;
            var msg = "";
            var newOrder = {
                order: {
                    OrderID: '',
                    NoBil: $('#txtnoinv').val(),
                    PenghutangID: $('#ddlPenghutang').val(),
                    JumlahTerima: $('#txtAmaunTerima').val(),
                    ModTerima: $('#ddlModTerimaan').val(),
                    KodBank: $('#ddlBankUTeM').val(),
                    //TkhMohon: $('#lblTkhMohon').val(),
                    //TkhMula: $('#tkhMula').val(),
                    //TkhTamat: $('#tkhTamat').val(),
                    //Kontrak: $("input[name='inlineRadioOptions']:checked").val(),
                    //JenisUrusniaga: $('#ddlUrusniaga').val(),
                    //Tujuan: $('#txtTujuan').val(),
                    //Jumlah: $('#total').val(),
                    OrderDetails: []
                }
            }
            $('.vot-carian-list').each(function (index, obj) {
                if (index > 0) {
                    var tcell = $(obj).closest("td");
                    var orderDetail = {
                        OrderID: $('#txtnoinv').val(),
                        PenghutangID: $('#ddlPenghutang').val(),
                        ddlVot: $('.hid-vot-list').eq(index).html(),
                        ddlPTJ: $('.Hid-ptj-list').eq(index).html(),
                        ddlKw: $('.Hid-kw-list').eq(index).html(),
                        ddlKo: $('.Hid-ko-list').eq(index).html(),
                        ddlKp: $('.Hid-kp-list').eq(index).html(),
                        details: $('.details').eq(index).val(),
                        quantity: $('.quantity').eq(index).val(),
                        price: $('.price').eq(index).val(),
                        Diskaun: $('.diskaun').eq(index).val(),
                        Cukai: $('.cukai').eq(index).val(),
                        amount: $('.amount').eq(index).val(),
                        id: $(tcell).find(".data-id").val()
                    };

                    if (orderDetail.ddlVot === "" || orderDetail.details === "" ||
                        orderDetail.quantity === "" || orderDetail.price === "") {
                        return;
                    }

                    acceptedRecord += 1;
                    newOrder.order.OrderDetails.push(orderDetail);
                }
            });

            msg = "Anda pasti ingin menyimpan " + acceptedRecord + " rekod ini?"

            //if (!confirm(msg)) {
            //    return false;
            //}

            //console.log(newOrder)
            var result = JSON.parse(await ajaxSaveOrder(newOrder));
            //console.log(result)
            //alert(result.Code)
            //alert(result.Payload.OrderID)
            $('#maklumanModal').modal('toggle');
            $('#detailMakluman').html(result.Message);
            await clearAllRows();
            // refresh page after 2 seconds
            setTimeout(function () {
                window.location.reload();
            }, 2000);
            //alert("hi1")
            if (result.Code == "00") {
                //alert("hi")
                var params = `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;
                window.open('<%=ResolveClientUrl("~/FORMS/AKAUN PENERIMA/Terimaan/CetakResit.aspx")%>?noResit=' + result.Payload.OrderID, '_blank', params);
            }
            // refresh page after 2 seconds
            //setTimeout(function () {
            //    window.location.reload();
            //}, 2000);
            
            <%--if (result.Status !== "5") {
                //$('#modalPenghutang').modal('toggle');
                // open modal makluman and show message
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Transaksi berjaya.");
                //clearAllFields();
                await clearAllRows();
                // refresh page after 2 seconds
                setTimeout(function () {
                    window.location.reload();
                }, 2000);
                //cetak resit
                var params = `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;
                //var txtbil = $('#txtnoinv').val();
                window.open('<%=ResolveClientUrl("~/FORMS/AKAUN PENERIMA/Terimaan/CetakResit.aspx")%>?noResit=' + txtbil, '_blank', params);
            } else {
                // open modal makluman and show message
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Transaksi disimpan.");
            }--%>
            //alert("Rekod Berjaya Disimpan");
            //$('#orderid').val(result.Payload.OrderID)
            //loadExistingRecords();

            //AddRow(5);

        });
        $('.btnYaxLulus').click(async function () {

            //close modal confirmation
            $('#confirmationModalxLulus').modal('toggle');

            var jumRecord = 0;
            var acceptedRecord = 0;
            var msg = "";
            var newOrder = {
                order: {
                    OrderID: $('#txtnoinv').val(),
                    PenghutangID: $('#ddlPenghutang').val(),
                    TkhMula: $('#tkhMula').val(),
                    TkhTamat: $('#tkhTamat').val(),
                    Kontrak: $("input[name='inlineRadioOptions']:checked").val(),
                    JenisUrusniaga: $('#ddlUrusniaga').val(),
                    Tujuan: $('#txtTujuan').val(),
                    Jumlah: $('#total').val(),
                    OrderDetails: []
                }
            }
            $('.vot-carian-list').each(function (index, obj) {
                if (index > 0) {
                    var tcell = $(obj).closest("td");
                    var orderDetail = {
                        OrderID: $('#txtnoinv').val(),
                        PenghutangID: $('#ddlPenghutang').val(),
                        ddlVot: $(obj).dropdown("get value"),
                        ddlPTJ: $('.Hid-ptj-list').eq(index).html(),
                        ddlKw: $('.Hid-kw-list').eq(index).html(),
                        ddlKo: $('.Hid-ko-list').eq(index).html(),
                        ddlKp: $('.Hid-kp-list').eq(index).html(),
                        details: $('.details').eq(index).val(),
                        quantity: $('.quantity').eq(index).val(),
                        price: $('.price').eq(index).val(),
                        Diskaun: $('.diskaun').eq(index).val(),
                        Cukai: $('.cukai').eq(index).val(),
                        amount: $('.amount').eq(index).val(),
                        id: $(tcell).find(".data-id").val()
                    };


                    if (orderDetail.ddlVot === "" || orderDetail.details === "" ||
                        orderDetail.quantity === "" || orderDetail.price === "") {
                        return;
                    }

                    acceptedRecord += 1;
                    newOrder.order.OrderDetails.push(orderDetail);
                }
            });

            msg = "Anda pasti ingin menyimpan " + acceptedRecord + " rekod ini?"

            //if (!confirm(msg)) {
            //    return false;
            //}

            //console.log(newOrder)
            var result = JSON.parse(await ajaxRejectOrder(newOrder));
            //alert(result.Message);
            if (result.Status !== "Failed") {
                //$('#modalPenghutang').modal('toggle');
                // open modal makluman and show message
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
                await clearAllRows();
                // refresh page after 2 seconds
                setTimeout(function () {
                    window.location.reload();
                }, 2000);
            } else {
                // open modal makluman and show message
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
            }
            //$('#orderid').val(result.Payload.OrderID)
            //loadExistingRecords();
            //await clearAllRows();
            //AddRow(5);
            //window.location.reload();
        });


        async function ajaxSaveOrder(id) {

            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'TerimaWS.asmx/SaveOrders',
                    method: 'POST',
                    data: JSON.stringify(id),
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
            console.log("tst")
        }
        async function ajaxRejectOrder(id) {

            return new Promise((resolve, reject) => {
                $.ajax({

                    url: '../Invois/SenaraiKelulusanWS.asmx/RejectLulus',
                    method: 'POST',
                    data: JSON.stringify(id),
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
            //console.log("tst")
        }

    </script>
</asp:Content>
