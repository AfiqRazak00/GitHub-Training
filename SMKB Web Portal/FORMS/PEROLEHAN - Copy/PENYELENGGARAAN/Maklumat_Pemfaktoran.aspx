<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Maklumat_Pemfaktoran.aspx.vb" Inherits="SMKB_Web_Portal.Maklumat_Pemfaktoran" %>


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

        #tblSenaraiPemfaktoran td:hover {
            cursor: pointer;
        }
    </style>


    <div class="tabcontent" style="display: block">

        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Maklumat Pemfaktoran</h5>
                    </div>

                    <div class="card" style="margin: 20px">
                        <div class="card-body">

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                            <input class="input-group__input" name="No Id" id="txtNoId" type="text" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                            <label class="input-group__label" for="No Idn">No Id</label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-6">
                                            <input class="input-group__input" placeholder="&nbsp;" name="Bayar Atas Nama" id="txtBayar" />
                                            <label class="input-group__label" for="Bayar Atas Nama">Bayar Atas Nama</label>
                                        </div>

                                        <div class="form-group col-md-6">
                                            <input class="input-group__input" placeholder="&nbsp;" name="Nombor Akaun" id="txtNoAkaun" type="text" />
                                            <label class="input-group__label" for="Nombor Akaun">Nombor Akaun</label>
                                        </div>

                                        </div>

                                    </div>
                                </div>
                            


                            
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-6">
                                            <input class="input-group__input" placeholder="&nbsp;" name="Nama Bank" id="txtNamaBank" type="text" />
                                            <label class="input-group__label" for="Nama Bank">Nama Bank</label>
                                        </div>

                                        <div class="form-group col-md-6">
                                            <input class="input-group__input" placeholder="&nbsp;" name="Email" id="txtEmail" type="text" />
                                            <label class="input-group__label" for="Email">Email</label>
                                        </div>

                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-12">
                                            <input class="input-group__input" placeholder="&nbsp;" name="Alamat 1" id="txtAlamat1" type="text" />
                                            <label class="input-group__label" for="Alamat 1">Alamat 1</label>
                                        </div>

                                    </div>
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <input class="input-group__input" placeholder="&nbsp;" name="Alamat 2" id="txtAlamat2" type="text" />
                                            <label class="input-group__label" for="Alamat 2">Alamat 2</label>
                                        </div>

                                    </div>
                                </div>
                            </div>



                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-4">
                                            <select class=" input-group__select ui search dropdown" placeholder="" name="ddlPoskod" id="ddlPoskod">
                                            </select>
                                            <label class="input-group__label">Poskod</label>
                                        </div>


                                         <div class="form-group col-md-4">
                                            <select class=" input-group__select ui search dropdown" placeholder="" name="ddlBandar" id="ddlBandar">
                                            </select>
                                            <label class="input-group__label">Bandar</label>
                                        </div>
                                     
                                        <div class="form-group col-md-4">
                                            <select class=" input-group__select ui search dropdown" placeholder="" name="ddlNegeri" id="ddlNegeri">
                                            </select>
                                            <label class="input-group__label">Negeri</label>
                                        </div>

                                   <%--<div class="form-group col-md-3">
                                            <input class="input-group__input" placeholder="&nbsp;" name="Negara" id="txtNegara" type="text" />
                                            <label class="input-group__label" for="Negara">Negara</label>
                                        </div>--%>



                                    </div>
                                </div>
                            </div>




                            <div class="form-row" style="margin-top:20px">
                                <div class="form-group col-md-12" align="center">

                                     <button type="button" id="btnReset" class="btn btn-setsemula btnReset" data-toggle="tooltip" data-placement="bottom" title="Rekod Baru" style="width:160px">
                                        Rekod Baru
                                    </button>

                                    <button type="button" id="btnDaftar" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Simpan" style="width:160px">
                                        Simpan
                                    </button>

                                </div>
                            </div>
                            </div>
                        </div>
                    </div>




                    <div class="card" style="margin: 30px 0px 0px 0px">
                      <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Senarai Bayar Atas Nama </h6>
                        <div class="card-body">
               
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblSenaraiPemfaktoran" class="table table-striped" style="width: 99%">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Bil</th>
                                                    <th scope="col">No ID </th>
                                                    <th scope="col">Bayar Atas Nama</th>
                                                    <th scope="col">No Akaun</th>
                                                    <th scope="col">Nama Bank</th>
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
        </div>
   


        <!-- Modal -->
    <div class="modal fade" id="transaksi" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header modal-header--sticky">
                    <h5 class="modal-title">Senarai Bayar Atas Nama</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>


                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">
                                <div class="form-group col-md-4">
                                    <input class="input-group__input" name="No Id" id="txtNoIdT" type="text" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="No Idn">No Id</label>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">

                                <div class="form-group col-md-6">
                                    <input class="input-group__input" placeholder="&nbsp;" name="Bayar Atas Nama" id="txtBayarT" />
                                    <label class="input-group__label" for="Bayar Atas Nama">Bayar Atas Nama</label>
                                </div>

                                <div class="form-group col-md-6">
                                    <input class="input-group__input" placeholder="&nbsp;" name="Nombor Akaun" id="txtNoAkaunT" type="text" />
                                    <label class="input-group__label" for="Nombor Akaun">Nombor Akaun</label>
                                </div>

                            </div>
                        </div>
                    </div>

                     <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">

                                <div class="form-group col-md-6">
                                    <input class="input-group__input" placeholder="&nbsp;" name="Nama Bank" id="txtNamaBankT" type="text" />
                                    <label class="input-group__label" for="Nama Bank">Nama Bank</label>
                                </div>

                                <div class="form-group col-md-6">
                                    <input class="input-group__input" placeholder="&nbsp;" name="Email" id="txtEmailT" type="text" />
                                    <label class="input-group__label" for="Email">Email</label>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">

                                <div class="form-group col-md-12">
                                    <input class="input-group__input" placeholder="&nbsp;" name="Alamat 1" id="txtAlamat1T" type="text" />
                                    <label class="input-group__label" for="Alamat 1">Alamat 1</label>
                                </div>

                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">
                                <div class="form-group col-md-12">
                                    <input class="input-group__input" placeholder="&nbsp;" name="Alamat 2" id="txtAlamat2T" type="text" />
                                    <label class="input-group__label" for="Alamat 2">Alamat 2</label>
                                </div>

                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">

                                <div class="form-group col-md-4">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlPoskod" id="ddlPoskodT">
                                    </select>
                                    <label class="input-group__label">Poskod</label>
                                </div>


                                <div class="form-group col-md-4">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlBandar" id="ddlBandarT">
                                    </select>
                                    <label class="input-group__label">Bandar</label>
                                </div>

                                <div class="form-group col-md-4">
                                    <select class=" input-group__select ui search dropdown" placeholder="" name="ddlNegeri" id="ddlNegeriT">
                                    </select>
                                    <label class="input-group__label">Negeri</label>
                                </div>

                                <%--<div class="form-group col-md-3">
                                            <input class="input-group__input" placeholder="&nbsp;" name="Negara" id="txtNegaraT" type="text" />
                                            <label class="input-group__label" for="Negara">Negara</label>
                                        </div>--%>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="modal-footer modal-footer--sticky" style="padding: 0px!important">
                    <button type="button" class="btn btn-setsemula" data-toggle="tooltip" data-placement="bottom">Tutup</button>
                    <button type="button" class="btn btn-secondary btnUpdate" data-toggle="tooltip" data-placement="bottom">Simpan</button>
                </div>

            </div>
        </div>
    </div>


    <%--  modal lulus permohonan--%>
        <div class="modal fade" id="saveConfirmationModal10" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabel10">Daftar Bidaan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessage10"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="simpanPemfaktoran">Ya</button>
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
                        <div id="resultModalMessage10">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>

        <%--  modal lulus permohonan--%>
        <div class="modal fade" id="saveConfirmationModal11" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabel11">Daftar Bidaan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessage11"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="simpanKemaskini">Ya</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal Result Lulus -->
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
                        <div id="resultModalMessage11">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>


        <script type="text/javascript">

            $(document).ready(function () {
                setupDropdown('#ddlPoskod', 'PenyelenggaraanWS.asmx/GetPoskod', false);
                setupDropdown('#ddlBandar', 'PenyelenggaraanWS.asmx/GetBandar', false);
                setupDropdown('#ddlNegeri', 'PenyelenggaraanWS.asmx/GetNegeri', false);
                setupDropdown('#ddlPoskodT', 'PenyelenggaraanWS.asmx/GetPoskod', false);
                setupDropdown('#ddlBandarT', 'PenyelenggaraanWS.asmx/GetBandar', false);
                setupDropdown('#ddlNegeriT', 'PenyelenggaraanWS.asmx/GetNegeri', false);
            });


            $('#btnReset').click(function () {
                $('#txtNoId').val("");
                $('#txtBayar').val("");
                $('#txtNoAkaun').val("");
                $('#txtNamaBank').val("");
                $('#txtEmail').val("");
                $('#txtAlamat1').val("");
                $('#txtAlamat2').val("");

                //dropdown clear
                $('#ddlPoskod').dropdown('clear');
                $('#ddlPoskod').dropdown('refresh');
                $('#ddlBandar').dropdown('clear');
                $('#ddlBandar').dropdown('refresh');
                $('#ddlNegeri').dropdown('clear');
                $('#ddlNegeri').dropdown('refresh');
            });


            function setupDropdown(selector, url, fullTextSearch) {
                $(selector).dropdown({
                    selectOnKeyDown: true,
                    placeholder: '-- Sila Pilih --',
                    fullTextSearch: fullTextSearch,
                    apiSettings: {
                        url: url + '?q={query}',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
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

                            //obj.dropdown('refresh').dropdown('show');
                        }
                    }
                });
            }



            var tbl = null;
            
            $(document).ready(function () {
                tbl = $("#tblSenaraiPemfaktoran").DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Load_SenaraiBidaan") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify();
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

                        // Add click event
                        $(row).on("click", function () {

                            id_no = data.id_no

                            $('#txtNoIdT').val(data.id_no);
                            $('#txtBayarT').val(data.bayar_atas_nama);
                            $('#txtNoAkaunT').val(data.noakaun);
                            $('#txtNamaBankT').val(data.Kod_Bank);
                            $('#txtEmailT').val(data.Email);
                            $('#txtAlamat1T').val(data.Alamat1);
                            $('#txtAlamat2T').val(data.Alamat2);

                            $('#ddlPoskodT')
                                .dropdown('setup menu', {
                                    values: [
                                        {
                                            value: data.Poskod,
                                            text: data.Poskod,
                                            name: data.Poskod
                                        }
                                    ]
                                })
                                .dropdown('set selected', data.Poskod)

                            $('#ddlBandarT').dropdown("queryRemote", "", function () {
                                setTimeout(function () {
                                    $('#ddlBandarT').dropdown("set selected", data.Bandar)
                                }, 10)
                            })

                            //$('#ddlBandarT')
                            //    .dropdown('setup menu', {
                            //        values: [
                            //            {
                            //                value: data.Bandar,
                            //                text: data.NamaBandar,
                            //                name: data.NamaBandar
                            //            }
                            //        ]
                            //    })
                            //    .dropdown('set selected', data.Bandar)


                            $('#ddlNegeriT')
                                .dropdown('setup menu', {
                                    values: [
                                        {
                                            value: data.Negeri,
                                            text: data.NamaNegeri,
                                            name: data.NamaNegeri
                                        }
                                    ]
                                })
                                .dropdown('set selected', data.Negeri)


                            $('#transaksi').modal('show');
                        });
                    },

                    "columns": [
                        { "data": "Bil" },   
                        { "data": "id_no" }, 
                        { "data": "bayar_atas_nama" },
                        { "data": "noakaun" },
                        { "data": "Kod_Bank" },

                    ],
                });
            });


            //buttton daftar bidaan
            $('.btnSimpan').off('click').on('click', async function () {

                var msg = "Anda pasti untuk mendaftar maklumat ini?";
                $('#confirmationMessage10').text(msg);
                $('#transaksi').modal('hide');
                $('#saveConfirmationModal10').modal('show');

                $('#simpanPemfaktoran').off('click').on('click', async function () {
                    $('#saveConfirmationModal10').modal('hide');

                    var newPemfaktoran= {
                        SaveBankPemfaktoran : {
                            txtNoId: $('#txtNoId').val(),
                            txtBayar: $('#txtBayar').val(),
                            txtNoAkaun: $('#txtNoAkaun').val(),
                            txtNamaBank: $('#txtNamaBank').val(),
                            txtEmail: $('#txtEmail').val(),
                            txtAlamat1: $('#txtAlamat1').val(),
                            txtAlamat2: $('#txtAlamat2').val(),
                            ddlPoskod: $('#ddlPoskod').val(),
                            ddlBandar: $('#ddlBandar').val(),
                            ddlNegeri: $('#ddlNegeri').val(),

                        }
                    }

                    try {
                        var result = JSON.parse(await ajaxSimpanDaftarPemfaktoran(newPemfaktoran));
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

            async function ajaxSimpanDaftarPemfaktoran(SaveBankPemfaktoran) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                       "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/SimpanPemfaktoranBank") %>',
                        method: 'POST',
                        data: JSON.stringify(SaveBankPemfaktoran),
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
                $('#resultModalMessage10').html(message);
                if (type === "success") {
                    $('#resultModal10').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal10').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal10').modal('show');
            }


            //buttton daftar bidaan
            $('.btnUpdate').off('click').on('click', async function () {

                var msg = "Anda pasti untuk mengemaskini maklumat ini?";
                $('#confirmationMessage11').text(msg);
                $('#transaksi').modal('hide');
                $('#saveConfirmationModal11').modal('show');

                $('#simpanKemaskini').off('click').on('click', async function () {
                    $('#saveConfirmationModal11').modal('hide');

                    var newPemfaktoran = {
                        UpdateBankPemfaktoran: {
                            txtNoId: $('#txtNoIdT').val(),
                            txtBayar: $('#txtBayarT').val(),
                            txtNoAkaun: $('#txtNoAkaunT').val(),
                            txtNamaBank: $('#txtNamaBankT').val(),
                            txtEmail: $('#txtEmailT').val(),
                            txtAlamat1: $('#txtAlamat1T').val(),
                            txtAlamat2: $('#txtAlamat2T').val(),
                            ddlPoskod: $('#ddlPoskodT').val(),
                            ddlBandar: $('#ddlBandarT').val(),
                            ddlNegeri: $('#ddlNegeriT').val(),

                        }
                    }

                    try {
                        var result = JSON.parse(await ajaxUpdatePemfaktoran(newPemfaktoran));
                        if (result.Status === true) {
                            showModal11("Success", result.Message, "success");
                            tbl.ajax.reload();

                        } else {
                            showModal11("Error", result.Message, "error");
                        }
                    }
                    catch (error) {
                        console.error('Error:', error);
                        showModal10("Error", "An error occurred during the request.", "error");
                    }
                });
            });

            async function ajaxUpdatePemfaktoran(SaveBankPemfaktoran) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/UpdatePemfaktoranBank") %>',
                        method: 'POST',
                        data: JSON.stringify(SaveBankPemfaktoran),
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
                $('#resultModalMessage11').html(message);
                if (type === "success") {
                    $('#resultModal11').removeClass("modal-error").addClass("modal-success");
                } else if (type === "error") {
                    $('#resultModal11').removeClass("modal-success").addClass("modal-error");
                }
                $('#resultModal11').modal('show');
            }
            

        </script>
</asp:Content>