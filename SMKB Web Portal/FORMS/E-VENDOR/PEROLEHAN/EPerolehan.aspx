<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="EPerolehan.aspx.vb" Inherits="SMKB_Web_Portal.EPerolehan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

     <style>
        .nospn {
            -moz-appearance: textfield;
        }

            .nospn::-webkit-outer-spin-button,
            .nospn::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }



        #permohonan .modal-body {
            max-height: 70vh; /* Adjust height as needed to fit your layout */
            min-height: 70vh;
            overflow-y: scroll;
            scrollbar-width: thin;
        }

        #subTab a {
            cursor: pointer;
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
    </style>

    <div class="modal-header">
        <h5 class="modal-title" id="titleMklmtPerolehan">Maklumat Perolehan Sebut Harga</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>

    <div class="modal-body">
        <div class="col-md-12">
            <div class="transaction-table table-responsive">
                <table id="tblDataPembelianNaskah" class="table table-striped" style="width: 100%">
                    <thead>
                        <tr data-id="">
                            <th scope="col">Bil</th>
                            <th scope="col">Tajuk Projek</th>
                            <th scope="col">PTJ</th>
                            <th scope="col">Tarikh Dipamer</th>
                            <th scope="col">Tarikh Dijual</th>
                            <th scope="col">Tarikh & Masa Ditutup</th>
                            <th scope="col">Harga Naskah Meja (RM)</th>
                            <th scope="col">Order ID</th>
                            <th scope="col">Status Hantar</th>
                            <th scope="col">Status Cetak</th>
                        </tr>
                    </thead>
                    <tbody id="tableID_Senarai_Naskah">
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script type="text/javascript">


        var startDateTime;
        var EndDateTime;

        var tbl = null;
        $(document).ready(function () {
            /* show_loader();*/
            tbl = $("#tblDataPembelianNaskah").DataTable({
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
                    "url": "EPerolehan_WS.asmx/LoadList_JawabPembelian",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    "data": function () {
                        //Filter by Session Syarikat
                        return JSON.stringify({
                            //idSemSya: '<%=Session("ssusrID")%>',
                        })
                    }
                },
                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });

                    //Add click event
                    $(row).on("click", function () {
                        var startDateTime = data.TkhPamer;
                        var EndDateTime = data.TkhTutup;
                        var IdPembelian = data.OrderID;
                        rowClickHandler(startDateTime, EndDateTime, IdPembelian);
                    });
                },
                "drawCallback": function (settings) {
                    // Your function to be called after loading data
                    /*close_loader();*/
                },
                "columns": [
                    {
                        "target": 0,
                        "render": function (data, type, row, meta) {
                            return meta.row + 1;
                        },
                        "orderable": false,
                    },
                    /*{ "data": "IdPengalaman"},*/
                    { "data": "Tajuk" },
                    { "data": "Pejabat" },
                    { "data": "TkhPamer" },
                    { "data": "TkhDiJual" },
                    {
                        "data": "TkhTutup",
                        "render": function (data, type, row) {
                            return formatMalayDate(data);
                        }
                    },
                    {
                        "data": "HargaMeja",
                        "render": function (data, type, row) {
                            // Assuming data is a numeric value representing the total tunggak
                            return parseFloat(data).toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2 });
                        }
                    },
                    { "data": "OrderID" },
                    {
                        "data": "StatHantar",
                        render: function (data, type, row, meta) {
                            if (data === "" || data === null || data === "0") {
                                return "BELUM HANTAR";
                            } else if(data == "1") {
                                return "SELESAI HANTAR";
                            }
                        }
                    },
                    {
                        "data": "StatCetak",
                        render: function (data, type, row, meta) {
                            if (data === "" || data === null || data === "0") {
                                return "BELUM DICETAK";
                            } else if (data == "1") {
                                return "SELESAI DICETAK";
                            }
                        }
                    },
                ]
            });
        });

        async function rowClickHandler(StartDateTime, EndDateTime, IdPembelian) {
            var Url = '<%=ResolveClientUrl("~/FORMS/E-VENDOR/PEROLEHAN/Maklumat_ePO.aspx")%>?StartDate=' + StartDateTime + '&EndDate=' + EndDateTime + '&IdPembelian=' + IdPembelian;
            window.location.href = Url;
            //return false;
        }

        function formatMalayDate(dateString) {
            // Assuming dateString is in the format "Sunday, 25 January 2023, 10.00 AM"

            // Parse the English date string into a JavaScript Date object
            var date = new Date(dateString);

            // Format the date in Malay language with AM/PM
            var options = { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric', hour: 'numeric', minute: 'numeric', hour12: true };
            var formattedDate = date.toLocaleDateString('ms-MY', options);

            return formattedDate;
        }

    </script>
</asp:Content>
