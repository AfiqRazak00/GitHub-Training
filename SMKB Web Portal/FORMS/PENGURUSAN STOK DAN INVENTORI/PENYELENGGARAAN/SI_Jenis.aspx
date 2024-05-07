<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="SI_Jenis.aspx.vb" Inherits="SMKB_Web_Portal.SI_Jenis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">


    <style>
        /*input CSS */
        .input-group {
            margin-bottom: 20px;
            position: relative;
        }

           .left-align {
            text-align: left;
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

           .xddl{
       margin-bottom:0px
   }
    </style>
    <%--------------------------------------------------  Start Header----------------------------------------------%>
    <div class="panel panel-default">
        <div class="panel-heading">
            <div class="modal-body">
                <div class="table-title">
                    <h6>Senarai Jenis Stok</h6>
                    <div id="btnTambah" class="btn btn-primary btnJenisStok" onclick="ShowPopup('1')">
                        <i class="fa fa-plus"></i>Jenis Stok 
                               
                    </div>
                </div>
            </div>
            <br />
        </div>
        <%------------------------------------------------  End Header ------------------------------------------------%>

        <%----------------------------------------------------Start PopUp for +Jenis Stok ----------------------------------%>
        <div class="modal fade" id="modalJenisStok" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                                <h5 class="modal-title"">Maklumat Jenis Stok</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                 <div class="form-row">
                                     
                                     <div class="form-group col-md-12 col-12 xddl" >
                                        <div class="form-group input-group">
                                            <input class="kodjenis input-group__input form-control input-sm" placeholder="" id="txtKod" name="txtKod" readonly />
                                                <label class="input-group__label">Kod Jenis</label>
                                        </div>
                                        <div class="form-group input-group">
                                            <select class="kategori input-group__select ui search dropdown" placeholder="" name="ddlKategori" id="ddlKategori"></select>
                                            <label class="input-group__label">Kategori <span style="color: red">*</span></label>
                                        
                                        </div>
                                        <div class="form-group input-group">
                                            <input type="text" class="butiran input-group__input form-control input-sm " placeholder="" id="txtButiran" name="txtButiran" />
                                            <label class="input-group__label">Butiran<span style="color: red">*</span></label>
                                        </div>
                                     </div>
                                </div>
                        </div>
                    </div>
                        </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group col-md-6">
                                   <label>Status <span style="color:red">*</span></label>
                                <div id="rblStatus">
                                    <input type="radio" name="rblStatus" value="1" id="rblStatus_0" checked="checked">
                                    <label for="rblStatus_0">Aktif</label>
                                    <input type="radio" name="rblStatus" value="0" id="rblStatus_1">
                                    <label for="rblStatus_1">Tidak Aktif</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                        <button type="button" runat="server" id="lbtnSimpan" class="btn btn-secondary lbtnSimpan">Simpan</button>
                    </div>
                </div>
            </div>
        </div>
        <%-----------------------------------------------End PopUp for +Jenis Stok ---------------------------------------------%>

        <%----------------------------------------------Start 2nd pop up For Update-----------------------------------------%>
        <div class="modal fade" id="modalJenisStok2" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="titleMklmtJenisStok2">Kemaskini Jenis Stok</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                          <div class="row">
                             <div class="col-md-12">
                                 <div class="form-row">
                                     <div class="form-group col-md-12 col-12 xddl">
                                        <div class="form-group input-group">
                                            <input type="text" class="kodjenis input-group__input form-control input-sm " placeholder="" id="txtKod2" name="txtKod" />
                                            <label class="input-group__label">Kod Jenis<span style="color:red">*</span></label>
                                        </div>
                                        <div class="form-group input-group">
                                            <select class="kategori input-group__select ui search dropdown" placeholder="" name="ddlKategori" id="ddlKategori2"></select>
                                            <label class="input-group__label">Kategori <span style="color:red">*</span></label>
                                        </div>
                                        <div class="form-group input-group">
                                            <input type="text" class="butiran2 input-group__input form-control input-sm " placeholder="" id="txtButiran2" name="txtButiran" />
                                            <label class="input-group__label">Butiran<span style="color:red">*</span></label>
                                        </div>
                                    </div>

                                     <label>Status<span style="color:red">*</span></label>
                                      <div class="col-md-12 col-12">
                                          <div class="form-check form-check-inline">
                                            <div id="rblStatus2">
                                                <input type="radio" name="rblStatus2" value="1" id="rblStatus1">
                                                <label for="rblStatus_0">Aktif</label>
                                                <input type="radio" name="rblStatus2" value="0" id="rblStatus0">
                                                <label for="rblStatus_1">Tidak Aktif</label>
                                                </div>
                                              </div>
                                          </div>
                                            </div>
                                        </div>
                                    </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger btnPadam" data-dismiss="modal">Tutup</button>
                                    <button type="button" class="btn btn-secondary btnUpdate" id="btnUpdate"
                                        data-toggle="tooltip" data-placement="bottom"
                                        title="Kemaskini">
                                        Simpan</button>
                                </div>
                    </div>
                </div>
            </div>
        </div>
        <!------------------------------------------ Modal Pengesahan Update------------------------------------------>
        <div class="modal fade" id="updateConfirmationModal1" tabindex="-1" role="dialog" aria-labelledby="updateConfirmationModalLabel">
            <div class="modal-dialog " role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="updateConfirmationModalLabel1">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="updateConfirmationMessage1"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="confirmUpdateButton1">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <%--------------------------------------------End 2nd pop up For Update------------------------------------%>

        <%--------------------------------------------- Start DataTable--------------------------------------------%>
        <div class="modal-body">
            <div class="col-md-12">
                <div class="transaction-table table-responsive">
                    <table id="tblDataJenisStok" class="table table-striped" style="width: 100%">
                        <thead>

                            <tr data-id="idJenisStok">
                                <th scope="col"  style="width: 10%; text-align:center;">Bil</th>
                                <th scope="col"  style="width: 10%; text-align:center;">Jenis</th>
                                <th scope="col"  style="width: 40%; text-align:center;">Butiran</th>
                                 <th scope="col"  style="width: 20%; text-align:center;">Kategori</th>
                                <th scope="col"  style="width: 20%; text-align:center;">Status</th>
                            </tr>
                        </thead>
                        <tbody id="ShowPopup('2')">
                            <tr style="width: 100%" class="table-list">
                                <td style="width: 10%"></td>
                                <td style="width: 10%"></td>
                                <td style="width: 40%"></td>
                                <td style="width: 20%"></td>
                                <td style="width: 20%"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <%----------------------------------- Start Confirmation Modal For +Jenis Stok---------------------------------------%>
        <div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog" aria-labelledby="confirmationModalLabel"
            aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmationModalLabel">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <span id="confirmationModal2"></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="btnNo" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" id="btnYes">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <%---------------------------------------- End Confirmation Modal For +Jenis Stok--------------------------------------%>

       
        <%------------------------------------------------End DataTable---------------------------------------%>

        <%------------------------------------------- Start Makluman Modal ----------------------------------%>
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
    <%---------------------------------------------End Makluman Modal ----------------------------------------%>

    <%-------------------------------------------Start popup elements-----------------------------------------%>
    <script type="text/javascript">
        var isClicked = false;
        document.getElementById("txtKod").addEventListener("keydown", function (event) {
            event.preventDefault();
        });

        //Run init
        init();

        function init() {
            loadSenarai();
        }


        function ShowPopup(elm) {

            if (elm == "1") {
                clearAndEnableEdit()
                $('#modalJenisStok').modal('toggle');
                $("#txtKod").prop("disabled", true).addClass('incolor');

            }
            else if (elm == "2") {
                $(".modal-body div").val("");
                $('#modalJenisStok2').modal('toggle');


                $('.btnSearch').click();

                $('.btnEmel').show();
                $('.btnCetak').show();
            }
        }
        /*----------------------------------------End popup elements------------------------------------*/

        /*-----------------------------------------------------Start data table elements-------------------------------------------*/
        var bil = 0;
        var curTblRow = 0;
        var targetId = "";
        var tbl = null

        function isSet(value) {
            if (value === null || value === '' || value === undefined) {
                return false;
            } else {
                return true;
            }
        }

        $(document).ready(function () {

            var isClicked = false;


            tbl = $("#tblDataJenisStok").DataTable({
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


                /*---------------------Start Calling data for edit button to showing data in the popup------------------*/
                "rowCallback": async function (row, data, index) {

                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });


                    $(row).off('click').on('click', async function () {
                        curTblRow = index;

                        clearAndEnableEdit();
                        var value = data.Id;
                        targetId = value;
                        var rdata = await ajaxPost("SI_Jenis_WS.asmx/GetSelectedRow", { kod: value }, false);
                        debugger
                        if (rdata.Status) {
                            var dt = rdata.Payload[0];
                            $('.kategori').val(dt.Kod_Kategori);
                            buildDdl('ddlKategori2', dt.Kod_Kategori, dt.ButiranKat);
                            $("#txtButiran2").val(dt.Butiran);
                            $(".kodjenis").val(dt.Id);
                            $("#rblStatus" + dt.Status).prop('checked', true);



                            isEdit = true;

                            $("#txtKod2").prop("disabled", true).addClass('incolor');
                            $('#modalJenisStok2').modal('toggle').show();
                        }

                        //Disable Jenis Pinjaman & Tahun Layak
                    });

                },
                /*--------------- ENd calling data for edit button--------------- */

                /* ----------------- Starrt configure for the datatable elements-----------*/
                "columnDefs": [
                    // Header center align
                    { className: "dt-head-center", targets: [0, 1, 2, 3, 4] },
                    //// Amaun semua right align
                    //{ className: "dt-body-right", targets: [0, 1, 2, 3, 4, 5] },
                    // Col yg bukan butiran center align
                    { className: "dt-body-center", targets: [0, 1, 2, 3, 4] },
                ],
                "columns": [
                    {
                        "data": "Bil",
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        },
                    },
                    {
                        "data": "Id",
                    },
                    {
                        "data": "Butiran",
                        "render": function (data, type, row, meta) {
                            return '<div class="left-align">' + data + '</div>'; // Apply class for left alignment
                        }
                    }, // Apply class for left alignment

                    {
                        "data": "ButiranKat", 
                    },

                    {
                        "data": "Status",
                        "render": function (data) {
                            if (data == 1) {
                                return 'Aktif';
                            } else if (data == 0) {
                                return 'Tidak Aktif';
                            } else {
                                return 'Data Error';
                            }
                        },
                        //    "width": "10%"
                    }

                ]
            })
        });
        /* -------------------------------------- End configure for the datatable elements---------------------*/
        /*-----------------------------------End data table elements---------------------------------------*/



        /*  ------------------------------------------- End dropdown for search button-------------------------------------------*/

        /* --------------------------------------------Start DropDown Search Kod_Kategori------------------------------------ */
        $(document).ready(function () {
            // alert("test")
            $('#ddlKategori').dropdown({
                fullTextSearch: false,
                apiSettings: {
                    url: 'SI_Jenis_WS.asmx/GetKategori?q={query}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,

                    beforeSend: function (settings) {

                        settings.data = JSON.stringify({ q: settings.urlData.query });

                        searchQuery = settings.urlData.query;
                        return settings;
                    },
                    onSuccess: function (response) {

                        console.log("response: ", response)

                        var obj = $(this);

                        var objItem = $(this).find('.menu');
                        $(objItem).html('');


                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        $.each(listOptions, function (index, option) {
                            console.log("Value", option);
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.Butiran));
                        });


                        $(obj).dropdown('refresh');

                        {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });
        });
        /*------------------------------------------End DropDown Search Kod_Kategori------------------------------------------------*/


        /*----------------------------------------- Start dropdown for edit Kod_Kategori button----------------------------------- */
        $(document).ready(function () {

            $('#ddlKategori2').dropdown({
                fullTextSearch: false,
                apiSettings: {
                    url: 'SI_Jenis_WS.asmx/GetKategori?q={query}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,

                    beforeSend: function (settings) {

                        settings.data = JSON.stringify({ q: settings.urlData.query });

                        searchQuery = settings.urlData.query;
                        return settings;
                    },
                    onSuccess: function (response) {

                        console.log("response: ", response)

                        var obj = $(this);

                        var objItem = $(this).find('.menu');
                        $(objItem).html('');


                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        $.each(listOptions, function (index, option) {
                            console.log("Value", option);
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.Butiran));
                        });


                        $(obj).dropdown('refresh');

                        {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });
        });
        /*----------------------------------------End dropdown for edit Kod_Kategori button---------------------------------------------------*/

        /*--------------------------------------Start submit data ---------------------------------------------*/
        $('.lbtnSimpan').click(async function () {
            // Check if any of the required fields is empty
            $('#modalJenisStok').modal('hide');

            if ($("#txtButiran").val() == "" || $('#ddlKategori').val() == "" || $("input[name='rblStatus']:checked").length === 0) {
                $('#maklumanModal').modal('toggle');

                $('#detailMakluman').html("Sila isi semua ruangan yang bertanda *");
            } else {
                $('#modalJenisStok').modal('toggle').hide();
                $('#confirmationModal').modal('toggle');
                $('#confirmationModal2').html("Adakah anda ingin menyimpan maklumat?");
            }
        });

        $('.lbtnKemaskini').click(async function () {
            $('#confirmationModal').modal('toggle');

        });


        $('#btnYes').on('click', async function () {
            // Close modal confirmation
            $('#modalJenisStok').modal('hide');

            $('#confirmationModal').modal('toggle');
            debugger
            var postDt = {
                //Jenis: viewDt($('.kodjenis').val(), 'text'),
                Ketegori: viewDt($('#ddlKategori').val(), 'text'),
                Butiran: viewDt($('.butiran').val(), 'text'),
                Status: viewDt($("input[name='rblStatus']:checked").val(), 'int'),
                TargetId: viewDt(targetId.toString(),'text')
            };

            var data = await ajaxPost("SI_Jenis_WS.asmx/SaveJenisStok", postDt, false);
            if (data.Status) {
                //Reload Table
                //$('#modalJenisStok').modal('hide');


                //loadSenarai();

                //$("#detailMakluman").text(data.Message);
                //$("#maklumanModal").modal('show'); 
                loadSenarai();
                $("#detailMakluman").text(data.Message);
                $("#maklumanModal").modal('show');
            } else {
                $("#detailMakluman").text(data.Message);
                $("#maklumanModal").modal('show');
            }


            // Handle the "No" button click
            $('#btnNo').on('click', function () {
                $('#confirmationModal').modal('hide');
            });
        });



        /*--------------------------End submit data-------------------------------------*/

        /* ----------------------UPDATE DATA JenisStok START ---------------------------*/
        $('#btnUpdate').off('click').on('click', async function () {
            $('#modalJenisStok2').modal('hide');
            debugger
            var postDt = {
                Jenis: viewDt($('.kodjenis').val(), 'text'),
                Ketegori: viewDt($('.kategori').val(), 'text'),
                Butiran: viewDt($('.butiran2').val(), 'text'),
                Status: viewDt($("input[name='rblStatus2']:checked").val(), 'int'),
            };
            var data = await ajaxPost("SI_Jenis_WS.asmx/Update_JenisStok", postDt, false);

            if (data.Status) {
                loadSenarai();
                $("#detailMakluman").text(data.Message);
                $("#maklumanModal").modal('show');
            }




        });

        function showUpdateModal1(title, message, type) {
            $('#updateResultUpdateModalTitle1').text(title);
            $('#updateResultModalMessage1').text(message);
            if (type === "success") {
                $('#updateResultModal1').removeClass("modal-error").addClass("modal-success");
            } else if (type === "error") {
                $('#updateResultModal1').removeClass("modal-success").addClass("modal-error");
            }
            $('#updateResultModal1').modal('show');
        }

        // ---------------------- UPDATE DATA JenisStok END -------------------------
        function clearAndEnableEdit() {
            //Clear Field
            $('#modalJenisStok .input-group__select select').each(function () {
                var tempSlctr = $(this).val();
                if (isSet(tempSlctr)) {
                    $(this).dropdown("clear");
                }
                $(this).parent().removeClass("border border-danger");
            });
            $('#modalJenisStok .input-group__input').each(function () {
                $(this).val(''); // Set the value to an empty string
                $(this).removeClass("border border-danger");
            });


            //Enable Field
            $('#modalJenisStok .input-group__select select').each(function () {
                $(this).parent().removeClass('disabled');
                $(this).parent().parent().removeClass('incolor')
            });
            $('#modalJenisStok .input-group__input').each(function () {
                $(this).prop('disabled', false).prop('readonly', false);
            });
        }

        async function loadSenarai() {

            var data = await ajaxPost("SI_Jenis_WS.asmx/FetchSenarai", {}, true);

            if (isSet(data)) {
                tbl.clear();
                tbl.rows.add(data.Payload).draw();
                //var rowCount = tbl.rows().count();
            }
        }

        function viewDt(value, type) {
            var result = '';
            if (type == 'text') {
                (isSet(value)) ? result = value : result = ''
            } else if (type == 'int') {
                (isSet(value)) ? result = value : result = '0'
            } else if (type == 'double') {
                (isSet(value)) ? result = value : result = '0.00'
            }

            return result;
        }
        async function ajaxPost(url, postData, enableLoader, fn) {
            if (enableLoader) show_loader();

            var dtToString = JSON.stringify(postData);

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: url,
                    method: "POST",
                    dataType: "json",
                    data: JSON.stringify({ postData: dtToString }),
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        result = JSON.parse(data.d);
                        if (fn !== null && fn !== undefined) {
                            fn(result);
                        }
                        if (enableLoader) close_loader();
                        resolve(result);
                    },
                    error: function (xhr, status, error) {
                        if (enableLoader) close_loader();
                        console.error("Error fetching details:" + error);
                        reject(false);
                    }
                });
            })
        }

        function buildDdl(id, kodVal, txtVal) {
            if (isSet(kodVal) && isSet(txtVal)) {
                $("#" + id).html("<option value = '" + kodVal + "'>" + txtVal + "</option>")
                $("#" + id).dropdown('set selected', kodVal);
            }
        }


    </script>
</asp:Content>
