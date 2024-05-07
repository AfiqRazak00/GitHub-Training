<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pemantauan_Bidaan_vendor.aspx.vb" Inherits="SMKB_Web_Portal.Pemantauan_Bidaan_vendor" %>

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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/flipclock/0.7.8/flipclock.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/flipclock/0.7.8/flipclock.js"></script>

    <div class="tabcontent" style="display: block">

        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Sebut Harga</h5>
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
                    <h5 class="modal-title">Maklumat Bidaan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">

                    <div class="container card">
                        <h5 class="text-center card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;"></h5>
                        <div class="card-body"></div>
                        <div class="row">
                            <div class="col-md-12">
                                <div style="text-align: center; font-size: 20px;"><b><span id="idsebutharga"></span></b>
                                    <span id="idnobid" style="display:none"></span>
                                </div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-12">
                                <div id="timer"></div>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-4">
                                        <div style="font-size: 16px; text-align: center">
                                            <b><span>NILAI BIDAAN</span></b>
                                            <br />
                                            <span id="NilaiBida"></span>
                                        </div>
                                        <br />
                                        <div style="font-size: 16px; text-align: center">
                                            <b><span>RANKING</span></b>
                                            <br />
                                            <span id="Ranking"></span>
                                        </div>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <input type="text"
                                            class="underline-input multi price form-control"
                                            placeholder="0.00" id="price" name="price"
                                            style="text-align: right; height: 100px; font-size: 50px" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                                        <br />
                                        <button class="btn-primary form-control btnBida" style="text-align: center; align-items: center;">BIDA</button>
                                    </div>
                                    <div class="form-group col-md-4">
                                        <div style="font-size: 16px; text-align: center">
                                            <b><span>MULA</span></b>
                                            <br />
                                            <span id="TkhMula"></span>
                                        </div>
                                        <br />
                                        <div style="font-size: 16px; text-align: center">
                                            <b><span>TAMAT</span></b>
                                            <br />
                                            <span id="TkhTamat"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <br />
                <%--<div class="card" style="margin: 20px;" >
                            <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;"><span id="idsebutharga"></span></h6>
                            <div class="card-body">
                            </div>
                        </div>--%>
                <div class="card" style="margin: 20px; display: none">
                    <h6 class="card-title" style="position: absolute; top: -10px; left: 15px; background-color: white; padding: 0 5px;">Senarai Pembida</h6>
                    <div class="card-body">

                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <%--<div class="form-group col-md-8">
                                                <div style="font-size: 16px"><span>SEBUT HARGA : </span><span id="idsebutharga"></span></div>
                                            </div>--%>
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


            $(document).ready(function () {
                setInterval(function () {
                    tbl2.ajax.reload();
                }, 5000);
            });


            var tbl = null;
            var No_Sebut_Harga = "";
            var No_Sebut_Harga1 = "";
            var no_bidaan = "";
            $(document).ready(function () {
                // Select the input element by its id
                const priceInput = document.getElementById('price');

                // Add keyup event listener
                priceInput.addEventListener('keyup', function (event) {
                    // Your keyup event handling code goes here
                    // For example, you can access the input value using `this.value`
                    const format_price = formatPriceKeyUp(this)
                    //console.log('Input value:', format_price);
                    // You can perform any other actions or manipulations here
                });
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
                        "url": 'ebidding_vendor.asmx/Load_SenaraiBidaan2',
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

                            $('#idsebutharga').text(data.Detail.toUpperCase());
                            $('#NilaiBida').text(moment(data.Tarikh_Tamat).format('DD/MM/YYYY hh:mm A'));
                            $('#Ranking').text(moment(data.Tarikh_Tamat).format('DD/MM/YYYY hh:mm A'));
                            $('#TkhMula').text(moment(data.Tarikh_Mula).format('DD/MM/YYYY hh:mm A'));
                            $('#TkhTamat').text(moment(data.Tarikh_Tamat).format('DD/MM/YYYY hh:mm A'));
                            $('#idnobid').text(data.Id_Bidaan.toUpperCase());
                            
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

            // Simpan  Permohonan ulasan
            $('.btnBida').off('click').on('click', async function (e) {
                e.preventDefault();
                let nosebutharga = $("#idsebutharga").html()
                let nobida = $("#idnobid").html()
                let nilaibida = $("#price").val().replace(/,/g, '')

                let res = await ajaxHantar(nobida, nilaibida).catch(function (err) {
                    console.log(err)
                }) 
            });

            async function ajaxHantar(nobida, nilaibida) {
                try {
                    let url = 'ebidding_vendor.asmx/Simpan_Bida';
                    let response = await $.ajax({
                        url: url,
                        method: "POST",
                        data: JSON.stringify({
                            "nobida": nobida,
                            "nilaibida": nilaibida
                        }),
                        dataType: "json",
                        contentType: "application/json;charset=utf-8"
                    });

                    console.log(response);
                    var jsondata = JSON.parse(response.d);
                    if (jsondata.Code == "200") {
                        return true;
                    } else {
                        throw jsondata.Message;
                    }
                } catch (error) {
                    throw error;
                }
            }


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
        </script>
</asp:Content>
