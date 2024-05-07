<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pengesahan_Pendaftaran.aspx.vb" Inherits="SMKB_Web_Portal.Pengesahan_Pendaftaran" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <%-- <div class="panel panel-default">
        <div class="panel-heading">
            <br />
            <div class="col-md-12">
                <div class="form-group row col-md-6">
                    <center>
                        <h4 class="panel-title">ID Syarikat/Nama Syarikat</h4>
                    </center>
                </div>
                <br />
            </div>
        </div>
    </div>--%>

    <%--<div class="col-md-12">
        <div class="form-group row col-md-6">
            <h6 class="panel-title">Pengakuan Pembida</h6>
        </div>
    </div>--%>
    <br />
    <br />
    <div class="col-md-12">
        <div class="form-row">
            <div class="form-group col-md-12">
                <center>
                    <img src="../../../Images/logo.png" id="logoUtem" alt="Logo Utem" /></center>
            </div>
            <div class="form-group col-md-12">
                <center>
                    <h4>UNIVERSITI TEKNIKAL MALAYSIA MELAKA</h4>
                </center>
                <center>
                    <h4>UNIT PEROLEHAN</h4>
                </center>
                <center>
                    <h4>BAHAGIAN PENGURUSAN BAJET DAN PEROLEHAN</h4>
                </center>
                <center>
                    <h4>PEJABAT BENDAHARI</h4>
                </center>
                <center>
                    <h4>PERAKUAN PEMBEKAL PENDAFTARAN SYARIKAT</h4>
                </center>
            </div>
            <div class="form-group col-md-12">
                <p>
                    Saya dengan ini mengaku bahawa maklumat yang dikemukakan adalah benar dan bersetuju sekiranya terdapat maklumat yang tidak benar atau dengan sengaja tidak menyatakan perihal sebenar di dalam pemohonan in akan menyebabkan saya tidak dibenarkan berdaftar dengan
                            <b>Universiti Teknikal Malaysia melaka</b>
                    atau menghadapi kemungkinan disenarai hitam oleh
                            <b>Universiti Teknikal Malaysia melaka</b>
                </p>
                <br />
                <p>
                    Saya dengan ini memberi kebenaran kepada Unit Perolehan, Pejabat Bendahari,
                            <b>Universiti Teknikal Malaysia melaka</b>
                    untuk berkongsi maklumat yang terdapat di dalam Maklumat Pendaftaran Pembekal Saya
                </p>
            </div>

            <div class="form-group col-md-12">
                <center>
                    <div class="form-check-inline">
                        <label class="form-check-label">
                            <input type="checkbox" class="form-check-input" id="chckSetuju" value="1">
                            Saya Bersetuju
                        </label>
                    </div>
                </center>
            </div>
            <br />
            <br />
            <div class="form-group col-md-12">
                <center>
                    <button class="btn btn-success btnHantar">Hantar</button></center>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
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
                    <button type="button" class="btn btn-secondary btnYa">Ya</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Makluman Modal -->
    <div class="modal fade" id="maklumanModal" tabindex="-1" role="dialog"
        aria-labelledby="maklumanModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="maklumanModalLabel">Makluman</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <span id="detailMakluman"></span>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" id="tutupMakluman" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>

    <script>

        var setujuValue = ""
        $(document).ready(function () {
            $('#chckSetuju').change(function () {
                var isSetuju = $(this).is(':checked');
                setujuValue = isSetuju.toString();
                //console.log("Value Setuju: ", setujuValue);
            });
        });

        async function ajaxSetuju(pengesahan) {

            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'Pendaftaran_WS.asmx/SyarikatSetuju',
                    method: 'POST',
                    data: JSON.stringify(pengesahan),
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

        $('.btnHantar').click(async function (event) {
            event.preventDefault();
            if ($('#chckSetuju').is(':checked') == false) {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html("Sila tanda di ruang yang disediakan");
            } else {
                $('#confirmationModal').modal('toggle');
            }
        });

        $('.btnYa').click(async function () {
            $('#confirmationModal').modal('toggle');

            let NoSya = '<%=Session("ssusrID")%>';

            var DataSyarikat = JSON.parse(await ajaxLoadDataSyarikat(NoSya));

            console.log("DataSyarikat: ", DataSyarikat[0].Nama_Sykt);

            var newSetuju = {
                pengesahan: {
                    NoSya: NoSya,
                    NamaSya: DataSyarikat[0].Nama_Sykt,
                    EmelSya: DataSyarikat[0].Emel_Semasa,
                    EmelAdmin: '',
                    NamaAdmin: '',
                    Setuju: setujuValue,
                }
            }

            console.log("Detail Setuju: ", newSetuju);

            var result = JSON.parse(await ajaxSetuju(newSetuju));

            if (result.Status !== "Failed") {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
                //clearAllFields();
            } else {
                $('#maklumanModal').modal('toggle');
                $('#detailMakluman').html(result.Message);
            }
        });

        async function ajaxLoadDataSyarikat(NoSya) {

            return new Promise((resolve, reject) => {
                $.ajax({

                    url: 'Pendaftaran_WS.asmx/GetEmailSyarikat',
                    method: 'POST',
                    data: JSON.stringify({ NoSya: NoSya }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        console.log("data: ", data.d);
                        resolve(data.d);
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            })
        }

    </script>
</asp:Content>


