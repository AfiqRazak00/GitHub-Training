<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Statutory.aspx.vb" Inherits="SMKB_Web_Portal.Statutory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

<style>
    .progressBar {
        height:30px;
        background-color:green;
    }
</style>
<div id="PermohonanTab" class="tabcontent" style="display: block">
    <div class="container" style=" margin-bottom: 10%;margin-top:0%;margin-left:0%;">
        <div class="row">
            <div class="col-md-4 col-sm-6 
                            col-xl-4 my-3">
                <div class="card d-block h-100 
                    box-shadow-hover pointer" >
                  <div class="card-header">
                    Bulan/Tahun Gaji : <label id="lblBlnThnGaji"></label>
                  </div>

                    <div class="card-body p-4">

                     <h6>Pilihan Proses</h6>
                     <hr>  

                    <div class="form-check">  
                    <input type = "radio" class = "form-check-input" id = "btn1" name = "optradio" value = "all">  
                    <label class = "form-check-label" for = "btn1"> Keseluruhan </label>  
                    </div>  
                    <div class="form-check">  
                    <input type = "radio" class = "form-check-input" id = "btn2" name = "optradio" value = "kwsp">  
                    <label class = "form-check-label" for = "btn1"> KWSP </label>  
                    </div> 
                    <div class="form-check">  
                    <input type = "radio" class = "form-check-input" id = "btn3" name = "optradio" value = "socso">  
                    <label class = "form-check-label" for = "btn2"> Perkeso </label>  
                    </div>  
                    <div class="form-check">  
                    <input type = "radio" class = "form-check-input" id = "btn4" name = "optradio" value = "cukai">  
                    <label class = "form-check-label" for = "btn3"> Cukai </label>  
                    </div>  
                    <div class="form-check">  
                    <input type = "radio" class = "form-check-input" id = "btn5" name = "optradio" value = "pencen">  
                    <label class = "form-check-label" for = "btn4"> Pencen </label>  
                    </div>  
                    <br />
                        <button type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Simpan">Proses</button>
                         <br />
                        <div class="totalData" style="display:none">0</div>
                        <div class="totalSuccess" style="display:none">0</div>

                         <div class="totalDataKwsp" style="display:none">0</div>
                        <div class="totalSuccessKwsp" style="display:none">0</div>

                         <div class="totalDataSocso" style="display:none">0</div>
                           <div class="totalSuccessSocso" style="display:none">0</div>

                        <div class="totalDataPencen" style="display:none">0</div>
                        <div class="totalSuccessPencen" style="display:none">0</div>
                        <div></div>
                        <br />
                        <div class="progressBar" style="width:0%;visibility:hidden;">
                            &nbsp;<div class="totalPercent" id="totpercent" >0</div>
                            &nbsp;<div class="totalPercentKwsp" id="totpercentkwsp" >0</div>
                            &nbsp;<div class="totalPercentSocso" id="totpercentsocso" >0</div>
                             &nbsp;<div class="totalPercentPencen" id="totpercentpencen" >0</div>
                            &nbsp;<div class="totalMasa" id="totmasa" >0</div>
                             &nbsp;<div class="totalMasaKwsp" id="totmasakwsp" >0</div>
                             &nbsp;<div class="totalMasasocso" id="totmasasocso" >0</div>
                             &nbsp;<div class="totalMasapencen" id="totmasapencen" >0</div>
                        </div>
                        
                    </div>
                </div>

            </div>
            <div class="col-md-4 col-sm-6 
                col-xl-4 my-3">
                <div class="card d-block h-100 
    box-shadow-hover pointer" >
                     <div class="card-header">
                       <label>Rumusan</label>
                        
                     </div>
                    <div class="card-body p-4">
                         
                         Bil. KWSP : <div class="totalPencen" id="bilKwsp" style="display:inline"></div><br />
                         Bil. Perkeso : <div class="totalPencen" id="bilSocso" style="display:inline"></div><br />
                         Bil. Cukai : <div class="totalPencen" id="bilCukai" style="display:inline"></div><br /> 
                         Bil. Pencen : <div class="totalPencen" id="bilPencen" style="display:inline"></div>  
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div class="hidBulan" style="display:none"></div>
    <div class="hidTahun" style="display:none"></div>
    <div class="hidParam" style="display:none"></div>



        <div class="box-body" align="center" >               
            <asp:GridView ID="gvJenis" CssClass="table table-bordered table-striped grid" Width="100%" runat="server"
                    AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" >                                    
                <Columns>
                    <asp:BoundField DataField="no_staf" HeaderText="No. Staf">
                        <ItemStyle Width="10%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ms01_nama" HeaderText="Nama">
                        <ItemStyle Width="10%" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="gaji" HeaderText="Gaji (RM)">
                        <ItemStyle Width="10%" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="elaun" HeaderText="Elaun (RM)">
                        <ItemStyle Width="10%" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="potongan" HeaderText="Potongan (RM)">
                        <ItemStyle Width="10%" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="kwsp" HeaderText="KWSP (RM)">
                        <ItemStyle Width="10%" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="perkeso" HeaderText="Perkeso (RM)">
                        <ItemStyle Width="10%" HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="cukai" HeaderText="Cukai (RM)">
                        <ItemStyle Width="10%" HorizontalAlign="Right" />
                    </asp:BoundField>
                        <%--<asp:TemplateField HeaderText="Kemaskini">
                            <ItemTemplate>

                                <asp:LinkButton ID="lbtnEdit" runat="server" ToolTip="Kemaskini" CommandName="EditRow" class="lnk" CommandArgument="<%# CType(Container, GridViewRow).RowIndex %>" >
                                        <i class="fa fa-edit"></i></asp:LinkButton>
    
                                    <asp:LinkButton ID="lbtnHapus" runat="server" ToolTip="Hapus" CommandName="DeleteRow" class="lnk" CommandArgument="<%# CType(Container, GridViewRow).RowIndex %>" OnClientClick="return confirm('Adakah anda pasti untuk padam rekod ini?');" >
                                        <i class="fa fa-trash-o delete"></i>
                                    </asp:LinkButton>

                            </ItemTemplate>
                            <ItemStyle Width="3%" HorizontalAlign="Center" />
                        </asp:TemplateField>--%>
                </Columns>
            </asp:GridView>                   
        </div>

        
       <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel"></h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <asp:Label runat="server" ID="lblModalMessaage" Text="Pengiraan statutory telah berjaya diproses."/>                          
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
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>
</div>
<script type="text/javascript">
    var bcancel = "";
    var masa = "";
    var _x0prntobjs = document;
    if (window.parent !== undefined && window.parent !== null) {
        _x0prntobjs = window.parent.document;
    }
    function createOuterDivs() {
        var tmpCss = "position:fixed;top: 0%;left: 0%;  width: 100%;";
        tmpCss = tmpCss + "height: 100%;background-color: #FFFFFF;z-index: 1001;";
        tmpCss = tmpCss + "-moz-opacity: 10;opacity: .90;filter: alpha(opacity=90);-webkit-backface-visibility: hidden;";
        var outerDiv = createButtons("div", "sessionContainers", '', '', tmpCss);
        return outerDiv;
    }
    function createButtons(elem, id, text, funcName, styleText) {
        var tmpBtn = document.createElement(elem);
        tmpBtn.innerHTML = text;
        tmpBtn.id = id;
        tmpBtn.name = id;
        if (funcName != "") {
            tmpBtn.addEventListener("click", funcName);
        }

        if (styleText != undefined) {
            tmpBtn.style.cssText = styleText;
        }

        return tmpBtn;
    }
    function notification(msg) {
        $("#notify").html(msg);
        $("#NotifyModal").modal('show');
    }
    $(document).ready(function () {
        getBlnThn();
        //getRumus();
        
    });
    function SaveSucces() {
        $('#MessageModal').modal('toggle');
        $(".modal-body input").val("");
    }
    async function getTotalDataStatutory() {
        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetTotalStatutory',
                method: 'POST',
                data: JSON.stringify(),

                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    resolve(JSON.parse(response.d));
                }
            });
        })

    }

    async function getTotalDataKwsp() {
        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetTotalKwsp',
                method: 'POST',
                data: JSON.stringify(),

                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    resolve(JSON.parse(response.d));
                }
            });
        })

    }

    async function getTotalDataSocso() {
        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetTotalSocso',
                method: 'POST',
                data: JSON.stringify(),

                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    resolve(JSON.parse(response.d));
                }
            });
        })

    }

    async function getTotalDataPencen() {
        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetTotalPencen',
                method: 'POST',
                data: JSON.stringify(),

                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    resolve(JSON.parse(response.d));
                }
            });
        })

    }

    async function getTotalDataCukai() {
        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetTotalCukai',
                method: 'POST',
                data: JSON.stringify(),

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

            var progressResult = 0;
            var progress = 0;
            var totalDataProcess = 0;
            var totalPercentage = 0;
            $('.totalPercent').html("0%");

             progressResult = await AjaxGetProgress();
             progress = progressResult[0].JumlahSelesai;
             totalDataProcess = $('.totalData').html();
             totalPercentage = progress / totalDataProcess * 100;

            var totalTime_seconds = totalPercentage;
            var totalTime_minutes = totalTime_seconds / 60;
            totalTime_seconds %= 60;

            //alert(totalDataProcess);

            $('.totalSuccess').html(progress);
            //$('.totalPercent').html(parseFloat(totalPercentage).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + "%");

            $('.totalPercent').html(Math.trunc(totalPercentage) + "%");
            $('.totalMasa').html("Pengiraan statutory sedang diproses.Sila tunggu hingga proses selesai...");
            //$('.totalMasa').html("Pengiraan statutory sedang diproses.Sila tunggu hingga proses selesai...<br/>" + Math.floor(totalTime_minutes) + " minit " + Math.floor(totalTime_seconds) + " saat");


            //$(".progressBar").attr("style", `width:${totalPercentage}%`)

            show_loaderPercents($('.totalPercent').html());

            var resultStatus = await AjaxCheckStatusProcessing();
            
            if (resultStatus.length !== 0) {
                $('.totalSuccess').html(totalDataProcess);
                $('.totalPercent').html("100%");
                show_loaderPercents("100%");
                //$('#lblModalMessaage').text('Proses pengiraan statutory telah berjaya diproses');

                //notification('Proses pengiraan statutory telah berjaya diproses');
                //close_loaders();
                //SaveSucces();
                return;
            }

            if (progress >= totalDataProcess && totalDataProcess !== 0) {
                //console.log('Success', response);
                //var response = JSON.parse(response.d);
                //console.log(response);

                //$('#lblModalMessaage').text('Data selesa dieksport');
                //$('#MessageModal').modal('toggle');
                //SaveSucces();
                //close_loaders();
                return;
            }
            if (bcancel == '1') {
                close_loaders();
                return;
            }  
            GetProgress();
        }, 1500)
    }

    async function AjaxGetProgress() {

        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetProgressStatutory',
                method: 'POST',
                data: JSON.stringify(),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    resolve(JSON.parse(response.d));
                }
            });
        })
    }

    async function GetProgressKwsp() {
        setTimeout(async function () {


            var progressResultKwsp = 0;
            var progresskwsp = 0;
            var totalDataProcessKwsp = 0;
            var totalPercentageKwsp = 0; 
            $('.totalPercentKwsp').html("0%");

            var progressResultKwsp = await AjaxGetProgressKwsp();
            progresskwsp = progressResultKwsp[0].JumlahSelesai;
            var totalDataProcessKwsp = $('.totalDataKwsp').html();
            totalPercentageKwsp = progresskwsp / totalDataProcessKwsp * 100;
           
            //alert(progresskwsp);

            var totalTime_seconds = totalPercentageKwsp;
            var totalTime_minutes = totalTime_seconds / 60;
            totalTime_seconds %= 60;

            $('.totalSuccessKwsp').html(progresskwsp);
            //$('.totalPercent').html(parseFloat(totalPercentage).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + "%");

            $('.totalPercentKwsp').html(Math.trunc(totalPercentageKwsp) + "%");
            $('.totalMasaKwsp').html("Pengiraan statutory sedang diproses.Sila tunggu hingga proses selesai...");
            //$('.totalMasaKwsp').html("Pengiraan statutory sedang diproses.Sila tunggu hingga proses selesai...<br/>"+Math.floor(totalTime_minutes) + " minit " + Math.floor(totalTime_seconds) + " saat");

            //$(".progressBar").attr("style", `width:${totalPercentage}%`)

            show_loaderPercents($('.totalPercentKwsp').html());
           
            var resultStatusKwsp = await AjaxCheckStatusKwsp();

            if (resultStatusKwsp.length !== 0) {
                $('.totalSuccessKwsp').html(totalDataProcessKwsp);
                $('.totalPercentKwsp').html("100%");
                show_loaderPercents("100%");
                //$(".progressBar").attr("style", `width:100%`);
                //$('#lblModalMessaage').text('Proses pengiraan kwsp telah berjaya diproses');
                //notification('Proses pengiraan kwsp telah berjaya diproses');
                //close_loaders();
                //SaveSucces();
                return;
            }

            if (progresskwsp >= totalDataProcessKwsp && totalDataProcessKwsp !== 0) {
                //console.log('Success', response);
                //var response = JSON.parse(response.d);
                //console.log(response);

                //$('#lblModalMessaage').text('Data selesa dieksport');
                //$('#MessageModal').modal('toggle');
                //alert("masuk 2")
                //SaveSucces();
                //close_loaders();
                return;
            }
            if (bcancel == '1') {
                close_loaders();
                return;
            }  
 
            GetProgressKwsp();
            
        }, 600)
    }

    async function AjaxGetProgressKwsp() {

        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetProgressKwsp',
                method: 'POST',
                data: JSON.stringify(),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    resolve(JSON.parse(response.d));
                }
            });
        })
    }

    async function GetProgressSocso() {
        setTimeout(async function () {

            var progressResult = 0;
            var progress = 0;
            var totalDataProcess = 0;
            var totalPercentage = 0;
            $('.totalPercent').html("0%");

             progressResult = await AjaxGetProgressSocso();
             progress = progressResult[0].JumlahSelesai;
            totalDataProcess = $('.totalDataSocso').html();
             totalPercentage = progress / totalDataProcess * 100;

            var totalTime_seconds = totalPercentage;
            var totalTime_minutes = totalTime_seconds / 60;
            totalTime_seconds %= 60;
            //alert(totalDataProcess);

            $('.totalSuccessSocso').html(progress);
            //$('.totalPercent').html(parseFloat(totalPercentage).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + "%");

            $('.totalPercentSocso').html(Math.trunc(totalPercentage) + "%");

            var totalTime_seconds = totalPercentage;
            var totalTime_minutes = totalTime_seconds / 60;
            totalTime_seconds %= 60;
 
           //$('.totalMasa').html("Pengiraan statutory sedang diproses.Sila tunggu hingga proses selesai...<br/>" + Math.floor(totalTime_minutes) + " minit " + Math.floor(totalTime_seconds) + " saat");
            $('.totalMasa').html("Pengiraan statutory sedang diproses.Sila tunggu hingga proses selesai...");


            //$(".progressBar").attr("style", `width:${totalPercentage}%`)

            show_loaderPercents($('.totalPercentSocso').html());

            var resultStatus = await AjaxCheckStatusSocso();
            //alert(resultStatus.length);
            if (resultStatus.length !== 0) {
                $('.totalSuccessSocso').html(totalDataProcess);
                $('.totalPercentSocso').html("100%");
                show_loaderPercents("100%");
                //$('#lblModalMessaage').text('Proses pengiraan perkeso telah berjaya diproses');
               // notification('Proses pengiraan perkeso 1  telah berjaya diproses');
                //close_loaders();
                //SaveSucces();
                return;
            }

            if (progress >= totalDataProcess && totalDataProcess !== 0) {
                //console.log('Success', response);
                //var response = JSON.parse(response.d);
                //console.log(response);

                //$('#lblModalMessaage').text('Data selesa dieksport');
                //$('#MessageModal').modal('toggle');
                //SaveSucces();
                //notification('Proses pengiraan perkeso 2 telah berjaya diproses');
                //close_loaders();
                return;
            }
            if (bcancel == '1') {
                close_loaders();
                return;
            }   

            GetProgressSocso();

        }, 100)
    }

    async function GetProgressCukai() {
        setTimeout(async function () {

            var progressResult = 0;
            var progress = 0;
            var totalDataProcess = 0;
            var totalPercentage = 0;
            $('.totalPercentCukai').html("0%");

             progressResult = await AjaxGetProgressCukai();
             progress = progressResult[0].JumlahSelesai;
             totalDataProcess = $('.totalDataCukai').html();
             totalPercentage = progress / totalDataProcess * 100;

            var totalTime_seconds = totalPercentage;
            var totalTime_minutes = totalTime_seconds / 60;
            totalTime_seconds %= 60;
            //alert(totalDataProcess);

            $('.totalSuccessCukai').html(progress);
            //$('.totalPercent').html(parseFloat(totalPercentage).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + "%");

            $('.totalPercentCukai').html(Math.trunc(totalPercentage) + "%");
            var totalTime_seconds = totalPercentage;
            var totalTime_minutes = totalTime_seconds / 60;
            totalTime_seconds %= 60;

            //$('.totalMasa').html("Pengiraan statutory sedang diproses.Sila tunggu hingga proses selesai...<br/>" + Math.floor(totalTime_minutes) + " minit " + Math.floor(totalTime_seconds) + " saat");
            $('.totalMasa').html("Pengiraan statutory sedang diproses.Sila tunggu hingga proses selesai...");


            //$(".progressBar").attr("style", `width:${totalPercentage}%`)

            show_loaderPercents($('.totalPercentCukai').html());

            var resultStatus = await AjaxCheckStatusCukai();

            if (resultStatus.length !== 0) {
                $('.totalSuccessCukai').html(totalDataProcess);
                $('.totalPercentCukai').html("100%");
                show_loaderPercents("100%");
               // $('#lblModalMessaage').text('Proses pengiraan cukai telah berjaya diproses');
                //notification('Proses pengiraan cukai telah berjaya diproses');
                //close_loaders();
               // SaveSucces();
                return;
            }

            if (progress >= totalDataProcess && totalDataProcess !== 0) {
                //console.log('Success', response);
                //var response = JSON.parse(response.d);
                //console.log(response);

                //$('#lblModalMessaage').text('Data selesa dieksport');
                //$('#MessageModal').modal('toggle');
               // SaveSucces();
               // close_loaders();
                return;
            }
            if (bcancel == '1') {
                close_loaders();
                return;
            }  
            GetProgressCukai();
        }, 1500)
    }

    async function AjaxGetProgressCukai() {

        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetProgressCukai',
                method: 'POST',
                data: JSON.stringify(),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    resolve(JSON.parse(response.d));
                }
            });
        })
    }

    async function AjaxGetProgressSocso() {

        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetProgressSocso',
                method: 'POST',
                data: JSON.stringify(),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    resolve(JSON.parse(response.d));
                }
            });
        })
    }

    async function GetProgressPencen() {
        setTimeout(async function () {

            var progressResult = 0;
            var progress = 0;
            var totalDataProcess = 0;
            var totalPercentage = 0;
            $('.totalPercentPencen').html("0%");

            progressResult = await AjaxGetProgressPencen();
            progress = progressResult[0].JumlahSelesai;
            totalDataProcess = $('.totalDataPencen').html();
            totalPercentage = progress / totalDataProcess * 100;

            var totalTime_seconds = totalPercentage;
            var totalTime_minutes = totalTime_seconds / 60;
            totalTime_seconds %= 60;

            //alert(totalDataProcess);

            $('.totalSuccessPencen').html(progress);
            //$('.totalPercent').html(parseFloat(totalPercentage).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + "%");

            $('.totalPercentPencen').html(Math.trunc(totalPercentage) + "%");

            //$(".progressBar").attr("style", `width:${totalPercentage}%`)

            //$('.totalMasa').html("Pengiraan statutory sedang diproses.Sila tunggu hingga proses selesai...<br/>" + Math.floor(totalTime_minutes) + " minit " + Math.floor(totalTime_seconds) + " saat");
            $('.totalMasa').html("Pengiraan statutory sedang diproses.Sila tunggu hingga proses selesai...");

            
            show_loaderPercents($('.totalPercentPencen').html());

            var resultStatus = await AjaxCheckStatusPencen();

            if (resultStatus.length !== 0) {
                $('.totalSuccessPencen').html(totalDataProcess);
                $('.totalPercentPencen').html("100%");
                show_loaderPercents("100%");
                //$('#lblModalMessaage').text('Proses pengiraan pencen telah berjaya diproses');
                //notification('Proses pengiraan pencen telah berjaya diproses');
                //close_loaders();
                //SaveSucces();
                return;
            }

            if (progress >= totalDataProcess && totalDataProcess !== 0) {
                //console.log('Success', response);
                //var response = JSON.parse(response.d);
                //console.log(response);

                //$('#lblModalMessaage').text('Data selesa dieksport');
                //$('#MessageModal').modal('toggle');
                //SaveSucces();
                return;
            }
            if (bcancel == '1') {
                close_loaders();
                return;
            }  
            GetProgressPencen();
        }, 1500)
    }

    async function AjaxGetProgressPencen() {

        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetProgressPencen',
                method: 'POST',
                data: JSON.stringify(),
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
                url: 'Transaksi_WS.asmx/GetStatusProcessing',
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

    async function AjaxCheckStatusKwsp() {
        var vparam = $('.hidParam').html();

        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetStatusProsesKwsp',
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

    async function AjaxCheckStatusSocso() {
        var vparam = $('.hidParam').html();
        //alert(vparam);
        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetStatusProsesSocso',
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


    async function AjaxCheckStatusPencen() {
        var vparam = $('.hidParam').html();
        //alert(vparam);
        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetStatusProsesPencen',
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

    async function AjaxCheckStatusCukai() {

        var vparam = $('.hidParam').html();

        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Transaksi_WS.asmx/GetStatusProsesCukai',
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

    function getRumus(vbln,vthn) {

        //alert(vbln);

        fetch('Transaksi_WS.asmx/LoadRumusStatutory', {
            method: 'POST',
            headers: {
                'Content-Type': "application/json"
            },

            body: JSON.stringify({ thn: vthn, bln: vbln })
        })
            .then(response => response.json())
            .then(data => setRumus(data.d))

    }

    function setRumus(data) {

        data = JSON.parse(data);

        if (data.bilkwsp === "") {
            alert("Tiada data");
            return false;
        }

        $('#bilPencen').text(data[0].bilpenc);
        $('#bilKwsp').text(data[0].bilkwsp);
        $('#bilSocso').text(data[0].bilsocso);
        $('#bilCukai').text(data[0].biltax);

    }
    function getBlnThn() {
        //Cara Pertama

        fetch('Transaksi_WS.asmx/LoadBlnThnGaji', {
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
        $('.hidParam').html(data[0].tahun + sBulan);
        $('.hidBulan').html(data[0].bulan);
        $('.hidTahun').html(data[0].tahun);
        //$('#hidParam').text(sBulan + data[0].tahun);
        //$('#hidBulan').text(data[0].bulan);
        //$('#hidTahun').text(data[0].tahun);
        
        getRumus($('.hidBulan').html(), $('.hidTahun').html());

    }
    $('.btnSimpan').click(async function () {

        var vbln = $('.hidBulan').html();
        var vthn = $('.hidTahun').html();
        var vparam = $('.hidParam').html();
        var jenis = "";
        //alert(vparam);
        document.getElementById('totpercent').style.display = 'none';

        if ($('input:radio:checked').length > 0) {
            // go on with script

            if ($("#gender_male").attr("checked") == true) {

            }
        } else {
            // NOTHING IS CHECKED
            //alert("Sila pilih untuk meneruskan proses");
            notification("Sila klik checkbox pada senarai untuk meneruskan proses");
            return false;
        }
        
        if (document.getElementById('btn1').checked) {
            //if (data.data.length === 0) {
            //    return false;
            //}
            jenis = "1";

            var totalDataToProcess = await getTotalDataStatutory();

            $('.totalData').html(totalDataToProcess[0].Total);
            //alert(totalDataToProcess[0].Total);
            //show_loader();
            $.ajax({
                url: 'Transaksi_WS.asmx/fProsesStatutory',
                method: 'POST',
                data: JSON.stringify({ param: vparam }),

                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {

                    var response = JSON.parse(response.d);
                    //console.log(response);
                    notification(response.Message);
                    close_loaders();
                }

            });
            GetProgress();

        } else if (document.getElementById('btn2').checked) {
            //if (data.data.length === 0) {
            //    return false;
            //}
            jenis = "2";
            
            var totalDatakwsp = await getTotalDataKwsp();
            //alert(totalDatakwsp[0].Total);
            $('.totalDataKwsp').html(totalDatakwsp[0].Total);

            //alert(totalDatakwsp[0].Total);
           // var param = $('#hidParam').text();
            //show_loader();
            $.ajax({
                
                url: 'Transaksi_WS.asmx/fProsesKWSP',
                method: 'POST',
                data: JSON.stringify({ param: vparam }),

                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    //console.log('Success', response);
                    var response = JSON.parse(response.d);
                    //console.log(response);
                    notification(response.Message);
                    close_loaders();
                }

            });
            GetProgressKwsp();
        } else if (document.getElementById('btn3').checked) {
            //if (data.data.length === 0) {
            //    return false;
            //}
            var totalDataSocso = await getTotalDataSocso();
            //alert(totalDataSocso[0].Total);
            $('.totalDataSocso').html(totalDataSocso[0].Total);

            $.ajax({
                url: 'Transaksi_WS.asmx/fProsesPerkeso',
                method: 'POST',
                data: JSON.stringify({ param: vparam }),

                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    //console.log('Success', response);
                    var response = JSON.parse(response.d);
                    //console.log(response);
                    notification(response.Message);
                    close_loaders();
                    //window.location.reload(1);
                }

            });

            GetProgressSocso();

        } else if (document.getElementById('btn4').checked) {
            //if (data.data.length === 0) {
            //    return false;
            //}
            
            var totalDataCukai = await getTotalDataCukai();
            //alert(totalDataCukai[0].Total);
            $('.totalDataCukai').html(totalDataCukai[0].Total);

            $.ajax({
                url: 'Transaksi_WS.asmx/fProsesCukai',
                method: 'POST',
                data: JSON.stringify({ param: vparam }),

                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    var response = JSON.parse(response.d);
                    //console.log(response);
                    notification(response.Message);
                    close_loaders();
                }

            });
            GetProgressCukai();
        } else if (document.getElementById('btn5').checked) {
            //if (data.data.length === 0) {
            //    return false;
            //}
            var totalDataPencen = await getTotalDataPencen();
            //alert(totalDataPencen[0].Total);
            $('.totalDataPencen').html(totalDataPencen[0].Total);

            $.ajax({
                url: 'Transaksi_WS.asmx/fProsesPencen',
                method: 'POST',
                data: JSON.stringify({ param: vparam }),

                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (response) {
                    var response = JSON.parse(response.d);
                    //console.log(response);
                    notification(response.Message);
                    close_loaders();
                }

            });
            GetProgressPencen();
        }



    });

    function load_loaderPercents(msg) {
        if (msg === undefined || msg === null) {
            msg = "";
        }

        var load_outer = document.createElement("div");
        load_outer.id = "pg-loader-containers";
        var loader = document.createElement("div");
        var lbl = document.createElement("label");
        var lbls = document.createElement("label");
        var logo = document.createElement("img");
        var logoHolder = document.createElement("div");

        var button = document.createElement("button");
        button.innerHTML = "Cancel";
        button.style.cssText = "margin-top:30px;margin-left:0px;border: none;";
 

        logoHolder.style.cssText = "position:relative;margin-top:10px;margin-left:0px;";
        //lbl.style.cssText = "position:relative;margin-top:10px;margin-left:0px;";
        logo.src = "";

        logo.style.cssText = "width:90px;height:90px;z-index:1003;";
        logo.style.cssText += "-webkit-animation: breathing 5s ease-out infinite normal;";
        logo.style.cssText += "animation: breathing 5s ease-out infinite normal;";
        lbl.id = "pg-loader-lbl";
        lbls.id = "pg-loader-lbls";
        lbl.innerHTML = msg;
        lbls.innerHTML = "Pengiraan statutory sedang diproses.Sila tunggu hingga proses selesai..."
       // lbls.innerHTML = msgs;

        loader.id = "pg-loader";
        loader.style.cssText = "";

        button.addEventListener("click", function () {
            
            bcancel = "1";
            cansel();
        });

        load_outer.style.cssText = "width:50%;position:fixed;top:35vh;font-weight:bolder;font-size:16px;left:25%;height:230px;z-index:1002;text-align:center;";
        load_outer.className = "animate-bottom";

        //
        load_outer.appendChild(lbls);
        load_outer.appendChild(loader);
        load_outer.appendChild(lbl);
        load_outer.appendChild(logoHolder);
        load_outer.appendChild(button);

        return load_outer;
    }

    function show_loaderPercents(msg) {
        _x0prntobj = document;
        loadLoaderPercents(msg);
    }
    function upd_loadertexts(newMsg) {
        var pgloader = _x0prntobjs.getElementById("pg-loader-lbl")
        //var pgloaders = _x0prntobjs.getElementById("pg-loader-lbls")

        pgloader.style.cssText = "width:50%;z-index:1003;font-size:30px;color:black;position:relative;margin-top:30px;margin-left:0px;"

        if (pgloader !== null && pgloader !== undefined) {
            pgloader.innerHTML = newMsg;
            //pgloaders.innerHTML = newmsgs;

        }
    }
    function loadLoaderPercents(msg) {
        //GoTop();


        if (_x0prntobjs.getElementById("sessionContainers") === undefined || _x0prntobjs.getElementById("sessionContainers") === null) {
            _x0prntobjs.body.className += " noscroll";
            _x0prntobjs.body.appendChild(createOuterDivs());
            _x0prntobjs.body.appendChild(load_loaderPercents(msg));
        } else {
            upd_loadertexts(msg);
        }
    }
    function close_loaders(fn) {
        var outerDiv = _x0prntobjs.getElementById("sessionContainers");
        var pg_loader = _x0prntobjs.getElementById("pg-loader-containers");
        if (pg_loader !== undefined && pg_loader !== null && outerDiv !== undefined && outerDiv !== null) {
            setTimeout(function () {
                pg_loader.className = "animate-out";
            }, 300);

            setTimeout(function () {
                _x0prntobjs.body.removeChild(outerDiv);
                _x0prntobjs.body.removeChild(pg_loader);
                //alert(_x0prntobj.body.className);
                _x0prntobjs.body.className = _x0prntobjs.body.className.replace(/\bnoscroll\b/g, "");
                if (fn !== null && fn !== undefined) {
                    fn();
                }
                //var matches = /\bnoscroll\b/g.exec(_x0prntobj.body.className);
                //alert(matches);
            }, 1000);
        }
    }
    function cansel(fn) {
        var outerDiv = _x0prntobjs.getElementById("sessionContainers");
        var pg_loader = _x0prntobjs.getElementById("pg-loader-containers");

                _x0prntobjs.body.removeChild(outerDiv);
                _x0prntobjs.body.removeChild(pg_loader);

    }
</script>
</asp:Content>
