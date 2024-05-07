<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Bulan.aspx.vb" Inherits="SMKB_Web_Portal.Bulan" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <style>
.box {
  box-shadow:
  0 2.8px 2.2px rgba(0, 0, 0, 0.034),
  0 6.7px 5.3px rgba(0, 0, 0, 0.048),
  0 12.5px 10px rgba(0, 0, 0, 0.06),
  0 22.3px 17.9px rgba(0, 0, 0, 0.072),
  0 41.8px 33.4px rgba(0, 0, 0, 0.086),
  0 100px 80px rgba(0, 0, 0, 0.12)
;

  
  
  min-height: 100px;
  width: 30vw;
  margin: 100px auto;
  background: white;
  border-radius: 5px;
  margin-bottom: 15%;
}

</style>
    <div id="PermohonanTab" class="tabcontent" style="display: block">
        
        <div class="container" style=" margin-bottom: 13%;margin-top:0%;margin-left:0%;text-align:center">
        <div class="row">
            <div class="col-md-4 col-sm-6 
                            col-xl-4 my-3">
                <div class="card d-block h-100 
                    box-shadow-hover pointer" >
                  <div class="card-header">
                    Bulan/Tahun Gaji : <label id="lblBlnThnGaji"></label>
                  </div>
                  <div class="card-header">
                    Bulan/Tahun Gaji Seterusnya : <label id="lblNextBlnThnGaji"></label>
                  </div>
                    
                    <div class="card-body p-4">

                        <p>
                            <asp:CheckBox ID="chkProses" runat="server" Text="Pilih untuk membuat Proses Naik Bulan" />
                        </p>
  
                        <p>
                             <button type="button" class="btn btn-secondary btnSah" data-toggle="tooltip" data-placement="bottom" title="Simpan">Simpan</button>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>

        <label id="hidBulan" style="visibility:hidden"></label>
                    <label id="hidTahun" style="visibility:hidden"></label>
                <label id="hidNextBulan" style="visibility:hidden"></label>
                    <label id="hidNextTahun" style="visibility:hidden"></label>
        <label id="hidParam" style="visibility:hidden"></label>
                <div class="totalData" style="display:none">0</div>
        <div class="totalSuccess" style="display:none">0</div>

        <div class="modal fade" id="SpinModal" tabindex="-1" role="dialog">
            <div class="modal-dialog modal-dialog-centered justify-content-center" role="document">
                <span class="fa fa-spinner fa-spin fa-3x"></span>
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
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="ReloadPage();">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script type="text/javascript">

    $(document).ready(function () {
        getBlnThn();
    });
    function notification(msg) {
        $("#notify").html(msg);
        $("#NotifyModal").modal('show');
    }
    function ReloadPage() {
        window.location.reload();
    }

    function getBlnThn() {
        //Cara Pertama
 
        fetch('<%=ResolveClientUrl("~/FORMS/GAJI/PROSES/Proses_WS.asmx/LoadBlnThnGaji")%>', {
            method: 'POST',
            headers: {
                'Content-Type': "application/json"
            },
            //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify()
        })
                .then(response => response.json())
                .then(data => setBlnThn(data.d))

    }
    function setBlnThn(data) {
        var sBulan = "";
        var nextBln = 0;
        var nextThn = 0;
        var sNextBln = "";
        data = JSON.parse(data);

        if (data.bulan === "") {
            alert("Tiada data");
            return false;
        }
        $('#lblBlnThnGaji').text(data[0].butir);
        if (data[0].bulan < 10) {
            sBulan = '0' + data[0].bulan;
        }
        else {
            sBulan = String(data[0].bulan);
        }

        if (data[0].bulan === 12) {
            nextThn = data[0].tahun + 1;
        }
        else {
            nextThn = data[0].tahun;
        }

        nextBln = data[0].bulan + 1;
        sNextBln = nextBln + '/' + nextThn;
        $('#hidBulan').text(data[0].bulan);
        $('#hidTahun').text(data[0].tahun);
        $('#hidParam').text(data[0].tahun + sBulan);
        
        $('#hidNextBulan').text(nextBln);
        $('#hidNextTahun').text(nextThn);
        $('#lblNextBlnThnGaji').text(sNextBln);
    }

<%--    $('.btnSah').click(function () {

        if ($('#<%=chkProses.ClientID%>').is(':checked')) {
            var bln = $('#hidBulan').text();
            var thn = $('#hidTahun').text();
            var nbln = $('#hidNextBulan').text();
            var nthn = $('#hidNextTahun').text();
            var param = $('#hidParam').text();
            //var thn = $('#hidTahun').text;
            //alert(nbln);

            $.ajax({
                "url": "Tutup_WS.asmx/UpdateTutup",
                method: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: JSON.stringify({ bln: bln, thn: thn, nextbln: nbln, nextthn: nthn, param: param }),
                 success: function (response) {
                     console.log('Success', response);
                     var response = JSON.parse(response.d);
                     console.log(response);
                     //alert(response.Message);
                     notification(response.Message);
                     //location.reload();
                     //window.location.reload(1);
                 }
            });

        } else {
            //alert("Sila pilih untuk membuat pengesahan");
            notification("Sila klik pada checkbox untuk membuat pengesahan.");
        }

    });--%>

    $('.btnSah').click(async function () {

        if ($('#<%=chkProses.ClientID%>').is(':checked')) {
            var bln = $('#hidBulan').text();
            var thn = $('#hidTahun').text();
            var nbln = $('#hidNextBulan').text();
            var nthn = $('#hidNextTahun').text();
            var vparam = $('#hidParam').text();

            var totalDataToProcess = await getTotalDataAP();
            
            $('.totalData').html(totalDataToProcess[0].Total);
            //alert($('.totalData').html());

            alert(vparam);
            $.ajax({
                "url": "Tutup_WS.asmx/fProsesTutup",
                method: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: JSON.stringify({ bln: bln, thn: thn, nextbln: nbln, nextthn: nthn, param: vparam  }),
                success: function (response) {
                    //console.log('Success', response);
                    var response = JSON.parse(response.d);
                    console.log(response);
                    ////alert(response.Message);
                    notification(response.Message);
                    //location.reload();
                    //window.location.reload(1);
                }
            });
            GetProgress();

        } else {
            //alert("Sila pilih untuk membuat pengesahan");
            notification("Sila klik pada checkbox untuk membuat pengesahan.");
        }


    });


    async function getTotalDataAP() {
        var bln = $('#hidBulan').text();
        var thn = $('#hidTahun').text();
        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Tutup_WS.asmx/GetTotalTutup',
                method: 'POST',
                data: JSON.stringify({ bln: bln, thn: thn }),

                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    resolve(JSON.parse(response.d));
                }
            });
        })

    }

    async function GetProgress() {
        setTimeout(async function () {
            var progressResult = await AjaxGetProgress();
            var progress = progressResult[0].JumlahSelesai;
            var totalDataProcess = $('.totalData').html();
            var totalPercentage = progress / totalDataProcess * 100;
            //alert(totalDataProcess);

            $('.totalSuccess').html(progress);
            // alert(progress);
            //alert(totalDataProcess);
            //$('.totalPercent').html(parseFloat(totalPercentage).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + "%");

            $('.totalPercent').html(Math.trunc(totalPercentage) + "%");

            //$(".progressBar").attr("style", `width:${totalPercentage}%`)

            show_loaderPercent($('.totalPercent').html());

            var resultStatus = await AjaxCheckStatusProcessing();

            if (resultStatus.length !== 0) {
                $('.totalSuccess').html(totalDataProcess);
                $('.totalPercent').html("100%");
                show_loaderPercent("100%");
                //$('#lblModalMessaage').text('Data selesai dieksport');
                close_loader();
                notification("Proses penetapan bulan gaji berjaya diproses.");
                //SaveSucces();
                return;
            }

            if (progress >= totalDataProcess && totalDataProcess !== 0) {
                //console.log('Success', response);
                //var response = JSON.parse(response.d);
                //console.log(response);

                //$('#lblModalMessaage').text('Data selesa dieksport');
                //$('#MessageModal').modal('toggle');
                notification("Proses penetapan bulan gaji berjaya diproses.");
                return;
            }

            GetProgress();
        }, 1000)
    }

    async function AjaxGetProgress() {

        var bln = $('#hidBulan').text();
        var thn = $('#hidTahun').text();

        return new Promise((resolve, reject) => {

            $.ajax({
                url: 'Proses_WS.asmx/GetProgressTutup',
                method: 'POST',
                data: JSON.stringify({ bln: bln, thn: thn }),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    resolve(JSON.parse(response.d));
                }
            });
        })
    }

    async function AjaxCheckStatusProcessing() {

        var vparam = $('.hidParam').html();

        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Proses_WS.asmx/GetStatusTutup',
                method: 'POST',
                data: JSON.stringify({ param: vparam }),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    resolve(JSON.parse(response.d));
                }
            });
        })
    }
</script>

</asp:Content>
