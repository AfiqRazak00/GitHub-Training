<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Kawalan_Elaun.aspx.vb" Inherits="SMKB_Web_Portal.Kawalan_Elaun" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <style>

    #permohonan .modal-body {
        max-height: 70vh;
        /* Adjust height as needed to fit your layout */
        min-height: 70vh;
        overflow-y: scroll;
        scrollbar-width: thin;
    }
    .codx {
        display: none;
        visibility: hidden;
    }

    .incolor {
        background-color: #e9ecef;
        color: #ffffff;
    }

    .xddl{
        margin-bottom:0px
    }
</style>
<link rel="stylesheet" href="../style.css" />
<div class="panel panel-default">
    <div class="panel-heading">
        <div class="modal-body">
            <div class="table-title">
                <h6>Senarai Kawalan Elaun</h6>
                <div id="btnTambah" class="btn btn-primary">
                    <i class="fa fa-plus"></i>Kawalan Elaun 
                </div>
            </div>
        </div>
        <br />
    </div>

    <div class="modal-body">
        <div class="col-md-12">
            <div class="transaction-table table-responsive">
                <table id="tblSenaraiElaun" class="table table-striped" style="width: 100%">
                    <thead>
                        <tr>
                            <th scope="col">Bil</th>
                            <th scope="col">Kod</th>
                            <th scope="col">Butiran</th>
                            <th scope="col">Status</th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div class="modal fade" id="confirmationModalSubmit" tabindex="-1" role="dialog"
        aria-labelledby="confirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalLabel">Pengesahan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Anda pasti ingin menyimpan rekod ini?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger"
                        data-dismiss="modal">
                        Tidak</button>
                    <button type="button" class="btn btn-secondary btnYaSubmit">Ya</button>
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
    <!-- Modal Add/Edit Kawalan Elaun -->
    <div class="modal fade" id="mdlKawalan" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"">Maklumat Kawalan Elaun</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">
                                <div class="form-group input-group col-md-12 col-12">
                                    <input type="text" class="kod input-group__input form-control input-sm" readonly/>
                                    <label class="input-group__label">Kod <span style="color: red">*</span></label>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                                <div class="form-group col-md-12 col-12 xddl">
                                    <div class="form-group input-group">
                                        <select class="input-group__select ui search dropdown" placeholder="" name="ddlElaun" id="ddlElaun">
                                        </select>
                                        <label class="input-group__label" for="ddlElaun">Elaun <span style="color: red">*</span></label>
                                        <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila buat pilihan</small>
                                    </div>
                                </div>
                                <div class="col-md-4 col-12">
                                    <fieldset class="pb-2 pl-2 pr-2">
                                        <legend class="w-auto" style="font-size: 11px;"><b>Status</b></legend>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="stAktif" id="stAktif1" value="1" checked>
                                            <label class="form-check-label" for="inlineRadio1">Aktif</label>
                                        </div>
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="stAktif" id="stAktif0" value="0">
                                            <label class="form-check-label" for="inlineRadio2">Tidak Aktif</label>
                                        </div>
                                    </fieldset>
                                    <small class="txtEror text-danger font-italic form-row col-md-12 col-12">Sila isi ruangan ini</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                    <button type="button" id="btnSimpan" class="btn btn-secondary">Simpan</button>

                </div>
            </div>
        </div>
    </div>
</div>
    <script>
        $(document).ready(function () {
            var isEdit = false;
            show_loader();

            $(".txtEror").addClass("codx");

            $('#ddlElaun').dropdown({
                fullTextSearch: true,
                placeholder: "Pilih Elaun",
                apiSettings: {
                    url: "KawalanElaunWS.asmx/fetchDdlElaun?q={query}",
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({ q: settings.urlData.query });
                        searchQuery = settings.urlData.query;
                        return settings;
                    },
                    onSuccess: function (response) {
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
                            $(objItem).append($('<div class="item" data-value="' + option.Butiran + '">').html(option.Butiran));
                        });

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        $(obj).dropdown('show');
                    }
                }
            });


            $('#ddlElaun').on('change', function () {
                var selectedElaun = $("#ddlElaun").val(); // Retrieve selected value from ddlKategori

                $.ajax({
                    url: "KawalanElaunWS.asmx/fetchElaunDetail",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify({ selectedElaun: selectedElaun }),
                    dataType: "json",
                    success: function (response) {
                        try {
                            var responseData = JSON.parse(response.d);

                            if (Array.isArray(responseData) && responseData.length > 0) {
                                responseData.forEach(function (item) {
                                    $(".kod").val(responseData[0].Kod_Trans);
                                });
                            }
                        } catch (error) {
                            console.error("Error parsing response:", error);
                        }
                        tbl.ajax.reload();
                    },
                    error: function (error) {
                        console.error("AJAX error:", error.responseText);
                    }
                });
            });


            $("#btnTambah").on("click", function () {
                isEdit = false;
                $("#mdlKawalan").modal('show');
                $('#ddlElaun').parent().prop('disabled', false); // Disable the dropdown
                $('#ddlElaun').parent().removeClass('disabled'); // Add a class to visually indicate that it's disabled
                $("#ddlElaun").parent().parent().removeClass('incolor');
                $('#ddlElaun').parent().removeClass("border border-danger");
                $('.kod').removeClass("border border-danger");
                $(".txtEror").addClass("codx");
                $('.kod').val("");
                $('#ddlElaun').dropdown("clear");
            });

            $('#btnSimpan').click(function () {
                var butiranElaun = $("#ddlElaun").val();
                var kodElaun = $(".kod").val();
                var statusValue = document.querySelector('input[name="stAktif"]:checked').value;

                // Check if any of the required fields are empty
                if (butiranElaun && kodElaun && statusValue) {
                    $("#mdlKawalan").modal('hide');
                    show_loader();
                    $(".txtEror").addClass("codx");

                    if (isEdit) {
                        saveData(butiranElaun, kodElaun, statusValue, isEdit);
                    }
                    else {
                        $.ajax({
                            url: "KawalanElaunWS.asmx/CheckDataExists", // Change the URL to the appropriate endpoint
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: JSON.stringify({ kodElaun: kodElaun }),
                            success: function (response) {
                                // Parse the response JSON string from 'd'
                                var data = JSON.parse(response.d);

                                if (data.length > 0) {

                                    // Update the content of the modal with the message
                                    $('#detailMakluman').html("Maklumat telah wujud.");

                                    // Show the modal
                                    $('#maklumanModal').modal('show');
                                } else {
                                    // Data doesn't exist, proceed with saving
                                    saveData(butiranElaun, kodElaun, statusValue, isEdit);
                                }
                            },
                            error: function (error) {
                                console.error("AJAX error:", error.responseText);
                            }
                        });
                        tbl.ajax.reload();
                    }
                } else {
                    // Some required fields are empty, display error message or highlight empty fields
                    const elementsToCheck = [
                        { condition: !butiranElaun, selector: "#ddlElaun" },
                        { condition: !kodElaun, selector: ".kod" }
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

            tbl = $("#tblSenaraiElaun").DataTable({
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
                    "url": "KawalanElaunWS.asmx/fetchSenaraiElaun",
                    method: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        close_loader();
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
                    { "data": "Kod_Detail" },
                    { "data": "Butiran" },
                    {
                        "data": "Status",
                        "render": function (data, type, row) {
                            // Customize the rendering based on the data
                            return data == 1 ? "Aktif" : "Tidak Aktif";
                        }
                    }
                ],
                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });

                    $(row).off('click').on('click', async function () {

                        $('#ddlElaun').dropdown("clear");
                        var data = tbl.row(this).data(); // Get data of the clicked row
                        var kodElaun = data['Kod_Detail'];
                        $(".kod").val(kodElaun);

                        $.ajax({
                            url: "KawalanElaunWS.asmx/fetchElaunRow",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            data: JSON.stringify({ kodElaun: kodElaun }),
                            dataType: "json",
                            success: function (response) {
                                try {
                                    var responseDataString = response.d; // Extract the string representation of JSON data from 'd'
                                    var responseData = JSON.parse(responseDataString); // Parse the JSON string to an array
                                    console.log("Response Data:", responseData); // Log the parsed data to check its structure and content
                                    if (responseData && responseData.length > 0) {
                                        var firstItem = responseData[0];
                                        $('#ddlElaun').dropdown("clear"); // Clear existing options
                                        $("#ddlElaun").html("<option value = '" + firstItem.Butiran + "'>" + firstItem.Butiran + "</option>");
                                        $("#ddlElaun").dropdown('set selected', firstItem.Butiran);
                                        $('#ddlElaun').parent().prop('disabled', true); // Disable the dropdown
                                        $('#ddlElaun').parent().addClass('disabled'); // Add a class to visually indicate that it's disabled
                                        $("#ddlElaun").parent().parent().addClass('incolor');

                                        // Check the radio button based on the status
                                        if (firstItem.Status == "1") {
                                            $("#stAktif1").prop("checked", true);
                                        } else if (firstItem.Status == "0") {
                                            $("#stAktif0").prop("checked", true);
                                        }
                                        isEdit = true; // Set edit mode to true
                                    } else {
                                        console.error("Empty response received from server.");
                                    }
                                } catch (error) {
                                    console.error("Error parsing response:", error);
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                console.error("AJAX error:", textStatus, errorThrown);
                            }
                        });
                        $('#ddlElaun').parent().removeClass("border border-danger");
                        $('.kod').removeClass("border border-danger");
                        $(".txtEror").addClass("codx");
                         $("#mdlKawalan").modal('show');
                    });
                }
            });
        });

        function saveData(butiranElaun, kodElaun, statusValue, isEdit) {

            $.ajax({
                url: "KawalanElaunWS.asmx/SimpanKawalanElaun",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ butiranElaun: butiranElaun, kodElaun: kodElaun, statusValue: statusValue, isEdit: isEdit }),
                success: function (response) {
                    // Handle success response from server
                    console.log('Data saved successfully:', response);

                    // Parse the response JSON string from 'd'
                    var responseData = JSON.parse(response.d);

                    // Extract the message from the responseData object
                    var message = responseData.Message;

                    // Update the content of the modal with the message
                    $('#detailMakluman').html(message);

                    // Show the modal
                    $('#maklumanModal').modal('show');
                    tbl.ajax.reload();
                },
                error: function (error) {
                    console.error("AJAX error:", error.responseText);
                }
            });
        }

    </script>
</asp:Content>
