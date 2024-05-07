<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="SENARAI_PT_BAYAR.aspx.vb" Inherits="SMKB_Web_Portal.SENARAI_PT_BAYAR" %>

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
            min-width: 80%;
            top: 0px;
            left: 0px;
        }
    </style>

    <div id="PermohonanTab" class="tabcontent" style="display: block">
        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">SENARAI PESANAN TEMPATAN SUDAH BAYAR</h5>

                    </div>

                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <%--<div class="form-row">
                            <div class=" row col-md-6">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <select id="txtKaedahCarian" class="custom-select input-group__select ui search dropdown">
                                            <option value="1" selected="PT">PT</option>
                                            <option value="4">Pembekal</option>
                                        </select>
                                        <label class="input-group__label" for="PanelJaw">Kaedah Carian :</label>
                                    </div>
                                </div>

                            </div>
                            <div class=" row col-md-6 Pembekal">
                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <input class="input-group__input form-control right_radius" id="txtPembekal" type="text" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: white;" />
                                        <label class="input-group__label" for="txtMasa_Lawatan">Bulan/Tahun :</label>
                                        <button id="btnBLN_THN" runat="server" class="btn btn-outline btnSearch left_radius" type="button"><i class="fa fa-search"></i>Cari</button>
                                    </div>
                                </div>

                            </div>
                            <div class=" row col-md-6 No_PT">

                                <div class="col-sm-12">
                                    <div class="input-group">
                                        <input class="input-group__input form-control right_radius" id="txtNoP_T" type="text" placeholder="&nbsp;" name="txtMasa_Lawatan:" style="background-color: white;" />
                                        <label class="input-group__label" for="txtMasa_Lawatan">No PT :</label>
                                        <button id="btnNoPT"  class="btn btn-outline btnSearch left_radius" data-toggle="tooltip" data-placement="bottom" title="Draft"><i class="fa fa-search"></i>Cari</button>

                                    </div>
                                </div>

                            </div>


                        </div>--%>
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
                                <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align: right">Carian :</label>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <select id="categoryFilter" class="custom-select">
                                            <option value="">SEMUA</option>
                                            <option value="1" selected="selected">Hari Ini</option>
                                            <option value="2">Semalam</option>
                                            <option value="3">7 Hari Lepas</option>
                                            <option value="4">30 Hari Lepas</option>
                                            <option value="5">60 Hari Lepas</option>
                                            <option value="6">Pilih Tarikh</option>
                                        </select>
                                        <div class="input-group-append">
                                            <button id="btnSearch" runat="server" class="btn btn-outline btnSearch" type="button">
                                                <i class="fa fa-search"></i>
                                                Cari
                           
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="form-row">
                                        <div class="form-group col-md-5">
                                            <br />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-11">
                                    <div class="form-row">
                                        <div class="form-group col-md-1">
                                            <label id="lblMula" style="text-align: right; display: none;">Mula: </label>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display: none;" class="form-control date-range-filter">
                                        </div>
                                        <div class="form-group col-md-1">
                                        </div>
                                        <div class="form-group col-md-1">
                                            <label id="lblTamat" style="text-align: right; display: none;">Tamat: </label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display: none;" class="form-control date-range-filter">
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblPesanan_CT" class="table table-striped" style="width: 95%">
                                <thead>
                                    <tr>
                                        <th scope="col">No PT</th>
                                        <th scope="col">Tarikh</th>
                                        <th scope="col">Nama Syarikat</th>
                                        <th scope="col">KW</th>
                                        <th scope="col">Vot</th>
                                        <th scope="col">Harga (RM)</th>
                                        <th scope="col">Tarikh Bekal</th>
                                        <th scope="col">PTj</th>
                                        <th scope="col">Nama Ketua Penyelidik</th>
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


    <script type="text/javascript">

        document.addEventListener('DOMContentLoaded', function () {
            var kaedahCarianSelect = document.getElementById('txtKaedahCarian');
            var pembekalDiv = document.querySelector('.Pembekal');

            var No_PTDiv = document.querySelector('.No_PT');




            // Initially hide or show based on the default value
            togglePembekalDiv();

            toggleNo_PTDiv();

            kaedahCarianSelect.addEventListener('change', function () {
                // Hide or show based on the selected value
                togglePembekalDiv();

                toggleNo_PTDiv();
            });

            function togglePembekalDiv() {
                if (kaedahCarianSelect.value === '4') {
                    pembekalDiv.style.display = 'block';
                } else {
                    pembekalDiv.style.display = 'none';
                }
            }


            function toggleNo_PTDiv() {
                if (kaedahCarianSelect.value === '1') {
                    No_PTDiv.style.display = 'block';
                } else {
                    No_PTDiv.style.display = 'none';
                }
            }

        });



        $("#categoryFilter").change(function (e) {

            var selectedItem = $('#categoryFilter').val()
            if (selectedItem == "6") {
                $('#txtTarikhStart').show();
                $('#txtTarikhEnd').show();

                $('#lblMula').show();
                $('#lblTamat').show();

                $('#txtTarikhStart').val("")
                $('#txtTarikhEnd').val("")
            }
            else {
                $('#txtTarikhStart').hide();
                $('#txtTarikhEnd').hide();

                $('#txtTarikhStart').val("")
                $('#txtTarikhEnd').val("")

                $('#lblMula').hide();
                $('#lblTamat').hide();

            }
        });


        // Get radio button elements
        const parentRadios = document.querySelectorAll('input[name="flexRadioDefault"]');
        const childContainer = document.querySelector('.child-container');

        // Add event listeners to parent radio buttons
        parentRadios.forEach(parentRadio => {
            parentRadio.addEventListener('change', function () {
                // Hide or show the child options container based on the selected parent radio
                childContainer.style.display = (this.id === 'flexRadioDefault1' || this.id === 'flexRadioDefault3') ? 'none' : 'block';

                // If the parent is checked, also uncheck the child options
                if (this.checked) {
                    document.querySelectorAll('.RadioDefault').forEach(RadioDefault => {
                        RadioDefault.checked = false;
                    });
                }
            });
        });

        $(document).ready(function () {
            // Initially hide the child-container-checkbox
            $('.child-container-checkbox').hide();

            // Attach a change event listener to the checkbox
            $('#flexcheckbox').change(function () {
                // Check if the checkbox is checked
                if ($(this).is(':checked')) {
                    // If checked, show the child-container-checkbox
                    $('.child-container-checkbox').show();
                } else {
                    // If unchecked, hide the child-container-checkbox
                    $('.child-container-checkbox').hide();
                }
            });
        });




        var isClicked = false;
        var Pesanan_ID = '';
        var tbl_CT;
        $(document).ready(function () {



            tbl_CT = $("#tblPesanan_CT").DataTable({
                "responsive": true,
                "searching": true,
                cache: true,
                dom: 'Bfrtip',


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
                "ajax":
                {
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PesananTempatanWS.asmx/LoadPerolehan_Pesanan_CT") %>',
                    type: 'POST',
                    "data": function () {

                        var startDate = $('#txtTarikhStart').val()
                        var endDate = $('#txtTarikhEnd').val()
                        return JSON.stringify({
                            category_filter: $('#categoryFilter').val(),
                            isClicked5: isClicked,
                            tkhMula: startDate,
                            tkhTamat: endDate
                        })
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },



                "columns": [

                    {
                        "data": "Bil",
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        },
                        "width": "5%"
                    },
                    {
                        "data": "No_Mohon",
                        "width": "10%"
                    },
                    {
                        "data": "No_Pesanan",
                        "width": "10%"
                    },
                    { "data": "Tarikh_Pesanan" },

                    {
                        "data": "Tujuan",
                        "width": "20%"
                    },
                    {
                        "data": "Nama_Sykt",
                        "width": "15%"
                    },
                    {
                        "data": "tot_Jumlah_Harga",
                        "width": "10%"
                    },
                    //{
                    //    "data": "null",
                    //    "type": "data", // This is optional but helps with sorting
                    //    render: function (data, type, row) {

                    //        return 'Cetak';

                    //    },
                    //    "width": "10%"
                    //},


                    //{
                    //    "data": null,
                    //    "defaultContent": '<i onclick="ShowPopup(1)" class="fa fa-ellipsis-h fa-lg"></i>',
                    //    "className": "text-center", // Center the icon within the cell
                    //    "width": "5%"
                    //}
                ],

                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });

                    // Add click event
                    $(row).on("click", function () {

                        var rowData = tbl_CT.row(this).data();

                        // Example: Store the No_Pesanan value in session storage
                        sessionStorage.setItem('No_Pesanan', rowData.No_Pesanan);

                        window.open('<%=ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN TEMPATAN/PrintReport/Pesanan_Tempatan_Print.aspx")%>', '_blank');

                    });
                },
            });
        });

        var newIdJualan;
        var newNoMohon;

        // Simpan btnNoPT
        $('#btnNoPT').off('click').on('click', async function (evt) {
            evt.preventDefault();
            Pesanan_ID = $('#txtNoP_T').val();

            console.log('Pesanan_ID', Pesanan_ID);
            tbl_CT.ajax.reload();


        });

        $('.btnSearch').click(async function () {
            show_loader();
            isClicked = true;
            tbl_CT.ajax.reload();
            close_loader();
        })




    </script>



</asp:Content>

