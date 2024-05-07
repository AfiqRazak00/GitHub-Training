<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Spesifikasi_Teknikal.aspx.vb" Inherits="SMKB_Web_Portal.Spesifikasi_Teknikal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Spesifikasi Teknikal</title>

    <script src="https://code.jquery.com/jquery-3.5.1.js" crossorigin="anonymous"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>


    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous" />
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <style>

        #tblSpekTeknikal, #tblSpekTeknikal th, #tblSpekTeknikal td {
            border: 1px solid black;
            border-collapse: collapse;
        }

        #tblSpekTeknikal thead > tr > th {
            border-bottom: 1px solid;
       
        }

        .pheader {
            /* text-align: center;*/ 
            font-size: 14px;
            font-weight: bold;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        .pheader2 {
            /* text-align: center; */ 
            font-size: 14px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        .ptarikh {
            font-size: 12px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

            <div id="masterdiv" class="container">

            <div id="headerreport" class="">
                <table id="tbl1" style="width:98%;border:0px unset;margin-top:10px">
                    <tr>
                        <td style="width: 20%"></td>
                        <td style="width: 20%; text-align: right">
                            <asp:Image ID="imgMyImage" runat="server" Style="width: 140px; height: 80px; text-align: right" /> 
                        </td>
                        <td style="width: 40%">
                            <p class="pheader"><strong>Universiti Teknikal Malaysia Melaka</strong></p>
                            <p class="pheader2">Hang Tuah Jaya,76100, Durian Tunggal,Melaka</p>
                            <p class="pheader2">No Tel: +606-270 1019  Fax:+606-331 6115</p>
                        </td>
                        <td style="width: 20%; text-align: right">
                            <span class="ptarikh">Tarikh : <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") %></span><br />
<%--                        <span class="ptarikh">Laporan : SPESIFIKASI AM</span><br />--%>
                            <span class="ptarikh">Pengguna :<%= Session("ssusrID") %></span>

                        </td>
                    </tr>
                </table>
                      <h4 class="text-center">PENENTUAN TEKNIKAL</h4>
                <br />
            </div>
        </div>



        <div class="container">
            <div class="col-md-12">
                <div class="transaction-table table-responsive">
                    <table id="tblSpekTeknikal" class="table table-striped" style="width: 99%; border-color: black">
                        <thead>
                            <tr>
                                <th scope="col" class="text-center">BIL</th>
                                <th scope="col" class="text-center">SPESIFIKASI AM/ TEKNIKAL/ FAKULTI/ JABATAN</th>
                            </tr>
                            <tr>
                                <th scope="col">2.0</th>
                                <th scope="col" class="text-center">TECHNICAL SPECIFICATION</th>
                            </tr>
                        </thead>

                        <tbody>
                        </tbody>

                        <tfoot>
                        </tfoot>
                    </table>

                </div>
            </div>


        </div>

             <br/><br/>
             <div style="text-align:center">
                <span><strong>*** Teknikal Tamat ***</strong></span>
            </div>
            <br/><br/>

        <script type="text/javascript">


            var tbl = null;

            $(document).ready(function () {
                tbl = $("#tblSpekTeknikal").DataTable({
                    "responsive": true,
                    "searching": false,
                    "info": false,
                    "paging": false,
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
                        "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadSpekTeknikalReport") %>',
                        type: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function (d) {
                            return JSON.stringify({ id: '<%=Session("no_mohon_spek")%>' });

                        },
                        "dataSrc": function (json) {
                            return JSON.parse(json.d);
                        }
                    },

                    "columns": [
                        {
                            "data": null,
                            "width": "8%",
                            "render": function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }
                                if (data.Level === 1) {
                                    return `<b>${data.Bil}<b/>`;
                                }

                                return `<div style="text-align:right">${data.Bil}</div>`;
                            },
                        },  

                        {
                            "data": null,
                            "width": "92%",
                            "render": function (data, type, row, meta) {
                                if (type !== "display") {
                                    return data;
                                }
                                if (data.Level === 1) {
                                    return `<b>${data.Butiran}<b/>`;
                                }

                                return `${data.Butiran}`;
                            },
                        }, 

                    ],
                    
                });

            });


        </script>
    </form>
</body>
</html>
