<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Penyesuaian_Bank.aspx.vb" Inherits="SMKB_Web_Portal.Penyesuaian_Bank" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <style>
        .tabcontent {
            padding: 0px 20px 20px 20px !important;
        }

        .table-title {
            padding-top: 0px !important;
            padding-bottom: 0px !important;
        }

        .custom-table > tbody > tr:hover {
            background-color: #ffc83d !important;
        }

        #tblDataSenarai_trans td:hover {
            cursor: pointer;
        }


        .default-primary {
            background-color: #007bff !important;
            color: white;
        }


        /*start sticky table tbody tfoot*/
        table {
            overflow: scroll;
            border-collapse: collapse;
            color: white;
        }

        .secondaryContainer {
            overflow: scroll;
            border-collapse: collapse;
            height: 500px;
            border-radius: 10px;
        }

        .sticky-footer {
            position: sticky;
            bottom: 0;
            background-color: white;
            z-index: 2;
        }

            .sticky-footer th,
            .sticky-footer td {
                text-align: center; /* Center-align the content in footer cells */
                border-top: 1px solid #ddd; /* Add a border at the top to separate from data rows */
                padding: 10px; /* Adjust padding as needed */
            }

        #showModalButton:hover {
            background-color: #ffc107; /* Change background color on hover */
            color: #fff; /* Change text color on hover */
            border-color: #ffc107; /* Change border color on hover */
            cursor: pointer; /* Change cursor to indicate interactivity */
        }

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
        }

        .input-group__input {
            width: 100%;
            height: 40px;
            border: 1px solid #dddddd;
            border-radius: 5px;
            padding: 0 10px;
        }

            .input-group__input:not(:-moz-placeholder-shown) + label {
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

            .input-group__input:not(:placeholder-shown) + label, .input-group__input:focus + label {
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


        .input-group__select + label {
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

    <script>
        function ShowPopup(elm) {
            // alert(elm);

            if (elm == "1") {
                $('#permohonan').modal('toggle');

            }
            else if (elm == "2") {

                $(".modal-body input").val("");
                $('#permohonan').modal('toggle');

            }
            else if (elm == "3") {

                $(".modal-body input").val("");
                $('#viewDetail').modal('toggle');
            }

        }
    </script>

    <div id="PermohonanTab" class="tabcontent" style="display: block">

        <div class="modal-body">
            <div class="table-title">
                <h6>Proses Penyesuaian Bank</h6>
                <div class="btn btn-primary" onclick="ShowPopup('2')">
                    <i class="fa fa-plus"></i>Tambah Senarai              
               
                </div>
            </div>
            <hr>
            <div class="search-filter">
                <div class="form-row justify-content-center">
                    <div class="form-group row col-md-6">
                        <label class="col-sm-2 col-form-label" style="text-align: right">Carian :</label>
                        <div class="col-sm-10">
                            <select class="input-group__select ui search dropdown listBank" name="ddlBank" id="ddlBank" placeholder="&nbsp;">
                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
            <div class="form-row">
                <div class="modal-body">
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblDataSenarai_trans" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr>
                                        <th scope="col">Bil</th>
                                        <th scope="col">Tarikh</th>
                                        <th scope="col">No. Bank</th>
                                        <th scope="col">Nama Bank</th>
                                        <th scope="col">No.Akaun</th>
                                        <th scope="col">Baki (RM)</th>
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
 
        <div class="modal fade" id="transaksi" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title">Maklumat Penyata Bank</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-8">
                                        <input class="input-group__input " id="lblNoBank" type="text" placeholder="&nbsp;" name="lblNoBank" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="No. Bank">No. Bank</label>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <input class="input-group__input " id="lblNoAkaun" type="text" placeholder="&nbsp;" name="lblNoAkaun" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="No. Akaun">No. Akaun</label>
                                    </div>

                                </div>
                            </div>
                            <div class="col-md-12">

                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <input class="input-group__input lblIdPenyesuaian" id="lblIdPenyesuaian" type="text" placeholder="&nbsp;" name="lblIdPenyesuaian" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="ID Penyata">ID Penyata</label>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input class="input-group__input " id="lblTarikh" type="text" placeholder="&nbsp;" name="Tarikh" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Tarikh">Tarikh</label>
                                    </div>
                                    <div class="form-group col-md-3">
                                        <input class="input-group__input" id="lblBaki" type="text" placeholder="&nbsp;" name="lblBaki" readonly style="background-color: #f0f0f0" />
                                        <label class="input-group__label" for="Baki (RM)">Baki (RM)</label>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <p style="margin-bottom:unset">Tapisan Tarikh:</p>
                                    <div class="col-md-6">
                                    <div class="card">
                                        <div class="form-group" style="margin-top: 10px; margin-left: 10px">
                                             <input type="date" name="txtTarikh" id="txtTarikh" class="form-control underline-input txtTarikh" />
                                        </div>
                                         <button type="button" class="btn btn-success btnProses" data-toggle="tooltip" data-placement="bottom">Proses</button>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>

                        <hr>
                  
                    </div>
                <%--    <div class="modal-footer modal-footer--sticky" style="padding: 0px!important">
                      
                        <button type="button" class="btn btn-success btnProses" data-toggle="tooltip" data-placement="bottom">Simpan</button>


                    </div>--%>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal -->
    <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-l" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalCenterTitle">Tambah Penyata Bank</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h6>Maklumat Penyata Bank</h6>
                    <hr>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-row">
                                <div class="form-group col-md-12">
                                    <select class="input-group__select ui search dropdown listBankM" name="ddlBankM" id="ddlBankM" placeholder="&nbsp;">
                                    </select>
                                    <label class="input-group__label" for="ddlBank">No. Bank</label>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">

                                    <input class="input-group__input form-control " id="txtTarikhPenyata" type="date" placeholder="&nbsp;" name="Tarikh Penyata Bank" />
                                    <label class="input-group__label" for="Tarikh Penyata Bank">Tarikh Penyata Bank</label>
                                </div>
                                <div class="form-group col-md-6">
                                    <input class="input-group__input form-control " id="txtBakiPenyata" type="text" placeholder="&nbsp;" name="Baki" />
                                    <label class="input-group__label" for="baki">Baki (RM)</label>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <input class="input-group__input form-control " id="txtIdPenyata" type="text" placeholder="&nbsp;" style="visibility: collapse" />
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                    <button type="button" class="btn btn-setsemula btnSet">Rekod Baru</button>
                    <button type="button" class="btn btn-success btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>

                </div>
            </div>

        </div>
    </div>

    <!-- Confirmation Modal  -->
    <div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog" aria-labelledby="confirmationModalLabel" aria-hidden="true">
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
                    <button type="button" class="btn default-primary btnYa" runat="server">Ya</button>
                </div>
            </div>
        </div>
    </div>

        <!-- Confirmation Modal  -->
    <div class="modal fade" id="confirmationModal_Dtl" tabindex="-1" role="dialog" aria-labelledby="confirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmationModalLabel_Dtl">Pengesahan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Anda pasti ingin proses rekod ini?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger"
                        data-dismiss="modal">
                        Tidak</button>
                    <button type="button" class="btn default-primary btnYa_Dtl" runat="server">Ya</button>
                </div>
            </div>
        </div>
    </div>

        <!-- Makluman Modal Bil -->
    <div class="modal fade" id="maklumanModal_Dtl" tabindex="-1" role="dialog"
        aria-labelledby="maklumanModalLabel-Dtl" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="maklumanModalLabel_Dtl">Makluman</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <span id="detailMakluman_Dtl"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn default-primary" id="tutupMakluman_Dtl"
                        data-dismiss="modal">
                        Tutup</button>
                </div>
            </div>
        </div

    <!-- Makluman Modal Bil -->
    <div class="modal fade" id="maklumanModalBil" tabindex="-1" role="dialog"
        aria-labelledby="maklumanModalLabelBil" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="maklumanModalLabelBil">Makluman</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <span id="detailMaklumanBil"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn default-primary" id="tutupMaklumanBil"
                        data-dismiss="modal">
                        Tutup</button>
                </div>
            </div>
        </div>
    </div>



    <script>

        $(document).ready(function () {
            // alert("test")
            $('#ddlBank').dropdown({
                fullTextSearch: false,
                onChange: function (value, text, $selectedItem) {



                    isClicked = true;
                    tbl.ajax.reload();



                },
                apiSettings: {
                    url: 'PenyataBank_WS.asmx/GetBank?q={query}',
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

                        //if (searchQuery !== oldSearchQuery) {
                        // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
                        //}

                        //oldSearchQuery = searchQuery;

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        /*if (shouldPop === true)*/ {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });

            $('#ddlBankM').dropdown({
                fullTextSearch: false,
                apiSettings: {
                    url: 'PenyataBank_WS.asmx/GetBank?q={query}',
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

                        /*if (shouldPop === true)*/ {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });
        });

        var tableID = "#tblData";
        var tbl = null
        var isClicked = false;

        $(document).ready(function () {

            tbl = $("#tblDataSenarai_trans").DataTable({
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
                    "url": "PenyataBank_WS.asmx/LoadOrderRecord_SenaraiTransaksi",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter date bermula dari sini - 20 julai 2023
                        var kodBank = $('#ddlBank').val()

                        return JSON.stringify({
                            strKodBank: kodBank,
                            isClicked: isClicked,
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
                        rowClickHandler(data.Pyt_Id);

                    });
                },
                "columns": [
                    {
                        "data": "Kod_bank",
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        },
                        "width": "5%"
                    },
                    { "data": "Tkh_Pyt" },
                    { "data": "Kod_bank" },
                    { "data": "Nama_Bank" },
                    { "data": "No_Akaun" },
                    { "data": "Baki_Pyt" }

                ]

            });

        });

        // add clickable event in DataTable row
        async function rowClickHandler(id) {

            if (id !== "") {

                //console.log("rows: " + id)

                // modal dismiss
                $('#transaksi').modal('toggle');

                ////BACA HEADER JURNAL
                var recordHdr = await AjaxGetRecordHdr(id);
                await AddRowHeader(null, recordHdr);

                ////BACA DETAIL JURNAL
                var record = await AjaxGetRecordDtl(id);
                await clearAllRows();
                await AddRow(null, record);

                AddRow(5);
            }
        }

        async function AjaxGetRecordDtl(id) {

            try {

                const response = await fetch('PenyataBank_WS.asmx/LoadRecordDtl', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ id: id })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        $('.btnSimpan').click(async function () {

            $('#confirmationModal').modal('toggle');

        })

        $('.btnProses').click(async function () {

            $('#confirmationModal_Dtl').modal('toggle');

        })

        $('.btnYa').click(async function () {

            $('#confirmationModal').modal('toggle');

            var jumRecord = 0;
            var acceptedRecord = 0;
            var msg = "";
            var newOrder = {
                order: {

                    Id: $('#txtIdPenyata').val(),
                    Bank: $('#ddlBankM').val(),
                    Tarikh: $('#txtTarikhPenyata').val(),
                    Jumlah: $('#txtBakiPenyata').val()

                }
            }


            var result = JSON.parse(await ajaxSaveOrder(newOrder));

            if (result.Status !== "Failed") {

                // open modal makluman and show message
                $('#maklumanModalBil').modal('toggle');
                $('#detailMaklumanBil').html(result.Message);

                await clearAllRows();


                // refresh page after 2 secondss
                setTimeout(function () {
                    tbl.ajax.reload();
                }, 2000);
            } else {
                // open modal makluman and show message
                $('#maklumanModalBil').modal('toggle');
                $('#detailMaklumanBil').html(result.Message);
            }

        });

        $(function () {
            $('.btnAddRow.five').click();
        });

        $('.btnYa_Dtl').click(async function () {

            $('#confirmationModal_Dtl').modal('toggle');

            var jumRecord = 0;
            var acceptedRecord = 0;
            var msg = "";
            var newOrder = {
                order: {
                    IdPenyata: $('#lblIdPenyesuaian').val(),
                    Tarikh: $('#txtTarikh').val()

                }
            }

            console.log("xx" + $('#lblIdPenyesuaian').val())
      

            var result = JSON.parse(await ajaxSaveOrder_Dtl(newOrder));

            if (result.Status !== "Failed") {

                // open modal makluman and show message
                $('#maklumanModal_Dtl').modal('toggle');
                $('#detailMakluman_Dtl').html(result.Message);

                await clearAllRows();


                // refresh page after 2 secondss
                setTimeout(function () {
                    tbl.ajax.reload();
                }, 2000);
            } else {
                // open modal makluman and show message
                $('#maklumanModal_Dtl').modal('toggle');
                $('#detailMakluman_Dtl').html(result.Message);
            }

        });

        async function clearAllRows() {

            $('#ddlBankM').dropdown('clear');
            $('#ddlBankM').dropdown('refresh');

            $('#txtTarikhPenyata').val("");
            $('#txtBakiPenyata').val("0.00");

            var tableID = "#tblData";
            $(tableID + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })

        }

        $('.btnSet').click(async function () {
            clearAllRows()
        })


        async function ajaxSaveOrder(order) {
            //console.log(order)
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'PenyataBank_WS.asmx/SaveOrders',
                    method: 'POST',
                    data: JSON.stringify(order),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                        //alert(resolve(data.d));
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }

                });
            })

        }



        $('.btnAddRow').click(async function () {
            var totalClone = $(this).data("val");

            await AddRow(totalClone);
        });

        var curNumObject = 0;

        async function AddRow(totalClone, objOrder) {

            show_loader();
            var counter = 1;
            var table = $('#tblData');

            if (objOrder !== null && objOrder !== undefined) {
                //totalClone = objOrder.Payload.OrderDetails.length;
                totalClone = objOrder.Payload.length;
            }
          
            while (counter <= totalClone) {

                curNumObject += 1;
          

                var row = $('#tblData tbody>tr:first').clone();

            

                row.attr("style", "");

                // Clear existing data in the cloned row
                row.find('input, select, textarea').val('');

                // Set default values for debit and kredit columns
                row.find('.Debit').val('0.00').prop('disabled', false);
                row.find('.Kredit').val('0.00').prop('disabled', false);


                $('#tblData tbody').append(row);


                if (objOrder !== null && objOrder !== undefined) {
                 
                    if (counter <= objOrder.Payload.length) {
                        await setValueToRow_Transaksi(row, objOrder.Payload[counter - 1]);

                    }
                }
                counter += 1;
            }

            close_loader();
        }

        async function setValueToRow_Transaksi(row, orderDetail) {

            //console.log(orderDetail)
            var txtTarikh = $(row).find("td > .txtTarikh");
            txtTarikh.val(orderDetail.Tkh_Transaksi);

            var txtRujukan = $(row).find("td > .Rujukan");
            txtRujukan.val(orderDetail.Rujukan);
      
            var txtButiran = $(row).find("td > .Perkara");
            txtButiran.val(orderDetail.Butiran);

            var txtDebit = $(row).find("td > .Debit");
            txtDebit.val(orderDetail.Debit);

            var txtKredit = $(row).find("td > .Kredit");
            txtKredit.val(orderDetail.Kredit);

            var txtBaki = $(row).find("td > .Baki");
            txtBaki.val(orderDetail.Baki);

            //await calculateGrandTotal();

        }

        async function clearAllRows() {
            $(tableID + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
         
        }

        async function AjaxGetRecordHdr(id) {

            try {

                const response = await fetch('PenyataBank_WS.asmx/LoadHdrPenyata', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ id: id })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        async function AddRowHeader(totalClone, objOrder) {
            var counter = 1;
            //var table = $('#tblDataSenarai');

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;
            }


            if (counter <= objOrder.Payload.length) {
                await setValueToRow_HdrPenyata(objOrder.Payload[counter - 1]);
            }
            // console.log(objOrder)
        }

        async function setValueToRow_HdrPenyata(orderDetail) {

            $('#lblNoBank').val(orderDetail.Nama_Bank)
            $('#lblNoAkaun').val(orderDetail.No_Akaun)
            $('#lblIdPenyesuaian').val(orderDetail.Pyt_Id)
            $('#lblTarikh').val(orderDetail.Tkh_Pyt)
            $('#lblBaki').val(orderDetail.Baki_Pyt)
                    

        }

        $(tableID).on('keyup', '.Debit , .Kredit', async function () {
            // Initialize sum variables
            var totalDebit = 0;
            var totalKredit = 0;

            var curTR = $(this).closest("tr");

            var debit_ = $(curTR).find("td > .Debit");
            var rowDebit = NumDefault(debit_.val())


            var kredit_ = $(curTR).find("td > .Kredit");
            var rowKredit = NumDefault(kredit_.val())

            // Convert rowDebit and rowKredit to numbers
            rowDebit = parseFloat(rowDebit);
            rowKredit = parseFloat(rowKredit);

            // Accumulate Debit and Kredit values
            totalDebit += parseFloat(rowDebit);
            totalKredit += parseFloat(rowKredit);

            //$('#totalDbt').val(totalDebit);
           // $('#totalKt').val(totalKredit);
            // Calculate the sum for the row
            var rowSum = 0;
            //var BakiAwal = 0;

            // Get the "txtbaki" value from the previous row (if it's not the first row)
            var prevRowBaki = 0;
            
            console.log("Before if statement:", $(curTR).prev("tr").length);

            if ($(curTR).prev("tr").length > 0) {
                //console.log("a")
                // It's not the first row
                prevRowBaki = NumDefault($(curTR).prev("tr").find("td > .Baki").val());
                prevRowBaki = parseFloat(prevRowBaki);

                // Check if Debit or Kredit is inserted and update Baki accordingly
                if (rowDebit > 0) {
                    rowSum = rowDebit + prevRowBaki;
                } else if (rowKredit > 0) {
                    rowSum = prevRowBaki - rowKredit;
                }
                var txtBaki = $(curTR).find("td > .Baki");
                txtBaki.val(rowSum);

                $('#totalBakiAkhir').val(rowSum);
               

            } else {
                //console.log("b")
                // It's the first row
                var BakiAwal_ = $('#lblBaki').val();
         
                //BakiAwal = parseFloat(BakiAwal_) + rowDebit;

                if (rowDebit > 0) {
                    rowSum = rowDebit + parseFloat(BakiAwal_);
                } else if (rowKredit > 0) {
                    rowSum = parseFloat(BakiAwal_) - rowKredit;
                }

                var txtBaki = $(curTR).find("td > .Baki");
                txtBaki.val(rowSum);
                $('#totalBakiAkhir').val(rowSum);               
            }


            // Check if Debit is entered
            if (rowDebit > 0) {
                // Disable Kredit input if Debit is entered
                kredit_.prop('disabled', true);
                debit_.Val = "0.00"
            } else {
                // Enable Kredit input if Debit is not entered
                kredit_.prop('disabled', false);
                debit_.Val = "0.00"
            }

            // Check if Kredit is entered
            if (rowKredit > 0) {
                // Disable Debit input if Kredit is entered
                debit_.prop('disabled', true);
               
            } else {
                // Enable Debit input if Kredit is not entered
                debit_.prop('disabled', false);
                
            }

            //// Set the value to 0 if the user clears the input
            debit_.val(rowDebit || "0.00");
            kredit_.val(rowKredit || "0.00");

        });

        function NumDefault(theVal) {

            return setDefault(theVal, 0)
        }

        function setDefault(theVal, defVal) {

            if (defVal === null || defVal === undefined) {
                defVal = "";
            }

            if (theVal === "" || theVal === undefined || theVal === null) {
                theVal = defVal;
            }
            return theVal;
        }

        async function ajaxSaveOrder_Dtl(order) {

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'PenyataBank_WS.asmx/Proses_BR',
                    method: 'POST',
                    data: JSON.stringify(order),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                        //alert(resolve(data.d));
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }

                });
            })

        }

        $("#savedokumen").on("click", function (evt) {
            evt.preventDefault();
            saveAndUploadFile();

        });

        function saveAndUploadFile() {         
          
            var fileInput = document.getElementById("uploadDokumen");
            var file = fileInput.files[0];

            if (!file) {
                showModalLampiran("Muatnaik fail", "Sila pilih fail yang hendak dimuatnaik.");
                return;
            }

            var fileSize = file.size;
            var maxSize = 5 * 1024 * 1024; // Maximum size in bytes (5MB)

            if (fileSize > maxSize) {
                showModalLampiran("Saiz Fail Besar", "Saiz fail melebihi had maksimum 5MB.");
                return;
            }

            var fileName = file.name;
            var fileExtension = fileName.split('.').pop().toLowerCase();

            if (fileExtension !== 'csv') {
                showModalLampiran("Fail Salah Format", "Hanya format CSV sahaja dibenarkan.");
                return;
            }

            var requestData = {                             
                fileName: fileName
            };

            var IdPenyesuaian = $('.lblIdPenyesuaian').val();

            //alert("test " + IdPenyesuaian)
            var formData = new FormData();           
            formData.append("file", file);
            formData.append("fileName", fileName);
            formData.append("nomohon", IdPenyesuaian);

           

            $.ajax({
                url: '<%= ResolveClientUrl("~/FORMS/PENYESUAIAN BANK/PENYATA BANK/PenyataBank_WS.asmx/SaveAndUploadFile") %>',
                    data: formData,
                    cache: false,
                    contentType: false,
                    type: 'POST',
                    processData: false,
                    success: function (response) {
                        //showModalLampiran("Berjaya Simpan", "Fail berjaya disimpan di pangkalan data.");
                        //tblLampiran.ajax.reload();
                    },
                    error: function () {
                        //showModalLampiran("Tidak Berjaya Simpan", "Sila cuba simpan semula.");
                    }
                });
        }


    </script>


    </div>
</asp:Content>
