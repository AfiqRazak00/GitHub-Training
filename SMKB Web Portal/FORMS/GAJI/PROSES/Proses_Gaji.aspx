<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Proses_Gaji.aspx.vb" Inherits="SMKB_Web_Portal.Proses_Gaji" %>
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
    <script type="text/javascript">


    </script>  
<div id="PermohonanTab" class="tabcontent" style="display: block">
        <div class="container" style=" margin-bottom: 10%;margin-top:0%;margin-left:0%;">
        <div class="row">
            <div class="col-md-4 col-sm-6 
                            col-xl-6 my-3">
                <div class="card d-block h-100 
                    box-shadow-hover pointer" >
                  <div class="card-header">
                    Bulan/Tahun Gaji : <label id="lblBlnThnGaji"></label>
                  </div>
                    
                    <div class="card-body p-6">

                         <div class="form-check">  
                         <input type = "radio" class = "form-check-input" id = "btn1" name = "optradio" value = "all">  
                         <label class = "form-check-label" for = "btn1"> Keseluruhan </label>  
                         </div>  
                         <div class="form-check">  
                         <input type = "radio" class = "form-check-input" id = "btn2" name = "optradio" value = "kwsp">  
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label >PTj Dari</label>
                                       <asp:DropDownList ID="ddlPtjDr" runat="server" CssClass="ui search dropdown input-group__input">
                                        </asp:DropDownList>
                                </div>
                                <div class="form-group col-md-6">
                                <label >PTj Hingga</label>  
                                        <asp:DropDownList ID="ddlPtjHg" runat="server" CssClass="ui search dropdown input-group__input" >
                                        </asp:DropDownList>
                                   
                                </div>
                            </div>
                         </div> 
                         <div class="form-check">  
                         <input type = "radio" class = "form-check-input" id = "btn3" name = "optradio" value = "socso">   
           
                         <div class="form-row">
                           <div class="form-group col-md-6">
                               <label >No. Staf Dari</label> 
                                    <asp:DropDownList ID="ddlStafDr" runat="server" CssClass="ui search dropdown input-group__input" >
                                   </asp:DropDownList>
                                   
                            </div>
                            <div class="form-group col-md-6">
                                <label >No. Staf Hingga</label>
                                  <asp:DropDownList ID="ddlStafHg" runat="server" CssClass="ui search dropdown input-group__input" >
                                   </asp:DropDownList>
                                   
                                             
                            </div>
      
                        </div>

                       
                    <br />
                    <button type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Proses">Proses</button>
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
                     &nbsp;<div class="totalMasa" id="totmasa" >0</div>
                 </div>
            </div>
        </div>
    </div>


<div class="modal fade"  id="SpinModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered justify-content-center" role="document">
        <span class="fa fa-spinner fa-spin fa-3x"></span>
    </div>
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
                        <asp:Label runat="server" ID="lblModalMessaage" Text="Proses gaji telah berjaya diproses." />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>

                    </div>
                </div>
            </div>
        </div>

    <div class="modal fade" id="MessageModalError" tabindex="-1" aria-hidden="true">
       <div class="modal-dialog" role="document">
           <div class="modal-content">
               <div class="modal-header">
                   <h5 class="modal-title" id="errModalLabel"></h5>
                   <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                       <span aria-hidden="true">&times;</span>
                   </button>
               </div>
               <div class="modal-body">
                   <asp:Label runat="server" ID="lblerror" Text="Error." />
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
        });
        function SaveSucces() {

            //document.getElementById("lblModalMessaage").value = "SomeText";
            $('#MessageModal').modal('toggle');
            $(".modal-body input").val("");
        }

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

        async function getTotalDataGaji() {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Proses_WS.asmx/GetTotalLejar',
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

        async function getTotalDataGajiPtj(vptjdr, vptjhg) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Proses_WS.asmx/GetTotalLejarPtj',
                    method: 'POST',
                    data: JSON.stringify({
                        ptjDr: vptjdr,
                        ptjHg: vptjhg
                    }),

                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (response) {
                        resolve(JSON.parse(response.d));
                    }
                });
            })

        }

        async function getTotalDataGajiStaf(vstafdr, vstafhg) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: 'Proses_WS.asmx/GetTotalLejarStaf',
                    method: 'POST',
                    data: JSON.stringify({
                        nostafDr: vstafdr,
                        nostafHg: vstafhg
                    }),

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

                var totalTime_seconds = totalPercentage;
                var totalTime_minutes = totalTime_seconds / 60;
                totalTime_seconds %= 60;

                //alert(totalDataProcess);

                $('.totalSuccess').html(progress);
                //$('.totalPercent').html(parseFloat(totalPercentage).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }) + "%");

                $('.totalPercent').html(Math.trunc(totalPercentage) + "%");

                $('.totalMasa').html("Pengiraan gaji sedang diproses.Sila tunggu hingga proses selesai...<br/>" + Math.floor(totalTime_minutes) + " minit " + Math.floor(totalTime_seconds) + " saat");


                //$(".progressBar").attr("style", `width:${totalPercentage}%`)

                show_loaderPercents($('.totalPercent').html(), $('.totalMasa').html());

                var resultStatus = await AjaxCheckStatusProcessing();

                if (resultStatus.length !== 0) {
                    $('.totalSuccess').html(totalDataProcess);
                    $('.totalPercent').html("100%");
                    show_loaderPercents("100%");
                    //notification("Proses gaji telah berjaya diproses.");
                    //SaveSucces();
                    //$('#lblModalMessaage').text('Data selesai dieksport');
                    close_loaders();
                    
                    return;
                }

                if (progress >= totalDataProcess && totalDataProcess !== 0) {
                    //console.log('Success', response);
                    //var response = JSON.parse(response.d);
                    //console.log(response);

                    //$('#lblModalMessaage').text('Data selesa dieksport');
                    //$('#MessageModal').modal('toggle');
                    $('.totalPercent').html("100%");
                    //notification("Proses gaji telah berjaya diproses.");
                    //SaveSucces();
                    close_loaders();
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

            var vbln = $('#hidBulan').text();
            var vthn = $('#hidTahun').text();
      
            return new Promise((resolve, reject) => {
                
                $.ajax({    
                    url: 'Proses_WS.asmx/GetProgressLejar',
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
                    url: 'Proses_WS.asmx/GetStatusProcessing',
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
            //alert('masuk');
            var vparam = $('.hidParam').html();
            //alert(vparam);
            var vptjdr = $("#<%=ddlPtjDr.ClientID%>").val();
            var vptjhg = $("#<%=ddlPtjHg.ClientID%>").val();
            var vstafdr = $("#<%=ddlStafDr.ClientID%>").val();
            var vstafhg = $("#<%=ddlStafHg.ClientID%>").val();

            if ($('input:radio:checked').length > 0) {
                // go on with script

                if ($("#gender_male").attr("checked") == true) {

                }
            } else {
                // NOTHING IS CHECKED
                //alert("Sila pilih untuk meneruskan proses");
                notification("Sila klik pada checkbox untuk meneruskan proses.");
                return false;
            }


            if (document.getElementById('btn1').checked) {
                var totalDataToProcess = await getTotalDataGaji();

                $('.totalData').html(totalDataToProcess[0].Total);

                //show_loader();
                $.ajax({
                    url: 'Proses_WS.asmx/fProsesGaji',
                    method: 'POST',
                    data: JSON.stringify({
                        kodparam: vparam
                    }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (response) {

                       // alert('masuk');
                        var response = JSON.parse(response.d);
                        //alert(response.Message);
                        notification(response.Message);
                       // alert(response.id);
                       console.log(response);
                      
                       // $('#MessageModal').modal('toggle');
                       // $(".modal-body input").val("");
                       // $('#lblModalMessaage').text(response.Message);


                        //SaveSucces();

                        //window.location.reload(1);
                    },
                    error: function (error) {
                        console.error("Error parsing JSON response:", error); // Access the error message directly
                    }

                });
                GetProgress();
            }
            else if (document.getElementById('btn2').checked) {
                //if (data.data.length === 0) {
                //    return false;
                //}
                jenis = "2";

                var totalDataToProcess = await getTotalDataGajiPtj(vptjdr, vptjhg);

                $('.totalData').html(totalDataToProcess[0].Total);

                //show_loader();
                $.ajax({
                    url: 'Proses_WS.asmx/fProsesGajiPtj',
                    method: 'POST',
                    data: JSON.stringify({
                        ptjDr: vptjdr,
                        ptjHg: vptjhg,
                        kodparam: vparam
                    }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (response) {


                        var response = JSON.parse(response.d);
                        notification(response.Message);
                        //console.log(response);
                        ////alert(response.Message);
                        //$('#lblModalMessaage').text(response.Message);

                        //SaveSucces();

                        //window.location.reload(1);
                    }

                });
                GetProgress();
            }
            else if (document.getElementById('btn3').checked) {
                //if (data.data.length === 0) {
                //    return false;
                //}
                jenis = "2";

                var totalDataToProcess = await getTotalDataGajiStaf(vstafdr, vstafhg);

                $('.totalData').html(totalDataToProcess[0].Total);

                //show_loader();
                $.ajax({
                    url: 'Proses_WS.asmx/fProsesGajiStaf',
                    method: 'POST',
                    data: JSON.stringify({
                        nostafDr: vstafdr,
                        nostafHg: vstafhg,
                        kodparam: vparam
                    }),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (response) {


                        var response = JSON.parse(response.d);
                        notification(response.Message);
                        //console.log(response);
                        ////alert(response.Message);
                        //$('#lblModalMessaage').text(response.Message);

                        //SaveSucces();

                        //window.location.reload(1);
                    },
                    error: function (error) {
                        console.error("Error parsing JSON response:", error); // Access the error message directly
                    }

                });
                GetProgress();
            }
            
        });
        function load_loaderPercents(msg, msgs) {
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
            lbls.innerHTML = msgs;


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

        function show_loaderPercents(msg, msgs) {
            _x0prntobj = document;
            loadLoaderPercents(msg, msgs);
        }
        function upd_loadertexts(newMsg, newmsgs) {
            var pgloader = _x0prntobjs.getElementById("pg-loader-lbl")
            var pgloaders = _x0prntobjs.getElementById("pg-loader-lbls")

            pgloader.style.cssText = "width:50%;z-index:1003;font-size:30px;color:black;position:relative;margin-top:30px;margin-left:0px;"

            if (pgloader !== null && pgloader !== undefined) {
                pgloader.innerHTML = newMsg;
                pgloaders.innerHTML = newmsgs;

            }
        }
        function loadLoaderPercents(msg, msgs) {
            //GoTop();


            if (_x0prntobjs.getElementById("sessionContainers") === undefined || _x0prntobjs.getElementById("sessionContainers") === null) {
                _x0prntobjs.body.className += " noscroll";
                _x0prntobjs.body.appendChild(createOuterDivs());
                _x0prntobjs.body.appendChild(load_loaderPercents(msg, msgs));
            } else {
                upd_loadertexts(msg, msgs);
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
