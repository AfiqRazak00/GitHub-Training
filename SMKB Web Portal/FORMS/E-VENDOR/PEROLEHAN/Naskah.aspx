<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Naskah.aspx.vb" Inherits="SMKB_Web_Portal.Naskah" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <%--<div class="modal fade" id="TempahanNaskahModalUni" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">--%>
    <div id="divNaskah">
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
                                        <p id="ButiranBdgPO"></p>
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
                    <%--<div class="text-center">
                            <button type="button" id="btnTempahNaskah" class="btn btn-success btnTempahNaskah">Tempah </button>
                        </div>--%>
                    <div class="row">
                        <div class="col-md-6" align="left">
                            <!-- Button semak(kanan) and kembali(kiri) -->
                            <button type="button" class="btn btn-primary btnKembali" data-toggle="tooltip" data-placement="bottom" title="Kembali">
                                <i class="fa fa-arrow-left" aria-hidden="true"></i>Kembali</button>
                        </div>
                        <div class="col-md-6" align="right">
                            <button type="button" class="btn btn-success btnTempahNaskah" data-toggle="tooltip" data-placement="bottom" title="Tempah">
                                <i class="fa fa-check" aria-hidden="true"></i>Tempah</button>
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>

    <div id="DivBayar" style="display: none;">
        <div class="col-md-12">
            <h3>Pembayaran Melalui MIGS </h3>
            <p></p>
            <iframe scrolling="auto" id="frame1" name="frame1" frameborder="0" style="width: 98%; height: 800px; display: inline"></iframe>
        </div>
    </div>
    <%--</div>
    </div>--%>

    <div class="modal fade" id="OrderNaskahModal" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
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

        /////////////////////////////////////       GLOBAL       /////////////////////////////////////////////
        async function DisplayMaklumanModal(msg) {
            $('#detailMakluman').html(msg);
            $('#maklumanModal').modal("toggle");
        }

        $('.btnKembali').on('click', async function () {
            <%--var Url = '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PEROLEHAN/Tawaran_Iklan.aspx")%>';
            window.location.href = Url;--%>
            show_loader();
            window.history.back();
            close_Loader();
            //return false;
        });

        $('.btnOrderNaskah').on('click', async function (event) {

            $('#OrderNaskahModal').modal("toggle");

            event.preventDefault();

            var IdJualan = sessionStorage.getItem('IdJualan');
            var NoMohon = sessionStorage.getItem('NoMohon');

            var newOrder = {
                DataOrder: {
                    IdPembelian: '',
                    IdJualan: IdJualan,
                    NoMohon: NoMohon,
                    TkhBeli: '',
                    IdSyarikat: $('#IDSya').val(),
                }
            }

            var Result = JSON.parse(await AjaxOrderIklan(newOrder));
            console.log("result: ", Result);
            if (Result.Code == "00") {
                debugger;
                if ($('#HargaNaskah').val() == "0.00" || $('#HargaNaskah').val() == "0" || $('#HargaNaskah').val() === null) {
                    displayMaklumanModal("Naskah Berjaya Ditempah");
                    return false;
                } else {
                    OpenBayaran(Result.Payload);
                }
                //var resp = OpenBayaran(Result.Payload);
                //if (resp.code == 200) {
                //    DisplayMaklumanModal(Result.Message);
                //} else {
                //    DisplayMaklumanModal(Result.Message);
                //}
            } else {
                DisplayMaklumanModal(Result.Message)
                return false;
            }


            //var OrderID = $(this).attr("data-id");
            //// var OrderID = "your_order_id_here";

            //// Construct the URL with the OrderID
            //var url = `https://evendor.utem.edu.my/PendaftaranSyarikat/Bayar2.php?IdSya=${OrderID}`;

            //// Redirect to the constructed URL
            //window.location.href = url;
        });

        async function OpenBayaran(IdPembelian) {
            $("#divNaskah").hide();
            // Show divBayar
            $("#DivBayar").show();
            // Set the frame source
            var url = 'https://evendor.utem.edu.my/PendaftaranSyarikat/Bayar2.php?IdSya=' + IdPembelian;
           //var URL = `https://evendor.utem.edu.my/PendaftaranSyarikat/Bayar2.php?IdSya=${IdPembelian}`;

            //console.log("URL: ", url);
            $('#frame1').attr('src', url);

        }

        async function AjaxOrderIklan(DataOrder) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: 'EPerolehan_WS.asmx/OrderNaskah',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify(DataOrder),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        /////////////////////////////////////       NASKAH       /////////////////////////////////////////////
        $(document).ready(async function () {
            const searchParams = new URLSearchParams(window.location.search);
            let mode = searchParams.get('mode');
            let idNaskah = searchParams.get('IdNaskah');
            let no = searchParams.get('no');

            sessionStorage.setItem('IdJualan', searchParams.get('IdNaskah'));
            //show_loader();

            if (mode == "UNI" || mode == "PTJ" || mode == "TENDER" || mode == "ePO") {
                if (no == '1') {
                    await loadDataAndSetValues(mode, idNaskah);
                    $('.btnTempahNaskah').hide();
                    tblLesen.ajax.reload();
                } else {
                    await loadDataAndSetValues(mode, idNaskah);
                    tblLesen.ajax.reload();
                }
            } else {
                DisplayMaklumanModal("Mode tidak sah");
            }

            //close_loader();
        });

        async function loadDataAndSetValues(mode, idNaskah) {
            try {
                var dataNaskah = JSON.parse(await AjaxLoadDataNaskah(idNaskah));

                if (dataNaskah.length > 0) {
                    clearAllValueNaskah();
                    console.log("DataNaskah[0].TkhMula", dataNaskah[0].Jenis_Dokumen);
                    if (dataNaskah[0].Jenis_Dokumen == "P04") {
                        //match Jenis Dokumen dgn jenis pTJ
                        mode = 'PTJ';
                    } else if (dataNaskah[0].Jenis_Dokumen == "P03") {
                        mode = 'UNI'
                    } else if (dataNaskah[0].Jenis_Dokumen == "P02") {
                        mode="TENDER"
                    }

                    var title = getTitleForMode(mode);
                    setValueToTempahan(dataNaskah, title, mode);
                } else {
                    //window.history.back();
                    DisplayMaklumanModal("Tiada Maklumat Naskah " + mode);
                    return false;
                }
            } catch (error) {
                console.error(error);
                return false;
            }
        }

        function getTitleForMode(mode) {
            if (mode == "UNI") {
                return "PEROLEHAN SEBUT HARGA UNIVERSITI";
            } else if (mode == "PTJ") {
                return "PEROLEHAN SEBUT HARGA PTJ";
            } else if (mode == "TENDER") {
                return "PEROLEHAN SEBUT HARGA TENDER";
            }
        }

        async function setValueToTempahan(dataNaskah, title, mode) {

            var TkhPamer = formatMalayDate(dataNaskah[0].TkhMula);
            var TkhJual = formatMalayDate(dataNaskah[0].TkhJual);
            var TkhTutup = formatMalayDate(dataNaskah[0].TkhTutup);
            var TkhLawat = formatMalayDate(dataNaskah[0].TkhLawat);

            $('#titleTempahanModal').html(title);
            $('#PTJ').val(dataNaskah[0].PTJ);
            $('#NoSebutHarga').html(dataNaskah[0].No_Sebut_Harga);
            $('#TujuanNaskah').html(dataNaskah[0].Tujuan);
            $('#TkhPamer').val(TkhPamer);
            $('#TkhJual').val(TkhJual);
            $('#TkhTutup').val(TkhTutup);
            $('#TempatHantar').val(dataNaskah[0].Tempat_Hantar);
            $('#KatPO').val(dataNaskah[0].KatPO);
            $('#KaedahPO').val(dataNaskah[0].KaedahPO);
            $('#TkhLawat').val(TkhLawat);
            $('#TempatLawat').val(dataNaskah[0].Tempat_Lawatan_Tapak);
            //$('#HargaNaskah').val(dataNaskah[0].Harga);

            var formattedHarga = parseFloat(dataNaskah[0].Harga).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
            $('#HargaNaskah').val(formattedHarga);


            // Loop Bidang
            //for (var i = 0; i < dataNaskah.length; i++) {
            //    var value = dataNaskah[i].ButiranBidang;
            //    $('#BidangPO').append('<p>' + value + '</p>');
            //}

            var DataKodBidang = JSON.parse(await getBidangKod(dataNaskah[0].No_Mohon));
            console.log(DataKodBidang);
            $('#BidangPO').html(DataKodBidang.Payload);
            var DataButiranBdg = JSON.parse(await getBidangKod2(dataNaskah[0].No_Mohon));
            $('#ButiranBdgPO').html(DataButiranBdg.Payload);

            // Skop
            $('#SkopNaskah').html(dataNaskah[0].Skop);
            $('#ArahanNaskah').html(dataNaskah[0].Syarat_Perolehan);

            $('.btnTempahNaskah').attr("data-id", dataNaskah[0].IdNaskah);
            $('.btnTempahNaskah').attr("No_Mohon", dataNaskah[0].No_Mohon);
            $('.btnTempahNaskah').attr("data-mode", mode);
        }

        async function getBidangKod(noMohon) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/PaparStatusBidang") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({ noMohon: noMohon }),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang1').html(result.Payload);
                        //$('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }

        async function getBidangKod2(noMohon) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/PaparStatusBidangDescription") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({ noMohon2: noMohon }),
                    success: function (result) {
                        resolve(result.d);
                        //result = JSON.parse(result.d)
                        //console.log(result);
                        //$('#displayKodBidang2').html(result.Payload);
                        //$('#ringkasanL2').html(result.Payload);

                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                        reject(false);
                    }
                });
            });
        }


        async function AjaxLoadDataNaskah(id) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'EPerolehan_WS.asmx/LoadDataNaskah',
                    method: 'POST',
                    data: JSON.stringify({ Id_Jualan: id }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(errorThrown);
                    }
                });
            });
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
            $('#ButiranBdgPO').html('');
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

        var IdNaskah = sessionStorage.getItem('IdJualan');
        var tblLesen = null
        $(document).ready(function () {
            /* show_loader();*/
            tblLesen = $("#tblDataLesen").DataTable({
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
                            Id: IdNaskah,
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

        /////////////////////////////////////    ORDER NASKAH   ///////////////////////////////////////////////

        $('.btnTempahNaskah').on('click', async function () {
            var dataId = $(this).attr("data-id");
            var dataMode = $(this).attr("data-mode");
            var NoMohon = $(this).attr("No_Mohon");

            var newDataTempah = {
                MklmtIklan: {
                    OrderNaskahID: dataId,
                    NoMohon: NoMohon
                }
            };

            try {
                let checkSya = JSON.parse(await AjaxCheckTempahNaskah(newDataTempah));
                console.log("checkSya: ", checkSya);
                if (checkSya.Code == "00") {
                    var DataOrderNaskah = JSON.parse(await AjaxLoadDataOrderNaskah(dataId));
                    if (DataOrderNaskah.length > 0) {
                        switch (dataMode) {
                            case "UNI":
                                setValueToOrderNaskah(DataOrderNaskah, "PEROLEHAN SEBUT HARGA UNIVERSITI");
                                break;
                            case "PTJ":
                                setValueToOrderNaskah(DataOrderNaskah, "PEROLEHAN SEBUT HARGA PTJ");
                                break;
                            case "TENDER":
                                setValueToOrderNaskah(DataOrderNaskah, "PEROLEHAN SEBUT HARGA TENDER");
                                break;
                            default:
                                DisplayMaklumanModal("Mode Tidak Sah");
                                return;
                        }
                        $('#OrderNaskahModal').modal("toggle");
                    } else {
                        DisplayMaklumanModal("Tiada Maklumat Order");
                    }
                } else {
                    DisplayMaklumanModal(checkSya.Message);
                }
            } catch (error) {
                console.error('Error:', error);
                DisplayMaklumanModal("Maaf, Syarikat Anda, Tidak Menepati Kriteria Yang Ditetapkan Di Dalam Naskah Jualan");
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

        async function setValueToOrderNaskah(DataOrderNaskah, title) {
            $('#titleOrderNaskahModal').html(title);

            $('#noPerolehan').val(DataOrderNaskah[0].No_Perolehan);
            $('#TajukOrder').val(DataOrderNaskah[0].Tujuan);
            $('#IDSya').val(DataOrderNaskah[0].ID_Sykt);
            $('#NamaSya').val(DataOrderNaskah[0].Nama_Sykt);
            $('#EmelSya').val(DataOrderNaskah[0].Emel_Semasa);
            $('#NoTel').val(DataOrderNaskah[0].Tel_Pej_Semasa);
            $('#MklmtPembelian').val("Tiada Data");

            var formattedHarga = parseFloat(DataOrderNaskah[0].Harga).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
            $('#JumHarga').val(formattedHarga);


            //sessionStorage.setItem('IdJualan', DataOrderNaskah[0].Id_Jualan);
            sessionStorage.setItem('NoMohon', DataOrderNaskah[0].No_Mohon);
        }

    </script>

</asp:Content>
