<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="semakanzon.aspx.vb" Inherits="SMKB_Web_Portal.semakanzon" %>

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
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Semakan Bendahari Zon</h5>
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

                    <div class=" -body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblSenaraiPerolehan" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>
                                            <th scope="col">No Mohon</th>
                                            <th scope="col">Tarikh Mohon</th>
                                            <th scope="col">Id Pemohon</th>
                                            <th scope="col">Nama Pemohon</th>
                                            <th scope="col">Kategori PO</th>
                                            <th scope="col">Status</th>
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


        <!-- Modal -->
        <div class="modal fade" id="transaksi" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable" role="document">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title">Senarai Permohonan Perolehan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>


                    <div class="modal-body">
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
                                        <input class="input-group__input" name="Status" id="lblStatus1" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Status">Status</label>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="No Perolehan" id="txtNoPO" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="No Perolehan">No Perolehan</label>
                                    </div>
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
                                    <div class="form-group col-md-12">
                                        <textarea class="input-group__input" id="txtSkop" placeholder="&nbsp;" name="Skop" readonly style="background-color: #f0f0f0"></textarea>
                                        <label class="input-group__label" for="Skop">Skop</label>
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

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" name="PTJ" id="txtKaedahPerolehan" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="PTJ">Kaedah Perolehan</label>
                                    </div>

                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <input class="input-group__input" name="Pemohon" id="txtPemohon" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Pemohon">Pemohon</label>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <input class="input-group__input" name="PTJ" id="ddlPTJPemohon" type="text" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="PTJ">PTJ</label>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" id="txtTkh" name="Tarikh Transaksi" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Tarikh Keperluan">Tarikh Keperluan</label>
                                    </div>


                                    <div class="form-group col-md-4">
                                        <input class="input-group__input" id="txtAmaun" placeholder="&nbsp;" name="Rekod Perolehan Terdahulu" oninput="formatInput(this)" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Rekod Perolehan Terdahulu">Rekod Perolehan Terdahulu (RM)</label>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <textarea class="input-group__input" id="txtJustifikasi" placeholder="&nbsp;" name="Justifikasi Perolehan" readonly style="background-color: #f0f0f0"></textarea>
                                        <label class="input-group__label" for="Justifikasi Perolehan">Justifikasi Perolehan</label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <p><strong>Kod Bidang</strong></p>
                        <div>
                            <div class="table-responsive">
                                <table id="tblMof" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <%--<th scope="col">Id_Upload</th>--%>
                                            <th scope="col">Bil</th>
                                            <th scope="col">Kod Bidang</th>
                                            <th scope="col">Bidang</th>
                                            <th scope="col">Situasi Keperluan</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tfoot>
                                    </tfoot>
                                </table>
                            </div>
                            <br />
                            <p><strong>PERNYATAAN KOD BIDANG :</strong></p>
                            <label id="ringkasanL1" style="font-weight: unset"></label>
                            <label id="ringkasanL2" style="font-weight: unset"></label>
                            <br />
                        </div>
                        <br />
                        <p><strong>Pengkhususan</strong></p>
                        <div>
                            <div class="table-responsive">
                                <table id="tblCidb" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <%--<th scope="col">Id_Upload</th>--%>
                                            <th scope="col">Bil</th>
                                            <th scope="col">Kod Kategori</th>
                                            <th scope="col">Kod Khusus</th>
                                            <th scope="col">Pengkhususan</th>
                                            <th scope="col">Situasi Keperluan</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tfoot>
                                    </tfoot>
                                </table>
                            </div>
                            <br />
                            <p><strong>PERNYATAAN KOD KHUSUS :</strong></p>
                            <label id="ringkasanL3" style="font-weight: unset"></label>
                            <br />
                            <label id="ringkasanL4" style="font-weight: unset"></label>
                            <br />
                        </div>

                        <br /><br />

                            <div class="transaction-table table-responsive">
                                <table id="tblDataPerolehanDtl" class="table table-striped" style="width: 99%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">KW</th>
                                            <th scope="col">KO</th>
                                            <th scope="col">PTJ</th>
                                            <th scope="col">KP</th>
                                            <th scope="col">Vot</th>
                                            <th scope="col">Baki Peruntukan (RM)</th>
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
                                            <th colspan="11" style="text-align: right" >Jumlah Besar (RM):</th>
                                            <th></th>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>

                        <br /><br />

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
                            <label style="margin-right:10px">Spesifikasi :</label>
<%--                         <button class="lihat-spek-am" id="spekAm">Lihat Spesifikasi Am</button>
                             <button class="lihat-spek-teknikal" id="spekTeknikal">Lihat Spesifikasi Teknikal</button>
--%>
                            <span class="badge badge-info p-2 m-1 lihat-spek-am" style="border-radius:5px;cursor:pointer">
                                <i class="fa fa-file" style="font-size:14px"></i>
                                <label style="margin-left:5px;margin-bottom:0px;font-size:14px;cursor:pointer">Lihat Spesifikasi Am</label>
                            </span>

                            <span class="badge badge-info p-2 m-1 lihat-spek-teknikal" style="border-radius:5px;cursor:pointer">
                                <i class="fa fa-file" style="font-size:14px"></i>
                                <label style="margin-left:5px;margin-bottom:0px;font-size:14px;cursor:pointer">Lihat Spesifikasi Teknikal</label>
                            </span>

                           <br /><br />


                    </div>

                    <div class="modal-footer modal-footer--sticky" style="padding: 0px!important">
                        <div style="margin:5px">
                            <input class="form-check-input" type="checkbox" value="" id="flagPT">
                            <label class="form-check-label" for="e-perolehan">
                                         Perolehan-Perolehan yang dikecualikan daripada tatacara perolehan kerajaan.
                            </label>
                        </div>
                    </div>

                     <div class="modal-footer modal-footer--sticky" style="padding: 0px!important; border-top:unset">                        
                        <button type="button" class="btn btn-setsemula btnKemaskini" data-toggle="tooltip" data-placement="bottom">Kemaskini</button>
                        <button type="button" class="btn btn-success btnLulus" data-toggle="tooltip" data-placement="bottom">Sokong</button>                     
                    </div>



                </div>
            </div>
        </div>


        <%--  modal lulus permohonan--%>
        <div class="modal fade" id="saveConfirmationModal10" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabel10">Hantar Permohonan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessage10"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="confirmSaveButton10">Ya</button>
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
            var tbl9 = null;
            var tbl8 = null;
            var gblNoMohon = "";
            var tblLampiran = null;
            var tblSpek = null;
            
            var NomborStaf = '<%= Session("ssusrID") %>';
            var no_mohon = "";

            $(document).ready(function () {

                $('.lihat-spek-am').click(async function (evt) {
                    evt.preventDefault();
                    var result = await setMohonID();
                    if (result) {
                        window.open("Spesifikasi_Am.aspx", "_blank");
                    }
                })

                $('.lihat-spek-teknikal').click(async function (evt) {
                    evt.preventDefault();
                    var result = await setMohonID();
                    if (result) {
                        window.open("Spesifikasi_Teknikal.aspx", "_blank");
                    }
                })


                async function setMohonID() {
                    return new Promise((resolve, reject) => {
                        $.ajax({
                            type: 'POST',
                            url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SetNoMohon") %>',
                            data: JSON.stringify({ IdMohon: $('#txtNoMohon').val() }),
                            contentType: 'application/json; charset=utf-8',
                            dataType: 'json',
                            success: function (response) {
                                resolve(response.d)
                            },
                            error: function (error) {
                            }
                        });
                    })
                }

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
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_SenaraiSemakanZon") %>',
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
                                isClicked5: isClicked,
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
                            no_mohon = data.No_Mohon;

                            $("#txtNoMohon").val(data.No_Mohon);
                            $("#lblTarikhPO").val(data.Tarikh_Mohon);
                            $("#lblStatus1").val(data.ButiranKodDok);


                            $("#txtNoPO").val(data.No_Perolehan);

                            $("#txtTujuan").val(data.Tujuan);
                            $("#txtSkop").val(data.Skop);


                            $("#ddlkategoriPO").val(data.ButiranB);
                            //$("#txtKaedahPerolehan").val(data.No_Mohon);

                            $("#txtPemohon").val(data.Nama);
                            $("#ddlPTJPemohon").val(data.KP);

                            $("#txtTkh").val(data.Bekal_Sebelum);
                            $("#txtAmaun").val(data.Perolehan_Terdahulu);

                            $("#txtJustifikasi").val(data.Justifikasi);

                            $('#transaksi').modal('show'); //modal
                            getBidangKod();
                            getBidangKod2();
                            getBidangKod3();
                            getBidangKod4();
                            showKaedahPerolehan();

                            gblNoMohon = no_mohon;

                            tbl9.ajax.reload();
                            tbl8.ajax.reload();
                            tblLampiran.ajax.reload();
                            tblSpek.ajax.reload();

                     

                        });
                    },


                    "columns": [
                        { "data": "No_Mohon" },
                        { "data": "Tarikh_Mohon" },
                        { "data": "Id_Pemohon" },
                        { "data": "Nama" },
                        { "data": "kategori_butiran" },
                        { "data": "ButiranKodDok" },
                    ]
                });

                tbl9 = $("#tblCidb").DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_Cidb") %>',
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
                        { "data": "Bil" }, // Empty column for index/bil
                        { "data": "Kod_Kategori" },
                        { "data": "Kod_Khusus" },
                        { "data": "Butiran" },
                        { "data": "Syarat" },
                    ],
                    "columnDefs": [
                        {
                            "targets": 0,
                            visible: false,
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Render the index/bil as row number
                                return meta.row + 1;
                            }
                        },
                    ]
                });

                tbl8 = $("#tblMof").DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_BidangMof") %>',
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
                        { "data": "Bilangan", "title": "Bil" }, // Empty column for index/bil
                        { "data": "Kod_Bidang", "title": "Kod_Bidang" },
                        { "data": "Butiran", "title": "Butiran" },
                        { "data": "Syarat", "title": "Syarat" }
                    ],
                    "columnDefs": [
                        {
                            "targets": 0,
                            visible: false,
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Render the index/bil as row number
                                return meta.row + 1;
                            }
                        },
                    ]
                });

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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadOrderRecord_PerolehanDtl") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ id: gblNoMohon })
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

                        // Update footer
                        api.column(11).footer().innerHTML =
                            pageTotal.toFixed(2);
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
                        { "data": "Bilangan" },
                        { "data": "Kod_Kump_Wang" },
                        { "data": "Kod_Operasi" },
                        { "data": "Kod_Ptj" },
                        { "data": "Kod_Projek" },
                        { "data": "Kod_Vot" },
                        { "data": "Baki_Peruntukan" },
                        { "data": "Butiran" },
                        { "data": "Kuantiti" },
                        { "data": "Ukuran" },
                        { "data": "Kadar_Harga" },
                        { "data": "Jumlah_Harga" },
                    ],
                    "columnDefs": [
                        {
                            "targets": 0,
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Render the index/bil as row number
                                return meta.row + 1;
                            }
                        },
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

                load_loader();
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

            function getBidangKod() {
                var noMohon = no_mohon;
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/PaparStatusBidang") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({ noMohon: noMohon }),
                    success: function (result) {
                        result = JSON.parse(result.d)
                        $('#displayKodBidang1').html(result.Payload);
                        $('#ringkasanL1').html(result.Payload);
                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                    }
                });
            }


            function getBidangKod2() {
                var noMohon2 = $('#txtNoMohon').val();
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/PaparStatusBidangDescription") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    data: JSON.stringify({ noMohon2: noMohon2 }),
                    success: function (result) {
                        result = JSON.parse(result.d)
                        $('#displayKodBidang2').html(result.Payload);
                        $('#ringkasanL2').html(result.Payload);

                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                    }
                });
            }
            getBidangKod2();


            function getBidangKod3() {
                var noMohon = $('#txtNoMohon').val();
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/PaparStatusCidb") %>',
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json', // Expecting plain text from the server
                    data: JSON.stringify({ noMohon: noMohon }),
                    success: function (result) {
                        result = JSON.parse(result.d)
                        $('#displayKodBidang3').html(result.Payload);
                        $('#ringkasanL3').html(result.Payload);

                    },
                    error: function (error) {
                        // Handle the case when there is an AJAX error
                        console.error('AJAX error:', error);
                    }
                });
            }
            getBidangKod3();


            function getBidangKod4() {
                var noMohon = $('#txtNoMohon').val();
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/PaparStatusCidbDescription") %>',
                   contentType: 'application/json; charset=utf-8',
                   dataType: 'json',
                   data: JSON.stringify({ noMohon: noMohon }),
                   success: function (result) {
                       result = JSON.parse(result.d)
                       $('#displayKodBidang4').html(result.Payload);
                       $('#ringkasanL4').html(result.Payload);
                   },
                   error: function (error) {
                       // Handle the case when there is an AJAX error
                       console.error('AJAX error:', error);
                   }
               });
            }
            getBidangKod4();


            //buttton lulus
            $('.btnLulus').off('click').on('click', async function () {
                var msg = "Anda pasti ingin meluluskan permohonan perolehan ini?";
                $('#confirmationMessage10').text(msg);
                $('#transaksi').modal('hide');
                $('#saveConfirmationModal10').modal('show');

                $('#confirmSaveButton10').off('click').on('click', async function () {
                    $('#saveConfirmationModal10').modal('hide');

                    var UpdateStatusLulusZon = {
                        txtNoMohonR: $('#txtNoMohon').val(),
                        flagPT: $('#flagPT').prop("checked"),
                        txtKodPejabat: $('#ddlPTJPemohon').val().replace(/\D/g, ''),
                    };

                    try {
                        var result = JSON.parse(await ajaxLulusPermohonan1(UpdateStatusLulusZon));
                        if (result.Status === true) {
                            showModal10("Success", result.Message, "success");
                            tbl.ajax.reload();

                        } else {
                            showModal10("Error", result.Message, "error");
                        }
                    } catch (error) {
                        console.error('Error:', error);
                        showModal1("Error", "An error occurred during the request.", "error");
                    }
                });
            });

            async function ajaxLulusPermohonan1(UpdateStatusLulusZon) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/ZonLulusPermohonan") %>',
                       method: 'POST',
                        data: JSON.stringify(UpdateStatusLulusZon),
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
       






            //buttton kemaskini
            $('.btnKemaskini').off('click').on('click', async function () {

                $('#transaksi').modal('hide');
                $('#saveConfirmationModal11').modal('show');

                $('#confirmSaveButton11').off('click').on('click', async function () {
                    $('#saveConfirmationModal11').modal('hide');
                    
                    var UpdateStatusKemaskiniZon = {
                        txtNoMohonR: no_mohon,
                        Ulasan: $('#txtUlasan').val(),
                        NoStaff: NomborStaf                    
                    };
                    console.log(UpdateStatusKemaskiniZon)
                    try {
                        var result = JSON.parse(await ajaxKemaskiniPermohonan(UpdateStatusKemaskiniZon));
                        if (result.Status === true) {
                            showModal11("Success", result.Message, "success");

                        } else {
                            showModal11("Error", result.Message, "error");
                        }

                    } catch (error) {
                        console.error('Error:', error);
                        showModal11("Error", "An error occurred during the request.", "error");
                    }
                });
            });

            async function ajaxKemaskiniPermohonan(UpdateStatusKemaskiniZon) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/ZonKemaskiniPermohonan") %>',
                       method: 'POST',
                        data: JSON.stringify(UpdateStatusKemaskiniZon),
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

            function showModal11(title, message, type) {
                $('#resultModalTitle11').text(title);
                $('#resultModalMessage11').text(message);
                if (type === "success") {
                    $('#resultModal11').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal11').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal11').modal('show');
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


        </script>
    </div>
</asp:Content>
