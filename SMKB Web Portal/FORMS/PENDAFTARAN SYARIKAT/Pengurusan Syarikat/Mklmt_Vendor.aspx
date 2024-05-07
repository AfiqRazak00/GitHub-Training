<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Mklmt_Vendor.aspx.vb" Inherits="SMKB_Web_Portal.Mklmt_Vendor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <style>
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
            z-index: 3;
        }

        .input-group__input {
            width: 100%;
            height: 40px;
            border: 1px solid #dddddd;
            border-radius: 5px;
        }

            .input-group__input:not(:-moz-placeholder-shown) + label {
                background-color: white;
                line-height: 10px;
                opacity: 1;
                font-size: 10px;
                top: -5px;
            }

            .input-group__input:not(:empty) + label {
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

            .input-group__input:not(:placeholder-shown) + label,
            .input-group__input:focus + label {
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


        .input-group__select + label,
        .input-group__select:focus-within + label {
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

    <div id="MklmtVendorTab" class="tabcontent" style="display: block">

        <ul class="nav nav-tabs" id="myTabs">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#mklmtSya">Maklumat Syarikat</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#mklmtCaw">Maklumat Cawangan</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#mklmtDaftarSijil">Maklumat Pendaftaran Perniagaan</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#mklmtPengalaman">Maklumat Pengalaman</a>
            </li>
        </ul>

        <div class="tab-content">
            <div class="tab-pane fade show active" id="mklmtSya">
                <div class="form-group row col-md-12">
                    <div class="form-group row col-md-3">
                        <div class="panel-heading col-md-12">
                            <br />
                            <h6 class="panel-title">Maklumat Syarikat</h6>
                            <label id="IdSyarikat"></label>
                        </div>

                        <div class="col-md-12">
                            <div class="form-group input-group">
                                <input type="text" class="input-group__input form-control input-sm " placeholder="" id="noDaftar" name="noDaftar" readonly />
                                <label class="input-group__label">Nombor Pendaftaran (SSM)</label>
                            </div>
                            <div class="form-group input-group">
                                <input type="text" class="input-group__input form-control input-sm " placeholder="" id="namaSya" name="namaSya" readonly />
                                <label class="input-group__label">Nama Syarikat</label>
                            </div>
                            <div class="form-group input-group">
                                <label for="lblPerniagaanUtama">Perniagaan Utama</label>
                                <div class="form-check form-check-inline">
                                    <input type="checkbox" class="form-check-input" id="chckBekalan">
                                    <label class="form-check-label" for="chckBekalan">Bekalan</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input type="checkbox" class="form-check-input" id="chckPerkhidmatan">
                                    <label class="form-check-label" for="chckPerkhidmatan">Perkhidmatan</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <input type="checkbox" class="form-check-input" id="chckKerja">
                                    <label class="form-check-label" for="chckKerja">Kerja</label>
                                </div>
                            </div>
                            <div class="form-group input-group">
                                <input type="text" class="input-group__input form-control input-sm " placeholder="" id="gredKerja" name="gredKerja" readonly />
                                <label class="input-group__label">Gred Kerja</label>
                            </div>
                            <div id="statBumi" class="form-group">
                                <label for="lblStatBumi">Status Bumiputera: </label>
                                <div class="form-check-inline">
                                    <label class="form-check-label col-md-7">
                                        <input type="checkbox" class="form-check-input" id="chckBukanBumi" name="chckStatBumi">Bukan Bumiputera
                                    </label>
                                    &nbsp;
                                    <label class="form-check-label col-md-5">
                                        <input type="checkbox" class="form-check-input" id="chckBumi" name="chckStatBumi">Bumiputera
                                    </label>
                                    &nbsp;
                                </div>
                            </div>
                            <div class="form-group input-group">
                                <input type="text" class="input-group__input form-control input-sm " placeholder="" id="statLulus" name="statLulus" readonly />
                                <label class="input-group__label">Status Lulus</label>
                            </div>
                            <div class="form-group input-group">
                                <input type="text" class="input-group__input form-control input-sm " placeholder="" id="statAktif" name="statAktif" readonly />
                                <label class="input-group__label">Status Aktif</label>
                            </div>
                            <div class="form-group input-group" style="visibility: hidden;">
                                <input type="text" class="input-group__input form-control input-sm " placeholder="" id="1" name="1" readonly />
                                <label class="input-group__label">Dummy</label>
                            </div>
                            <div class="form-group input-group" style="visibility: hidden;">
                                <input type="text" class="input-group__input form-control input-sm " placeholder="" id="2" name="2" readonly />
                                <label class="input-group__label">Dummy</label>
                            </div>
                        </div>

                        <!-- CheckBox Katergori Syarikat -->
                        <%--<div id="katSya" class="form-group col-md-12">
                            <label for="lblKatSya">Kategori Syarikat <a style="color: red">*</a> : </label>
                            <div class="form-check-inline col-md-12">
                                <label class="form-check-label col-md-4">
                                    <input type="checkbox" class="form-check-input" id="chckKatSyaE" name="chckKatSya">Enterprise / Trading
                                </label>
                                &nbsp;
                                    <label class="form-check-label col-md-4">
                                        <input type="checkbox" class="form-check-input" id="chckKatSyaS" name="chckKatSya">Sdn. Bhd. / Bhd.
                                    </label>
                                &nbsp;
                            </div>
                        </div>--%>
                    </div>

                    <div class="col-md-4">
                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Alamat</h6>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-md-12">

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtAlmtPerniagaan1" name="txtAlmtPerniagaan1" readonly />
                                            <label class="input-group__label">Alamat Baris Pertama</label>
                                        </div>

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtAlmtPerniagaan2" name="txtAlmtPerniagaan2" readonly />
                                            <label class="input-group__label">Alamat Baris Kedua</label>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group input-group">
                                                    <%-- <select class=" input-group__select ui search dropdown" placeholder="" name="ddlPoskod" id="ddlPoskod"></select>
                                                    <label class="input-group__label">Poskod </label>--%>
                                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="PoskodSya" name="PoskodSya" readonly />
                                                    <label class="input-group__label">Poskod</label>
                                                </div>

                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group input-group">
                                                    <%--<select class=" input-group__select ui search dropdown" placeholder="" name="ddlBandar" id="ddlBandar"></select>
                                                    <label class="input-group__label">Bandar </label>--%>
                                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="BandarSya" name="BandarSya" readonly />
                                                    <label class="input-group__label">Bandar</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group input-group">
                                                    <%-- <select class=" input-group__select ui search dropdown" placeholder="" name="ddlNegeri" id="ddlNegeri"></select>
                                                    <label class="input-group__label">Negeri </label>--%>
                                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="NegeriSya" name="NegeriSya" readonly />
                                                    <label class="input-group__label">Negeri</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group input-group">
                                                    <%--<select class=" input-group__select ui search dropdown" placeholder="" name="ddlNegara" id="ddlNegara"></select>
                                                    <label class="input-group__label">Negara </label>--%>
                                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="NegaraSya" name="NegaraSya" readonly />
                                                    <label class="input-group__label">Negara</label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtWeb" name="txtWeb" readonly />
                                            <label class="input-group__label">Laman Web URL </label>
                                        </div>

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtEmailSya" name="txtEmailSya" readonly />
                                            <label class="input-group__label">Email </label>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtTel1" name="txtTel1" readonly />
                                                    <label class="input-group__label">No. Telefon Pertama </label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtTel2" name="txtTel2" readonly />
                                                    <label class="input-group__label">No. Telefon Kedua </label>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtNoFax" name="txtNoFax" readonly />
                                            <label class="input-group__label">No. Faksimili </label>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Maklumat Pegawai Untuk Dihubungi Pertama</h6>
                        </div>
                        <br />

                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNamaPegawai1" id="txtNamaPegawai1" readonly>
                            <label class="input-group__label">Nama</label>
                        </div>
                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtJwtPegawai1" id="txtJwtPegawai1" readonly>
                            <label class="input-group__label">Jawatan</label>
                        </div>

                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtEmailPegawai1" id="txtEmailPegawai1" readonly>
                            <label class="input-group__label">Emel</label>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPeg1" id="txtNoTelPeg1" readonly>
                                    <label class="input-group__label">No. Telefon Bimbit</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPejPeg1" id="txtNoTelPejPeg1" readonly>
                                    <label class="input-group__label">No. Telefon Pejabat</label>
                                </div>
                            </div>
                        </div>

                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Maklumat Pegawai Untuk Dihubungi Kedua</h6>
                        </div>
                        <br />
                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNamaPegawai2" id="txtNamaPegawai2" readonly>
                            <label class="input-group__label">Nama</label>
                        </div>

                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtJwtPegawai2" id="txtJwtPegawai2" readonly>
                            <label class="input-group__label">Jawatan</label>
                        </div>

                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtEmailPegawai2" id="txtEmailPegawai2" readonly>
                            <label class="input-group__label">Emel</label>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPeg2" id="txtNoTelPeg2" readonly>
                                    <label class="input-group__label">Nombor Telefon Bimbit</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPejPeg2" id="txtNoTelPejPeg2" readonly>
                                    <label class="input-group__label">Nombor Telefon Pejabat</label>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Maklumat Bank -->
                    <div class="col-md-2">

                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Maklumat Bank</h6>
                        </div>
                        <br />


                        <div class="form-group input-group">
                            <%--<select class=" input-group__input form-control input_sm ui search dropdown ddlKodBank " name="ddlKodBank" id="ddlKodBank">
                            </select>
                            <label class="input-group__label">Kod bank</label>--%>
                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="BankSya" name="BankSya" readonly />
                            <label class="input-group__label">Bank</label>
                        </div>

                        <div class="form-group input-group">
                            <input type="text" class="input-group__input form-control input-sm " placeholder="" id="txtNoAkaun" name="txtNoAkaun" readonly />
                            <label class="input-group__label">Nombor Akaun</label>
                        </div>


                    </div>

                </div>
            </div>

            <div class="tab-pane fade show" id="mklmtCaw">
                <div class="form-group row col-md-12">
                    <div class="col-md-4">
                        <div class="panel-heading col-md-12">
                            <br />
                            <h6 class="panel-title">Maklumat Cawangan</h6>
                            <%--<label id="IdCaw"></label>--%>
                        </div>
                        <br />

                        <div class="row">
                            <div class="col-md-12">


                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtAlmtCaw1" name="txtAlmtCaw1" readonly />
                                    <label class="input-group__label">Alamat Baris Pertama</label>
                                </div>

                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtAlmtCaw2" name="txtAlmtCaw2" readonly />
                                    <label class="input-group__label">Alamat Baris Kedua</label>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group input-group">
                                            <%--<select class=" input-group__select ui search dropdown" placeholder="" name="ddlPoskodCaw" id="ddlPoskodCaw"></select>
                                            <label class="input-group__label">Poskod </label>--%>
                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="poskodCaw" id="poskodCaw" readonly>
                                            <label class="input-group__label">Poskod</label>
                                        </div>

                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group input-group">
                                            <%--<select class=" input-group__select ui search dropdown" placeholder="" name="ddlBandarCaw" id="ddlBandarCaw"></select>
                                            <label class="input-group__label">Bandar </label>--%>
                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="bandarCaw" id="bandarCaw" readonly>
                                            <label class="input-group__label">Bandar</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group input-group">
                                            <%--<select class=" input-group__select ui search dropdown" placeholder="" name="ddlNegeriCaw" id="ddlNegeriCaw"></select>
                                            <label class="input-group__label">Negeri </label>--%>
                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="NegeriCaw" id="NegeriCaw" readonly>
                                            <label class="input-group__label">Negeri</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group input-group">
                                            <%--<select class=" input-group__select ui search dropdown" placeholder="" name="ddlNegaraCaw" id="ddlNegaraCaw"></select>
                                            <label class="input-group__label">Negara </label>--%>
                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="NegaraCaw" id="NegaraCaw" readonly>
                                            <label class="input-group__label">Negara</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtWebCaw" name="txtWebCaw" readonly />
                                    <label class="input-group__label">Laman Web URL </label>
                                </div>

                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtEmailSyaCaw" name="txtEmailSyaCaw" readonly />
                                    <label class="input-group__label">Email </label>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtTel1Caw" name="txtTel1Caw" readonly />
                                            <label class="input-group__label">No. Telefon Pertama </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtTel2Caw" name="txtTel2Caw" readonly />
                                            <label class="input-group__label">No. Telefon Kedua </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtNoFaxCaw" name="txtNoFaxCaw" readonly />
                                    <label class="input-group__label">No. Faksimili </label>
                                </div>

                            </div>
                        </div>

                    </div>

                    <!-- Mklmt Pegawai -->
                    <div class="col-md-4">
                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Maklumat Pegawai Untuk Dihubungi Pertama</h6>
                        </div>
                        <br />

                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNamaPegawaiCaw1" id="txtNamaPegawaiCaw1" readonly>
                            <label class="input-group__label">Nama</label>
                        </div>
                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtJwtPegawaiCaw1" id="txtJwtPegawaiCaw1" readonly>
                            <label class="input-group__label">Jawatan</label>
                        </div>

                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtEmailPegawaiCaw1" id="txtEmailPegawaiCaw1" readonly>
                            <label class="input-group__label">Emel</label>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPegCaw1" id="txtNoTelPegCaw1" readonly>
                                    <label class="input-group__label">No. Telefon Bimbit</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPejPegCaw1" id="txtNoTelPejPegCaw1" readonly>
                                    <label class="input-group__label">No. Telefon Pejabat</label>
                                </div>
                            </div>
                        </div>

                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Maklumat Pegawai Untuk Dihubungi Kedua</h6>
                        </div>
                        <br />
                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNamaPegawaiCaw2" id="txtNamaPegawaiCaw2" readonly>
                            <label class="input-group__label">Nama</label>
                        </div>

                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtJwtPegawaiCaw2" id="txtJwtPegawaiCaw2" readonly>
                            <label class="input-group__label">Jawatan</label>
                        </div>

                        <div class="form-group input-group">
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtEmailPegawaiCaw2" id="txtEmailPegawaiCaw2" readonly>
                            <label class="input-group__label">Emel</label>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPegCaw2" id="txtNoTelPegCaw2" readonly>
                                    <label class="input-group__label">Nombor Telefon Bimbit</label>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group input-group">
                                    <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPejPegCaw2" id="txtNoTelPejPegCaw2" readonly>
                                    <label class="input-group__label">Nombor Telefon Pejabat</label>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Mklmt Bank Caw -->
                    <div class="col-md-4">

                        <div class="panel-heading">
                            <br />
                            <h6 class="panel-title">Maklumat Bank</h6>
                        </div>
                        <br />


                        <div class="form-group input-group">
                            <%--<select class=" input-group__input form-control input_sm ui search dropdown ddlKodBank " name="ddlKodBankCaw" id="ddlKodBankCaw">
                            </select>
                            <label class="input-group__label">Kod bank</label>--%>
                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="BankCaw" id="BankCaw" readonly>
                            <label class="input-group__label">Bank</label>
                        </div>

                        <div class="form-group input-group">
                            <input type="text" class="input-group__input form-control input-sm " placeholder="" id="txtNoAkaunCaw" name="txtNoAkaunCaw" readonly />
                            <label class="input-group__label">Nombor Akaun</label>
                        </div>
                    </div>
                </div>

                <!-- DataTable Maklumat Cawangan -->
                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblDataCawangan" class="table table-striped" style="width: 95%">
                                <thead>
                                    <tr>
                                        <th scope="col">Bil</th>
                                        <th scope="col">Nama Cawangan</th>
                                        <th scope="col">Negeri</th>
                                        <th scope="col">Negara</th>
                                        <th scope="col">Pegawai Pertama</th>
                                        <th scope="col">No. Telefon Pegawai Pertama</th>

                                    </tr>
                                </thead>
                                <tbody id="tableID_Senarai_Cawangan">
                                </tbody>

                            </table>

                        </div>
                    </div>
                </div>

            </div>

            <div class="tab-pane fade show" id="mklmtDaftarSijil">
                <div class="form-group col-md-12">
                    <div class="panel-heading col-md-12">
                        <br />
                        <h6 class="panel-title">Maklumat Pendaftaran Perniagaan</h6>
                        <label id="IdDaftar"></label>
                    </div>

                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataMklmtDaftar" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">Kod Daftar</th>
                                            <th scope="col">No Pendaftaran</th>
                                            <th scope="col">Tarikh Berkuatkuasa</th>
                                            <th scope="col">Tarikh Tamat</th>
                                            <th scope="col">Lampiran</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_Daftar">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <hr />

                    <div class="panel-heading col-md-12">
                        <br />
                        <h6 class="panel-title">Maklumat Bidang Perniagaan (MOF)</h6>
                    </div>

                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataListBidang" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">Kod Bidang</th>
                                            <th scope="col">BIdang</th>

                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Bidang_MOF">
                                    </tbody>

                                </table>

                            </div>
                        </div>
                    </div>

                    <hr />

                    <div class="panel-heading col-md-12">
                        <br />
                        <h6 class="panel-title">Maklumat Pengkhususan Perniagaan (CIDB)</h6>
                    </div>

                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataListKat" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">Gred Kerja</th>
                                            <th scope="col">kategori</th>
                                            <th scope="col">Kod Khusus</th>
                                            <th scope="col">Pengkhususan</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_List_Kat">
                                    </tbody>

                                </table>

                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="tab-pane fade show" id="mklmtPengalaman">
                <div class="form-group row col-md-12">
                    <div class="form-group row col-md-3">
                        <div class="panel-heading col-md-12">
                            <br />
                            <h6 class="panel-title">Maklumat Pengalaman</h6>
                            <label id="IdPengalaman"></label>
                        </div>
                    </div>
                </div>

                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblDataPengalaman" class="table table-striped" style="width: 95%">
                                <thead>
                                    <tr data-id="idPengalaman">
                                        <th scope="col">Bil</th>
                                        <th scope="col">Tajuk Project</th>
                                        <th scope="col">Syarikat yang Menawarkan Kerja</th>
                                        <th scope="col">Tarikh Mula Projek</th>
                                        <th scope="col">NIlai Projek(RM)</th>

                                    </tr>
                                </thead>
                                <tbody id="tableID_Senarai_Pengalaman">
                                </tbody>

                            </table>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Model Semak -->
        <div class="modal fade" id="semakModal" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleMklmtCawangan">Semakan Pendaftaran Vendor</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <div class="col-md-12">
                            <!-- Form Pilih Status_Lulus 03/05 -->
                            <div class="form-group input-group">
                                <input type="text" class="input-group__input form-control input-sm " placeholder="" id="noDaftarSemak" name="noDaftarSemak" readonly />
                                <label class="input-group__label">Nombor Pendaftaran (SSM)</label>
                            </div>
                            <div class="form-group input-group">
                                <input type="text" class="input-group__input form-control input-sm " placeholder="" id="namaSyaSemak" name="namaSyaSemak" readonly />
                                <label class="input-group__label">Nama Syarikat</label>
                            </div>

                            <div id="semakStatLulus" class="form-group">
                                <label for="lblStatLulus">Status Lulus: </label>
                                <div class="form-check-inline">
                                    <label class="form-check-label col-md-7">
                                        <input type="radio" class="form-check-input" id="radioKemaskini" name="radioSemakKelulusan">Kemaskini Pendaftaran
                                    </label>
                                    &nbsp;
                                    <label class="form-check-label col-md-5">
                                        <input type="radio" class="form-check-input" id="radioTungguKelulusan" name="radioSemakKelulusan">Menunggu Kelulusan Pendaftaran
                                    </label>
                                    &nbsp;
                                </div>
                            </div>

                            <div class="form-group input-group" id="inputUlasanSemak" style="display:none;">
                                <textarea class="input-group__input form-control" placeholder="" id="ulasanSemak" name="ulasanSemak"></textarea>
                                <label class="input-group__label">Ulasan</label>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <%-- <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>--%>
                        <button type="button" runat="server" id="btnHantarSemak" class="btn btn-success btnHantarSemak">Hantar</button>
                    </div>

                </div>
            </div>
        </div>

        <!-- Model Lulus -->
        <div class="modal fade" id="KelulusanModal" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleKelulusan">Kelulusan Pendaftaran Vendor</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <div class="col-md-12">
                            <!-- Form Pilih Status_Lulus 03/05 -->
                            <div class="form-group input-group">
                                <input type="text" class="input-group__input form-control input-sm " placeholder="" id="noDaftarKelulusan" name="noDaftarKelulusan" readonly />
                                <label class="input-group__label">Nombor Pendaftaran (SSM)</label>
                            </div>
                            <div class="form-group input-group">
                                <input type="text" class="input-group__input form-control input-sm " placeholder="" id="namaSyaKelulusan" name="namaSyaKelulusan" readonly />
                                <label class="input-group__label">Nama Syarikat</label>
                            </div>
                            <div id="StatKelulusan" class="form-group">
                                <label for="lblStatLulus">Status Lulus: </label>
                                <div class="form-check-inline">
                                    <label class="form-check-label col-md-7">
                                        <input type="radio" class="form-check-input" id="radioLulus" name="radioKelulusan">Lulus
                                    </label>
                                    &nbsp;
                            <label class="form-check-label col-md-5">
                                <input type="radio" class="form-check-input" id="radioTakLulus" name="radioKelulusan">Tidak Lulus
                            </label>
                                    &nbsp;
                                </div>
                            </div>

                            <!-- Ulasan -->

                            <div class="form-group input-group" id="inputUlasan" style="display: none;">
                                <textarea class="input-group__input form-control" placeholder="" id="ulasanKelulusan" name="ulasanKelulusan"></textarea>
                                <label class="input-group__label">Ulasan</label>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <%-- <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>--%>
                        <button type="button" runat="server" id="btnHantarKelulusan" class="btn btn-success btnHantarKelulusan">Hantar</button>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal-footer modal-footer--sticky" id="footerSemakanDaftar">
            <div class="form-group col-md-12">
                <div class="row">
                    <div class="col-md-6" align="left">
                        <!-- Button semak(kanan) and kembali(kiri) -->
                        <button type="button" class="btn btn-primary btnKembali" data-toggle="tooltip" data-placement="bottom" title="Kembali" style="display:none;">
                            <i class="fa fa-arrow-left" aria-hidden="true"></i>Kembali</button>
                        <button type="button" class="btn btn-primary btnKembaliKelulusan" data-toggle="tooltip" data-placement="bottom" title="Kembali" style="display:none;">
                            <i class="fa fa-arrow-left" aria-hidden="true"></i>Kembali</button>
                    </div>
                    <div class="col-md-6" align="right">
                        <button type="button" class="btn btn-success btnSemak" data-toggle="tooltip" data-placement="bottom" title="Semakan" style="display: none;">
                            <i class="fa fa-check" aria-hidden="true"></i>Semak</button>
                        <button type="button" class="btn btn-success btnKelulusan" data-toggle="tooltip" data-placement="bottom" title="Kelulusan" style="display: none;">
                            <i class="fa fa-check" aria-hidden="true"></i>Kelulusan</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Confirmation Modal -->
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
                        <button type="button" class="btn btn-secondary btnYa" style="display:none;">Ya</button>
                        <button type="button" class="btn btn-secondary btnYaLulus" style="display:none;">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Makluman Modal -->
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
                        <button type="button" class="btn btn-secondary" id="tutupMakluman"
                            data-dismiss="modal">
                            Tutup</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script type="text/javascript">

        $('.btnKembali').click(async function () {
            var url = '<%=ResolveClientUrl("~/FORMS/PENDAFTARAN SYARIKAT/Pengurusan Syarikat/Syarikat_Berdaftar.aspx")%>';
            location.replace(url, '_blank');
        });

        $('.btnKembaliKelulusan').click(async function () {
            var url = '<%=ResolveClientUrl("~/FORMS/PENDAFTARAN SYARIKAT/Pengurusan Syarikat/Kelulusan_Syarikat.aspx")%>';
            location.replace(url, '_blank');
        });

        $('.btnSemak').click(async function () {

            // Clear Input Fields
            //$(".modal-body input").val("");
            //$(".modal-body textarea").val("");

            //Open Modal
            $('#semakModal').modal('toggle');

        });

        $('.btnKelulusan').click(async function () {
            $('#KelulusanModal').modal('toggle');
        });

        const searchParams = new URLSearchParams(window.location.search);
        var IdSya = searchParams.get('idSya');
        var menu = searchParams.get('menu');

        if (menu === "070102") {
            $('.btnKelulusan').show();
            $('.btnSemak').hide();
            $('.btnYaLulus').show();
            $('.btnYa').hide();
            $('.btnKembali').hide();
            $('.btnKembaliKelulusan').show();

            $('input[name="radioKelulusan"]').change(function () {
                if ($(this).attr('id') == 'radioTakLulus') {
                    // Show Ulasan input when 'Tidak Lulus' is selected
                    $('#inputUlasan').show();
                } else {
                    // Hide Ulasan input when 'Lulus' is selected
                    $('#inputUlasan').hide();
                }
            });
        } else {
            $('.btnKelulusan').hide();
            $('.btnSemak').show();
            $('.btnYaLulus').hide();
            $('.btnYa').show();
            $('.btnKembali').show();
            $('.btnKembaliKelulusan').hide();

            $('input[name="radioSemakKelulusan"]').change(function () {
                if ($(this).attr('id') == 'radioKemaskini') {
                    // Show Ulasan input when 'Tidak Lulus' is selected
                    $('#inputUlasanSemak').show();
                } else {
                    // Hide Ulasan input when 'Lulus' is selected
                    $('#inputUlasanSemak').hide();
                }
            });
        }

        var tblMklmtDaftar;
        var tblListBidang;
        var tblListKat;
        var tblListCaw;
        var tblListPengalaman;


        $(document).ready(function () {
            const searchParams = new URLSearchParams(window.location.search);
            let IdSya = searchParams.get('idSya');
            sessionStorage.setItem("NoSya", IdSya);
            let KodDaftar;
            /* show_loader();*/
            tblListCaw = $("#tblDataCawangan").DataTable({
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
                    "url": '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PENDAFTARAN/Pendaftaran_WS.asmx/LoadList_SenaraiCawangan")%>',
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            idSemSya: IdSya,
                        })
                        //akhir sini
                    }
                },
                "rowCallback": function (row, data) {
                    // Add hover effect
                    //$(row).hover(function () {
                    //    $(this).addClass("hover pe-auto bg-warning");
                    //}, function () {
                    //    $(this).removeClass("hover pe-auto bg-warning");
                    //});

                    // Add click event
                    //$(row).on("click", function () {
                    //    rowClickHandler(data);
                    //});
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
                    { "data": "NamaCaw" },
                    { "data": "ButiranNegeri" },
                    { "data": "ButiranNegara" },
                    { "data": "NamaPeg1" },
                    { "data": "TelPeg1" }
                ]
            });

            /* show_loader();*/
            tblMklmtDaftar = $("#tblDataMklmtDaftar").DataTable({
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
                    "url": "SyarikatBerDaftar_WS.asmx/LoadData_PendaftaranSijil",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        var dataJson = JSON.parse(json.d);
                        console.log(dataJson);

                        if (dataJson.length > 0) {
                            // Assuming ID_Dok is a property directly present in each row
                            var bilFromResponse = dataJson[0].Bil || '';

                            // Modify the data to include ID_Dok in each row
                            dataJson = dataJson.map(function (row) {
                                row.Bil = bilFromResponse;
                                return row;
                            });

                            return dataJson;
                        } else {
                            return false;
                        }

                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            IdSya: IdSya,
                        })
                        //akhir sini
                    }
                },
                "rowCallback": function (row, data) {
                    // Add hover effect
                    //$(row).hover(function () {
                    //    $(this).addClass("hover pe-auto bg-warning");
                    //}, function () {
                    //    $(this).removeClass("hover pe-auto bg-warning");
                    //});

                    // Add click event
                    //$(row).on("click", function () {
                    //    rowClickHandler(data);
                    //});
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
                    { "data": "Kod_Daftar" },
                    { "data": "No_Daftar" },
                    { "data": "TkhMula" },
                    { "data": "TkhTamat" },
                    {
                        "data": "Nama_Dok",
                        "render": function (data, type, row) {

                            var fileName = data;
                            //IdDokSSM = row.ID_Dok;
                            var BilSijil = row.Bil;
                            KodDaftar = row.Kod_Daftar;

                            var link = `<a href="#" onclick="OpenFile('${fileName}', '${BilSijil}','${KodDaftar}'); return false;">${fileName}</a>`;
                            return link;
                        }
                    },
                ]
            });

            /* show_loader();*/

            tblListBidang = $("#tblDataListBidang").DataTable({
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
                    "url": '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PENDAFTARAN/Pendaftaran_WS.asmx/LoadList_Bidang")%>',
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            idSya: IdSya,
                        })
                        //akhir sini
                    }
                },
                "rowCallback": function (row, data) {
                    // Add hover effect
                    //$(row).hover(function () {
                    //    $(this).addClass("hover pe-auto bg-warning");
                    //}, function () {
                    //    $(this).removeClass("hover pe-auto bg-warning");
                    //});

                    // Add click event
                    //$(row).on("click", function () {
                    //    rowClickHandler(data);
                    //});
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
                    { "data": "Kod_Bidang" },
                    { "data": "Butiran" }
                ]
            });



            /* show_loader();*/
            tblListKat = $("#tblDataListKat").DataTable({
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
                    "url": '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PENDAFTARAN/Pendaftaran_WS.asmx/LoadList_Pengkhusus")%>',
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            idSya: IdSya,
                        })
                        //akhir sini
                    }
                },
                "rowCallback": function (row, data) {
                    // Add hover effect
                    //$(row).hover(function () {
                    //    $(this).addClass("hover pe-auto bg-warning");
                    //}, function () {
                    //    $(this).removeClass("hover pe-auto bg-warning");
                    //});

                    // Add click event
                    //$(row).on("click", function () {
                    //    rowClickHandler(data);
                    //});
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
                    { "data": "ID_Daftar" },
                    { "data": "KodGred" },
                    { "data": "Kod_Khusus" },
                    { "data": "ButiranKhusus" }

                ]
            });



            /* show_loader();*/
            tblListPengalaman = $("#tblDataPengalaman").DataTable({
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
                    "url": '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PENDAFTARAN/Pendaftaran_WS.asmx/LoadList_SenaraiPengalaman")%>',
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter by Session Syarikat
                        return JSON.stringify({
                            idSemSya: IdSya,
                        })
                    }
                },
                "rowCallback": function (row, data) {
                    // Add hover effect
                    //$(row).hover(function () {
                    //    $(this).addClass("hover pe-auto bg-warning");
                    //}, function () {
                    //    $(this).removeClass("hover pe-auto bg-warning");
                    //});

                    // Add click event
                    //$(row).on("click", function () {
                    //    rowClickHandler(data);
                    //});
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
                    /*{ "data": "IdPengalaman"},*/
                    { "data": "TajukProjek" },
                    { "data": "NamaSyarikat" },
                    { "data": "TarikhMula" },
                    { "data": "NilaiJualan" }
                ]
            });
        });

        function OpenFile(fileName, BilSijil, KodDaftar) {
            var Path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/SIJIL/")%>' + KodDaftar + '/' + sessionStorage.getItem("NoSya") + '/' + BilSijil + '/' + fileName;
            window.open(Path, '_blank');
        }

        async function AjaxLoadDataCawangan(idSya) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PENDAFTARAN/Pendaftaran_WS.asmx/LoadList_SenaraiCawangan")%>',
                    method: 'POST',
                    data: JSON.stringify({ idSemSya: idSya }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var result = JSON.parse(data.d);// Parse JSON data
                        if (result.length > 0) {
                            console.log("result: ", result);
                            resolve(result);
                        }
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            })
        }

        //async function AjaxLoadDataSijilPendaftaran(idSya) {
        //    return new Promise((resolve, reject) => {
        //        $.ajax({

        //            url: 'SyarikatBerdaftar_WS.asmx/LoadData_SyarikatSijil',
        //            method: 'POST',
        //            data: JSON.stringify({ IdSya: idSya }),
        //            dataType: 'json',
        //            contentType: 'application/json; charset=utf-8',
        //            success: function (data) {
        //                console.log("data: ", data.d)
        //                resolve(data.d);
        //            },
        //            error: function (xhr, textStatus, errorThrown) {
        //                console.error('Error:', errorThrown);
        //                reject(false);
        //            }
        //        });
        //    })
        //}

        async function AjaxLoadDataPengalaman(idSya) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SyarikatBerdaftar.asmx/LoadData_SyarikatPengalaman',
                    method: 'POST',
                    data: JSON.stringify({ IdSya: idSya }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        console.log("data: ", data.d)
                        resolve(data.d);
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            })
        }

        //Load Data Vendor 
        $(document).ready(function () {

            const searchParams = new URLSearchParams(window.location.search);
            let IdSya = searchParams.get('idSya');
            let activeTab = "#mklmtSya";
            $('#myTabs').on('shown.bs.tab', async function (e) {
                activeTab = $(e.target).attr('href');
                console.log("activetabs: ", activeTab);

                if (activeTab === "#mklmtSya") {
                    LoadDataVendor(IdSya);
                } else if (activeTab === "#mklmtCaw") {
                    LoadDataCaw(IdSya);
                } else if (activeTab === "#mklmtDaftarSijil") {
                    /*LoadDataSijil(IdSya);*/
                } else if (activeTab === "#mklmtPengalaman") {
                    /*LoadDataPengalaman(IdSya);*/
                } else {
                    LoadDataVendor(IdSya);
                }
            });
            LoadDataVendor(IdSya);

            //Ajax Request Data Vendor
            async function AjaxLoadDataVendor(idSya) {
                return new Promise((resolve, reject) => {
                    $.ajax({

                        url: 'SyarikatBerdaftar_WS.asmx/LoadData_SyarikatDaftarById',
                        method: 'POST',
                        data: JSON.stringify({ IdSya: idSya }),
                        dataType: 'json',
                        contentType: 'application/json; charset=utf-8',
                        success: function (data) {
                            var result = JSON.parse(data.d);// Parse JSON data
                            if (result.length > 0) {
                                console.log("result: ", result);
                                resolve(result);
                                //console.log("Sya1", dataSyarikat1.No_Sykt);
                            }
                            //resolve(data.d);
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            console.error('Error:', errorThrown);
                            reject(false);
                        }
                    });
                })
            }

            async function LoadDataVendor(IdSya) {
                if (IdSya != "") {
                    var DataVendor = await AjaxLoadDataVendor(IdSya);
                    console.log("LoadDatavendor", DataVendor);

                    if (DataVendor.length > 0) {
                        SetValue_DataVendor(DataVendor);
                    } else {
                        console.log("Tiada Data untuk Id" + IdSya);
                    }

                } else {
                    console.log("Tiada ID");
                }
            }

            async function SetValue_DataVendor(DataVendor) {

                //console.log("DataVendor: ", DataVendor);
                //console.log("No_Sykt", DataVendor[0].No_Sykt);

                sessionStorage.setItem("NoSya", DataVendor[0].No_Sykt);
                sessionStorage.setItem("EmailSya", DataVendor[0].EmailSya);
                sessionStorage.setItem("NamaSya", DataVendor[0].Nama_Sykt);

                $('#noDaftarSemak').val(DataVendor[0].No_Sykt);
                $('#namaSyaSemak').val(DataVendor[0].Nama_Sykt);
                $('#noDaftarKelulusan').val(DataVendor[0].No_Sykt);
                $('#namaSyaKelulusan').val(DataVendor[0].Nama_Sykt);

                //mklmtvendor
                $('#noDaftar').val(DataVendor[0].No_Sykt);
                $('#namaSya').val(DataVendor[0].Nama_Sykt);

                if (DataVendor[0].Bekalan === "true" || DataVendor[0].Bekalan === true) {
                    $('#chckBekalan').prop('checked', true);
                    $('#chckBekalan').prop('disabled', true);
                } else {
                    $('#chckBekalan').prop('checked', false);
                    $('#chckBekalan').prop('disabled', true);
                }

                if (DataVendor[0].Perkhidmatan === "true" || DataVendor[0].Perkhidmatan === true) {
                    $('#chckPerkhidmatan').prop('checked', true);
                    $('#chckPerkhidmatan').prop('disabled', true);
                } else {
                    $('#chckPerkhidmatan').prop('checked', false);
                    $('#chckPerkhidmatan').prop('disabled', true);
                }

                if (DataVendor[0].Kerja === "true") {
                    /*$('#chckKerja').is(":checked");*/
                    $('#chckKerja').prop('checked', true);
                    $('#chckKerja').prop('disabled', true);
                } else {
                    $('#chckKerja').prop('checked', false);
                    $('#chckKerja').prop('disabled', true);
                }

                //if (DataVendor[0].StatBumi === "1") {
                //    //$("#chckBukanBumi").prop('disabled', true);
                //    $('#chckBumi').prop('checked', true);
                //    $("input[name='chckStatBumi'").prop('disabled', true);
                //} else if (DataVendor[0].StatBumi === "0") {
                //    $('#chckBukanBumi').prop('checked', true);
                //    $("input[name='chckStatBumi']").prop('disabled', true);
                //    //$("#chckBumi").prop('disabled', true);
                //}

                $('#gredKerja').val(DataVendor[0].Kod_Gred);

                if (DataVendor[0].StatBumi == "1") {
                    $('#chckBumi').prop('checked', true);
                    $('#chckBukanBumi').prop('checked', false);
                    $('#chckBumi').prop('disabled', true);
                    $('#chckBukanBumi').prop('disabled', true);
                } else {
                    $('#chckBukanBumi').prop('checked', true);
                    $('#chckBumi').prop('checked', false);
                    $('#chckBumi').prop('disabled', true);
                    $('#chckBukanBumi').prop('disabled', true);
                }

                //if (DataVendor[0].StatLulus == "02") {
                //    $('#statLulus').val("MENUNGGU SEMAKAN PENDAFTARAN");
                //} else if (DataVendor[0].StatLulus == "03") {
                //    $('#statLulus').val("KEMASKINI PENDAFTARAN");
                //} else if (DataVendor[0].StatLulus == "04") {
                //    $('#statLulus').val("MENUNGGU KELULUSAN PENDAFTARAN");
                //} else if (DataVendor[0].StatLulus == "05") {
                //    $('#statLulus').val("LULUS");
                //} else if (DataVendor[0].StatLulus == "06") {
                //    $('#statLulus').val("TIDAK LULUS");
                //} else {
                //    $('#statLulus').val("TIADA DATA");
                //}

                $('#statLulus').val(DataVendor[0].ButiranStatLulus);

                //$('#statLulus').val(DataVendor[0].StatLulus);

                //if (DataVendor[0].StatAktif == "00") {
                //    $('#statAktif').val("TIDAK AKTIF");
                //} else if (DataVendor[0].StatAktif == "08") {
                //    $('#statAktif').val("SENARAI HITAM");
                //} else if (DataVendor[0].StatAktif == "09") {
                //    $('#statAktif').val("dIGANTUNG");
                //} else {
                //    $('#statAktif').val("AKTIF");
                //}

                $('#statAktif').val(DataVendor[0].ButiranStatAktif);

                //Alamat
                $('#txtAlmtPerniagaan1').val(DataVendor[0].Almt1);
                $('#txtAlmtPerniagaan2').val(DataVendor[0].Almt2);
                //$('#ddlPoskod').val(DataVendor[0].Poskod);
                //$('#ddlBandar').val(DataVendor[0].Bandar);
                //$('#ddlNegeri').val(DataVendor[0].Negeri);
                //$('#ddlNegara').val(DataVendor[0].Negara);
                $('#PoskodSya').val(DataVendor[0].Poskod);
                $('#BandarSya').val(DataVendor[0].ButiranBandar);
                $('#NegeriSya').val(DataVendor[0].ButiranNegeri);
                $('#NegaraSya').val(DataVendor[0].ButiranNegara);
                $('#txtWeb').val(DataVendor[0].Web);
                $('#txtEmailSya').val(DataVendor[0].EmailSya);
                $('#txtTel1').val(DataVendor[0].TelBimbit);
                $('#txtTel2').val(DataVendor[0].TelPejSya);
                $('#txtNoFax').val(DataVendor[0].NoFaxSya);

                //Pegawai
                $('#txtNamaPegawai1').val(DataVendor[0].NamaPegawai1);
                $('#txtJwtPegawai1').val(DataVendor[0].JwtPegawai1);
                $('#txtEmailPegawai1').val(DataVendor[0].EmailPeg1);
                $('#txtNoTelPeg1').val(DataVendor[0].TelPeg1);
                $('#txtNoTelPejPeg1').val(DataVendor[0].TelPejPeg1);
                $('#txtNamaPegawai2').val(DataVendor[1].NamaPegawai1);
                $('#txtJwtPegawai2').val(DataVendor[1].JwtPegawai1);
                $('#txtEmailPegawai2').val(DataVendor[1].EmailPeg1);
                $('#txtNoTelPeg2').val(DataVendor[1].TelPeg1);
                $('#txtNoTelPejPeg2').val(DataVendor[1].TelPejPeg1);

                //Bank
                //$('#ddlKodBank').val(DataVendor[0].KodBank);
                $('#BankSya').val(DataVendor[0].ButiranBank);
                $('#txtNoAkaun').val(DataVendor[0].NoAkaun);
            }
        });

        async function LoadDataCaw(IdSya) {
            if (IdSya != "") {
                var DataCaw = await AjaxLoadDataCawangan(IdSya);

                if (DataCaw.length > 0) {
                    SetValue_DataVendorCaw(DataCaw);
                } else {
                    console.log("Tiada Data untuk Id" + IdSya);
                }

            } else {
                console.log("Tiada ID");
            }

        }

        //async function LoadDataSijil(IdSya) {
        //    if (IdSya != "") {

        //        var DataSijil = await AjaxLoadDataSijilPendaftaran(IdSya);

        //        if (DataSijil.length > 0) {
        //            SetValue_DataVendorSijil(DataSijil);
        //        } else {
        //            console.log("Tiada data untuk id" + idSya);
        //        }

        //    } else {
        //        console.log("Tiada ID");
        //    }
        //}

        async function LoadDataPengalaman(IdSya) {
            if (IdSya != "") {

                var DataPengalaman = await AjaxLoadDataPengalaman(IdSya);

                if (DataPengalaman.length > 0) {
                    SetValue_DataVendorPengalaman(DataPengalaman);
                } else {
                    console.log("Tiada data untuk id" + idSya);
                }

            } else {
                console.log("Tiada ID");
            }
        }

        async function SetValue_DataVendorCaw(DataCaw) {

            console.log("DataVendorCaw: ", DataCaw[0].Almt1);
            $('#txtAlmtCaw1').val(DataCaw[0].Almt1);
            $('#txtAlmtCaw2').val(DataCaw[0].Almt2);
            $('#poskodCaw').val(DataCaw[0].Poskod);
            $('#bandarCaw').val(DataCaw[0].ButiranBandar);
            $('#NegeriCaw').val(DataCaw[0].ButiranNegeri);
            $('#NegaraCaw').val(DataCaw[0].ButiranNegara);
            $('#txtWebCaw').val(DataCaw[0].web);
            $('#txtEmailSyaCaw').val(DataCaw[0].EmailCaw);
            $('#txtTel1Caw').val(DataCaw[0].Tel1);
            $('#txtTel2Caw').val(DataCaw[0].Tel2);
            $('#txtNoFaxCaw').val(DataCaw[0].Faks);
            $('#txtNamaPegawaiCaw1').val(DataCaw[0].NamaPeg);
            $('#txtJwtPegawaiCaw1').val(DataCaw[0].JwtPeg);
            $('#txtEmailPegawaiCaw1').val(DataCaw[0].EmelPeg);
            $('#txtNoTelPegCaw1').val(DataCaw[0].TelBimbit);
            $('#txtNoTelPejPegCaw1').val(DataCaw[0].TelPejPeg);
            $('#txtNamaPegawaiCaw2').val(DataCaw[1].NamaPeg);
            $('#txtJwtPegawaiCaw2').val(DataCaw[1].JwtPeg);
            $('#txtEmailPegawaiCaw2').val(DataCaw[1].EmelPeg);
            $('#txtNoTelPegCaw2').val(DataCaw[1].TelBimbit);
            $('#txtNoTelPejPegCaw2').val(DataCaw[1].TelPejPeg);
            $('#BankCaw').val(DataCaw[0].ButiranBank);
            $('#txtNoAkaunCaw').val(DataCaw[0].NoAkaun);
        }

        //async function SetValue_DataVendorSijil(DataSijil) {

        //    console.log("DataVendorSijil: ", DataSijil);
        //    $('#').val(DataSijil);
        //    $('#').val(DataSijil);
        //    $('#').val(DataSijil);
        //    $('#').val(DataSijil);
        //}

        //async function SetValue_DataVendorPengalaman(DataPengalaman) {

        //    console.log("DataVendorSijil: ", DataPengalaman);
        //    $('#').val(DataPengalaman);
        //    $('#').val(DataPengalaman);
        //    $('#').val(DataPengalaman);
        //    $('#').val(DataPengalaman);
        //}

        function displayMaklumanModal(message) {
            $('#maklumanModal').modal('toggle');
            $('#detailMakluman').html(message);
        }

        $("input[name='radioSemakKelulusan']").change(function () {
            if ($("#radioTungguKelulusan").is(":checked")) {
                $("input[name='radioSemakKelulusan']").val("3");
            } else if ($("#radioKemaskini").is(":checked")) {
                $("input[name='radioSemakKelulusan']").val("2");
            } else {
                $("input[name='radioSemakKelulusan']").val("");
                // Assuming chckKatSyaS and chckKatSyaE are checkboxes, uncheck them
                $("#radioTungguKelulusan").prop("checked", false);
                $("#radioKemaskini").prop("checked", false);
            }
        });

        $("input[name='radioKelulusan']").change(function () {
            if ($("#radioLulus").is(":checked")) {
                $("input[name='radioKelulusan']").val("1");
            } else if ($("#radioTakLulus").is(":checked")) {
                $("input[name='radioKelulusan']").val("2");
            } else {
                $("input[name='radioKelulusan']").val("");
                // Assuming chckKatSyaS and chckKatSyaE are checkboxes, uncheck them
                $("#radioLulusn").prop("checked", false);
                $("#radioTakLulus").prop("checked", false);
            }
        });

        $('.btnHantarSemak').click(async function () {
            let isRadioKemaskiniChecked = $('#radioKemaskini').is(":checked");
            let isRadioTungguKelulusanChecked = $('#radioTungguKelulusan').is(":checked");
            let ulasanSemakIsEmpty = $('#ulasanSemak').val() === "";
            let radioSemakKelulusanValue = $("input[name='radioSemakKelulusan']:checked").val();

            // Check if any radio button in the 'radioSemakKelulusan' group is checked
            if (radioSemakKelulusanValue === undefined) {
                displayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
                return;
            }

            // Handle specific cases based on which radio button is checked
            if (isRadioKemaskiniChecked) {
                if (ulasanSemakIsEmpty) {
                    displayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
                } else {
                    $('#confirmationModal').modal('toggle');
                }
            } else if (isRadioTungguKelulusanChecked) {
                $('#confirmationModal').modal('toggle');
            } else {
                displayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
            }
        });

        $('.btnHantarKelulusan').click(async function () {
            let isRadioLulusChecked = $('#radioLulus').is(":Checked");
            let isRadioTakLulusChecked = $('#radioTakLulus').is(":Checked");
            let ulasanKelulusanIsEmpty = $('#ulasanKelulusan').val() === "";
            let radioKelulusanValue = $("input[name='radioKelulusan']:checked").val();

            if (radioKelulusanValue === undefined) {
                displayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
                return;
            }

            if (isRadioTakLulusChecked) {
                if (ulasanKelulusanIsEmpty) {
                    displayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
                    return;
                } else {
                    $('#confirmationModal').modal('toggle');
                }
            } else if (isRadioLulusChecked) {
                $('#confirmationModal').modal('toggle');
            } else {
                displayMaklumanModal("Sila Isi Maklumat Yang Diperlukan");
            }
        });

        $('.btnYaLulus').click(async function () {
            $('confirmationModal').modal('toggle');

            var newMklmtKelulusan = {
                mklmtKelulusan: {
                    IdSya: IdSya,
                    StatLulus: $("input[name='radioKelulusan']").val(),
                    EmailSya: sessionStorage.getItem("EmailSya"),
                    EmailAdmin: 'aida.hazirah@utem.edu.my',
                    NamaSya: sessionStorage.getItem("NamaSya"),
                    NamaStaff: 'AIDA HAZIRAH BINTI ABDUL HAMID'
                }
            }

            console.log("DataKelulusan: ", newMklmtKelulusan);
            //var result = JSON.parse(await ajaxSaveStatkelulusan(newMklmtKelulusan));

            //if (result.Status !== "Failed") {
            //    $('#maklumanModal').modal('toggle');
            //    $('#detailMakluman').html(result.Message);
            //    $('#cawangan').modal('toggle');
            //} else {
            //    $('#maklumanModal').modal('toggle');
            //    $('#detailMakluman').html(result.Message);
            //}
        });

        $('.btnYa').click(async function () {
            $('confirmationModal').modal('toggle');

            var newMklmtSemak = {
                mklmtSemak: {
                    IdSya: IdSya,
                    StatLulus: $("input[name='radioSemakKelulusan']").val(),
                    EmailSya: sessionStorage.getItem("EmailSya"),
                    EmailAdmin: 'aida.hazirah@utem.edu.my',
                    NamaSya: sessionStorage.getItem("NamaSya"),
                    NamaStaff: 'AIDA HAZIRAH BINTI ABDUL HAMID'
                }
            }

            console.log("DataSemakan: ", newMklmtSemak);
            //var result = JSON.parse(await ajaxSaveStatSemak(newMklmtSemak));

            //if (result.Status !== "Failed") {
            //    $('#maklumanModal').modal('toggle');
            //    $('#detailMakluman').html(result.Message);
            //    $('#cawangan').modal('toggle');
            //} else {
            //    $('#maklumanModal').modal('toggle');
            //    $('#detailMakluman').html(result.Message);
            //}
        });

        async function ajaxSaveStatSemak(mklmtSemak) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SyarikatBerdaftar_WS.asmx/SaveStatSemak',
                    method: 'POST',
                    data: JSON.stringify(mklmtSemak),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        console.log("data: ", data.d)
                        resolve(data.d);
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            })
        }

        async function ajaxSaveStatkelulusan(mklmtKelulusan) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'SyarikatBerdaftar_WS.asmx/SaveStatKelulusan',
                    method: 'POST',
                    data: JSON.stringify(mklmtSemak),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        console.log("data: ", data.d)
                        resolve(data.d);
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            })
        }

    </script>
</asp:Content>
