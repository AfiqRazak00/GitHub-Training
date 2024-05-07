﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Dalam_Negara.aspx.vb" Inherits="SMKB_Web_Portal.Dalam_Negara" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
  

    <style>
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

        .nav-tabs .nav-link {
            padding: 0.25rem 0.5rem;
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

        .input-group__label_td {
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

        .input-group__input_td {
            width: 100%;
            height: 40px;
            border: 1px solid #dddddd;
            border-radius: 5px;
            padding: 0 10px;
        }

        .input-group__input_RM {
            width: 100%;
            text-align: right;
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

        .input-group__subTitle_lable {
            background-color: white;
            line-height: 10px;
            opacity: 1;
            font-size: 15px;
            top: -5px;
        }

        .btn-change1 {
            height: 50px;
            width: 150px;
            background: #FFC83D;
            margin: 20px;
            float: left;
            border: 0px;
            color: #000;
            box-shadow: 0 0 1px #ccc;
            -webkit-transition-duration: 0.5s;
            -webkit-box-shadow: 0px 0px 0 0 #31708f inset, 0px 0px 0 0 #31708f inset;
        }

            .btn-change1:hover {
                -webkit-box-shadow: 50px 0px 0 0 #31708f inset, -50px 0px 0 0 #31708f inset;
            }

        .btn-change {
            height: 40px;
            width: 170px;
            background: #007bff;
            margin: 20px;
            float: left;
            box-shadow: 0 0 1px #ccc;
            -webkit-transition: all 0.5s ease-in-out;
            border: 0px;
            border-radius: 8px;
            color: #FFF;
        }

            .btn-change:hover {
                -webkit-transform: scale(1.1);
                background: #007bff;
                color: white;
            }

        .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
            color: #000;
            font-weight: normal;
            background-color: #FFC83D;
        }

        .tab-pane {
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            border-radius: 0px 0px 5px 5px;
            padding: 10px;
        }

        .nav-tabs .nav-link {
            padding: 0.25rem 0.5rem;
        }

        #Num {
            width: 50px;
        }

        .custom-select {
            background-color: #FFC83D;
        }

        .form-control-checkbox-tbl {
            display: block;
            width: 100%;
            /* height: calc(1.5em + .75rem + 2px); */
            padding: .375rem .75rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #495057;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: .25rem;
            transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
        }

        .form-control-input-tbl {
            display: block;
            /* width: 100%; */
            height: calc(1.5em + .75rem + 2px);
            padding: .375rem .75rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #495057;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: .25rem;
            transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
        }
    </style>
    <script>
        $(document).ready(function () {
            $('#chckMula').on('click', async function () {
                console.log("list_chckMula");
                var checkboxes = $('.list_chckMula');
                var chckMula = $(this).prop('checked');

                // Disable or enable chckTmt checkboxes based on the state of chckMula
                if (chckMula) {
                    $('#chckTamat').prop('disabled', true);
                } else {
                    $('#chckTamat').prop('disabled', false);
                }
            });
        });
    </script>
    <div class="modal fade" id="SenaraiPermohonan" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Permohonan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="panel-body" style="overflow-x: auto">
                    <br />
                    <div class="col-md-12">
                        <div class="form-group row">
                            <div class="col-md-6">
                                <input type="text" id="txtNama" name="txtNama" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="Nama">Nama</label>
                            </div>
                            <div class="col-md-6">
                                <input type="text" id="txtNoStaf" name="txtNoStaf" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="NoStaf">NoStaf</label>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Create the dropdown filter -->
                <div class="search-filter">
                    <div class="form-row justify-content-center">
                        <div class="form-group row col-md-6">
                            <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align: right">Carian :</label>
                            <div class="col-sm-8">
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
                                    <button id="btnSearch" runat="server" class="btn btnSearch" type="button">
                                        <i class="fa fa-search"></i>
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
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display: none;" class="input-group__input form-control input-sm">
                                        <label class="input-group__label" id="lblMula" for="Mula" style="display: none;">Mula: </label>
                                    </div>

                                    <div class="form-group col-md-6">
                                        <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display: none;" class="input-group__input form-control input-sm">
                                        <label class="input-group__label" id="lblTamat" for="Tamat" style="display: none;">Tamat: </label>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- tutup filtering--%>

                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblDataSenarai" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th scope="col">No. Permohonan</th>
                                        <th scope="col">Tarikh Mohon</th>
                                        <th scope="col">Nama Pemohon</th>
                                        <th scope="col">Tujuan</th>
                                        <th scope="col">Jumlah Mohon (RM)</th>
                                        <th scope="col">Status Terkini </th>

                                    </tr>
                                </thead>
                                <tbody id="tableID_SenaraiPermohonan">
                                </tbody>
                            </table>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Trigger the modal with a button -->
    <div class="modal-body">
        <div class="table-title">
            <%--<h6>Permohonan Pelbagai  </h6>--%>
            <button type="button" class="btn-change" data-toggle="modal" data-target="#myPersonal">Maklumat Pegawai</button>
            <div class="btn btn-primary btnPapar" onclick="ShowPopup('2')">
                Senarai Permohonan 
            </div>
        </div>
        <div class="form-row">
        </div>
    </div>
    <!-- Modal -->
    <div id="myPersonal" class="modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">


            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4>Maklumat Pegawai</h4>
                    <button type="button" class="close" data-dismiss="modal"></button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">

                    <asp:Panel ID="Panel2" runat="server">
                        <div class="form-row">
                            <div class="form-group col-sm-6">
                                <input type="text" id="txtNamaP" name="Nama" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="Nama">Nama</label>
                                <%--<asp:TextBox ID="txtNamaP" runat="server" Width="100%" class="form-control input-sm" style="background-color:#f3f3f3"></asp:TextBox>--%>
                            </div>
                            <div class="form-group col-sm-6">
                                <input type="text" id="txtNoPekerja" width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="No.Pekerja">No.Pekerja</label>


                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group col-sm-6">
                                <input type="text" id="txtJawatan" width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="kodModul">Jawatan</label>
                            </div>
                            <div class="form-group col-sm-6">
                                <input type="text" id="txtGredGaji" width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="kodModul">Gred Gaji</label>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group col-sm-6">
                                <input type="text" id="txtPejabat" width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="kodModul">Pejabat/Jabatan/Fakulti</label>
                                <input type="hidden" id="hidPtjPemohon" />

                                <%-- <asp:TextBox ID="txtPejabat" runat="server" Width="100%" CssClass="form-control" style="background-color:#f3f3f3"></asp:TextBox>--%>
                            </div>
                            <div class="form-group col-sm-6">
                                <input type="text" id="txtKump" width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="Kumpulan">Kumpulan</label>
                                <%--<asp:TextBox ID="txtKump" runat="server" Width="100%" CssClass="form-control" style="background-color:#f3f3f3"></asp:TextBox>--%>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group col-sm-6">
                                <input type="text" id="txtMemangku" width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="Memangku Jawatan">Memangku Jawatan</label>
                                <%-- <asp:TextBox ID="txtMemangku" runat="server" Width="100%" CssClass="form-control" style="background-color:#f3f3f3"></asp:TextBox>--%>
                            </div>
                            <div class="form-group col-sm-6">
                                <input type="text" id="txtTel" width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                <label class="input-group__label" for="Samb. Tel">Samb. Tel</label>
                                <%--<asp:TextBox ID="txtTel" runat="server" Width="100%" CssClass="form-control" style="background-color:#f3f3f3"></asp:TextBox>--%>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
            <%--Tutup class="modal-content">--%>
        </div>
    </div>
    <%--Tutup modal myPersonal--%>
    <div class="container-fluid">
        <br />
        <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item" role="presentation"><a class="nav-link active" id="Permohonan" data-toggle="tab" href="#menu1">Permohonan</a></li>
            <li class="nav-item" role="presentation"><a class="nav-link" id="tab-Kenyataan" data-toggle="tab" href="#menu2" aria-selected="false">Kenyataan</a></li>
            <li class="nav-item" role="presentation"><a class="nav-link" id="tab-elaunPjln" data-toggle="tab" href="#elaunPjln">Elaun Perjalanan </a></li>
            <li class="nav-item" role="presentation"><a class="nav-link" id="tab-pengangkutan" data-toggle="tab" href="#pengangkutan" aria-selected="false">Tambang Kenderaan Awam</a></li>
            <li class="nav-item" role="presentation"><a class="nav-link" id="tab-elaunMakan" data-toggle="tab" href="#elaunMakan" aria-selected="false">Elaun Makan/Harian</a></li>
            <li class="nav-item" role="presentation"><a class="nav-link" id="tab-sewaHotel" data-toggle="tab" href="#sewaHotel" aria-selected="false">Sewa Hotel/Lojing</a></li>
            <li class="nav-item" role="presentation"><a class="nav-link" id="tab-pelbagai" data-toggle="tab" href="#pelbagai" aria-selected="false">Pelbagai</a></li>
            <li class="nav-item" role="presentation"><a class="nav-link" id="tab-sumbangan" data-toggle="tab" href="#sumbangan" aria-selected="false">Sumbangan</a></li>
            <li class="nav-item" role="presentation"><a class="nav-link" id="tab-pengesahan" data-toggle="tab" href="#pengesahan" aria-selected="false">Pengesahan</a></li>
        </ul>

        <div class="tab-content">



            <%--Permohonan--%>
            <div id="menu1" class="tab-pane fade show active" role="tabpanel" aria-labelledby="Permohonan">
                <%--menu1--%>
                <asp:Panel ID="Panel1" runat="server">
                    <div class="tab-content" id="PermohonanTab">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-4">
                                        <label class="input-group__subTitle_lable">&nbsp;&nbsp;&nbsp;&nbsp;Sila Pilih Jenis Permohonan</b></label>
                                        &nbsp;
                     <input type="radio" id="Sendiri" name="JnsMohon" value="SENDIRI" checked>
                                        <label for="html">Sendiri</label>&nbsp;&nbsp; 
                     <input type="radio" id="StafLain" name="JnsMohon" value="STAFLAIN">
                                        <label for="html">Staf Lain</label>
                                        &nbsp;&nbsp;&nbsp;

                                    </div>
                                    <div class="form-group col-md-3">
                                        <%-- <div id="cariStaf" style="display:inline">--%>
                                        <div id="cariStaf" style="display: none">
                                            <select class="input-group__select ui search dropdown cr-staf" name="ddlStaf" id="ddlStaf" placeholder="&nbsp;"></select>
                                            <label class="input-group__label" for="Pilih Staf">Pilih Staf</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="col-md-12">
                        <div class="form-row">
                            <div class="form-group col-md-3" style="left: -1px; top: 0px">
                                <input type="text" id="noPermohonan" class="input-group__input form-control input-md" style="background-color: #f0f0f0" readonly>
                                <label class="input-group__label" for="No.Permohonan">No.Permohonan</label>
                            </div>
                            <div class="form-group col-md-3">
                                <select name="ddlTahun" id="ddlTahun" class="input-group__select form-control ui search dropdown tahun-list" placeholder="&nbsp;"></select>
                                <label class="input-group__label" for="Tahun">Tahun</label>
                            </div>
                            <div class="form-group col-md-3">
                                <select name="ddlBulan" id="ddlBulan" class="input-group__select form-control ui search dropdown bulan-list" placeholder="&nbsp;"></select>
                                <label class="input-group__label" for="Bulan">Bulan</label>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-row">
                                <input type="hidden" id="selectedNoPendahuluan" />
                                <input type="hidden" id="selectedJumlah" />
                                <input type="hidden" id="monthInt" />
                                <input type="hidden" id="tkhMohonCL" />

                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-3">
                                <select name="ddlKumpWang" id="ddlKumpWang" class="input-group__select ui search dropdown KumWang-list" placeholder="&nbsp;"></select>
                                <label class="input-group__label" for="Kum_wang">Kumpulan Wang</label>
                            </div>
                            <div class="form-group col-md-3">
                                <select name="ddlOperasi" id="ddlOperasi" class="input-group__select ui search dropdown KodOperasi-list" placeholder="&nbsp;"></select>
                                <label class="input-group__label" for="Kod Operasi">Kod Operasi</label>
                            </div>
                            <div class="form-group col-md-3">
                                <select name="ddlPTJ" id="ddlPTJ" class="input-group__select ui search dropdown KodPTJ-list" placeholder="&nbsp;"></select>
                                <label class="input-group__label" for="Kod Projek">Kod PTj</label>
                            </div>
                            <div class="form-group col-md-3">
                                <select name="ddlProjek" id="ddlProjek" class="input-group__select ui search dropdown KodProjek-list" placeholder="&nbsp;"></select>
                                <label class="input-group__label" for="Kod Projek">Kod Projek</label>
                            </div>
                        </div>
                    </div>
                    <div class="table-title">
                        <h6>&nbsp;&nbsp;Kontra Pendahuluan (jika ada) :</h6>
                        <hr />
                    </div>
                    <div>
                        <h6><b>&nbsp;&nbsp;Senarai Pendahuluan yang Telah Diterima</b></h6>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblListPend" class="table table-striped" style="width: 98%">
                                            <thead>
                                                <tr>
                                                    <th>
                                                        <input type="checkbox" name="select_all" value="1" id="example-select-all"></th>
                                                    <th scope="col" style="width: 25%">No Pendahuluan</th>
                                                    <th scope="col" style="width: 35%">Program</th>
                                                    <th scope="col" style="width: 15%">Jumlah Cek (RM)</th>
                                                    <th scope="col" style="width: 20%">No Baucer</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tableID_ListPend">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <textarea rows="2" cols="45" id="txtsebab" name="txtsebab" class="input-group__input form-control" placeholder="&nbsp;" maxlength="500"></textarea>
                                    <label class="input-group__label" for="Sebab">Sebab-sebab kelewatan menghantar permohonan (jika ada)</label>
                                </div>
                                <div class="form-group col-md-4"></div>
                                <div class="form-group col-md-2" align="right" >
                                    <button id="btnsimpanInfo" type="button" class="btn btn-secondary btnSimpanInfo">Simpan</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                </asp:Panel>


            </div>
            <%-- Tutup menu1"--%>

            <div id="menu2" class="tab-pane fade" aria-labelledby="tab-Kenyataan" role="tabpanel">
                <%--menu2--%>
                <asp:Panel ID="pnlKenyataan" runat="server">
                    <div class="col-md-10">
                        <div class="form-row">
                            <div class="form-group col-md-5">
                                <input type="text" id="txtMohonID" class="input-group__input form-control" placeholder="&nbsp;" style="background-color: #f3f3f3">
                                <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>
                            </div>
                            <div class="form-group col-md-3">
                                <input type="date" id="tkhMohon2" class="input-group__input form-control input-sm" style="background-color: #f3f3f3" placeholder="&nbsp;" readonly>
                                <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>
                            </div>
                        </div>
                    </div>

                    <div class="modal-body">
                        <div>
                            <h7>Kenyataan Tuntutan </h7>
                        </div>
                        <br />
                        <div class="col-sm-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblKenyataan" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th width="3%" rowspan="2">
                                                <input type="checkbox" name="checkbox" class="list_checkbox form-control-checkbox-tbl" value="1" /></th>
                                            <th width="9%" rowspan="2">
                                                <div align="center">Bil</div>
                                            </th>
                                            <th width="3%" rowspan="2">
                                                <div align="center">Mula</div>
                                            </th>
                                            <th width="7%" rowspan="2">
                                                <div align="center">Tarikh</div>
                                            </th>
                                            <th colspan="2" align="center">
                                                <div align="center">Waktu</div>
                                            </th>
                                            <th width="3%" rowspan="2">
                                                <div align="center">Tamat</div>
                                            </th>
                                            <th width="25%" rowspan="2">
                                                <div align="center">Tujuan/Tempat</div>
                                            </th>
                                            <th width="5%" rowspan="2">
                                                <div align="center">Jarak(KM)</div>
                                            </th>
                                        </tr>
                                        <tr>
                                            <th width="22%">
                                                <div align="center">Bertolak</div>
                                            </th>
                                            <th width="22%">
                                                <div align="center">Sampai</div>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_KenyataanTuntutan">
                                        <tr style="display: none;">
                                            <td>
                                                <input type="checkbox" name="chckItem" id="chckItem" class="list_chckItem form-control-checkbox-tbl" value="1" />
                                            </td>
                                            <td>
                                                <input type="text" id="txtBil" class="list_Bil form-control-input-tbl" size="5" placeholder="&nbsp;"  />
                                            </td>
                                            <td>
                                                <input type="checkbox" id="chckMula" name="chckMula" class="list_chckMula form-control-checkbox-tbl" value="1" />
                                            </td>
                                            <td>
                                                <input type="date" id="tkhTuntut" name="tkhTuntut" class="list_tkhTuntut form-control" size="2" placeholder="&nbsp;" >
                                            </td>
                                            <td>
                                                <div align="center">
                                                    <select id="ddlJamTolak" name="ddlJamTolak" class="list_ddlJamTolak input-group__select ui search dropdown" >
                                                        <option value="01">01</option>
                                                        <option value="02">02</option>
                                                        <option value="03">03</option>
                                                        <option value="04">04</option>
                                                        <option value="05">05</option>
                                                        <option value="06">06</option>
                                                        <option value="07">07</option>
                                                        <option value="08">08</option>
                                                        <option value="09">09</option>
                                                        <option value="10">10</option>
                                                        <option value="11">11</option>
                                                        <option value="12">12</option>
                                                        <option value="13">13</option>
                                                        <option value="14">14</option>
                                                        <option value="15">15</option>
                                                        <option value="16">16</option>
                                                        <option value="17">17</option>
                                                        <option value="18">18</option>
                                                        <option value="19">19</option>
                                                        <option value="20">20</option>
                                                        <option value="21">21</option>
                                                        <option value="22">22</option>
                                                        <option value="23">23</option>
                                                        <option value="00">00</option>

                                                    </select>
                                                    :  
                                                    <select id="ddlMinitTolak" class="list_ddlMinitTolak input-group__select ui search dropdown" >
                                                        <option value="00">00</option>
                                                        <option value="10">10</option>
                                                        <option value="20">20</option>
                                                        <option value="30">30</option>
                                                        <option value="40">40</option>
                                                        <option value="50">50</option>ss
                                                        <option value="59">59</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <div align="center">
                                                    <select id="ddlJamSampai" class="list_ddlJamSampai input-group__select ui search dropdown" >
                                                        <option value="01">01</option>
                                                        <option value="02">02</option>
                                                        <option value="03">03</option>
                                                        <option value="04">04</option>
                                                        <option value="05">05</option>
                                                        <option value="06">06</option>
                                                        <option value="07">07</option>
                                                        <option value="08">08</option>
                                                        <option value="09">09</option>
                                                        <option value="10">10</option>
                                                        <option value="11">11</option>
                                                        <option value="12">12</option>
                                                        <option value="13">13</option>
                                                        <option value="14">14</option>
                                                        <option value="15">15</option>
                                                        <option value="16">16</option>
                                                        <option value="17">17</option>
                                                        <option value="18">18</option>
                                                        <option value="19">19</option>
                                                        <option value="20">20</option>
                                                        <option value="21">21</option>
                                                        <option value="22">22</option>
                                                        <option value="23">23</option>
                                                        <option value="00">00</option>
                                                    </select>
                                                    : 
                                                    <select id="ddlMinitSampai" class="list_ddlMinitSampai input-group__select ui search dropdown" >
                                                        <option value="00">00</option>
                                                        <option value="10">10</option>
                                                        <option value="20">20</option>
                                                        <option value="30">30</option>
                                                        <option value="40">40</option>
                                                        <option value="50">50</option>
                                                        <option value="59">59</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <input type="checkbox" name="chckTamat" class="list_chckTamat form-control-checkbox-tbl" value="1"  />
                                            </td>
                                            <td>
                                                <div align="center">
                                                    <textarea width="100%" rows="3" cols="25" id="txtTujuan" class="list_txtTujuan form-control" placeholder="&nbsp;" maxlength="300" ></textarea>
                                                </div>
                                            </td>
                                            <td>
                                                <div align="center">
                                                    <input type="text" id="txtJarak" class="list_txtJarak form-control-input-tbl" size="3" placeholder="&nbsp;" >
                                                    <br />
                                                    
                                                    <select id="ddlJnsKenderaan" class="ui search dropdown input-group__select list_ddlJnsKenderaan_list" name="ddlJnsKenderaan">
                                                          <Label class="input-group__label" for="Nama">Jenis Kenderaan</Label> 
                                                    </select>
                                                    
                                                    <br />
                                                    <select id="ddlKenderaan" class="ui search dropdown input-group__select list_ddlKenderaan_list" name="ddlKenderaan"></select>
                                                   
                                                    <%--<input type="hidden" class="data-id" value="" />                                     
                                                    <label id="lblJnsKend" name="lblJnsKend" class="label-jnsLKend-list" style="text-align: center;visibility: hidden"></label>
                                                    <label id="HidlblJnsKend" name="HidlblJnsKend" class="Hid-jnsLKend-list" style="visibility: hidden"></label>--%>
                                                    <br />
                                                    <button type="button" class="btn-change" data-toggle="modal" data-target="#myKenderaan" style="display:none">Daftar Kenderaan</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                  <div class="row">
                      <div class="col-md-3">
                          <div class="btn-group">
                              <button type="button" class="btn btn-warning btnAddRow-tabK font-weight-bold" data-val="1" value="1"><b>+ Tambah</b></button>
                              <button type="button" class="btn btn-warning dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                  <span class="sr-only">Toggle Dropdown</span>
                              </button>
                              <div class="dropdown-menu">
                                  <a class="dropdown-item btnAddRow-tabK five" value="5" data-val="5">Tambah 5</a>
                                  <a class="dropdown-item btnAddRow-tabK" value="10" data-val="10">Tambah 10</a>

                              </div>
                          </div>
                      </div>
                  </div>

                  <div class="form-row">
                      <%--<div class="form-group col-md-6">
  <asp:LinkButton id="lbtnKembali" class="btn btn-primary" runat="server" onclick="lbtnKembali_Click"><i class="las la-angle-left"></i>Kembali</asp:LinkButton>
  </div>--%>
                      <div class="form-group col-md-12" align="right">
                          <button type="button" class="btn btn-danger btnReset" onclick="btnReset()">Hapus</button>
                          <button id="btnSaveKenyataan" type="button" class="btn btn-secondary btnSimpan2" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                      </div>
                  </div>
              </div>

                    <div>
                        <h6 style="color: #FF3300; font-size: 12px">Klik Senarai Tuntutan untuk senarai tuntutan yang layak</h6>
                    </div>
                    <div>
                        <h6 style="color: #FF3300; font-size: 12px">Klik butang Tambah untuk menambah baik Kenyataan Tuntutan</h6>
                    </div>
                    <div>
                        <h6 style="color: #FF3300; font-size: 12px">Klik butang Hapus untuk hapus Kenyataan Tuntutan</h6>
                    </div>
                </asp:Panel>

            </div>  
            <%--Tutup KenyataanTab--%>

            <%--content tab-3--%>
            <div id="elaunPjln" class="tab-pane fade" aria-labelledby="tab-elaunPjln" role="tabpanel">
                <%--menu 3--%>
                <asp:Panel ID="panel10" runat="server">
                    <div class="col-md-10">
                        <div class="form-row">
                            <div class="form-group col-md-5">
                                <input type="text" id="txtMohonID3" class="input-group__input form-control" placeholder="&nbsp;" style="background-color: #f3f3f3">
                                <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>
                            </div>
                            <div class="form-group col-md-3">
                                <input type="date" id="tkhMohon3" class="input-group__input form-control input-sm" style="background-color: #f3f3f3" placeholder="&nbsp;" readonly>
                                <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body">
                        <div>
                            <h7>Elaun Perjalanan Kenderaan </h7>
                        </div>
                        <br />
                        <div>
                            <div class="col-md-12">
                                <table class="table table-striped" id="tblDataEP" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th style="width: 20%; text-align: center" scope="col">No.Kenderaan</th>
                                            <th style="width: 20%; text-align: center" scope="col">Kiraan Kilometer (KM)</th>
                                            <th style="width: 20%; text-align: center" scope="col">Jumlah Jarak (KM)</th>
                                            <th style="width: 20%; text-align: center" scope="col">Kadar Sekilometer (RM)</th>
                                            <th style="width: 20%; text-align: center" scope="col">Amaun (RM)</th>

                                        </tr>
                                    </thead>
                                    <tbody id="tblDataEPList">
                                        <tr style="display: none; width: 100%" class="table-list">

                                            <td style="width: 20%">
                                                <input id="hidJnsKend" name="hidJnsKend" type="hidden" class="hidJnsKend-list form-control" style="text-align: right" />
                                                <input id="txtKenderaanEP" name="txtKenderaanEP" type="text" class="list-txtKenderaanEP form-control" style="text-align: right" readonly />
                                            </td>

                                            <td style="width: 10%">
                                                <input type="text" id="txtKiraKilometer" class="list-txtKiraKilometer form-control" style="text-align: right" readonly /><%-- //style="visibility: hidden"--%>
                                                <label id="hidkm" name="hidkm" class="hidkm-list"></label>
                                            </td>

                                            <td style="width: 20%">
                                                <input id="txtJumJarakEP" name="txtJumJarakEP" type="text" class="list-txtJumJarakEP form-control" style="text-align: right" readonly />
                                            </td>
                                            <td style="width: 20%">
                                                <input id="txtKadarEP" name="txtKadarEP" type="text" class="list-txtKadarEP form-control" style="text-align: right" readonly />
                                            </td>
                                            <td style="width: 20%">
                                                <input id="hidNostafKend" name="hidNostafKend" type="hidden" class="hidNostafKend-list form-control" style="text-align: right" />
                                                <input id="txtJumlahEP" name="txtJumlahEP" type="text" class="list-txtJumlahEP form-control" style="text-align: right" readonly />
                                            </td>

                                        </tr>
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td colspan="3">
                                                <%--<div class="btn-group">
                                                    <button type="button" class="btn btn-warning btnAddRow_tabEP One" data-val="1" value="1"><b>+ Tambah</b></button>
                                                    <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                        <span class="sr-only">Toggle Dropdown</span>
                                                    </button>
                                                    <div class="dropdown-menu">
                                                        <a class="dropdown-item btnAddRow_tabEP five" value="5" data-val="5">Tambah 5</a>
                                                        <a class="dropdown-item btnAddRow_tabEP" value="10" data-val="10">Tambah 10</a>

                                                    </div>
                                                </div>--%>
                                            </td>
                                            <td style="text-align:right">
                                                <%--<input class="form-control underline-input" id="totalDbt" name="totalDbt" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />--%>
                                                <label style="font-size: medium;">Jumlah (RM) </label>
                                            </td>
                                            <td>
                                                <input type="text" id="totalEP" class="input-group__input form-control-totalEP" placeholder="&nbsp;" style="background-color: #f3f3f3; text-align: right">
                                            </td>
                                        </tr>
                                        <tr >
                                            


                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-12" align="right">
                                <button id="btnSimpantab3" type="button" class="btn btn-secondary btnSimpantab3" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </div>

            <div id="pengangkutan" class="tab-pane fade" aria-labelledby="tab-pengangkutan" role="tabpanel"> <%--menu 4--%>
                <asp:Panel ID="Panel11" runat="server"> 
                    <div class="col-md-10">
                        <div class="form-row">
                            <div class="form-group col-md-5">
                                <input type="text" id="txtMohonID4" class="input-group__input form-control" placeholder="&nbsp;" style="background-color: #f3f3f3">
                                <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>
                            </div>
                            <div class="form-group col-md-3">
                                <input type="date" id="tkhMohon4" class="input-group__input form-control input-sm" style="background-color: #f3f3f3" placeholder="&nbsp;" readonly>
                                <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body">
                    <div>
                        <h8>Tambang Pengangkutan Awam</h8>              
                    </div>
                    <br />
                    <div>                           
                    <div class="row">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table class="table table-striped" id="tblTambang" style="width: 100%;">
                                    <thead>
                                        <tr style="width: 100%; text-align: center;">
                                            <th scope="col" style="width: 20%;vertical-align:middle; text-align: left;">Jenis Kenderaan Awam</th>
                                            <th scope="col" style="width: 10%;vertical-align:middle">Dengan Resit</th>
                                            <th scope="col" style="width: 10%;vertical-align:middle">Tanpa Resit</th>
                                            <th scope="col" style="width: 15%;vertical-align:middle">No Resit</th>
                                            <th scope="col" style="width: 10%;vertical-align:middle">Amaun(RM)</th>  
                                            <th scope="col" style="width: 25%;vertical-align:middle">Upload Resit</th> 
                                            <th scope="col" style="width: 10%;vertical-align:middle"></th> 
                                        </tr>
                                    </thead>
                                    <tbody id="tblTambangList">
                                        <tr class="table-list" width: 100%"  style="display:none;">
                                            <td>                                                      
                                                <select class="ui search dropdown ddlJenisTambangtblAwam-list" name="ddlJenisTambang" id="ddlJenisTambang"></select>
                                                <input type="hidden" class="data-id" />                                     
                                                <label id="lblJenisTambang" name="lblJenisTambang" class="label-jenisTam-list" style="text-align: center;visibility: hidden"></label>
                                                <label id="HidlblJenisTambang" name="HidlblJenisTambang" class="Hid-jenisTam-list" style="visibility: hidden"></label>
                                            </td>
                                            <td style="text-align:center">
                                                <input type="checkbox" name="checkbox_DengResit"  class="lblDengResit_list" style="text-align:center; vertical-align: middle;" >
                                                <label class="lblDengResit" id="lblDengResit" name="lblDengResit"></label>
                                            </td>
                                            <td style="text-align:center">
                                                <input type="checkbox" name="checkbox_TanpaResit" class="lblTanpaResit-list" style="text-align:center; vertical-align: middle;" >
                                                <label class="lblTanpaResit" id="lblTanpaResit" name="lblTanpaResit"></label>
                                            </td>
                                            <td style="text-align:right">
                                                <center><input type="text" class="form-control input-md lblnoResit-list" id="noResit" style="background-color:#fff;font-size:small"></center>
                                                <label class="lblnoResit" id="lblnoResit" name="lblnoResit"></label>
                                            </td>
                                            <td>
                                                <input type="text" class="form-control input-md AmaunTambang-list" id="AmaunTambang" style="background-color:#fff;font-size:small;text-align: right">
                                                <label class="lblAmaunTambang" id="lblAmaunTambang" name="lblAmaunTambang"></label>
                                            </td>  
                                            <td>                        
                                                <div class="input-group col-md-10">    
                                                    <div class="form-inline">
                                                        <input type="file" id="fileInputSurat" class="fileInputSurat" style="width:250px" />
                                                        <a href ="#" class="tempFile" target="_blank"></a>                                           
                                                        <span id="uploadResit" style="display: inline;"></span>
                                                        <span id="">&nbsp</span>
                                                        <span id="progressContainer"></span>
                                                        <input type ="hidden" id="txtNamaFile" />
                                                        <input type="hidden" class="form-control"  id="hidFolder" style="width:200px" readonly="readonly" /> 
                                                        <input type="hidden" class="form-control"  id="hidFileName" style="width:200px" readonly="readonly" /> 
                                                    </div>         
                                                </div>
                                            </td>
                                            <td> 
                                                <%--<input type="button" class="btn btn-secondary btnSimpanTA" onclick="return SimpanTA(this);" id="btnSimpanTA" value="Simpan" />--%>
                                                <button id="Button2" runat="server" class="btn btnSimpanTA" type="button" style="color: blue">
                                                    <i class="fa fa-floppy-o"></i>
                                                </button>                                        
                                                <button id="Button1" runat="server" class="btn btnDeleteTA" type="button" style="color: red">
                                                    <i class="fa fa-trash"></i> 
                                                </button>
                                            </td>   
                                        </tr>  
                                    </tbody>    
                                    <tfoot>
                                        <tr>
                                            <td></td>
                                            <td colspan="3" style="text-align:right">
                                                <%--<input class="form-control underline-input" id="totalDbt" name="totalDbt" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />--%>
                                                <label style="font-size:medium"> Jumlah (RM) </label>
                                            </td>
                                            <td colspan="1">
                                                <input class="form-control underline-input" id="totalTblTambang" name="totalTblTambang" style="text-align: right; font-weight: bold" width="8%" value="0.00" readonly /></td>
                                            <td colspan="2"></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <div class="btn-group">
                                                    <button type="button" class="btn btn-warning btnAddRow-tabPA One" data-val="1" value="1"><b>+ Tambah</b></button>
                                                    <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    <span class="sr-only">Toggle Dropdown</span>
                                                    </button>
                                                    <div class="dropdown-menu">
                                                        <a class="dropdown-item btnAddRow-tabPA five" value="5" data-val="5">Tambah 5</a>
                                                        <a class="dropdown-item btnAddRow-tabPA" value="10" data-val="10">Tambah 10</a>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="form-row"> 
                    <%--<div class="form-group col-md-12" align="right">                     
                    <button id="btnSimpantab4" type="button" class="btn btn-secondary btnSimpantab4" data-toggle="tooltip" data-placement="bottom" title="Draft" >Simpan</button>
                    </div>--%>
                    </div>
                    </div> 
                    </div>  
                </asp:Panel>
            </div>

            <div id="elaunMakan" class="tab-pane fade" aria-labelledby="tab-elaunMakan" role="tabpanel">
                <%--menu 5--%>
                <asp:Panel ID="Panel5" runat="server">
                    <div class="col-md-10">
                        <div class="form-row">
                            <div class="form-group col-md-5">
                                <input type="text" id="txtMohonID5" class="input-group__input form-control" placeholder="&nbsp;" style="background-color: #f3f3f3">
                                <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>
                            </div>
                            <div class="form-group col-md-3">
                                <input type="date" id="tkhMohon5" class="input-group__input form-control input-sm" style="background-color: #f3f3f3" placeholder="&nbsp;" readonly>
                                <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body">
                        <div>
                            <h8>Elaun Makan / Elaun Harian</h8>
                        </div>
                        <br />
                        <div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive " style="overflow-x: visible">
                                        <table class="table table-striped" id="tblElaunMkn" style="width: 100%;">
                                            <thead>
                                                <tr style="width: 100%; text-align: center;">
                                                    <th scope="col" style="width: 20%;" rowspan="2">Jumlah Hari(Pergi dan Pulang)</th>
                                                    <th scope="col" style="width: 10%;" rowspan="2">Jenis Perjalanan</th>
                                                    <th scope="col" style="width: 20%;" rowspan="2">Tempat</th>
                                                    <th scope="col" style="width: 20%;" rowspan="2">Pilih/Tandakan</th>
                                                    <th scope="col" style="width: 15%;" rowspan="2">Harga</th>
                                                    <th scope="col" style="width: 15%;" rowspan="2">Jumlah(RM)</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tblElaunMkn-list" style="width: 100%;" class="table-list">
                                                <tr style="display:none;">
                                                    <td style="width: 20%; text-align: justify;">                            
                                                        <input type="text" id="txtbilEL" class="input-group__input_td form-control-txtbilEL" readonly/> 
                                                         <input type="hidden" id="hidIDEL" class="input-group__input_td form-control-hidIDEL"/> 
                                                    </td>
                                                    <td style="width: 10%; text-align: justify;">                                                                             
                                                        <select class="ui search dropdown JenisTugasElaunMkn-list" name="ddlJenisTugasElaunMkn" id="ddlJenisTugasElaunMkn"></select>
                                                        <input type="hidden" class="data-id" value="" />                                     
                                                        <label id="lblJenisTugasElaunMkn" name="lblJenisTugasElaunMkn" class="label-JenisTugasElaunMkn-list" style="text-align: center;visibility: hidden"></label>
                                                        <label id="HidJenisTugasElaunMkn" name="HidJenisTugasElaunMkn" class="Hid-JenisTugasElaunMkn-list" style="visibility: hidden"></label>
                                                    </td>
                                                    <td style="width: 20%;text-align: justify;">
                                                        <select class="ui search dropdown JnstempatElaunMkn-list" name="ddlTmptElaunMkn" id="ddlTmptElaunMkn"></select>
                                                         <input type="hidden" class="data-id" value="" />                                     
                                                         <label id="lblJnstempatElaunMkn" name="lblJnstempatElaunMkn" class="label-JnstempatElaunMkn-list" style="text-align: center;visibility: hidden"></label>
                                                         <label id="HidJnstempatElaunMkn" name="HidJnstempatElaunMkn" class="Hid-JnstempatElaunMkn-list" style="visibility: hidden"></label>
                                                    </td>
                                                    <td style="width: 20%;text-align: left;">Sila Tandakan Pilihan Anda : <br />                                                        
                                                        <label style="vertical-align:middle" text-align: left;"> <input type="checkbox" name="checkbox4" value="checkbox" class="pagi"/> Sarapan Pagi</label><br /> 
                                                        <label style="vertical-align:middle" text-align: left;"> <input type="checkbox" name="checkbox5" value="checkbox" class="tghari" />  Makan Tengahari</label> <br />                            
                                                        <label style="vertical-align:middle" text-align: left;"> <input type="checkbox" name="checkbox6" value="checkbox" class="malam"/>  Makan Malam</label>
                                                    </td>
                                                    <td style="width: 15%;text-align: justify;">
                                                         <input type="text" id="txtHargaEL" class="input-group__input form-control-txtHargaEL" style="text-align:right"/>
                                                            <input type="text" id="txtPeratusMkn" class="input-group__input form-control-txtPeratusMkn" style="text-align:right;display:none"/> 
                                                    </td>
                        
                                                    <td style="width: 15%;">
                                                        <input type="text" id="txtJumlahEL" class="input-group__input form-control-txtJumlahEL" placeholder="&nbsp;" style="background-color:#f3f3f3;text-align:right" >
                                                    </td>
                                               </tr>

                                            </tbody>

                                            <tfoot>
                                                <tr>
                                                    <td colspan="4"></td>
                                                    <td style="text-align: right">
                                                        <label style="font-size: medium">Jumlah (RM) </label>
                                                    </td>
                                                    <td>
                                                        <input class="form-control underline-input" id="totalEL" name="totalEL" style="text-align: right; font-weight: bold" width="8%" value="0.00" readonly /></td>
                                                    <td></td>
                                                </tr>
                                                <%--<tr>
                                                    <td colspan="7">
                                                        <div class="btn-group">
                                                            <button type="button" class="btn btn-warning btnAddRow-tabElaunMkn One" data-val="1" value="1"><b>+ Tambah</b></button>
                                                            <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                <span class="sr-only">Toggle Dropdown</span>
                                                            </button>
                                                            <div class="dropdown-menu">
                                                                <a class="dropdown-item btnAddRow-tabElaunMkn five" value="5" data-val="5">Tambah 5</a>
                                                                <a class="dropdown-item btnAddRow-tabElaunMkn" value="10" data-val="10">Tambah 10</a>

                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>--%>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-12" align="right">
                                    <button id="btnSimpantab5" type="button" class="btn btn-secondary btnSimpantab5" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </div>

     
    <div id="sewaHotel" class="tab-pane fade" aria-labelledby="tab-sewaHotel" role="tabpanel">   <%--menu 6--%>
         <asp:Panel ID="Panel4" runat="server" > 
              <div class="col-md-10">        
                 <div class="form-row">
                 <div class="form-group col-md-5">
                 <input type="text"  id="txtMohonID6"  class="input-group__input form-control" placeholder="&nbsp;" style="background-color:#f3f3f3">
                 <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>                       
                 </div>                    
                 <div class="form-group col-md-3">
                 <input type="date" id="tkhMohon6" class="input-group__input form-control input-sm" style="background-color:#f3f3f3" placeholder="&nbsp;" readonly>                                   
                 <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>                        
                 </div>                
                 </div>
            </div>  

            <div class="modal-body">
                  <div>
                      <h8>Tuntutan Bayaran Sewa Hotel </h8>         
                  </div>                 
                <div>
                    <div class="row">
    <div class="col-md-12">
        <div class="transaction-table table-responsive">
            <table class="table table-striped" id="tblSewaHotel" style="width: 100%;">
                <thead>
                    <tr style="width: 100%; text-align: center;">
                        <th scope="col" style="width: 5%;vertical-align:middle; text-align: left;">No</th>
                        <th scope="col" style="width: 10%;vertical-align:middle">Jenis Tugas</th>
                        <th scope="col" style="width: 10%;vertical-align:middle">Tempat</th>
                        <th scope="col" style="width: 10%;vertical-align:middle">No Resit</th>
                        <th scope="col" style="width: 5%;vertical-align:middle">Hari</th>
                        <th scope="col" style="width: 15%;vertical-align:middle">Elaun(RM)/Hari</th> 
                        <th scope="col" style="width: 15%;vertical-align:middle">Amaun Tuntutan (RM)</th>
                        <th scope="col" style="width: 15%;vertical-align:middle">Upload Resit</th> 
                        <th scope="col" style="width: 15%;vertical-align:middle"></th> 
                    </tr>
                </thead>
                <tbody id="tblSewaHotelData">
                   
                <tr class="table-list" width: 100%" style="display:none;">
                    <td>
                    <input type="text" class="form-control input-md-txtBiltblHotel-list" id="txtBiltblHotel" style="background-color:#f3f3f3;font-size:small" >
                    <label class="lblBiltblHotel-list" id="lblBiltblHotel" name="bilhotel"></label>
                    </td>
                    <td>                                                      
                    <select class="ui search dropdown ddlJenisTugastblHotel-list" name="ddlJenisTugastblHotel" id="ddlJenisTugastblHotel"></select>
                    <input type="hidden" class="hidBil" value="" />                                     
                    <label id="lblJenisTugastblHotel" name="lblJenisTugastblHotel" class="label-JenisTugastblHotel-list" style="text-align: center;visibility: hidden"></label>
                    <label id="HidJenisTugastblHotel" name="HidJenisTugastblHotel" class="Hid-JenisTugastblHotel-list" style="visibility: hidden"></label>
                    </td>

                    <td>                                                      
                    <select class="ui search dropdown ddltempattblHotel-list" name="ddlTmpttblHotel" id="ddlTmpttblHotel"></select>
                   <label id="lblJnstempattblHotel" name="lblJnstempattblHotel" class="label-JnstempattblHotel-list" style="text-align: center;visibility: hidden"></label>
                    <label id="HidJnstempattblHotel" name="HidJnstempattblHotel" class="Hid-JnstempattblHotel-list" style="visibility: hidden"></label>
                    </td>

                    <td>
                    <input type="text" class="form-control input-md resittblHotel-list" id="resittblHotel" style="font-size:small" >
                    <label class="lblresittblHotel-list" id="lblresittblHotel" name="lblresittblHotel"></label>
                    </td>

                     <td>
                     <input type="text" class="form-control input-md haritblHotel-list" id="haritblHotel" style="font-size:small" >
                     <label class="lblharitblHotel-list" id="lblharitblHotel" name="lblharitblHotel"></label>
                     </td>
                    
                    <td>
                    <input type="text" class="form-control input-md elauntblHotel-list" id="elauntblHotel" disabled="disabled" style="background-color:#f3f3f3;font-size:small;text-align:right">
                    <label class="lblelauntblHotel-list" id="lblelauntblHotel" name="lblelauntblHotel"></label>
                    </td>

                    <td>
                    <input type="text" class="form-control input-md amauntblHotel-list" id="amauntblHotel" style="background-color:#f3f3f3;font-size:small;text-align:right">
                    <label class="lblamauntblHotel-list" id="lblamauntblHotel" name="lblamauntblHotel"></label>
                    </td> 
                    
                    <td>                        
                     <div class="input-group col-md-10">    
                     <div class="form-inline">
                        <input type="file" id="fileInputHotel" class="fileInputHotel" style="width:250px" />
                         <a href ="#" class="tempFileHotel" target="_blank"></a>                                           
                        <span id="uploadResitHotel" style="display: inline;"></span>
                        <span id="">&nbsp</span>
                        <span id="progressContainer3"></span>
                        <input type ="hidden" id="txtNamaFileHotel" />
                        <input type="hidden" class="form-control"  id="hidFolderHotel" style="width:200px" readonly="readonly" /> 
                        <input type="hidden" class="form-control"  id="hidFileNameHotel" style="width:200px" readonly="readonly" /> 
                        </div>         
                    </div>
                    </td>
                    <td> 
                             <button id="btnSimpanTH" runat="server" class="btn btnSimpanHotel"  type="button" style="color: blue">
    <i class="fa fa-floppy-o"></i></button>
                         <%--<input type="button" class="btn btn-secondary btnSimpanTH" onclick="return SimpanTH(this);" id="btnSimpanTH" value="Simpan" />--%>
                        <button id="lbtnCari" runat="server" class="btn btnDelete" type="button" style="color: red">
    <i class="fa fa-trash"></i>
</button>
     
                    </td>
   

                </tr >

                <tr class ="dummy-row-total" style="display:none;">
                    <td colspan="6">Bayaran Perkhidmatan Dan Cukai Kerajaan</td>
                    <td style="">
                        RM <input type="text" class="js-total-cukai" id="total-cukai" size="13" style="text-align: right; font-weight: bold" width="8%" value="0.00"  />
                    </td>
                    <td colspan="2">
                        <input type="checkbox" name="checkfield" id="chkKongsi"  class="kongsi-bilik" value="false"/>
                        <label  for="Makanan Disediakan">Kongsi Bilik</label>
                    </td>
                </tr>

                </tbody>    
                    <tfoot>
                    <tr>
                        <td colspan="4"></td>
                        <td colspan="2" style="text-align:right">
                            <%--<input class="form-control underline-input" id="totalDbt" name="totalDbt" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />--%>
                            <label style="font-size:medium"> Jumlah (RM) </label>
                        </td>
                        <td colspan="1">
                            <input class="form-control underline-input" id="totaltblHotel" name="totaltblHotel" style="text-align: right; font-weight: bold" width="8%" value="0.00" readonly /></td>
                        <td colspan="2"></td>
                    </tr>
                    <tr>
                        <td colspan="9">
                            <div class="btn-group">
                                <button type="button" class="btn btn-warning btnAddRow-tabHotel One" data-val="1" value="1"><b>+ Tambah</b></button>
                                <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="sr-only">Toggle Dropdown</span>
                                </button>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item btnAddRow-tabHotel five" value="5" data-val="5">Tambah 5</a>
                                    <a class="dropdown-item btnAddRow-tabHotel" value="10" data-val="10">Tambah 10</a>

                                </div>
                            </div>
                        </td>
                    </tr>
                    </tfoot>
            </table>

            <%--<div class="form-row"> 
<div class="form-group col-md-12" align="right">                     
<button id="btnSimpanHotel" type="button" class="btn btn-secondary btnSimpanHotel" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
</div>
</div>--%>

        </div>

        
        </div>
    
    </div>

<div class="row">
     <div>
         <br />
     <h8>&nbsp;&nbsp;Tuntutan Bayaran Elaun Penginapan Lojing</h8>         
 </div>
<div class="col-md-12">
    <div class="transaction-table table-responsive">
        
        <table class="table table-striped" id="tblLojing" style="width: 100%;">
            <thead>
                <tr style="width: 100%; text-align: center;">
                    <th scope="col" style="width: 5%;vertical-align:middle; text-align: left;">No</th>
                    <th scope="col" style="width: 10%;vertical-align:middle">Jenis Tugas</th>
                    <th scope="col" style="width: 10%;vertical-align:middle">Tempat</th>
                    <th scope="col" style="width: 15%;vertical-align:middle">No Resit</th>                     
                    <th scope="col" style="width: 5%;vertical-align:middle">Hari</th>
                    <th scope="col" style="width: 10%;vertical-align:middle">Elaun(RM)/Hari</th>
                    <th scope="col" style="width: 10%;vertical-align:middle">Amaun Tuntutan (RM)</th>
                     <th scope="col" style="width: 20%;vertical-align:middle">Upload Resit</th> 
                     <th scope="col" style="width: 15%;vertical-align:middle"></th> 
                </tr>
            </thead>
            <tbody id="tblLojingData">
                <tr class="table-list" width: 100%" style="display:none;">
                    <td>
                    <input type="text" class="form-control input-md-txtBiltblLojing" id="txtBiltblLojing" style="background-color:#f3f3f3;font-size:small" >
                    <label class="lblAmaun" id="lblBiltblLojing" name="bilhotel"></label>
                    </td>
                    <td>                                                      
                    <select class="ui search dropdown ddlJenisTugastblLojingA-list" name="ddlJenisTugastblLojing" id="ddlJenisTugastblLojing"></select>
                    <input type="hidden" class="data-id" value="" />                                     
                    <label id="lblJenisTugastblLojing" name="lblJenisTugastblLojing" class="label-JenisTugastblLojing-list" style="text-align: center;visibility: hidden"></label>
                    <label id="HidJenisTugastblLojing" name="HidJenisTugastblLojing" class="Hid-JenisTugastblLojing-list" style="visibility: hidden"></label>
                    </td>

                    <td>                                                      
                    <select class="ui search dropdown ddlTmpttblLojingA-list" name="ddlTmpttblLojing" id="ddlTmpttblLojing"></select>
                    <label id="lblJnstempattblLojing" name="lblJnstempattblLojing" class="label-JnstempattblLojing-list" style="text-align: center;visibility: hidden"></label>
                    <label id="HidJnstempattblLojing" name="HidJnstempattblLojing" class="Hid-JnstempattblLojing-list" style="visibility: hidden"></label>
                    </td>

                    <td>
                    <input type="text" class="form-control input-md resittblLojing" id="resittblLojing" style="font-size:small" >
                    <label class="resit-list" id="lblresittblLojing" name="lblresittblLojing"></label>
                    </td>

                    <td>
                    <input type="text" class="form-control input-md haritblLojing-list" id="haritblLojing" style="font-size:small" >
                    <label class="lblharitblLojing-list" id="lblharitblLojing" name="lblharitblLojing"></label>
                    </td>

                    <td>
                    <input type="text" class="form-control input-md elauntblLojing-list" id="elauntblLojing" disabled="disabled" style="background-color:#f3f3f3;font-size:small;text-align:right">
                    <label class="lblAmaunLojing-list" id="lblelauntblLojing" name="lblelauntblLojing"></label>
                    </td>

                    
   
                    <td>
                    <input type="text" class="form-control input-md amauntblLojing-list" id="amauntblLojing" style="background-color:#f3f3f3;font-size:small;text-align:right">
                    <label class="lblAmaunLojing-list" id="lblamauntblLojing" name="lblamauntblLojing"></label>
                    </td> 
                    
                   <td>                        
                     <div class="input-group col-md-10">    
                     <div class="form-inline">
                        <input type="file" id="fileInputLojing" class="fileInputLojing" style="width:250px" />
                         <a href ="#" class="tempFileLojing" target="_blank"></a>                                           
                        <span id="uploadResitLojing" style="display: inline;"></span>
                        <span id="">&nbsp</span>
                        <span id="progressContainer4"></span>
                        <input type ="hidden" id="txtNamaFileLojing" />
                        <input type="hidden" class="form-control"  id="hidFolderLojing" style="width:200px" readonly="readonly" /> 
                        <input type="hidden" class="form-control"  id="hidFileNameLojing" style="width:200px" readonly="readonly" /> 
                        </div>         
                    </div>
                    </td>

                    <td> 
                        <button id="Button3" runat="server" class="btn btnSimpanLojing"   type="button" style="color: blue">
                        <i class="fa fa-floppy-o"></i></button>
                        <%--<input type="button" class="btn btn-secondary btnSimpanTH" onclick="return SimpanTH(this);" id="btnSimpanTH" value="Simpan" />--%>
                        <button id="Button4" runat="server" class="btn btnDelLojing" type="button" style="color: red">
                        <i class="fa fa-trash"></i>
                        </button>
     
                    </td>

 
                </tr >

            </tbody>    
                <tfoot>
                <tr>                    
                    <td>Alamat Lojing</td>
                    <td colspan="2"><textarea rows="2" cols="40" ID="txtAlamatLojing" name="AlamatLojing" class="form-control input-md alamatlLojing" placeholder="&nbsp;" MaxLength="500"></textarea></td>
                   
                    <td colspan="3" style="text-align:right">
                        <%--<input class="form-control underline-input" id="totalDbt" name="totalDbt" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />--%>
                        <label style="font-size:medium"> Jumlah (RM) </label>
                    </td>
                    <td>
                        <input class="form-control underline-input" id="totalTblLojing" name="totalTblLojing" style="text-align: right; font-weight: bold" width="8%" value="0.00" readonly /></td>
                    <td colspan="3"></td>
                </tr>
                    
                <tr>
                    <td colspan="9">
                        <div class="btn-group">
                            <button type="button" class="btn btn-warning btnAddRow-tabLojing One" data-val="1" value="1"><b>+ Tambah</b></button>
                            <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="sr-only">Toggle Dropdown</span>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item btnAddRow-tabLojing five" value="5" data-val="5">Tambah 5</a>
                                <a class="dropdown-item btnAddRow-tabLojing" value="10" data-val="10">Tambah 10</a>

                            </div>
                        </div>
                    </td>
                </tr>
                </tfoot>
        </table>
    </div>
    </div>
</div>
              
</div> 
        <%--<div class="form-row"> 
            <div class="form-group col-md-12" align="right">                     
                <button id="btnSimpanLojing" type="button" class="btn btn-secondary btnSimpanLojing" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
            </div>
        </div>--%>
                  
              
             
</div>
        
      <div><h8 style="color: #FF3300">Nota:</h8></div>
     <div><h8 style="color: #FF3300">SM = Semenanjung Malaysia</h8></div>
     <div><h8 style="color: #FF3300">SS = Sabah dan Sarawak</h8></div>
                 
    </asp:Panel>
  </div>

     <div id="pelbagai" class="tab-pane fade" aria-labelledby="tab-pelbagai" role="tabpanel">   <%--menu 7--%>
      <asp:Panel ID="Panel6" runat="server" >    
            <div class="col-md-10">        
                 <div class="form-row">
                 <div class="form-group col-md-5">
                 <input type="text"  id="txtMohonID7"  class="input-group__input form-control" placeholder="&nbsp;" style="background-color:#f3f3f3">
                 <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>                       
                 </div>                    
                 <div class="form-group col-md-3">
                 <input type="date" id="tkhMohon7" class="input-group__input form-control input-sm" style="background-color:#f3f3f3" placeholder="&nbsp;" readonly>                                   
                 <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>                        
                 </div>                
                 </div>
            </div>   
      <div class="modal-body">
          <div>
              <h8>Tuntutan Pelbagai</h8>
              <br />
          </div>
        <br />
      <div>                           
      <div class="row">
          <div class="col-md-12">
              <div class="transaction-table table-responsive">
                   <table class="table table-striped" id="tblPelbagai" style="width: 100%;">
     <thead>
         <tr style="width: 100%; text-align: center;">
             <th scope="col" style="width: 20%;vertical-align:middle; text-align: left;">Jenis Belanja Pelbagai</th>
             <th scope="col" style="width: 10%;vertical-align:middle">Dengan Resit</th>
             <th scope="col" style="width: 10%;vertical-align:middle">Tanpa Resit</th>
             <th scope="col" style="width: 20%;vertical-align:middle">No Resit</th>
             <th scope="col" style="width: 10%;vertical-align:middle">Amaun(RM)</th> 
             <th scope="col" style="width: 20%;vertical-align:middle">Upload Resit</th> 
             <th scope="col" style="width: 10%;vertical-align:middle"></th> 
         </tr>
     </thead>
     <tbody id="tblPelbagaiList">
            <tr class="table-list" width: 100%" style="display:none;">
                <td>                                                      
                    <select class="ui search dropdown JenisPelbagai-list" name="ddlJenisPelbagai" id="ddlJenisPelbagai"></select>
                    <input type="hidden" class="txtBil"  name="txtBil" value="" />                                     
                    <label id="lblJenisPelbagai" name="lblJenisPelbagai" class="label-jenisPelbagai-list" style="text-align: center;visibility: hidden"></label>
                    <label id="HidlblJenisPelbagai" name="HidlblJenisPelbagai" class="Hid-jenisPelbagai-list" style="visibility: hidden"></label>
                </td >
                <td style="text-align:center">
                    <input type="checkbox" name="checkbox_DengResitBP" class="checkbox_DengResitBP-list" style="text-align:center; vertical-align: middle;" >
                    <label class="lblDengResitBP-list" id="lblDengResitBP" name="lblDengResitBP"></label>
                </td>
                <td style="text-align:center">
                    <input type="checkbox" name="checkbox_TanpaResitBP" class="checkbox_TanpaResitBP-list"  style="text-align:center; vertical-align: middle;" >
                    <label class="lblTanpaResitBP-list" id="lblTanpaResitBP" name="lblTanpaResitBP"></label>
                </td>
                <td >
                    <center><input type="text" class="form-control input-md-noResitBP" id="noResitBP" name="noResitBP" style="background-color:#fff;font-size:small"></center>
                    <label class="lblnoResitBP-list" id="lblnoResitBP" name="lblnoResitBP"></label>
                </td>
                <td>
                    <input type="text" class="form-control input-md-AmaunBP" id="AmaunBP" style="background-color:#fff;font-size:small;text-align: right" >
                    <label class="lblAmaunBP-list" id="lblAmaunBP" name="lblAmaunBP"></label>
                </td>

               <td>                        
                 <div class="input-group col-md-10">    
                 <div class="form-inline">
                    <input type="file" id="fileInputPelbagai" class="fileInputPelbagai" style="width:250px" />
                     <a href ="#" class="tempFilePelbagai" target="_blank"></a>                                           
                    <span id="uploadPelbagai" style="display: inline;"></span>
                    <span id="">&nbsp</span>
                    <span id="progressContainer2"></span>
                    <input type ="hidden" id="txtNamaFilePelbagai" />
                    <input type="hidden" class="form-control"  id="hidFolderPelbagai" style="width:200px" readonly="readonly" /> 
                    <input type="hidden" class="form-control"  id="hidFileNamePelbagai" style="width:200px" readonly="readonly" /> 
                    </div>         
                </div>
                </td>
                <%--<td> 
                     <input type="button" class="btn btn-secondary btnSimpanTP" onclick="return SimpanTP(this);" id="btnSimpanTP" value="Simpan" />
                </td>--%>

                 <td> 
                         <button id="Button5" runat="server" class="btn btnSimpanPelbagai"   type="button" style="color: blue">
                         <i class="fa fa-floppy-o"></i></button>
                         <%--<input type="button" class="btn btn-secondary btnSimpanTH" onclick="return SimpanTH(this);" id="btnSimpanTH" value="Simpan" />--%>
                         <button id="Button6" runat="server" class="btn btnDelPelbagai" type="button" style="color: red">
                         <i class="fa fa-trash"></i>
                         </button>
     
                </td>

            <%--<td class="tindakan">
            <button class="btn btnDelete">
            <i class="fa fa-trash" style="color: red"></i>
            </button>
            <button class="btn"><i class="fa fa-trash"></i> Trash</button>
            </td>--%>
            </tr >

     </tbody>    
         <tfoot>
         <tr>
             <td colspan="2"></td>
             <td colspan="2" style="text-align:right">
                 <%--<input class="form-control underline-input" id="totalDbt" name="totalDbt" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />--%>
                 <label style="font-size:medium"> Jumlah (RM) </label>
             </td>
             <td>
                 <input class="form-control underline-input" id="totalRm" name="totalRm" style="text-align: right; font-weight: bold" width="8%" value="0.00" readonly /></td>
             <td colspan="2"></td>
         </tr>
         <tr>
             <td colspan="7">
                 <div class="btn-group">
                     <button type="button" class="btn btn-warning btnAddRow-tabPelbagai One" data-val="1" value="1"><b>+ Tambah</b></button>
                     <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                         <span class="sr-only">Toggle Dropdown</span>
                     </button>
                     <div class="dropdown-menu">
                         <a class="dropdown-item btnAddRow-tabPelbagai five" value="5" data-val="5">Tambah 5</a>
                         <a class="dropdown-item btnAddRow-tabPelbagai" value="10" data-val="10">Tambah 10</a>

                     </div>
                 </div>
             </td>
         </tr>
         </tfoot>
 </table>
              </div>
    <%--<div class="form-row"> 
    <div class="form-group col-md-12" align="right">                     
        <button id="btnSimpantab7" type="button" class="btn btn-secondary btnSimpantab7" data-toggle="tooltip" data-placement="bottom" title="Draft" >Simpan</button>
    </div>
</div>--%>
          </div>

         
      </div>
      </div>

        </div> <%--Tutup Bahagian C modal-body--%>

         </asp:Panel>
     
     </div>  <%--Tutup tab 7--%> 

  <div id="sumbangan" class="tab-pane fade" aria-labelledby="tab-sumbangan" role="tabpanel">   <%--menu 7--%>
      <asp:Panel ID="Panel9" runat="server" >    
            <div class="col-md-10">        
                 <div class="form-row">
                 <div class="form-group col-md-5">
                 <input type="text"  id="txtMohonID9"  class="input-group__input form-control" placeholder="&nbsp;" style="background-color:#f3f3f3">
                 <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>                       
                 </div>                    
                 <%--<div class="form-group col-md-3">
                 <input type="date" id="tkhMohon9" class="input-group__input form-control input-sm" style="background-color:#f3f3f3" placeholder="&nbsp;" readonly>                                   
                 <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>                        
                 </div>    --%>            
                 </div>
            </div>   
      <div class="modal-body">
          <div>
              <h8>Sumbangan Tabung</h8>
              <br />
          </div>
        <br />
      <div>                           
    
      <div class="col-md-12"> 
          <div class="transaction-table table-responsive">
    <table  class="table table-striped" id="tblSumbangan" style="width: 100%;">
        <thead>
            <tr style="width: 100%; text-align: center;">
                <th scope="col" style="width: 5%;vertical-align:middle; text-align: left;">Bil</th>
                <th scope="col" style="width: 40%;vertical-align:middle">Nama Tabung</th>
                <th scope="col" style="width: 30%;vertical-align:middle">Jumlah (RM)</th> 
                <th scope="col" style="width: 25%;vertical-align:central">Tindakan</th>
            </tr>
        </thead>
         <tbody id="tblDataSumbangan">
             <tr class="table-list" width: 100%" style="display:none;">
                  <td>
                      <input type="text" class="form-control txtBilSumbangan-list" id="txtBilSumbangan" style="background-color:#f3f3f3;font-size:small" >
                  </td>

                 <td>
                     <select class="ui search dropdown JenisSumbangan-list" name="ddlSumbangan" id="ddlSumbangan"></select>
                     <label id="lblSumbangan" name="lblSumbangan" class="label-jenisSumbangan-list" style="text-align: center;visibility: hidden"></label>
                     <label id="HidlblSumbangan" name="HidlblSumbangan" class="Hid-jenisSumbangan-list" style="visibility: hidden"></label>
                 </td>                                   

                 <td>
                     <input type="text" class="form-control input-md-txtSumbangan" id="txtSumbangan" style="background-color:#fff;font-size:small;text-align: right" >
                 </td>
                 
                 <td style="text-align:center">
                     
                      <%--<input type="button" class="btn btn-secondary btnSimpanTH" onclick="return SimpanTH(this);" id="btnSimpanTH" value="Simpan" />--%>
                      <button id="btnDeSumbangan" runat="server" class="btn btnDeSumbangan" type="button" style="color: red">
                      <i class="fa fa-trash"></i>
                      </button>
                 </td>        

             </tr>
         </tbody>
        <tfoot>
            <tr>
               
                <td colspan="2" style="text-align: right">
                    <%--<input class="form-control underline-input" id="totalDbt" name="totalDbt" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />--%>
                    <label style="font-size:medium"> Jumlah (RM) </label>
                </td>
                <td>
                    <input type="text" id="totalTabung" class="input-group__input form-control-totalTabung" placeholder="&nbsp;" style="background-color:#f3f3f3;text-align: right" >    
                </td>
            </tr>
              <tr>
                <td colspan="4">
                    <div class="btn-group">
                        <button type="button" class="btn btn-warning btnAddRow_tabSumbangan One" data-val="1" value="1"><b>+ Tambah</b></button>
                        <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="sr-only">Toggle Dropdown</span>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item btnAddRow_tabSumbangan five" value="5" data-val="5">Tambah 5</a>
                            <a class="dropdown-item btnAddRow_tabSumbangan" value="10" data-val="10">Tambah 10</a>

                        </div>
                    </div>
                </td>               
            </tr>

            
        </tfoot>
     </table>
     </div>
          <div class="row">
    <div class="col-md-12">
        <div class="form-row">
            <div class="form-group col-md-12" align="right">                     
                <button id="btnSimpantab6" type="button" class="btn btn-secondary btnSimpantab5" data-toggle="tooltip" data-placement="bottom" title="Draft" >Simpan</button>
            </div>
        </div>
    </div>
</div>
</div>

         
     
      </div>

    </div> <%--Tutup Bahagian C modal-body--%>

    </asp:Panel>

 </div>
  <div id="pengesahan" class="tab-pane fade" aria-labelledby="tab-pengesahan" role="tabpanel">   <%--menu 8--%>
     <asp:Panel ID="Panel8" runat="server" >    
           <div class="col-md-10">        
                <div class="form-row">
                <div class="form-group col-md-5">
                <input type="text"  id="txtMohonID8"  class="input-group__input form-control" placeholder="&nbsp;" style="background-color:#f3f3f3">
                <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>                       
                </div>                    
                <div class="form-group col-md-3">
                <input type="date" id="tkhMohon8" class="input-group__input form-control input-sm" style="background-color:#f3f3f3" placeholder="&nbsp;" readonly>                                   
                <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>                        
                </div>                
                </div>
           </div>   
     <div class="modal-body">
         <div class="row">
            <div class="col-md-12"> 
                Rumusan Kenyataan Tuntutan<br />
                <table class="table table-striped" style="width: 100%">
                     <tr>
                       <td> Jumlah Elaun Makan/Harian </td>
                       <td><input type="text" name="JumElaun" id="JumElaun" style="text-align: right" readonly value="0.00" /></td>
                     </tr>
                    <tr>
                      <td> Jumlah Sewa Hotel/ Elaun Lojing </td>
                      <td><input type="text" name="JumSewaHotel" id="JumSewaHotel" style="text-align: right" value="0.00" readonly /></td>
                    </tr>
                     <tr>
                       <td> Jumlah Elaun Perjalanan Kenderaan </td>
                       <td><input type="text" name="JumPerjalanan" id="JumPerjalanan" style="text-align: right" value="0.00" readonly /></td>
                     </tr>
                    <tr>
                      <td> Jumlah Tambang Pengangkutan Awam </td>
                      <td><input type="text" name="JumTambang" id="JumTambang" style="text-align: right" value="0.00" readonly /></td>
                    </tr>
                    <tr>
                      <td> Jumlah Pelbagai </td>
                      <td><input type="text" name="JumPelbagai" id="JumPelbagai" style="text-align: right" value="0.00" readonly /></td>
                    </tr>
                    <tr>
                      <td> Jumlah Keseluruhan Tuntutan </td>
                      <td><input type="text" name="JumKeseluruhan" id="JumKeseluruhan" style="text-align: right"  value="0.00" readonly /></td>
                    </tr>
                    <tr>
                      <td> Tolak Jumlah Pendahuluan Yang Diberi </td>
                      <td><input type="text" name="TolakPendahuluan" id="TolakPendahuluan" style="text-align: right" value="0.00" readonly /></td>
                    </tr>
                    <tr>
                      <td> Tolak Jumlah Sumbangan </td>
                      <td><input type="text" name="TolakSumbangan" id="TolakSumbangan" style="text-align: right" value="0.00" readonly /></td>
                    </tr>
                     <tr>
                       <td> JUMLAH BESAR BAKI TUNTUTAN / BAKI DIBAYAR BALIK </td>
                       <td><input type="text" name="jumBersih" id="jumBersih" style="text-align: right"  value="0.00" readonly /></td>
                     </tr>
                </table>                
           </div>
         </div>       

        <div>
            <h8><b>Pengakuan Dan Pengesahan</b></h8>
            <br />
        </div>
    
    <div>                           
    <div class="row">
        <div class="col-md-12">
           <input type="checkbox" ID="chckSah" value="1"/> Saya mengaku bahawa <br />
            a) Perjalanan pada tarikh-tarikh tersebut adalah benar dan telah dibuat atas tugas rasmi <br />
            b) Tuntutan ini dibuat mengikut kadar dan syarat seperti yang dinyatakan dibawah peraturan-peraturan bagi pegawai bertugas rasmi dan/ 
            atau pegawai berkursus yang berkuatkuasa semasa. <br />
            c) Perbelanjaan yang tidak disokong dengan resit berjumlah sebanyak RM <input type="text" id="jumtdkDsokong"  value="0.00"  style="text-align: right"> telah sebenarnya dilakukan dan dibayar oleh saya.<br /><br />
            <div class="form-group col-md-3">      
                <div class="form-inline">      
                <input type="file" id="fileInputBelanja" class="input-group__input choose-button"/>
                <label for="UploadBelanja"  class="input-group__label">Muatnaik bukti belanja</label><br />
                <input type="button" id="uploadBelanja" class="btn btn-secondary" value="Muatnaik" onclick="uploadFileBelanja()" />
                <span id="uploadedFileNameLabelBelanja" style="display: inline;"></span>
                <span id="">&nbsp</span>
                <span id="progressContainerBelanja"></span>
                <input type="hidden" class="form-control"  id="hidJenDokBelanja" style="width:300px" readonly="readonly" /> 
                <input type="hidden" class="form-control"  id="hidFileNameBelanja" style="width:300px" readonly="readonly" /> 
                </div> 
            </div>
            d) Semua butiran yang dinyatakan diatas adalah tepat dan benar dan saya bertanggungjawab terhadap semua maklumat yang dinyatakan; dan <br />
            e) Sekiranya saya mengemukakan tuntutan palsu, saya boleh dikenakan tindakan di bawah Seksyen 18, <br />Akta Suruhanjaya Pencegah Rasuah Malaysia 2009[Akta 694](Kesalahan dengan maksud untuk memperdayakan prinsipal oleh ejen).


        </div>
    </div>
    </div>
     <div class="form-row">
            <div class="form-group col-md-12" align="right">           
               <button type="button" class="btn btn-secondary btnSimpanHantar">Hantar</button>
            </div>
    </div>

       <%--Tutup Bahagian Pengesahan modal-body--%>

         </div>
        </asp:Panel>
    
    </div>  <%--Tutup tab 8--%> 
 
</div>

        
 </div>

 <!-- Modal Delete Lampiran-->
 <div class="modal fade" id="saveConfirmationModalDeleteLampiran" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
     <div class="modal-dialog " role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title" id="saveConfirmationModalLabelDeleteLampiran">Pengesahan</h5>
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                 </button>
             </div>
             <div class="modal-body">
                 <p id="confirmationMessageDeleteLampiran"></p>
             </div>
             <div class="modal-footer">
                 <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                 <button type="button" class="btn btn-secondary" id="confirmSaveButtonDeleteLampiran">Ya</button>
             </div>
         </div>
     </div>
 </div>



    
 

 <!-- Modal myKenderaan -->
<div id="myKenderaan" class="modal fade" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
       
    <!-- Modal content-->
    <div class="modal-content">
    <div class="modal-header"><h4>Daftar Kenderaan</h4>
    <button type="button" class="close" data-dismiss="modal"></button>
    <h4 class="modal-title"></h4> 
    </div>
    <div class="modal-body">
       
             <asp:Panel ID="Panel3" runat="server" >
                         <div class="form-row">                                      
                            <div class="form-group col-sm-3">
                                 <input type="text" id="txtNamaPK" name="Nama" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0"/> 
                                <label class="input-group__label" for="Nama">Nama Pegawai</label>                                       
                                 <%--<asp:TextBox ID="txtNamaP" runat="server" Width="100%" class="form-control input-sm" style="background-color:#f3f3f3"></asp:TextBox>--%>
                            </div>                                    
                            <div class="form-group col-sm-3">
                                 <input type="text" ID="txtNoPekerjaK"  Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />  
                                <label class="input-group__label"  for="No.Pekerja">No.Staf</label>                                                               
                            </div>  
                              <div class="form-group col-sm-3">
                                  <input type="text" ID="txtPtjK"  Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />  
                                 <label class="input-group__label"  for="No.Pekerja">PTJ</label>                                                               
                             </div> 
                              <div class="form-group col-sm-3">
                                 <input type="text" ID="txtTujuanPjlnK"  Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />  
                                <label class="input-group__label"  for="Tujuan Perjalanan">Tujuan Perjalanan</label>                                                               
                            </div>  
                       </div>

                        <div class="form-row">
                            <div class="form-group col-sm-3">
                                 <input type="text" ID="TxtJnsKenderaan"  Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0"  />  
                                <label class="input-group__label" for="Jenis Kenderaan">Jenis Kenderaan</label>                        
                            </div>
                            <div class="form-group col-sm-3">
                                 <input type="text" ID="txtNoDaftarK" Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" /> 
                                <label class="input-group__label" for="No Daftar">No Daftar Kenderaan</label>                                     
                            </div>
                            <div class="form-group col-sm-3">
                                 <input type="text" ID="txtKelasK" Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" /> 
                                <label class="input-group__label" for="KelasKendeaan">Kuasa/Kelas</label>                                     
                            </div>
                            <div class="form-group col-sm-3">
                                  <input type="date" id="tkhPjln" class="input-group__input form-control tkhPjln"  placeholder="&nbsp;">
                                    <label class="input-group__label" for="Tarikh Perjalanan">Tarikh Perjalanan</label>                                     
                            </div>
                        </div>

                         <div class="form-row">
                            <asp:Panel ID="Panel7" runat="server">           
                                <b>*Saya seperti nama diatas dengan ini memohon kebenaran tuan menggunakan Kenderaan sendiri kerana :</b><br />
                                    
                                    <br /><input type="checkbox" ID="sebab1" value="1" /> &nbsp;&nbsp;Jarak sehala antara kedua-dua tempat adalah kurang dari 240km
                                    <br /><input type="checkbox" ID="sebab2" value="2" /> &nbsp;&nbsp;Dikehendaki menjalankan tugas rasmi di beberapa tempat di sepanjang perjalanan
                                    <br /><input type="checkbox" ID="sebab3" value="3" /> &nbsp;&nbsp;Keperluan mustahak/keperluan lain : &nbsp;
                                        &nbsp;&nbsp;<textarea rows="2" cols="45" name="sebabLain" class="input-group__input form-control"  ></textarea>
                                       
                                        <br /><input type="checkbox" ID="sebab4" value="4" />Berkongsi kenderaan dengan : <br />
                                           <table class="table table-striped"  width="75%" border="1" cellpadding="1" cellspacing="1">
                                              <tr>
                                                <td width="5%" bgcolor="#CCCCCC"><div align="center">No</div></td>
                                                <td width="10%" bgcolor="#CCCCCC"><div align="center">No.Staf</div></td>
                                                <td width="60%" bgcolor="#CCCCCC"> <div align="center">Nama</div></td>
                                              </tr>
                                              <tr>
                                                <td>1.</td>
                                                <td><div align="center"><input type="text" name="namaBersama1" /></div></td>
                                                <td><input type="text" name="nostafBersama1" size="75%" /></td>
                                              </tr>
                                              <tr>
                                                <td>2.</td>
                                                <td><div align="center"><input type="text" name="namaBersama2" /></div></td>
                                                <td><div align="left"><input type="text" name="nostafBersama2"  size="75%" /></div></td>
                                              </tr>
                                               <tr >
                                                  <td>3.</td>
                                                  <td><div align="center"><input type="text" name="namaBersama3" /></div></td>
                                                  <td><input type="text" name="nostafBersama3" size="75%" /></td>
                                                </tr>
                                            </table>
                                        
                                    
                                  <br />
                                * Sekiranya perjalanan melebihi 240 km sehala, saya bersetuju untuk dibayar
                                    tambang gantian mengikut kadar tambang keretapi/kapal terbang.
                               <br />
                               </asp:Panel>
                            
                        </div>

                      
            </asp:Panel>
    </div>
    <div class="modal-footer">
         <button type="button" class="btn btn-secondary btnSimpan">Simpan</button>
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    </div>
    </div>

    </div>
</div>

     <!-- Modal -->
     <div class="modal fade" id="NotifyModal" role="dialog" tabindex="-1" aria-hidden="true">
         <div class="modal-dialog" role="document">
             <!-- Modal content-->
             <div class="modal-content">
                 <div class="modal-header">
                     <h5 class="modal-title" id="lblNotify">Makluman</h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                         <span aria-hidden="true">&times;</span>
                     </button>
                 </div>
                 <div class="modal-body">
                     <p id="notify"></p>
                 </div>
                 <div class="modal-footer">
                     <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                 </div>
             </div>
         </div>
     </div>


     <!--modal message-->
     <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
         <div class="modal-dialog" role="document">
             <div class="modal-content">
                 <div class="modal-header">
                     <h5 class="modal-title" id="exampleModalLabel">Pengesahan</h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                         <span aria-hidden="true">&times;</span>
                     </button>
                 </div>
                 <div class="modal-body">
                 </div>
                 <div class="modal-footer">
                     <button type="button" class="btn btn-danger btnTidak"
                         data-dismiss="modal">
                         Tidak</button>
                     <button type="button" class="btn btn-secondary btnYA" data-toggle="modal"
                         data-target="#ModulForm" data-dismiss="modal">
                         Ya</button>
                 </div>
             </div>
         </div>
     </div>


    <div class="modal fade" id="PilihStaf" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalCenter">Pilih Staf Yang Kongsi Bilik</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblDataSenarai_trans" class="table table-striped" style="width: 99%">
                                <thead>
                                    <tr>
                                        <th scope="col">No. Staf</th>
                                        <th scope="col">Nama</th>
                                        <th scope="col">PTJ</th> 
                                        <th scope="col">Tindakan</th> 
                                    </tr>
                                </thead>
                                <tbody id="tableID_Senarai_trans">
                                </tbody>                                                                         
                               </table>
                                 <div class="modal-footer">
                                       <%-- <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>--%>
                                        <button type="button" runat="server" id="lbtnSimStafAK" class="btn btn-secondary btnSimpanST" data-dismiss="modal"> Simpan</button>
                                 </div>
                        </div>
                    </div>                  
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="SenaraiStaf" tabindex="-1" role="dialog"
      aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title" id="centerTitle">Senarai Staf Untuk Arahan Kerja</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>                    
              <div class="modal-body">
                  <div class="col-md-12">
                      <div class="transaction-table table-responsive">
                          <table id="tblDataSenAK_trans" CssClass="table table-striped" style="width: 99%">
                              <thead>
                                  <tr>
                                      <th scope="col">No. Staf</th>
                                      <th scope="col">Nama</th>
                                      <th scope="col">PTJ</th>  
                                      <th scope="col">Tindakan</th> 
                                  </tr>
                              </thead>
                              <tbody id="tableID_SenAK_trans">
                                <%--  <tr style="display: none; width: 100%" class="table-list">
                                      
                                      <td style="width: 10%">
                                          <label id="lblNoStaf2" name="lblNoStaf2" class="lblNoStaf2"></label>
                                          <input type ="hidden" class = "lblNoStaf2" value=""/>
                                      </td>
                                      <td style="width: 10%">
                                          <label id="lblNama2" name="lblNama2" class="lblNama2"></label>
                                      </td>
                                      <td style="width: 10%">
                                          <label id="lblPtj2" name="lblPtj2" class="lblPtj2"></label>
                                      </td>
                                     
                                      <td style="width: 5%">
                                          <button id="Button1" runat="server" class="btn btnView" type="button" style="color: blue" data-dismiss="modal">
                                              <i class="fa fa-edit"></i>
                                          </button>
                                      </td>
                                  </tr>--%>
                              </tbody>

                          </table>

                     </div>
                  </div>                  
              </div>
          </div>
      </div>
  </div>

  


    <script type="text/javascript">
        var curNumObject = 0;
        var bilKenyataan = 0;
        var bilKenyataan = 0;
        var tbl = null
        var tbl2 = null
        var tblCariStaf = null;
        var shouldPop = true;
        var isClicked = false;
        const dateInput = document.getElementById('tkhMohonCL');
        document.getElementById("tkhMohonCL").disabled = true;
        var kongsi = $('.kongsi-bilik')
        kongsi = false;

        var searchQuery = "";
        var oldSearchQuery = "";       
        //var tableID = "#tblData";
        var tableID_Senarai = "#tblDataSenarai_trans";


        // ✅ Using the visitor's timezone
        dateInput.value = formatDate();

        function formatDate(date = new Date()) {
            return [

                date.getFullYear(),
                padTo2Digits(date.getMonth() + 1),
                padTo2Digits(date.getDate()),
            ].join('-');
        }

        function padTo2Digits(num) {
            return num.toString().padStart(2, '0');
        }

        function ShowPopup(elm) {

            if (elm == "1") {
                $('#permohonan').modal('toggle');


            }
            else if (elm == "2") {
                console.log("1872- mcm mn ni")
                $(".modal-body div").val("");
                $('#SenaraiPermohonan').modal('toggle');

            }
        }

        $(document).ready(function () {
            getDataPeribadi();

            $('#ddlStaf').dropdown({
                fullTextSearch: false,
                onChange: function () {   //function bila klik ddlstaf.pilih nama staf then auto load maklumat staf.
                    getDataPeribadi($(this).val())  //baca value bila pilih nama pada ddlStaf selection
                },
                apiSettings: {
                    url: 'MohonTuntutan_WS.asmx/fnCariStaf?q={query}',
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
                            $(objItem).append($('<div class="item" data-value="' + option.StafNo + '">').html(option.MS01_Nama));
                        });

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        $(obj).dropdown('show');

                    }
                }
            });

            //add checking
            $('#chckMula').on('click', async function () {
                console.log("list_chckMula")
                var checkboxes = $('.list_chckMula');
                var chckMula = $(this).prop('checked');

                // Disable or enable chckTmt checkboxes based on the state of chckMula
                if (chckMula) {
                    $('#chckTamat').prop('disabled', true);
                } else {
                    $('#chckTamat').prop('disabled', false);
                }
            })
            $('.list_chckTamat').on('click', async function () {
                var checkboxes = $('.list_chckTamat');
                var chckTamat = $(this).prop('checked');

                // Disable or enable chckTmt checkboxes based on the state of chckMula
                if (chckTamat) {
                    $('#chckMula').prop('disabled', true);
                } else {
                    $('#chckMula').prop('disabled', false);
                }
            })
        });



        $('.btnSearch').click(async function () {
            isClicked = true;
            tbl.ajax.reload();
        })


        $(document).ready(function () {
            console.log("818")

            getDataPeribadi();
            //getHadMinPendahuluan();
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
                },
                "ajax": {
                    "url": "MohonTuntutan_WS.asmx/LoadOrderRecord_PermohonanSendiri",
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        //var data = JSON.parse(json.d);
                        //console.log(data.Payload);
                        return JSON.parse(json.d);
                    },
                    data: function () {
                        var startDate = $('#txtTarikhStart').val()
                        var endDate = $('#txtTarikhEnd').val()
                        return JSON.stringify({
                            category_filter: $('#categoryFilter').val(),
                            isClicked: isClicked,
                            tkhMula: startDate,
                            tkhTamat: endDate,
                            staffP: $('#txtNoPekerja').val()
                    //staffP: '<%'=Session("ssusrID")%>'

                        })
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
                        $('#Permohonan').click();
                        rowClickHandler(data);
                    });

                },
                "columns": [
                    {
                        "data": "No_Tuntutan",
                        render: function (data, type, row, meta) {

                            if (type !== "display") {
                                return data;
                            }

                            var link = `<td style="width: 10%" >
                               <label  name="noTuntutan"  value="${data}" >${data}</label>
                                           <input type ="hidden" class = "noTuntutan" value="${data}"/>
                                       </td>`;
                            return link;
                        }
                    },
                    { "data": "Tarikh_Mohon" },
                    { "data": "NamaPemohon" },
                    { "data": "Tujuan_Tuntutan" },
                    {
                        "data": "Jum_Pendahuluan",
                        render: function (data, type, full) {
                            return parseFloat(data).toFixed(2);
                        }

                    },
                    { "data": "Butiran" }

                ],
                "columnDefs": [
                    { "targets": [4], "className": "right-align" }
                ],
            });
        });

        $(document).ready(function () {
            console.log("525")
            tbl2 = $("#tblListPend").DataTable({   //tbl load senarai permohonan PP
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
                },
                "ajax": {
                    "url": "MohonTuntutan_WS.asmx/LoadRecord_PermohonanPP",
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        //var data = JSON.parse(json.d);
                        //console.log(data.Payload);
                        return JSON.parse(json.d);
                    },

                    data: function () {
                        return JSON.stringify({
                        //staffP: '<%=Session("ssusrID")%>'
                            staffP: $('#txtNoPekerja').val()
                        })
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
                        console.log("data1");

                        rowClickHandlerKeperluan(data);
                    });

                },
                "columns": [
                    {
                        "data": "No_Pendahuluan",
                        'targets': 0,
                        'searchable': false,
                        'orderable': false,
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;

                            }
                            var checked = "";

                            var link = ` <input type="checkbox" data-nomohon="${data}" onclick="return setActiveNoPendahuluan(this);" name="checkPP" class = "checkPP" id="checkPP" class="checkSingle" ${checked} />`;
                            return link;
                        }
                    },
                    {
                        "data": "No_Pendahuluan",
                        render: function (data, type, row, meta) {

                            if (type !== "display") {
                                return data;
                            }

                            var link = `<td style="width: 10%" >
                      <label  name="noPermohonan1"  value="${data}" >${data}</label>
                        <input type ="hidden" class = "noPermohonan1" value="${data}"/>
                        </td>`;
                            return link;
                        }
                    },
                    {
                        "data": "Tujuan"
                    },
                    {
                        "data": "Jum_Lulus",
                        render: function (data, type, full) {
                            return parseFloat(data).toFixed(2);
                        }
                    },
                    { "data": "No_Baucar" }


                ],
                "columnDefs": [
                    { "targets": [3], "className": "right-align" }
                ],
            });
        });


        function setActiveNoPendahuluan(obj) {
            $('#selectedNoPendahuluan').val($(obj).data("nomohon"));
        }

        function rowClickHandlerKeperluan(orderDetail) {

            $('#selectedNoPendahuluan').val(orderDetail.No_Pendahuluan);
            $('#selectedJumlah').val(orderDetail.Jum_Lulus);
            console.log("1876")
            console.log(orderDetail.No_Pendahuluan);

        }

        $(function () {
            console.log("1869")
            //$("#listInfo").tabs({
            //    disabled: [0, 1]
            //});

            //$('#listInfo').data('disabled.tabs', [2]);
            // $('#listInfo').data('disabled.tabs', [2,4]);
        });

        function rowClickHandler(orderDetail) {
            //clearAllRows();
            console.log("rowclick")
            console.log(orderDetail.Nopemohon);
            $('#SenaraiPermohonan').modal('toggle')
            getDataPeribadiPemohon(orderDetail.Nopemohon)


            $('#noPermohonan').val(orderDetail.No_Tuntutan)
            $('#hidPtjPemohon').val(orderDetail.PTj)
            $('#ddlBulan').val(orderDetail.Bulan_Tuntut)
            $('#ddlTahun').val(orderDetail.Tahun_Tuntut)
            $('#txtTujuan').val(orderDetail.Tujuan_Tuntutan)
            $('#tkhMohon').val(orderDetail.Tarikh_Mohon)
            $('#selectedNoPendahuluan').val(orderDetail.No_Pendahuluan)
            $('#selectedJumlah').val(orderDetail.Jum_Pendahuluan)
            console.log("1947")
            console.log(orderDetail.No_Pendahuluan)
            //ni digunakan untuk reload semula datatable  tblListPend n check nopendahuluan yang telah disimpan
            $('#tblListPend > tbody > tr').each(function (ind, obj) {
                $row = $(obj);
                $checkBox = $row.eq("0").find("input");
                console.log($checkBox.data("nomohon"))
                if ($checkBox.data("nomohon") === $('#selectedNoPendahuluan').val()) {
                    $checkBox.prop("checked", true);
                    console.log("masuk check true")
                } else {
                    $checkBox.prop("checked", false);
                    console.log("masuk check false")
                }
            })


            var newId = $('#ddlKumpWang')
            var ddlKumpWang = $('#ddlKumpWang')
            var ddlSearch = $('#ddlKumpWang')
            var ddlText = $('#ddlKumpWang')
            var selectObj_KumpWang = $('#ddlKumpWang')
            $(ddlKumpWang).dropdown('set selected', orderDetail.Kod_Kump_Wang);
            selectObj_KumpWang.append("<option value = '" + orderDetail.Kod_Kump_Wang + "'>" + orderDetail.colKW + "</option>")

            var newId = $('#ddlOperasi')
            var ddlKO = $('#ddlOperasi')
            var ddlSearch = $('#ddlOperasi')
            var ddlText = $('#ddlOperasi')
            var selectObj_ddlKO = $('#ddlOperasi')
            $(ddlKO).dropdown('set selected', orderDetail.Kod_Operasi);
            selectObj_ddlKO.append("<option value = '" + orderDetail.Kod_Operasi + "'>" + orderDetail.colKO + "</option>")

            var newId = $('#ddlProjek')
            var ddlKP = $('#ddlProjek')
            var ddlSearch = $('#ddlProjek')
            var ddlText = $('#ddlProjek')
            var selectObj_ddlKP = $('#ddlProjek')
            $(ddlKP).dropdown('set selected', orderDetail.Kod_Projek);
            selectObj_ddlKP.append("<option value = '" + orderDetail.Kod_Projek + "'>" + orderDetail.colKp + "</option>")

            var newId = $('#ddlPTJ')
            var ddlKPtj = $('#ddlPTJ')
            var ddlSearch = $('#ddlPTJ')
            var ddlText = $('#ddlPTJ')
            var selectObj_ddlKPtj = $('#ddlPTJ')
            $(ddlKPtj).dropdown('set selected', orderDetail.Kod_PTJ);
            selectObj_ddlKPtj.append("<option value = '" + orderDetail.Kod_PTJ + "'>" + orderDetail.ButiranPTJ + "</option>")
        }





        function btnAddrowHandler() {

        }

        // Get the current year
        const currentYear = new Date().getFullYear();

        // Calculate the last year (current year - 1)
        const lastYear = currentYear - 1;

        // Get a reference to the select element for years
        const ddlTahun = document.getElementById("ddlTahun");

        // Create option elements for the current year and last year
        const currentYearOption = new Option(currentYear, currentYear);
        const lastYearOption = new Option(lastYear, lastYear);

        // Append the option elements to the select element
        ddlTahun.appendChild(currentYearOption);
        ddlTahun.appendChild(lastYearOption);

        // Get a reference to the select element
        const selectElement = document.getElementById("ddlBulan");

        // Array of month names
        const monthNames = [
            "Januari", "Februari", "March", "April", "Mei", "Jun",
            "Julai", "Ogos", "September", "Oktober", "November", "December"
        ];

        // Create option elements for each month and append them to the select element
        monthNames.forEach((month, index) => {
            const option = new Option(month, index + 1);
            selectElement.appendChild(option);
        });

        function openCalendar() {
            var tarikhInput = document.getElementById("tarikh");
            tarikhInput.click(); // Simulate a click on the date input field to open the calendar popup
        }




        document.addEventListener("DOMContentLoaded", function () {
            const tabs = document.querySelectorAll('.nav-link');
            const tabContents = document.querySelectorAll('.tab-pane');

            tabs.forEach(function (tab, index) {
                tab.addEventListener('click', function () {
                    //// Hide all tab contents
                    tabContents.forEach(function (content) {
                        content.classList.remove('show', 'active');
                    });

                    $('.nav-link.active').removeClass("active");
                    tab.classList.add("active");

                    // Show the selected tab content
                    tabContents[index].classList.add('show', 'active');
                });
            });
        });


        function SaveSucces() {
            $('#MessageModal').modal('toggle');

        }


        $('.btnPapar').click(async function () {
            tbl.ajax.reload();
        });


        // Populate dropdowns with hours and minutes
        const hoursDropdowns = document.querySelectorAll('[id^="hours-"]');
        const minutesDropdowns = document.querySelectorAll('[id^="minutes-"]');

        for (let i = 0; i <= 12; i++) {
            const option = document.createElement('option');
            option.value = i;
            option.textContent = i < 10 ? `0${i}` : i;

            hoursDropdowns.forEach(dropdown => {
                dropdown.appendChild(option.cloneNode(true));
            });
        }

        for (let i = 0; i < 60; i++) {
            const option = document.createElement('option');
            option.value = i;
            option.textContent = i < 10 ? `0${i}` : i;

            minutesDropdowns.forEach(dropdown => {
                dropdown.appendChild(option.cloneNode(true));
            });
        }



        $(function () {
            $('.btnAddRow-tabK.One').click();
        });

        $('.btnAddRow-tabK').click(async function () {

            var totalClone = $(this).data("val");
            await SetDataKenyataanKepadaRows(totalClone);

        });


        //tuk elaun Perjalanan
        $(function () {
            $('.btnAddRow_tabEP.One').click();
        });

        $('.btnAddRow_tabEP').click(async function () {

            var totalClone = $(this).data("val");

            //await AddRow_tabEP(totalClone);
            await SetDataDataElaunPjlnRows(totalClone);
        });



        //function AddRoe bagi tbl Pengangkutan Awam
        $(function () {
            $('.btnAddRow-tabPA.One').click();
        });

        $('.btnAddRow-tabPA').click(async function () {

            var totalClone = $(this).data("val");
            //await AddRow_tabEP(totalClone);
            console.log("btnAddRow-tabPA")
            console.log(totalClone)
            await SetDataDataKenderaanAwam(totalClone);
            //await AddRow_tabPA(totalClone);
        });





        //function AddRow bagi tbl Elaun Makan
        $(function () {
            $('.btnAddRow-tabElaunMkn.One').click();
        });

        $('.btnAddRow-tabElaunMkn').click(async function () {
            console.log("Add ROW")
            var totalClone = $(this).data("val");
            await SetDataElaunMakanKepadaRows(totalClone);
            //await AddRow_tabElaunMkn(totalClone);
        });

        //async function AddRow_tabElaunMkn(totalClone, objOrder) {
        //    var counter = 1;
        //    var table = $('#tblElaunMkn');

        //    if (objOrder !== null && objOrder !== undefined) {
        //        //totalClone = objOrder.Payload.OrderDetails.length;
        //        totalClone = objOrder.Payload.length;

        //    }

        //    while (counter <= totalClone) {

        //        curNumObject += 1;

        //        //var newId_coa = "ddlCOA" + curNumObject;
        //        var newId_hari = "txtbilEL" + curNumObject;
        //        var newId_bil = "form-control-hidIDEL" + curNumObject; //create new object pada table
        //        var newId_TugasEL = "ddlJenisTugasElaunMkn" + curNumObject;
        //        var newId_lblTugas = "label-JenisTugasElaunMkn-list" + curNumObject;
        //        var newId_hidTugas = "Hid-JenisTugasElaunMkn-list" + curNumObject;
        //        var newId_pagi = "chckPagi" + curNumObject;
        //        var newId_tghari = "chckTghari" + curNumObject;
        //        var newId_petand = "chckPtg" + curNumObject;
        //        var newId_tempatEL = "ddlTmptElaunMkn" + curNumObject;
        //        var newId_lblTempatEL = "lblJnstempatElaunMkn" + curNumObject;
        //        var newId_hidTempatEL = "HidJnstempatElaunMkn" + curNumObject;
        //        var newId_hargaEL = "txtHargaEL-list" + curNumObject;
        //        var newId_JumlahEL = "txtJumlahEL" + curNumObject;


        //        var row = $('#tblElaunMkn tbody>tr:first').clone();

        //        //var bilEL = $(row).find(".txtbilEL").attr("id", newId_bil);
        //        var bilHari = $(row).find(".txtbilEL").attr("id", newId_hari);
        //        var jenisTugasEL = $(row).find(".JenisTugasElaunMkn-list").attr("id", newId_TugasEL);
        //        var lblTugasEL = $(row).find(".label-JenisTugasElaunMkn-list").attr("id", newId_lblTugas);
        //        var hidTugasEL = $(row).find(".Hid-JenisTugasElaunMkn-list").attr("id", newId_hidTugas);
        //        var DengResit = $(row).find(".chckPagi").attr("id", newId_pagi);
        //        var TanpaResit = $(row).find(".chckTghari").attr("id", newId_tghari);
        //        var noResit = $(row).find(".chckPtg").attr("id", newId_petand);
        //        var jenisTempatEL = $(row).find(".JnstempatElaunMkn-list").attr("id", newId_tempatEL);
        //        var lblTempatEL = $(row).find(".label-JnstempatElaunMkn-list").attr("id", newId_lblTempatEL);
        //        var hidTempatEL = $(row).find(".Hid-JnstempatElaunMkn-list").attr("id", newId_hidTempatEL);
        //        var AmaunEL = $(row).find(".txtHargaEL-list").attr("id", newId_hargaEL);
        //        var JumlahEL = $(row).find(".txtJumlahEL").attr("id", newId_JumlahEL)

        //        var $objBil = $(row).find(".form-control-hidIDEL");
        //        $objBil.attr("id", newId_bil);

        //        row.attr("style", "");

        //        var val = "";

        //        $objBil.val($('#tblElaunMkn tbody').find(".form-control-hidIDEL").length);               

        //        $('#tblElaunMkn tbody').append(row);                

        //        counter += 1;

        //        generateDropdown_list("#" + newId_TugasEL, "MohonTuntutan_WS.asmx/GetTugasElaunMkn")
        //        generateDropdown_list("#" + newId_tempatEL, "MohonTuntutan_WS.asmx/GetTempatTblElaunMkn") 


        //        //ni tuk code hapus, perlu masukkan code ni untuk recalculate bil
        //        //var curBil = 1;
        //        //$('#tblKenyataan tbody').find(".list_Bil").each(function (ind, obj) {
        //        //    if (ind === 0) {
        //        //        return;
        //        //    }

        //        //    $(obj).val(curBil);
        //        //    curBil += 1;
        //        //})




        //    }
        //}

        //function addrow bagi tab lojing
        $(function () {
            $('.btnAddRow-tabLojing.One').click();
        });

        $('.btnAddRow-tabLojing').click(async function () {

            var totalClone = $(this).data("val");
            await AddRow_tabLojing(totalClone);
        });


        async function AddRow_tabLojing(totalClone, objOrder) {
            var counter = 1;
            var table = $('#tblLojing');

            if (objOrder !== null && objOrder !== undefined) {
                //totalClone = objOrder.Payload.OrderDetails.length;
                totalClone = objOrder.Payload.length;

            }

            while (counter <= totalClone) {

                curNumObject += 1;

                //var newId_coa = "ddlCOA" + curNumObject;
                var newId_bilLojing = "txtBiltblLojing" + curNumObject; //create new object pada table
                var newId_jnstugasLojing = "ddlJenisTugastblLojing" + curNumObject;
                var newId_lbljnstugasLojing = "lblJenisTugastblLojing" + curNumObject;
                var newId_hidjnstugasLojing = "HidJenisTugastblLojing" + curNumObject;
                var newId_tempatLojing = "ddlTmpttblLojing" + curNumObject;
                var newId_lbltempatLojing = "lblJnstempattblLojing" + curNumObject;
                var newId_hidtempatLojing = "HidJnstempattblLojing" + curNumObject;
                var newId_resitLojing = "resittblLojing" + curNumObject;
                var newId_lblresitLojing = "lblresittblLojing" + curNumObject;
                var newId_elaunLojing = "elauntblLojing" + curNumObject;
                var newId_lblelaunLojing = "lblelauntblLojing" + curNumObject;
                var newId_hariLojing = "haritblLojing" + curNumObject;
                var newId_lblhariLojing = "lblharitblLojing" + curNumObject;
                var newId_amaunLojing = "amauntblLojing" + curNumObject;
                var newId_lblamaunLojing = "lblamauntblLojing" + curNumObject;


                var row = $('#tblLojing tbody>tr:first').clone();

                // var dropdown5 = $(row).find(".COA-list").attr("id", newId_coa);
                var bilLojing = $(row).find(".input-md-txtBiltblLojing").attr("id", newId_bilLojing).val($(".input-md-txtBiltblLojing").length);
                //var bilLojing = $(row).find(".txtBiltblLojing").attr("id", newId_bilLojing);
                var jnstugasLojing = $(row).find(".ddlJenisTugastblLojingA-list").attr("id", newId_jnstugasLojing);
                var lbljnstugasLojing = $(row).find(".form-control lblJenisTugastblLojing").attr("id", newId_lbljnstugasLojing);
                var hidjnstugasLojing = $(row).find(".HidJenisTugastblLojing").attr("id", newId_hidjnstugasLojing);
                var tempatLojing = $(row).find(".ddlTmpttblLojingA-list").attr("id", newId_tempatLojing);
                var lbltempatLojing = $(row).find(".lblJnstempattblLojing").attr("id", newId_lbltempatLojing);
                var hidtempatLojing = $(row).find(".HidJnstempattblLojing").attr("id", newId_hidtempatLojing);
                var resitLojing = $(row).find(".resittblLojing").attr("id", newId_resitLojing);
                var lblresitLojing = $(row).find(".lblresittblLojing").attr("id", newId_lblresitLojing);
                var elaunLojing = $(row).find(".elauntblLojing").attr("id", newId_elaunLojing);
                var lblelaunLojing = $(row).find(".lblelauntblLojing").attr("id", newId_lblelaunLojing);
                var hariLojing = $(row).find(".haritblLojing").attr("id", newId_hariLojing);
                var lblelaunLojing = $(row).find(".lblharitblLojing").attr("id", newId_lblhariLojing);
                var amaunLojing = $(row).find(".amauntblLojing").attr("id", newId_amaunLojing);
                var lblamaunLojing = $(row).find(".lblamauntblLojing").attr("id", newId_lblamaunLojing);


                row.attr("style", "");
                var val = "";
                //$objBil.val($('#tblLojing tbody').find(".txtBiltblLojing").length);        

                $('#tblLojing tbody').append(row);

                generateDropdown_list("#" + newId_jnstugasLojing, "MohonTuntutan_WS.asmx/GetTugasElaunMknLojing")
                generateDropdown_list("#" + newId_tempatLojing, "MohonTuntutan_WS.asmx/GetTempatTblLojing")


                counter += 1;
            }
        }


        //function addrow bagi tab SEWA HOTEL
        $(function () {
            $('.btnAddRow-tabHotel.One').click()
            
        });

        $('.btnAddRow-tabHotel').click(async function () {

            var totalClone = $(this).data("val");
            //await AddRow_tabEP(totalClone);
            await SetDataSewaHotel(totalClone);
            //await AddRow_tabPA(totalClone);
        });

        //async function AddRow_tabHotel(totalClone, objOrder) {
        //    var counter = 1;
        //    var table = $('#tblSewaHotel');

        //    if (objOrder !== null && objOrder !== undefined) {
        //        //totalClone = objOrder.Payload.OrderDetails.length;
        //        totalClone = objOrder.Payload.length;

        //    }

        //    while (counter <= totalClone) {

        //        curNumObject += 1;

        //        //var newId_coa = "ddlCOA" + curNumObject;
        //        var newId_bilHotel = "txtBiltblHotel" + curNumObject; //create new object pada table
        //        var newId_jnstugasHotel = "ddlJenisTugastblHotel" + curNumObject;
        //        var newId_lbljnstugasHotel = "lblJenisTugastblHotel" + curNumObject;
        //        var newId_hidjnstugasHotel = "HidJenisTugastblHotel" + curNumObject;
        //        var newId_tempatHotel = "ddlTmpttblHotel" + curNumObject;
        //        var newId_lbltempatHotel = "lblJnstempattblHotel" + curNumObject;
        //        var newId_hidtempatHotel = "HidJnstempattblHotel" + curNumObject;
        //        var newId_resitHotel = "resittblHotel" + curNumObject;
        //        var newId_lblresitHotel = "lblresittblHotel" + curNumObject;
        //        var newId_elaunHotel = "elauntblHotel" + curNumObject;
        //        var newId_lblelaunHotel = "lblelauntblHotel" + curNumObject;
        //        var newId_hariHotel = "haritblHotel" + curNumObject;
        //        var newId_lblhariHotel = "lblharitblHotel" + curNumObject;
        //        var newId_amaunHotel = "amauntblHotel" + curNumObject;
        //        var newId_lblamaunHotel = "lblamauntblHotel" + curNumObject;



        //        var row = $('#tblSewaHotel tbody>tr:first').clone();

        //        // var dropdown5 = $(row).find(".COA-list").attr("id", newId_coa);
        //        var bilHotel = $(row).find(".input-md-txtBiltblHotel-list").attr("id", newId_bilHotel).val($(".input-md-txtBiltblHotel-list").length);
        //        var jnstugasHotel = $(row).find(".ddlJenisTugastblHotel-list").attr("id", newId_jnstugasHotel);
        //        var lbljnstugasHotel = $(row).find(".label-JenisTugastblHotel-list").attr("id", newId_lbljnstugasHotel);
        //        var hidjnstugasHotel = $(row).find(".Hid-JenisTugastblHotel-list").attr("id", newId_hidjnstugasHotel);
        //        var tempatHotel = $(row).find(".ddltempattblHotel-list").attr("id", newId_tempatHotel);
        //        var lbltempatHotel = $(row).find(".lblJnstempattblHotel").attr("id", newId_lbltempatHotel);
        //        var hidtempatHotel = $(row).find(".Hid-JnstempattblHotel-list").attr("id", newId_hidtempatHotel);
        //        var resitHotel = $(row).find(".resittblHotel-list").attr("id", newId_resitHotel);
        //        var lblresitHotel = $(row).find(".lblresittblHotel-list").attr("id", newId_lblresitHotel);
        //        var elaunHotel = $(row).find(".elauntblHotel-list").attr("id", newId_elaunHotel);
        //        var lblelaunHotel = $(row).find(".lblelauntblHotel-list").attr("id", newId_lblelaunHotel);
        //        var hariHotel = $(row).find(".haritblHotel-list").attr("id", newId_hariHotel);
        //        var lblelaunHotel = $(row).find(".lblharitblHotel-list").attr("id", newId_lblhariHotel);
        //        var amaunHotel = $(row).find(".input-md amauntblHotel-list").attr("id", newId_amaunHotel);
        //        var lblamaunHotel = $(row).find(".lblamauntblHotel-list").attr("id", newId_lblamaunHotel);


        //        row.attr("style", "");
        //        var val = "";

        //        $('#tblSewaHotel tbody').append(row);

        //        generateDropdown_list("#" + newId_jnstugasHotel, "MohonTuntutan_WS.asmx/GetJenisTugasTblSewaHotel")
        //        generateDropdown_list("#" + newId_tempatHotel, "MohonTuntutan_WS.asmx/GetTempatTblHotel")



        //        counter += 1;
        //    }
        //}





        //function addrow bagi tuk tab pelbagai
        $(function () {
            $('.btnAddRow-tabPelbagai.One').click();
        });

        $('.btnAddRow-tabPelbagai').click(async function () {

            var totalClone = $(this).data("val");
            await SetDataPelbagaiRows(totalClone);
            // await AddRow_tabPelbagai(totalClone);
        });


        async function clearAlltblPelbagai() {
            console.log("masuk clearAlltblPelbagai")
            $('#tblPelbagai' + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })

        }


        function getDataPeribadi() {
            //Cara Pertama
            console.log("load info pemohon 2587")
            var nostaf = $('#ddlStaf').val()

            if (nostaf === null) {

                nostaf = '<%=Session("ssusrID")%>'

            }

            else {

                nostaf = $('#ddlStaf').val();
            }

            fetch('MohonTuntutan_WS.asmx/GetUserInfo', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                         //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                body: JSON.stringify({ nostaf: nostaf })
            })
                .then(response => response.json())
                .then(data => setDataPeribadi(data.d))


            ////Cara Kedua
                 <%--var param = {
                     nostaf: '<%=Session("ssusrID")%>'
                 }

                 $.ajax({
                     url: 'Pendahuluan_WS.asmx/GetUserInfo',
                     method: 'POST',
                     data: JSON.stringify(param),
                     dataType: 'json',
                     contentType: 'application/json; charset=utf-8',
                     success: function (data) {
                         setDataPeribadi(data.d);
                         //alert(resolve(data.d));
                     },
                     error: function (xhr, textStatus, errorThrown) {
                         console.error('Error:', errorThrown);
                         reject(false);
                     }

                 });--%>
        }

        function setDataPeribadi(data) {
            data = JSON.parse(data);
            if (data.Nostaf === "") {
               // alert("Tiada data");
                return false;
            }

            $('#txtNamaP').val(data[0].Param1);
            $('#txtNoPekerja').val(data[0].StafNo);
            $('#txtJawatan').val(data[0].Param3);
            $('#txtGredGaji').val(data[0].Param6);
            $('#txtPejabat').val(data[0].Param5);
            $('#txtKump').val(data[0].Param4);
            $('#txtTel').val(data[0].Param7);
            $('#hidPtjPemohon').val(data[0].Param2)
            $('#txtNama').val(data[0].Param1);
            $('#txtNoStaf').val(data[0].StafNo);
            $('#tblListPend').DataTable().ajax.reload();
            <%--hadGaji = data[0].GredGaji;
            console.log($('#hidPtjPemohon').val());
             //$('#<%'=txtMemangku.ClientID%>').val(data[0].Param3);--%>
        }

        function generateDropdown(id, url, param, fn) {

            var inParam = "";

            if (param !== null && param !== undefined) {
                inParam = param;
            }
            $('#' + id).dropdown({
                fullTextSearch: false,
                onChange: function () {
                    if (fn !== null && fn !== undefined) {
                        return fn();
                    }
                },
                apiSettings: {
                    url: url + '?q={query}&' + inParam,
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

                        var listOptions = JSON.parse(response.d);

                        // Add new options to dropdown
                        if (listOptions.length === 0) {
                            $(objItem).html('<div class="message">Rekod Tidak Dijumpai.</div>');
                            return false;
                        }

                       
                        console.log(objItem)
                        $.each(listOptions, function (index, option) {
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                        });


                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        $(obj).dropdown('show');
                    }
                }
            });
        }

        $(document).ready(function () {
            generateDropdown("ddlProjek", "MohonTuntutan_WS.asmx/GetJenisProjek")
            generateDropdown("ddlPTJ", "MohonTuntutan_WS.asmx/GetKodPtj")
            generateDropdown("ddlOperasi", "MohonTuntutan_WS.asmx/GetJenisOperasi")
            generateDropdown("ddlKumpWang", "MohonTuntutan_WS.asmx/GetJenisKumpWang")

        });


     
        function generateDropdown_list(id, url, param, fn) {
          
            var inParam = "";

            if (param !== null && param !== undefined) {
                inParam = param;
            }
            $(id).dropdown({
                fullTextSearch: false,
                onChange: function (value, text, obj) {
                    if (fn !== null && fn !== undefined) {
                        return fn(value, text, obj);
                    }
                },
                apiSettings: {
                    url: url + '?q={query}&' + inParam,
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        var defaultParam = { q: settings.urlData.query };
                        var testParam = {};
                     
                        if (typeof param === "function") {
                            testParam = param();
                        } else {
                            testParam = param;
                        }

                        if (testParam !== null && testParam !== undefined) {
                            $.extend(defaultParam, testParam);
                        }

                        settings.data = JSON.stringify(defaultParam);
                        //settings.data = JSON.stringify({ q: param });
                        //searchQuery = settings.urlData.query;
                        console.log("a +" + settings.data)
                        return settings;
                    },
                    onSuccess: function (response) {
                        // Clear existing dropdown options
                        var obj = $(this);

                        var objItem = $(this).find('.menu');
                        $(objItem).html('');

                        var listOptions = JSON.parse(response.d);

                        if (listOptions.length === 0) {
                            $(objItem).html('<div class="message">Rekod Tidak Dijumpai.</div>');
                            return false;
                        }

                        $.each(listOptions, function (index, option) {
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                        });


                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        $(obj).dropdown('show');
                    }
                }
            });
        }

        function getDataPeribadiPemohon(pemohon) {
            //Cara Pertama
            console.log("getDataPeribadiPemoho-2764")
            var nostaf = pemohon
            //alert(pemohon)

            fetch('MohonTuntutan_WS.asmx/GetUserInfo', {
                method: 'POST',
                headers: {

                    'Content-Type': "application/json"
                },
                     //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                body: JSON.stringify({ nostaf: pemohon })
            })
                .then(response => response.json())
                .then(data => setDataPeribadi(data.d))
        }

          // console.log('<%=Session("ssusrID")%>')

        //tuk radioButton
        const radioButtons = document.querySelectorAll('input[name="JnsMohon"]');
        for (const radioButton of radioButtons) {
            radioButton.addEventListener('change', showSelected);
        }

        function showSelected(e) {
            if (this.checked) {
                var x = document.getElementById("cariStaf");

                ///document.querySelector('#output').TextText = `You selected ${this.value}`;
                if (this.value == "STAFLAIN") {
                    x.style.display = "inline";
                    getDataPeribadi('<%=Session("ssusrID")%>')
                }
                else {
                    x.style.display = "none";
                }
            }
        }


        //event bila klik button simpan  btnSaveInfo
        $('.btnSimpanInfo').click(async function () {
            var jumRecord = 0;
            var acceptedRecord = 0;
            console.log("2836")
            console.log($('#selectedNoPendahuluan').val())
            console.log($('#selectedJumlah').val())

            var pemohon = $('#txtNoStaf').val()
            var statusPemohon

            if ('<%=Session("ssusrID")%>' !== pemohon) {
                statusPemohon = "0"  //mohon tuk org lain
            } else {
                statusPemohon = "N"  //mohon tuk sendiri
            }
            $('#selectedJumlah').val(0.00);

            var msg = "";
            var newTuntutanDN = {
                listClaim: {
                    OrderID: $('#noPermohonan').val(),
                    StafID: pemohon,  //nama org yg login
                    Tahun: $('#ddlTahun').val(),
                    Bulan: $('#ddlBulan').val(),
                    KumpWang: $('#ddlKumpWang').val(),
                    KodOperasi: $('#ddlOperasi').val(),
                    KodPtj: $('#ddlPTJ').val(),
                    KodProjek: $('#ddlProjek').val(),
                    staPemohon: statusPemohon,
                    NoPemohon: $('#txtNoPekerja').val(),   //nama pemohon 
                    sebabLewat: $('#txtsebab').val(),
                    noPendahuluan: $('#selectedNoPendahuluan').val(),
                    jumlahBaucer: $('#selectedJumlah').val(0.00),
                    hidPtjPemohon: $('#hidPtjPemohon').val(),
                    TkhMohon: $('#tkhMohonCL').val(),

                }

            };

            console.log(newTuntutanDN);
            console.log(newTuntutanDN.listClaim.OrderID);


            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
           
            if (!confirm) {
                return
            }
            else {

                var result = JSON.parse(await ajaxSaveRecord(newTuntutanDN));
                //alert(result.Message)
                $('#orderid').val(result.Payload.OrderID)
                $('#noPermohonan').val(result.Payload.OrderID)

                //await clearAllRowsHdr();

            }

        });

        async function ajaxSaveRecord(tuntutan) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'MohonTuntutan_WS.asmx/SaveRecordTuntutan',
                    method: 'POST',
                    data: JSON.stringify(tuntutan),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var response = JSON.parse(data.d)
                        notification("Data telah disimpan");
                        resolve(data.d);
                        //alert(resolve(data.d));
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }

                })
            })
        };

        async function clearAllRowsHdr() {

            $('#noPermohonan').val("");
            $('#ddlTahun').val("");
            $('#ddlBulan').val("");
            $('#ddlKumpWang').val("");
            $('#ddlOperasi').val("");
            $('#ddlPTJ').val("");
            $('#ddlProjek').val("");

        }

        //Bila klik Tab tab-elaunPjln
        $('#tab-elaunPjln').click(async function () {

            console.log("masuk elaunPjln")
            $('#noPermohonan').val();
            var id = $('#noPermohonan').val();
            var tkhMohon1 = $('#tkhMohonCL').val();
            $('#txtMohonID3').val(id);
            $('#tkhMohon3').val(tkhMohon1);
            //loadDataKenyataan(id)

            if (id !== "") {
                clearAlltblElaunPjln();
                //BACA DETAIL JURNAL
                var recordDataElaunPjln = await AjaxGetDataElaunPjln(id);  //Baca data pada table Keperluan             
                //await clearAllRows();
                await SetDataDataElaunPjlnRows(null, recordDataElaunPjln); //setData pada table
            }

            return false;

        })

        async function AjaxGetDataElaunPjln(id) {

            try {

                const response = await fetch('MohonTuntutan_WS.asmx/GetDataFromKenyataan', {
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


        async function SetDataDataElaunPjlnRows(totalClone, objOrder) {

            var counter = 1;
            var table = $('#tblDataEP');
            var total = 0.00;
            var totalJarak;

            console.log("masuk  SetDataDataElaunPjlnRows  tblDataEP ")
            if (objOrder !== null && objOrder !== undefined) {   //semak berapa object yang ada
                totalClone = objOrder.Payload.length;
            }


            while (counter <= totalClone) {
                curNumObject += 1;
                console.log("masuk sii")

                var newId_kiraKilo = "txtKiraKilometer" + curNumObject; //create new object pada table
                var newId_hidJnsKend = "hidJnsKend" + curNumObject;
                //var newId_hidKM = "hidkm" + curNumObject;
                var newId_kenderaanEP = "txtKenderaanEP" + curNumObject;
                var newId_jarakEP = "txtJumJarakEP" + curNumObject;
                var newId_kadarEP = "txtKadarEP" + curNumObject;
                var newId_jumlahEP = "txtJumlahEP" + curNumObject;
                var newId_hidNostafK = "hidNostafKend" + curNumObject;
                var newBil = "hidkm" + curNumObject;

                var row = $('#tblDataEP tbody>tr:first').clone();

                // var dropdown5 = $(row).find(".COA-list").attr("id", newId_coa);
                //var hidKM = $(row).find(".hidkm-list").attr("id", newId_hidKM);
                var txtKiraKM = $(row).find(".list-txtKiraKilometer").attr("id", newId_kiraKilo);
                var kenderaanEP = $(row).find(".list-txtKenderaanEP").attr("id", newId_kenderaanEP);
                var hidJnsKendEP = $(row).find(".hidJnsKend-list").attr("id", newId_hidJnsKend);
                var jarakEP = $(row).find(".list-txtJumJarakEP").attr("id", newId_jarakEP);
                var kadarEP = $(row).find(".list-txtKadarEP").attr("id", newId_kadarEP);
                var hidNoStafKend = $(row).find(".hidNostafKend-list").attr("id", newId_hidNostafK);
                var jumlahEP = $(row).find(".list-txtJumlahEP").attr("id", newId_jumlahEP);

                var $objBil = $(row).find(".hidkm-list");
                $objBil.attr("id", newBil);

                if (objOrder !== null && objOrder !== undefined) {
                    var obj = objOrder.Payload;


                    console.log(obj[counter - 1].jumjarak);
                    console.log(obj[counter - 1].kadarHarga);
                    console.log(obj[counter - 1].Jenis_Kenderaan);
                    console.log(obj[counter - 1].No_Kend);
                    console.log(obj[counter - 1].KM);
                    console.log(obj[counter - 1].Jenis_Kenderaan);
                    console.log(obj[counter - 1].No_Staf);
                    console.log("Next");


                    $objBil.val($('.hidkm-list').length);
                    txtKiraKM.val(obj[counter - 1].KM);
                    //hidKM.val(obj[counter - 1].jumjarak);
                    kenderaanEP.val(obj[counter - 1].No_Kend);
                    hidJnsKendEP.val(obj[counter - 1].Jenis_Kenderaan)
                    jarakEP.val(obj[counter - 1].jumjarak);
                    kadarEP.val(obj[counter - 1].kadarHarga);
                    hidNoStafKend.val(obj[counter - 1].No_Staf);

                    totalJarak = jarakEP.val() * kadarEP.val();

                    jumlahEP.val(parseFloat(totalJarak).toFixed(2));

                    total += jumlahEP.val();

                    console.log($objBil.val($('.hidkm-list').length));
                    console.log("3134");
                    $('#totalEP').val(parseFloat(total).toFixed(2));
                }
                else {
                    //$objBil.val($('.list_Bil').length);
                }

                //total += parseFloat(obj[counter - 1].Jumlah_anggaran);

                row.attr("style", "");  //style pada row

                $('#tblDataEP tbody').append(row);  //bind data start pada row yang first pada tblData2



                counter += 1;

            }


        }





        //function bila klil pada Tab-Kenyataan
        $('#tab-Kenyataan').click(async function () {
            console.log("masuk tab_Kenyataan  jjjj")
            $('#noPermohonan').val();
            var id = $('#noPermohonan').val();
            var tkhMohon1 = $('#tkhMohonCL').val();
            $('#txtMohonID').val(id);
            $('#tkhMohon2').val(tkhMohon1);

            if (id !== "") {
                clearAlltblKenyataan();
                //BACA DETAIL JURNAL
                var recordDataKenyataan = await AjaxGetDataKenyataan(id);  //Baca data pada table Keperluan             
                //await clearAllRows();
                await SetDataKenyataanKepadaRows(null, recordDataKenyataan); //setData pada table
            }

            return false;


        })

        async function AjaxGetDataKenyataan(id) {

            try {

                const response = await fetch('MohonTuntutan_WS.asmx/LoadListKenyataan', {
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

        async function clearAlltblKenyataan() {
            console.log("masuk clearAlltblKenyataan 3026 ")
            $('#tblKenyataan' + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
            //$(totalKt).val("0.00");
        }

        async function clearAlltblElaunPjln() {
            console.log("masuk clearAlltblElaunPjln 3214 ")
            $('#tblDataEP' + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
            //$(totalKt).val("0.00");

        }



        async function clearAlltblSewaHotel() {
            console.log("masuk clearAlltblSewaHotel 3242 ")
            $('#tblSewaHotel' + " > tbody > tr ").each(function (index, obj) {
                if (index > 1) {
                    obj.remove();
                }
            })

        }

        async function clearAlltblLojing() {
            console.log("masuk clearAlltblLojing 3309 ")
            $('#tblLojing' + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })

        }

        async function clearAlltblKenderaanAwam() {
            console.log("masuk clearAlltblPengankutan 3214 ")
            $('#tblTambang' + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
            //$(totalKt).val("0.00");

        }

        async function clearAlltblElaunMakan() {
            console.log("masuk clearAlltblKenyataan 3026 ")
            $('#tblElaunMkn' + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
            //$(totalKt).val("0.00");
        }

        async function SetDataKenyataanKepadaRows(totalClone, objOrder) {

            var counter = 1;
            var table = $('#tblKenyataan');
            var total = 0.00;

            console.log("masuk  SetDataKenyataanKepadaRows 3042 ")
            if (objOrder !== null && objOrder !== undefined) {   //semak berapa object yang ada
                totalClone = objOrder.Payload.length;
            }


            while (counter <= totalClone) {
                curNumObject += 1;

                var newId_checkbox1 = "checkbox1" + curNumObject; //create new object pada table
                var newId_checkbox2 = "checkbox2" + curNumObject;
                var newId_tarikh = "tkhTuntut" + curNumObject;
                var newId_hoursbertolak = "hours-bertolak" + curNumObject;
                var newId_minutesbertolak = "minutes-bertolak" + curNumObject;
                var newId_hourssampai = "hours-sampai" + curNumObject;
                var newId_minutessampai = "minutes-sampai" + curNumObject;
                var newId_checkbox3 = "checkbox3" + curNumObject;
                var newId_txtTujuan = "txtTujuan" + curNumObject;
                var newId_ddlJenInv = "ddlJenInv" + curNumObject;
                var newId_txtJarak = "txtJarak" + curNumObject;
                var newId_JnsKenderaan = "list_ddlJnsKenderaan" + curNumObject;
                var newId_NoKend = "list_ddlKenderaan" + curNumObject;
                var newId_lblNoKend = "label-jnsLKend-list" + curNumObject;
                var newId_hidNoKend = "Hid-jnsLKend-list" + curNumObject;


                var newBil = "txtBil" + curNumObject;


                var row = $('#tblKenyataan tbody>tr:first').clone();

                // var dropdown5 = $(row).find(".COA-list").attr("id", newId_coa);
                var Checkbox1 = $(row).find(".list_chckItem").attr("id", newId_checkbox1);
                var Checkbox2 = $(row).find(".list_chckMula").attr("id", newId_checkbox2);
                var tkhJalan = $(row).find(".list_tkhTuntut").attr("id", newId_tarikh);
                var hoursTolak = $(row).find(".list_ddlJamTolak").attr("id", newId_hoursbertolak);
                var minutesTolak = $(row).find(".list_ddlMinitTolak ").attr("id", newId_minutesbertolak);
                var hoursSampai = $(row).find(".list_ddlJamSampai").attr("id", newId_hourssampai);
                var minutesSampai = $(row).find(".list_ddlMinitSampai").attr("id", newId_minutessampai);
                var Checkbox3 = $(row).find(".list_chckTamat").attr("id", newId_checkbox3);
                var txtTujuan = $(row).find(".list_txtTujuan ").attr("id", newId_txtTujuan);
                //var jnsKenderaan = $(row).find(".list_ddlKenderaan").attr("id", newId_ddlJenInv);
                var txtJarak = $(row).find(".list_txtJarak").attr("id", newId_txtJarak);
                var JnsKenderaan = $(row).find(".list_ddlJnsKenderaan_list").attr("id", newId_JnsKenderaan);
                var NoDaftarK = $(row).find(".list_ddlKenderaan_list").attr("id", newId_NoKend);
                var lblNoDaftarK = $(row).find(".label-jnsLKend-list").attr("id", newId_lblNoKend);
                var hidNoDaftarK = $(row).find(".Hid-jnsLKend-list").attr("id", newId_hidNoKend);

                var $objBil = $(row).find("#txtBil");
                $objBil.attr("id", newBil);

                $('#tblKenyataan tbody').append(row);  //bind data start pada row yang first pada tblData2

                generateDropdown_list("#" + newId_JnsKenderaan, "MohonTuntutan_WS.asmx/GetJenisKenderaan", function () {
                    //alert($('#txtNoPekerja').val());
                    return { nostaf: $('#txtNoPekerja').val() };
                }, function (value, text, obj) {
                    var $parent = $(obj).closest("div.list_ddlJnsKenderaan_list");
                    var $ddlKenderaan = $($parent).siblings(".list_ddlKenderaan_list");
                    var $daftarKenderaan = $($parent).siblings(".btn-change"); 
           

                    if (value !== "02" && value !== "07") {
                        $ddlKenderaan.attr("style", "display:none;")
                        $($ddlKenderaan.find('select')).dropdown("clear");
                    } else {
                        $ddlKenderaan.attr("style", "")
                    }

                    if (value === "04") {
                        $daftarKenderaan.attr("style", "display:none;")
                    } else {
                        $daftarKenderaan.attr("style", "")
                    }
                })

                generateDropdown_list("#" + newId_NoKend, "MohonTuntutan_WS.asmx/GetDataKenderaan", function () {
                    //alert($('#txtNoPekerja').val());
                    return { nostaf: $('#txtNoPekerja').val() };
                })

               


                if (objOrder !== null && objOrder !== undefined) {
                    var obj = objOrder.Payload;

                    console.log(obj[counter - 1].Bil);
                    console.log(obj[counter - 1].Flag_Mula);
                    console.log(obj[counter - 1].Flag_Tamat);
                    console.log(obj[counter - 1].Jarak);
                    console.log(obj[counter - 1].jamTolak);
                    console.log(obj[counter - 1].minitTolak);
                    console.log(obj[counter - 1].jamSampai);
                    console.log(obj[counter - 1].minitSampai);
                    console.log(obj[counter - 1].Tarikh);
                    console.log(obj[counter - 1].No_Kend);
                    console.log("NExt");
                    //Checkbox2.val(obj[counter - 1].Flag_Muzla);

                    if (obj[counter - 1].Flag_Mula === true) {
                        console.log("masuk checked")
                        $(row).find(".list_chckMula").prop("checked", true);
                    }

                    if (obj[counter - 1].Flag_Tamat === true) {
                        console.log("masuk checked")
                        $(row).find(".list_chckTamat").prop("checked", true);
                    }

                    $objBil.val(obj[counter - 1].Bil)
                    tkhJalan.val(obj[counter - 1].Tarikh);
                    hoursTolak.val(obj[counter - 1].jamTolak);
                    minutesTolak.val(obj[counter - 1].minitTolak);
                    hoursSampai.val(obj[counter - 1].jamSampai);
                    minutesSampai.val(obj[counter - 1].minitSampai);
                    Checkbox3.val(obj[counter - 1].Flag_Tamat);
                    txtTujuan.val(obj[counter - 1].Tujuan);
                    NoDaftarK.val(obj[counter - 1].No_Kend);
                    hidNoDaftarK.val(obj[counter - 1].No_Kend);
                    txtJarak.val(obj[counter - 1].Jarak);
                    JnsKenderaan.val([counter - 1].Jenis_Kenderaan)
                 
                    var selectObj_NoDaftar = $('#' + newId_NoKend)
                    NoDaftarK.dropdown('set selected', obj[counter - 1].No_Kend)                   
                    selectObj_NoDaftar.append("<option value = '" + obj[counter - 1].No_Kend + "'>" + obj[counter - 1].No_Kend + "</option>")

                    var selectObj_JnsKenderaan = $('#' + newId_JnsKenderaan)
                    JnsKenderaan.dropdown('set selected', obj[counter - 1].Butiran);                  
                    selectObj_JnsKenderaan.append("<option value = '" + obj[counter - 1].Jenis_Kenderaan + "'>" + obj[counter - 1].Butiran + "</option>")


                } else {
                    $objBil.val($('.list_Bil').length-1);
                }

               
                row.attr("style", "");  //style pada row


                counter += 1;
            }


        }

        //event bila klik button simpan  btnSaveKenyataan
        $('#btnSaveKenyataan').click(async function () {

            id = $('#noPermohonan').val();

            var item = {
                kenyataan: {
                    OrderID: $('#noPermohonan').val(),
                    GroupKenyataan: []
                }

            }

            $('#tableID_KenyataanTuntutan tr').each(function (index, obj) {
                var staKenderaan
                var staMula
                var staTamat
                if (index > 0) {
                    console.log($(obj));
                    //alert("ce;; "+tcell)
                    console.log($(obj).find('.list_ddlKenderaan_list select'));
                    console.log($(obj).find('.list_chckMula').is(':checked'))
                    let isChecked = $(obj).find('.list_chckMula').is(':checked')
                    if (isChecked !== true) {
                        staMula = "0"
                    }
                    else {
                        staMula = "1"
                    }


                    let isCheckedTamat = $(obj).find('.list_chckTamat').is(':checked')
                    //console.log("semak"); 
                    //console.log(isChecked); 
                    if (isCheckedTamat !== true) {
                        staTamat = "0"

                    }
                    else {
                        staTamat = "1"
                    }

                    if ($(obj).find('.list_ddlKenderaan_list').val() !== "") {
                        staKenderaan = "1"
                    }
                    else {
                        staKenderaan = "0"
                    }

                    if ($(obj).find('.list_txtTujuan').val() !== "") {
                        var listKenyataan = {
                            mohonID: $('#noPermohonan').val(),
                            idbil: $(obj).find('.list_Bil').val(),
                            flagMula: staMula,
                            //flagMula: $(obj).find('.list_chckMula').val(),
                            tarikh: $(obj).find('.list_tkhTuntut').val(),
                            MasaTolakJam: $(obj).find('.list_ddlJamTolak').val(),
                            MasaTolakMinit: $(obj).find('.list_ddlMinitTolak').val(),
                            MasaSampaiJam: $(obj).find('.list_ddlJamSampai').val(),
                            MasaSampaiMinit: $(obj).find('.list_ddlMinitSampai').val(),
                            flagTamat: staTamat,
                            tujuan: $(obj).find('.list_txtTujuan').val(),
                            Jarak: $(obj).find('.list_txtJarak').val(),
                            Kenderaan: $(obj).find('.list_ddlKenderaan_list select').val(),
                            JnsKenderaan: $(obj).find('.list_ddlJnsKenderaan_list select').val(),
                            staKenderaan: staKenderaan,


                        };
                        item.kenyataan.GroupKenyataan.push(listKenyataan);
                    }
                }

            });


            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
            console.log(confirm)
            if (!confirm) {
                return
            }
            else {
                show_loader();

                var result = JSON.parse(await saveRecordItem(item));
                //alert(result.Message)
                //$('#totalKt').val(parseFloat(result.Payload.Jumlah).toFixed(2));
                //console.log($('#totalKt').val(result.Payload.Jumlah))
                close_loader();
            }
        });

        async function saveRecordItem(kenyataan) {
            console.log(kenyataan)
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'MohonTuntutan_WS.asmx/SaveRecordKenyataan',
                    method: 'POST',
                    data: JSON.stringify(kenyataan),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var response = JSON.parse(data.d)
                        notification(response.Message);
                        resolve(data.d);
                        //alert(resolve(data.d));
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }

                })
            })
        };


        //simpan bagi tab Elaun Perjalanan
        $('#btnSimpantab3').click(async function () {

            $('#noPermohonan').val();
            var id = $('#noPermohonan').val();
            var idPemohon
            idPemohon = $('#txtNoPekerja').val();

            var tkhMohon1 = $('#tkhMohonCL').val();
            $('#txtMohonID3').val(id);
            $('#tkhMohon3').val(tkhMohon1);
            console.log("mohon id")
            console.log(id)

            var total = 0.00
            var elaunPerjalanan = {
                itemEP: {
                    mohonID: $('#noPermohonan').val(),
                    Jumlah: $('#totalEP').val(),
                    GroupItemTabElaunPjln: []
                }
            }


            $('#tblDataEPList tr').each(function (index, obj) {
                var flagKend
                var idStafKend
                var id = $('#noPermohonan').val();
                console.log("masuksave")
                console.log(id)


                if (index > 0) {

                    idStafKend = $(obj).find('.hidNostafKend-list').val();

                    if (idStafKend !== idPemohon) {
                        flagKend = "1"
                    }
                    else {
                        flagKend = "0"
                    }


                    if ($(obj).find('.list-txtKiraKilometer').val() !== "") {
                        var listItemEP = {
                            mohonID: $('#noPermohonan').val(),
                            strKiraKM: $(obj).find('.list-txtKiraKilometer').val(),
                            strhidKM: $(obj).find('.hidkm-list').val(),
                            strKenderaan: $(obj).find('.list-txtKenderaanEP').val(),
                            strHidJnsK: $(obj).find('.hidJnsKend-list').val(),
                            strJumJarak: $(obj).find('.list-txtJumJarakEP').val(),
                            strKadarKM: $(obj).find('.list-txtKadarEP').val(),
                            strJumlahEP: $(obj).find('.list-txtJumlahEP').val(),
                            strTotalEP: $(obj).find('#totalEP').val(),
                            strFlagKend: flagKend,
                        };

                        elaunPerjalanan.itemEP.GroupItemTabElaunPjln.push(listItemEP);
                    }
                }


            });
            //1`ShowPopup("msg")
            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
            console.log(confirm)
            //msg = "Anda pasti ingin menyimpan rekod ini?"

            if (!confirm) {
                return
            }
            else {

                //show_loader();

                var result = JSON.parse(await saveRecordElaunPjln(elaunPerjalanan));
               // alert(result.Message)
                $('#totalEP').val(parseFloat(result.Payload.Jumlah).toFixed(2));
                console.log($('#totalEP').val(result.Payload.Jumlah))
                //close_loader();
            }
        });

        async function saveRecordElaunPjln(listEP_data) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'MohonTuntutan_WS.asmx/SaveRecordElaunPjln',
                    method: 'POST',
                    data: JSON.stringify(listEP_data),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var response = JSON.parse(data.d)
                        notification("Data telah disimpan");
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


        //Bila klik  tab-pengangkutan
        $('#tab-pengangkutan').click(async function () {
            console.log("masuk tab-pengangkutann")
            $('#noPermohonan').val();
            var id = $('#noPermohonan').val();
            var tkhMohon1 = $('#tkhMohonCL').val();
            $('#txtMohonID4').val(id);
            $('#tkhMohon4').val(tkhMohon1);
            //loadDataKenyataan(id)

            if (id !== "") {
                clearAlltblKenderaanAwam();
                //BACA DETAIL JURNAL
                var recordDataKendAwam = await AjaxGetDataKenderaanAwam(id);  //Baca data pada table Keperluan             
                //await clearAllRows();
                await SetDataDataKenderaanAwam(null, recordDataKendAwam); //setData pada table
            }
            return false;
        })

        async function AjaxGetDataKenderaanAwam(id) {

            try {

                const response = await fetch('MohonTuntutan_WS.asmx/GetDataKendAwam', {
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


        async function SetDataDataKenderaanAwam(totalClone, objOrder) {
            console.log("masuk SetDataDataKenderaanAwam")
            var counter = 1;
            var total = 0.00;
            var table = $('#tblTambang');
            var jumlah = 0.00;
            console.log(totalClone)
            var curNumObject = 0;

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.length;

            }
            console.log("jumlah data");
            console.log(totalClone)
            while (counter <= totalClone) {

                curNumObject += 1;

                //var newId_coa = "ddlCOA" + curNumObject;
                var newId_JenisTambang = "ddlJenisTambangtblAwam-list" + curNumObject; //create new object pada table
                var newId_lbljenisTambang = "label-jenisTam-list" + curNumObject;
                var newId_hidjenisTambang = "Hid-jenisTam-list" + curNumObject;
                var newId_DengResit = "checkbox_DengResit" + curNumObject;
                var newId_TanpaResit = "checkbox_TanpaResit" + curNumObject;
                var newId_noResit = "noResit" + curNumObject;
                var newId_AmaunTamb = "lblAmaunTambang" + curNumObject;
                var newId_attResit = "fileInputSurat" + curNumObject;
                var newBil = "data-id" + curNumObject;



                var row = $('#tblTambang tbody>tr:first').clone();

                var JenisTambang = $(row).find(".ddlJenisTambangtblAwam-list").attr("id", newId_JenisTambang);
                var lblJenisTamb = $(row).find(".label-jenisTam-list").attr("id", newId_lbljenisTambang);
                var hidJenisTamb = $(row).find(".Hid-jenisTam-list").attr("id", newId_hidjenisTambang);
                var DengResit = $(row).find(".lblDengResit_list").attr("id", newId_DengResit);
                var TanpaResit = $(row).find(".lblTanpaResit-list").attr("id", newId_TanpaResit);
                var noResit = $(row).find(".lblnoResit-list").attr("id", newId_noResit);
                var AmaunTamb = $(row).find(".AmaunTambang-list").attr("id", newId_AmaunTamb);
                var AttResit = $(row).find(".fileInputSurat").attr("id", newId_attResit);
                var Lampiran = $(row).find(".tempFile").attr("id", "tempFile" + curNumObject);
                var objBil = $(row).find(".data-id");
                objBil.attr("id", newBil);



                if (objOrder !== null && objOrder !== undefined) {
                    var obj = objOrder;
                    console.log(obj[counter - 1].No_Tuntutan);
                    console.log(obj[counter - 1].Jns_Dtl_Tuntutan);
                    console.log(obj[counter - 1].No_Item);
                    console.log(obj[counter - 1].Jenis_Tambang);
                    console.log(obj[counter - 1].Flag_Resit);
                    console.log(obj[counter - 1].No_Resit);
                    console.log(obj[counter - 1].Jumlah_anggaran);
                    console.log(obj[counter - 1].Butiran);
                    //objBil.val($('.data-id').length);

                    console.log("next")
                    console.log(objBil.val())
                    if (obj[counter - 1].Flag_Resit === true) {
                        console.log("masuk checked")
                        $(row).find(".lblDengResit_list").prop("checked", true);
                    }


                    if (obj[counter - 1].Flag_Resit === false) {
                        console.log("masuk checked")
                        TanpaResit.prop("checked", true);

                    }



                    var $tempFilePreview = $(row).find(".tempFile");
                    var $link1 = obj[counter - 1].Path

                    objBil.val(obj[counter - 1].No_Item)
                    JenisTambang.val(obj[counter - 1].Jenis_Tambang);
                    noResit.val(obj[counter - 1].No_Resit);
                    AmaunTamb.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));
                    //AttResit.val(obj[counter - 1].Nama_Fail)
                    $tempFilePreview.attr("href", $link1);
                    $tempFilePreview.html(obj[counter - 1].Nama_Fail);
                    console.log("NExt");
                    console.log(obj[counter - 1].No_Item);
                    jumlah = (obj[counter - 1].Jumlah_anggaran);
                    total += jumlah;
                    console.log(total)
                    $('#totalTblTambang').val(parseFloat(total).toFixed(2))
                }
                else {
                    console.log("masuk else")
                    objBil.val($('.data-id').length);
                }



                row.attr("style", "");


                $('#tblTambang tbody').append(row);

                generateDropdown_list("#" + newId_JenisTambang, "MohonTuntutan_WS.asmx/GetKendAwam", () => {
                    //alert($('#txtNoPekerja').val());
                    return { nostaf: $('#txtNoPekerja').val() };
                })

                var selectObj_KendAwam = $('#' + newId_JenisTambang)
                JenisTambang.dropdown('set selected', objOrder[counter - 1].Butiran);
                selectObj_KendAwam.append("<option value = '" + objOrder[counter - 1].Jenis_Tambang + "'>" + objOrder[counter - 1].Jenis_Tambang + " - " + objOrder[counter - 1].Butiran + "</option>")

                counter += 1;
                console.log("semasa bil")
                console.log(counter)

            }

        }


        //di digunakan untuk kiraan auto calculate Jumlah setiap table
        $('#tblTambang').on('keyup', '.AmaunTambang-list', async function (evt) {
            console.log("keyup")
            var $tr = $(this).closest("tr");
            CalculateTambang($tr);
        })

        async function CalculateTambang($tr) {
            console.log("3701")
            var $amaun = $tr.find(".AmaunTambang-list");
            console.log($amaun.val())
            if (isNaN($amaun.val())) {
                $amaun.val(0)
            }

            var KeseluruhanAmaun = 0.00;
            var $allAmaunt = $('.AmaunTambang-list');

            $allAmaunt.each(function (ind, amaunObj) {
                if (amaunObj.value === "") {
                    return;
                }

                KeseluruhanAmaun += parseFloat(amaunObj.value);
            })

            $('#totalTblTambang').val(KeseluruhanAmaun)
        }

        //on change bila klik jns tempat dan jns tempat dan dapatkan kiraan drpd DB
        $('#tblLojing').on('change', '.ddlJenisTugastblLojingA-list, .ddlTmpttblLojingA-list', async function (evt) {
            var $tr = $(this).closest("tr");

            var $ddlTugas = $tr.find(".ddlJenisTugastblLojingA-list");
            var $ddlTempat = $tr.find(".ddlTmpttblLojingA-list");

            if ($ddlTugas[0].firstChild.value === "" || $ddlTempat[0].firstChild.value === "") {
                return;
            }

            var amaun = await GetAmaunFromDB($ddlTugas[0].firstChild.value, $ddlTempat[0].firstChild.value);
            var $elaun = $tr.find(".elauntblLojing-list");

            $elaun.val(amaun.Payload[0].KadarLojing);
            CalculateAmountLojing($tr);
        })


        $('#tblLojing').on('keyup', '.haritblLojing-list', async function (evt) {
            var $tr = $(this).closest("tr");
            CalculateAmountLojing($tr);
        })


        async function CalculateAmountLojing($tr) {
            var $ddlTugas = $tr.find(".ddlJenisTugastblLojingA-lis");
            var $ddlTempat = $tr.find(".ddlTmpttblLojingA-lis");
            var $hari = $tr.find(".haritblLojing-list");
            var $elaun = $tr.find(".elauntblLojing-list");
            var $amaun = $tr.find(".amauntblLojing-list");

            if (isNaN($hari.val())) {
                $hari.val(0)
            }

            if (isNaN($elaun.val())) {
                $elaun.val(0);
            }
            var total = $hari.val() * $elaun.val();
            var KeseluruhanAmaun = 0.00;

            var $allAmaunt = $('.amauntblLojing-list');
            $amaun.val(total);

            $allAmaunt.each(function (ind, amaunObj) {
                if (amaunObj.value === "") {
                    return;
                }

                KeseluruhanAmaun += parseFloat(amaunObj.value);
            })

            $('#totalTblLojing').val(KeseluruhanAmaun)
        }

        ////ni tuk function Delete Bagi tbl Kenderaan Awam BY ICON
        //$('#tblTambang').on('click', '.btnDeleteTA', async function (evt) {
        //    evt.preventDefault()            
        //    console.log("btnDeleteTA")
        //    var curTR = $(this).closest("tr");
        //    var recordID = curTR.find("td > .data-id");
        //    var bool = true;
        //    DelRecordTA(curTR);

        //});

        async function DelRecordTA(obj) {

            console.log("Masuk DelRecordTA")
            console.log(obj.length);
            var bil = $(obj).find('.data-id').length;
            var $row = obj;//$curBtnUpload.closest("tr");
            var $Tambang_hidID = $row.find('.data-id');

            var frmData = new FormData();
            var $file = $row.find('.fileInputSurat').get(0).files[0];
            var fileName = "";
            var fileSize = "";

            if ($file !== undefined) {
                fileName = $file.name
                fileSize = $file.size;
            }

            frmData.append("fileSurat", $file);
            //frmData.append("fileName", fileName);
            //frmData.append("fileSize", fileSize);
            frmData.append("idItem", $Tambang_hidID.val());
            frmData.append("mohonID", $('#txtMohonID4').val());


            $.ajax({
                url: "MohonTuntutan_WS.asmx/BatalUploadResitTA",
                type: 'POST',
                data: frmData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {

                    //var result = JSON.parse(data.d)
                    //var test = data.getElementsByTagName("string"); //ni jenis String xml time preview Data F12
                    //var result = JSON.parse(test[0].textContent)  //textContent adalah tuk dapatkan data yg didalamnya
                    //$row.find(".tempFile").attr("href", result.Payload.Url);
                    //$row.find(".tempFile").html(result.Payload.FileName);
                    //alert(resolve(data.d));
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                }

            });

        }

        ///delete data pada 
        $("#tblTambang").on("click", ".btnDeleteTA", function (event) {
            console.log("masuk delete")
            var row = $(this).closest('tr');
            //var dataTable = $('#tblTambang').DataTable();
            var tblTambang = $("#tblTambang");


            Id_Lampiran_Hidden = row.find("td > .data-id"); //DELETE ROWS BASED ON THIS ID
            var nomohon = $("#txtMohonID4").val();
            //Nama_Fail_Pdf = row.find("td > .tempFile"); 
            console.log(Id_Lampiran_Hidden.val());
            console.log(nomohon);

            var msg = "Anda pasti ingin memadam rekod ini?";
            $('#confirmationMessageDeleteLampiran').text(msg);
            $('#saveConfirmationModalDeleteLampiran').modal('show');

            $('#confirmSaveButtonDeleteLampiran').off('click').on('click', async function () {
                $('#saveConfirmationModalDeleteLampiran').modal('hide'); // Hide the modal
                var result = JSON.parse(await ajaxdeleteLampiran(Id_Lampiran_Hidden.val(), nomohon));
                if (result.Status === true) {
                    showModalDeleteLampiran("Success", result.Message, "success");
                }
                else {
                    showModalDeleteLampiran("Error", result.Message, "error");
                }

                AjaxGetDataKenderaanAwam(nomohon);
            });
        });

        async function ajaxdeleteLampiran(Id_Lampiran_Hidden, nomohon) {
            console.log("masuk ajaxdeleteLampiran ")
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PENDAHULUAN DAN TUNTUTAN/PERMOHONAN TUNTUTAN/MohonTuntutan_WS.asmx/BatalUploadResitTA") %>',
                    //url: "MohonTuntutan_WS.asmx/BatalUploadResitTA",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ id: Id_Lampiran_Hidden, nomohon1: nomohon }),
                    success: function (data) {
                        resolve(data.d);
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                        reject(false);
                    }
                });
            })
        }

        function showModalDeleteLampiran(title, message, type) {
            $('#resultModalTitleDeleteLampiran').text(title);
            $('#resultModalMessageDeleteLampiran').text(message);
            if (type === "success") {
                $('#resultModalDeleteLampiran').removeClass("modal-error").addClass("modal-success");
            } else if (type === "error") {
                $('#resultModalDeleteLampiran').removeClass("modal-success").addClass("modal-error");
            }
            $('#resultModalDeleteLampiran').modal('show');
        }



        //test dulu Simpan Pada tbl Tambang---------
        $('#tblTambang').on('click', '.btnSimpanTA', async function (event) {
            event.preventDefault();
            console.log("masuk sini 2710")
            var curTR = $(this).closest("tr");
            var recordID = curTR.find("td > .data-id");
            var bool = true;
            SimpanTA(curTR);

        })


        ///function simpan dan upload pada datatable TambangKenderaan awam
        async function SimpanTA(obj) {
            console.log("Masuk simpanTA")
            console.log(obj.length);
            var bil = $(obj).find('.data-id').length;
            var $row = obj;//$curBtnUpload.closest("tr");
            var $Tambang_hidID = $row.find('.data-id');
            var $Tambang_jnsKend = $row.find('.ddlJenisTambangtblAwam-list select');
            var $Tambang_dgnResit = staResit;
            var $Tambang_noResit = $row.find('.lblnoResit-list');
            var $Tambang_amaun = $row.find('.AmaunTambang-list');



            var staResit
            let isChecked = $(obj).find('.lblDengResit_list').is(':checked')
            if (isChecked !== true) {
                staResit = "0"
                if ($Tambang_noResit === "") {
                    notification("Sila masukkan No.Resit")

                }

            }


            let isCheckedTR = $(obj).find('.lblTanpaResit-list').is(':checked')
            if (isCheckedTR !== true) {
                staResit = "1"
                $Tambang_noResit.val('-')
            }

            var frmData = new FormData();
            var $file = $row.find('.fileInputSurat').get(0).files[0];
            var fileName = "";
            var fileSize = "";

            if ($file !== undefined) {
                fileName = $file.name
                fileSize = $file.size;
            }

            frmData.append("fileSurat", $file);
            //frmData.append("fileName", fileName);
            //frmData.append("fileSize", fileSize);
            frmData.append("idItem", $Tambang_hidID.val());
            frmData.append("mohonID", $('#txtMohonID4').val());
            frmData.append("JnsKenderaan", $Tambang_jnsKend.val());
            frmData.append("staResit", staResit);
            frmData.append("NoResit", $Tambang_noResit.val());
            frmData.append("jumlah", $Tambang_amaun.val());
            frmData.append("jumlahSemua", $('#totalTblTambang').val());
            // console.log(frmData);

            $.ajax({
                url: "MohonTuntutan_WS.asmx/SaveUploadResitTA",
                type: 'POST',
                data: frmData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    //var result = JSON.parse(data.d)
                    var test = data.getElementsByTagName("string"); //ni jenis String xml time preview Data F12
                    var result = JSON.parse(test[0].textContent)  //textContent adalah tuk dapatkan data yg didalamnya
                    $row.find(".tempFile").attr("href", result.Payload.Url);
                    $row.find(".tempFile").html(result.Payload.FileName);
                    //alert(resolve(data.d));
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                }

            });

        }






        //simpan bagi tab 4 - Tambang kenderaan Awam
        $('#btnSimpantab4').click(async function () {

            var id = $('#noPermohonan').val();
            var tkhMohon1 = $('#tkhMohonCL').val();
            var staResit
            $('#txtMohonID4').val(id);
            $('#tkhMohon4').val(tkhMohon1);
            console.log("id")
            console.log(id)
            var strTotal = 0.00

            var TmbgKendAwam = {
                itemKendAwam: {
                    mohonID: $('#noPermohonan').val(),
                    Jumlah: $('#totalTblTambang').val(),
                    GroupItemKendAwam: []
                }
            }

            console.log($('#txtMohonID4').val())

            $('#tblTambangList tr').each(function (index, obj) {

                total = $(obj).find('.AmaunTambang-list').val()
                strTotal = total + strTotal;
                console.log(strTotal);

                let isChecked = $(obj).find('.lblDengResit_list').is(':checked')
                if (isChecked !== true) {
                    staResit = "0"
                }
                else {
                    staResit = "1"
                }

                if (index > 0) {
                    if ($(obj).find('.ddlJenisTambangtblAwam-list select').val() !== "") {
                        var listItemTambang = {
                            Tambang_mohonID: $('#txtMohonID4').val(),
                            Tambang_hidID: $(obj).find('data-id').val(),
                            Tambang_jnsKend: $(obj).find('.ddlJenisTambangtblAwam-list select').val(),
                            Tambang_dgnResit: staResit,
                            Tambang_noResit: $(obj).find('.lblnoResit-list').val(),
                            Tambang_amaun: $(obj).find('.AmaunTambang-list').val(),
                            Tambang_Total: $(obj).find('#totalTblTambang').val()
                        };
                        TmbgKendAwam.itemKendAwam.GroupItemKendAwam.push(listItemTambang);
                    }
                    else
                        alert("Sila Isi Maklumat Kenderaan Awam");
                }


            });


            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")

            if (!confirm) {
                return
            }
            else {
                //console.log(TmbgKendAwam);
                //show_loader();

                var result = JSON.parse(await saveRecordTambangAwam(TmbgKendAwam));
                //alert(result.Message)
                $('#totalTblTambang').val(parseFloat(result.Payload.Jumlah).toFixed(2));
                console.log($('#totalTblTambang').val(result.Payload.Jumlah));
                //close_loader();
            }

        });

        async function saveRecordTambangAwam(listTambangKendAwam) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'MohonTuntutan_WS.asmx/SaveRecordTambangKendAwam',
                    method: 'POST',
                    data: JSON.stringify(listTambangKendAwam),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var response = JSON.parse(data.d)
                        notification("Data telah disimpan");
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


        //function bila klil pada tab-elaunMakan
        $('#tab-elaunMakan').click(async function () {
            console.log("masuk tab-elaun makan  jjjj")
            $('#noPermohonan').val();
            var id = $('#noPermohonan').val();
            var tkhMohon1 = $('#tkhMohonCL').val();
            $('#txtMohonID5').val(id);
            $('#tkhMohon5').val(tkhMohon1);

            if (id !== "") {
                await clearAlltblElaunMakan();
                //BACA DETAIL JURNAL
                var recordDataElaunMakan = await AjaxGetDataElaunMakan(id);  //Baca data pada table Keperluan
                //await clearAllRows();
                if (recordDataElaunMakan.Payload.length === 0) {
                    recordDataElaunMakan = await AjaxGetDataBilHari(id);
                }
                await SetDataElaunMakanKepadaRows(null, recordDataElaunMakan); //setData pada table
            }
            return false;
        })

        async function AjaxGetDataElaunMakan(id) {
           
            try {

                const response = await fetch('MohonTuntutan_WS.asmx/GetDataElaunMakan', {
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


        async function AjaxGetDataBilHari(id) {
          
            try {

                const response = await fetch('MohonTuntutan_WS.asmx/GetDataStoreProceHari', {
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

        async function SetDataElaunMakanKepadaRows(totalClone, objOrder) {
            var counter = 1;
            var table = $('#tblElaunMkn');
            var total = 0.00;
            var jumlah = 0.00;


            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;
                // totalClone = objOrder.length;

            }



            while (counter <= totalClone) {

                curNumObject += 1;
                //var newId_coa = "ddlCOA" + curNumObject;
                var newId_hari = "txtbilEL" + curNumObject;
                var newId_bil = "form-control-hidIDEL" + curNumObject; //create new object pada table
                var newId_TugasEL = "ddlJenisTugasElaunMkn" + curNumObject;
                var newId_lblTugas = "label-JenisTugasElaunMkn-list" + curNumObject;
                var newId_hidTugas = "Hid-JenisTugasElaunMkn-list" + curNumObject;
                var newId_pagi = "chckPagi" + curNumObject;
                var newId_tghari = "chckTghari" + curNumObject;
                var newId_petand = "chckPtg" + curNumObject;
                var newId_tempatEL = "ddlTmptElaunMkn" + curNumObject;
                var newId_lblTempatEL = "lblJnstempatElaunMkn" + curNumObject;
                var newId_hidTempatEL = "HidJnstempatElaunMkn" + curNumObject;
                var newId_hargaEL = "txtHargaEL-list" + curNumObject;
                var newId_JumlahEL = "txtJumlahEL" + curNumObject;




                var row = $('#tblElaunMkn tbody>tr:first').clone();

                //var bilEL = $(row).find(".txtbilEL").attr("id", newId_bil);
                var bilHari = $(row).find(".form-control-txtbilEL").attr("id", newId_hari);
                var jenisTugasEL = $(row).find(".JenisTugasElaunMkn-list").attr("id", newId_TugasEL);
                var lblTugasEL = $(row).find(".label-JenisTugasElaunMkn-list").attr("id", newId_lblTugas);
                var hidTugasEL = $(row).find(".Hid-JenisTugasElaunMkn-list").attr("id", newId_hidTugas);
                var mPagi = $(row).find(".pagi").attr("id", newId_pagi);
                var mTghari = $(row).find(".tghari").attr("id", newId_tghari);
                var mMalam = $(row).find(".malam").attr("id", newId_petand);
                var jenisTempatEL = $(row).find(".JnstempatElaunMkn-list").attr("id", newId_tempatEL);
                var lblTempatEL = $(row).find(".label-JnstempatElaunMkn-list").attr("id", newId_lblTempatEL);
                var hidTempatEL = $(row).find(".Hid-JnstempatElaunMkn-list").attr("id", newId_hidTempatEL);
                var AmaunEL = $(row).find(".form-control-txtHargaEL").attr("id", newId_hargaEL);
                var JumlahEL = $(row).find(".form-control-txtJumlahEL").attr("id", newId_JumlahEL)
                var $objBil = $(row).find(".form-control-hidIDEL");
                $objBil.attr("id", newId_bil);


                $('#tblElaunMkn tbody').append(row);

                generateDropdown_list("#" + newId_TugasEL, "MohonTuntutan_WS.asmx/GetJenisTugasTblSewaHotel", null)
                generateDropdown_list("#" + newId_tempatEL, "MohonTuntutan_WS.asmx/GetTempatTblHotel", null)

                if (objOrder !== null && objOrder !== undefined) {
                    var obj = objOrder.Payload;

                    bilHari.val(obj[counter - 1].Bil_Hari);
                    if (Object.keys(obj[counter - 1]).length > 2) {

                        if ((obj[counter - 1].Flag_Mkn_Pagi) === 1) {
                            var $checkPagi = 1
                        }

                        console.log("next")

                        if (obj[counter - 1].Flag_Mkn_Pagi === true) {
                            console.log("masuk checked")
                            $(row).find(".pagi").prop("checked", true);
                        }


                        if (obj[counter - 1].Flag_Mkn_Tghari === true) {
                            console.log("masuk checked")
                            $(row).find(".tghari").prop("checked", true);

                        }

                        if (obj[counter - 1].Flag_Mkn_Mlm === true) {
                            console.log("masuk checked")
                            $(row).find(".malam").prop("checked", true);

                        }


                        $objBil.val(obj[counter - 1].No_Item)

                        jenisTugasEL.val(obj[counter - 1].Jenis_Tugas);
                        //mPagi.val(obj[counter - 1].Flag_Mkn_Pagi);
                        //mTghari.val(obj[counter - 1].Flag_Mkn_Tghari);
                        //mMalam.val(obj[counter - 1].Flag_Mkn_Mlm);
                        jenisTempatEL.val(obj[counter - 1].Jenis_Tempat);
                        AmaunEL.val(parseFloat(obj[counter - 1].Kadar_Harga).toFixed(2));
                        JumlahEL.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));
                        var selectObj_jnstugasHotel = $('#' + newId_TugasEL)
                        jenisTugasEL.dropdown('set selected', obj[counter - 1].JenisTugas);
                        selectObj_jnstugasHotel.append("<option value = '" + obj[counter - 1].Jenis_Tugas + "'>" + obj[counter - 1].JenisTugas + "</option>")

                        var selectObj_jnstempatHotel = $('#' + newId_tempatEL)
                        jenisTempatEL.dropdown('set selected', obj[counter - 1].Tempat);
                        selectObj_jnstempatHotel.append("<option value = '" + obj[counter - 1].Jenis_Tempat + "'>" + obj[counter - 1].Tempat + "</option>")

                        jumlah = (obj[counter - 1].Jumlah_anggaran);
                        total += jumlah;

                        $('#totalEL').val(parseFloat(total).toFixed(2))
                    }
                    else {
                        $objBil.val(counter)
                    }


                }
                else {
                    $objBil.val($('.form-control-hidIDEL').length);
                }

                row.attr("style", "");
                var val = "";

                counter += 1;
            }


        }



        $('#btnSimpantab5').click(async function () {

            var item
            $('#noPermohonan').val();
            var id = $('#noPermohonan').val();
            var idPemohon
            var tkhMohon1 = $('#tkhMohonCL').val();
            $('#txtMohonID3').val(id);
            $('#tkhMohon3').val(tkhMohon1);
            console.log("mohon id")
            console.log(id)


            var ElaunMakan = {
                itemElaunMakan: {
                    OrderID: $('#noPermohonan').val(),
                    Jumlah: $('#totalEL').val(),
                    GroupElaunMakan: []
                }

            }

            $('#tblElaunMkn-list tr').each(function (index, obj) {
                var flagPagi
                var flagTghari
                var flagMalam
                var flagHarian = 1
                if (index > 0) {

                    if ($(obj).find('.pagi').prop('checked')) {
                        flagPagi = 1
                    }
                    else {
                        flagPagi = 0
                    }

                    if ($(obj).find('.tghari').prop('checked')) {
                        flagTghari = 1
                    }
                    else {
                        flagTghari = 0
                    }

                    if ($(obj).find('.malam').prop('checked')) {
                        flagMalam = 1
                    }
                    else {
                        flagMalam = 0
                    }

                    console.log(flagPagi)
                    console.log(flagTghari)
                    console.log(flagMalam)


                    console.log($(obj));
                    //alert("ce;; "+tcell)
                    console.log($(obj).find('.form-control-txtbilEL'));
                    if ($(obj).find('.form-control-txtbilEL').val() !== "") {
                        var listElaunMkn = {
                            EM_mohonID: $('#noPermohonan').val(),
                            EM_bilHari: $(obj).find('.form-control-txtbilEL').val(),
                            EM_hidID: $(obj).find('.form-control-hidIDEL').val(),
                            EM_JnsPerjalanan: $(obj).find('.JenisTugasElaunMkn-list > select').val(),
                            EM_MknPagi: flagPagi,
                            EM_MknTghri: flagTghari,
                            EM_MknMlm: flagMalam,
                            EM_ElaunHarian: flagHarian,
                            EM_harga: $(obj).find('.form-control-txtHargaEL').val(),
                            EM_tempat: $(obj).find('.JnstempatElaunMkn-list  > select').val(),
                            EM_Jumlah: $(obj).find('.form-control-txtJumlahEL').val(),
                        };
                        ElaunMakan.itemElaunMakan.GroupElaunMakan.push(listElaunMkn);
                    }
                }

            });

            //ni tuk modal msg
            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
            console.log(confirm)
            if (!confirm) {
                return
            }
            else {
                var result = JSON.parse(await saveRecordElaunMakan(ElaunMakan));
                //alert(result.Message)
                $('#totalEL').val(parseFloat(result.Payload.Jumlah).toFixed(2));
                console.log($('#totalEL').val(result.Payload.Jumlah))
               
            }
        });


        async function saveRecordElaunMakan(list_EM) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'MohonTuntutan_WS.asmx/SaveRecordElaunMakan',
                    method: 'POST',
                    data: JSON.stringify(list_EM),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var response = JSON.parse(data.d)
                        console.log(response);
                        notification(response.Message);
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

        //test dulu Simpan Pada tbl SewaLojing---------
        $('#tblLojing').on('click', '.btnSimpanLojing', async function (event) {
            console.log("event btn SewaLojing");
            event.preventDefault();
            console.log("masuk sini 2710")
            var curTR = $(this).closest("tr");
            var recordID = curTR.find("td > .input-md-txtBiltblLojing");
            var bool = true;
            SimpanDataLojing(curTR);

        });


        ///function simpan dan upload pada datatable Lojing
        async function SimpanDataLojing(obj) {
            console.log("Masuk SimpanDataLojing")
            console.log(obj.length);

            var bil = $(obj).find('.input-md-txtBiltblLojing').length;

            //var $curBtnUpload = $(obj);
            var $row = obj; // $curBtnUpload.closest("tr");
            var $Lojing_hidID = bil;
            var $Lojing_jnsTugas = $row.find('.ddlJenisTugastblLojingA-list select');
            var $Lojing_JnsTempat = $row.find('.ddlTmpttblLojingA-list select');
            var $Lojing_noResit = $row.find('.input-md.resittblLojing');
            var $Lojing_bilHari = $row.find('.input-md.haritblLojing-list');
            var $Lojing_ElaunHarian = $row.find('.input-md.elauntblLojing-list');
            var $Lojing_Jumlah = $row.find('.input-md.amauntblLojing-list');
            var $Lojing_Alamat = $('#txtAlamatLojing').val();

            console.log("$Lojing_hidID")
            console.log($Lojing_Alamat);
            var frmData = new FormData();
            var $file = $row.find('.fileInputLojing').get(0).files[0];

            frmData.append("fileSurat", $file);
            frmData.append("fileName", $file.name);
            frmData.append("fileSize", $file.size);
            frmData.append("idItem", $Lojing_hidID);
            frmData.append("mohonID", $('#txtMohonID6').val());
            frmData.append("Lojing_jnsTugas", $Lojing_jnsTugas.val());
            frmData.append("Lojing_JnsTempat", $Lojing_JnsTempat.val());
            frmData.append("Lojing_noResit", $Lojing_noResit.val());
            frmData.append("Lojing_bilHari", $Lojing_bilHari.val());
            frmData.append("Lojing_ElaunHarian", $Lojing_ElaunHarian.val());
            frmData.append("Lojing_Jumlah", $Lojing_Jumlah.val());
            frmData.append("Lojing_Alamat", $Lojing_Alamat);
            // console.log(frmData);

            $.ajax({
                url: "TabHotelLoging_WS_New.asmx/SaveUploadElaunLojing",
                type: 'POST',
                data: frmData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    //var result = JSON.parse(data.d)
                    var test = data.getElementsByTagName("string"); //ni jenis String xml time preview Data F12
                    var result = JSON.parse(test[0].textContent)  //textContent adalah tuk dapatkan data yg didalamnya
                    $row.find(".tempFilLojing").attr("href", result.Payload.Url);
                    $row.find(".tempFileLojing").html(result.Payload.FileName);
                    //alert(resolve(data.d));
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                }



            });

        }

        //test dulu Simpan Pada tbl SewaHotel---------
        $('#tblSewaHotel').on('click', '.btnSimpanHotel', async function (event) {
            console.log("event btn Simpan Hotel");
            event.preventDefault();
            console.log("masuk sini 2710")
            var curTR = $(this).closest("tr");
            var recordID = curTR.find("td > .hidBil");
            var bool = true;
            await SimpanDataSewaHotel(curTR);
            await GetTotalHotelLojing();

        })


        async function GetTotalHotelLojing() {
            var id = $('#noPermohonan').val();
            var recordJumlahHotelLojing = await AjaxJumlahHotelLojingTerkini(id);
            await SetDataTotalHotelLojing(null, recordJumlahHotelLojing);



            var totalHotel = $('#totaltblHotel').val();
            var totalLojing = $('#totalTblLojing').val();
            console.log("return")
            console.log(parseFloat(totalHotel.val()) + parseFloat(totalLojing.val()));
            return parseFloat(totalHotel.val()) + parseFloat(totalLojing.val());
        }

        async function SetDataTotalHotelLojing(totalClone, objOrder) {

            if (objOrder !== null && objOrder !== undefined) {
                var obj = objOrder;

                console.log("masuk function SetDataTotalHotelLojing")
                var totalHotel = $('#totaltblHotel').val();
                var totalLojing = $('#totalTblLojing').val();

                totalHotel = obj[counter - 1].TotalK_EH
                totalLojing = obj[counter - 1].TotalK_EL

                var Totalkeseluruhan = 0.00
                Totalkeseluruhan = parseFloat(totalHotel) + parseFloat(totalLojing)
                console.log(Totalkeseluruhan.val());
            }
            else {

            }
        } 

        //dapatkan jumlahkeseluruhan tbl Hotel dan Lojing
        async function AjaxJumlahHotelLojingTerkini(id) {
            console.log("masuk AJAX AjaxRecordSewaHotel ")

            try {

                const response = await fetch('TabHotelLoging_WS_New.asmx/GetDataJumlahHotelLojing', {
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
        

        ///function simpan dan upload pada datatable SewaHotel
       async function SimpanDataSewaHotel(obj) {
            console.log("Masuk SimpanDataSewaHotel")
            console.log(obj.length);

            var JumlahKeseluruhan = GetTotal();

           var bil = $(obj).find('.input-md-txtBiltblHotel-list').length;
           var flagKongsiBilik 
           // alert(flagKongsiBilik.val())
            var $secondRow = $(obj).next("tr");
            console.log($secondRow);
           
            console.log("bil")
            console.log(bil);

           if ($(obj).find('.kongsi-bilik').prop('checked')) {
               flagKongsiBilik = 1

           } else {
               flagKongsiBilik = 0
           }


            //var $curBtnUpload = $(obj);
            var $row = obj; // $curBtnUpload.closest("tr");
            var $Hotel_hidID = $row.find('.input-md-txtBiltblHotel-list');
            var $Hotel_jnsTugas = $row.find('.ddlJenisTugastblHotel-list select');
            var $Hotel_JnsTempat = $row.find('.ddltempattblHotel-list select');
            var $Hotel_noResit = $row.find('.resittblHotel-list');
            var $Hotel_bilHari = $row.find('.input-md.haritblHotel-list');
            var $Hotel_ElaunHarian = $row.find('.elauntblHotel-list');
            var $Hotel_Jumlah = $row.find('.amauntblHotel-list');
           var $totalCukai = $secondRow.find(".js-total-cukai");
           var $flagKongsiBilik = flagKongsiBilik;
            //alert($totalCukai.val());
            console.log("$Hotel_hidID")
            console.log($Hotel_hidID)
            var frmData = new FormData();
            var $file = $row.find('.fileInputHotel').get(0).files[0];

            frmData.append("fileSurat", $file);
            frmData.append("fileName", $file.name);
            frmData.append("fileSize", $file.size);
            frmData.append("idItem", $Hotel_hidID.val());
            frmData.append("mohonID", $('#txtMohonID6').val());
            frmData.append("Hotel_jnsTugas", $Hotel_jnsTugas.val());
            frmData.append("Hotel_JnsTempat", $Hotel_JnsTempat.val());
            frmData.append("Hotel_noResit", $Hotel_noResit.val());
            frmData.append("Hotel_bilHari", $Hotel_bilHari.val());
            frmData.append("Hotel_ElaunHarian", $Hotel_ElaunHarian.val());
            frmData.append("Hotel_Jumlah", $Hotel_Jumlah.val());
           frmData.append("Total_Cukai", $totalCukai.val());
           frmData.append("flagBilik", $flagKongsiBilik.val());
            // console.log(frmData);

            $.ajax({
                url: "TabHotelLoging_WS_New.asmx/SaveUploadSewaHotel",
                type: 'POST',
                data: frmData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    //var result = JSON.parse(data.d)
                    var test = data.getElementsByTagName("string"); //ni jenis String xml time preview Data F12
                    var result = JSON.parse(test[0].textContent)  //textContent adalah tuk dapatkan data yg didalamnya
                    $row.find(".tempFileHotel").attr("href", result.Payload.Url);
                    $row.find(".tempFileHotel").html(result.Payload.FileName);
                    //alert(resolve(data.d));
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                }



            });

        }


        //button simpan bagi sewa hotel
        $('#btnSimpanHotel').click(async function () {
            var item
            id = $('#noPermohonan').val();

            var SewaHotel = {
                itemSewaHotel: {
                    mohonID: $('#noPermohonan').val(),
                    Jumlah: $('#totaltblHotel').val(),
                    GroupSewaHotel: []
                }
            }

            var totalRow = $('#tblSewaHotelData tbody > tr').length;
            var counter = 0;
            while (counter < totalRow) {
                //console.log(obj);
                if (counter > 1) {
                    var row = $('#tblSewaHotelData tbody > tr').eq(counter);
                    var secondRow = $('#tblSewaHotelData tbody > tr').eq(counter + 1);
                    console.log(row);
                    console.log(secondRow);
                    //if ($(row).find('.haritblHotel-list').val() !== null) {
                    //    var listSewaHotel = {
                    //        SH_mohonID: $('#noPermohonan').val(),
                    //        SH_hidID: $(row).find('.hidBil').val(),
                    //        SH_JnsTugas: $(row).find('.ddlJenisTugastblHotel-list select').val(),
                    //        SH_JnsTempat: $(row).find('.ddltempattblHotel-list select').val(),
                    //        SH_noResit: $(row).find('.resittblHotel-list').val(),
                    //        SH_ElaunHarian: $(row).find('.elauntblHotel-list').val(),
                    //        SH_bilHari: $(row).find('.haritblHotel-list').val(),
                    //        SH_Jumlah: $(row).find('.amauntblHotel-list').val(),
                    //        SH_Total: $(row).find('.totaltblHotel').val(),
                    //        TotalCukai: $(secondRow).find('.js-total-cukai').val(),
                    //    };
                    //    //console.log(listSewaHotel);
                    //    SewaHotel.itemSewaHotel.GroupSewaHotel.push(listSewaHotel);
                    //}
                }
                counter += 1;
            }

            return false;
            

            $('#tblSewaHotelData tr').each(function (index, obj) {
                //console.log(obj);
                if (index > 0) {
                    if ($(obj).find('.haritblHotel-list').val() !== null) {
                        var listSewaHotel = {
                            SH_mohonID: $('#noPermohonan').val(),
                            SH_hidID: $(obj).find('.hidBil').val(),
                            SH_JnsTugas: $(obj).find('.ddlJenisTugastblHotel-list select').val(),
                            SH_JnsTempat: $(obj).find('.ddltempattblHotel-list select').val(),
                            SH_noResit: $(obj).find('.resittblHotel-list').val(),
                            SH_ElaunHarian: $(obj).find('.elauntblHotel-list').val(),
                            SH_bilHari: $(obj).find('.haritblHotel-list').val(),
                            SH_Jumlah: $(obj).find('.amauntblHotel-list').val(),
                            SH_Total: $(obj).find('.totaltblHotel').val(), 
                            totalCukai: $(obj).find('.js-total-cukai').val(),
                        };
                        //console.log(listSewaHotel);
                        SewaHotel.itemSewaHotel.GroupSewaHotel.push(listSewaHotel);
                    }
                }
            })

            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
           
            if (!confirm) {
                return
            }
            else {

                var result = JSON.parse(await saveRecordSewaHotel(SewaHotel));
                //alert(result.Message)
                console.log("masuk simpan 3945");
                // $('#totalTblLojing').val(parseFloat(result.Payload.Jumlah).toFixed(2));
                //console.log($('#totalTblLojing').val(result.Payload.Jumlah))
               // close_loader();
            }

        });


        async function saveRecordSewaHotel(item) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'MohonTuntutan_WS.asmx/SaveDataSewaHotelWS',
                    method: 'POST',
                    data: JSON.stringify(item),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var response = JSON.parse(data.d)
                        notification("Data telah disimpan");
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



        $('#tab-sewaHotel').click(async function () {
            console.log("masuk sewa hotel")
            $('#noPermohonan').val();
            var id = $('#noPermohonan').val();
            var tkhMohon1 = $('#tkhMohonCL').val();
            $('#txtMohonID6').val(id);
            $('#tkhMohon6').val(tkhMohon1);
            //loadDataKenyataan(id)

            if (id !== "") {
                clearAlltblSewaHotel();
                //BACA DETAIL JURNAL
                var recordDataSewaHotel = await AjaxRecordSewaHotel(id);  //Baca data pada table Keperluan             
                //await clearAllRows();
                await SetDataSewaHotel(null, recordDataSewaHotel); //setData pada table
                clearAlltblLojing();
                var recordDataElaunLojing = await AjaxRecordElaunLojing(id);  //Baca data pada table Keperluan             
                //await clearAllRows();
                await SetDataElaunLojing(null, recordDataElaunLojing); //setData pada table

            }
            return false;
        })


        async function AjaxRecordElaunLojing(id) {
            console.log("masuk AJAX AjaxRecordElaunLojing ")

            try {

                const response = await fetch('TabHotelLoging_WS_New.asmx/GetDataElaunLojing', {
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

        async function SetDataElaunLojing(totalClone, objOrder) {
            console.log("SetDataElaunLojing")
            var counter = 1;
            var table = $('#tblLojing');
            var total = 0.00;

            if (objOrder !== null && objOrder !== undefined) {
                //totalClone = objOrder.Payload.OrderDetails.length;
                totalClone = objOrder.length;

            }

            while (counter <= totalClone) {

                curNumObject += 1;

                var bil = $(obj).find('.input-md-txtBiltblLojing').length;


                //var newId_coa = "ddlCOA" + curNumObject;
                var newId_bilLojing = "txtBiltblLojing" + curNumObject; //create new object pada table
                var newId_jnstugasLojing = "ddlJenisTugastblLojingA" + curNumObject;
                var newId_lbljnstugasLojing = "label-JenisTugastblLojing-list" + curNumObject;
                var newId_hidjnstugasLojing = "Hid-JenisTugastblLojing-list" + curNumObject;
                var newId_tempatLojing = "ddlTmpttblLojingA" + curNumObject;
                var newId_lbltempatLojing = "label-JnstempattblLojing-list" + curNumObject;
                var newId_hidtempatLojing = "Hid-JnstempattblLojing-list" + curNumObject;
                var newId_resitLojing = "resittblLojing" + curNumObject;
                var newId_lblresitLojing = "resit-list" + curNumObject;
                var newId_elaunLojing = "elauntblLojing-list" + curNumObject;
                var newId_lblelaunLojing = "lblAmaunLojing-list" + curNumObject;
                var newId_hariLojing = "haritblLojing-list" + curNumObject;
                var newId_lblhariLojing = "lblharitblLojing-list" + curNumObject;
                var newId_amaunLojing = "mauntblLojing-list" + curNumObject;
                var newId_lblamaunLojing = "lblAmaunLojing-list" + curNumObject;
                var newId_attResit = "fileInputLojing" + curNumObject;
                var newId_Alamat = "txtAlamatLojing" + curNumObject;
                var newBil = "txtBil" + curNumObject;



                var row = $('#tblLojing tbody>tr:first').clone();


                var $objBil = $(row).find(".input-md-txtBiltblLojing").attr("id", newId_bilLojing);
                var jnstugasLojing = $(row).find(".ddlJenisTugastblLojingA-list").attr("id", newId_jnstugasLojing);
                var lbljnstugasLojingl = $(row).find(".label-JenisTugastblLojing-list").attr("id", newId_lbljnstugasLojing);
                var hidjnstugasLojing = $(row).find(".Hid-JenisTugastblLojing-list").attr("id", newId_hidjnstugasLojing);
                var tempatLojing = $(row).find(".ddlTmpttblLojingA-list").attr("id", newId_tempatLojing);
                var lbltempatLojing = $(row).find(".label-JnstempattblLojing-list").attr("id", newId_lbltempatLojing);
                var hidtempatLojing = $(row).find(".Hid-JnstempattblLojing-list").attr("id", newId_hidtempatLojing);
                var resitLojing = $(row).find(".input-md.resittblLojing").attr("id", newId_resitLojing);
                var lblresitLojing = $(row).find(".resit-list").attr("id", newId_lblresitLojing);
                var elaunLojing = $(row).find(".input-md.elauntblLojing-list").attr("id", newId_elaunLojing);
                var lblelaunLojing = $(row).find(".lblAmaunLojing-list").attr("id", newId_lblelaunLojing);
                var hariLojing = $(row).find(".input-md.haritblLojing-list").attr("id", newId_hariLojing);
                var lblelaunLojing = $(row).find(".lblharitblLojing-list").attr("id", newId_lblhariLojing);
                var amaunLojing = $(row).find(".amauntblLojing-list").attr("id", newId_amaunLojing);
                var lblamaunLojing = $(row).find(".lblAmaunLojing-list").attr("id", newId_lblamaunLojing);
                var AttResit = $(row).find(".fileInputLojing").attr("id", newId_attResit);
                var Lampiran = $(row).find(".tempFileLojing").attr("id", "tempFileLojing" + curNumObject);


                var $objBil = $(row).find('.input-md-txtBiltblLojing');
                $objBil.attr("id", newBil);


                if (objOrder !== null && objOrder !== undefined) {
                    var obj = objOrder;

                    console.log(obj[counter - 1].No_Item);
                    console.log(obj[counter - 1].Jenis_Tugas);
                    console.log(obj[counter - 1].Jenis_Tempat);
                    console.log(obj[counter - 1].Bil_Hari);
                    console.log(obj[counter - 1].No_Resit);
                    console.log(obj[counter - 1].Kadar_Harga);
                    console.log(obj[counter - 1].Jumlah_anggaran);
                    console.log(obj[counter - 1].Alamat_Lojing);

                    var $tempFilePreview = $(row).find(".tempFileLojing");
                    var $link1 = obj[counter - 1].Path

                    console.log($objBil.val($('.input-md-txtBiltblLojing').length));

                    $objBil.val(obj[counter - 1].No_Item)

                    jnstugasLojing.val(obj[counter - 1].Jenis_Tugas);
                    tempatLojing.val(obj[counter - 1].Jenis_Tempat);
                    resitLojing.val(obj[counter - 1].No_Resit);
                    hariLojing.val(obj[counter - 1].Bil_Hari);
                    amaunLojing.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));
                    elaunLojing.val(parseFloat(obj[counter - 1].Kadar_Harga).toFixed(2));

                    $tempFilePreview.attr("href", $link1);
                    $tempFilePreview.html(obj[counter - 1].Nama_Fail);
                    console.log($tempFilePreview.html());
                    console.log($objBil.val(obj[counter - 1].No_Item));
                    console.log("NExt");
                    jumlah = (obj[counter - 1].Jumlah_anggaran);
                    total += jumlah;
                    console.log(total)
                    $('#txtAlamatLojing').val(obj[counter - 1].Alamat_Lojing)
                    $('#totalTblLojing').val(parseFloat(total).toFixed(2))
                }
                else {
                    $objBil.val($('.input-md-txtBiltblLojing').length);
                }



                row.attr("style", "");
                var val = "";

                $('#tblLojing tbody').append(row);

                generateDropdown_list("#" + newId_jnstugasLojing, "MohonTuntutan_WS.asmx/GetJenisTugasTblSewaHotel", null)

                var selectObj_jnstugasLojing = $('#' + newId_jnstugasLojing)
                jnstugasLojing.dropdown('set selected', obj[counter - 1].JenisTugas);
                selectObj_jnstugasLojing.append("<option value = '" + obj[counter - 1].Jenis_Tugas + "'>" + obj[counter - 1].JenisTugas + "</option>")

                generateDropdown_list("#" + newId_tempatLojing, "MohonTuntutan_WS.asmx/GetTempatTblHotel", null)
                var selectObj_tempatLojing = $('#' + newId_tempatLojing)
                tempatLojing.dropdown('set selected', obj[counter - 1].Tempat);
                selectObj_tempatLojing.append("<option value = '" + obj[counter - 1].Jenis_Tempat + "'>" + obj[counter - 1].Tempat + "</option>")

                counter += 1;



            }


        }


        async function AjaxRecordSewaHotel(id) {
            console.log("masuk AJAX AjaxRecordSewaHotel ")

            try {

                const response = await fetch('TabHotelLoging_WS_New.asmx/GetDataSewaHotel', {
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

        async function SetDataSewaHotel(totalClone, objOrder) {
            console.log("SetDataSewaHotel")
            var counter = 1;
            var table = $('#tblSewaHotel');
            var total = 0.00;
            var jumCukai = 0.00;
            var jumlahsewa_Cukai = 0.00;

            if (objOrder !== null && objOrder !== undefined) {
                //totalClone = objOrder.Payload.OrderDetails.length;
                totalClone = objOrder.length;

            }

            while (counter <= totalClone) {

                curNumObject += 1;

                //var newId_coa = "ddlCOA" + curNumObject;
                var newId_bilHotel = "txtBiltblHotel" + curNumObject; //create new object pada table
                var newId_jnstugasHotel = "ddlJenisTugastblHotel" + curNumObject;
                var newId_lbljnstugasHotel = "lblJenisTugastblHotel" + curNumObject;
                var newId_hidjnstugasHotel = "HidJenisTugastblHotel" + curNumObject;
                var newId_tempatHotel = "ddlTmpttblHotel" + curNumObject;
                var newId_lbltempatHotel = "lblJnstempattblHotel" + curNumObject;
                var newId_hidtempatHotel = "HidJnstempattblHotel" + curNumObject;
                var newId_resitHotel = "resittblHotel" + curNumObject;
                var newId_lblresitHotel = "lblresittblHotel" + curNumObject;
                var newId_elaunHotel = "elauntblHotel" + curNumObject;
                var newId_lblelaunHotel = "lblelauntblHotel" + curNumObject;
                var newId_hariHotel = "haritblHotel" + curNumObject;
                var newId_lblhariHotel = "lblharitblHotel" + curNumObject;
                var newId_amaunHotel = "amauntblHotel" + curNumObject;
                var newId_lblamaunHotel = "lblamauntblHotel" + curNumObject;
                var newId_chckKongsiBilik = "kongsiBilik" + curNumObject;
                var newId_attResit = "fileInputHotel" + curNumObject;
                var newBil = "txtBil" + curNumObject;




                var row = $('#tblSewaHotel tbody>tr:first').clone();
                var secondRow = $('#tblSewaHotel tbody>tr:nth-child(2)').clone();

                var $objTotalCukai = $(secondRow).find(".js-total-cukai").attr("id", "total-cukai" + curNumObject);
                secondRow.attr("class", "")


                // var dropdown5 = $(row).find(".COA-list").attr("id", newId_coa);
                //var bilHotel = $(row).find(".input-md-txtBiltblHotel-list").attr("id", newId_bilHotel).val($(".input-md-txtBiltblHotel-list").length);
                var $objBil = $(row).find(".input-md-txtBiltblHotel-list").attr("id", newId_bilHotel);
                var jnstugasHotel = $(row).find(".ddlJenisTugastblHotel-list").attr("id", newId_jnstugasHotel);
                var lbljnstugasHotel = $(row).find(".label-JenisTugastblHotel-list").attr("id", newId_lbljnstugasHotel);
                var hidjnstugasHotel = $(row).find(".Hid-JenisTugastblHotel-list").attr("id", newId_hidjnstugasHotel);
                var tempatHotel = $(row).find(".ddltempattblHotel-list").attr("id", newId_tempatHotel);
                var lbltempatHotel = $(row).find(".lblJnstempattblHotel").attr("id", newId_lbltempatHotel);
                var hidtempatHotel = $(row).find(".Hid-JnstempattblHotel-list").attr("id", newId_hidtempatHotel);
                var resitHotel = $(row).find(".resittblHotel-list").attr("id", newId_resitHotel);
                var lblresitHotel = $(row).find(".lblresittblHotel-list").attr("id", newId_lblresitHotel);
                var elaunHotel = $(row).find(".elauntblHotel-list").attr("id", newId_elaunHotel);
                var lblelaunHotel = $(row).find(".lblelauntblHotel-list").attr("id", newId_lblelaunHotel);
                var hariHotel = $(row).find(".input-md.haritblHotel-list").attr("id", newId_hariHotel);
                var lblelaunHotel = $(row).find(".lblharitblHotel-list").attr("id", newId_lblhariHotel);
                var amaunHotel = $(row).find(".amauntblHotel-list").attr("id", newId_amaunHotel);
                var lblamaunHotel = $(row).find(".lblamauntblHotel-list").attr("id", newId_lblamaunHotel);
                var flagKongsiBilik = $(row).find(".kongsi-bilik").attr("id", newId_chckKongsiBilik);
                var AttResit = $(row).find(".fileInputHotel").attr("id", newId_attResit);
                var Lampiran = $(row).find(".tempFileHotel").attr("id", "tempFile" + curNumObject);


                var $objBil = $(row).find('.input-md-txtBiltblHotel-list');
                $objBil.attr("id", newBil);


                $('#tblSewaHotel tbody').append(row);
                $('#tblSewaHotel tbody').append(secondRow);

                generateDropdown_list("#" + newId_jnstugasHotel, "MohonTuntutan_WS.asmx/GetJenisTugasTblSewaHotel", null)
                generateDropdown_list("#" + newId_tempatHotel, "MohonTuntutan_WS.asmx/GetTempatTblHotel", null)

                if (objOrder !== null && objOrder !== undefined) {
                    var obj = objOrder;
                    $objTotalCukai.val(parseFloat(obj[counter - 1].Caj_Hotel).toFixed(2));
                    console.log(obj[counter - 1].No_Item);
                    console.log(obj[counter - 1].Jenis_Tugas);
                    console.log(obj[counter - 1].Jenis_Tempat);
                    console.log(obj[counter - 1].Bil_Hari);
                    console.log(obj[counter - 1].No_Resit);
                    console.log(obj[counter - 1].Kadar_Harga);
                    console.log(obj[counter - 1].Jumlah_anggaran);
                    console.log("kongsiBilik")
                    console.log(obj[counter - 1].Flag_Kongsi_Bilik);

                    if ((obj[counter - 1].Flag_Kongsi_Bilik === true)) {
                          console.log("masuk checked")
                        $(row).find('.kongsi-bilik').prop('checked', true)
                    } else {
                        $(row).find('.kongsi-bilik').prop('checked', false)

                    }

                    var $tempFilePreview = $(row).find(".tempFileHotel");
                    var $link1 = obj[counter - 1].Path

                    console.log($objBil.val($('.input-md-txtBiltblHotel-list').length));

                    $objBil.val(obj[counter - 1].No_Item)

                    jnstugasHotel.val(obj[counter - 1].Jenis_Tugas);
                    tempatHotel.val(obj[counter - 1].Jenis_Tempat);
                    resitHotel.val(obj[counter - 1].No_Resit);
                    hariHotel.val(obj[counter - 1].Bil_Hari);
                    amaunHotel.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));
                    elaunHotel.val(parseFloat(obj[counter - 1].Kadar_Harga).toFixed(2));

                    $tempFilePreview.attr("href", $link1);
                    $tempFilePreview.html(obj[counter - 1].Nama_Fail);
                    console.log($tempFilePreview.html());
                    console.log($objBil.val(obj[counter - 1].No_Item));
                    console.log("NExt");
                    jumlah = (obj[counter - 1].Jumlah_anggaran);
                    jumCukai = (obj[counter - 1].Caj_Hotel);
                    jumlahsewa_Cukai = parseFloat(jumlah) + parseFloat(jumCukai)
                    total += jumlahsewa_Cukai;
                    //total += jumlah;
                    console.log(total)
                    $('#totaltblHotel').val(parseFloat(total).toFixed(2))

                    var selectObj_jnstugasHotel = $('#' + newId_jnstugasHotel)
                    jnstugasHotel.dropdown('set selected', obj[counter - 1].JenisTugas);
                    selectObj_jnstugasHotel.append("<option value = '" + obj[counter - 1].Jenis_Tugas + "'>" + obj[counter - 1].JenisTugas + "</option>")


                    var selectObj_jnstempatHotel = $('#' + newId_tempatHotel)
                    tempatHotel.dropdown('set selected', obj[counter - 1].Tempat);
                    selectObj_jnstempatHotel.append("<option value = '" + obj[counter - 1].Jenis_Tempat + "'>" + obj[counter - 1].Tempat + "</option>")
                }
                else {
                    $objBil.val($('.input-md-txtBiltblHotel-list').length - 1);
                }



                row.attr("style", "");
                secondRow.attr("style", "");
               // var val = "";

                counter += 1;

            }
        }



        $('#tab-pelbagai').click(async function () {

            console.log("masuk tab-pelbagai")
            $('#noPermohonan').val();
            var id = $('#noPermohonan').val();
            var tkhMohon1 = $('#tkhMohonCL').val();
            $('#txtMohonID7').val(id);
            $('#tkhMohon7').val(tkhMohon1);

            //nak kira jumlah hotel and lojing
            var total = 0.00
            var kTotal = 0.00
            var hotel = parseFloat($('#totaltblHotel').val());
            var lojing = parseFloat($('#totalTblLojing').val());

            //total = $('#totaltblHotel').val() + $('#totalTblLojing').val()


            total = hotel + lojing;
            if (total === 0) {
                kTotal=0.00
            }
            kTotal = parseFloat(total).toFixed(2);
            console.log("total")
            console.log(total);
            console.log(hotel);
            console.log(lojing)
            console.log(kTotal)
            await simpanTotalHotelLojing(id, kTotal)


            if (id !== "") {
                clearAlltblPelbagai();
                //BACA DETAIL JURNAL
                var recordDataPelbagai = await AjaxGetDataPelbagai(id);  //Baca data pada table Keperluan             
                //await clearAllRows();
                await SetDataPelbagaiRows(null, recordDataPelbagai); //setData pada table
            }

            return false;

        })

        async function simpanTotalHotelLojing(id, total) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'TabHotelLoging_WS_New.asmx/SaveJumlahHotelLojing',
                    method: 'POST',
                    data: JSON.stringify({ id: id, total: total }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var response = JSON.parse(data.d)
                        notification("Data telah disimpan");
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

        async function AjaxGetDataPelbagai(id) {

            try {

                const response = await fetch('TabPelbagai_WS.asmx/GetDataPelbagai', {
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


        async function SetDataPelbagaiRows(totalClone, objOrder) {
            console.log("SetDataPelbagaiRows")
            var counter = 1;
            var table = $('#tblPelbagai');
            var total = 0.00;
            var jumlah = 0.00;

            if (objOrder !== null && objOrder !== undefined) {
                //totalClone = objOrder.Payload.OrderDetails.length;
                totalClone = objOrder.length;

            }

            while (counter <= totalClone) {

                curNumObject += 1;

                //var newId_coa = "ddlCOA" + curNumObject;
                var newBil = "txtBil" + curNumObject;
                var newId_jenisBP = "JenisPelbagai-list" + curNumObject;
                var newId_lbljenisBP = "lblJenisPelbagai" + curNumObject;
                var newId_hidjenisBP = "HidlblJenisPelbagai" + curNumObject;
                var newId_DengResitBP = "checkbox_DengResitBP" + curNumObject;
                var newId_lblDengResitBP = "lblDengResitBP" + curNumObject;
                var newId_TanpaResitBP = "checkbox_TanpaResitBP" + curNumObject;
                var newId_lblTanpaResitBP = "lblTanpaResitBP" + curNumObject;
                var newId_noResitBP = "noResitBP" + curNumObject;
                var newId_lblnoResitBP = "lblnoResitBP" + curNumObject;
                var newId_AmaunBP = "AmaunBP" + curNumObject;
                var newId_lblAmaunBP = "lblAmaunBP" + curNumObject;
                var newId_attResit = "fileInputPelbagai" + curNumObject;

                var row = $('#tblPelbagai tbody>tr:first').clone();


                var JenisPelbagaiBP = $(row).find(".JenisPelbagai-list").attr("id", newId_jenisBP);
                var lbljnsPelbagaiBP = $(row).find(".label-jenisPelbagai-list").attr("id", newId_lbljenisBP);
                var hidjnsPelbagaiBP = $(row).find(".Hid-jenisPelbagai-list").attr("id", newId_hidjenisBP);
                var checkbox_DengResitBP = $(row).find(".checkbox_DengResitBP-list").attr("id", newId_DengResitBP);
                var lblDengResitBP = $(row).find(".lblDengResitBP-list").attr("id", newId_lblDengResitBP);
                var checkbox_TanpaResitBP = $(row).find(".checkbox_TanpaResitBP-list").attr("id", newId_TanpaResitBP);
                var lblTanpaResitBP = $(row).find(".lblTanpaResitBP-list").attr("id", newId_lblTanpaResitBP);
                var noResitBP = $(row).find(".input-md-noResitBP").attr("id", newId_noResitBP);
                var lblnoResitBP = $(row).find(".lblnoResitBP-list").attr("id", newId_lblnoResitBP);
                var amaunBP = $(row).find(".input-md-AmaunBP").attr("id", newId_AmaunBP);
                var lblAmaunBP = $(row).find(".lblAmaunBP-list").attr("id", newId_lblAmaunBP);
                var AttResit = $(row).find(".fileInputPelbagai").attr("id", newId_attResit);
                var Lampiran = $(row).find(".tempFilePelbagai").attr("id", "tempFilePelbagai" + curNumObject);
                var $objBil = $(row).find('.txtBil');
                $objBil.attr("id", newBil);


                if (objOrder !== null && objOrder !== undefined) {
                    var obj = objOrder;

                    console.log(obj[counter - 1].No_Item);
                    console.log(obj[counter - 1].Butiran);
                    console.log(obj[counter - 1].Flag_Resit);
                    console.log(obj[counter - 1].No_Resit);
                    console.log(obj[counter - 1].Jumlah_anggaran);


                    console.log("next")
                    if (obj[counter - 1].Flag_Resit === true) {
                        console.log("masuk checked")
                        $(row).find(".checkbox_DengResitBP-list").prop("checked", true);
                    }


                    if (obj[counter - 1].Flag_Resit === false) {
                        console.log("masuk checked")
                        checkbox_TanpaResitBP.prop("checked", true);

                    }

                    var $tempFilePreview = $(row).find(".tempFilePelbagai");
                    var $link1 = obj[counter - 1].Path
                    console.log($objBil.val($('.txtBil').length));

                    $objBil.val(obj[counter - 1].No_Item)
                    JenisPelbagaiBP.val(obj[counter - 1].Butiran);
                    lbljnsPelbagaiBP.val(obj[counter - 1].Jenis_Tambang);
                    hidjnsPelbagaiBP.val(obj[counter - 1].Jenis_Tambang);
                    noResitBP.val(obj[counter - 1].No_Resit);
                    amaunBP.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));
                    $tempFilePreview.attr("href", $link1);
                    $tempFilePreview.html(obj[counter - 1].Nama_Fail);

                    console.log($objBil.val(obj[counter - 1].No_Item));
                    console.log("NExt");
                    jumlah = (obj[counter - 1].Jumlah_anggaran);
                    total += jumlah;
                    console.log(total)
                    $('#totalRm').val(parseFloat(total).toFixed(2));
                }
                else {
                    $objBil.val($('.txtBil').length);
                }

                row.attr("style", "");
                var val = "";

                $('#tblPelbagai tbody').append(row);

                generateDropdown_list("#" + newId_jenisBP, "MohonTuntutan_WS.asmx/GetJenisPelbagai")
                var selectObj_JenisBP = $('#' + newId_jenisBP)
                JenisPelbagaiBP.dropdown('set selected', obj[counter - 1].Butiran);
                selectObj_JenisBP.append("<option value = '" + obj[counter - 1].Jenis_Belanja_Pelbagai + "'>" + obj[counter - 1].Butiran + "</option>")


                counter += 1;
            }
        }


        //test dulu Simpan Pada tbl Pelbagai---------
        $('#tblPelbagai').on('click', '.btnSimpanPelbagai', async function (event) {
            console.log("event btn Simpan Pelbagai");
            event.preventDefault();
            console.log("masuk sini 2710")
            var curTR = $(this).closest("tr");
            var recordID = curTR.find("td > .txtBil");
            var bool = true;
            SimpanTP(curTR);

        })


        ///function simpan dan upload pada  tblPelbagai
        async function SimpanTP(obj) {
            console.log("Masuk simpanTP")
            var bil = $(obj).find('.txtBil').val();

            console.log("bil")
            console.log(bil);

            var staResit
            let isChecked = $(obj).find('.checkbox_DengResitBP-list').is(':checked')
            if (isChecked !== true) {
                staResit = "1"
            }
            else {
                staResit = "0"
            }

            let isCheckedTR = $(obj).find('.checkbox_TanpaResitBP-list').is(':checked')
            if (isCheckedTR !== true) {
                staResit = "1"
            }
            else {
                staResit = "0"
            }


            console.log("staResit")
            console.log(staResit)

            //var $curBtnUpload = $(obj);
            var $row = obj;
            var $Pelbagai_hidID = bil;
            var $Pelbagai_Jenis = $row.find('.JenisPelbagai-list select');
            var $FlagResit = staResit;
            var $Pelbagai_noResit = $row.find('.input-md-noResitBP');
            var $Pelbagai_amaun = $row.find('.input-md-AmaunBP');

            console.log("$Pelbagai_hidID")
            console.log($Pelbagai_hidID)
            var frmData = new FormData();
            var $file = $row.find('.fileInputPelbagai').get(0).files[0];

            console.log($file);
            if ($file !== undefined) {
                frmData.append("fileSurat", $file);
                frmData.append("fileName", $file.name);
                frmData.append("fileSize", $file.size);

            }


            frmData.append("idItem", $Pelbagai_hidID);
            frmData.append("mohonID", $('#txtMohonID7').val());
            frmData.append("JnsBelanjeP", $Pelbagai_Jenis.val());
            frmData.append("staResit", staResit);
            frmData.append("NoResit", $Pelbagai_noResit.val());
            frmData.append("jumlah", $Pelbagai_amaun.val());
            // console.log(frmData);

            $.ajax({
                url: "TabPelbagai_WS.asmx/SaveUploadTblBP",
                type: 'POST',
                data: frmData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (data) {
                    //var result = JSON.parse(data.d)
                    var test = data.getElementsByTagName("string"); //ni jenis String xml time preview Data F12
                    var result = JSON.parse(test[0].textContent)  //textContent adalah tuk dapatkan data yg didalamnya
                    if ($file !== undefined) {
                        $row.find(".tempFilePelbagai").attr("href", result.Payload.Url);
                        $row.find(".tempFilePelbagai").html(result.Payload.FileName);
                    }
                    // $row.find(".tempFilePelbagai").attr("href", result.Payload.Url);
                    //$row.find(".tempFilePelbagai").html(result.Payload.FileName);
                    //alert(resolve(data.d));
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                }



            });

        }

        //di digunakan untuk kiraan auto calculate Jumlah setiap table
        $('#tblPelbagai').on('keyup', '.input-md-AmaunBP', async function (evt) {
            console.log("keyup")
            var $tr = $(this).closest("tr");
            CalculatePelbagai($tr);
        })

        async function CalculatePelbagai($tr) {
            console.log("3701")
            var $amaun = $tr.find(".input-md-AmaunBP");
            console.log($amaun.val())
            if (isNaN($amaun.val())) {
                $amaun.val(0)
            }

            var KeseluruhanAmaun = 0.00;
            var $allAmaunt = $('.input-md-AmaunBP');

            $allAmaunt.each(function (ind, amaunObj) {
                if (amaunObj.value === "") {
                    return;
                }

                KeseluruhanAmaun += parseFloat(amaunObj.value);
            })

            $('#totalRm').val(KeseluruhanAmaun)
        }

        $('#tblSewaHotel').on('change', '.ddlJenisTugastblHotel-list, .ddltempattblHotel-list', async function (evt) {
            var $tr = $(this).closest("tr");

            var $ddlTugas = $tr.find(".ddlJenisTugastblHotel-list");
            var $ddlTempat = $tr.find(".ddltempattblHotel-list");

            if ($ddlTugas[0].firstChild.value === "" || $ddlTempat[0].firstChild.value === "") {
                return;
            }

            var amaun = await GetAmaunFromDB($ddlTugas[0].firstChild.value, $ddlTempat[0].firstChild.value);
            var $elaun = $tr.find(".elauntblHotel-list");

            $elaun.val(amaun.Payload[0].KadarHotel);
            CalculateAmount($tr);
        })

        $('#tblSewaHotel').on('keyup', '.haritblHotel-list', async function (evt) {
            var $tr = $(this).closest("tr");
            CalculateAmount($tr);
        })

        async function GetAmaunFromDB(jnsTugas, jnsTempat) {
            var hadGaji = $('#txtGredGaji').val();
            console.log({ jnsTugas: jnsTugas, jnsTempat: jnsTempat, hadGaji: hadGaji });
            try {

                const response = await fetch('MohonTuntutan_WS.asmx/kiraElaunHotel', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ jnsTugas: jnsTugas, jnsTempat: jnsTempat, hadGaji: hadGaji })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return error;
            }
        }

        async function CalculateAmount($tr) {
            var $ddlTugas = $tr.find(".ddlJenisTugastblHotel-list");
            var $ddlTempat = $tr.find(".ddltempattblHotel-list");
            var $hari = $tr.find(".haritblHotel-list");
            var $elaun = $tr.find(".elauntblHotel-list");
            var $amaun = $tr.find(".amauntblHotel-list");

            if (isNaN($hari.val())) {
                $hari.val(0)
            }

            if (isNaN($elaun.val())) {
                $elaun.val(0);
            }
            var total = $hari.val() * $elaun.val();
            var KeseluruhanAmaun = 0.00;

            var $allAmaunt = $('.amauntblHotel-list');
            $amaun.val(total);

            $allAmaunt.each(function (ind, amaunObj) {
                if (amaunObj.value === "") {
                    return;
                }

                KeseluruhanAmaun += parseFloat(amaunObj.value);
            })

            $('#totaltblHotel').val(KeseluruhanAmaun)
        }

        $('#btnSimpantab7').click(async function () {

            $('#noPermohonan').val();
            var id = $('#noPermohonan').val();
            var idPemohon
            idPemohon = $('#txtNoPekerja').val();

            var tkhMohon1 = $('#tkhMohonCL').val();
            $('#txtMohonID3').val(id);
            $('#tkhMohon3').val(tkhMohon1);
            console.log("mohon id")
            console.log(id)


            var PelbagaiGroup = {
                itemPelbagai: {
                    mohonID: $('#noPermohonan').val(),
                    Jumlah: $('#totalEP').val(),
                    ItemGroupPelbagai: []
                }
            }

            $('#tblPelbagaiList tr').each(function (index, obj) {
                var flagResit
                var staResit
                var strTotal = 0.00

                var id = $('#noPermohonan').val();
                console.log("masuksave Pelbagai")
                console.log(id)

                let isChecked = $(obj).find('.checkbox_DengResitBP-list').is(':checked')
                if (isChecked !== true) {
                    staResit = "0"
                }
                else {
                    staResit = "1"
                }

                if (index > 0) {

                    if ($(obj).find('.JenisPelbagai-list select').val() !== "") {
                        var tblListPelbagai = {
                            Pelbagai_mohonID: $('#noPermohonan').val(),
                            Pelbagai_hidID: $(obj).find('.txtBil').val(),
                            strJnsPel: $(obj).find('.JenisPelbagai-list select').val(),
                            strResitPel: staResit,
                            strTResitPel: $(obj).find('.checkbox_TanpaResitBP-list').val(),
                            strNoResitPel: $(obj).find('.input-md-noResitBP').val(),
                            strJumAmaunPel: $(obj).find('.input-md-AmaunBP').val(),
                            strJumlahPel: $(obj).find('#totalRm').val(),

                        };

                        PelbagaiGroup.itemPelbagai.ItemGroupPelbagai.push(tblListPelbagai);
                    }
                }


            });

            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")

            if (!confirm) {
                return
            }
            else {
                console.log(PelbagaiGroup);
                //show_loader();

                var result = JSON.parse(await saveRecordPelbagai(PelbagaiGroup));

                $('#totalRm').val(parseFloat(result.Payload.Jumlah).toFixed(2));
                //console.log($('#totalRm').val(result.Payload.Jumlah))
                //close_loader();
            }

        });

        async function saveRecordPelbagai(tblListPelbagai) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'MohonTuntutan_WS.asmx/SaveRecordBelanjaPelbagai',
                    method: 'POST',
                    data: JSON.stringify(tblListPelbagai),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var response = JSON.parse(data.d)
                        notification("Data telah disimpan");
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

        //function kiraan bagi elaun Makan

        $('#tblElaunMkn').on('change', '.JenisTugasElaunMkn-list.selection, .JnstempatElaunMkn-list.selection, .pagi, .tghari,.malam', async function (evt) {
            var $tr = $(this).closest("tr");

            var $ddlTugas = $tr.find(".JenisTugasElaunMkn-list.selection");
            var $ddlTempat = $tr.find(".JnstempatElaunMkn-list.selection");

            if ($ddlTugas[0].firstChild.value === "" || $ddlTempat[0].firstChild.value === "") {
                return;
            }

            var amaun = await GetAmaunPeratusMkn($ddlTugas[0].firstChild.value, $ddlTempat[0].firstChild.value);
            var $PeratusMkn = $tr.find(".form-control-txtPeratusMkn");
            $PeratusMkn.val(amaun.Payload[0].KadarMkn);

            CalculateElaun($tr);
        })

        $('#tblElaunMkn').on('keyup', '.form-control-txtbilEL', async function (evt) {
            var $tr = $(this).closest("tr");
            CalculateElaun($tr);
        })

        $('#tblElaunMkn').on('change', '.pagi,.tghari,.malam', async function (evt) {
            console.log("masuk 5337")
            var $tr = $(this).closest("tr");
            var $pagi = $tr.find(".pagi");
            var $tghari = $tr.find(".tghari");
            var $malam = $tr.find(".malam");
            var $statushari = $tr.find(".form-control-txtbilEL")
            console.log($statushari.val());
            //var $bilHari = $tr.find(".form-control-txtbilEL");
            var $harga = $tr.find(".form-control-txtHargaEL")
            var $PeratusMkn = $tr.find(".form-control-txtPeratusMkn")
            var $ElaunPagi = 0.00
            var $ElaunTghri = 0.00
            var $ElaunMalam = 0.00
            var $jumlahElaun = 0.00
            var $jumlahMkn = 0.00
            var $ratePagi, $rateTghari, $rateMalam
            //$PeratusMkn.val(amaun.Payload[0].KadarMkn);
            console.log($PeratusMkn.val())

            if (($pagi).prop('checked')) {
                $ratePagi = 0.2
                console.log($ratePagi);
                // $ElaunPagi = ($ratePagi.val() / 100) * $PeratusMkn.val()
                $ElaunPagi = $PeratusMkn.val() * 0.2;
                console.log($ElaunPagi)
            }
            

            if (($tghari).prop('checked')) {
                $rateTghari = 0.4
                console.log($rateTghari);
                // $ElaunPagi = ($ratePagi.val() / 100) * $PeratusMkn.val()
                $ElaunTghri = $PeratusMkn.val() * 0.4;
                console.log($ElaunTghri)
            }
           

            if (($malam).prop('checked')) {
                $rateMalam = 0.4
                console.log($rateMalam);
                // $ElaunPagi = ($ratePagi.val() / 100) * $PeratusMkn.val()
                $ElaunMalam = $PeratusMkn.val() * 0.4;
                console.log($ElaunMalam)
            }
           

            if ($statushari.val(0) === true) {
                console.log("masuk sini statusHari = 0")
                $jumlahElaun = ($ElaunPagi + $ElaunTghri + $ElaunMalam) / 2;
                $harga.val($jumlahElaun)
                console.log($harga.val())
            }
            else {
                $jumlahElaun = $ElaunPagi + $ElaunTghri + $ElaunMalam
                $harga.val($jumlahElaun)
                console.log($harga.val())
            }
          
            CalculateElaun($tr);
        })



        async function CalculateElaun($tr) {
            var $ddlTugas = $tr.find(".JenisTugasElaunMkn-list.selection");
            var $ddlTempat = $tr.find(".JnstempatElaunMkn-list.selection");
            var $hari = $tr.find(".form-control-txtbilEL");
            var $elaun = $tr.find(".form-control-txtHargaEL");
            var $amaun = $tr.find(".form-control-txtJumlahEL");
            var $PeratusMkn = $tr.find(".form-control-txtPeratusMkn")
            
            var $pagi = $tr.find(".pagi");
            var $tghari = $tr.find(".tghari");
            var $malam = $tr.find(".malam");
            var $ElaunPagi = 0.00
            var $ElaunTghri = 0.00
            var $ElaunMalam = 0.00

            if (isNaN($hari.val())) {
                $hari.val(0)
            }

            if (isNaN($elaun.val())) {
                $elaun.val(0);
            }

            if (($pagi).prop('checked')) {
                $ratePagi = 0.2
                console.log($ratePagi);
                // $ElaunPagi = ($ratePagi.val() / 100) * $PeratusMkn.val()
                $ElaunPagi = $PeratusMkn.val() * 0.2;
                console.log($ElaunPagi)
            }

            if (($tghari).prop('checked')) {
                $rateTghari = 0.4
                console.log($rateTghari);
                // $ElaunPagi = ($ratePagi.val() / 100) * $PeratusMkn.val()
                $ElaunTghri = $PeratusMkn.val() * 0.4;
                console.log($ElaunTghri)
            }

            if (($malam).prop('checked')) {
                $rateMalam = 0.4
                console.log($rateMalam);
                // $ElaunPagi = ($ratePagi.val() / 100) * $PeratusMkn.val()
                $ElaunMalam = $PeratusMkn.val() * 0.4;
                console.log($ElaunMalam)
            }

            if ($hari.val() === "0") {
                $jumlahElaun = ($ElaunPagi + $ElaunTghri + $ElaunMalam) / 2;
                var total = $jumlahElaun;
                $amaun.val(parseFloat(total).toFixed(2))
                console.log("total")
            }
            else {
                $jumlahElaun = $ElaunPagi + $ElaunTghri + $ElaunMalam
                var total = $hari.val() * $jumlahElaun;
                $amaun.val(parseFloat(total).toFixed(2))
            }
            
            console.log("total")            
            var KeseluruhanAmaun = 0.00;
            $elaun.val(parseFloat($jumlahElaun).toFixed(2))
            

            var $allAmaunt = $('.input-group__input.form-control-txtJumlahEL');

            $allAmaunt.each(function (ind, amaunObj) {
                if (amaunObj.value === "") {
                    return;
                }

                KeseluruhanAmaun += parseFloat(amaunObj.value);
            })

            $('#totalEL').val(parseFloat(KeseluruhanAmaun).toFixed(2))
        }

        async function GetAmaunPeratusMkn(jnsTugas, jnsTempat) {
            var hadGaji = $('#txtGredGaji').val();
            console.log({ jnsTugas: jnsTugas, jnsTempat: jnsTempat, hadGaji: hadGaji });
            try {

                const response = await fetch('MohonTuntutan_WS.asmx/kiraElaunMakan', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ jnsTugas: jnsTugas, jnsTempat: jnsTempat, hadGaji: hadGaji })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return error;
            }
        }

       

        $(document).ready(function () {
            $('#tblSewaHotelData').on('change', '.kongsi-bilik', async function (evt) {
              // $('.kongsi-bilik').click(function () {
                    if (this.checked) {
                        //alert("masuk kongsi Bilik");
                        //$('#SenaraiStaf').modal('toggle'); 
                        $('#PilihStaf').modal('toggle');


                    }
                    if (!this.checked) {
                        //alert("Tidak Kongsi");
                        $("#PilihStaf").modal("hide");
                    }

                });
            //});
     
        })

        var selectedData = [];

        $('.btnSimpanST').on('click', function () {
            $('.js-pilih-staf:checked').each(function (ind, obj) {
                console.log(ind);
                console.log(obj);
                    selectedData.push(obj.value);
                }  
            )

            console.log(selectedData);

            if (selectedData.length > 0) {

                //var noArahan = $('#txtNoArahan').val();
                var noTuntut = $('#txtMohonID6').val();

                 $.ajax({
                     url: 'MohonTuntutan_WS.asmx/SimpanStafKongsi',
                     method: 'POST',
                     contentType: 'application/json; charset=utf-8',
                     data: JSON.stringify({ selectedData: selectedData, noTuntut: noTuntut }),
                     success: function (data) {
                         // Handle the success response
                         console.log('Success:', data.d);
                         var response = JSON.parse(data.d);
                         notification(response.Message);
                         tbl1.ajax.reload();
                     },
                     error: function (xhr, status, error) {
                         // Handle the error response
                         console.error('Error:', error);
                     }
                 });
             }
         });

        $(document).ready(function () {

            tblCariStaf = $("#tblDataSenarai_trans").DataTable({
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
                },


                "ajax": {
                    "url": "MohonTuntutan_WS.asmx/LoadRecordStaf",
                    method: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify(d)
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },
                drawCallback: function (settings) {
                    // Your function to be called after loading data
                    close_loader();
                },
                "columns": [
                    {
                        "data": "MS01_NOSTAF",
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
                    { "data": "MS01_NAMA" },
                    { "data": "Singkatan" },
                    {
                        className: "text-center",
                        "data": "MS01_NOSTAF",
                        render: function (data, type, row, meta) {

                            if (type !== "display") {

                                return data;

                            }

                            return '<input type="checkbox"  class="_check js-pilih-staf" name="check" value="' + data + '">';
                            this.width = "5%";
                        }

                    }
                ]
            });

        });


        $('.kongsi-bilik').change(function () {  //jika user tick  checkbox sediakan makan function ni akan dilakukan
           // alert("masuk checkbox")
            StaKongsiBilik()
            });

        //$('#tab-pengesahan').click(async function () {

        //    console.log("masuk tab-pengesahan")
        //    $('#noPermohonan').val();
        //    var id = $('#noPermohonan').val();
        //    var tkhMohon1 = $('#tkhMohonCL').val();
        //    $('#txtMohonID8').val(id);
        //    //$('#tkhMohon7').val(tkhMohon1);


        //    if (id !== "") {
        //        //BACA DETAIL JURNAL
        //        var recordDataPengesahan = await AjaxGetDataPengesahan(id);  //Baca data pada table Keperluan
        //        //await clearAllRows();
        //        await SetDataPengesahanRows(null, recordDataPengesahan); //setData pada table
        //    }

        //    return false;

        //})

        //async function AjaxGetDataPengesahan(id) {

        //    try {

        //        const response = await fetch('MohonTuntutan_WS.asmx/GetDataPengesahan', {
        //            method: 'POST',
        //            headers: {
        //                'Content-Type': 'application/json'
        //            },
        //            body: JSON.stringify({ id: id })
        //        });
        //        const data = await response.json();
        //        return JSON.parse(data.d);
        //    } catch (error) {
        //        console.error('Error:', error);
        //        return false;
        //    }
        //}


        //async function SetDataPengesahanRows(totalClone, objOrder) {

        //    var counter = 1;
        //    var total = 0.00;
        //    var jumlah = 0.00;

        //    //if (objOrder !== null && objOrder !== undefined) {
        //    //    //totalClone = objOrder.Payload.OrderDetails.length;
        //    //    totalClone = objOrder.length;

        //    //}

        //    if (objOrder !== null && objOrder !== undefined) {
        //            var obj = objOrder.Payload;

        //            console.log(obj[counter - 1].No_Tuntutan);
        //            console.log(obj[counter - 1].Tarikh_Mohon);
        //            $('#txtMohonID8').val(obj[counter - 1].No_Tuntutan)
        //            $('#tkhMohon8').val(obj[counter - 1].Tarikh_Mohon)


        //        }

        //    }


        //Bila klik  tab-pengesahan
        $('#tab-pengesahan').click(async function () {
            console.log("masuk tab-pengesahan")
            $('#noPermohonan').val();
            var id = $('#noPermohonan').val();
            $('#txtMohonID8').val(id);


            if (id !== "") {
                //BACA DETAIL JURNAL
                var recordDataPengesahan = await AjaxPengesahan(id);  //Baca data pada table Keperluan             
                //await clearAllRows();
                await SetDataDataPengesahan(null, recordDataPengesahan); //setData pada table
            }
            return false;
        })


        async function simpanTotalPelbagai(id, total) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'TabPelbagai_WS.asmx/SaveJumlahPelbagai',
                    method: 'POST',
                    data: JSON.stringify({ id: id, total: total }),
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

        async function AjaxPengesahan(id) {

            try {

                const response = await fetch('MohonTuntutan_WS.asmx/GetDataPengesahan', {
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


        async function SetDataDataPengesahan(totalClone, objOrder) {
            console.log("masuk SetDataDataPengesahan")
            var counter = 1;
            var total = 0.00;
            var totalBersih = 0.00;
            var curNumObject = 0;
            var jumElaunMakan
            var jumHotel
            var jumPejlnKenderaan
            var jumTambangAwam
            var jumPelbagai
            var jumlahPendhuluan
            var jumSumbangan
            var tolakBaki

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;
            }

            if (objOrder !== null && objOrder !== undefined) {
                var obj = objOrder.Payload;


                if (obj[counter - 1].Jumlah_Elaun_Mkn === null) {
                    obj[counter - 1].Jumlah_Elaun_Mkn = 0.00;
                }
               
                jumElaunMakan = obj[counter - 1].Jumlah_Elaun_Mkn

                if (obj[counter - 1].Jumlah_Sewa_HotelLojing === null) {
                    obj[counter - 1].Jumlah_Sewa_HotelLojing = 0.00;
                }

                jumHotel = obj[counter - 1].Jumlah_Sewa_HotelLojing

                if (obj[counter - 1].Jumlah_Elaun_Kend === null) {
                    obj[counter - 1].Jumlah_Elaun_Kend = 0.00
                }

                jumPejlnKenderaan = obj[counter - 1].Jumlah_Elaun_Kend

                if (obj[counter - 1].Jumlah_Tambang_Awam === null) {
                    obj[counter - 1].Jumlah_Tambang_Awam = 0.00
                } else
                {
                    jumTambangAwam = obj[counter - 1].Jumlah_Tambang_Awam
                }

                if (obj[counter - 1].Jumlah_Belanja_Pelbagai === null) {
                    obj[counter - 1].Jumlah_Belanja_Pelbagai = 0.00
                }

                jumPelbagai = obj[counter - 1].Jumlah_Belanja_Pelbagai

                if (obj[counter - 1].Jum_Pendahuluan === null) {
                    obj[counter - 1].Jum_Pendahuluan = 0.00
                }
                jumlahPendhuluan = obj[counter - 1].Jum_Pendahuluan

                if (obj[counter - 1].Jum_Sumbangan === null) {
                    obj[counter - 1].Jum_Sumbangan=0.00
                }

                jumSumbangan = obj[counter - 1].Jum_Sumbangan

                $('#tkhMohon8').val(obj[counter - 1].Tarikh_Mohon);
                $('#JumElaun').val(parseFloat(obj[counter - 1].Jumlah_Elaun_Mkn).toFixed(2));
                $('#JumSewaHotel').val(parseFloat(obj[counter - 1].Jumlah_Sewa_HotelLojing).toFixed(2));
                $('#JumPerjalanan').val(parseFloat(obj[counter - 1].Jumlah_Elaun_Kend).toFixed(2));
                $('#JumTambang').val(parseFloat(obj[counter - 1].Jumlah_Tambang_Awam).toFixed(2));
                $('#JumPelbagai').val(parseFloat(obj[counter - 1].Jumlah_Belanja_Pelbagai).toFixed(2));
                $('#TolakPendahuluan').val(parseFloat(obj[counter - 1].Jum_Pendahuluan).toFixed(2));
                $('#TolakSumbangan').val(parseFloat(obj[counter - 1].Jum_Sumbangan).toFixed(2));

                tolakBaki = parseFloat(jumlahPendhuluan) + parseFloat(jumSumbangan)
                total = parseFloat(jumElaunMakan) + parseFloat(jumHotel) + parseFloat(jumPejlnKenderaan) + parseFloat(jumTambangAwam) + parseFloat(jumPelbagai)
                console.log(total)
                $('#JumKeseluruhan').val(parseFloat(total).toFixed(2));
                totalBersih = parseFloat(total) - parseFloat(tolakBaki)
                console.log(totalBersih);
                $('#jumBersih').val(parseFloat(totalBersih).toFixed(2));


            }
            else {
                console.log("masuk else")

            }

        }


        $('.btnAddRow_tabSumbangan').click(async function () {

            var totalClone = $(this).data("val");

            //await AddRow_tabEP(totalClone);
            await SetDataSumbanganRows(totalClone);
        });



        async function clearAlltblSumbangan() {
            console.log("masuk clearAlltblSumbangan ")
            $('#tblSumbangan' + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })

        }

        //Bila klik Tab tab-Sumbangan
        $('#tab-sumbangan').click(async function () {

            console.log("masuk sumbangan")
            $('#noPermohonan').val();
            var id = $('#noPermohonan').val();
            var tkhMohon = $('#tkhMohon2').val();
            $('#txtMohonID9').val(id);
            $('#tkhMohon9').val(tkhMohon);
            //loadDataKenyataan(id)

            var totalPelbagai = parseFloat($('#totalRm').val()).toFixed(2);
            console.log(totalPelbagai);

            await simpanTotalPelbagai(id, totalPelbagai)

            if (id !== "") {
                clearAlltblSumbangan();
                //BACA DETAIL JURNAL
                var recordDataSumbangan = await AjaxGetDataSumbangan(id);  //Baca data pada table Keperluan             
                //await clearAllRows();
                await SetDataSumbanganRows(null, recordDataSumbangan); //setData pada table
            }

            return false;

        });

        async function AjaxGetDataSumbangan(id) {

            try {

                const response = await fetch('MohonTuntutan_WS.asmx/GetDatSumbangan', {
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

        async function SetDataSumbanganRows(totalClone, objOrder) {

            var counter = 1
            var table = $('#tblSumbangan');
            var total = 0.00;
            var totalJarak;


            console.log("masuk  ")
            if (objOrder !== null && objOrder !== undefined) {   //semak berapa object yang ada
                totalClone = objOrder.length;
            }


            while (counter <= totalClone) {
                curNumObject += 1;
                console.log("curNumObject")
                console.log(curNumObject)

                var newId_bil = "txtBilSumbangan-list" + curNumObject; //create new object pada table
                var newId_JnsTabung = "ddlSumbangan" + curNumObject;
                var newId_jumlahSumbangan = "txtSumbangan" + curNumObject;


                var row = $('#tblSumbangan tbody>tr:first').clone();

                var $objBil = $(row).find(".txtBilSumbangan-list").attr("id", newId_bil);
                var jnsTabung = $(row).find(".JenisSumbangan-list").attr("id", newId_JnsTabung);
                var jumlahSumbang = $(row).find(".input-md-txtSumbangan").attr("id", newId_jumlahSumbangan);


                if (objOrder !== null && objOrder !== undefined) {
                    var obj = objOrder;
                    console.log(obj[counter - 1].Butiran);
                    console.log(obj[counter - 1].Jumlah_anggaran);

                    console.log("Next");
                    jnsTabung.val(obj[counter - 1].Butiran);
                    jumlahSumbang.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));


                    total += jumlahSumbang.val();

                    console.log($objBil.val($('.txtBilSumbangan-list').length));
                    console.log("3134");

                }
                else {
                    $objBil.val($('.txtBilSumbangan-list').length);
                }


                row.attr("style", "");  //style pada row
                $('#tblSumbangan tbody').append(row);  //bind data start pada row yang first pada tblData2

                generateDropdown_list("#" + newId_JnsTabung, "MohonTuntutan_WS.asmx/GetJenisSumbangan")

                var selectObj_JenisTabung = $('#' + newId_JnsTabung)
                jnsTabung.dropdown('set selected', objOrder[counter - 1].Kod_Tabung);
                selectObj_JenisTabung.append("<option value = '" + objOrder[counter - 1].Kod_Tabung + "'>" + objOrder[counter - 1].Kod_Tabung + " - " + objOrder[counter - 1].Butiran + "</option>")


                counter += 1;
            }
            $('#totalTabung').val(parseFloat(total).toFixed(2));

        }


        //di digunakan untuk kiraan auto calculate Jumlah setiap table
        $('#tblSumbangan').on('keyup', '.input-md-txtSumbangan', async function (evt) {
            console.log("keyup")
            var $tr = $(this).closest("tr");
            CalculateTabung($tr);
        });

        async function CalculateTabung($tr) {
            console.log("3701")
            var $amaun = $tr.find(".input-md-txtSumbangan");
            console.log($amaun.val())
            if (isNaN($amaun.val())) {
                $amaun.val(0)
            }

            var KeseluruhanAmaun = 0.00;
            var $allAmaunt = $('.input-md-txtSumbangan');

            $allAmaunt.each(function (ind, amaunObj) {
                if (amaunObj.value === "") {
                    return;
                }

                KeseluruhanAmaun += parseFloat(amaunObj.value);
            })

            $('#totalTabung').val(parseFloat(KeseluruhanAmaun).toFixed(2));
        };


        //event bila klik button simpan Sumbangan
        $('#btnSimpantab6').click(async function () {
            console.log("masuk sini")
            id = $('#noPermohonan').val();

            var item = {
                tabung: {
                    OrderID: $('#noPermohonan').val(),
                    Jumlah: $('#totalTabung').val(),
                    GroupSumbangan: []
                }
            }
            console.log($('#tblSumbangan tbody tr'));
            $('#tblSumbangan tbody tr').each(function (index, obj) {
                var staKenderaan
                var staMula
                var staTamat
                if (index > 0) {
                    console.log($(obj));
                    console.log("masuk btnSimpan ")

                    if ($(obj).find('.JenisSumbangan-list > select').val() !== "") {
                        var listSumbangan = {
                            mohonID: $('#noPermohonan').val(),
                            idbil: $(obj).find('.txtBilSumbangan-list').val(),
                            KodTabung: $(obj).find('.JenisSumbangan-list > select').val(),
                            Jumlah: $(obj).find('.input-md-txtSumbangan').val(),
                            JumSumbangan: $('#totalTabung').val(),
                        };
                        item.tabung.GroupSumbangan.push(listSumbangan);
                    }
                }

            });

            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
            console.log(confirm)
            //msg = "Anda pasti ingin menyimpan rekod ini?"

            if (!confirm) {
                return
            }
            else {

                //show_loader();

                var result = JSON.parse(await saveRecordSumbangan(item));
                //alert(result.Message)
                //$('#totalKt').val(parseFloat(result.Payload.Jumlah).toFixed(2));
                //console.log($('#totalKt').val(result.Payload.Jumlah))
                //close_loader();
            }
        });

        async function saveRecordSumbangan(list) {
            console.log("Sumbangan")
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'MohonTuntutan_WS.asmx/SaveRecordSumbanganDN',
                    method: 'POST',
                    data: JSON.stringify(list),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var response = JSON.parse(data.d)
                        notification("Data telah disimpan");
                        resolve(data.d);
                        //alert(resolve(data.d));
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }

                })
            })
        };

        $('.btnSimpanHantar').click(async function () {
            console.log("masuk butang hantar")
            var statusCheck

            if ($('#chckSah').is(':checked')) {
                statusCheck = "1"
            }
            else {
                statusCheck = "0"
            }

            if (statusCheck !== "1") {
                notification("Sila tandakan pengesahan pada kotak yang disediakan")
                return false;
            }




            console.log("semak ")

            console.log(statusCheck)
            var pengesahan = {
                PengesahanList: {
                    OrderID: $('#txtMohonID8').val(),
                    JumElaunMkn: $('#JumElaun').val(),
                    JumSewaHotel: $('#JumSewaHotel').val(),
                    JumElaunPjln: $('#JumPerjalanan').val(),
                    JumTambangAwam: $('#JumTambang').val(),
                    JumPelbagai: $('#JumPelbagai').val(),
                    JumAllTuntutan: $('#JumKeseluruhan').val(),
                    JumPendahuluan: $('#TolakPendahuluan').val(),
                    JumSumbangan: $('#TolakSumbangan').val(),
                    JumBersihTuntut: $('#jumBersih').val(),
                    JumBelanjaSendiri: $('#jumtdkDsokong').val(),
                    Folder: $('#hidJenDokBelanja').val(),
                    File_Name: $('#hidFileNameBelanja').val(),

                }
            }


            //ni tuk modal msg
            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
            console.log(confirm)
            if (!confirm) {
                return
            }
            else {

                var result = JSON.parse(await ajaxSavePengesahan(pengesahan));
                //$('.btnSimpan').style.display = 'none';  
            }

        });

        function show_message_async(msg, okfn, cancelfn) {

            $("#MessageModal .modal-body").text(msg);
            var decision = false
            return new Promise(function (resolve) {

                $('.btnYA').click(function () {
                    console.log("rreessoollvveedd")
                    decision = true
                });
                $("#MessageModal").on('hidden.bs.modal', function () {
                    resolve(decision);
                });


                $("#MessageModal").modal('show');
            })

        }

        async function ajaxSavePengesahan(dataSah) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'MohonTuntutan_WS.asmx/SaveRecordPengesahan',
                    method: 'POST',
                    data: JSON.stringify(dataSah),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var response = JSON.parse(data.d)
                        console.log(response);
                        notification(response.Message);
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

        function uploadFileBelanja() {
            console.log("masuk uploadFileBelanja")
            var fileInputBelanja = document.getElementById("fileInputBelanja");
            var file = fileInputBelanja.files[0];
            var id = $('#txtMohonID8').val();
            var jnsBelanja = "buktiBelanja"
            console.log(id);
            if (file) {
                var fileSize = file.size; // File size in bytes
                var maxSize = 3 * 1024 * 1024; // Maximum size in bytes (3MB)

                if (fileSize <= maxSize) {
                    // File size is within the allowed limit

                    var fileName = file.name;
                    var fileExtension = fileName.split('.').pop().toLowerCase();

                    // Check if the file extension is PDF or Excel
                    //if (fileExtension === 'pdf' || fileExtension === 'xlsx' || fileExtension === 'xls') {
                    if (fileExtension === 'pdf') {
                        var reader = new FileReader();
                        reader.onload = function (e) {

                            var fileData = e.target.result; // Base64 string representation of the file data
                            var fileName = file.name;

                            var requestData = {
                                fileData: "test",
                                fileName: fileName
                            };

                            var frmData = new FormData();

                            frmData.append("fileSurat", $('input[id="fileInputBelanja"]').get(0).files[0]);
                            frmData.append("fileName", fileName);
                            frmData.append("fileSize", fileSize);
                            frmData.append("idMohon", id);
                            frmData.append("jnsBelanja", jnsBelanja);


                            $('#hidJenDokBelanja').val(fileExtension);
                            $('#hidFileNameBelanja').val(fileName);


                            $.ajax({
                                url: "MohonTuntutan_WS.asmx/UploadFile",
                                type: 'POST',
                                data: frmData,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (response) {
                                    // Show the uploaded file name on the screen
                                    // $("#uploadedFileNameLabel").text(fileName);

                                    var fileLink = document.createElement("a");
                                    fileLink.href = requestData.resolvedUrl + fileName;
                                    fileLink.textContent = fileName;

                                    var uploadedFileNameLabel = document.getElementById("uploadedFileNameLabelBelanja");
                                    uploadedFileNameLabel.innerHTML = "";
                                    uploadedFileNameLabel.appendChild(fileLink);


                                    $("#uploadedFileNameLabel").show();
                                    // Clear the file input
                                    $("#fileInputBelanja").val("");

                                    $("#progressContainerBelanja").text("File uploaded successfully.");
                                },
                                error: function () {
                                    $("#progressContainerBelanja").text("Error uploading file.");
                                }
                            });
                        };

                        reader.readAsArrayBuffer(file);
                    } else {
                        // Invalid file type
                        //alert("Only PDF and Excel files are allowed.");
                        notification("Only PDF and Excel files are allowed.")
                    }
                } else {
                    // File size exceeds the allowed limit
                    //alert("File size exceeds the maximum limit of 3MB");
                    notification("File size exceeds the maximum limit of 3MB")
                }
            } else {
                // No file selected
                //alert("Please select a file to upload");
                notification("Please select a file to upload")
            }
        }





        function notification(msg) {
            $("#notify").html(msg);
            $("#NotifyModal").modal('show');
        }

        function show_message_async(msg, okfn, cancelfn) {

            $("#MessageModal .modal-body").text(msg);
            var decision = false
            return new Promise(function (resolve) {

                $('.btnYA').click(function () {
                    console.log("rreessoollvveedd")
                    decision = true
                });
                $("#MessageModal").on('hidden.bs.modal', function () {
                    resolve(decision);
                });


                $("#MessageModal").modal('show');
            })

        }




        //$('#Permohonan').click(async function () {
        //    // $('#noPermohonan').val(orderDetail.No_Tuntutan)
        //    console.log("2887")
        //    $('#tab-Kenyataan').disable();
        //    $('#tab-elaunPjln').disable();
        //    $('#tab-pengangkutan').disable();
        //    $('#tab-elaunMakan').disable();
        //    $('#tab-sewaHotel').disable();
        //    $('#tab-pelbagai').disable();
        //    $('#tab-pengesahan').disable();

        //});






    </script>
</asp:Content>
