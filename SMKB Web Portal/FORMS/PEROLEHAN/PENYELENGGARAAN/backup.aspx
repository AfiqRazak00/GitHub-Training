<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="backup.aspx.vb" Inherits="SMKB_Web_Portal.backup" %>
<asp:Content ID="FormContents" ContentPlaceHolderID="FormContents" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>

        <style>
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

        .modal-header--sticky {
            position: sticky;
            top: 0;
            background-color: inherit; 
            z-index: 1055; 
        }

        .modal-footer--sticky {
            position: sticky;
            bottom: 0;
            background-color: inherit; 
            z-index: 1055; 
        }


        .table-common {
            border-collapse: collapse;
            width: 100%;
        }

            .table-common th,
            .table-common td {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }

            .table-common th {
                background-color: #f2f2f2;
            }

            .error-message {
                display:none;
            }

            .error-message.err-active {
                display:inline;
            }

            .dropdown.disabled {
                opacity:unset !important;
            }
    </style>


    <contenttemplate>

        <div id="PermohonanTab" class="tabcontent" style="display: block">

            <ul class="nav nav-tabs" id="myTab" role="tablist">

                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="maklumatPO-tab" data-toggle="tab" data-target="#perolehan" type="button" role="tab">Daftar Jawatankuasa</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link btnSearchAm" id="spesifikasiAm-tab" data-toggle="tab" data-target="#spesifikasi-am" type="button" role="tab">Daftar Ahli Jawatankuasa</button>
                </li>
            </ul>



            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="perolehan" role="tabpanel">
                    <!-- tab 1 (Maklumat Perolehan) -->

                    <div id="divpendaftaraninv" runat="server" visible="true">
                        <div class="modal-body">
                            <div>
                                <div class="row">
                                    <div class="col-sm-4">
                                        <h5>Daftar Jawatankuasa</h5>
                                    </div>

                                </div>
                                <hr />


                                    <div class="card">
                                    <div class="card-body">

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-4">
                                                <select class="input-group__select ui search dropdown" name="Mod Jawatankuasa" id="ddlMod" placeholder="&nbsp;">
                                                </select>
                                                <label class="input-group__label" for="Mod Jawatankuasa">Mod Jawatankuasa</label>
                                            </div>

                                            <div class="form-group col-md-4">
                                                <select class="input-group__select ui search dropdown" name="Kategori Jawatankuasa" id="ddlKategori" placeholder="&nbsp;">
                                                </select>
                                                <label class="input-group__label" for="Kategori Jawatankuasa">Kategori Jawatankuasa</label>
                                            </div>

                                            
                                            <div class="form-group col-md-4">
                                                <input class="input-group__input" name="Kod Jawatankuasa" id="txtKodJawatankuasa" type="text" readonly style="background-color: #f0f0f0" />
                                                <label class="input-group__label" for="Kod Jawatankuasa">Kod Jawatankuasa</label>
                                            </div>


                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">

                                            <div class="form-group col-md-8">
                                                <input class="input-group__input" name="Nama Jawatankuasa" id="txtNamaJawatankuasa" type="text" />
                                                <label class="input-group__label" for="Nama Jawatankuasa">Nama Jawatankuasa</label>
                                            </div>


                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="form-group" style="margin-left: 7px">
                                                <label style="margin-bottom: unset"><strong>Status:</strong></label>

                                                <input type="radio" id="DokumenType_0" name="DokumenType" value="1" style="display: inline-block; margin-left: 10px">
                                                <label style="font-weight: unset" for="html">Aktif</label>

                                                <input type="radio" id="DokumenType_1" name="DokumenType" value="0" style="display: inline-block; margin-left: 10px">
                                                <label style="font-weight: unset" for="css">Tidak Aktif</label>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group col-md-12" align="center">
                                        <button type="button" id="lbtnSimpanInfo" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Simpan">
                                            Simpan
                                        </button>
                                    </div>
                                </div>

                              </div>
                            </div>








                                <div class="card mt-4">
                                    <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Senarai Jawatankuasa</h6>
                                    <div class="card-body">

                                        <div class="col-md-12">
                                            <div class="transaction-table table-responsive">
                                                <table id="tblSenaraiJawatankuasa" class="table table-striped" style="width: 99%">
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Bil</th>
                                                            <th scope="col">Mod Jawatankuasa</th>
                                                            <th scope="col">Kod Jawatankuasa</th>
                                                            <th scope="col">Butiran</th>
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
                    </div>

                </div>



                <!-- tab 2 (Maklumat Spesifikasi Am) -->
                <div class="tab-pane fade" id="spesifikasi-am" role="tabpanel">
                    <div class="modal-body">
                        <div>
                            <h5>Maklumat Spesifikasi Am</h5>
                            <hr />
                        </div>

                    </div>

                </div>

            </div>
        </div>



        <script type="text/javascript">

            $('#ddlMod').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Mod_Jawatankuasa?q={query}") %>',
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
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                        });

                        $(obj).dropdown('refresh');

                        $(obj).dropdown('show');
                    }
                }
            });

            $('#ddlMod').change(function () {
                $('#ddlKategori').dropdown("clear");
                $('#ddlKategori').closest(".dropdown").removeClass("disabled");
            })


           <%-- $('#ddlKategori').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Kod_Jawatankuasa?q={query}&kodmof={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query, kod_jawatankuasa: $('#ddlMod').dropdown("get value") });
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
            });--%>

     <%--       generate_dropdownObj({
                id: 'ddlKategori',
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Kod_Jawatankuasa?q={query}&kodmof={query}") %>',
            })--%>

            generate_dropdown('ddlKategori',
                '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Kod_Jawatankuasa?q={query}&kodmof={query}") %>', function () {
                    return {
                        kod_jawatankuasa: $('#ddlMod').dropdown("get value")
                    }
            }, function (value, text, obj) {
                    if (value === "") {
                        return;
                    }
                    var kod_jawatankuasa = $('#ddlMod').val();
                    var kod_kategori = value;

                    //BUAT AJAX DAPATKAN KOD JAWATANKUASA KEMUDIAN SET PADA INPUT
                    //alert(kod_jawatankuasa);
                    //alert(kod_kategori);
                //
            })

            <%--$('#ddlKategori').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                placeholder: '-- Sila Pilih --',
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Get_Kod_Jawatankuasa?q={query}&kodmof={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query, kod_jawatankuasa: $('#ddlMod').dropdown("get value") });
                        return settings;
                    },
                    onResponse: function (response) {
                        var responsex = {
                            success: true,
                            results: []
                        };
                        users = JSON.parse(response.d)
                        $.each(users, function (index, item) {
                            responsex.results.push({
                                text: item.text,
                                value: item.value
                            });
                        });
                        return responsex;
                    },
                    cache: false,
                    //dataType: "json",
                    //contentType: 'application/json; charset=utf-8'
                },
                filterRemoteData: true,
                fields: {
                    name: 'text',
                    value: 'value'
                },
            })--%>

            function generate_dropdown(id, urlDropdown, paramToSend, onchange) {
                $('#' + id).dropdown({
                    selectOnKeydown: true,
                    fullTextSearch: true,
                    placeholder: '-- Sila Pilih --',
                    onChange: function (value, text, obj) {
                        if (typeof onchange === "function") {
                            onchange(value, text, obj);
                        }
                    },
                    apiSettings: {
                        url: urlDropdown,
                        method: 'POST',
                        dataType: "json",
                        contentType: 'application/json; charset=utf-8',
                        beforeSend: function (settings) {
                            var defaultParam = {
                                q: settings.urlData.query
                            }
                            if (typeof paramToSend === "function") {
                                var newParam = paramToSend();
                                $.extend(defaultParam, newParam);
                            }

                            settings.data = JSON.stringify(defaultParam);
                            return settings;
                        },
                        onResponse: function (response) {
                            var responsex = {
                                success: true,
                                results: []
                            };
                            users = JSON.parse(response.d)
                            $.each(users, function (index, item) {
                                responsex.results.push({
                                    text: item.text,
                                    value: item.value
                                });
                            });
                            return responsex;
                        },
                        cache: false,
                        //dataType: "json",
                        //contentType: 'application/json; charset=utf-8'
                    },
                    filterRemoteData: true,
                    fields: {
                        name: 'text',
                        value: 'value'
                    },
                })


                //function generate_dropdownObj(param) {
                //    $('#' + param.id).dropdown({
                //        selectOnKeydown: true,
                //        fullTextSearch: true,
                //        placeholder: '-- Sila Pilih --',
                //        onChange: function (value, text, obj) {
                //            if (typeof param.onchange === "function") {
                //                param.onchange(value, text, obj);
                //            }
                //        },
                //        apiSettings: {
                //            url: param.url,
                //            method: 'POST',
                //            dataType: "json",
                //            contentType: 'application/json; charset=utf-8',
                //            beforeSend: function (settings) {
                //                var defaultParam = {
                //                    q: settings.urlData.query
                //                }
                //                if (typeof param.paramToSend === "function") {
                //                    var newParam = param.paramToSend();
                //                    $.extend(defaultParam, newParam);
                //                }

                //                settings.data = JSON.stringify(defaultParam);
                //                return settings;
                //            },
                //            onResponse: function (response) {
                //                var responsex = {
                //                    success: true,
                //                    results: []
                //                };
                //                users = JSON.parse(response.d)
                //                $.each(users, function (index, item) {
                //                    responsex.results.push({
                //                        text: item.text,
                //                        value: item.value
                //                    });
                //                });
                //                return responsex;
                //            },
                //            cache: false,
                //            //dataType: "json",
                //            //contentType: 'application/json; charset=utf-8'
                //        },
                //        filterRemoteData: true,
                //        fields: {
                //            name: 'text',
                //            value: 'value'
                //        },
                //    })
                //}

            $('#ddlKategori').closest(".dropdown").addClass("disabled");
        </script>



    </contenttemplate>
</asp:Content>

