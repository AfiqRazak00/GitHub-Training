<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Dashboard.aspx.vb" Inherits="SMKB_Web_Portal.Dashboard" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    
    <style>
        .card {
            background: #FFFFFF;
            border: 1px solid #CDCDCD;
            border-radius: 3px;
            padding: 15px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 170px;
            margin-bottom: 30px;
        }

        .card p {
            font-weight: 600;
            font-size: 1em;
            text-decoration: underline;
            text-align: center;
        }

        .card i {
            font-size: 64px;
            padding-bottom: 10px;
            padding: 15px 0px;
        }
    </style>
    
    <div class="search-filter">
        <div class="justify-content-center">
            <div class="row">

                <div class="col">
                    <div class="card">
                        <p class="">JUMLAH BIL BERSTATUS DRAF</p>
                        <h2 id="txtStatusDraf" runat="server">0</h2>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <p class="">JUMLAH BIL MENUNGGU KELULUSAN</p>
                        <h2 id="txtTungguKelulusan" runat="server">0</h2>
                    </div>
                </div>                        
                <div class="col">
                    <div class="card">
                        <p>JUMLAH BIL YANG TELAH DILULUSKAN</p>
                        <h2 id="txtDiluluskan" runat="server">0</h2>
                    </div>
                </div>                        
            </div>
            <div class="row">
                <div class="col">
                    <div class="card">
                        <p>JUMLAH BIL TERKUMPUL</p>
                        <h2 id="txtTerkumpul" runat="server">0</h2>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <p>JUMLAH (RM) MENUNGGU PEMBAYARAN (18)</p>
                        <h2 id="txtTungguPembayaran" runat="server">0</h2>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <p>JUMLAH (RM) TERTUNGGAK (12)</p>
                        <h2 id="txtTertunggak" class="text-danger" runat="server">0</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-8">
                    <div class="">
                        <p>Senarai Bil Yang Tertunggak</p>
                        <!-- make a table -->
                        <table id="tblTertunggak" class="table table-striped table-bordered table-hover" runat="server">
                            <thead>
                                <tr>
                                    <th>No. Bil</th>
                                    <th>Nama Penghutang</th>
                                    <th>Tarikh Tamat</th>
                                    <th>Jumlah Tertunggak (RM)</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>Ali</td>
                                    <td>12/12/2019</td>
                                    <td>100.00</td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Abu</td>
                                    <td>12/12/2019</td>
                                    <td>100.00</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
