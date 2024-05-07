<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Penetapan_Tarikh.aspx.vb" Inherits="SMKB_Web_Portal.Penetapan_Tarikh" %>

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


    <div id="PermohonanTab" class="tabcontent" style="display: block">
   
        <!-- Modal -->
        <div>
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Papar Penetapan Tarikh</h5>                
                         <button type="button" class="btn btn-primary"  data-dismiss="modal" onclick="ShowPopup('2')"><i class="fa fa-plus"></i>Tambah Senarai 
                           
                        </button>
</div>
                <div class="modal-body">

                    <div class="transaction-table table-responsive">
                        <div class="col-md-12">
                            <table id="tblDataSenarai_trans" class="table table-striped" style="width: 95%">
                                <thead>

                                    <tr>
                                        <th scope="col">Tahun Bajet</th>
                                        <th scope="col">Tarikh Akhir Baki Vot dibaca semasa proses Pertengahan Tahun</th>
                                        <th scope="col">Tarikh Akhir Baki Vot dibaca semasa proses Akhir Tahun :</th>
                                </thead>
                                <tbody id="tableID_Senarai_trans">
                                </tbody>

                            </table>


                        </div>
                    </div>
                </div>
            </div>

        </div>
        <!-- Modal -->
        <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Tambah Penetapan Tarikh</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group col-md-12">
                                    <label>Tahun Bajet :</label>
                                    <input id="txtTahunBajet" type="text" class="form-control" enable="true" style="width: 40%">
                                </div>
                                <div class="form-group col-md-12">
                                    <label>Tarikh Akhir Baki Vot dibaca semasa proses Pertengahan Tahun :</label>
                                    <input id="txtTkhPertengahan" type="date" class="form-control" enable="true" style="width: 40%">
                                </div>
                                <div class="form-group col-md-12">
                                    <label>Tarikh Akhir Baki Vot dibaca semasa proses Akhir Tahun :</label>
                                    <input id="txtTkhAkhir" type="date" class="form-control" enable="true" style="width: 40%">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                        <button type="button" runat="server" id="btnSimpan" class="btn btn-secondary btnSimpan">Simpan</button>

                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Tolong Sahkan?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <asp:Label runat="server" ID="lblModalMessaage" />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal  -->
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
                        data-dismiss="modal">
                        Tidak</button>
                    <button type="button" class="btn default-primary btnYa" runat="server">Ya</button>
                </div>
            </div>
        </div>
    </div>

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

    <!-- Modal -->
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

    <script type="text/javascript">

        var tbl = null

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
                    "url": "Pertengahan_Tahun_WS.asmx/LoadSenaraiTarikhBajet",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
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
                        rowClickHandler(data.Tahun_Bajet);

                    });
                },
                "columns": [

                    { "data": "Tahun_Bajet", "className": "text-center" },
                    { "data": "Tarikh_View_Belanja_Semakan_Bajet", "className": "text-center" },
                    { "data": "Tarikh_View_Belanja_Akhir_Tahun", "className": "text-center" }


                ]

            });

        });

        // add clickable event in DataTable row
        async function rowClickHandler(id) {
            if (id !== "") {
                
                $('#permohonan').modal('toggle');

                //BACA DATA TARIKH
                var recordHdr = await AjaxGetRecordTkh(id);
                await AddRowHeader(null, recordHdr);

            }
        }

        async function AjaxGetRecordTkh(id) {

            try {

                const response = await fetch('Pertengahan_Tahun_WS.asmx/LoadDataTkh', {
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
                await setValueToRow_HdrTkh(objOrder.Payload[counter - 1]);
            }
            // console.log(objOrder)
        }

        async function setValueToRow_HdrTkh(orderDetail) {

            $('#txtTahunBajet').val(orderDetail.Tahun_Bajet)
            $('#txtTkhPertengahan').val(orderDetail.Tarikh_View_Belanja_Semakan_Bajet)
            $('#txtTkhAkhir').val(orderDetail.Tarikh_View_Belanja_Akhir_Tahun)
         

            //var newId = $('#ddlJenTransaksi')

            ////await initDropdownPtj(newId)
            ////$(newId).api("query");

            //var ddlJenTransaksi = $('#ddlJenTransaksi')
            //var ddlSearch = $('#ddlJenTransaksi')
            //var ddlText = $('#ddlJenTransaksi')
            //var selectObj_JenisTransaksi = $('#ddlJenTransaksi')
            //$(ddlJenTransaksi).dropdown('set selected', orderDetail.Jenis_Trans);
            //selectObj_JenisTransaksi.append("<option value = '" + orderDetail.Jenis_Trans + "'>" + orderDetail.ButiranJenis + "</option>")
        }

    </script>

    <script type="text/javascript">      

        function ShowPopup(elm) {

            if (elm == "1") {
                $('#permohonan').modal('toggle');

            }
            else if (elm == "2") {
                $(".modal-body input").val("");

                $('#permohonan').modal('toggle');
            }


        };

        $('.btnSimpan').click(async function () {
            //alert("a")
            $('#confirmationModal').modal('toggle');

        });

        $('.btnYa').click(async function () {

            $('#confirmationModal').modal('toggle');
            $('#permohonan').modal('toggle');
            var jumRecord = 0;
            var acceptedRecord = 0;
            var msg = "";
            //alert("TahunBajet"+ $('#txtTahunBajet').val())
            var newOrder_Pertengahan = {
                Order_Pertengahan: {
                    TahunBajet: $('#txtTahunBajet').val(),
                    TkhPertengahan: $('#txtTkhPertengahan').val(),
                    TkhAkhir: $('#txtTkhAkhir').val(),
                }
            }

            //console.log(newOrder_Pertengahan)

            //var result = JSON.parse(await ajaxSaveOrder(newOrder_Pertengahan));
            var result = JSON.parse(await ajaxSaveOrder(newOrder_Pertengahan));
            //let result = await ajaxSaveOrder(newOrder_Pertengahan).catch(function (err) {
            //    //alert("aa");
            //    notification("Maklumat gagal di simpan.")
            //})

            //result = JSON.parse(result)

            //console.log("aa")
            //alert(result.Message)
            if (result.Status !== "Failed") {

                // open modal makluman and show message
                $('#maklumanModalBil').modal('toggle');
                $('#detailMaklumanBil').html(result.Message);

                $('#txtTahunBajet').val("");
                $('#txtTkhPertengahan').val("");
                $('#txtTkhAkhir').val("");

                // refresh page after 2 seconds
                setTimeout(function () {
                    tbl.ajax.reload();
                }, 2000);
            } else {
                // open modal makluman and show message
                $('#maklumanModalBil').modal('toggle');
                $('#detailMaklumanBil').html(result.Message);

            }


        });

        async function ajaxSaveOrder(Order_Pertengahan_value) {
            //alert(Order_Pertengahan)
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Pertengahan_Tahun_WS.asmx/SaveOrders_Bajet',
                    method: 'POST',
                    data: JSON.stringify(Order_Pertengahan_value),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }

                });
            })

        }


        function notification(msg) {
            $("#notify").html(msg);
            $("#NotifyModal").modal('show');
        }

    </script>
</asp:Content>
