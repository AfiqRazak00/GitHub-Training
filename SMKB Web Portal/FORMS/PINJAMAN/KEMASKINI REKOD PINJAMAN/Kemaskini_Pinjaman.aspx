<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Kemaskini_Pinjaman.aspx.vb" Inherits="SMKB_Web_Portal.Kemaskini_Pinjaman" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
     <style>
       .codx {
            display: none;
            visibility: hidden;
        }
   </style>
    <contenttemplate>
        <div class="modal-body">
            <div class="tab-content" id="myTabContent">
                <div class="table-title">
                    <h5>Senarai Pinjaman</h5>
                </div>
                <div class="col-md-13">
                    <div class="transaction-table table-responsive">
                        <span style="display: inline-block; height: 100%;"></span>
                        <table id="tblPinjaman" class="table table-striped">
                            <thead>
                                <tr style="width: 100%">
                                    <th>Bil</th>
                                    <th>No. Pinjaman</th>
                                    <th>Tarikh Mohon</th>
                                    <th>Kategori Pinjaman</th>
                                    <th style="width: 10%">Tempoh Pinjaman</th>
                                    <th style="width: 10%">Amaun Lulus (RM)</th>
                                    <th>Status Pinjaman</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!-- modal kemaskini start -->
        <div class="modal fade" id="modalInvoisData" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" style="min-width: 60%" id="modalKemaskiniData" role="document">
                <div class="modal-content modal-xl">
                    <div class="modal-header modal-header--sticky" style="border-bottom: none !important">
                         <button type="button" class="close d-flex justify-content-end" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-md-7">
                            <div class="form-group input-group">
                                <input type="text" class=" input-group__input form-control input-sm " id="txtnama" name="txtnama" readonly />
                            </div>
                        </div>
                    </div>
                    <ul class="nav nav-tabs" id="subTab">
                         <li class="nav-item">
                            <a class="nav-link active text-uppercase"data-toggle="tab" href="#InfoPemohon" >MAKLUMAT</a>
                         </li>
                         <li class="nav-item" role="presentation">
                            <a class="nav-link text-uppercase" data-toggle="tab" href="#KemaskiniDokumen" >Kemaskini Dokumen</a>
                         </li>
                    </ul>
                    <div class="modal-body">
                        <div class="tab-content" id="tabContent">
                            <div class="tab-pane fade show active" id="InfoPemohon" role="tabpanel">
                                <fieldset class="form-group border p-3" style="border-radius: 5px;">
                                    <legend class="w-auto px-2 h6 font-weight-bold">Maklumat Pemohon</legend>
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <div class="row justify-content-center">
                                                <div class="col-md-2">
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm  " id="txtnostaf" name="txtnostaf" readonly />
                                                        <label class="input-group__label">No Staf</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " name="txttarafpkhd" id="txttarafpkhd" readonly>
                                                        <label class="input-group__label">Taraf Perkhidmatan</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class="input-group__input form-control input-sm  " id="txtgredgaji" name="txtgredgaji" readonly>
                                                        <label class="input-group__label">Gred Gaji</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm text-right" name="txtgajipokok" id="txtgajipokok" readonly>
                                                        <label class="input-group__label">Gaji Pokok</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " id="txtvoipno" name="txtvoipno" readonly>
                                                        <label class="input-group__label">VoIP No.</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " name="txtnokp" id="txtnokp" readonly>
                                                        <label class="input-group__label">No KP</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " name="txtkumppkhd" id="txtkumppkhd" readonly>
                                                        <label class="input-group__label">Kumpulan Perkhidmatan</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " name="txtdob" id="txtdob" readonly>
                                                        <label class="input-group__label">Tarikh Lahir</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="date" class=" input-group__input form-control input-sm " name="txttarikhlantikan" id="txttarikhlantikan" readonly>
                                                        <label class="input-group__label">Tarikh Lantikan</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " name="txtjawatan" id="txtjawatan" readonly>
                                                        <label class="input-group__label">Jawatan</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " id="txtjabatan" name="txtjabatan" readonly>
                                                        <label class="input-group__label">Jabatan</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class="input-group__input form-control input-sm  " id="txtumur" name="txtumur" readonly>
                                                        <label class="input-group__label">Umur Pada Tarikh Memohon</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " id="txttarikhsah" name="txttarikhsah" readonly>
                                                        <label class="input-group__label">Tarikh Sah</label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                                <fieldset class="form-group border p-3" style="border-radius: 5px;">
                                    <legend class="w-auto px-2 h6 font-weight-bold">Maklumat Pinjaman</legend>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="row justify-content-center">
                                                <div class="col-md-4">
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " id="txtkatpinj" name="txtkatpinj" readonly />
                                                        <label class="input-group__label">Kategori Pinjaman</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " name="txttempoh" id="txttempoh" readonly>
                                                        <label class="input-group__label">Tempoh</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " name="txtkelayakan" id="txtkelayakan" readonly>
                                                        <label class="input-group__label">Kelayakan</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group input-group">
                                                        <input type="text" class="input-group__input form-control input-sm  " id="txtjenpinj" name="txtjenpinj" readonly>
                                                        <label class="input-group__label">Jenis Pinjaman</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm text-right " id="txtamaunpinj" name="txtamaunpinj" readonly />
                                                        <label class="input-group__label">Amaun Mohon (RM)</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class="input-group__input form-control input-sm  " id="txtinsentifno" name="txtinsentifno" readonly>
                                                        <label class="input-group__label">No Insentif</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <div class="form-group input-group">
                                                        <input type="text" class=" input-group__input form-control input-sm " name="txttkhmohon" id="txttkhmohon" readonly>
                                                        <label class="input-group__label">Tarikh Mohon</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class="input-group__input form-control input-sm text-right " id="txtansuran" name="txtansuran" readonly>
                                                        <label class="input-group__label">Ansuran Bulanan (RM)</label>
                                                    </div>
                                                    <div class="form-group input-group">
                                                        <input type="text" class="input-group__input form-control input-sm text-right " id="txtinsentifamaun" name="txtinsentifamaun" readonly>
                                                        <label class="input-group__label">Insentif (RM)</label>
                                                    </div>

                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                            <div class="tab-pane fade " id="KemaskiniDokumen" role="tabpanel">
                                <div class="tab-pane fade show active" id="upload" role="tabpanel">                  
                                    <div class="modal-body">
                                        <div>
                                            <h5>Lampiran Dokumen Sokongan</h5>
                                            <hr />
                                            <div class="row">
                                                <div class="col-md-6">
                                                    <div class="card">
                                                        <div class="form-group" style="margin-top: 10px; margin-left: 10px">
                                                            <input type="file" id="uploadDokumen" class="form-control-file" accept="application/pdf"/>
                                                            <small class="form-text text-muted">Jenis fail yang dibenarkan: .pdf only (Saiz Maksimum: 5MB)</small>
                                                            <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                                            <small class="txtSaiz text-danger font-italic form-row col-md-12 col-12">Saiz fail melebihi had maksimum 5MB.</small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                            
                                            <div class="row">
                                                <div class="form-group col-md-6 mt-3">
                                                    <input class="input-group__input" name="butiranFail" id="butiranFail" type="text" />
                                                    <label class="input-group__label" for="butiranFail" style="left:unset">Butiran</label>
                                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                                </div>
                                            </div>

                                           <div class="row">
                                                <div class="form-group col-md-6 mt-3">
                                                    <input class="input-group__input" name="tkhMula" id="tkhMula" type="date" />
                                                    <label class="input-group__label" for="tkhMula" style="left:unset">Tarikh Mula</label>
                                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                                </div>
                                           </div>

                                            <div class="row">
                                                <div class="form-group col-md-6 mt-3">
                                                    <input class="input-group__input" name="tkhTamat" id="tkhTamat" type="date" />
                                                    <label class="input-group__label" for="tkhTamat" style="left:unset">Tarikh Tamat</label>
                                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                                </div>
                                           </div>

                                            <button class="btn btn-secondary" id="savedokumen">Muat Naik</button>
                                        </div>
                                        <br />
                                        <br />
                                        <p>Lampiran</p>
                                        <div class="col-md-12">
                                            <div class="transaction-table table-responsive">
                                                <table id="tblSimpanUpload" class="table table-striped" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Bil</th>
                                                            <th scope="col">Tarikh Dokumen</th>
                                                            <th scope="col">Nama Fail</th>
                                                            <th scope="col">Butiran</th>
                                                            <th scope="col">Tindakan</th>
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
                    </div>
                </div>
            </div>
        </div>
        <%--Modal Alert--%>
        <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                    <h6 class="modal-title">Sistem Maklumat Kewangan Bersepadu</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                    </button>
                    </div>
                    <div class="modal-body">
                    <div id="lblMessageModal"></div>
                    </div>
                    <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal" id="btnTutup">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
        <script>
            var tbl2 = null;

            $(document).ready(function () {
                $(".txtEror").addClass("codx");
                $(".txtSaiz").addClass("codx");

                $('#btnTutup').click(async function () {
                    document.getElementById('uploadDokumen').value = '';
                    document.getElementById('butiranFail').value = '';
                    document.getElementById('tkhMula').value = '';
                    document.getElementById('tkhTamat').value = '';
                    tbl2.ajax.reload();
                })

                $('#savedokumen').click(function (evt) {
                    evt.preventDefault();

                    var fileInput = document.getElementById('uploadDokumen');
                    var butiranFail = $("#butiranFail").val();
                    var tkhMula = $("#tkhMula").val();
                    var tkhTamat = $("#tkhTamat").val();

                    var file = fileInput.files[0];

                    // Check if any of the required fields are empty
                    if (file && butiranFail && tkhMula && tkhTamat) {
                        $(".txtEror").addClass("codx");

                        var fileSize = file.size;
                        var fileName = file.name;
                        var maxSize = 5 * 1024 * 1024; // Maximum size in bytes (5MB)

                        if (fileSize > maxSize) {
                            $(".txtSaiz").removeClass("codx");
                            $("#uploadDokumen").addClass("border border-danger");
                        } else {
                            // Get the full string containing No_Pinj and name
                            var fullString = $("#txtnama").val();

                            // Split the string by tab character (\t)
                            var parts = fullString.split('\t');

                            // Extract the No_Pinj part (the first part after splitting)
                            var No_Pinj = parts[0];

                            var formData = new FormData();
                            formData.append("No_Pinj", No_Pinj);
                            formData.append("fileName", fileName);
                            formData.append("file", file);
                            formData.append("butiranFail", butiranFail);
                            formData.append("tkhMula", tkhMula);
                            formData.append("tkhTamat", tkhTamat);

                            $.ajax({
                                url: "KemaskiniWS.asmx/SimpanDokumen",
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                data: formData,
                                processData: false, // Prevent jQuery from automatically processing the data
                                contentType: false, 
                                success: function (response) {
                                    var jsonString = $(response).find("string").text();

                                    console.log('jsonString:', jsonString);

                                    // Parse JSON string
                                    var result = JSON.parse(jsonString);

                                    if (result.Status) {
                                        $('#lblMessageModal').html(result.Message);
                                        $('#MessageModal').modal('show');
                                    } else {
                                        console.error('Error from server:', result.Message);
                                    }
                                    // Show the modal
                                    $('#MessageModal').modal('show');
                                },
                                error: function (error) {
                                    console.error("AJAX error:", error.responseText);
                                }
                            });
                        }

                    } else {
                        // Some required fields are empty, display error message or highlight empty fields
                        const elementsToCheck = [
                            { condition: !file, selector: "#uploadDokumen" },
                            { condition: !butiranFail, selector: "#butiranFail" },
                            { condition: !tkhMula, selector: "#tkhMula " },
                            { condition: !tkhTamat, selector: "#tkhTamat" }
                        ];

                        elementsToCheck.forEach(({ condition, selector }) => {
                            const element = $(selector).closest('.form-group').find('.txtEror');
                            if (condition) {
                                if ($(selector).is('select')) {
                                    $(selector).parent().addClass("border border-danger");
                                } else {
                                    $(selector).addClass("border border-danger");
                                }
                                element.removeClass('codx');
                            } else {
                                if ($(selector).is('select')) {
                                    $(selector).parent().removeClass("border border-danger");
                                } else {
                                    $(selector).removeClass("border border-danger");
                                }
                                element.addClass('codx');
                            }
                        });
                    }
                });

                tbl = $("#tblPinjaman").DataTable({
                    "responsive": true,
                    "searching": true,
                    "info": true,
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
                        "url": "KemaskiniWS.asmx/fetchSenaraiPinjaman",
                        method: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        "dataSrc": function (json) {
                            return JSON.parse(json.d);
                        }

                    },
                    "columns": [
                        {
                            "data": null,
                            "render": function (data, type, row, meta) {
                                // Auto-incrementing number starting from 1
                                return meta.row + 1;
                            }
                        },
                        { "data": "No_Pinj" },
                        {
                            "data": "Tkh_Mohon",
                            "render": function (data, type, row, meta) {
                                // Parse the date string
                                var date = new Date(data);

                                // Extract day, month, and year
                                var day = date.getDate();
                                var month = date.getMonth() + 1; // Months are zero-based
                                var year = date.getFullYear();

                                // Ensure leading zeros if necessary
                                day = (day < 10) ? '0' + day : day;
                                month = (month < 10) ? '0' + month : month;

                                // Construct the formatted date string
                                var formattedDate = day + '/' + month + '/' + year;

                                return formattedDate;
                            }
                        },
                        { "data": "Kategori_Pinj" },
                        { "data": "Tempoh_Pinj" },
                        {
                            "data": "Amaun",
                            "render": function (data, type, row, meta) {
                                // Assuming data is a numeric value, add style to align right
                                return '<div style="text-align: right;">' + data + '</div>';
                            }
                        },
                        { "data": "Butiran" },
                    ],
                    "rowCallback": function (row, data) {
                        // Add hover effect
                        $(row).hover(function () {
                            $(this).addClass("hover pe-auto bg-warning");
                        }, function () {
                            $(this).removeClass("hover pe-auto bg-warning");
                        });
                    }
                });

                $('#tblPinjaman tbody').on('click', 'tr', function () {
                    $(".txtEror").addClass("codx");
                    $(".txtSaiz").addClass("codx");
                    $("#uploadDokumen").removeClass("border border-danger");
                    $("#butiranFail").removeClass("border border-danger");
                    $("#tkhMula").removeClass("border border-danger");
                    $("#tkhTamat").removeClass("border border-danger");

                    var rowData = tbl.row(this).data(); // Get data of the clicked row
                    var No_Pinj = rowData['No_Pinj'];

                    $.ajax({
                        url: "KemaskiniWS.asmx/fetchMaklumat",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({ No_Pinj: No_Pinj }),
                        dataType: "json",
                        success: function (response) {
                            // Parse the JSON string within the "d" property
                            var responseData = JSON.parse(response.d);
                            // Check if responseData is an array and has at least one element
                            if (Array.isArray(responseData) && responseData.length > 0) {
                                $("#txtnopinj").val(responseData[0].No_Pinj)
                                $("#txtnama").val(responseData[0].No_Pinj + "\t\t\t" + responseData[0].MS01_Nama)
                                $("#txtnostaf").val(responseData[0].No_Staf)
                                $("#txtnokp").val(responseData[0].MS01_KpB)
                                $("#txttarafpkhd").val(responseData[0].Taraf)
                                $("#txtgredgaji").val(responseData[0].MS02_GredGajiS)
                                $("#txtjawatan").val(responseData[0].Jawatan)
                                $("#txtjabatan").val(responseData[0].Pejabat)
                                $("#txtkumppkhd").val(responseData[0].Kumpulan)
                                $("#txtdob").val(responseData[0].MS01_TkhLahir)
                                $("#txtumur").val(responseData[0].AgeFormatted)
                                $("#txttarikhlantikan").val(dateStrFromSQl(responseData[0].MS02_TkhLapor))
                                $("#txttarikhsah").val(responseData[0].MS02_TkhSah)
                                $("#txtgajipokok").val(responseData[0].MS02_JumlahGajiS)
                                $("#txtvoipno").val(responseData[0].MS01_VoIP)

                                $("#txtkatpinj").val(responseData[0].KatPinj)
                                $("#txtamaunpinj").val(responseData[0].Amaun_Mohon)
                                $("#txttkhmohon").val(responseData[0].TkhMohon)
                                $("#txtjenpinj").val(responseData[0].JenisPinj)
                                $("#txttempoh").val(responseData[0].TempohPinj)
                                $("#txtansuran").val(responseData[0].Ansuran)
                                $("#txtkelayakan").val(responseData[0].Kelayakan)
                                $("#txtinsentifamaun").val(responseData[0].amaun_insentif)
                                $("#txtinsentifno").val(responseData[0].no_insentif)
                            }
                        },
                        error: function (error) {
                            console.error("AJAX error:", error.responseText);
                        }
                    });

                    tbl2 = $("#tblSimpanUpload").DataTable({
                        "destroy": true,
                        "responsive": false,
                        "searching": false,
                        "info": false,
                        "paging": false,
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
                            "url": "KemaskiniWS.asmx/fetchSenaraiDokumen",
                            method: 'POST',
                            "contentType": "application/json; charset=utf-8",
                            "dataType": "json",
                            "data": function () {
                                return JSON.stringify({
                                    No_Pinj: No_Pinj
                                })
                            },
                            "dataSrc": function (json) {
                                return JSON.parse(json.d);
                            }

                        },
                        "columns": [
                            {
                                "data": null,
                                "render": function (data, type, row, meta) {
                                    // Auto-incrementing number starting from 1
                                    return meta.row + 1;
                                }
                            },
                            {
                                "data": "Tkh_Dokumen",
                                "render": function (data, type, row, meta) {
                                    // Parse the date string
                                    var date = new Date(data);

                                    // Extract day, month, and year
                                    var day = date.getDate();
                                    var month = date.getMonth() + 1; // Months are zero-based
                                    var year = date.getFullYear();

                                    // Ensure leading zeros if necessary
                                    day = (day < 10) ? '0' + day : day;
                                    month = (month < 10) ? '0' + month : month;

                                    // Construct the formatted date string
                                    var formattedDate = day + '/' + month + '/' + year;

                                    return formattedDate;
                                }
                            },
                            {
                                "data": "Nama_Fail", // Assuming this is the column containing file names
                                "render": function (data, type, row, meta) {

                                    // Eye icon with file name
                                    var baseUrl = '<%= ResolveClientUrl("~/UPLOAD/PINJAMAN/KEMASKINI PERMOHONAN/") %>'; // Base URL
                                    var fileName = encodeURIComponent(row.Nama_Fail); // Encode file name

                                    // Construct the file URL
                                    var fileUrl = baseUrl + fileName;

                                    // Display file name
                                    return '<a style = "color: blue; text-decoration: underline;" href="' + fileUrl + '" target="_blank" >' + data + '</a>';
                                }
                            },
                            { "data": "Butiran" },
                            {
                                "data": null,
                                "render": function (data, type, row, meta) {
                                    var deleteIcon = '<i class="fa fa-trash btnDelete" title="Delete"></i>';
                                    return deleteIcon;
                                }
                            }
                        ]
                    });

                    $("#modalInvoisData").modal('show')
                    $('[data-toggle="tab"][href="#InfoPemohon"]').tab('show');
                    //const firstTab = document.querySelector('[data-tab="InfoPemohon"]');
                    //firstTab.click();
                });

                $('#tblSimpanUpload').on('click', '.btnDelete', function () {
                    var rowData = tbl2.row($(this).closest('tr')).data(); // Get data of the clicked row
                    var Nama_Fail = rowData.Nama_Fail; // Assuming Nama_Fail is a property of the row data

                    // Get the full string containing No_Pinj and name
                    var fullString = $("#txtnama").val();

                    // Split the string by tab character (\t)
                    var parts = fullString.split('\t');

                    // Extract the No_Pinj part (the first part after splitting)
                    var No_Pinj = parts[0];

                    $.ajax({
                        url: "KemaskiniWS.asmx/DeleteDokumen",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify({ Nama_Fail: Nama_Fail, No_Pinj: No_Pinj }),
                        success: function (response) {
                            // Parse the response JSON string from 'd'
                            var responseData = JSON.parse(response.d);

                            // Extract the message from the responseData object
                            var message = responseData.Message;
                            console.log('message:', message);

                            // Update the content of the modal with the message
                            $('#lblMessageModal').html(message);

                            // Show the modal
                            $('#MessageModal').modal('show');
                        },
                        error: function (error) {
                            console.error("AJAX error:", error.responseText);
                        }
                    });
                });

            });
        </script>
    </contenttemplate>
</asp:Content>
