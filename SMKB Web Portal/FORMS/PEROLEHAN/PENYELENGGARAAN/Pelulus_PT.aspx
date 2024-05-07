<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pelulus_PT.aspx.vb" Inherits="SMKB_Web_Portal.Pelulus_PT" %>
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

        #tblSenaraiPelulus td:hover {
            cursor: pointer;
        }

        .dropdown.disabled {
            opacity: unset !important;
        }
    </style>


    <div class="tabcontent" style="display: block">

        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Pelulus Pesanan Tempatan</h5>
                    </div>

                    <div class="card" style="margin: 20px">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">


                                        <div class="form-group col-md-6">
                                            <select class="input-group__select ui search dropdown" name="Pusat Tanggungjawab" id="ddlPtj" placeholder="&nbsp;">
                                            </select>
                                            <label class="input-group__label" for="Pusat Tanggungjawab">Pusat Tanggungjawab</label>
                                        </div>

                                        <div class="form-group col-md-6">
                                            <select class="input-group__select ui search dropdown" name="Nama Staf" id="ddlStaf" placeholder="&nbsp;">
                                            </select>
                                            <label class="input-group__label" for="Nama Staf">Nama Staf</label>
                                        </div>

                                    </div>
                                </div>
                            </div>



                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">

                                        <div class="form-group col-md-3">
                                            <select class="input-group__select ui search dropdown cddl" name="Jawatan Jawatankuasa" id="ddlStatus" placeholder="&nbsp;">
                                                <option value="" selected>-- Sila Pilih -- </option>
                                                <option value="1">Aktif</option>
                                                <option value="0">Tidak Aktif</option>
  
                                            </select>
                                            <label class="input-group__label" for="Jawatan Jawatankuasa">Jawatan Jawatankuasa</label>
                                        </div>


                                    </div>
                                </div>
                            </div>


                            <div class="form-row">
                                <div class="form-group col-md-12" align="center">
                                    <button type="button" id="btnSimpan" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Simpan" style="width:160px">
                                        Simpan
                                    </button>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="card" style="margin: 20px">
                      <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Senarai Pelulus Pesanan Tempatan</h6>
                        <div class="card-body">
               
                                <div class="col-md-12">
                                    <div class="transaction-table table-responsive">
                                        <table id="tblSenaraiPelulus" class="table table-striped" style="width: 99%">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Bil</th>
                                                    <th scope="col">ID No</th>
                                                    <th scope="col">PTJ</th>
                                                    <th scope="col">No Staf</th>
                                                    <th scope="col">Nama Staf</th>
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


        <!-- Modal -->
        <div class="modal fade" id="editPelulus" tabindex="-1" aria-hidden="true">
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


                                    <div class="form-group col-md-6">
                                        <select class="input-group__select ui search dropdown" name="Pusat Tanggungjawab" id="ddlPtjR" placeholder="&nbsp;" >
                                        </select>
                                        <label class="input-group__label" for="Pusat Tanggungjawab">Pusat Tanggungjawab</label>
                                    </div>

                                    <div class="form-group col-md-6">
                                        <select class="input-group__select ui search dropdown" name="Nama Staf" id="ddlStafR" placeholder="&nbsp;">
                                        </select>
                                        <label class="input-group__label" for="Nama Staf">Nama Staf</label>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-md-3">
                                        <select class="input-group__select ui search dropdown cddl" name="Jawatan Jawatankuasa" id="ddlStatusR" placeholder="&nbsp;">
                                            <option value="" selected>-- Sila Pilih -- </option>
                                            <option value="1">Aktif</option>
                                            <option value="0">Tidak Aktif</option>

                                        </select>
                                        <label class="input-group__label" for="Jawatan Jawatankuasa">Jawatan Jawatankuasa</label>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <input type="hidden" name="txtIdNo" id="txtIdNo" />

                    </div>

                    <div class="modal-footer modal-footer--sticky" style="padding: 0px!important">                        
                        <button type="button" class="btn btn-setsemula" data-toggle="tooltip" data-placement="bottom">Tutup</button>
                        <button type="button" class="btn btn-secondary btnSimpanUpdate" data-toggle="tooltip" data-placement="bottom">Simpan</button>                     
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
                        <button type="button" class="btn btn-secondary" id="simpanBidaan">Ya</button>
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



            <!-- Modal Pengesahan-->
        <div class="modal fade" id="saveConfirmationModal1" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="saveConfirmationModalLabel1">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="confirmationMessage1"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="confirmSaveButton1">Ya</button>
                    </div>
                </div>
            </div>
        </div>


            <div class="modal fade" id="resultModal1" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="resultModalLabel1">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="resultModalMessage1"></p>
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
                       <h5 class="modal-title" id="saveConfirmationModalLabel11">Kemaskini Maklumat</h5>
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


        <script type="text/javascript">

            $(".cddl").dropdown({
                fullTextSearch: true
            });

            $(document).ready(function () {
                setupDropdown('#ddlPtj', 'PenyelenggaraanWS.asmx/Get_Ptj', false);
                setupDropdown('#ddlPtjR', 'PenyelenggaraanWS.asmx/Get_Ptj', false);
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
                tbl = $("#tblSenaraiPelulus").DataTable({
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/Senarai_Pelulus") %>',
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
                            
                            $('#ddlPtjR').dropdown("queryRemote", "", function () {
                                setTimeout(function () {
                                    $('#ddlPtjR').dropdown("set selected", data.KodPTJ)

                                    $('#ddlStafR').dropdown("queryRemote", "", function () {
                                        setTimeout(function () {
                                            $('#ddlStafR').dropdown("set selected", data.NoStaf)

                                            $('#editPelulus').modal('show'); 
                                        }, 10)
                                    })
                                }, 10)
                            })
                            
                            $('#ddlStatusR').dropdown("set selected", data.KodStatus)
                            
                            $('#txtIdNo').val(data.Id_No);


                           
                        });
                    },


                    "columns": [
                        { "data": null }, 
                        { "data": "Id_No" },   
                        { "data": "NamaPejabat" },
                        { "data": "NoStaf" },
                        { "data": "NamaStaf" },
                        { "data": "Status" }
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
                            "targets": 1,
                            visible: false,
                        },
                    ]
                });
            });


           <%-- $('#ddlStaf').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                placeholder: '-- Sila Pilih --',
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/GetStaf?q={query}&kod_jawatankuasa={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query, kod_jawatankuasa: $('#ddlPtj').dropdown("get value") });
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

                        $(obj).dropdown('refresh');

                        $(obj).dropdown('show');
                    }
                }
            });--%>

            $('#ddlStaf').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                placeholder: '-- Sila Pilih --',
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/GetStaf?q={query}&kod_jawatankuasa={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query, kod_jawatankuasa: $('#ddlPtj').dropdown("get value") });
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


            $('#ddlStafR').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                placeholder: '-- Sila Pilih --',
                apiSettings: {
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/GetStaf?q={query}&kod_jawatankuasa={query}") %>',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        settings.data = JSON.stringify({ q: settings.urlData.query, kod_jawatankuasa: $('#ddlPtjR').dropdown("get value") });
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

                        $(obj).dropdown('refresh');

                        //$(obj).dropdown('show');
                    }
                }
            });


            $('#ddlPtj').change(function () {
                $('#ddlStaf').dropdown("clear");
                $('#ddlStaf').closest(".dropdown").removeClass("disabled");
            })

            $('#ddlPtjR').change(function () {
                $('#ddlStafR').dropdown("clear");
                $('#ddlStafR').closest(".dropdown").removeClass("disabled");
            })


            $('#ddlStaf').closest(".dropdown").addClass("disabled");
            $('#ddlStafR').closest(".dropdown").addClass("disabled");



            //buttton daftar bidaan
            $('.btnSimpan').off('click').on('click', async function () {

                var msg = "Anda pasti untuk mendaftar maklumat ini?";
                $('#confirmationMessage10').text(msg);
                $('#editPelulus').modal('hide');
                $('#saveConfirmationModal10').modal('show');

                $('#simpanBidaan').off('click').on('click', async function () {
                    $('#saveConfirmationModal10').modal('hide');

                    var newPelulusDaftar = {
                        SavePelulus : {
                            ddlPtj: $('#ddlPtj').val(),
                            ddlStaf: $('#ddlStaf').val(),
                            ddlStatus: $('#ddlStatus').val()

                        }
                    }

                    try {
                        var result = JSON.parse(await ajaxSimpanPelulus(newPelulusDaftar));
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

            async function ajaxSimpanPelulus(SavePelulus) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                       "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/SimpanPelulus") %>',
                        method: 'POST',
                        data: JSON.stringify(SavePelulus),
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
            $('.btnSimpanUpdate').off('click').on('click', async function () {

                var msg = "Anda pasti untuk mengemaskini maklumat ini?";
                $('#confirmationMessage11').text(msg);
                $('#editPelulus').modal('hide');
                $('#saveConfirmationModal11').modal('show');

                $('#simpanKemaskini').off('click').on('click', async function () {
                    $('#saveConfirmationModal11').modal('hide');
                    
                    var newUpdate = {
                        UpdateAhli: {
                            ddlPtj: $('#ddlPtjR').val(),
                            ddlStaf: $('#ddlStafR').val(),
                            ddlStatus: $('#ddlStatusR').val(),
                            txtIdNo: $('#txtIdNo').val()
                        }
                    }

                    try {
                        var result = JSON.parse(await ajaxUpdateAhli(newUpdate));
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

            async function ajaxUpdateAhli(UpdateAhli) {
                return new Promise((resolve, reject) => {
                    $.ajax({
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PENYELENGGARAAN/PenyelenggaraanWS.asmx/UpdateAhliJawatan") %>',
                       method: 'POST',
                        data: JSON.stringify(UpdateAhli),
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

        </script>
</asp:Content>