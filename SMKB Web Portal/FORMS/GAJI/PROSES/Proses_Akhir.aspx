<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Proses_Akhir.aspx.vb" Inherits="SMKB_Web_Portal.Proses_Akhir" %>
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
        
        <div class="container" style=" margin-bottom: 13%;margin-top:0%;margin-left:0%;text-align:center">
        <div class="row">
            <div class="col-md-4 col-sm-6 col-xl-4 my-3">
                <div class="card d-block h-100 
                    box-shadow-hover pointer" >
                  <div class="card-header">
                    Bulan/Tahun Gaji : <label id="lblBlnThnGaji"></label>
                  </div>
                 
                    
                    <div class="card-body p-4">
                        <div class="form-group col-md-12">
                            <label >Bank</label>
                                    <asp:DropDownList ID="ddlBank" runat="server" CssClass="ui search dropdown input-group__input" DataTextField="76106" DataValueField="76106">
                                       <asp:ListItem Selected="True" Value="76106"> 76106 - BANK ISLAM MALAYSIA BERHAD  </asp:ListItem>
                                    </asp:DropDownList>
                                   
                            </div>

                        <button type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Proses">Proses</button>

                    </div>
                </div>
            </div>
        </div>
    </div>

        <label id="hidBulan" style="visibility:hidden"></label>
        <label id="hidTahun" style="visibility:hidden"></label>
            <div class="hidParam" style="display:none"></div>
        <div class="totalData" style="display:none">0</div>
        <div class="totalSuccess" style="display:none">0</div>

        <div></div>
        <br />
        <div class="progressBar" style="width:0%;visibility:hidden;">
            &nbsp;<div class="totalPercent" id="totpercent" >0</div>
   
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
                            <asp:Label runat="server" ID="lblModalMessaage" Text="Proses integrasi gaji ke pembayaran berjaya diproses."/>                          
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

    $(document).ready(function () {
        getBlnThn();
       
        //$('[id*=ddlBank]').html('<option value="76106">76106</option>');

    });
    function notification(msg) {
        $("#notify").html(msg);
        $("#NotifyModal").modal('show');
    }

    function SaveSucces() {
        $('#MessageModal').modal('toggle');
        $(".modal-body input").val("");
    }
    //function getBank()
    //{
    //    alert('masuk');
    //    return new Promise((resolve, reject) => {
    //        $.ajax({

    //            "url": "Proses_WS.asmx/GetBankMaster",
    //            method: 'POST',
    //            "contentType": "application/json; charset=utf-8",
    //            "dataType": "json",
    //            success: function (data) {

    //                var json = JSON.parse(data.d);

    //                var option = json.map(x => "<option value='" + x.Kod_Bank + "'>" + x.Kod_Bank + "</option>");

    //                $('[id*=ddlBank]').html('<option value="">Sila Pilih</option>');
    //                $('[id*=ddlBank]').append(option.join(' '));

    //            }

    //        });
    //    })

    //}

    function getBlnThn() {
        //Cara Pertama

        fetch('Proses_WS.asmx/LoadBlnThnGaji', {
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
            sBulan = data[0].bulan;
        }

        //$('#hidParam').text(sBulan + data[0].tahun);
        $('.hidParam').html(data[0].tahun + sBulan);
        //alert($('.hidParam').html());
        $('#hidBulan').text(data[0].bulan);
        $('#hidTahun').text(data[0].tahun);
        //$('#hidParam').text(sBulan + data[0].tahun);
        //$('#hidBulan').text(data[0].bulan);
        //$('#hidTahun').text(data[0].tahun);


    }
    async function getTotalDataAP() {
        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'Proses_WS.asmx/GetTotalAP',
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
                //close_loader();
                //notification("Proses integrasi gaji ke pembayaran berjaya diproses.");
                //SaveSucces();
                return;
            }

            if (progress >= totalDataProcess && totalDataProcess !== 0) {
                //console.log('Success', response);
                //var response = JSON.parse(response.d);
                //console.log(response);

                //$('#lblModalMessaage').text('Data selesa dieksport');
                //$('#MessageModal').modal('toggle');
                //notification("Proses integrasi gaji ke pembayaran berjaya diproses.");
                return;
            }

            GetProgress();
        }, 1000)
    }

    async function AjaxGetProgress() {

        var vparam = $('.hidParam').html();

        return new Promise((resolve, reject) => {

            $.ajax({
                url: 'Tutup_WS.asmx/GetProgressAP',
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
                url: 'Tutup_WS.asmx/GetStatusAP',
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

    $('.btnSimpan').click(async function () {

        //alert('test');
            var bln = $('#hidBulan').text();
            var thn = $('#hidTahun').text();
            //var thn = $('#hidTahun').text;
            //alert(bln);
        var totalDataToProcess = await getTotalDataAP();
       //alert(totalDataToProcess[0].Total);

        $('.totalData').html(totalDataToProcess[0].Total);

            $.ajax({
                "url": "Proses_WS.asmx/fProsesAP",
                method: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: JSON.stringify({ ibank: $('#<%=ddlBank.ClientID%>').val() }),
                success: function (response) {
                    var response = JSON.parse(response.d);
                    //console.log(response);
                    notification(response.Message);
                    close_loader();
                }

            });
        GetProgress();

    });


</script>
</asp:Content>
