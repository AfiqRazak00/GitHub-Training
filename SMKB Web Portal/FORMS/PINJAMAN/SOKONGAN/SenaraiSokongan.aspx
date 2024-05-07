<%@ Page Title="" Language="vb" AutoEventWireup="false" Async="true" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="SenaraiSokongan.aspx.vb" Inherits="SMKB_Web_Portal.SenaraiSokongan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>

    <style>
        #modalSokonganData .modal-body {
            max-height: 60vh; /*Adjust height as needed to fit your layout */
            min-height: 60vh;
            overflow-y: scroll;
            scrollbar-width: thin;
        }
        .text-right {
            text-align: right;
        }
    </style>

    <contenttemplate>
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <%-- DIV PENDAFTARAN INVOIS --%>
            <div id="divpendaftaraninv" runat="server" visible="true">
                <div class="modal-body">
                    <div>
                        <hr />
                        <h6>Senarai Permohonan Pinjaman Yang Belum Di Sokong</h6>
                        <hr />
                        <!-- Create the dropdown filter -->

                        <div class="search-filter">
                            <div class="form-row justify-content-center">
                                <div class="form-group row col-md-6">
                                    <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align: right">Carian :</label>
                                    <div class="col-sm-8">
                                        <div class="input-group">
                                            <select id="invoisDateFilter" class="custom-select" onchange="dateFilterHandler(event)">
                                                <option value="all">SEMUA</option>
                                                <option value="0" selected="selected">Hari Ini</option>
                                                <option value="1">Semalam</option>
                                                <option value="7">7 Hari Lepas</option>
                                                <option value="30">30 Hari Lepas</option>
                                                <option value="60">60 Hari Lepas</option>
                                                <option value="select">Pilih Tarikh</option>
                                            </select>
                                            <button id="btnSearch" class="btn btnSearch btn-outline" type="button" onclick="loadPermohonan()">
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
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblSenaraiPermohonan" class="table table-striped" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="text-align: center;width: 15%;">No Permohonan</th>
                                                <th scope="col" style="text-align: center;width: 10%;">No Staf</th>
                                                <th scope="col" style="text-align: center;width: 30%;">Nama</th>
                                                <th scope="col" style="text-align: center;width: 10%;">Tarikh Mohon</th>
                                                <th scope="col" style="text-align: center;width: 15%;">Jenis Pinjaman</th>
                                                <th scope="col" style="text-align: center;width: 15%;">Amaun (RM)</th>
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
        <!-- modal sokongan start -->
        <div class="modal fade" id="modalInvoisData" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" style="min-width: 60%" id="modalSokonganData" role="document">
                <div class="modal-content modal-xl">
                    <div class="modal-header modal-header--sticky" style="border-bottom: none !important">
                         <button type="button" class="close d-flex justify-content-end" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-md-7">
                            <div class="form-group input-group">
                                <input type="text" class=" input-group__input form-control input-sm " id="txtnama" name="txtnama" readonly />
                            </div>
                        </div>
                    </div>
                    <ul class="nav nav-tabs" id="subTab">
                         <li class="nav-item">
                            <a class="nav-link active text-uppercase"data-toggle="tab" href="#InfoPemohon" >MAKLUMAT PEMOHON</a>
                         </li>
                         <li class="nav-item" role="presentation">
                            <a class="nav-link text-uppercase" data-toggle="tab" href="#InfoPinjaman" >MAKLUMAT PINJAMAN</a>
                         </li>
                    </ul>
                    <div class="modal-body">
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="InfoPemohon" role="tabpanel">
                                <div class="row ">
                                    <div class="col-md-12">
                                        <div class="row justify-content-center">
                                            <div class="col-md-2">
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm  " id="txtnostaf" name="txtnostaf" readonly />
                                                    <label class="input-group__label">No Staf</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txttarafpkhd" id="txttarafpkhd" readonly>
                                                    <label class="input-group__label">Taraf Perkhidmatan</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class="input-group__input form-control input-sm  " id="txtgredgaji" name="txtgredgaji" readonly>
                                                    <label class="input-group__label">Gred Gaji</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm text-right" name="txtgajipokok" id="txtgajipokok" readonly>
                                                    <label class="input-group__label">Gaji Pokok</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " id="txtvoipno" name="txtvoipno" readonly>
                                                    <label class="input-group__label">VoIP No.</label>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtnokp" id="txtnokp" readonly>
                                                    <label class="input-group__label">No KP</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtkumppkhd" id="txtkumppkhd" readonly>
                                                    <label class="input-group__label">Kumpulan Perkhidmatan</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtdob" id="txtdob" readonly>
                                                    <label class="input-group__label">Tarikh Lahir</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="date" class=" input-group__input form-control input-sm " name="txttarikhlantikan" id="txttarikhlantikan" readonly>
                                                    <label class="input-group__label">Tarikh Lantikan</label>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtjawatan" id="txtjawatan" readonly>
                                                    <label class="input-group__label">Jawatan</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " id="txtjabatan" name="txtjabatan" readonly>
                                                    <label class="input-group__label">Jabatan</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class="input-group__input form-control input-sm  " id="txtumur" name="txtumur" readonly>
                                                    <label class="input-group__label">Umur Pada Tarikh Memohon</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " id="txttarikhsah" name="txttarikhsah" readonly>
                                                    <label class="input-group__label">Tarikh Sah</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <table class="table table-striped" id="tblDataUlasan" style="width: 100%;">
                                            <thead>
                                                <tr style="width: 100%; text-align: center">
                                                    <th scope="col">
                                                        <input type="checkbox" name="selectAll" id="selectAll" /></th>
                                                    <th scope="col">Ulasan Sokongan</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tableID">
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane fade " id="InfoPinjaman" role="tabpanel">
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="row justify-content-center">
                                            <div class="col-md-4">
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " id="txtkatpinj" name="txtkatpinj" readonly />
                                                    <label class="input-group__label">Kategori Pinjaman</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txttempoh" id="txttempoh" readonly>
                                                    <label class="input-group__label">Tempoh</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtkelayakan" id="txtkelayakan" readonly>
                                                    <label class="input-group__label">Kelayakan</label>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group input-group">
                                                    <input type="text" class="input-group__input form-control input-sm  " id="txtjenpinj" name="txtjenpinj" readonly>
                                                    <label class="input-group__label">Jenis Pinjaman</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm text-right " id="txtamaunpinj" name="txtamaunpinj" readonly />
                                                    <label class="input-group__label">Amaun Mohon (RM)</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class="input-group__input form-control input-sm  " id="txtinsentifno" name="txtinsentifno" readonly>
                                                    <label class="input-group__label">No Insentif</label>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group input-group">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txttkhmohon" id="txttkhmohon" readonly>
                                                    <label class="input-group__label">Tarikh Mohon</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class="input-group__input form-control input-sm text-right " id="txtansuran" name="txtansuran" readonly>
                                                    <label class="input-group__label">Ansuran Bulanan (RM)</label>
                                                </div>
                                                <div class="form-group input-group">
                                                    <input type="text" class="input-group__input form-control input-sm text-right " id="txtinsentifamaun" name="txtinsentifamaun" readonly>
                                                    <label class="input-group__label">Insentif (RM)</label>
                                                </div>

                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modal-footer--sticky">
                        <div class="col-md-12">
                            <div class="row">
                                <div class="col-md-6">
                                </div>
                                <div class="col-md-6 ">
                                    <div class="row justify-content-end">
                                        <button type="button" onclick="lulus(this)" id="btnXLulus" class="btn btn-danger btnXLulus" data-toggle="tooltip" title="Simpan dan Hantar">Tidak Sokong</button>
                                        <p>&nbsp;</p>
                                        <button type="button" onclick="lulus(this)" id="btnLulus" class="btn btn-success btnLulus" data-toggle="tooltip" title="Simpan dan Hantar">Sokong</button>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- modal sokongan end -->

        <!-- modal message start -->
        <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary btnYA" data-toggle="modal" data-target="#ModulForm" data-dismiss="modal">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- modal message end -->

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
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- notify modal end-->
        <script type="text/javascript" src="../../../Content/js/SharedFunction.js"></script>
        <script type="text/javascript">
            var tbl = null
            var checklistData = [];

            $(document).ready(function () {
                var today = toSqlDateString(new Date())

                document.getElementById('txtTarikhStart').setAttribute('max', today);
                document.getElementById('txtTarikhEnd').setAttribute('max', today);
                tbl = $("#tblSenaraiPermohonan").DataTable({
                    "responsive": true,
                    "searching": true,
                    "rowCallback": function (row, data) {
                        // Add hover effect
                        $(row).hover(function () {
                            $(this).addClass("hover pe-auto bg-warning");
                        }, function () {
                            $(this).removeClass("hover pe-auto bg-warning");
                        });
                    },
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
                        { targets: [5]}
                    ],
                    "columns": [
                        { "data": "No_Pinj", "className": "text-center"},
                        { "data": "No_Staf", "className": "text-center" },
                        { "data": "Nama"},
                        { "data": "FormattedDate", "className": "text-center" },
                        { "data": "Jenis_Pinj_Desc"},
                        { "data": "Amaun_Mohon", "className": "text-right" }
                    ],
                    createdRow: function (row, data, dataIndex) {
                        row.dataset.idrujukan = data["No_Pinj"]
                        row.onclick = showInvoisData
                    }

                });

                tblTransaksi = $("#tblDataUlasan").DataTable({
                    "responsive": true,
                    "searching": false,
                    "sorting": false,
                    "paging": false,
                    "bInfo": false,
                    "columns":
                        [
                            {
                                "data": "ID_Ulasan",
                                'targets': 0,
                                'searchable': false,
                                'orderable': false,
                                render: function (data, type, row, meta) {
                                    if (type !== "display") {
                                        return data;

                                    }
                                    var link = ` <input type="checkbox" name="checkROC" class = "checkROC" id="checkROC" class="checkSingle"  />`;
                                    return link;
                                }
                            },
                            { "data": "Butiran" }
                        ],
                    "language": {
                        "emptyTable": " "
                    },
                    createdRow: function (row, data, dataIndex) {
                        row.dataset.noitem = data["ID_Ulasan"];
                        // $(row).find('.additional-info').hide();
                    }
                });
            });

            async function lulus(clickedButton) {
                let conf = await show_message_async('Ulasan <br>  <textarea id="txtUlasan" placeholder=""  class="input-group__input form-control" rows = "2" ></textarea >')
                if (!conf) {
                    return
                }
                let ulasan = $("#txtUlasan").val()

                // Iterate through each row in the DataTable
                tblTransaksi.rows().every(function (index, element) {
                    var rowData = this.data();
                    var rowId = rowData.ID_Ulasan;

                    var isChecked = $(this.node()).find('.checkROC').prop('checked');

                    var rowObject = {
                        ID: rowId,
                        isChecked: isChecked,
                    };
                    checklistData.push(rowObject);
                });
                let fulldata = cacheInvois

                let buttonId = $(clickedButton).attr('id');

                let res = await lulusInvois(fulldata, ulasan, checklistData, buttonId).catch(function (err) {
                    console.log(err)
                })
                if (!res) {
                    notification("Permohonan Pembiayaan gagal disokong")
                    console.log(res)
                    return
                }
                if (buttonId == "btnXLulus") {
                    notification("Permohonan Pembiayaan berjaya tidak disokong")
                } else {
                    notification("Permohonan Pembiayaan berjaya disokong")
                }

                $("#modalInvoisData").modal('hide')
                $("#btnSearch").click()

            }

            function notification(msg) {
                $("#notify").html(msg)
                $("#NotifyModal").modal('show');
            }

            function lulusInvois(invois, ulasan, checklistData, buttonId) {
                return new Promise(function (resolve, reject) {
                    let url = '<%= ResolveUrl("~/FORMS/PINJAMAN/SOKONGAN/Pinj_Sokongan_WS.asmx/saveSokonganPTJ") %>'
                    $.ajax({
                        url: url,
                        method: "POST",
                        data: JSON.stringify({
                            "pinjamanHdr": invois,
                            "ulasan": ulasan,
                            "checklistData": checklistData,
                            "buttonId": buttonId
                        }),
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        success: function (data) {
                            console.log(data)
                            var jsondata = JSON.parse(data.d)
                            if (jsondata.Code == "200") {
                                resolve(true)
                            }
                            else {
                                reject(jsondata.Message)
                            }
                        }
                    })
                })

            }


            //load data into modal
            async function showInvoisData(e) {
                var target = e.target
                if (target.tagName == "TD") {
                    target = target.parentElement
                }
                show_loader()
                let invHdr = await getInvoisHdr(target.dataset.idrujukan)
                close_loader()

                $("#modalInvoisData").modal('show')
                const firstTab = document.querySelector('[data-tab="InfoPemohon"]');
                firstTab.click();
            }

            function getInvoisHdr(No_Pinj) {
                return new Promise(function (resolve, reject) {
                    $.ajax({
                       <%-- url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Invois_WS.asmx/getFullInvoisData") %>',--%>
                        url: '<%= ResolveUrl("~/FORMS/PINJAMAN/SOKONGAN/Pinj_Sokongan_WS.asmx/getFullSokonganData") %>',
                        method: "POST",
                        data: JSON.stringify({
                            No_Pinj: No_Pinj

                        }),
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        success: async function (data) {
                            data = JSON.parse(data.d)
                            data = data.Payload
                            fillInvoisHdr(data.hdr[0])
                            console.log('Kat_Pij ' + data.hdr[0].Kategori_Pinj)
                            //retrive table ulasan
                            retrieveUlasanSokongan(data.hdr[0].Kategori_Pinj)
                            resolve(true)
                        },
                        error: function (xhr, status, error) {
                            console.error(error);
                            reject(false)
                        }
                    })
                })
            }
            var cacheInvois = null
            function fillInvoisHdr(inv) {
                cacheInvois = inv

                $("#txtnopinj").val(inv.No_Pinj)
                $("#txtnama").val(inv.No_Pinj + "\t\t\t" + inv.MS01_Nama)
                $("#txtnostaf").val(inv.No_Staf)
                $("#txtnokp").val(inv.MS01_KpB)
                $("#txttarafpkhd").val(inv.Taraf)
                $("#txtgredgaji").val(inv.MS02_GredGajiS)
                $("#txtjawatan").val(inv.Jawatan)
                $("#txtjabatan").val(inv.Pejabat)
                $("#txtkumppkhd").val(inv.Kumpulan)
                $("#txtdob").val(inv.MS01_TkhLahir)
                $("#txtumur").val(inv.AgeFormatted)
                $("#txttarikhlantikan").val(dateStrFromSQl(inv.MS02_TkhLapor))
                $("#txttarikhsah").val(inv.MS02_TkhSah)
                $("#txtgajipokok").val(inv.MS02_JumlahGajiS)
                $("#txtvoipno").val(inv.MS01_VoIP)

                $("#txtkatpinj").val(inv.KatPinj)
                $("#txtamaunpinj").val(inv.Amaun_Mohon)
                $("#txttkhmohon").val(inv.TkhMohon)
                $("#txtjenpinj").val(inv.JenisPinj)
                $("#txttempoh").val(inv.TempohPinj)
                $("#txtansuran").val(inv.Ansuran)
                $("#txtkelayakan").val(inv.Kelayakan)
                $("#txtinsentifamaun").val(inv.amaun_insentif)
                $("#txtinsentifno").val(inv.no_insentif)
            }

            $('#selectAll').click(function (e) {
                if ($(this).hasClass('checkedAll')) {
                    $('input').prop('checked', false);
                    $(this).removeClass('checkedAll');
                } else {
                    $('input').prop('checked', true);
                    $(this).addClass('checkedAll');
                }
            });

            function retrieveUlasanSokongan(Kategori_Pinj) {
                console.log(Kategori_Pinj)
                show_loader()
                $.ajax({
                    url: '<%= ResolveUrl("~/FORMS/PINJAMAN/SOKONGAN/Pinj_Sokongan_WS.asmx/loadUlasanSokongan") %>',
                    method: "POST",
                    data: JSON.stringify({
                        Kategori_Pinj: Kategori_Pinj,
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        data = JSON.parse(data.d)
                        tblTransaksi.clear()
                        tblTransaksi.rows.add(data.Payload).draw()
                    },
                    error: function (xhr, status, error) {
                        close_loader()
                        console.error(error);
                    }
                })
            }

            ///////// senarai invois
            function loadInvoisLists(dateStart, dateEnd) {
                console.log('load invois')

                if (!dateEnd) {
                    dateEnd = ""
                }
                if (!dateStart) {
                    dateStart = ""
                }

                show_loader()
                $.ajax({
                    url: '<%= ResolveUrl("~/FORMS/PINJAMAN/SOKONGAN/Pinj_Sokongan_WS.asmx/loadSokonganData") %>',
                    method: "POST",
                    data: JSON.stringify({
                        DateStart: dateStart,
                        DateEnd: dateEnd
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
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

            function dateFilterHandler(e) {
                if (e.target.value == "select") {
                    $("#specificDateFilter").show()
                }
                else {
                    $("#specificDateFilter").hide()
                }
            }

            function loadPermohonan() {
                if ($("#invoisDateFilter").val() == "select") {
                    let dateStart = $("#txtTarikhStart").val()
                    let dateEnd = $("#txtTarikhEnd").val()
                    if (dateStart == "") {
                        dialogMakluman("sila pilih tarikh carian")
                        return
                    }
                    loadInvoisLists(dateStart, dateEnd)
                }
                else if ($("#invoisDateFilter").val() == "all") {
                    loadInvoisLists()

                }
                else {
                    let days = $("#invoisDateFilter").val()
                    let dateString = toSqlDateString(getDateBeforeDays(days))
                    loadInvoisLists(dateString, "")
                }
            }
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


            function dateStrFromSQl(dateString) {
                try {

                    var dateComponents = dateString.split("T")[0].split("-");
                    var year = dateComponents[0];
                    var month = dateComponents[1];
                    var day = dateComponents[2];

                    return formattedDate = year + "-" + month + "-" + day;
                }
                catch (e) {
                    return ''
                }
            }

            function showError(errors) {
                let msg = ""
                errors.forEach(e => {
                    msg += e + "<br>"
                })
                dialogMakluman(msg)
            }

            function dialogPengesahan(msg) {
                $("#dialogConfirmContent").html(msg)
                var decision = false

                return new Promise(function (resolve) {
                    $("#modalDialogConfirm").modal('show')

                    $('#btnDialogModalConfirm').on('click', function () {
                        decision = true // Confirm button clicked
                    });
                    $('#modalDialogConfirm').on('hidden.bs.modal', function (e) {
                        resolve(decision); // Modal closed without confirming
                    });

                });
            }

            var queueMakluman = []
            function dialogMakluman(msg) {
                queueMakluman.push(msg)
                if (!$('#modalDialogInfo').hasClass('show')) {
                    showDialogMakluman();
                }

            }

            function showDialogMakluman() {

                if (queueMakluman.length > 0) {
                    var msg = queueMakluman.shift()
                    $("#dialogInfoContent").html(msg)
                    $('#modalDialogInfo').modal('show');

                    $('#modalDialogInfo').one('hidden.bs.modal', function () {
                        showDialogMakluman(); // Process the next alert after the modal is closed 
                    });
                }
            }

            function show_message_async(msg) {
                $("#MessageModal .modal-body").html(msg);
                var decision = false
                return new Promise(function (resolve) {

                    $('.btnYA').click(function () {
                        console.log("rreessoollvveedd")
                        decision = true
                    });
                    $("#MessageModal").on('hidden.bs.modal', function () {
                        resolve(decision);
                    });


                    $("#MessageModal").modal('show');
                })

            }

            function toSqlDateString(date) {
                let dd = date.getDate();
                let mm = date.getMonth() + 1; // January is 0!
                let yyyy = date.getFullYear();

                if (dd < 10) {
                    dd = '0' + dd;
                }

                if (mm < 10) {
                    mm = '0' + mm;
                }

                return yyyy + '-' + mm + '-' + dd;
            }

            function getDateBeforeDays(days) {
                let pastDate = new Date();
                pastDate.setDate(pastDate.getDate() - days);
                return pastDate;
            }

        </script>
    </contenttemplate>
</asp:Content>


