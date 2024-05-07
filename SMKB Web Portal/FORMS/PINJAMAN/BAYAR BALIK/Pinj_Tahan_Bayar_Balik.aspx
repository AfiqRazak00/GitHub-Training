<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pinj_Tahan_Bayar_Balik.aspx.vb" Inherits="SMKB_Web_Portal.Pinj_Tahan_Bayar_Balik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>

    
    <style>
         #permohonan .modal-body {
            max-height: 60vh; /*Adjust height as needed to fit your layout */
            min-height: 60vh;
            overflow-y: scroll;
            scrollbar-width: thin;
        }
        .text-right {
            text-align: right;
        }

        .default-primary {
            background-color: #007bff !important;
            color: white;
        }


       /*start sticky table tbody tfoot*/
        table {
            
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

        #showModalButton:hover {
            /* Add your hover styles here */
            background-color: #ffc107; /* Change background color on hover */
            color: #fff; /* Change text color on hover */
            border-color: #ffc107; /* Change border color on hover */
            cursor: pointer; /* Change cursor to indicate interactivity */
        }

         #tblSenaraiPermohonan tr:hover {
            cursor: pointer; /* Change cursor to indicate interactivity */
         }

         #tblJadualBayarBalik tr:hover {
            cursor: pointer; /* Change cursor to indicate interactivity */
         }
    </style>
    <contenttemplate>   
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <div id="divpendaftaraninv" runat="server" visible="true">
                <div class="modal-body ">
                    <div class="table-title form-row">
                        <div class="justify-content-around">
                            <h5>Maklumat Pembiayaan</h5>
                        </div>
                        <div class="form-row justify-content-end" >
                            <div class="btn btn-primary btnPapar" onclick="ShowPopup('2')">
                                Senarai Rekod Pembiayaan
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="">
                        <div class="form-row">
                            <div class="form-group col-md-4">
                                <input type="text" class="form-control input-group__input" id="txtnopinj" name="txtnopinj" readonly/>
                                <label class="input-group__label" for="txtnopinj">No Pembiayaan </label>
                            </div>
                            <div class="form-group col-md-4">
                                <input type="text" class="form-control input-group__input" id="txtnama" name="txtnama" readonly/>
                                <label class="input-group__label" for="txtnama">Nama </label>
                            </div>
                            <div class="form-group col-md-4">
                                <input type="text" class="form-control input-group__input" id="txtamaun" name="txtamaun" readonly/>
                                <label class="input-group__label" for="txtamaun">Amaun (RM) </label>
                            </div>
                        </div>
                        <br>
                        <div class="row ">
                            <div class="col-md-12">
                                <table class="table table-striped" id="tblJadualBayarBalik" style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th scope="col" style="width: 5%; text-align:center">Bil</th>
                                            <th scope="col" style="width: 5%; text-align:center">Tahan</th>
                                            <th scope="col" style="width: 5%; text-align:center">Aktif</th>
                                            <th scope="col" style="width: 10%; text-align:center">Bulan Bayar</th>
                                            <th scope="col" style="width: 15%; text-align:center">Pokok (RM)</th>
                                            <th scope="col" style="width: 15%; text-align:center">Untung (RM)</th>
                                            <th scope="col" style="width: 15%; text-align:center">Bayaran (RM)</th>
                                            <th scope="col" style="width: 20%; text-align:center">Baki Pokok (RM)</th>
                                        </tr>
                                    </thead>
                                </table>
                            </div>  
                        </div>
                    </div>
                </div>
                <div class="sticky-footer">
                    <br>
                    <div class="form-row">
                       <div class="form-group col-md-12">
                          <div id="showBtn" class="float-right">
                             <button type="button" class="btn btn-setsemula btnreset">Rekod Baru</button>
                             <button type="button" class="btn btn-secondary btnSimpan">Simpan</button>
                          </div>
                       </div>
                    </div>
                 </div> 
            </div>
        </div>

        <!-- Modal senarai-->
        <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" style="min-width: 60%" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Rekod Pembiayaan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
                                <label for="" class="col-sm-4 col-form-label">Carian:</label>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <select id="pinjamanDateFilter" class="custom-select" onchange="dateFilterHandler(event)">
                                            <option value="all">SEMUA</option>
                                            <option value="0" selected="selected">Hari Ini</option>
                                            <option value="1">Semalam</option>
                                            <option value="7">7 Hari Lepas</option>
                                            <option value="30">30 Hari Lepas</option>
                                            <option value="60">60 Hari Lepas</option>
                                            <option value="select">Pilih Tarikh</option>
                                        </select>
                                        <button id="btnSearch" runat="server" class="btn btn-outline btnSearch" type="button" onclick="loadPermohonan()">
                                            <i class="fa fa-search"></i>Cari
                                        </button>

                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="form-row">
                                        <div class="form-group col-md-5">
                                            <br />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-11" id="specificDateFilter" style="display: none">
                                    <div class="form-row">
                                        <div class="form-group col-md-1">
                                            <label id="lblMula" style="text-align: right;">Mula:</label>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhStart" name="txtTarikhStart" class="form-control input-sm date-range-filter">
                                        </div>
                                        <div class="form-group col-md-1">
                                        </div>
                                        <div class="form-group col-md-1">
                                            <label id="lblTamat" style="text-align: right;">Tamat:</label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" class="form-control input-sm date-range-filter">
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblSenaraiPermohonan" class="table table-striped" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="text-align: center;width: 5%">Bil</th>
                                                <th scope="col" style="text-align: center;width: 15%">No Pembiayaan</th>
                                                <th scope="col" style="text-align: center;width: 10%">No Staf</th>
                                                <th scope="col" style="text-align: center;width: 30%">Nama</th>
                                                <th scope="col" style="text-align: center;width: 15%">Tarikh Mohon</th>
                                                <th scope="col" style="text-align: center;width: 15%">Jenis Pembiayaan</th>
                                                <th scope="col" style="text-align: center;width: 15%">Amaun(RM)</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableID_Senarai">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Confirmation Modal Proses Bayar Balik -->
        <div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog"
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
                            data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn default-primary btnYaConfirmation">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- notify modal start-->
        <div class="modal fade" id="NotifyModal" role="dialog" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblNotify">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="notify"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary tutupButton" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            function getDateBeforeDays(days) {
                let pastDate = new Date();
                pastDate.setDate(pastDate.getDate() - days);
                return pastDate;
            }

            function dateFilterHandler(e) {
                if (e.target.value == "select") {
                    $("#specificDateFilter").show()
                }
                else {
                    $("#specificDateFilter").hide()
                }
            }

            function loadPermohonan() {
                if ($("#pinjamanDateFilter").val() == "select") {
                    let dateStart = $("#txtTarikhStart").val()
                    let dateEnd = $("#txtTarikhEnd").val()
                    if (dateStart == "") {
                        dialogMakluman("sila pilih tarikh carian")
                        return
                    }
                    loadPermohonanLists(dateStart, dateEnd)
                }
                else if ($("#pinjamanDateFilter").val() == "all") {
                    loadPermohonanLists()

                }
                else {
                    let days = $("#pinjamanDateFilter").val()
                    let dateString = toSqlDateString(getDateBeforeDays(days))
                    loadPermohonanLists(dateString, "")
                }
            }

            function loadPermohonanLists(dateStart, dateEnd) {
                console.log('load list permohonan')

                if (!dateEnd) {
                    dateEnd = ""
                }
                if (!dateStart) {
                    dateStart = ""
                }

                show_loader()
                $.ajax({
                    url: '<%= ResolveUrl("~/FORMS/PINJAMAN/BAYAR BALIK/Pinj_TahanBayarBalik_WS.asmx/loadListPermohonanData") %>',
                    method: "POST",
                    data: JSON.stringify({
                        DateStart: dateStart,
                        DateEnd: dateEnd
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        debugger
                        close_loader()
                        data = JSON.parse(data.d)
                        tbl.clear()
                        tbl.rows.add(data.Payload).draw()
                    },
                    drawCallback: function (settings) {
                        // Your function to be called after loading data
                        close_loader();
                    },
                    error: function (xhr, status, error) {
                        close_loader()
                        console.error(error);
                    }
                })
            }

            var selectedCategory = null;
            function ShowPopup(elm) {
                debugger
                if (elm == "1") {
                    $('#permohonan').modal('toggle');
                }
                else if (elm == "2") { // open modal and load data

                    $(".modal-body div").val("");
                    $('#permohonan').modal('toggle');

                    // set datepicker to empty and hide it as default state
                    $('#txtTarikhStart').val("");
                    $('#txtTarikhEnd').val("");
                    $('#divDatePicker').removeClass("d-flex").addClass("d-none");
                }
            }

            var tbl = null
            var tblJadualBayarBalik = null
            var tblPotongan = null

            $(document).ready(function () {
                var today = toSqlDateString(new Date())

                document.getElementById('txtTarikhStart').setAttribute('max', today);
                document.getElementById('txtTarikhEnd').setAttribute('max', today);

                tbl = $("#tblSenaraiPermohonan").DataTable({
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
                    columnDefs: [
                        { targets: [6] }
                    ],
                    "columns": [
                        { "data": "Bil", "className": "text-center" },
                        { "data": "No_Pinj", "className": "text-center" },
                        { "data": "No_Staf", "className": "text-center" },
                        { "data": "MS01_Nama" },
                        { "data": "FormattedDate", "className": "text-center" },
                        { "data": "Jenis_Pinj_Desc" },
                        { "data": "Amaun", "className": "text-right" }
                    ],
                    "rowCallback": function (row, data) {
                        // Add hover effect
                        $(row).hover(function () {
                            $(this).addClass("hover pe-auto bg-warning");
                        }, function () {
                            $(this).removeClass("hover pe-auto bg-warning");
                        });
                    },
                    createdRow: function (row, data, dataIndex) {
                        row.dataset.idrujukan = data["No_Pinj"]
                        row.onclick = showPermohonanData
                    }
                });

                tblJadualBayarBalik = $("#tblJadualBayarBalik").DataTable({
                    "responsive": true,
                    "searching": true,
                    "sPaginationType": "full_numbers",
                    "pageLength": 20,
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
                    columnDefs: [
                        { targets: [6] }
                    ],
                    "columns": [
                        { "data": "bil", "className": "text-center" },
                        {
                            "data": "Status",
                            'targets': 0,
                            'searchable': false,
                            'className': 'text-center',
                            'orderable': false,
                            render: function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;

                                }
                                var isChecked = data == 0 ? "checked" : ""; // Check if Status is 1
                                var link = ` <input type="checkbox" name="checkTahan" id="checkTahan" ${isChecked} />`;
                                return link;
                            }
                        },
                        {
                            "data": "Status",
                            'targets': 1,
                            'searchable': false,
                            'orderable': false,
                            'className': 'text-center',
                            render: function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }
                                var isChecked = data == 1 ? "checked" : ""; // Check if Status is 1
                                var link = `<input type="checkbox" name="checkAktif" id="checkAktif"  ${isChecked} />`;
                                return link;
                            }
                        },
                        { "data": "Bulan_Tahun", "className": "text-center" },
                        { "data": "Pokok", "className": "text-right" },
                        { "data": "Faedah", "className": "text-right" },
                        { "data": "Ansuran", "className": "text-right" },
                        { "data": "Baki_Pokok", "className": "text-right" }
                    ],
                    "rowCallback": function (row, data) {
                        // Add hover effect
                        $(row).hover(function () {
                            $(this).addClass("hover pe-auto bg-warning");
                        }, function () {
                            $(this).removeClass("hover pe-auto bg-warning");
                        });
                    }
                });
            });

            $(document).on("click", "input[name='checkTahan']", function () {
                // Find the parent row of the clicked checkbox
                var row = $(this).closest("tr");
                // Find the checkbox in the "Status" column within the same row and uncheck it
                $("input[name='checkAktif']", row).prop("checked", false);
            });

            $(document).on("click", "input[name='checkAktif']", function () {
                // Find the parent row of the clicked checkbox
                var row = $(this).closest("tr");
                // Find the checkbox in the "Status" column within the same row and uncheck it
                $("input[name='checkTahan']", row).prop("checked", false);
            });

            //load data into modal
            async function showPermohonanData(e) {
                // modal dismiss
                $('#permohonan').modal('toggle');
                var target = e.target
                if (target.tagName == "TD") {
                    target = target.parentElement
                }
                show_loader()

                let pinjHdr = await getPinjamanHdr(target.dataset.idrujukan)
                close_loader()
            }

            function getPinjamanHdr(No_Pinj) {
                return new Promise(function (resolve, reject) {
                    $.ajax({
                        url: '<%= ResolveUrl("~/FORMS/PINJAMAN/BAYAR BALIK/Pinj_TahanBayarBalik_WS.asmx/LoadMaklumatPinjaman") %>',
                        method: "POST",
                        data: JSON.stringify({
                            No_Pinj: No_Pinj

                        }),
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        success: async function (data) {
                            debugger
                            data = JSON.parse(data.d)
                            data = data.Payload
                            fillPinjamanHdr(data[0])
                            retrieveJadualBayarBalik(data[0].No_Pinj)
                            resolve(true)
                        },
                        error: function (xhr, status, error) {
                            console.error(error);
                            reject(false)
                        }
                    })
                })
            }

            function retrieveJadualBayarBalik(No_Pinj) {
                $.ajax({
                    url: '<%= ResolveUrl("~/FORMS/PINJAMAN/BAYAR BALIK/Pinj_TahanBayarBalik_WS.asmx/loadJadualBayarBalik") %>',
                    method: "POST",
                    data: JSON.stringify({
                        No_Pinj: No_Pinj
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        data = JSON.parse(data.d)
                        tblJadualBayarBalik.clear()
                        tblJadualBayarBalik.rows.add(data.Payload).draw()
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                    }
                })
            }

            var cachePinjaman = null
            function fillPinjamanHdr(pinj) {
                cachePinjaman = pinj
                $("#txtnopinj").val(pinj.No_Pinj)
                $("#txtnama").val(pinj.Nama)
                $("#txtamaun").val(pinj.Amaun_Formatted)
            }

            var cachePenjamin = null

            $('.btnSimpan').click(async function () {
                $('#confirmationModal').modal('toggle');
            })

            var checklistData = [];
            // confirmation button in confirmation modal
            $('.btnYaConfirmation').click(async function () {
                //close modal confirmation
                $('#confirmationModal').modal('toggle');
                let fulldata = cachePinjaman

                // Iterate through each row in the DataTable
                tblJadualBayarBalik.rows().every(function (index, element) {
                    var rowData = this.data();
                    var rowId = rowData.Bil_Byr;
                    var rowBulanTahun = rowData.Bulan_Tahun;
                    var [rowBulan, rowTahun] = rowBulanTahun.split(" - ");

                    var rowPokok = rowData.Pokok.replace(/,/g, "");
                    var rowFaedah = rowData.Faedah.replace(/,/g, "");
                    var rowAnsuran = rowData.Ansuran.replace(/,/g, "");
                    var rowBaki_Pokok = rowData.Baki_Pokok.replace(/,/g, "");
                    var rowStatus_GJ = rowData.Status_GJ

                    var isChecked = $(this.node()).find('input[name="checkTahan"]').prop('checked');

                    var rowObject = {
                        ID: rowId,
                        isChecked: isChecked,
                        bulan: rowBulan,
                        tahun: rowTahun,
                        pokok: rowPokok,
                        faedah: rowFaedah,
                        ansuran: rowAnsuran,
                        bakiPokok: rowBaki_Pokok,
                        statusGJ: rowStatus_GJ
                    };
                    checklistData.push(rowObject);
                });
                debugger
                let errmsg = null
                
                let res = await saveTahanBayarBalik(fulldata, checklistData).catch(function (err) {
                    console.log(err)
                    errmsg = err
                })
                if (res != null) {
                    notification(res)
                    return
                }
                else {
                    notification(errmsg)
                }
            });

            function notification(msg) {
                $("#notify").html(msg)
                $("#NotifyModal").modal('show');
            }

            function saveTahanBayarBalik(pinjaman, checklistData) {
                debugger
                show_loader()
                return new Promise(function (resolve, reject) {
                    let url = '<%= ResolveUrl("~/FORMS/PINJAMAN/BAYAR BALIK/Pinj_TahanBayarBalik_WS.asmx/saveTahanBayarBalik") %>'
                    $.ajax({
                        url: url,
                        method: "POST",
                        data: JSON.stringify({
                            "pinjaman": pinjaman,
                            "checklistData": checklistData
                        }),
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        success: function (data) {
                            debugger
                            close_loader()
                            console.log(data)
                            var jsondata = JSON.parse(data.d)
                            if (jsondata.Code == "200") {
                                resolve(jsondata.Message)
                            }
                            else {
                                reject(jsondata.Message)
                            }
                        }
                    })
                })

            }

            $('.tutupButton').on('click', async function () {
                location.reload();
            });

            $('.btnreset').on('click', async function () {
                location.reload();
            });

        </script>
    </contenttemplate>
</asp:Content>