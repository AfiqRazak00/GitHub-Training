
<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Lejar_Pemiutang.aspx.vb" Inherits="SMKB_Web_Portal.Lejar_Pemiutang" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <style>
        .dropdown-list {
            width: 100%;
            /* You can adjust the width as needed */
        }
    
        .align-right {
            text-align: right;
        }
    
        .center-align {
            text-align: center;
        }
        #tblDataSenarai_LejarPemiutang td:hover {
            cursor: pointer;
        }
    </style>
    <contenttemplate>
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <!-- Modal -->
            <div id="permohonan">
                <div>
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalCenterTitle">Laporan Transaksi Lejar Pemiutang</h5>
                        </div>
            
                        <!-- Create the dropdown filter -->
                        <div class="search-filter">
                            <div class="form-row justify-content-center">
                                <div class="form-group row col-md-6">
                                    <label for="syarikat" class="col-sm-2 col-form-label" style="text-align: right">Syarikat
                                        :</label>
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                            <asp:DropDownList ID="syarikat" runat="server" DataTextField="Nama"
                                                DataValueField="Nama" class="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />
            
                            <div class="form-row justify-content-center">
                                <div class="form-group row col-md-6">
                                    <label for="ptj" class="col-sm-2 col-form-label" style="text-align: right">Ptj :</label>
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                            <asp:DropDownList ID="ptj" runat="server" DataTextField="Pejabat"
                                                DataValueField="KodPejabat" class="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <br />
            
                            <div class="form-row justify-content-center">
                                <div class="form-group row col-md-6">
                                    <label for="tahun" class="col-sm-2 col-form-label" style="text-align: right">Tahun :</label>
                                    <div class="col-sm-6">
                                        <div class="input-group">
                                            <asp:DropDownList ID="tahun" runat="server" CssClass="form-control"></asp:DropDownList>
                                        </div>
                                    </div>
                                    <button id="btnSearch" runat="server" class="btn btnSearch" onclick="return beginSearch();"
                                        type="button">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>
                            </div>
                            <br />
                        </div>
            
                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblDataSenarai_LejarPemiutang" class="table table-striped" style="width: 100%">
                                        <thead>
                                            <tr >
                                                <th colspan="2" style="text-align:center;border-right:1px solid lightgrey">Maklumat Pemiutang</th>
                                                <th colspan="5" style="text-align:center;border-right:1px solid lightgrey">Carta Akaun</th>
                                                <th scope="col" colspan ="2" style="text-align:center;border-right:1px solid lightgrey">Jan</th>
                                                <th scope="col" colspan ="2" style="text-align:center;border-right:1px solid lightgrey">Feb</th>
                                                <th scope="col" colspan ="2" style="text-align:center;border-right:1px solid lightgrey">Mac</th>
                                                <th scope="col" colspan ="2" style="text-align:center;border-right:1px solid lightgrey">Apr</th>
                                                <th scope="col" colspan ="2" style="text-align:center;border-right:1px solid lightgrey">Mei</th>
                                                <th scope="col" colspan ="2" style="text-align:center;border-right:1px solid lightgrey">Jun</th>
                                                <th scope="col" colspan ="2" style="text-align:center;border-right:1px solid lightgrey">July</th>
                                                <th scope="col" colspan ="2" style="text-align:center;border-right:1px solid lightgrey">Ogos</th>
                                                <th scope="col" colspan ="2" style="text-align:center;border-right:1px solid lightgrey">Sep</th>
                                                <th scope="col" colspan ="2" style="text-align:center;border-right:1px solid lightgrey">Okt</th>
                                                <th scope="col" colspan ="2" style="text-align:center;border-right:1px solid lightgrey">Nov</th>
                                                <th scope="col" colspan ="2" style="text-align:center">Dis</th>
                                            </tr>
                                            <tr>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">No. Pemiutang</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Nama Pemiutang</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kod KW</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kod Operasi</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kod PTJ</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kod Vot</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kod Projek</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Kt</th>
                                                <th scope="col" style="text-align:center;border-right:1px solid lightgrey">Dt</th>
                                                <th scope="col" style="text-align:center">Kt</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableID_Senarai_LejarPemiutang">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <div class="modal fade" id="modalshowvote" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-dialog-scrollable">

                <div class="modal-content modal-xl">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title" id="exampleModalLabel">Laporan Lejar Pemiutang</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div style="margin: 8px 0px">
                            <strong>No. Pemiutang :</strong> <span id="nopmtg"></span>
                            <br /><strong>Nama Pemiutang :</strong> <span id="namapmtg"></span>
                            <br /><strong>Kod KW :</strong> <span id="kodkw"></span>&nbsp;&nbsp;
                            <strong>Kod Operasi :</strong> <span id="kodko"></span>&nbsp;&nbsp;<br />
                            <strong>Kod PTJ :</strong> <span id="kodptj"></span>&nbsp;&nbsp;
                            <strong>Kod Vot :</strong> <span id="kodvot"></span>&nbsp;&nbsp;
                            <strong>Kod Projek :</strong> <span id="kodprojek"></span>
                            <br>
                        </div>

                        <div class="table-responsive">
                            <table id="namatable" class="table table-bordered table-striped w-100">
                                <thead>
                                    <tr>
                                        <th scope="col">Bulan</th>
                                        <th scope="col">Debit (RM)</th>
                                        <th scope="col">Kredit (RM)</th>
                                    </tr>

                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="modal-footer modal-footer--sticky" style="padding: 0px!important">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    </contenttemplate>
    <script type="text/javascript">

        var tbl = null;
        var thn = '';

        $(document).ready(function () {

            // set asp:DropDownList ID="ptj" to default value
            $('#<%=ptj.ClientID%>').val('00');

            tbl = $("#tblDataSenarai_LejarPemiutang").DataTable({
                "responsive": true,
                "searching": true,
                cache: true,
                dom: 'Bfrtip',
                buttons: [
                    'csv', 'excel', {

                        extend: 'print',
                        text: '<i class="fa fa-files-o green"></i> Print',
                        titleAttr: 'Print',
                        className: 'ui green basic button',
                        action: function (e, dt, button, config) {
                            window.open('<%=ResolveClientUrl("~/index.aspx")%>', '_blank');

                        }
                    }
                ],

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
                "rowCallback": async function (row, data, index) {
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });
                },
                "ajax":
                {
                    "url": "LejarPemiutangWS.asmx/LoadOrderRecord_TransaksiLejarPemiutang",
                    type: 'POST',
                    data: function (d) {
                        return "{ tahun: '" + $('#<%=tahun.ClientID%>').val() + "',syarikat: '" + $('#<%=syarikat.ClientID%>').val() + "', ptj: '" + $('#<%=ptj.ClientID%>').val() + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }
                },
                "drawCallback": function (settings) {
                    // Your function to be called after loading data
                    close_loader();
                },
                "columns": [
                    { "data": "Kod_Pemiutang" },
                    { "data": "Nama_Pemiutang" },
                    { "data": "Kod_Kump_Wang" },
                    { "data": "Kod_Operasi" },
                    { "data": "Kod_PTJ" },
                    { "data": "Kod_Vot" },
                    { "data": "Kod_Projek" },
                    { "data": "Dr_1", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_1", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Dr_2", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_2", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Dr_3", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_3", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Dr_4", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_4", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Dr_5", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_5", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Dr_6", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_6", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Dr_7", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_7", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Dr_8", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_8", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Dr_9", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_9", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Dr_10", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_10", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Dr_11", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_11", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Dr_12", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                    { "data": "Cr_12", "render": function (data) { return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 }); }, "className": "align-right" },
                ]
            });


        });

        function beginSearch() {
            show_loader();
            tbl.ajax.reload();
        }

        //method ganti rowcallback
        $('#tblDataSenarai_LejarPemiutang').on('click', 'tr', function () {
            var row = tbl.row(this);
            GetVotDetails(row.data());
        });

        function GetVotDetails(data) {
            console.log(data);
            $('#nopmtg').text(data.Kod_Pemiutang);
            $('#namapmtg').text(data.Nama_Pemiutang);
            $('#kodkw').text(data.Kod_Kump_Wang);
            $('#kodko').text(data.Kod_Operasi);
            $('#kodptj').text(data.Kod_PTJ);
            $('#kodvot').text(data.Kod_Vot);
            $('#kodprojek').text(data.Kod_Projek);
            $('#modalshowvote').modal('toggle');
            $('#namatable tbody').html("");
            $('#jumTotalDebit').val(0);
            $('#jumTotalKredit').val(0);
            $.ajax({
                url: 'LejarPemiutangWS.asmx/LoadVotPmtgDetails',
                method: 'POST',
                data: JSON.stringify({
                    KodVot: data.Kod_Vot,
                    KodPtj: data.Kod_PTJ,
                    Tahun: $('#<%=tahun.ClientID%>').val(),
                    KodKW: data.Kod_Kump_Wang,
                    KodOperasi: data.Kod_Operasi,
                    KodProjek: data.Kod_Projek,
                    KodPmtg: data.Kod_Pemiutang
                }),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    data = JSON.parse(data.d);
                    console.log(data);
                    var counter = 0;
                    var totalDebits = 0;
                    var totalKredits = 0;

                    while (counter < data.length) {
                        totalDebits = totalDebits + data[counter].Debit;
                        totalKredits = totalKredits + data[counter].Kredit;

                        var formattedDebit = formatNumber(data[counter].Debit);
                        var formattedKredit = formatNumber(data[counter].Kredit);

                        $('<tr>')
                            .append($('<td>').html(data[counter].namaBulan))
                            .append($('<td>').html(formattedDebit).addClass("align-right"))
                            .append($('<td>').html(formattedKredit).addClass("align-right"))
                            .appendTo($('#namatable tbody'));
                        counter++;
                    }
                    $('#jumTotalDebit').val(formatNumber(totalDebits));
                    $('#jumTotalKredit').val(formatNumber(totalKredits));

                    $('<tr>')
                        .append('<td><strong>Jumlah</strong></td>')
                        .append('<td class="align-right"><strong>' + formatNumber(totalDebits) + '</strong></td>')
                        .append('<td class="align-right"><strong>' + formatNumber(totalKredits) + '</strong></td>')
                        .appendTo($('#namatable tbody'));

                    function formatNumber(number) {
                        return new Intl.NumberFormat('en-US', {
                            style: 'decimal',
                            minimumFractionDigits: 2,
                            maximumFractionDigits: 2
                        }).format(number);
                    }


                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                }
            });
        }
    </script>
</asp:Content>

