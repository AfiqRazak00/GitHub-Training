<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pemantauan_Bidaan.aspx.vb" Inherits="SMKB_Web_Portal.Pemantauan_Bidaan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/rowreorder/1.4.1/css/rowReorder.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.dataTables.min.css">

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

        #tblSenaraiBidaan td:hover {
            cursor: pointer;
        }

        #timer {
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 5px;
            color: #f6f4f3;
        }

        .days, .hours, .minutes, .seconds {
            display: inline-block;
            padding: 20px;
            width: 140px;
            height: 150px;
            border-radius: 5px;
        }

        .days {
            background: #3E3E3E;
            /*            background: #ef2f3c;
*/
        }

        .hours {
            background: #f6f4f3;
            color: #183059;
        }

        .minutes {
            background: #276fbf;
        }

        .seconds {
            background: #f0a202;
        }

        .numbers {
            color: #f6f4f3;
            font-size: 4em;
        }


        @keyframes blink {
            0% {
                opacity: 0;
            }

            50% {
                opacity: 1;
            }

            100% {
                opacity: 0;
            }
        }

        .blink-text {
            animation: blink 1s infinite;
        }
    </style>


    <div class="tabcontent" style="display: block">

        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai e-Bidding</h5>
                    </div>
                    <br />
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblSenaraiBidaan" class="table table-striped" style="width: 99%">
                                <thead>
                                    <tr>
                                        <th scope="col">Bil</th>
                                        <th scope="col">ID Bidaan</th>
                                        <th scope="col">No Sebut Harga / Tender</th>
                                        <th scope="col">Sebut Harga / Tender</th>
                                        <th scope="col">Tarikh Mula</th>
                                        <th scope="col">Tarikh Tamat</th>
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


    <!-- Modal -->
    <div class="modal fade" id="transaksi" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header modal-header--sticky">
                    <h5 class="modal-title">Senarai Permohonan Perolehan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <div class="container">
                        <h5 class="text-center">Masa Bidaan</h5>
                        <div id="timer"></div>
                    </div>


                    <br />
                    <br />



                    <div class="card" style="margin: 20px">
                        <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Senarai Pembida</h6>
                        <div class="card-body">

                            <div class="row">
                                <div class="col-md-12">
                                    <div class="form-row">
                                        <div class="form-group col-md-8">
                                            <div style="font-size: 16px"><span>SEBUT HARGA : </span><span id="idsebutharga"></span></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="transaction-table table-responsive">
                                <table id="tblSenaraiPembidaT" class="table table-striped" style="width: 99%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">Kod</th>
                                            <th scope="col">Harga Bida</th>
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


    <script type="text/javascript">





        var tbl = null;
        var No_Sebut_Harga = "";
        var No_Sebut_Harga1 = "";
        var no_bidaan = "";
        $(document).ready(function () {
            tbl = $("#tblSenaraiBidaan").DataTable({
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
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/e-Bidding/ebidding.asmx/Load_SenaraiBidaan2") %>',
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
                        no_bidaan = data.Id_Bidaan;
                        No_Sebut_Harga1 = data.No_Sebut_Harga;

                        const dateTime = new Date(data.Tarikh_Mula);
                        const datePart = dateTime.toISOString().slice(0, 10);
                        const timePart = dateTime.toTimeString().slice(0, 5);

                        const dateTime1 = new Date(data.Tarikh_Tamat);
                        const datePart1 = dateTime1.toISOString().slice(0, 10);
                        const timePart1 = dateTime1.toTimeString().slice(0, 5);

                        $('#idsebutharga').text(data.Detail);

                        updateTimerForDate(data.Tarikh_Tamat, data.Tarikh_Mula);
                        tbl2.ajax.reload();
                        $('#transaksi').modal('show');
                    });
                },


                "columns": [
                    { "data": null },
                    { "data": "Id_Bidaan" },
                    { "data": "No_Sebut_Harga" },
                    { "data": "no_mohon" },
                    {
                        "data": "Tarikh_Mula",
                        "type": "date",
                        "render": function (data, type, row) {
                            {
                                return moment(data).format('DD/MM/YYYY hh:mm A');
                            }
                            return data;
                        },
                    },

                    {
                        "data": "Tarikh_Tamat",
                        "type": "date",
                        "render": function (data, type, row) {
                            {
                                return moment(data).format('DD/MM/YYYY hh:mm A');
                            }
                            return data;
                        },
                    },

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
                ]
            });
        });


        let timerInterval; // Declare the timerInterval variable outside the functions

        function updateTimerDisplay(days, hours, minutes, seconds) {
            document.getElementById("timer").innerHTML =
                `<div class="days">
                        <div class="numbers">${days}</div>Hari
                    </div>
                    <div class="days">
                        <div class="numbers">${hours}</div>Jam
                    </div>
                    <div class="days">
                        <div class="numbers">${minutes}</div>Minit
                    </div>
                    <div class="days">
                        <div class="numbers">${seconds}</div>Saat
                    </div>`;
        }

        function updateTimerForDate(TarikhTamat, TarikhMula) {
            clearInterval(timerInterval);

            function updateTimer() {
                const tarikhEnd = new Date(TarikhTamat).getTime();
                const tarikhStart = new Date(TarikhMula).getTime();
                const today = new Date().getTime();

                if (tarikhEnd > today) {
                    // Timer still running
                    let diff = tarikhEnd - today;
                    const days = Math.floor(diff / (1000 * 60 * 60 * 24));
                    const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                    const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
                    const seconds = Math.floor((diff % (1000 * 60)) / 1000);
                    updateTimerDisplay(days, hours, minutes, seconds);
                } else if (today > tarikhEnd) {
                    // Timer expired
                    clearInterval(timerInterval);
                    showTarikhBidaanTamat();
                } else if (tarikhStart > today) {
                    // Timer not started yet
                    showTarikhBidaanBelumMula();
                }
            }

            updateTimer();

            timerInterval = setInterval(updateTimer, 1000);
        }

        function showTarikhBidaanBelumMula() {
            document.getElementById("timer").innerHTML =
                `<div class="blink-text">
                        <h3 style="color:red">Masa Bidaan Belum Mula</h3>
                    </div>`;
        }


        function showTarikhBidaanTamat() {
            document.getElementById("timer").innerHTML =
                `<div class="blink-text">
                        <h3 style="color:red">Masa Bidaan Telah Tamat</h3>
                    </div>`;
        }



        var tbl2 = null;
        tbl2 = $("#tblSenaraiPembidaT").DataTable({
            "responsive": true,
            "searching": false,
            "info": false,
            "paging": false,
            "ordering": false,
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
                "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/e-Bidding/ebidding.asmx/Load_LiveBidaan") %>',
                type: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: function (d) {
                    return JSON.stringify({ id: No_Sebut_Harga1 });

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
            },
            "columns": [
                { "data": "rank" },
                { "data": "kod_pembuka" },
                { "data": "harga" }
            ],

        });

        $(document).ready(function () {
            setInterval(function () {
                tbl2.ajax.reload();
            }, 5000);
        });



    </script>
</asp:Content>
