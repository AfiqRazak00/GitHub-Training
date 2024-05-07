<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Proses_GajiEOT.aspx.vb" Inherits="SMKB_Web_Portal.Proses_GajiEOT" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
 <%@ Register Src="~/FORMS/EOT/Modal_Message.ascx" TagName="popupM" TagPrefix="Message" %>
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
<div id="PermohonanTab" class="tabcontent" style="display: block">
   
    <div class="container" style=" margin-bottom: 10%;margin-top:0%;margin-left:20%;text-align:center">
        
         <div id="popupM">  
        <div class="row" >
            <div class="col-md-4 col-sm-6 
                            col-xl-6 my-3">
                <div class="card d-block h-100 
                    box-shadow-hover pointer" >
                  <div class="card-header"><span style="font-size:18px"> Bulan/Tahun Gaji : <label id="lblBlnThnGaji"></label></span>
                   
                  </div>
                    
                    <div class="card-body p-6">

                        <div class="form-row">
                           <div class="form-group col-md-12">
                               
                                   <label for="JumRekod" align="center" style="font-size:18px">Bilangan Rekod :</label> 
                                 <%-- <label id="lblBilProses">0</label>--%>
                               <label id="lblBilProses" onclick="toggleModal()"  style="cursor: pointer; color: blue; text-decoration:underline; font-weight:bold;font-size:20px;">0</label>
                                
                            </div>
                            <div class="form-group col-md-12">
                              <label for="JumAmaun"  align="center" style="font-size:18px">Jumlah Amaun :</label>  
                               <label id="lblAmaun" style="font-size:20px">0.00</label>
                                
                            </div>
                        </div>
                         <hr />
                      
                    <button type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Proses">Proses</button>
                    </div>
                    
                   <%--  <div   class="form-row" align="left">&nbsp;&nbsp;&nbsp;&nbsp
                      <button type="button" id="btnSemak"  class ="btn btn-info btnSemak" data-toggle="modal" data-placement="bottom" data-target="#SenaraiStaf" title="Senarai Rekod">Senarai Rekod</button>
                    </div>--%>
                </div>
               <label id="hidBulan" style="visibility:hidden"></label>
                    <label id="hidTahun" style="visibility:hidden"></label>
            </div>
        </div>
            
       </div>
          <Message:popupM runat="server" ID="Notify" />
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
        
    <div class="modal fade" id="SenaraiStaf" tabindex="-1" role="dialog" data-backdrop="static"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header baccolor">
                    <h5 class="modal-title" id="fMCTitlejadual">Senarai Rekod</h5>
                    <button type="button" class="btn btn-default tutupKadar"  aria-label="Close" data-dismiss="modal">
                        <span aria-hidden="true">X</span>
                    </button>
                </div>
              
                <div class="modal-body">
                 <div class="form-row">
                    <div class="col-md-12">                        
                        <div class="transaction-table table-responsive">
                            <table id="tblDataSenarai_trans" class="table table-striped" style="width: 100%">
                                <thead>
                                    <tr> 
                                        <th scope="col">No Mohon</th>
                                        <th scope="col">No Staf</th>
                                        <th scope="col">Nama</th>     
                                        <th scope="col">Pejabat</th>
                                        <th scope="col">Jawatan</th>
                                        <th scope="col">Amaun</th>
                                    </tr>
                                </thead>
                                <tbody id="tblDataSenarai_Detail">
                                               
                                </tbody>     
                            </table>
                        </div>
                    </div>
                </div>
               </div> 

                 <div class="sticky-footer">
                    <br />
                    <div class="form-row">
                        <div class="form-group col-md-8">
                           
                            <div class="float-right">
                                <span
                                    style="font-family: roboto!important; font-size: 18px!important"><b>&nbsp;&nbsp;&nbsp;Jumlah Amaun
                                                        (<span id="result" style="margin-right: 5px">0</span> item) :
                                                        <span id="stickyJumlah"
                                                            style="margin-right: 5px">0.00</span></b></span>
                              
                            </div>


                        </div>
                    </div>
                </div>
            </div>
        </div>
 </div>
</div> 
    
    <script type="text/javascript">
        var tbl = null;
        $(document).ready(function () {
            getBlnThn();
            getJumRekod();
            show_loader();
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
                    "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },
                "ajax": {
                    "url": "Transaksi_EOTs.asmx/LoadSenGajiOT",
                    method: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function () {
                        return JSON.stringify();
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },
                "rowCallback": function (row, data) {
                    close_loader();
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });

                },
            
                "columns": [
                    { "data": "No_Mohon" },
                    { "data": "No_Staf" },
                    { "data": "nama" },
                    { "data": "singkat" },
                    { "data": "jgiliran" },
                    { "data": "Amaun_Terima" }

                ]
            });


        });

        function getBlnThn() {
            //Cara Pertama

            fetch('Transaksi_EOTs.asmx/LoadBlnThnGaji', {
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

        function getJumRekod() {
            //Cara Pertama

            fetch('Transaksi_EOTs.asmx/fGetRekodProsesGaji', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
                //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                body: JSON.stringify()
            })
                .then(response => response.json())
                .then(data => setJumlahRekod(data.d))

        }

        function setJumlahRekod(data) {
           
            data = JSON.parse(data);
            if (data.JumRekod === 0) {
                alert("Tiada data");
                return false;
            }
            $('#lblBilProses').html(data[0].JumRekod);
            $('#lblAmaun').html(data[0].JumAmaun.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true }));
            $("#stickyJumlah").html(data[0].JumAmaun.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true }));
            $("#result").html(data[0].JumRekod)
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
        $('#hidBulan').text(sBulan + data[0].tahun);
        $('#hidTahun').text(data[0].tahun);

    }

        $('.btnSimpan').click(function ()
        {
            //alert('masuk');
            var bln = $('#hidBulan').text();

            show_loader();
            $.ajax({
                "url": "Transaksi_EOTs.asmx/fProsesGaji_EOT",
                method: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: JSON.stringify(),
                success: function (response) {
                    console.log('Success', response);
                    var response = JSON.parse(response.d);
                    console.log(response);
                
                    Notification(response.Message);
                    window.location.reload(1);
                }   
            });
        });


        $('#btnSemak').click(async function () {
           
            $('#SenaraiStaf').modal('toggle');
       
        });


        function toggleModal() {
           // var label = document.getElementById("lblBilProses");
           // label.style.color = "blue";
           // label.style.textDecoration = "underline";
            $('#SenaraiStaf').modal('toggle');

            // Change label color to blue and underline
            
        }

    </script>

</asp:Content>
