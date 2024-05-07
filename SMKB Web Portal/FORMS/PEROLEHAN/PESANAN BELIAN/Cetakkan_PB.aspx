<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Cetakkan_PB.aspx.vb" Inherits="SMKB_Web_Portal.Cetakkan_PB" %>


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
                        <h5 class="modal-title" id="exampleModalCenterTitle">Cetak Pesanan Belian</h5>

                    </div>

                    <!-- Create the dropdown filter -->
                    <div class="search-filter ">
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
                                        <th scope="col">Bil</th>
                                        <th scope="col">No Perolehan</th>
                                        <th scope="col">No PT</th>
                                        <th scope="col">Tarikh PT</th>
                                        <th scope="col">Tujuan</th>
                                        <th scope="col">Nama Pembekal</th>
                                        <th scope="col">Jumlah Perbelanjaan (RM)</th>
                                        <th scope="col">Telah dicetak</th>
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





        var Pesanan_ID = '';
        var tbl_CT;
        var isClicked7 = false;

        $(document).ready(function () {
            tbl_CT = $("#tblPesanan_CT").DataTable({
                "responsive": true,
                "searching": true,
                "info": false,
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
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadSenaraiPembelian_CT")%>',
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        var startDate = $('#txtTarikhStart').val();
                        var endDate = $('#txtTarikhEnd').val();
                        return JSON.stringify({
                            category_filter: $('#categoryFilter').val(),
                            isClicked7: isClicked7,
                            tkhMula: startDate,
                            tkhTamat: endDate
                        })
                        console.log("Data sent to server:", data);
                        return JSON.stringify(data);
                    },
                    "error": function (xhr, error, thrown) {
                        console.log("Ajax error:", error);
                        //console.log("Details:", xhr.responseText); // Log the responseText for more details
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

                        var rowData = tbl_CT.row(this).data();

                        // Example: Store the Id_Pembelian value in session storage
                        sessionStorage.setItem('Id_Pembelian', rowData.Id_Pembelian);

                        window.open('<%=ResolveClientUrl("~/FORMS/PEROLEHAN/PESANAN BELIAN/PrintReport/Pembelian_Tempatan_Print.aspx")%>', '_blank');

    });
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
                        "data": "Id_Pembelian",
                        "width": "10%"
                    },
                    {
                        "data": "Tarikh_Beli",
                        "type": "date", // This is optional but helps with sorting
                        render: function (data, type, row) {
                            // Format the date using moment.js
                            if (data == null) {
                                return '-';
                            } else {
                                return moment(data).format('DD/MM/YYYY , h:mm a '); // Adjust the format as needed
                            }
                        },
                    },
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
                    {
                        "data": "null",
                        "type": "data", // This is optional but helps with sorting
                        render: function (data, type, row) {

                            return 'Cetak';

                        },
                        "width": "10%"
                    },
                ]
            });



            function formatDateTime(dateTimeString) {
                var time = new Date(dateTimeString);
                return ('0' + time.getHours()).slice(-2) + ':' + ('0' + time.getMinutes()).slice(-2) + ':' + ('0' + time.getSeconds()).slice(-2);
            }

            function formatDateString(dateString) {
                var date = new Date(dateString);
                return ('0' + date.getDate()).slice(-2) + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + date.getFullYear();
            }

            // Function to format date and time
            function formatDateTime(dateTimeString) {
                let date = new Date(dateTimeString);
                let hh = String(date.getHours()).padStart(2, '0');
                let min = String(date.getMinutes()).padStart(2, '0');
                let ss = String(date.getSeconds()).padStart(2, '0');
                return `${hh}:${min}:${ss}`;
            }

            // Function to format date string as dd-mm-yyyy
            function formatDateString(dateString) {
                let date = new Date(dateString);
                let dd = String(date.getDate()).padStart(2, '0');
                let mm = String(date.getMonth() + 1).padStart(2, '0');
                let yyyy = date.getFullYear();
                return `${dd}/${mm}/${yyyy}`;
            }

            $('.btnSearch').click(async function () {

                //load_loader();
                isClicked7 = true;
                tbl_CT.ajax.reload();
                //    close_loader();
            })
            

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








    </script>



</asp:Content>
