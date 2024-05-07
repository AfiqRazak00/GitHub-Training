<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Tawaran_Iklan.aspx.vb" Inherits="SMKB_Web_Portal.Tawaran_Iklan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <style>
        .nospn {
            -moz-appearance: textfield;
        }

            .nospn::-webkit-outer-spin-button,
            .nospn::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }



        #permohonan .modal-body {
            max-height: 70vh; /* Adjust height as needed to fit your layout */
            min-height: 70vh;
            overflow-y: scroll;
            scrollbar-width: thin;
        }

        #subTab a {
            cursor: pointer;
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

    <div id="dashboard" class="tabcontent" style="display: block;">

        <!-- Iklan tab -->
        <ul class="nav nav-tabs" id="myTabs">
            <li class="nav-item">
                <a class="nav-link active" data-toggle="tab" href="#SebutHargaUni">Sebut Harga Universiti <span id="BilSebutHargaBadgeUni" class="badge badge-danger blink_badge" style="display: none;"></span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#SebutHargaPTJ">Sebut Harga PTJ <span id="BilSebutHargaBadgePTJ" class="badge badge-danger blink_badge" style="display: none;"></span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" data-toggle="tab" href="#Tender">Tender <span id="BilSebutHargaBadgeTender" class="badge badge-danger blink_badge" style="display: none;"></span></a>
            </li>
        </ul>

        <div class="tab-content">

            <div class="tab-pane fade show active" id="SebutHargaUni">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleSebutHargaUni">Maklumat Sebut Harga Universiti</h5>
                </div>

                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblDataIklanNaskahUni" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr data-id="">
                                        <th scope="col">Bil</th>
                                        <th scope="col">Tajuk</th>
                                        <th scope="col">PTJ</th>
                                        <th scope="col">Tarikh Dipamer</th>
                                        <th scope="col">Tarikh Di Buka</th>
                                        <th scope="col">Tarikh & Masa Ditutup</th>
                                        <th scope="col">Tarikh Lawatan Tapak</th>
                                        <th scope="col">Harga Naskah (RM)</th>
                                    </tr>
                                </thead>
                                <tbody id="tableID_Senarai_NaskahUni">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade show" id="SebutHargaPTJ">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleSebutHargaPTJ">Maklumat Sebut Harga PTJ</h5>
                </div>

                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblDataIklanNaskahPTJ" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr data-id="">
                                        <th scope="col">Bil</th>
                                        <th scope="col">Tajuk</th>
                                        <th scope="col">PTJ</th>
                                        <th scope="col">Tarikh Dipamer</th>
                                        <th scope="col">Tarikh Di Buka</th>
                                        <th scope="col">Tarikh & Masa Ditutup</th>
                                        <th scope="col">Tarikh Lawatan Tapak</th>
                                        <th scope="col">Harga Naskah (RM)</th>
                                    </tr>
                                </thead>
                                <tbody id="tableID_Senarai_NaskahPTJ">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade show" id="Tender">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleSebutHargaTender">Maklumat Tender</h5>
                </div>

                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblDataIklanNaskahTender" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr data-id="">
                                        <th scope="col">Bil</th>
                                        <th scope="col">Tajuk</th>
                                        <th scope="col">PTJ</th>
                                        <th scope="col">Tarikh Dipamer</th>
                                        <th scope="col">Tarikh Di Buka</th>
                                        <th scope="col">Tarikh & Masa Ditutup</th>
                                        <th scope="col">Tarikh Lawatan Tapak</th>
                                        <th scope="col">Harga Naskah (RM)</th>
                                    </tr>
                                </thead>
                                <tbody id="tableID_Senarai_NaskahTender">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>

        </div>

        <div class="modal fade" id="TempahanNaskahModalUni" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleTempahanModal">PEROLEHAN SEBUT HARGA UNIVERSITI</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="NaskahHdr">
                            <div class="col-md-12" style="border-top: 4px solid black; border-bottom: 4px solid black; background-color: lightgrey;">
                                <div class="form-group mt-3">
                                    <%--<label id="IdJualan"></label>--%>
                                    <strong>
                                        <label id="NoSebutHarga" style="font-size: 1.25em; font-weight: bold;"></label>
                                    </strong>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="card mt-3">
                                    <div class="card-header">
                                        <label id="TujuanNaskah"></label>
                                    </div>
                                    <div class="card-body">
                                        <div class="col-md-12">
                                            <div id="NaskahDtl">
                                                <div class="col-md-12 row">

                                                    <div class="col-md-12">
                                                        <div class="form-group input-group">
                                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="PTJ" id="PTJ" readonly>
                                                            <label class="input-group__label">PTJ</label>
                                                        </div>
                                                    </div>

                                                </div>
                                                <div class="col-md-12 row">
                                                    <div class="col-md-4">
                                                        <div class="form-group input-group">
                                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="TkhPamer" id="TkhPamer" readonly>
                                                            <label class="input-group__label">Tarikh & Masa Di Pamer</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group input-group">
                                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="TkhJual" id="TkhJual" readonly>
                                                            <label class="input-group__label">Tarikh & Masa Di Jual </label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group input-group">
                                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="TkhTutup" id="TkhTutup" readonly>
                                                            <label class="input-group__label">Tarikh & Masa Di Tutup</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-12 row">
                                                    <div class="col-md-12">
                                                        <div class="form-group input-group">
                                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="TempatHantar" id="TempatHantar" readonly>
                                                            <label class="input-group__label">Tempat Hantar</label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-12 row">
                                                    <div class="col-md-6">
                                                        <div class="form-group input-group">
                                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="KatPO" id="KatPO" readonly>
                                                            <label class="input-group__label">Kategori Perolehan</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group input-group">
                                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="KaedahPO" id="KaedahPO" readonly>
                                                            <label class="input-group__label">Kaedah Perolehan</label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-12 row">
                                                    <div class="col-md-4">
                                                        <div class="form-group input-group">
                                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="TkhLawat" id="TkhLawat" readonly>
                                                            <label class="input-group__label">Tarikh dan Masa Lawatan Tapak</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group input-group">
                                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="TempatLawat" id="TempatLawat" readonly>
                                                            <label class="input-group__label">Tempat Lawatan Tapak</label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group input-group">
                                                            <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="HargaNaskah" id="HargaNaskah" readonly>
                                                            <label class="input-group__label">HargaNaskah</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-footer">
                                        <div class="col-md-12">
                                        </div>
                                    </div>
                                </div>

                                <div class="card mt-3">
                                    <div class="card-header">
                                        SIJIL KEMENTERIAN KEWANGAN, KOD BIDANG
                                    </div>
                                    <div class="card-body">
                                        <div class="col-md-12">
                                            <div id="MklmtBidangPO">
                                                <p id="BidangPO"></p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-footer">
                                        <div class="col-md-12">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="card mt-3">
                                            <div class="card-header">
                                                skop
                                            </div>
                                            <div class="card-body">
                                                <div class="col-md-12">
                                                    <div id="Skop">
                                                        <p id="SkopNaskah"></p>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="card-footer">
                                                <div class="col-md-12">
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="card mt-3">
                                            <div class="card-header">
                                                ARAHAN
                                            </div>
                                            <div class="card-body">
                                                <div class="col-md-12">
                                                    <div id="Arahan">
                                                        <p id="ArahanNaskah"></p>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="card-footer">
                                                <div class="col-md-12">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <div class="col-md-12 mt-4">
                            <p>Tawaran ini adalah dipelawa kepada kontraktor-kontraktor yang mempunyai Sijil Perakuan Pendaftaran Seperti Berikut:</p>
                        </div>

                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataLesen" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr data-id="idPengalaman">
                                            <th scope="col">Bil</th>
                                            <th scope="col">Kod Pendaftaran</th>
                                            <th scope="col">Lesen Pendaftaran</th>
                                            <th scope="col">Maklumat Lanjut</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_Pengalaman">
                                    </tbody>

                                </table>

                            </div>
                        </div>

                    </div>

                    <div id="NaskahFtr" class="mb-3">
                        <div class="col-md-12">
                            <div class="text-center">
                                <button type="button" id="btnTempahNaskah" class="btn btn-success btnTempahNaskah">Tempah </button>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="OrderNaskahModal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="titleOrderNaskahModal">PEROLEHAN SEBUT HARGA UNIVERSITI</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                Pembelian Naskah
                            </div>
                            <div class="card-body">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group input-group">
                                                <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="noPerolehan" name="noPerolehan" readonly />
                                                <label class="input-group__label">No Perolehan</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group input-group">
                                                <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="TajukOrder" name="TajukOrder" readonly />
                                                <label class="input-group__label">Tajuk</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group input-group">
                                                <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="IDSya" name="IDSya" readonly />
                                                <label class="input-group__label">ID Syarikat</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group input-group">
                                                <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="NamaSya" name="NamaSya" readonly />
                                                <label class="input-group__label">Nama Syarikat</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">

                                            <div class="form-group input-group">
                                                <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="EmelSya" name="EmelSya" readonly />
                                                <label class="input-group__label">Emel Syarikat</label>
                                            </div>

                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group input-group">
                                                <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="NoTel" name="NoTel" readonly />
                                                <label class="input-group__label">No Telefon</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group input-group">
                                                <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="MklmtPembelian" name="MklmtPembelian" readonly />
                                                <label class="input-group__label">Maklumat Pembelian</label>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group input-group">
                                                <input type="text" class=" input-group__input form-control input-sm" placeholder="" id="JumHarga" name="JumHarga" readonly />
                                                <label class="input-group__label">Jumlah Harga</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="card-footer">
                            <div class="col-md-12">
                                <div class="text-center">
                                    <button id="btnOrderNaskah" class="btn btn-success btnOrderNaskah">Order </button>
                                </div>
                            </div>
                        </div>
                    </div>
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
                <div class="modal-body" id="confirmContent">
                    Anda pasti ingin menyimpan rekod ini?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger"
                        data-dismiss="modal">
                        Tidak</button>
                    <button type="button" class="btn btn-secondary btnYa">Ya</button>
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


    <script type="text/javascript">

        async function DisplayMaklumanModal(msg) {
            $('#detailMakluman').html(msg);
            $('#maklumanModal').modal("toggle");
        }

        $('.btnTempahNaskah').on('click', async function () {
            $('#TempahanNaskahModalUni').modal("toggle");

            var dataId = $('.btnTempahNaskah').attr("data-id");
            var dataMode = $('.btnTempahNaskah').attr("data-mode");
            var NoMohon = $('.btnTempahNaskah').attr("No_Mohon");

            var newDataTempah = {
                MklmtIklan: {
                    OrderNaskahID: dataId,
                    NoMohon: NoMohon
                }
            }

            let checkSya = JSON.parse(await AjaxCheckTempahNaskah(newDataTempah));

            if (checkSya.Code == "00") {
                if (dataMode == "UNI") {

                    var DataOrderNaskah = JSON.parse(await AjaxLoadDataOrderNaskah(dataId))

                    if (DataOrderNaskah.length > 0) {
                        SetValueToOrderNaskahUni(DataOrderNaskah);
                    } else {
                        DisplayMaklumanModal("Tiada Maklumat Order");
                    }

                } else if (dataMode == "PTJ") {

                    var DataOrderNaskah = JSON.parse(await AjaxLoadDataOrderNaskah(dataId))

                    console.log("DataNAskah Order: ", DataOrderNaskah);

                    if (DataOrderNaskah.length > 0) {
                        SetValueToOrderNaskahPTJ(DataOrderNaskah);
                    } else {
                        DisplayMaklumanModal("Tiada Maklumat Order");
                    }

                } else if (dataMode == "TENDER") {

                    var DataOrderNaskah = JSON.parse(await AjaxLoadDataOrderNaskah(dataId))

                    if (DataOrderNaskah.length > 0) {
                        SetValueToOrderNaskahTender(DataOrderNaskah);
                    } else {
                        DisplayMaklumanModal("Tiada Maklumat Order");
                    }

                } else {
                    DisplayMaklumanModal("Mode Tidak Sah");
                }

                $('#OrderNaskahModal').modal("toggle");

            } else {
                DisplayMaklumanModal(checkSya.Message);
            }
        });

        async function AjaxCheckTempahNaskah(MklmtIklan) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'EPerolehan_WS.asmx/CheckTempahNaskah',
                    method: 'POST',
                    data: JSON.stringify(MklmtIklan),
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

        async function SetValueToOrderNaskahUni(DataOrderNaskah) {
            $('#titleOrderNaskahModal').html("PEROLEHAN SEBUT HARGA UNIVERSITI");

            $('#noPerolehan').val(DataOrderNaskah[0].No_Perolehan);
            $('#TajukOrder').val(DataOrderNaskah[0].Tujuan);
            $('#IDSya').val(DataOrderNaskah[0].ID_Sykt);
            $('#NamaSya').val(DataOrderNaskah[0].Nama_Sykt);
            $('#EmelSya').val(DataOrderNaskah[0].Emel_Semasa);
            $('#NoTel').val(DataOrderNaskah[0].Tel_Pej_Semasa);
            $('#MklmtPembelian').val("Tiada Data");
            $('#JumHarga').val(DataOrderNaskah[0].Harga);

            //confirmkan OrderId Generated 
            $('.btnOrderNaskah').attr('id', DataOrderNaskah[0].No_Perolehan);
        }

        async function SetValueToOrderNaskahPTJ(DataOrderNaskah) {
            $('#titleOrderNaskahModal').html("PEROLEHAN SEBUT HARGA PTJ");

            $('#noPerolehan').val(DataOrderNaskah[0].No_Perolehan);
            $('#TajukOrder').val(DataOrderNaskah[0].Tujuan);
            $('#IDSya').val(DataOrderNaskah[0].ID_Sykt);
            $('#NamaSya').val(DataOrderNaskah[0].Nama_Sykt);
            $('#EmelSya').val(DataOrderNaskah[0].Emel_Semasa);
            $('#NoTel').val(DataOrderNaskah[0].Tel_Pej_Semasa);
            $('#MklmtPembelian').val("Tiada Data");
            $('#JumHarga').val(DataOrderNaskah[0].Harga);
        }

        async function SetValueToOrderNaskahTender(DataOrderNaskah) {
            $('#titleOrderNaskahModal').html("PEROLEHAN SEBUT HARGA TENDER");

            $('#noPerolehan').val(DataOrderNaskah[0].No_Perolehan);
            $('#TajukOrder').val(DataOrderNaskah[0].Tujuan);
            $('#IDSya').val(DataOrderNaskah[0].ID_Sykt);
            $('#NamaSya').val(DataOrderNaskah[0].Nama_Sykt);
            $('#EmelSya').val(DataOrderNaskah[0].Emel_Semasa);
            $('#NoTel').val(DataOrderNaskah[0].Tel_Pej_Semasa);
            $('#MklmtPembelian').val("Tiada Data");
            $('#JumHarga').val(DataOrderNaskah[0].Harga);
        }

        var counterUni = 0;
        var counterUpdatedUni = false;
        var tblSebutHargaUni = null;

        $(document).ready(function () {
            /* show_loader();*/
            tblSebutHargaUni = $("#tblDataIklanNaskahUni").DataTable({
                "responsive": true,
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
                    "sInfo": "Menunjukkan _END_ dari _TOTAL_ rekod",
                    "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },

                "ajax": {
                    "url": "EPerolehan_WS.asmx/LoadList_TawaranIklanUni",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter by Session Syarikat
                        return JSON.stringify({
                            //idSemSya: '<%=Session("ssusrID")%>',
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

                    //Add click event
                    $(row).on("click", function () {
                        //var startDateTime = data.TkhPamer;
                        //var EndDateTime = data.TkhTutup;
                        //rowClickHandler(startDateTime, EndDateTime);
                        //var DataNaskah = JSON.stringify(data);
                        //var Id = DataNaskah['IdNaskah'];

                        var Id = data.IdNaskah;
                        var mode = "PTJ";

                        OpenNaskah(mode, Id);
                        //$('#TempahanNaskahModalUni').attr('data-mode', 'UNI');
                        //OpenPopUpTempahan(Id);
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
                            // Increment counter for each row only if not updated during draw event
                            if (!counterUpdatedUni) {
                                counterUni++;
                            }
                            return counterUni;
                        },
                        "orderable": false,
                    },
                    /*{ "data": "IdPengalaman"},*/
                    { "data": "Tujuan" },
                    { "data": "Pejabat" },
                    {
                        "data": "TkhMula",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "TkhBuka",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "TkhTutup",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "TkhLawatan",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "HargaNaskah",
                        "render": function (data, type, row) {
                            // Assuming data is a numeric value representing the total tunggak
                            return parseFloat(data).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                        }
                    },

                ]
            });

            tblSebutHargaUni.on('draw', function () {
                if (!counterUpdatedUni) {
                    counterUni = tblSebutHargaUni.rows().count(); // Update counter based on the current row count
                    counterUpdatedUni = true;
                    updateModalBadgeUni();
                }
            });
        });

        function updateModalBadgeUni() {

            if (counterUni > 0) {
                $('#BilSebutHargaBadgeUni').show();
                $('#BilSebutHargaBadgeUni').text(counterUni);
                counterUpdatedUni = false;
            } else {
                $('#BilSebutHargaBadgeUni').hide();
            }
        }

        var counterPTJ = 0;
        var counterUpdatedPTJ = false;
        var tblSebutHargaPTJ = null;

        $(document).ready(function () {
            /* show_loader();*/
            tblSebutHargaPTJ = $("#tblDataIklanNaskahPTJ").DataTable({
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
                    "url": "EPerolehan_WS.asmx/LoadList_TawaranIklanPTJ",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter by Session Syarikat
                        return JSON.stringify({
                            //idSemSya: '<%=Session("ssusrID")%>',
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

                    //Add click event
                    $(row).on("click", function () {
                        //var DataNaskahPTJ = JSON.stringify(data);
                        //$('#TempahanNaskahModalUni').attr('data-mode', 'PTJ');
                        //var IdJualan = data.IdJualan;
                        //OpenPopUpTempahan(DataNaskahPTJ);

                        var Id = data.IdNaskah;
                        var mode = "PTJ";

                        OpenNaskah(mode, Id);
                        /*$('#TempahanNaskahModalUni').attr('data-mode', 'PTJ');*/
                        //OpenPopUpTempahan(Id);
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
                            // Increment counter for each row only if not updated during draw event
                            if (!counterUpdatedPTJ) {
                                counterPTJ++;
                            }
                            return counterPTJ;
                        },
                        "orderable": false,
                    },
                    /*{ "data": "IdPengalaman"},*/
                    { "data": "Tujuan" },
                    { "data": "Pejabat" },
                    {
                        "data": "TkhMula",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "TkhBuka",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "TkhTutup",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "TkhLawatan",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "HargaNaskah",
                        "render": function (data, type, row) {
                            // Assuming data is a numeric value representing the total tunggak
                            return parseFloat(data).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                        }
                    },

                ]
            });

            tblSebutHargaPTJ.on('draw', function () {
                if (!counterUpdatedPTJ) {
                    counterPTJ = tblSebutHargaPTJ.rows().count(); // Update counter based on the current row count
                    counterUpdatedPTJ = true;
                    updateModalBadgePTJ();
                }
            });

        });

        function updateModalBadgePTJ() {
            if (counterPTJ > 0) {
                $('#BilSebutHargaBadgePTJ').show();
                $('#BilSebutHargaBadgePTJ').text(counterPTJ);
                counterUpdatedPTJ = false;
            } else {
                $('#BilSebutHargaBadgePTJ').hide();
            }
        }

        var counterTender = 0;
        var counterUpdatedTender = false;
        var tblSebutHargaTender = null;

        $(document).ready(function () {
            /* show_loader();*/
            tblSebutHargaTender = $("#tblDataIklanNaskahTender").DataTable({
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
                    "url": "EPerolehan_WS.asmx/LoadList_TawaranIklanTender",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter by Session Syarikat
                        return JSON.stringify({
                            //idSemSya: '<%=Session("ssusrID")%>',
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

                    //Add click event
                    $(row).on("click", function () {
                        //var startDateTime = data.TkhPamer;
                        //var EndDateTime = data.TkhTutup;
                        //rowClickHandler(startDateTime, EndDateTime);
                        //var DataNaskah = JSON.stringify(data);
                        //$('#TempahanNaskahModalUni').attr('data-mode', 'TENDER');
                        //var MklmtNaskah = data;
                        //var IdJualan = data.IdJualan;
                        //OpenPopUpTempahan(DataNaskah);

                        var Id = data.IdNaskah;
                        var mode = "PTJ";

                        OpenNaskah(mode, Id);
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
                            // Increment counter for each row only if not updated during draw event
                            if (!counterUpdatedTender) {
                                counterTender++;
                            }
                            return counterTender;
                        },
                        "orderable": false,
                    },
                    /*{ "data": "IdPengalaman"},*/
                    { "data": "Tujuan" },
                    { "data": "Pejabat" },
                    {
                        "data": "TkhMula",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "TkhBuka",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "TkhTutup",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "TkhLawatan",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "HargaNaskah",
                        "render": function (data, type, row) {
                            // Assuming data is a numeric value representing the total tunggak
                            return parseFloat(data).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                        }
                    },

                ]
            });

            tblSebutHargaTender.on('draw', function () {
                if (!counterUpdatedTender) {
                    counterTender = tblSebutHargaTender.rows().count(); // Update counter based on the current row count
                    counterUpdatedTender = true;
                    updateModalBadgeTender();
                }
            });
        });

        function updateModalBadgeTender() {

            if (counterTender > 0) {
                $('#BilSebutHargaBadgeTender').show();
                $('#BilSebutHargaBadgeTender').text(counterTender);
                counterUpdatedTender = false;
            } else {
                $('#BilSebutHargaBadgeTender').hide();
            }
        }

        async function OpenNaskah(mode, idNaskah) {
            var Url = '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PEROLEHAN/Naskah.aspx")%>?mode=' + mode + '&IdNaskah=' + idNaskah;
            window.location.href = Url;
            return false;
        }

        async function OpenPopUpTempahan(Id) {

            var mode = $('#TempahanNaskahModalUni').attr('data-mode');

            if (mode == "UNI") {

                var DataNaskah = JSON.parse(await AjaxLoadDataNaskah(Id));

                console.log(DataNaskah);
                console.log("DataNaskah IdNAskah", DataNaskah[0].IdNaskah);

                if (DataNaskah.length > 0) {

                    clearAllValueNaskah();
                    SetValueToTempahanUni(DataNaskah);
                    //$('.btnTempahNaskah').attr("data-id", DataNaskah[0].No_Sebut_Harga);
                    //$('.btnTempahNaskah').attr("data-id", DataNaskah[0].IdNaskah);
                    //$('.btnTempahNaskah').attr("data-mode", "UNI");
                } else {
                    DisplayMaklumanModal("Tiada Maklumat Naskah UNI");
                    return false;
                }
            } else if (mode == "PTJ") {

                var DataNaskah = JSON.parse(await AjaxLoadDataNaskah(Id));

                if (DataNaskah.length > 0) {
                    clearAllValueNaskah();
                    SetValueToTempahanPtj(DataNaskah);
                    //$('.btnTempahNaskah').attr("data-id", DataNaskah[0].IdNaskah);
                    //$('.btnTempahNaskah').attr("data-mode", "PTJ");
                } else {
                    DisplayMaklumanModal("Tiada Maklumat Naskah PTJ");
                    return false;
                }

            } else if (mode == "TENDER") {

                if (DataNaskah.length > 0) {
                    clearAllValueNaskah();
                    SetValueToTempahanTender(MklmtNaskah);
                    //$('.btnTempahNaskah').attr("data-id", DataNaskah[0].IdNaskah);
                    //$('.btnTempahNaskah').attr("data-mode", "TENDER");
                } else {
                    DisplayMaklumanModal("Tiada Maklumat Naskah Tender");
                    return false;
                }

            }

            $('#TempahanNaskahModalUni').modal("toggle");
        }

        async function AjaxLoadDataNaskah(Id) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'EPerolehan_WS.asmx/LoadDataNaskah',
                    method: 'POST',
                    data: JSON.stringify({ Id_Jualan: Id }),
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

        async function SetValueToTempahanUni(MklmtNaskah) {
            // console.log("MklmtNaskah", MklmtNaskah);

            var TkhPamer = formatMalayDate(MklmtNaskah[0].TkhMula);
            var TkhJual = formatMalayDate(MklmtNaskah[0].TkhJual);
            var TkhTutup = formatMalayDate(MklmtNaskah[0].TkhTutup);
            var TkhLawat = formatMalayDate(MklmtNaskah[0].TkhLawat);

            $('#titleTempahanModal').html("PEROLEHAN SEBUT HARGA UNIVERSITI")
            //$('#IdJualan').html(MklmtNaskah.IdJualan);
            $('#PTJ').val(MklmtNaskah[0].PTJ);
            $('#NoSebutHarga').html(MklmtNaskah[0].No_Sebut_Harga);
            $('#TujuanNaskah').html(MklmtNaskah[0].Tujuan);
            $('#TkhPamer').val(TkhPamer);
            $('#TkhJual').val(TkhJual);
            $('#TkhTutup').val(TkhTutup);
            $('#TempatHantar').val(MklmtNaskah[0].Tempat_Hantar);
            $('#KatPO').val(MklmtNaskah[0].KatPO);
            $('#KaedahPO').val(MklmtNaskah[0].KaedahPO);
            $('#TkhLawat').val(TkhLawat);
            $('#TempatLawat').val(MklmtNaskah[0].TempatLawat);
            $('#HargaNaskah').val(MklmtNaskah[0].Harga);

            // Loop Bidang
            for (var i = 0; i < MklmtNaskah.length; i++) {
                //$('#BidangPO').html(MklmtNaskah[i].Kod_Bidang);

                var value = MklmtNaskah[i].ButiranBidang;
                $('#BidangPO').append('<p>' + value + '</p>');
            }
            //Skop
            $('#SkopNaskah').html(MklmtNaskah[0].Skop);
            $('#ArahanNaskah').html(MklmtNaskah[0].Syarat_Perolehan);

            $('.btnTempahNaskah').attr("data-id", MklmtNaskah[0].IdNaskah);
            $('.btnTempahNaskah').attr("No_Mohon", MklmtNaskah[0].No_Mohon);
            $('.btnTempahNaskah').attr("data-mode", "UNI");

        }

        async function SetValueToTempahanPtj(MklmtNaskah) {

            var TkhPamer = formatMalayDate(MklmtNaskah[0].TkhMula);
            var TkhJual = formatMalayDate(MklmtNaskah[0].TkhJual);
            var TkhTutup = formatMalayDate(MklmtNaskah[0].TkhTutup);
            var TkhLawat = formatMalayDate(MklmtNaskah[0].TkhLawat);

            $('#titleTempahanModal').html("PEROLEHAN SEBUT HARGA PTJ")

            //$('#IdJualan').html(MklmtNaskah.IdJualan);
            $('#PTJ').val(MklmtNaskah[0].PTJ);
            $('#NoSebutHarga').html(MklmtNaskah[0].No_Sebut_Harga);
            $('#TujuanNaskah').html(MklmtNaskah[0].Tujuan);
            $('#TkhPamer').val(TkhPamer);
            $('#TkhJual').val(TkhJual);
            $('#TkhTutup').val(TkhTutup);
            $('#TempatHantar').val(MklmtNaskah[0].Tempat_Hantar);
            $('#KatPO').val(MklmtNaskah[0].KatPO);
            $('#KaedahPO').val(MklmtNaskah[0].KaedahPO);
            $('#TkhLawat').val(TkhLawat);
            $('#TempatLawat').val(MklmtNaskah[0].TempatLawat);
            $('#HargaNaskah').val(MklmtNaskah[0].Harga);

            // Loop Bidang
            for (var i = 0; i < MklmtNaskah.length; i++) {
                //$('#BidangPO').html(MklmtNaskah[i].Kod_Bidang);

                var value = MklmtNaskah[i].ButiranBidang;
                $('#BidangPO').append('<p>' + value + '</p>');
            }
            //Skop
            $('#SkopNaskah').html(MklmtNaskah[0].Skop);
            $('#ArahanNaskah').html(MklmtNaskah[0].Syarat_Perolehan);
            $('.btnTempahNaskah').attr("data-id", MklmtNaskah[0].IdNaskah);
            $('.btnTempahNaskah').attr("No_Mohon", MklmtNaskah[0].No_Mohon);
            $('.btnTempahNaskah').attr("data-mode", "PTJ");

        }

        async function SetValueToTempahanTender(MklmtNaskah) {

            var TkhPamer = formatMalayDate(MklmtNaskah[0].TkhMula);
            var TkhJual = formatMalayDate(MklmtNaskah[0].TkhJual);
            var TkhTutup = formatMalayDate(MklmtNaskah[0].TkhTutup);
            var TkhLawat = formatMalayDate(MklmtNaskah[0].TkhLawat);

            $('#titleTempahanModal').html("PEROLEHAN SEBUT HARGA TENDER")

            //$('#IdJualan').html(MklmtNaskah.IdJualan);
            $('#PTJ').val(MklmtNaskah[0].PTJ);
            $('#NoSebutHarga').html(MklmtNaskah[0].No_Sebut_Harga);
            $('#TujuanNaskah').html(MklmtNaskah[0].Tujuan);
            $('#TkhPamer').val(TkhPamer);
            $('#TkhJual').val(TkhJual);
            $('#TkhTutup').val(TkhTutup);
            $('#TempatHantar').val(MklmtNaskah[0].Tempat_Hantar);
            $('#KatPO').val(MklmtNaskah[0].KatPO);
            $('#KaedahPO').val(MklmtNaskah[0].KaedahPO);
            $('#TkhLawat').val(TkhLawat);
            $('#TempatLawat').val(MklmtNaskah[0].TempatLawat);
            $('#HargaNaskah').val(MklmtNaskah[0].Harga);

            // Loop Bidang
            for (var i = 0; i < MklmtNaskah.length; i++) {
                //$('#BidangPO').html(MklmtNaskah[i].Kod_Bidang);

                var value = MklmtNaskah[i].ButiranBidang;
                $('#BidangPO').append('<p>' + value + '</p>');
            }
            //Skop
            $('#SkopNaskah').html(MklmtNaskah[0].Skop);
            $('#ArahanNaskah').html(MklmtNaskah[0].Syarat_Perolehan);

            $('.btnTempahNaskah').attr("data-id", MklmtNaskah[0].IdNaskah);
            $('.btnTempahNaskah').attr("No_Mohon", MklmtNaskah[0].No_Mohon);
            $('.btnTempahNaskah').attr("data-mode", "TENDER");
        }

        async function clearAllValueNaskah() {
            $('#PTJ').val('');
            $('#NoSebutHarga').html('');
            $('#TujuanNaskah').html('');
            $('#TkhPamer').val('');
            $('#TkhJual').val('');
            $('#TkhTutup').val('');
            $('#TempatHantar').val('');
            $('#KatPO').val('');
            $('#KaedahPO').val('');
            $('#TkhLawat').val('');
            $('#TempatLawat').val('');
            $('#HargaNaskah').val('');
            $('#BidangPO').html(''); // Clear BidangPO content
            $('#SkopNaskah').html('');
            $('#ArahanNaskah').html('');
        }

        function formatMalayDate(dateString) {
            // Assuming dateString is in the format "Sunday, 25 January 2023, 10.00 AM"

            // Parse the English date string into a JavaScript Date object
            var date = new Date(dateString);

            // Format the date in Malay language with AM/PM
            var options = { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric', hour: 'numeric', minute: 'numeric', hour12: true };
            var formattedDate = date.toLocaleDateString('ms-MY', options);

            return formattedDate;
        }

        // Call the updateModalBadge function when the modal is shown
        $('#yourModalId').on('shown.bs.modal', function () {
            updateModalBadge();
        });

        async function AjaxLoadDataOrderNaskah(Id) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'EPerolehan_WS.asmx/LoadData_OrderNaskah',
                    method: 'POST',
                    data: JSON.stringify({ IdNaskah: Id }),
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

        $('.btnOrderNaskah').on('click', async function (event) {

            event.preventDefault();

            var OrderID = $(this).attr("data-id");
            // var OrderID = "your_order_id_here";

            // Construct the URL with the OrderID
            var url = `https://evendor.utem.edu.my/PendaftaranSyarikat/Bayar2.php?IdSya=${OrderID}`;

            // Redirect to the constructed URL
            window.location.href = url;
        });


        //////////////////////////////////////   Tbl Lesen /////////////////////////////////////////

        var tblLesen = null
        $(document).ready(function () {
            /* show_loader();*/
            tblLesen = $("#tblDataLesen").DataTable({
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
                    "url": "EPerolehan_WS.asmx/LoadList_Lesen",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter by Session Syarikat
                        return JSON.stringify({
                            Id: 'NJ4100000000020224',
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
                    { "data": "Kod_Lesen" },
                    { "data": "ButiranLesen" },
                    { "data": "Maklumat_Lanjut" },

                ]
            });
        });

    </script>

</asp:Content>
