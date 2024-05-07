<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Peruntukan_Universiti.aspx.vb" Inherits="SMKB_Web_Portal.Peruntukan_Universiti" %>

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

        /*  #tblDataSenarai_trans td:hover {
            cursor: pointer;
        }*/


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
            font-size: 12PX;
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
            line-height: 10px;
            color: #01080D;
            opacity: 1;
        }
    </style>



    <div id="PermohonanTab" class="tabcontent" style="display: block">

        <!-- Modal -->
       <div  id="permohonan" >
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Papar Peruntukan Universiti</h5>                        
                    </div>        
  

                    <div class="modal-body">

                        <div class="transaction-table table-responsive">
                            <div class="col-md-12">
                                <table id="tblDataSenarai_trans" class="table table-striped" style="width: 95%" >
                                    <thead>
                                       
                                        <tr>
                                            
                                            <th scope="col">Tahun</th>                                         
                                            <th scope="col">Bajet (RM)</th>
                                            <th scope="col">Tambahan (RM)</th>
                                            <th scope="col">Kurangan (RM)</th>
                                            <th scope="col">Baki BF (RM)</th>
                                            <th scope="col">Jumlah (RM)</th>                                            
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_trans">
                                    </tbody>

                                </table>


                            </div>
                        </div>
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
                    "url": "PeruntukanUniWS.asmx/LoadOrderRecord",
                    "method": 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }                 

                },               
                "columns": [
                  
                    { "data": "Tahun_Bajet" },
                    {
                        "data": "Jumlah_Asal",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        },
                        "className": "text-right"
                    },
                    {
                        "data": "Jumlah_TBH",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        },
                        "className": "text-right"
                    },
                    {
                        "data": "Jumlah_KG",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        },
                        "className": "text-right"
                    },
                    {
                        "data": "Jumlah_BF",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        },
                        "className": "text-right"
                    },
                    {
                        "data": "Jumlah_Besar",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        },
                        "className": "text-right"
                    }
                    


                ]

            });

        });

    </script>


</asp:Content>
