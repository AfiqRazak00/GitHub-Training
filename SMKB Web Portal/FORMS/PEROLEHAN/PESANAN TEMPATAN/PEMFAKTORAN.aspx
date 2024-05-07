<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="PEMFAKTORAN.aspx.vb" Inherits="SMKB_Web_Portal.PEMFAKTORAN" %>


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

        #tblDataSenarai_permohonan td:hover {
            cursor: pointer;
        }



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



        .right_radius {
            border-bottom-right-radius: 0px !important;
            border-top-right-radius: 0px !important;
        }

        .left_radius {
            border-bottom-left-radius: 0px !important;
            border-top-left-radius: 0px !important;
        }

        .ui.search.dropdown {
            min-width: 100%;
            top: 0px;
            left: 0px;
        }
    </style>

    <div id="PermohonanTab" class="tabcontent" style="display: block">
        <div id="permohonan">
            <div>
                <div class="modal-content m-2">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">PEMFAKTORAN
                        </h5>
                    </div>

                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row">
                            <div class="form-group row col-md-6">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <select id="txtKaedahCarian" class="custom-select input-group__select ui search dropdown">
                                            <option value="" selected="Sila Pilih">Sila Pilih</option>
                                            <option value="1">PT No.</option>
                                            <%--<option value="3">Tarikh</option>
                                            <option value="4">Pembekal</option>--%>
                                        </select>
                                        <label class="input-group__label" for="PanelJaw">Kategori :</label>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group row col-md-6 Pembekal1">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <select class="form-select input-group__select ui search dropdown " id="txtPembekal_ID" aria-label="Example select with button addon">
                                        </select>
                                        <label class="input-group__label" for="PanelJaw">Pembekal :</label>
                                    </div>
                                </div>

                            </div>
                            <div class="form-group row col-md-6 Pembekal2">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <select class="form-select input-group__select ui search dropdown " id="txtPembekal_dtl" aria-label="Example select with button addon">
                                        </select>
                                    </div>
                                </div>

                            </div>


                            <div class="form-group row col-md-6 Tarikh_d">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <div>
                                            <input class="input-group__input form-control " id="txtTarikh_D" type="date" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: white;" />
                                            <label class="input-group__label" for="txtMasa_Lawatan">Tarikh Dari :</label>
                                        </div>
                                        <div>
                                            <input class="input-group__input form-control" id="txtTarikh_H" type="date" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: white;" />
                                            <label class="input-group__label" for="txtMasa_Lawatan" style="left: auto;">Tarikh Hingga :</label>
                                        </div>

                                    </div>
                                </div>

                            </div>
                            <div class="form-group row col-md-6 No_PT Pembekal Tarikh_d">

                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <select class="form-select input-group__select ui search dropdown  " id="txtNo_PT_Inden_SST" aria-label="Example select with button addon">
                                        </select>
                                        <label class="input-group__label" for="txtNo_PT_Inden_SST">No PT/Inden/SST :</label>
                                    </div>
                                </div>

                            </div>


                        </div>
                        <button type="button" data-toggle="tooltip" data-placement="bottom" title="Draft" id="btnPapar" class="btn btn-primary">Papar</button>

                    </div>
                </div>

                <div class="modal-content m-2">

                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row">
                            <div class="form-group col-md-4 ">
                                <div class="input-group">
                                    <input class="input-group__input  " readonly id="txtNo_PT" type="text" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0;" />
                                    <label class="input-group__label" for="txtNo_PT">No PT :</label>
                                </div>
                            </div>
                            <div class="form-group col-md-4 ">
                                <div class="input-group">
                                    <input class="input-group__input  " readonly id="txtTarikhPT" type="date" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0;" />
                                    <label class="input-group__label" for="txtTarikhPT">Tarikh PT  :</label>
                                </div>
                            </div>
                            <div class="form-group col-md-4 ">
                                <div class="input-group">
                                    <input class="input-group__input  " readonly id="txtNo_Daftar_Syarikat" type="text" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0;" />
                                    <label class="input-group__label" for="txtNo_Daftar_Syarikat">No Daftar Syarikat :</label>
                                </div>
                            </div>
                            <div class="form-group col-md-6 ">
                                <div class="input-group">
                                    <input class="input-group__input  " readonly id="txtNama_Syarikat" type="text" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0;" />
                                    <label class="input-group__label" for="txtNama_Syarikat">Nama Syarikat :</label>
                                </div>
                            </div>
                            <div class="form-group col-md-6 ">
                                <div class="input-group">
                                    <textarea class="input-group__input" readonly id="txtAlamat" style="background-color: #f0f0f0; height: auto" rows="2"></textarea>
                                    <label class="input-group__label" for="Alamat">Alamat :</label>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>

                <div class="modal-content m-2">

                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row">
                            <div class="form-group  col-md-6 ">

                                
                                    <div class="input-group">

                                        <input class="input-group__input  " readonly id="txtNamaBank" type="text" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0;" />
                                        <label class="input-group__label" for="txtNegeri">Nama Bank :</label>

                                    </div>
                               

                            </div>
                            <div class="form-group  col-md-6 ">

                                
                                    <div class="input-group">
                                        <select class="form-select input-group__select ui search dropdown " id="txtBayar_Atas_Nama" aria-label="Example select with button addon">
                                        </select>
                                        <label class="input-group__label" for="txtNo_PT_Inden_SST">Bayar Atas Nama :</label>
                                    </div>
                                

                            </div>
                            <div class="form-group col-md-6">
                                <div class="input-group">
                                    <input class="input-group__input  " readonly id="txtNo_Akaun" type="text" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0;" />
                                    <label class="input-group__label" for="txtNo_PT">No Akaun :</label>
                                </div>
                            </div>
                            <div class="form-group col-md-6 ">
                                <div class="input-group">
                                    <input class="input-group__input  " readonly id="txtEmail" type="email" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0;" />
                                    <label class="input-group__label" for="txtTarikhPT">Email :</label>
                                </div>
                            </div>
                            <div class="form-group col-md-6 ">
                                <div class="input-group">
                                    <textarea class="input-group__input" readonly id="txtAlamatBank" style="background-color: #f0f0f0; height: auto" rows="2"></textarea>
                                    <label class="input-group__label" for="Alamat">Alamat :</label>
                                </div>

                            </div>
                            <div class="form-group col-md-3 ">
                                <div class="input-group">
                                    <input class="input-group__input  " readonly id="txtBandar" type="text" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0;" />
                                    <label class="input-group__label" for="txtBandar">Bandar :</label>
                                </div>
                            </div>
                            <div class="form-group col-md-3 ">
                                <div class="input-group">
                                    <input class="input-group__input  " readonly id="txtNegeri" type="text" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0;" />
                                    <label class="input-group__label" for="txtNegeri">Negeri  :</label>
                                </div>
                            </div>
                            <div class="form-group col-md-3 ">
                                <div class="input-group">
                                    <input class="input-group__input  " readonly id="txtPoskod" type="text" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0;" />
                                    <label class="input-group__label" for="txtPoskod">Poskod  :</label>
                                </div>
                            </div>
                            <div class="form-group col-md-3 ">
                                <div class="input-group">
                                    <input class="input-group__input  " readonly id="txtNegara" type="text" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: #f0f0f0;" />
                                    <label class="input-group__label" for="txtNegara">Negara :</label>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="col text-center m-3">
                    <button type="button" id="btnSimpanReset" class="btn btn-outline btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Draft">Reset</button>
                    <button type="button" id="btnSimpanPemfaktoran" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                </div>

            </div>

        </div>

        <!-- Modal Pengesahan-->
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

    </div>



    <script type="text/javascript">

        var Pesanan_ID = '';
        var No_PT_Inden_SST = '';
        var kaedahCarian = '';
        var IdPembekal_dtl = '';
        var txtTkhMula = '';
        var txtTkhTamat = '';
        var IdFaktor = ''
        var KodBank = '';
        var Bayar_Nama = '';

        document.addEventListener('DOMContentLoaded', function () {
            var kaedahCarianSelect = document.getElementById('txtKaedahCarian');
            var pembekalDiv1 = document.querySelector('.Pembekal1');
            var pembekalDiv2 = document.querySelector('.Pembekal2');
            var Tarikh_dDiv = document.querySelector('.Tarikh_d');
            var No_PTDiv = document.querySelector('.No_PT');




            // Initially hide or show based on the default value
            togglePembekalDiv();
            toggleTarikh_dDiv();
            toggleNo_PTDiv();

            kaedahCarianSelect.addEventListener('change', function () {
                // Hide or show based on the selected value
                togglePembekalDiv();
                toggleTarikh_dDiv();
                toggleNo_PTDiv();
                kaedahCarian = kaedahCarianSelect.value
                recallNo_PT_Inden_SST(kaedahCarian);
                //loadNo_PT_Inden_SST()
            });

            function togglePembekalDiv() {
                if (kaedahCarianSelect.value === '4') {
                    pembekalDiv1.style.display = 'block';
                    pembekalDiv2.style.display = 'block';
                    No_PTDiv.style.display = 'block';
                } else {
                    pembekalDiv1.style.display = 'none';
                    pembekalDiv2.style.display = 'none';
                    //No_PTDiv.style.display = 'none';
                }
            }

            function toggleTarikh_dDiv() {
                if (kaedahCarianSelect.value === '3') {
                    Tarikh_dDiv.style.display = 'block';
                    No_PTDiv.style.display = 'block';
                } else {
                    Tarikh_dDiv.style.display = 'none';
                    //No_PTDiv.style.display = 'none';
                }
            }

            //function togglePelarasan_PTDiv() {
            //    if (kaedahCarianSelect.value === '2') {
            //        Pelarasan_PTDiv.style.display = 'block';
            //    } else {
            //        Pelarasan_PTDiv.style.display = 'none';
            //    }
            //}
            function toggleNo_PTDiv() {
                if (kaedahCarianSelect.value === '1') {
                    No_PTDiv.style.display = 'block';
                } else if (kaedahCarianSelect.value === '') {
                    No_PTDiv.style.display = 'none';
                }
            }



        });


        var Pembekal_dtl
        var KodJenisBarang

        $(document).ready(function () {
            // Dropdown Syarikat Bidang Utama
            $('#txtPembekal_ID').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/GetPembekalPO?q={query}") %>',
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
                        $(objItem).html('');

                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        $.each(listOptions, function (index, option) {
                            $(objItem).append($('<div class="item" data-value="' + option.kodValue + '">').html(option.text));
                        });

                        $(obj).dropdown('refresh');

                        // Handle selection change
                        $(obj).dropdown({
                            onChange: function (kodValue, text, $selectedItem) {
                                // Do something with the selected value
                                console.log("Selected Value:", kodValue);
                                console.log("Selected Text:", text);
                                console.log("Selected Item:", $selectedItem);

                                KodJenisBarang = kodValue;
                                console.log("+ KodJenisBarang", KodJenisBarang)

                                // Recall #txtPembekal_dtl dropdown
                                recallPembekalDtl(kodValue);

                                beginSearch();
                            }
                        });

                        // Show dropdown
                        $(obj).dropdown('show');
                    }
                }
            });
        });

        function recallPembekalDtl(KodJenisBarang) {
            $('#txtPembekal_dtl').dropdown('clear'); // Clear the dropdown options
            $('#txtPembekal_dtl').dropdown('refresh'); // Refresh the dropdown

            // Update API settings data
            //$('#txtPembekal_dtl').dropdown('setting', 'apiSettings', {
            //    data: { q: '', Jenis_Barang: KodJenisBarang }
            //});

            // Update API settings data for txtPembekal_dtl dropdown
            $('#txtPembekal_dtl').dropdown('setting', 'apiSettings', {
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/GetSyarikatPO") %>',
                method: 'POST',
                dataType: "json",
                contentType: 'application/json; charset=utf-8',
                cache: false,
                beforeSend: function (settings) {
                    settings.data = JSON.stringify({ q: '', Jenis_Barang: KodJenisBarang });
                    return settings;
                },
                onSuccess: function (response) {
                    var obj = $(this);
                    var objItem = $(this).find('.menu');
                    $(objItem).html('');

                    if (response.d.length === 0) {
                        $(obj.dropdown("clear"));
                        return false;
                    }

                    var listOptions = JSON.parse(response.d);

                    $.each(listOptions, function (index, option) {
                        $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                    });

                    $(obj).dropdown('refresh');

                    // Handle selection change
                    $(obj).dropdown({
                        onChange: function (value, text, $selectedItem) {
                            // Do something with the selected value
                            console.log("Selected Value:", value);
                            console.log("Selected Text:", text);
                            console.log("Selected Item:", $selectedItem);

                            IdPembekal_dtl = value;
                            console.log("+ IdPembekal_dtl", IdPembekal_dtl)
                            recallNo_PT_Inden_SST(4)

                            //beginSearch();
                        }
                    });

                    // Show dropdown
                    $(obj).dropdown('show');
                }
            });

            // Query for new options
            $('#txtPembekal_dtl').dropdown('query');
        }

        function recallNo_PT_Inden_SST(kaedahCarian) {
            $('#txtNo_PT_Inden_SST').dropdown('clear'); // Clear the dropdown options
            $('#txtNo_PT_Inden_SST').dropdown('refresh'); // Refresh the dropdown

            // Update API settings data
            //$('#txtNo_PT_Inden_SST').dropdown('setting', 'apiSettings', {
            //    data: { q: '', category_filter: kaedahCarian, IdSyarikat: IdPembekal_dtl, tkhMula: $("#txtTarikh_D").val(), TkhTamat: $("#txtTarikh_H").val(), }
            //});

            $('#txtNo_PT_Inden_SST').dropdown('setting', 'apiSettings', {
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/GetPerolehanPesananHdr") %>',
                method: 'POST',
                dataType: "json",
                contentType: 'application/json; charset=utf-8',
                cache: false,
                beforeSend: function (settings) {
                    settings.data = JSON.stringify({ q: '', category_filter: kaedahCarian, IdSyarikat: IdPembekal_dtl, tkhMula: $("#txtTarikh_D").val(), TkhTamat: $("#txtTarikh_H").val(), });
                    return settings;
                },
                onSuccess: function (response) {
                    var obj = $(this);
                    var objItem = $(this).find('.menu');
                    $(objItem).html('');

                    if (response.d.length === 0) {
                        $(obj.dropdown("clear"));
                        return false;
                    }

                    var listOptions = JSON.parse(response.d);

                    $.each(listOptions, function (index, option) {
                        $(objItem).append($('<div class="item" data-value="' + option.kodValue + '">').html(option.text));
                    });

                    $(obj).dropdown('refresh');

                    // Handle selection change
                    $(obj).dropdown({
                        onChange: function (value, text, $selectedItem) {
                            // Do something with the selected value
                            console.log("Selected Value:", value);
                            console.log("Selected Text:", text);
                            console.log("Selected Item:", $selectedItem);

                            No_PT_Inden_SST = value;
                            console.log("+ No_PT_Inden_SST", No_PT_Inden_SST)


                            //beginSearch();
                        }
                    });

                    // Show dropdown
                    $(obj).dropdown('show');
                }
            });


            $('#txtNo_PT_Inden_SST').dropdown('query'); // Query for new options
        }

        $(document).ready(function () {
            // Dropdown Syarikat Bidang Utama
            loadPembekalDtl();
            loadNo_PT_Inden_SST();
        })

        function loadPembekalDtl() {
            Pembekal_dtl = $('#txtPembekal_dtl').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/GetSyarikatPO?q={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query, Jenis_Barang: KodJenisBarang });
                        return settings;
                    },
                    onSuccess: function (response) {
                        var obj = $(this);
                        var objItem = $(this).find('.menu');
                        $(objItem).html('');

                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        $.each(listOptions, function (index, option) {
                            $(objItem).append($('<div class="item" data-value="' + option.kodValue + '">').html(option.text));
                        });

                        $(obj).dropdown('refresh');

                        // Show dropdown
                        $(obj).dropdown('show');
                    }
                }
            });
        }


        $('#ddlKategori').dropdown({
            selectOnKeydown: true,
            fullTextSearch: true,
            apiSettings: {
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Get_Sub_Bidang_Utama?q={query}&kodmof={query}") %>',
                method: 'POST',
                dataType: "json",
                contentType: 'application/json; charset=utf-8',
                cache: false,
                beforeSend: function (settings) {
                    // Replace {query} placeholder in data with user-entered search term
                    settings.data = JSON.stringify({ q: settings.urlData.query, kodmof: $('#ddlMod').dropdown("get value") });
                    //searchQuery = settings.urlData.query;
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
                        $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                    });

                    // Refresh dropdown
                    $(obj).dropdown('refresh');

                    //if (shouldPop === true) {
                    $(obj).dropdown('show');
                    //}
                }
            }
        });

        $(document).ready(function () {
            // Dropdown bank Bidang Utama
            $('#txtBayar_Atas_Nama').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/GetBankPO?q={query}") %>',
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
                        $(objItem).html('');

                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        $.each(listOptions, function (index, option) {
                            $(objItem).append($('<div class="item" data-value="' + option.kodValue + '">').html(option.text));
                        });

                        $(obj).dropdown('refresh');

                        // Handle selection change
                        $(obj).dropdown({
                            onChange: function (kodValue, text, $selectedItem) {
                                // Do something with the selected value
                                console.log("Selected Value:", kodValue);
                                console.log("Selected Text:", text);
                                console.log("Selected Item:", $selectedItem);

                                Bayar_Atas_Nama = kodValue;
                                Bayar_Nama = text;
                                console.log("+ Bayar_Atas_Nama", Bayar_Atas_Nama)

                                $(document).ready(function () {
                                    $.ajax({
                                        type: "POST",
                                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/LoadPemfaktoran_Bank") %>',
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        data: JSON.stringify({ IdPemfaktoranBank: Bayar_Atas_Nama }), // Convert the data to a JSON string
                                        success: function (data) {
                                            // Parse the JSON data
                                            var jsonData = JSON.parse(data.d);

                                            var AlamatBank = jsonData[0].Alamat1 + ' ' + jsonData[0].Alamat1;
                                            $('#txtNamaBank').val(jsonData[0].Name_bank);
                                            $('#txtNo_Akaun').val(jsonData[0].NoAkaun);
                                            $('#txtEmail').val(jsonData[0].Email);
                                            $('#txtAlamatBank').val(AlamatBank);
                                            $('#txtBandar').val(jsonData[0].Bandar_name);
                                            $('#txtNegeri').val(jsonData[0].Negeri_name);
                                            $('#txtPoskod').val(jsonData[0].Poskod);
                                            $('#txtNegara').val(jsonData[0].Negara_name);
                                            KodBank = jsonData[0].Kod_Bank;



                                        },
                                        error: function (error) {
                                            console.log("Error: " + error);
                                        }
                                    });
                                });

                            }
                        });

                        // Show dropdown
                        $(obj).dropdown('show');
                    }
                }
            });
        })

       <%-- $(document).ready(function () {
            // Dropdown Syarikat Bidang Utama
            $('#txtBayar_Atas_Nama').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Get_Jawatan_Kuasa?q={query}") %>',
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
                        $(objItem).html('');

                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        $.each(listOptions, function (index, option) {
                            $(objItem).append($('<div class="item" data-value="' + option.kodValue + '">').html(option.text));
                        });

                        $(obj).dropdown('refresh');

                        // Handle selection change
                        $(obj).dropdown({
                            onChange: function (kodValue, text, $selectedItem) {
                                // Do something with the selected value
                                console.log("Selected Value:", kodValue);
                                console.log("Selected Text:", text);
                                console.log("Selected Item:", $selectedItem);

                                KodJawatanKuas = kodValue;

                                console.log("+ KodJawatanKuas", KodJawatanKuas)

                                beginSearch();

                            }
                        });

                        // Show dropdown
                        $(obj).dropdown('show');
                    }
                }
            });
        })--%>

        function loadNo_PT_Inden_SST() {
            console.log("test=", kaedahCarian)
            $(document).ready(function () {
                // Dropdown Syarikat Bidang Utama

                $('#txtNo_PT_Inden_SST').dropdown({
                    selectOnKeydown: true,
                    fullTextSearch: true,
                    apiSettings: {
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/GetPerolehanPesananHdr?q={query}") %>',
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        cache: false,
                        beforeSend: function (settings) {
                            settings.data = JSON.stringify({ q: settings.urlData.query, category_filter: kaedahCarian, IdSyarikat: IdPembekal_dtl, tkhMula: $("#txtTarikh_D").val(), TkhTamat: $("#txtTarikh_H").val(), });
                            return settings;
                        },
                        onSuccess: function (response) {
                            var obj = $(this);
                            var objItem = $(this).find('.menu');
                            $(objItem).html('');

                            if (response.d.length === 0) {
                                $(obj.dropdown("clear"));
                                return false;
                            }

                            var listOptions = JSON.parse(response.d);

                            $.each(listOptions, function (index, option) {
                                $(objItem).append($('<div class="item" data-value="' + option.kodValue + '">').html(option.text));
                            });

                            $(obj).dropdown('refresh');

                            // Handle selection change
                            $(obj).dropdown({
                                onChange: function (value, text, $selectedItem) {
                                    // Do something with the selected value
                                    console.log("Selected Value:", value);
                                    console.log("Selected Text:", text);
                                    console.log("Selected Item:", $selectedItem);

                                    No_PT_Inden_SST = value;
                                    console.log("+ No_PT_Inden_SST", No_PT_Inden_SST)


                                    //beginSearch();
                                }
                            });

                            // Show dropdown
                            $(obj).dropdown('show');
                        }
                    }
                });
            })
        }
        var IdMohon = '';


        var newIdJualan;
        var newNoMohon;


        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadMaklumat_Naskah_Jualan") %>',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ IdMohon: Id_MohonDtl }), // Convert the data to a JSON string
                success: function (data) {
                    // Parse the JSON data
                    var jsonData = JSON.parse(data.d);



                    //$("#txtNoNaskah_Jualan").val(jsonData[0].Id_Jualan);
                    $('#txtNo_PT').val();
                    $('#txtTarikhPT').val();
                    $('#txtNo_Daftar_Syarikat').val();
                    $('#txtNama_Syarikat').val();
                    $('#txtAlamat').val();

                    $('#txtNo_Akaun').val();
                    $('#txtEmail').val();
                    $('#txtAlamatBank').val();
                    $('#txtBandar').val();
                    $('#txtNegeri').val();
                    $('#txtPoskod').val();
                    $('#txtNegara').val();




                },
                error: function (error) {
                    console.log("Error: " + error);
                }
            });
        });


        // Simpan  Permohonan ulasan
        $('#btnSimpanPemfaktoran').off('click').on('click', async function () {
            var msg = "Anda pasti ingin mengemaskini maklumat Penfaktoran ini?";
            
            $('#confirmationMessage10').text(msg);
            $('#saveConfirmationModal10').modal('show');

            $('#confirmSaveButton10').off('click').on('click', async function () {
                $('#saveConfirmationModal10').modal('hide');



                var newPemfaktoran_dtl = {

                    Pemfaktoran_dtl: {

                        txtPembekal_ID: $('#txtPembekal_ID').val(),
                        txtPembekal_dtl: $('#txtPembekal_dtl').val(),
                        txtTarikh_D: $('#txtTarikh_D').val(),
                        txtTarikh_H: $('#txtTarikh_H').val(),
                        txtNo_PT_Inden_SST: $('#txtNo_PT_Inden_SST').val(),
                        txtNo_PT: $('#txtNo_PT').val(),
                        txtTarikhPT: $('#txtTarikhPT').val(),
                        txtNo_Daftar_Syarikat: $('#txtNo_Daftar_Syarikat').val(),
                        txtNama_Syarikat: $('#txtNama_Syarikat').val(),
                        txtAlamat: $('#txtAlamat').val(),

                        txtNamaBank: $('#txtNamaBank').val(),
                        txtBayar_Atas_Nama: Bayar_Nama,
                        txtNo_Akaun: $('#txtNo_Akaun').val(),
                        txtEmail: $('#txtEmail').val(),
                        txtAlamatBank: $('#txtAlamatBank').val(),
                        txtBandar: $('#txtBandar').val(),
                        txtNegeri: $('#txtNegeri').val(),
                        txtPoskod: $('#txtPoskod').val(),
                        txtNegara: $('#txtNegara').val(),
                        txtId_Pemfaktoran_Bank: Bayar_Atas_Nama,
                        txtIdFaktor: IdFaktor,
                        txtKodBank: KodBank
                    }

                };


                try {
                    var result = JSON.parse(await ajaxHantarPemfaktoran(newPemfaktoran_dtl))

                    if (result.Status === true) {
                        showModal10("Success", result.Message, "success");
                        //$('#txtNoMohonR').val(result.Payload.txtNoMohon);
                    } else {
                        showModal10("Error", result.Message, "error");
                    }
                } catch (error) {
                    console.error('Error:', error);
                    showModal10("Error", "An error occurred during the request.", "error");
                }
            });
        });

        // Simpan  Permohonan ulasan
        $('#btnSimpanReset').off('click').on('click', async function () {

            $('#txtNo_PT').val('');
            $('#txtTarikhPT').val('');
            $('#txtNo_Daftar_Syarikat').val('');
            $('#txtNama_Syarikat').val('');
            $('#txtAlamat').val('');

            $('#txtNamaBank').val(''),
            $('#txtNo_Akaun').val('');
            $('#txtEmail').val('');
            $('#txtAlamatBank').val('');
            $('#txtBandar').val('');
            $('#txtNegeri').val('');
            $('#txtPoskod').val('');
            $('#txtNegara').val('');
            $('#txtBayar_Atas_Nama').dropdown('clear'); // Clear the dropdown options

        });



        async function ajaxHantarPemfaktoran(Pemfaktoran_dtl) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/UpdateHantarPemfaktoran") %>',
                    method: 'POST',
                    data: JSON.stringify(Pemfaktoran_dtl),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);

                        var jsonData = JSON.parse(data.d);


                        //$("#txtNoNaskah_Jualan").val(jsonData[0].Id_Jualan);


                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            });
        }


        // Simpan btnPapar
        $('#btnPapar').off('click').on('click', async function () {
            Pesanan_ID = No_PT_Inden_SST;

            console.log('Pesanan_ID', No_PT_Inden_SST);

            try {
                var result = JSON.parse(await ajaxHantarMaklumatPesananHdr(Pesanan_ID))

                if (result.Status === true) {
                    //showModal10("Success", result.Message, "success");
                    //$('#txtNoMohonR').val(result.Payload.txtNoMohon);
                    //tblNJ.ajax.reload();
                    //loadMaklumatIklan();
                } else {
                    //showModal10("Error", result.Message, "error");
                }
            } catch (error) {
                console.error('Error:', error);
                showModal10("Error", "An error occurred during the request.", "error");
            }


        });
        
        async function ajaxHantarMaklumatPesananHdr(Pesanan_ID) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/LoadPerolehan_Pesanan_Hdr") %>',
                    method: 'POST',
                    data: JSON.stringify({ IdPesanan: No_PT_Inden_SST }),

                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);


                        var jsonData = JSON.parse(data.d);

                        var txtaddress = jsonData[0].Almt_Semasa_1 + ' ' + jsonData[0].Almt_Semasa_2 + ' ' + jsonData[0].Poskod_Semasa + ' ' + jsonData[0].Bandar_name + ' ' + jsonData[0].Negeri_name;

                        //$("#txtNoNaskah_Jualan").val(jsonData[0].Id_Jualan);
                        $('#txtNo_PT').val(jsonData[0].No_Pesanan);
                        $('#txtTarikhPT').val(jsonData[0].Tarikh_PT1);
                        $('#txtNo_Daftar_Syarikat').val(jsonData[0].ID_Sykt);
                        $('#txtNama_Syarikat').val(jsonData[0].Nama_Sykt);
                        $('#txtAlamat').val(txtaddress);


                        

                        if (jsonData[0].Alamat1 === null || jsonData[0].Alamat1 === '') {
                            var AlamatBank = ' ';
                        } else {
                            var AlamatBank = jsonData[0].Alamat1 + ' ' + jsonData[0].Alamat2;
                        }
                        
                        $('#txtNamaBank').val(jsonData[0].Name_bank);
                        $('#txtNo_Akaun').val(jsonData[0].NoAkaun);
                        $('#txtEmail').val(jsonData[0].Email);
                        $('#txtAlamatBank').val(AlamatBank);
                        $('#txtBandar').val(jsonData[0].Bandar_nameBank);
                        $('#txtNegeri').val(jsonData[0].Negeri_nameBank);
                        $('#txtPoskod').val(jsonData[0].Poskod);
            

                        IdFaktor = jsonData[0].Id_Faktor;
                        KodBank = jsonData[0].Main_Kod_Bank
                        

                        // Populate dropdown select options
                        var selectOptions = '';
                        jsonData.forEach(function (item) {
                            selectOptions += '<option value="' + item.Id_No + '">' + item.Bayar_Atas_Nama + '</option>'; // Replace SomeValue and SomeText with actual property names from your data
                        });

                        // Update dropdown select
                        if (jsonData[0].Bayar_Atas_Nama === null || jsonData[0].Bayar_Atas_Nama === '') {
                            $('#txtBayar_Atas_Nama').html();
                            $('#txtNegara').val('');
                        } else {
                            $('#txtBayar_Atas_Nama').html(selectOptions);
                            $('#txtNegara').val(jsonData[0].Negara_name);
                        }
                        
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





    </script>



</asp:Content>


