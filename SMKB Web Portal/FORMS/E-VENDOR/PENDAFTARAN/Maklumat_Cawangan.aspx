<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Maklumat_Cawangan.aspx.vb" Inherits="SMKB_Web_Portal.Maklumat_Cawangan" %>

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

    <div id="CawanganTab" class="tabcontent" style="display: block">

        <div class="modal-body">
            <div class="table-title">
                <h6 style="visibility: hidden;">Maklumat Cawangan (Jika Ada)</h6>
                <div class="btn btn-primary btnCawangan" onclick="ShowPopup('1')">
                    <i class="fa fa-plus"></i>Cawangan   
                </div>
            </div>
        </div>

        <div class="modal fade" id="cawangan" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleMklmtCawangan">Tambah Maklumat Cawangan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="panel-heading">
                                <br />
                                <h6 class="panel-title">Maklumat Bank Cawangan</h6>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <select class=" input-group__input form-control input_sm ui search dropdown ddlKodBank " name="ddlKodBank" id="ddlKodBank">
                                        </select>
                                        <label class="input-group__label">Kod bank</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class="input-group__input form-control input-sm " placeholder="" id="txtNoAkaun" name="txtNoAkaun" />
                                        <label class="input-group__label">Nombor Akaun</label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="UploadPenyataBank">Muka Hadapan Penyata Akaun  <a style="color: red">*</a> : </label>
                                <div class="form-inline">

                                    <input type="file" id="fileInputBankCaw" />
                                    <span id="uploadedFileNameLabelBank" style="display: inline;"></span>
                                    <span id="">&nbsp</span>
                                    <span id="progressContainerBank"></span>
                                    <input type="hidden" class="form-control" id="hidJenDokBank" style="width: 300px" readonly="readonly" />
                                    <input type="hidden" class="form-control" id="hidFileNameBank" style="width: 300px" readonly="readonly" />

                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="panel-heading">
                                    <br />
                                    <h6 class="panel-title">Alamat Cawangan</h6>
                                </div>
                                <div class="row">

                                    <div class="col-md-4">

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtNamaCwgn" name="txtNamaCwgn" />
                                            <label class="input-group__label">Nama Cawangan</label>
                                        </div>

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtAlmtPerniagaan1" name="txtAlmtPerniagaan1" />
                                            <label class="input-group__label">Alamat Baris Pertama</label>
                                        </div>

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtAlmtPerniagaan2" name="txtAlmtPerniagaan2" />
                                            <label class="input-group__label">Alamat Baris Kedua</label>
                                        </div>

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtWeb" name="txtWeb" />
                                            <label class="input-group__label">Laman Web URL </label>
                                        </div>

                                    </div>

                                    <div class="col-md-4">

                                        <div class="form-group input-group">
                                            <select class=" input-group__select ui search dropdown" placeholder="" name="ddlPoskod" id="ddlPoskod"></select>
                                            <label class="input-group__label">Poskod </label>
                                        </div>

                                        <div class="form-group input-group">
                                            <select class=" input-group__select ui search dropdown" placeholder="" name="ddlBandar" id="ddlBandar"></select>
                                            <label class="input-group__label">Bandar </label>
                                        </div>

                                        <div class="form-group input-group">
                                            <select class=" input-group__select ui search dropdown" placeholder="" name="ddlNegeri" id="ddlNegeri"></select>
                                            <label class="input-group__label">Negeri </label>
                                        </div>

                                        <div class="form-group input-group">
                                            <select class=" input-group__select ui search dropdown" placeholder="" name="ddlNegara" id="ddlNegara"></select>
                                            <label class="input-group__label">Negara </label>
                                        </div>

                                    </div>

                                    <div class="col-md-4">

                                        <%--<div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtEmailCaw" name="txtEmailCaw" />
                                            <label class="input-group__label">Email </label>
                                        </div>--%>

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtTel1" name="txtTel1" />
                                            <label class="input-group__label">No. Telefon 1 </label>
                                        </div>

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtTel2" name="txtTel2" />
                                            <label class="input-group__label">No. Telefon 2 </label>
                                        </div>

                                        <div class="form-group input-group">
                                            <input type="text" class=" input-group__input form-control input-sm " placeholder="" id="txtNoFax" name="txtNoFax" />
                                            <label class="input-group__label">No. Faksimili </label>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Maklumat Pegawai untuk dihunbungi -->
                    <div class="form-group row col-md-12">
                        <div class="form-group col-md-6">
                            <div class="panel-heading">
                                <br />
                                <h6 class="panel-title">Pegawai untuk Dihubungi Pertama</h6>
                                <label id="IdPeg1" style="visibility: hidden;"></label>
                            </div>
                            <div class="form-group row col-md-12">
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNamaPegawai1" id="txtNamaPegawai1">
                                        <label class="input-group__label">Nama</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtJwtPegawai1" id="txtJwtPegawai1">
                                        <label class="input-group__label">Jawatan</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtEmailPegawai1" id="txtEmailPegawai1">
                                        <label class="input-group__label">Emel</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPeg1" id="txtNoTelPeg1">
                                        <label class="input-group__label">Nombor Telefon Bimbit</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPejPeg1" id="txtNoTelPejPeg1">
                                        <label class="input-group__label">Nombor Telefon Pejabat</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <div class="panel-heading">
                                <br />
                                <h6 class="panel-title">Pegawai untuk Dihubungi Kedua</h6>
                                <label id="IdPeg2" style="visibility: hidden;"></label>
                            </div>
                            <div class="form-group row col-md-12">
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNamaPegawai2" id="txtNamaPegawai2">
                                        <label class="input-group__label">Nama</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtJwtPegawai2" id="txtJwtPegawai2">
                                        <label class="input-group__label">Jawatan</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtEmailPegawai2" id="txtEmailPegawai2">
                                        <label class="input-group__label">Emel</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPeg2" id="txtNoTelPeg2">
                                        <label class="input-group__label">Nombor Telefon Bimbit</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group input-group">
                                        <input type="text" class=" input-group__input form-control input-sm" placeholder="" name="txtNoTelPejPeg2" id="txtNoTelPejPeg2">
                                        <label class="input-group__label">Nombor Telefon Pejabat</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br />
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                        <button type="button" runat="server" id="lbtnSimpanCaw" class="btn btn-secondary lbtnSimpan">Simpan</button>
                    </div>
                </div>
            </div>
        </div>


        <hr />

        <!-- DataTable Maklumat Cawangan -->
        <div class="modal-body">
            <div class="col-md-12">
                <div class="transaction-table table-responsive">
                    <table id="tblDataCawangan" class="table table-striped" style="width: 100%">
                        <thead>
                            <tr>
                                <th scope="col">Bil</th>
                                <th scope="col">Nama Cawangan</th>
                                <th scope="col">Negeri</th>
                                <th scope="col">Negara</th>
                                <th scope="col">Nama Bank</th>
                                <th scope="col">No. Akaun</th>
                                <th scope="col">Pegawai Pertama</th>
                                <th scope="col">No. Telefon Pegawai Pertama</th>
                                <th scope="col">Lampiran</th>
                                <th scope="col">Tindakan</th>
                            </tr>
                        </thead>
                        <tbody id="tableID_Senarai_Cawangan">
                        </tbody>

                    </table>

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
                        <button type="button" class="btn btn-secondary btnYaDelete" style="display: none;">Ya</button>
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

        function ShowPopup(elm) {

            if (elm == "1") {
                //$(".modal-body input").val("");
                //$(".modal-body textarea").val("");
                // clear ddl
                /*$('#ddlPoskod').remove();*/
                //$('#ddlBandar').dropdown('clear');
                //$('#ddlNegeri').dropdown('clear');
                //$('#ddlNegara').dropdown('clear');
                $('#cawangan').modal('toggle');
                clearAllFields();
                $("#titleMklmtCawangan").html("Tambah Maklumat Cawangan");

            }
        }

        var curNumObject = 0;
        var tableDataPegawai = "tblDataPegawai";
        var tableDataCawangan = "tblDataCawangan";
        var tableID_Pegawai = "#tableID_Senarai_Pegawai";
        var tableID_Cawangan = "#tableID_Senarai_Cawangan";
        var tbl;

        // Data Cawangan
        $(document).ready(function () {
            /* show_loader();*/
            tbl = $("#tblDataCawangan").DataTable({
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
                    "url": "Pendaftaran_WS.asmx/LoadList_SenaraiCawangan",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter category bermula dari sini - 20 julai 2023
                        return JSON.stringify({
                            idSemSya: '<%=Session("ssusrID")%>',
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
                    { "data": "ButiranBank" },
                    { "data": "No_Akaun" },
                    { "data": "NamaPeg1" },
                    { "data": "TelPeg1" },
                    {
                        "data": "Nama_Dok",
                        "render": function (data, type, row) {

                            var fileName = data;
                            //IdDokSSM = row.ID_Dok;
                            Bil = row.Bil;

                            var link = `<a href="#" onclick="OpenFile('${fileName}', '${Bil}'); return false;">${fileName}</a>`;
                            return link;
                        }
                    },
                    {
                        className: "btnEdit",
                        "data": "ID_Cwgn",
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;
                            }

                            var link = `<button id="btnEdit" runat="server" class="btn btnEdit" type="button" style="color: blue" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-edit"></i>
                                        </button>
                                        <button id="btnDelete" runat="server" class="btn btnDelete" type="button" style="color: red" data-dismiss="modal" data-id="${data}">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;

                            return link;
                        }
                    }

                ]
            });
        });

        function OpenFile(fileName, Bil) {

            var path = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/BANK/") %>' + '<%=Session("ssusrID")%>' + '/' + Bil + '/' + fileName;
            window.open(path, '_blank');
        }

        async function LoadDataCawangan(IdCaw) {
            var NoSya = '<%=Session("ssusrID")%>';

            if (NoSya !== "") {
                var RecordCawangan = JSON.parse(await ajaxLoadDataCawangan(NoSya, IdCaw));
                var RecordCawangan0 = RecordCawangan[0];
                var RecordCawangan1 = RecordCawangan[1];
                //console.log("RecordCawangan: ",RecordCawangan);

                if (RecordCawangan0.length === 0) {
                    displayMaklumanModal("Tiada Data");
                    return;
                }

                if (RecordCawangan1.length === 0) {
                    displayMaklumanModal('Tiada Data Pegawai Kedua');
                    return;
                }

                clearAllFields();
                setValue_DataCawangan(RecordCawangan0, RecordCawangan1);

               // return false;
            }
        }

        async function ajaxLoadDataCawangan(NoSya, IdCaw) {
            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'Pendaftaran_WS.asmx/LoadDataCawangan',
                    method: 'POST',
                    data: JSON.stringify({
                        NoSya: NoSya,
                        idCaw: IdCaw
                    }),
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
        }

        async function setValue_DataCawangan(DataCawangan0, DataCawangan1) {

            console.log("Data SetValue: ", DataCawangan0);

            var selectObj_Bandar = $('#ddlBandar');
            var selectObj_Negeri = $('#ddlNegeri');
            var selectObj_Negara = $('#ddlNegara');
            var selectObj_Poskod = $('#ddlPoskod');
            var selectObj_BankCaw = $('#ddlKodBank');

            $('#idCawangan').html(DataCawangan0.IdCaw);
            $('#idPegawai1').html(DataCawangan0.IdPeg);
            $('#idPegawai2').html(DataCawangan1.IdPeg);

            $('#ddlKodBank').dropdown('set selected', DataCawangan0.KodBank);
            selectObj_BankCaw.append("<option value ='" + DataCawangan0.KodBank + "'>" + DataCawangan0.ButiranBank + "</option>");
            $('#txtNoAkaun').val(DataCawangan0.NoAkaun);
            //$('#fileInputBankCaw').val(DataCawangan0.NamaDok);

            // Assuming fileUrl contains the URL of the file
            var fileUrl = DataCawangan0.NamaDok;

            // Create an anchor element
            var link = document.createElement("a");
            link.href = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/E-VENDOR/BANK/") %>' + '<%=Session("ssusrID")%>' + '/' + DataCawangan0.Bil + '/' + DataCawangan0.NamaDok;
            link.target = "_blank"; // Open the link in a new tab
            link.textContent = DataCawangan0.NamaDok; // Text to display for the link

            // Append the anchor element inside the input field
            var fileInputBankCaw = document.getElementById("fileInputBankCaw");
            fileInputBankCaw.insertAdjacentElement('afterend', link);
            var fileInputValue = fileInputBankCaw.value;
            console.log("Data InputFileBank", fileInputValue);
            //fileInputBankCaw.value = DataCawangan0.NamaDok;


            $('#txtNamaCwgn').val(DataCawangan0.NamaCaw);
            $('#txtAlmtPerniagaan1').val(DataCawangan0.Almt1);
            $('#txtAlmtPerniagaan2').val(DataCawangan0.Almt2);

            $('#ddlPoskod').dropdown('set selected', DataCawangan0.Poskod);
            selectObj_Poskod.append("<option value ='" + DataCawangan0.Poskod + "'>" + DataCawangan0.Poskod + "</option>");

            $('#ddlBandar').dropdown('set selected', DataCawangan0.KodBandar);
            selectObj_Bandar.append("<option value ='" + DataCawangan0.KodBandar + "'>" + DataCawangan0.ButiranBandar + "</option>");

            $('#ddlNegeri').dropdown('set selected', DataCawangan0.Negeri);
            selectObj_Negeri.append("<option value ='" + DataCawangan0.Negeri + "'>" + DataCawangan0.ButiranNegeri + "</option>");

            $('#ddlNegara').dropdown('set selected', DataCawangan0.Negara);
            selectObj_Negara.append("<option value ='" + DataCawangan0.Negara + "'>" + DataCawangan0.ButiranNegara + "</option>");

            $('#txtWeb').val(DataCawangan0.Web);
            /*$('#txtEmailCaw').val(DataCawangan.NamaCaw);*/
            $('#txtTel1').val(DataCawangan0.Tel1);
            $('#txtTel2').val(DataCawangan0.Tel2);
            $('#txtNoFax').val(DataCawangan0.Faks);
            $('#txtNamaPegawai1').val(DataCawangan0.NamaPeg);
            $('#txtJwtPegawai1').val(DataCawangan0.JwtPeg);
            $('#txtNoTelPeg1').val(DataCawangan0.TelBimbit);
            $('#txtEmailPegawai1').val(DataCawangan0.EmelPeg);
            $('#txtNoTelPejPeg1').val(DataCawangan0.TelPejPeg);
            $('#txtNamaPegawai2').val(DataCawangan1.NamaPeg);
            $('#txtJwtPegawai2').val(DataCawangan1.JwtPeg);
            $('#txtNoTelPeg2').val(DataCawangan1.TelBimbit);
            $('#txtEmailPegawai2').val(DataCawangan1.EmelPeg);
            $('#txtNoTelPejPeg2').val(DataCawangan1.TelPejPeg);
        }

        $('#tblDataCawangan').on('click', '.btnEdit', async function (event) {

            $("#titleMklmtCawangan").html("Kemaskini Maklumat Cawangan");
            $('#cawangan').modal("toggle");

            event.stopPropagation();
            var idCaw = $(this).data("id");

            if (idCaw !== "") {
                LoadDataCawangan(idCaw)
            } else {
                displayMaklumanModal('ID Cawangan Tidak Sah')
            }
        });

        $('#tblDataCawangan').on('click', '.btnDelete', async function (event) {

            event.stopPropagation();
            var curTR = $(this).closest("tr");
            var bool = true;
            var idCaw = $(this).data("id");
            var NoSya = '<%=Session("ssusrID")%>';
            $('.btnYaDelete').show();

            $('#confirmationModal').modal('toggle');
            $('#confirmContent').text('Adakah Anda Pasti Mahu Memadam Data Ini?');
            $('.btnYa').hide();

            $('.btnYaDelete').click(async function () {
                $('#confirmationModal').modal('toggle');

                if (idCaw !== "") {
                    bool = await DelCawangan(idCaw, NoSya);
                }

                if (bool === true) {
                    curTR.remove();
                }

                tbl.ajax.reload();
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Maklumat Berjaya Dipadam");

                return false;
            });
        });

        async function DelCawangan(idCaw, NoSya) {
            var bool = false;
            var result = JSON.parse(await AjaxDeleteCawangan(idCaw, NoSya));

            if (result.Code === "00") {
                bool = true;
            }
            return bool;
        }

        async function AjaxDeleteCawangan(idCaw, NoSya) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Pendaftaran_WS.asmx/DeleteRecordCawangan',
                    method: 'POST',
                    data: JSON.stringify({
                        idCaw: idCaw,
                        NoSya: NoSya
                    }),
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

        $('#txtNamaCwgn').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });
        // validate alamat
        $('#txtAlmtPerniagaan1').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#txtAlmtPerniagaan2').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        // validate txtbox nama peg1, peg2
        $('#txtNamaPegawai1').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#txtNamaPegawai2').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#txtJwtPeg1').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#txtJwtPeg2').on('input', function () {
            var inputValue = $(this).val();
            $(this).val(inputValue.toUpperCase())
        });

        $('#txtNoFax').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });
        // validate phone number
        $('#txtTel1').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#txtTel2').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#txtNoTelPeg1').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#txtNoTelPejPeg1').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#txtNoTelPeg2').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $('#txtNoTelPejPeg2').on('input', function () {
            var inputValue = $(this).val();
            var regex = /[^\d{3,12}$]/gi;
            this.value = this.value.replace(regex, "");
        });

        $(document).ready(function () {
            setupDropdown('#ddlKodBank', 'Pendaftaran_WS.asmx/GetCodeBank', false);
            setupDropdown('#ddlBandar', 'Pendaftaran_WS.asmx/GetBandar', true);
            setupDropdown('#ddlNegeri', 'Pendaftaran_WS.asmx/GetNegeri', false);
            setupDropdown('#ddlNegara', 'Pendaftaran_WS.asmx/GetNegara', false);
            setupDropdown('#ddlPoskod', 'Pendaftaran_WS.asmx/GetPoskod', false);
        });

        function setupDropdown(selector, url, fullTextSearch) {
            $(selector).dropdown({
                selectOnKeyDown: true,
                fullTextSearch: fullTextSearch,
                apiSettings: {
                    url: url + '?q={query}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: true,
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query });
                        return settings;
                    },
                    onSuccess: function (response) {
                        var obj = $(this);
                        var objItem = $(this).find('.menu');
                        objItem.html('');

                        if (response.d.length === 0) {
                            obj.dropdown("clear");
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);
                        $.each(listOptions, function (index, option) {
                            objItem.append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                        });

                        obj.dropdown('refresh').dropdown('show');
                    }
                }
            });
        }

        var emailCaw = "";
        var validEmailCaw = "";
        var emptEmailCaw = ""
        var emailPeg1 = "";
        var validEmailPeg1 = "";
        var emptEmailPeg1 = ""
        var emailPeg2 = "";
        var validEmailPeg2 = "";
        var emptEmailPeg2 = ""
        var regexEmail = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/;

        $('.lbtnSimpan').click(async function () {
            if ($('#ddlKodBank').val() == "" || $('#txtNoAkaun').val() == "" || $('#fileInputBankCaw').val() == "" || $('#txtNamaCwgn').val() == "" || $('#txtAlmtPerniagaan1').val() == "" || $('#txtAlmtPerniagaan2').val() == "" || $('#ddlBandar').val() == "" || $('#ddlPoskod').val() == "" ||
                $('#ddlNegeri').val() == "" || $('#ddlNegara').val() == "" || $('#txtTel1').val() == "" || $('#txtNamaPegawai1').val() == "" || $('#txtJwtPeg1').val() == "" || $('#txtNoTelPegi').val() == "") {

                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Sila isi semua ruangan yang bertanda *");
            } else {

                emailCaw = $('#txtEmailCaw').val();
                emailPeg1 = $('#txtEmailPegawai1').val();
                emailPeg2 = $('#txtEmailPegawai2').val();

                if (emailCaw !== undefined && emailCaw.trim() !== "") {
                    const isValidEmailCaw = regexEmail.test(emailCaw);
                    if (isValidEmailCaw) {
                        validEmailCaw = emailCaw;
                    } else {
                        $('#maklumanModal').modal('toggle');
                        $('#detailMakluman').html("Sila Masukkan Emel yang Sesuai");
                        return;
                    }
                } else {
                    emptEmailCaw = emailCaw;
                }

                if (emailPeg1 !== '') {
                    const isValidEmailPeg1 = regexEmail.test(emailPeg1);
                    if (isValidEmailPeg1) {
                        validEmailPeg1 = emailPeg1;
                        console.log(emailPeg1);
                    } else {
                        $('#maklumanModal').modal('toggle');
                        $('#detailMakluman').html("Sila Masukkan Emel yang Sesuai pada pegawai pertama");
                    }
                } else {
                    emptEmailPeg1 = emailPeg1;
                }

                if (emailPeg2 !== '') {
                    const isValidEmailPeg2 = regexEmail.test(emailPeg2);
                    if (isValidEmailPeg2) {
                        validEmailPeg2 = emailPeg2;
                        console.log(emailPeg1);
                        $('#confirmationModal').modal('toggle');
                        $('.btnYaDelete').hide();
                    } else {
                        $('#maklumanModal').modal('toggle');
                        $('#detailMakluman').html("Sila Masukkan Emel yang Sesuai pada pegawai kedua");
                    }
                } else {
                    emptEmailPeg2 = emailPeg2;
                    $('#confirmationModal').modal('toggle');
                    $('.btnYaDelete').hide();
                }
            }
        });

        function uploadFileBankCaw() {

            var fileInputId = "fileInputBankCaw";
            var resolvedUrl = "~/UPLOAD/DOCUMENT/E-VENDOR/BANK/";
            var hidJenDokId = "hidJenDokBank";
            var hidFileNameId = "hidFileNameBank";
            var progressContainerId = "progressContainerBank";
            var uploadedFileNameLabelId = "uploadedFileNameLabelBank";
            var wsMethod = "Pendaftaran_WS.asmx/UploadFileBank";
            var KodDaftar = "PBC";
            var result = uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod, KodDaftar);

            return result;
        }

        function uploadFile(fileInputId, resolvedUrl, hidJenDokId, hidFileNameId, progressContainerId, uploadedFileNameLabelId, wsMethod, KodDaftar) {
            var fileInput = document.getElementById(fileInputId);
            var file = fileInput.files[0];
            var result = {
                fileExtension: "",
                fileName: "",
                message: "",
                url: ""
            };

            if (file) {
                var fileSize = file.size; // File size in bytes
                var maxSize = 5 * 1024 * 1024; // Maximum size in bytes (3MB)

                if (fileSize <= maxSize) {
                    // File size is within the allowed limit
                    var fileName = file.name;
                    var fileExtension = fileName.split('.').pop().toLowerCase();

                    // Check if the file extension is PDF or Excel
                    if (['pdf', 'xlsx', 'xls'].includes(fileExtension)) {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                            var fileData = e.target.result; // Base64 string representation of the file data

                            var requestData = {
                                fileData: fileData,
                                fileName: fileName,
                                resolvedUrl: resolveAppUrl(resolvedUrl),
                            };

                            var frmData = new FormData();
                            frmData.append("fileSurat", file);
                            frmData.append("fileName", fileName);
                            frmData.append("fileSize", fileSize);
                            frmData.append("kodDaftar", KodDaftar);

                            console.log("frmData: ", frmData);

                            $(`#${hidJenDokId}`).val(fileExtension);
                            $(`#${hidFileNameId}`).val(fileName);

                            $.ajax({
                                url: wsMethod,
                                type: 'POST',
                                data: frmData,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (response) {
                                    // Show the uploaded file name on the screen
                                    //var fileLink = document.createElement("a");
                                    //fileLink.href = requestData.resolvedUrl + fileName;
                                    //fileLink.textContent = fileName;

                                    //var uploadedFileNameLabel = document.getElementById(uploadedFileNameLabelId);
                                    //uploadedFileNameLabel.appendChild(fileLink);

                                    /* fileLinkToLocal(requestData.resolvedUrl + fileName);*/

                                    /*$(`#${uploadedFileNameLabelId}`).show();*/
                                    // Clear the file input
                                    /*$(`#${fileInputId}`).val("");*/
                                    /* $(`#${progressContainerId}`).text("File uploaded successfully.");*/
                                    /*displayFileLink(fileName);*/
                                },
                                error: function () {
                                    $(`#${progressContainerId}`).text("Error uploading file.");
                                }
                            });
                        };

                        reader.readAsArrayBuffer(file);

                        result.fileName = fileName;
                        result.fileExtension = fileExtension;
                        result.message = "OK";
                        result.url = resolvedUrl;

                    } else {
                        // Invalid file type
                        /*displayMaklumanModal("Only PDF and Excel files are allowed.");*/
                        result.message = "Only PDF and Excel files are allowed.";

                    }
                } else {
                    // File size exceeds the allowed limit
                    /*displayMaklumanModal("File size exceeds the maximum limit of 3MB");*/
                    result.message = "File size exceeds the maximum limit of 5MB";

                }
            } else {
                // No file selected
                /*displayMaklumanModal("Please select a file to upload");*/
                result.message = "Please select a file to upload"

            }

            return result;
        }

        /* confirmation button in confirmation modal*/
        $('.btnYa').click(async function () {
            //close modal confirmation
            $('#confirmationModal').modal('toggle');

            idCawangan = $('#idCawangan').html();
            //console.log({ idCawangan });

            var form = $(this).closest('form');

            var fileName = await getFileName(form.find('#fileInputBankCaw'));
            var fileEextesion = await getFileExtension(form.find('#fileInputBankCaw'));
            var filePath = '~/UPLOAD/DOCUMENT/E-VENDOR/BANK/'

            var AlmtCaw = [
                {
                    Almt1: $('#txtAlmtPerniagaan1').val(),
                    Almt2: $('#txtAlmtPerniagaan2').val(),
                    Bandar: $('#ddlBandar').val(),
                    Poskod: $('#ddlPoskod').val(),
                    Negeri: $('#ddlNegeri').val(),
                    Negara: $('#ddlNegara').val(),
                    TelBimbitSya: $('#txtTel1').val(),
                    TelPejSya: $('#txtTel2').val(),
                    NoFaxSya: $('#txtNoFax').val(),
                    Web: $('#txtWeb').val(),
                    EmailSya: validEmailCaw,
                }
            ];

            var ListPegawai = [
                {
                    IdPeg: 'NULL',
                    KatPegawai: 'P1',
                    NamaPegawai: $('#txtNamaPegawai1').val(),
                    JwtPegawai: $('#txtJwtPegawai1').val(),
                    EmailPegawai: validEmailPeg1,
                    NoTelPeg: $('#txtNoTelPeg1').val(),
                    NoTelPejPeg: $('#txtNoTelPejPeg1').val(),
                },
                {
                    IdPeg: 'NULL',
                    KatPegawai: 'P2',
                    NamaPegawai: $('#txtNamaPegawai2').val(),
                    JwtPegawai: $('#txtJwtPegawai2').val(),
                    EmailPegawai: validEmailPeg2,
                    NoTelPeg: $('#txtNoTelPeg2').val(),
                    NoTelPejPeg: $('#txtNoTelPejPeg2').val(),
                }
            ];

            var ListFile = [
                {
                    /*IdDok: null,*/
                    IdSya: '<%=Session("ssusrID")%>',
                    NoRujukan: '',
                    JenDok: "PBC",
                    FileName: fileName,
                    Bil: '',
                    FilePath: filePath,
                    JenFile: fileEextesion,
                }
            ];

            var newCawangan = {
                cawangan: {
                    IdSya: '<%=Session("ssusrID")%>',
                    IdCaw: $('#idCawangan').html(),
                    NamaCaw: $('#txtNamaCwgn').val(),
                    KodBank: $('#ddlKodBank').val(),
                    NoAkaun: $('#txtNoAkaun').val(),
                    AlmtCaw: AlmtCaw,
                    ListPegawai: ListPegawai,
                    ListFile: ListFile
                }
            }

            console.log("data Cawangan: ", newCawangan);
            var result = JSON.parse(await ajaxSaveCawangan(newCawangan));
            console.log("result value", result);

            if (result.Status !== "Failed") {

                try {
                    var messageFile;

                    messageFile = uploadFileBankCaw();
                    console.log("message File After Upload in the folder: ", messageFile);

                    if (messageFile.message != "OK") {
                        displayMaklumanModal(messageFile);
                        return;
                    } else {
                        tbl.ajax.reload();
                        clearAllFields();
                        $('#cawangan').modal('toggle');
                        $('#maklumanModal').modal('toggle');
                        $('#detailMakluman').html("Maklumat berjaya Dihantar");
                        $('#cawangan').modal('toggle');
                    }

                } catch (error) {
                    console.error("Error during file upload:", error);
                    displayMaklumanModal("Gagal Memuatnaik Fail" + activeTab.substring(1).toUpperCase());
                    return;
                }

            } else {

                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
            }
        });

        //Ajax submit maklumat syarikat
        async function ajaxSaveCawangan(newCawangan) {

            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'Pendaftaran_WS.asmx/SaveCawangan',
                    method: 'POST',
                    data: JSON.stringify(newCawangan),
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

        async function getFileName(fileInput) {
            var file = fileInput[0].files;

            if (file.length > 0) {
                var fileName = file[0].name;

                return fileName;
            } else {
                return null;
            }

        }

        async function getFileExtension(fileInput) {
            var file = fileInput[0].files;
            if (file.length > 0) {
                var fileName = file[0].name;
                var fileExtension = fileName.split('.').pop().toLowerCase();

                return fileExtension;
            } else {
                return null;
            }
        }

        async function clearAllFields() {
            //Clear All Fields in the form
            $('#idCawangan').html("");
            $('#idPegawai1').html("");
            $('#idPegawai2').html("");

            //$('#ddlKodBank').dropdown('clear');
            $('#ddlKodBank').val("");
            $('#txtNoAkaun').val("");
            //$('#fileInputBankCaw').val("");

            var previousLink = document.querySelector('#fileInputBankCaw + a');
            console.log("Selector a : ", previousLink);
            if (previousLink) {
                previousLink.remove();
            }

            $('#txtNamaCwgn').val("");
            $('#txtAlmtPerniagaan1').val("");
            $('#txtAlmtPerniagaan2').val("");
            //$('#ddlPoskod').dropdown('clear');
            //$('#ddlBandar').dropdown('clear');
            //$('#ddlNegeri').dropdown('clear');
            //$('#ddlNegara').dropdown('clear');
            $('#ddlPoskod').val("");
            $('#ddlBandar').val("");
            $('#ddlNegeri').val("");
            $('#ddlNegara').val("");
            $('#txtWeb').val("");
            $('#txtEmailCaw').val("");
            $('#txtTel1').val("");
            $('#txtTel2').val("");
            $('#txtNoFax').val("");
            $('#txtNamaPegawai1').val("");
            $('#txtJwtPegawai1').val("");
            $('#txtNoTelPeg1').val("");
            $('#txtEmailPegawai1').val("");
            $('#txtNoTelPejPeg1').val("");
            $('#txtNamaPegawai2').val("");
            $('#txtJwtPegawai2').val("");
            $('#txtNoTelPeg2').val("");
            $('#txtEmailPegawai2').val("");
            $('#txtNoTelPejPeg2').val("");
        }

        function displayMaklumanModal(message) {
            $('#maklumanModal').modal('toggle');
            $('#detailMakluman').html(message);
        }

        function resolveAppUrl(relativeUrl) {
            var resolvedUrl = "";
            $.ajax({
                type: "POST",
                url: "Pendaftaran_WS.asmx/ResolveAppUrl",
                data: JSON.stringify({ relativeUrl: relativeUrl }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false, // Ensure synchronous execution for simplicity
                success: function (response) {
                    resolvedUrl = response.d;
                }
            });
            return resolvedUrl;
        }


    </script>
</asp:Content>
