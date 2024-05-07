<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Kelulusan_Ketua_PTjPBU.aspx.vb" Inherits="SMKB_Web_Portal.Kelulusan_Ketua_PTjPBU" %>

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

        #tblSenaraiPerolehan td:hover {
            cursor: pointer;
        }
    </style>



    <div class="tabcontent" style="display: block">

        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">KELULUSAN KETUA PTJ/PBU</h5>
                    </div>

                    <!-- Start Dropdown Filter -->
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
                                            <label id="lblMula" style="text-align: right; display: none;">Mula: </label>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display: none;" class="form-control date-range-filter">
                                        </div>
                                        <div class="form-group col-md-1">
                                        </div>
                                        <div class="form-group col-md-1">
                                            <label id="lblTamat" style="text-align: right; display: none;">Tamat: </label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display: none;" class="form-control date-range-filter">
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End Dropdown Filter -->

                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblSenaraiPerolehan" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">No Perolehan</th>
                                            <th scope="col">Tajuk</th>
                                            <th scope="col">Kategori</th>
                                            <th scope="col">Tarikh Mohon</th>
                                            <th scope="col">Tarikh Lulus</th>
                                            <th scope="col">Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal -->
        <div class="modal fade" id="transaksi" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable" role="document">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title">KELULUSAN KETUA PTJ/PBU</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>


                    <div class="modal-body">

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="No PT" id="txtNamaPemohon" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="No PT">Nama Pemohon</label>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="Jawatan Pemohon" id="jawatanPemohon" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Jawatan Pemohon">Jawatan Pemohon </label>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="No. Telefon Pemohon" id="noTelefonPemohon" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="No. Telefon Pemohon">No. Telefon Pemohon </label>
                                    </div>

                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="No Permohonan" id="txtNoMohon" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="No Permohonan">No Permohonan</label>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="Tarikh" id="lblTarikhPO" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Tarikh">Tarikh Permohonan</label>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="No PT" id="txtNoPT" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="No PT">No PT</label>
                                    </div>

                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-6">
                                        <input class="input-group__input" name="Pembekal" id="txtPembekal" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Pembekal">Pembekal</label>
                                    </div>

                                    <div class="form-group col-md-6">
                                        <input class="input-group__input" id="rujukanPembekal" placeholder="&nbsp;" name="Rujukan Pembekal" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Rujukan Pembekal">Rujukan Pembekal</label>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                   <div class="form-group col-md-6">
                                        <input class="input-group__input" id="bekalSebelum" placeholder="&nbsp;" name="Bekal Sebelum" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Bekal Sebelum">Bekal Sebelum</label>
                                    </div>

                                    <div class="form-group col-md-6">
                                        <input class="input-group__input" id="bayarAtasNama" placeholder="&nbsp;" name="Bayar Atas Nama" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Bayar Atas Nama">Bayar Atas Nama</label>
                                    </div>

                                    <input class="" id="idSyarikat" placeholder="&nbsp;" name="Id Syarikat" type="hidden" />
                                    <input class="" id="kodSyarikat" placeholder="&nbsp;" name="Kod Syarikat" type="hidden" />
                                 
                                </div>
                            </div>
                            </div>
                        

                         <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-12">
                                        <textarea class="input-group__input" id="txtTujuan" placeholder="&nbsp;" name="Tajuk / Tujuan" readonly style="background-color: #f0f0f0"></textarea>
                                        <label class="input-group__label" for="Tajuk / Tujuan">Tajuk / Tujuan</label>
                                    </div>

                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                     <div class="form-group col-md-4">
                                        <input class="input-group__input" name="PTJ" id="ddlkategoriPO" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="PTJ">Kategori Perolehan</label>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <p>Lampiran</p>
                        <div class="transaction-table table-responsive">
                            <table id="tblSimpanUpload" class="table table-striped" style="width: 99%">
                                <thead>
                                    <tr>
                                        <th scope="col">Bil</th>
                                        <th scope="col">Nama Fail</th>
                                        <th scope="col">Tindakan</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                <tfoot>
                                </tfoot>
                            </table>
                        </div>

                        <br /><br />
                      <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-12">
                                        <input class="input-group__input" name="Bekal Kepada" id="txtBekalKepada" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Bekal Kepada">Bekal Kepada</label>
                                    </div>

                                </div>
                            </div>
                        </div>
                    
                         <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-12">
                                        <input class="input-group__input" name="Alamat" id="txtAlamat" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Alamat">Alamat</label>
                                    </div>

                                </div>
                            </div>
                        </div>

                         <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="Poskod" id="txtPoskod" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Poskod">Poskod</label>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="Bandar" id="txtBandar" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Bandar">Bandar</label>
                                    </div>

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="Negeri" id="txtNegeri" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Negeri">Negeri</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <br /><br />

                        <div class="transaction-table table-responsive">
                            <table id="tblDataPerolehanDtl" class="table table-striped" style="width: 99%">
                                <thead>
                                    <tr>
                                        <th scope="col">Id No Dtl</th>
                                        <th scope="col">Bil</th>
                                        <th scope="col">KW</th>
                                        <th scope="col">KO</th>
                                        <th scope="col">PTJ</th>
                                        <th scope="col">KP</th>
                                        <th scope="col">Vot</th>
                                        <th scope="col">Barang / Perkara</th>
                                        <th scope="col">Kuantiti</th>
                                        <th scope="col">Ukuran</th>
                                        <th scope="col">Anggaran Harga Seunit (RM)</th>
                                        <th scope="col">Jumlah Anggaran Harga (RM)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th colspan="11" style="text-align: right">Jumlah Besar (RM):</th>
                                        <th></th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>


                    </div>

                     <div class="modal-footer modal-footer--sticky" style="padding: 0px!important">                        
                        <%-- <button type="button" class="btn btn-setsemula btnTidakLulus" data-toggle="tooltip" data-placement="bottom">Tidak Lulus</button>--%>
                        <button type="button" class="btn btn-success btnLulusPt" data-toggle="tooltip" data-placement="bottom">Lulus</button>                     
                    </div>



                </div>
            </div>
        </div>


        <%--  modal lulus permohonan--%>
        <div class="modal fade" id="saveConfirmationModal10" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabel10">Lulus Pesanan Tempatan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessage10"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="registerPT">Ya</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Result Lulus -->
        <div class="modal fade" id="resultModal10" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="resultModalLabel10">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="resultModalMessage10"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>




        <%--modal untuk kemaskini button--%>
         <div class="modal fade" id="saveConfirmationModal11" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg" role="document">
              <div class="modal-content">
                  <div class="modal-header">
                      <h5 class="modal-title" id="saveConfirmationModalLabel11">Ulasan</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                      </button>
                  </div>
                  <div class="modal-body">
                      <div class="row">
                          <div class="col-md-12">
                              <div class="form-row">
                                  <div class="form-group col-md-12">
                                      <textarea class="input-group__input js-group-one" id="txtUlasan" placeholder="&nbsp;" name="Tajuk / Tujuan" style="height:140px" ></textarea>
                                      <label class="input-group__label" for="Tajuk / Tujuan">Sila Masukkan Ulasan</label>
                                  </div>
                              </div>
                          </div>
                      </div>

                  </div>
                  <div class="modal-footer" style="padding:0px" >
                      <button type="button" class="btn btn-setsemula" data-dismiss="modal">Tutup</button>
                      <button type="button" class="btn btn-secondary" id="confirmSaveButton11">Hantar</button>
                  </div>
              </div>
          </div>
      </div>

      <!-- Modal Result Kemaskini -->
      <div class="modal fade" id="resultModal11" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
          <div class="modal-dialog" role="document">
              <div class="modal-content">
                  <div class="modal-header">
                      <h5 class="modal-title" id="resultModalLabel11">Makluman</h5>
                      <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                      </button>
                  </div>
                  <div class="modal-body">
                      <p id="resultModalMessage11"></p>
                  </div>
                  <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                  </div>
              </div>
          </div>
      </div>

        <script type="text/javascript">

            var tbl = null
            var isClicked = false;
            var gblNoMohon = "";
            var tblLampiran = null;
            var tblSpek = null;
            var No_skyt = "";


            var NomborStaf = '<%= Session("ssusrID") %>';
            var no_mohon = "";

            $(document).ready(function () {

                tbl = $("#tblSenaraiPerolehan").DataTable({

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
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/Load_LulusPtOlehPtj") %>',
                        method: 'POST',
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
                                isClicked5: isClicked,
                                tkhMula: startDate,
                                tkhTamat: endDate
                            })
                        }
                    },

                    "rowCallback": function (row, data) {
                        $(row).hover(function () {
                            $(this).addClass("hover pe-auto bg-warning");
                        }, function () {
                            $(this).removeClass("hover pe-auto bg-warning");
                        });

                        $(row).on("click", function () {
                            no_mohon = data.No_Mohon;

                            $("#txtNamaPemohon").val(data.MS01_Nama);
                            $("#jawatanPemohon").val(data.JawGiliran);
                            $("#noTelefonPemohon").val(data.MS01_VoIP);


                            $("#txtNoMohon").val(data.No_Mohon);
                            $("#lblTarikhPO").val(data.Tarikh_Mohon);
                            $("#txtNoPT").val(data.NoPt);

                            $("#bekalSebelum").val(data.Bekal_Sebelum);


                            $("#txtPembekal").val(data.Nama_Sykt);
                            $("#bayarAtasNama").val(data.Nama_Sykt);




                            $("#txtTujuan").val(data.Tujuan);

                            $("#ddlkategoriPO").val(data.ButiranB);

                            $("#txtBekalKepada").val(data.Pejabat);

                            $("#txtAlamat").val(data.Alamat);
                            $("#txtPoskod").val(data.Poskod);
                            $("#txtBandar").val(data.Bandar);
                            $("#txtNegeri").val(data.NegeriButiran);

                            $("#idSyarikat").val(data.ID_Syarikat);
                            $("#kodSyarikat").val(data.Kod_Syarikat);



                            $('#transaksi').modal('show'); //modal

                            gblNoMohon = no_mohon;
                            No_skyt = data.No_sykt;

                            tblLampiran.ajax.reload();
                            tblSpek.ajax.reload();


                        });
                    },


                    "columns": [
                        {
                            "data": "Bil",
                            render: function (data, type, row, meta) {
                                return meta.row + meta.settings._iDisplayStart + 1;
                            },
                            "width": "5%"
                        },
                        { "data": "No_Mohon" },
                        { "data": "Tujuan" },
                        { "data": "MS01_Nama" },
                        { "data": "Tarikh_Mohon" },
                        { "data": "Tujuan" },
                        { "data": "ButiranB" },
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


            $('.btnSearch').click(async function () {
                show_loader();
                isClicked = true;
                tbl.ajax.reload();
                close_loader();
            })

            $("#tblSimpanUpload").off('click', '.viewLampiran').on("click", ".viewLampiran", function (event) {
                var data = tblLampiran.row($(this).parents('tr')).data();
                var fileName = data.Nama_Fail;
                var nomohon = no_mohon;

                openPDFInNewTab(fileName, nomohon);
            });

            function openPDFInNewTab(fileName, nomohon) {
                var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/PEROLEHAN/PERMOHONAN/") %>' + nomohon + '/' + fileName;
                window.open(pdfPath, '_blank');
            }



            $('.btnLulusPt').off('click').on('click', async function () {
                var msg = "Anda pasti untuk melulus pesanan tempatan ini?";
                $('#confirmationMessage10').text(msg);
                $('#transaksi').modal('hide');
                $('#saveConfirmationModal10').modal('show');


                $('#registerPT').off('click').on('click', async function () {
                    $('#saveConfirmationModal10').modal('hide');

                    var newLulusPt = {
                        LulusPt1: {
                            txtNoMohon: $('#txtNoMohon').val(),
                            NoPt: $('#txtNoPT').val(),
                        }
                    }

                    try {
                        var result = JSON.parse(await ajaxLulusPesananTempatan(newLulusPt));
                        if (result.Status === true) {
                            showModal10("Success", result.Message, "success");
                            tbl.ajax.reload();

                        } else {
                            showModal10("Error", result.Message, "error");
                        }
                    }
                    catch (error) {
                        console.error('Error:', error);
                        showModal10("Error", "An error occurred during the request.", "error");
                    }
                });
            });

            async function ajaxLulusPesananTempatan(LulusPt1) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/UpdateLulusPtOlehPtj") %>',
                        method: 'POST',
                        data: JSON.stringify(LulusPt1),
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

            function showModal10(title, message, type) {
                $('#resultModalTitle10').text(title);
                $('#resultModalMessage10').text(message);
                if (type === "success") {
                    $('#resultModal10').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal10').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal10').modal('show');
            }



            function showKaedahPerolehan() {
                var noMohon = $('#txtNoMohon').val();
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetKaedahPerolehan") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({ noMohon: noMohon }),
                    success: function (result) {
                        result = JSON.parse(result.d)
                        $('#txtKaedahPerolehan').val(result[0].Kategori_Perolehan);
                    },
                    error: function (error) {
                        console.error('AJAX error:', error);
                    }
                });
            }


            tblLampiran = $("#tblSimpanUpload").DataTable({
                //retrieve: true,
                info: false,
                ordering: false,
                paging: false,
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
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_Lampiran") %>',
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({ id: gblNoMohon });
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }
                },
                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });
                },
                "columns": [
                    { "data": "Bil" },
                    { "data": "Lampiran" },
                    { "data": null, "title": "Tindakan" }
                ],
                "columnDefs": [
                    {
                        "targets": 0,
                        visible: true,
                        "data": null,
                        "render": function (data, type, row, meta) {
                            // Render the index/bil as row number
                            return meta.row + 1;
                        }
                    },
                    {
                        "targets": 2, // Target the last column (Delete column)
                        "data": null,
                        "render": function (data, type, row) {
                            return `
                                <div class="row">
                                    <div class="col-md-1">
                                        <button type="button" class="btn viewLampiran" style="padding:0px 0px 0px 0px" title="Papar">
                                            <i class="fa fa-eye "></i>
                                        </button>
                                    </div>
                                </div>`;
                        }
                    }
                ]
            });


            tblSpek = $("#tblDataPerolehanDtl").DataTable({
                //retrieve: true,
                info: false,
                ordering: false,
                paging: false,
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
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/Load_PtPtj") %>',
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({ id: gblNoMohon, ID_Sykt: No_skyt })
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }
                },


                footerCallback: function (row, data, start, end, display) {
                    let api = this.api();
                    // Remove the formatting to get integer data for summation
                    let intVal = function (i) {
                        return typeof i === 'string'
                            ? i.replace(/[\$,]/g, '') * 1
                            : typeof i === 'number'
                                ? i
                                : 0;
                    };

                    // Total over all pages
                    total = api
                        .column(11)
                        .data()
                        .reduce((a, b) => intVal(a) + intVal(b), 0);

                    // Total over this page
                    pageTotal = api
                        .column(11, { page: 'current' })
                        .data()
                        .reduce((a, b) => intVal(a) + intVal(b), 0);

                    // Format the total values with thousand separators and two decimal places
                    totalFormatted = total.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
                    pageTotalFormatted = pageTotal.toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');

                    // Update footer with formatted values
                    api.column(11).footer().innerHTML = pageTotalFormatted;
                },

                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });
                },
                "columns": [
                    { "data": "Id_Mohon_Dtl" },
                    { "data": "Bilangan" },
                    { "data": "Kod_Kump_Wang" },
                    { "data": "Kod_Operasi" },
                    { "data": "Kod_Ptj" },
                    { "data": "Kod_Projek" },
                    { "data": "Kod_Vot" },
                    { "data": "Butiran" },
                    { "data": "Kuantiti" },
                    { "data": "NewButiran" },
                    { "data": "Harga_Seunit", "className": "text-right" },
                    { "data": "Jumlah_Harga", "className": "text-right" },
                ],
                "columnDefs": [
                    {
                        "targets": 1,
                        "data": null,
                        "render": function (data, type, row, meta) {
                            // Render the index/bil as row number
                            return meta.row + 1;
                        }
                    },
                ]

            });





        </script>
    </div>
</asp:Content>