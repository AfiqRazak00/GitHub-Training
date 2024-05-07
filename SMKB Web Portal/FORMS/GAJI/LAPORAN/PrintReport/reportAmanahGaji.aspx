<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="reportAmanahGaji.aspx.vb" Inherits="SMKB_Web_Portal.reportAmanahGaji" %>

<%@ Register Src="~/FORMS/GAJI/LAPORAN/PrintReport/TableAmanahGaji.ascx" TagPrefix="Vot" TagName="Table" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <script src="<%=ResolveClientUrl("~/Content/js/jquery.min.js")%> "></script>
    <!-- Bootstrap JS -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script src="https://printjs-4de6.kxcdn.com/print.min.js"></script>
    <title></title>

    <style>
        table {
            border-collapse: separate;
            margin: 0 auto;
            width: 100%;
        }

        .top-border {
            border-top: 1px solid black;
            min-width: 250px;
        }

        .topbottom-border{
            border-top: 1px solid black;
            border-bottom: 3px double black;
            min-width: 250px;
        }

        body {
            font-family: Arial, sans-serif;
        }

        .pheader {
            font-size: 14px;
            font-weight: bold;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        .pheader2 {
            font-size: 14px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        .pheader3 {
            text-align: center;
            font-size: 14px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        .ptarikh {
            font-size: 12px;
            margin-top: 0px !important;
            margin-bottom: 0px !important;
        }

        th, td {
            padding: 1px;
        }

        .headerkiri {
            text-align: center;
        }

        .valuekanan {
            text-align: right;
        }

        .valuetengah {
            text-align: center;
        }

        .bold {
            font-weight: bold;
        }

        .tdbg1 {
            background-color: #DAE0E5;
            font-weight: bold;
        }
        @media print {
            .print-div {
                /*break-after:page;*/
            }

            .header-space,
            .footer, .footer-space {
                height: 180px;
            }

            .header {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                padding: 10px;
                height: 180px; /*Set a fixed height for the header */
            }

            .container {
                margin: unset;
            }
        }

        @page {
            size: A4; /*or letter, legal, etc. */
            margin: 1cm; /*adjust margins as needed */
        }

    </style>
</head>
<body>
    <%--<form id="form1" runat="server">--%>
    <div id="masterdiv" class="container">
        <div id="headerreport" class="header" style="">
            <table>
                <tr>
                    <td style="width: 20%; text-align: right">
                        <asp:Image ID="imgMyImage" runat="server" Style="width: 140px; height: 80px; text-align: right" />
                    </td>
                    <td style="width: 50%; text-align: center">
                        <p class="pheader"><strong>Universiti Teknikal Malaysia Melaka</strong></p>
                        <p class="pheader2">Hang Tuah Jaya,76100, Durian Tunggal,Melaka</p>
                        <p class="pheader2">No Tel: +606-270 1019  Fax:+606-331 6115</p>
                    </td>
                    <td style="width: 30%; text-align: right">
                        <span class="ptarikh">Tarikh : <%= DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss") %></span><br />
                        <span class="ptarikh">Laporan Amanah Gaji</span><br />
                        <span class="ptarikh">Pengguna : <%= Session("ssusrID") %></span>

                    </td>
                </tr>
                <tr>
                    <%--<td></td>--%>
                    <td style="text-align: center" colspan="3">
                        <br />
                        <p class="pheader3"><strong>Laporan Amanah Gaji Bulanan</strong></p>
                        <p class="pheader3">Ptj :
                            <asp:Label runat="server" ID="ptj"></asp:Label></p>
                        <p class="pheader3">
                            Bagi 
                                <asp:Label runat="server" ID="bulan"></asp:Label>
                            <asp:Label runat="server" ID="tahun"></asp:Label>
                        </p>
                    </td>
                    <%--<td style="width: 25%"></td>--%>
                </tr>
            </table>
        </div>
        <div class="vot-table-content">
        <%--<div class="content">--%>
            <Vot:Table runat="server" ID="TableAmanahGaji" CustomClass="TableAmanahGaji" />
        </div>
        <br />
        <div style="text-align: center">
            <span><strong>***** Tamat Laporan *****</strong></span>
        </div>
        <script>
                function printContent() {
                    window.print();
                    return false;
                }
        </script>
    </div>
    <%--close master div--%>
    <%--   </form>--%>
    <script type="text/javascript">
        $(document).ready(function () {
            if (window.addEventListener) {
                window.print();
            } else {
                window.print();
            }
        });

    </script>
</body>
</html>
