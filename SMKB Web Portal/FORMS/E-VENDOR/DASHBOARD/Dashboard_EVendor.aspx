<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Dashboard_EVendor.aspx.vb" Inherits="SMKB_Web_Portal.Dashboard_EVendor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <div id="permohonan" class="tabcontent" style="display: block;">
        <div class="tab-content">

            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <i class="far fa-bell fa-lg"></i>Pemberitahuan
                    </div>
                    <div class="card-body">
                        <div class="col-md-12">
                            <div id="Pemberitahuan" class="d-inline-flex align-items-center">
                                <i class="fas fa-info-circle fa-lg mr-1"></i>
                                <!-- <label id="info"></label> -->
                            </div>
                        </div>
                    </div>

                    <div class="card-footer">
                        <div class="col-md-12">
                        </div>
                    </div>
                </div>
            </div>


            <div class="col-md-12 mt-4">
                <div class="row">
                    <div class="col-md-4">
                        <div class="card">
                            <div class="card-header">
                                Bilangan
                            </div>
                            <div class="card-body">
                                <div class="col-md-12">
                                    <div id="GrafBil"></div>
                                </div>
                            </div>

                            <div class="card-footer">
                                <div class="col-md-12">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header">
                                <ul class="nav nav-tabs" id="myTabs">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#Iklan">Tawaran Iklan <%--<span id="BilSebutHargaBadgeUni" class="badge badge-danger blink_badge" style="display: none;"></span>--%></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#Jadual">Jadual Paparan <%--<span id="BilSebutHargaBadgePTJ" class="badge badge-danger blink_badge" style="display: none;"></span>--%></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#Syarikat">Syarikat Dilantik <%--<span id="BilSebutHargaBadgeTender" class="badge badge-danger blink_badge" style="display: none;"></span>--%></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" data-toggle="tab" href="#Arkib">Arkib <%--<span id="BilSebutHargaBadgeTender" class="badge badge-danger blink_badge" style="display: none;"></span>--%></a>
                                    </li>
                                </ul>
                            </div>
                            <div class="card-body">
                                <div class="col-md-12">
                                </div>
                            </div>

                            <div class="card-footer">
                                <div class="col-md-12">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <footer>
                <hr />
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-3"></div>
                        <div class="col-md-3">
                            <p>Hubungi Kami</p>
                            <p>Unit Perolehan, Pejabat Bendahari, UTeM</p>
                            <p>06-331 6107/ 6322/ 6094/ 6090</p>
                        </div>
                        <div class="col-md-3">
                            <p>Dasar E-Perolehan</p>
                            <p>Dasar Keselamatan</p>
                            <p>Dasar Privasi</p>
                            <p>Dasar Pendaftaran Vendor</p>
                            <p>Dasar Muatnaik Dokumen</p>
                            <p>Dasar Aduan, Cadangan dan Pertanyaan</p>
                        </div>
                        <div class="col-md-3"></div>
                    </div>
                </div>
                <hr />
            </footer>
        </div>
    </div>

    <script type="text/javascript">

        async function AjaxLoadInfo() {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'DashboardEvendor_WS.asmx/LoadList_Info',
                    method: 'POST',
                    data: JSON.stringify(),
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
            });
        }

        $(document).ready(function () {
            LoadDataInfo(); // Call LoadDataInfo() when the document is ready
        });

        async function LoadDataInfo() {
            var DataInfo = JSON.parse(await AjaxLoadInfo());
            if (DataInfo.length > 0) {
                // Start the blinking animation
                var counter = 0; // Counter to keep track of the current message index
                var infoCount = DataInfo.length;

                // Preload all info into a separate div
                for (var i = 0; i < infoCount; i++) {
                    $('#Pemberitahuan').append('<div class="infoMessage">' + DataInfo[i].Info + '</div>');
                }

                // Start animation
                setInterval(() => {
                    $('.infoMessage').eq(counter).fadeIn(500).delay(2000).fadeOut(500);
                    counter = (counter + 1) % infoCount; // Increment counter for next message
                }, 3000); // Change blinking interval as needed (here set to 3 seconds)

            } else {
                $('#info').html("Tiada Maklumat");
            }
        }




    </script>
</asp:Content>
