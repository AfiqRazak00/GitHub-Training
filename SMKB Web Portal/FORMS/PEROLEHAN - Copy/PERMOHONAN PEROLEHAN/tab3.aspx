<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="tab3.aspx.vb" Inherits="SMKB_Web_Portal.tab3" %>
<asp:Content ID="FormContents" ContentPlaceHolderID="FormContents" runat="server">

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
    </style>
    <contenttemplate>

        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <div id="divpendaftaraninv" runat="server" visible="true">
                <div class="modal-body">
                    <div>  
                        <h5>Senarai Permohonan Perolehan</h5>
                        <hr />

                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblKelulusan" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">No Perolehan</th>
                                            <th scope="col">Tujuan</th>
                                            <th scope="col">Kategori</th>
                                            <th scope="col">Tarikh Mohon</th>
                                            <th scope="col">Anggaran Perbelanjaan (RM)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                    <tfoot>

                                    </tfoot>

                                </table>

                            </div>
                        </div>


                    </div> 
                </div> 
            </div> 
        </div> 


        <div class="modal fade" id="ringkasanPoModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header modal-header--sticky">
                            <h5 class="modal-title">Ringkasan Maklumat Permohonan Perolehan</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">                                  

                             <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <h5>Senarai Permohonan Perolehan</h5>
                                        <table class="table table-borderless">
                                            <tbody>
                                                <tr>
                                                    <td style="font-weight:bold">No Mohon</td>
                                                    <td> 
                                                        <input type="text" class="form-control" placeholder="No Mohon" id="noMohonValue" name="noMohonValue" readonly/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-weight:bold">Tarikh Mohon</td>
                                                    <td>                                                  
                                                         <input type="text" class="form-control" placeholder="Tujuan" id="tkh_mohonValue" name="tkh_mohonValue" readonly/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-weight:bold">Tajuk/Tujuan</td>
                                                    <td>
                                                        <input type="text" class="form-control" placeholder="Tujuan" id="tujuanValue" name="tujuanValue" readonly/>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-weight:bold">Skop</td>
                                                    <td>
                                                        <input type="text" class="form-control" placeholder="Tujuan" id="skopValue" name="skopValue" readonly/>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-weight:bold">Kategori Perolehan</td>
                                                    <td>
                                                        <input type="text" class="form-control" placeholder="Tujuan" id="KategoriValue" name="KategoriValue" readonly/>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td style="font-weight:bold">Tarikh Keperluan</td>
                                                    <td>
                                                        <input type="text" class="form-control" placeholder="Tujuan" id="tkh_keperluanValue" name="tkh_keperluanValue" readonly/>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="font-weight:bold">Rekod Perolehan Terdahulu</td>
                                                    <td>
                                                        <div class="input-group">
                                                            <div class="input-group-prepend">
                                                                <div class="input-group-text">RM</div>
                                                            </div>
                                                        <input type="text" class="form-control" placeholder="Tujuan" id="po_terdahuluValue" name="po_terdahuluValue" readonly/>
                                                        </div>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td style="font-weight:bold">Justifikasi</td>
                                                    <td>
                                                        <input type="text" class="form-control" placeholder="Tujuan" id="justifikasiValue" name="justifikasiValue" readonly/>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>




                                        <h5>Butiran Perolehan</h5>
                                        <hr />
                                        <div class="col-md-12">
                                            <div class="transaction-table table-responsive">
                                                <table id="tblDataPerolehanDtl" class="table table-striped" style="width: 99%">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Id_Mohon_Dtl</th>
                                                            <th scope="col">Bil</th>
                                                            <th scope="col">KW</th>
                                                            <th scope="col">KO</th>
                                                            <th scope="col">PTJ</th>
                                                            <th scope="col">KP</th>
                                                            <th scope="col">Vot</th>
                                                            <!--<th scope="col">Baki Peruntukan (RM)</th>-->
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

                                                    </tfoot>

                                                </table>

                                            </div>
                                        </div>



                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer modal-footer--sticky" style="padding:0px!important">
                            <button type="button" class="btn btn-success btnLulus" data-toggle="tooltip" data-placement="bottom" title="Simpan dan Hantar">Lulus</button>
                            <button type="button" class="btn btn-danger btnXLulus" data-toggle="tooltip" data-placement="bottom" title="Simpan dan Hantar">Tidak Lulus</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Modal Pengesahan (Lulus)-->
            <div class="modal fade" id="saveConfirmationModalLulus" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                <div class="modal-dialog " role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="saveConfirmationModalLabelLulus">Pengesahan</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p id="confirmationMessageLulus"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                            <button type="button" class="btn btn-secondary" id="confirmSaveButtonLulus">Ya</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Result (Lulus)-->
            <div class="modal fade" id="resultModalLulus" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="resultModalLabelLulus">Makluman</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p id="resultModalMessageLulus"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                        </div>
                    </div>
                </div>
            </div>



            <!-- Modal Pengesahan (Tak Lulus)-->
            <div class="modal fade" id="saveConfirmationModalXLulus" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
                <div class="modal-dialog " role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="saveConfirmationModalLabelXLulus">Pengesahan</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p id="confirmationMessageXLulus"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                            <button type="button" class="btn btn-secondary" id="confirmSaveButtonXLulus">Ya</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal Result (Tak Lulus)-->
            <div class="modal fade" id="resultModalXLulus" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="resultModalLabelXLulus">Makluman</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p id="resultModalMessageXLulus"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                        </div>
                    </div>
                </div>
            </div>



        <script type="text/javascript">

            var no_mohon = "";

            var tbl = null;
            $(document).ready(function () {
                tbl = $("#tblKelulusan").DataTable({
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
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadKelulusanPo") %>',
                        //"url": "PermohonanPoWS.asmx/LoadKelulusanPo",
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
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

                        // Add click event
                        $(row).on("click", function () {
                            console.log(data);
                            var rowData = data;

                            no_mohon = rowData.No_Mohon;
                            // Update the modal content with the No_Mohon and Tujuan values
                            $("#noMohonValue").val(rowData.No_Mohon); //BOLEH GUNA NO MOHON UNTUK KELUARKAN DATA
                            $("#tkh_mohonValue").val(rowData.Tarikh_Mohon);
                            $("#tujuanValue").val(rowData.Tujuan);
                            $("#skopValue").val(rowData.Skop);
                            $("#KategoriValue").val(rowData.kategori_butiran);
                            $("#tkh_keperluanValue").val(rowData.Tarikh_Perlu);
                            $("#po_terdahuluValue").val(rowData.Perolehan_Terdahulu);
                            $("#justifikasiValue").val(rowData.Justifikasi);

                            // Show the modal
                            $('#ringkasanPoModal').modal('show');




                            var tbl2 = null;
                            $(document).ready(function () {
                                tbl2 = $("#tblDataPerolehanDtl").DataTable({
                                    "responsive": true,
                                    "searching": false,
                                    "lengthChange": false,
                                    "sPaginationType": "full_numbers",
                                    "oLanguage": {
                                        "oPaginate": {
                                            "sNext": '<i class="fa fa-forward"></i>',
                                            "sPrevious": '<i class="fa fa-backward"></i>',
                                            "sFirst": '<i class="fa fa-step-backward"></i>',
                                            "sLast": '<i class="fa fa-step-forward"></i>'
                                        },
                                        
                                        "sZeroRecords": "Tiada rekod yang sepadan ditemui",
                                        "sInfo": "Menunjukkan _END_ dari _TOTAL_ rekod",
                                        "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                                        "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                                        "sEmptyTable": "Tiada rekod.",
                                        
                                    },
                                    "ajax": {
                                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadOrderRecord_PerolehanDtl") %>',
                                        //"url": "PermohonanPoWS.asmx/LoadOrderRecord_PerolehanDtl",
                                        type: 'POST',
                                        "contentType": "application/json; charset=utf-8",
                                        "dataType": "json",
                                        data: function (d) {
                                            return JSON.stringify({ id: rowData.No_Mohon })
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
                                        { "data": "Id_Mohon_Dtl", "title": "Id_Mohon_Dtl" }, //Hidden
                                        { "data": "Bilangan", "title": "Bil" }, // Empty column for index/bil
                                        { "data": "Kod_Kump_Wang", "title": "KW" },
                                        { "data": "Kod_Operasi", "title": "KO" },
                                        { "data": "Kod_Ptj", "title": "PTJ" },
                                        { "data": "Kod_Projek", "title": "KP" },
                                        { "data": "Kod_Vot", "title": "Vot" },
                                        //{ "data": "Baki_Peruntukan", "title": "Baki Peruntukan (RM)" },
                                        { "data": "Butiran", "title": "Barang / Perkara" },
                                        { "data": "Kuantiti", "title": "Kuantiti" },
                                        { "data": "Ukuran", "title": "Ukuran" },

                                        { "data": "Kadar_Harga", "title": "Anggaran Harga Seunit (RM)" },
                                        { "data": "Jumlah_Harga", "title": "Jumlah Anggaran Harga (RM)" },
                                    ],
                                    "columnDefs": [
                                        {
                                            "targets": 0,
                                            visible: false,
                                            searchable: false
                                        },
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

                            });
                        });
                        
                    },
                    "columns": [
                        { "data": "Bilangan", "title": "Bil" }, // Empty column for index/bil
                        { "data": "No_Mohon", "title": "No Perolehan" },
                        { "data": "Tujuan", "title": "Tujuan" },
                        { "data": "kategori_butiran", "title": "Kategori" },
                        { "data": "Tarikh_Mohon", "title": "Tarikh Mohon" },
                        { "data": "Total_Harga", "title": "Anggaran Perbelanjaan (RM)" }
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
            });

            //Destroy DataTable inside modal if the modal is closed
            $('#ringkasanPoModal').on('hidden.bs.modal', function () {
                if ($.fn.DataTable.isDataTable('#tblDataPerolehanDtl')) {
                    $('#tblDataPerolehanDtl').DataTable().destroy();
                }
            });


            //Lulus with bootstrap modal
            $('.btnLulus').off('click').on('click', async function () {
                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";

                // Set message in the modal
                var msg = "Anda pasti ingin meluluskan permohonan ini?";
                $('#confirmationMessageLulus').text(msg);
                // Open the Bootstrap modal
                $('#saveConfirmationModalLulus').modal('show');

                $('#confirmSaveButtonLulus').off('click').on('click', async function () {
                    $('#saveConfirmationModalLulus').modal('hide'); // Hide the modal

                    var newPermohonanPo = {
                        mohonPo: {
                            nombor_mohon: no_mohon
                        }
                    }

                    var result = JSON.parse(await ajaxLulusPerolehan(newPermohonanPo));
                    if (result.Status === "success") {
                        showModalLulus("Success", result.Message, "success");
                    } else {
                        showModalLulus("Error", result.Message, "error");
                    }
                    tbl.ajax.reload(); //Reload datatable
                });
            });
            async function ajaxLulusPerolehan(mohonPo) {

                return new Promise((resolve, reject) => {

                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LulusPerolehan") %>',
                        //url: 'PermohonanPoWS.asmx/LulusPerolehan',
                        method: 'POST',
                        data: JSON.stringify(mohonPo),
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
            function showModalLulus(title, message, type) {
                $('#resultModalTitleLulus').text(title);
                $('#resultModalMessageLulus').text(message);
                if (type === "success") {
                    $('#resultModalLulus').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModalLulus').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModalLulus').modal('show');
            }




            //Tak Lulus with bootstrap modal
            $('.btnXLulus').off('click').on('click', async function () {
                var jumRecord = 0;
                var acceptedRecord = 0;
                var msg = "";

                // Set message in the modal
                var msg = "Anda pasti ingin menolak permohonan ini?";
                $('#confirmationMessageXLulus').text(msg);
                // Open the Bootstrap modal
                $('#saveConfirmationModalXLulus').modal('show');

                $('#confirmSaveButtonXLulus').off('click').on('click', async function () {
                    $('#saveConfirmationModalXLulus').modal('hide'); // Hide the modal

                    var newPermohonanPo = {
                        mohonPo: {
                            nombor_mohon: no_mohon
                        }
                    }

                    var result = JSON.parse(await ajaxTakLulusPerolehan(newPermohonanPo));
                    if (result.Status === "success") {
                        showModalXLulus("Success", result.Message, "success");
                    } else {
                        showModalXLulus("Error", result.Message, "error");
                    }
                    tbl.ajax.reload(); //Reload datatable
                });
            });
            async function ajaxTakLulusPerolehan(mohonPo) {

                return new Promise((resolve, reject) => {

                    $.ajax({
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/TakLulusPerolehan") %>',
                        //url: 'PermohonanPoWS.asmx/TakLulusPerolehan',
                        method: 'POST',
                        data: JSON.stringify(mohonPo),
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
            function showModalXLulus(title, message, type) {
                $('#resultModalTitleXLulus').text(title);
                $('#resultModalMessageXLulus').text(message);
                if (type === "success") {
                    $('#resultModalXLulus').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModalXLulus').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModalXLulus').modal('show');
            }













        </script>
    </contenttemplate>




</asp:Content>
