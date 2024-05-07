<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Transaksi_Semasa.aspx.vb" Inherits="SMKB_Web_Portal.Transaksi_Semasa" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
<style>
     .table-wrapper{
 width : 100%;
 box-shadow: 0px 35px 50px rgba( 0, 0, 0, 0.2 );
 font-size: 8px;
 }
</style>
<div id="PermohonanTab" class="tabcontent" style="display: block">
    Bulan/Tahun Gaji : <label id="lblBlnThnGaji"></label>
    <label id="hidBulan" style="visibility:hidden"></label>
                    <label id="hidTahun" style="visibility:hidden"></label>

        <div class="table-title">
            <h6><u><b>Senarai Staf</b></u></h6>
            <hr>
        </div>
       
        <div class="form-row">
             
            <div class="col-md-12">
                
                <div class="transaction-table table-responsive">
                    
                    <table id="tblListStaf" class="table table-striped" style="width:100%">
                        <thead>
                            <tr>
                                <th scope="col" style="width:100px">No. Staf</th>
                                <th scope="col" style="width:100px">Nama</th>
                                <th scope="col" style="width:250px">Pejabat</th>
                                <th scope="col" style="width:100px">Tindakan</th>
                            </tr>
                        </thead>
                        <tbody id="tableID_ListStaf">
                                        
                        </tbody>

                    </table>
                </div>
            </div>                  
        </div>
    <div class="table-title">

        <div class="col-sm-6 col-md-8">
            <div class="card border-white">
                <div class="card-header" style="text-align: left">
                    <label id="lbl1" style="color:blue"></label>
                    <label id="lbl2" style="color:blue"></label>
                     <label id="hidNostaf" style="visibility:hidden"></label>
                    <label id="hidSave" style="visibility:hidden"></label>
                </div>

            </div>
        </div>
 
    </div>
         <div class="col-md-12">

        <div class="form-row">

                

                          <div class="table-wrapper">
                       <table id="tblListHdr" style="width:97%" class="table table-bordered table-sm"  cellspacing="0px" cellpadding="0px">

                           <thead style="font-size:12px;background-color:lightgrey;">
                                <tr >
                                <td colspan="3" style="border-right:1px solid gainsboro;text-align:center"><b>PENDAPATAN</b></td>
                                <td colspan="3" style="border-right:1px solid gainsboro;text-align:center"><b>POTONGAN</b></td>
                            </tr>
                            <tr >
                                <td scope="col" style="width:50px;text-align:center"><b>KOD</b></td>
                                <td scope="col" style="width:100px;text-align:left"><b>BUTIRAN</b></td>
                                <td scope="col" style="width:100px;border-right:1px solid gainsboro;text-align:right"><b>AMAUN (RM)</b></td>
                                <td scope="col" style="width:50px;text-align:center"><b>KOD</b></td>
                                <td scope="col" style="width:100px;text-align:left"><b>BUTIRAN</b></td>
                                <td scope="col" style="width:100px;text-align:right"><b>AMAUN (RM)</b></td>
                            </tr>
                           </thead>

                            <tbody id="tbllistbody" style="font-size:12px">

                            </tbody>

                        <tfoot style="font-size:12px">
                             
                            <tr style="background-color:beige;" rowspan="4"> 
                                <td colspan="2" ><b>PENDAPATAN KASAR (RM) </b></td>
                                <td colspan="1" id="lblAmaunPendapatan" style="border-right:1px solid gainsboro;text-align:right;font-weight:bold"></td>
                                <td colspan="2" ><b>JUMLAH POTONGAN (RM) </b></td>
                                <td colspan="1" id="lblAmaunPotongan" style="text-align:right;font-weight:bold"></td>
                            </tr>
                            <tr style="background-color:beige;" rowspan="4">
       
                                <td colspan="2" ><b>Pencen Majikan</b></td>
                                <td colspan="1" id="lblPencen" style="text-align:right; font-weight:bold"></td>
                                
                                <td colspan="2" ><b>PENDAPATAN BERSIH (RM) </b></td>
                                <td colspan="1" id="lblAmaunbersih" style="text-align:right; font-weight:bold" ></td>
                            </tr>
                            <tr style="background-color:beige;" rowspan="4">
                                <td colspan="2" ><b>KWSP Majikan</b></td>
                                <td colspan="1" id="lblKwsp" style="text-align:right; font-weight:bold"></td>
                                <td colspan="2" ></td>
                                <td colspan="1" id="" style="text-align:right; font-weight:bold" ></td>
                            </tr>
                            <tr style="background-color:beige;" rowspan="4">
                                <td colspan="2" ><b>Socso Majikan</b></td>
                                <td colspan="1" id="lblSocso" style="text-align:right; font-weight:bold"></td>  
                                <td colspan="2" ></td>
                                <td colspan="1" id="" style="text-align:right; font-weight:bold" ></td>
                            </tr>
                            <%--<tr >
                                <td colspan="6" > </td>
                            </tr>--%>
                        </tfoot>
                            
                    </table>
                </div>
                
        </div>
    </div>


</div>
<script type="text/javascript">
    var tbl = null

    $(document).ready(function () {
        getBlnThn();

        tbl = $("#tblListStaf").DataTable({
            dom: '<"toolbar">frtip',
            "responsive": true,
            "searching": true,
            "bLengthChange": false,
            "sPaginationType": "full_numbers",
            "pageLength": 5,
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
                "url": "Transaksi_WS.asmx/LoadListStaf",
                        method: 'POST',
                        "contentType": "application/json; charset=utf-8",
                        "dataType": "json",
                        data: function () {
                            return JSON.stringify()
                        },
                        "dataSrc": function (json) {
                            //var data = JSON.parse(json.d);
                            //console.log(data.Payload);
                            return JSON.parse(json.d);
                        }
            },
            "columns": [
                {
                    "data": "MS01_NoStaf",
                    
                },
                { "data": "MS01_Nama" },
                { "data": "PejabatS" },
                {
                    className: "btnView",
                    "data": "MS01_NoStaf",
                    render: function (data, type, row, meta) {

                        if (type !== "display") {

                            return data;

                        }

                        var link = `<button runat="server" class="btn" type="button" style="color: blue" data-dismiss="modal">
                                                    <i class="far fa-list-alt"></i>
                                        </button>`;
                        return link;
                    }
                }
            ]

        });

    });
   
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
            sBulan = data[0].bulan;
        }
        $('#hidBulan').text(data[0].bulan);
        $('#hidTahun').text(data[0].tahun);

    }

    function getInfoDet(obj) {
        alert($(obj).text());


    }
    function formatDate(tkh) {
        var date1 = tkh.split('/')
        var newDate = date1[2] + '-' + date1[1] + '-' + date1[0];
        return newDate;
       // var date = new Date(newDate);
       // alert(newDate);
    }



    $('#tblListStaf').on('click', '.btnView', function (e) {
        e.preventDefault();
        var recordID = $(this).closest('tr').find('td:eq(0)').text(); // amend the index as needed
       // var curTR = $(this).closest("tr");
        //var recordID = curTR.find("td > .noStaf");
        //var bool = true;
        //var id = recordID.val();
        var bln = $('#hidBulan').text();
        var thn = $('#hidTahun').text();
        $('#lbl1').text(recordID);
        $('#hidNostaf').text(recordID);
        $('#lbl2').text($(this).closest('tr').find('td:eq(1)').text());
        
        //ListMaster(recordID, thn, bln);
        $('#tblListHdr > tbody').empty();

        getAllData();
        //var data = table.row($(this).parents('tr')).data();

        //alert(data[0] + "'s salary is: " + data[5]);


        
        //$("div.header").html('Charges list');
    });


    ///////////////////////////////////
    //1st
 // getAllData();

    async function getAllData() {
        
        var dataIncome = await getIncome();
        var dataPotongan = await getPotongan();
        var dataMajikan = await getMajikan();
        var counter = 0;
        var bil = 0;

        dataIncome = JSON.parse(dataIncome)
        dataPotongan = JSON.parse(dataPotongan)
        dataMajikan = JSON.parse(dataMajikan)
        $('#tbllistbody').html("");
        
        var totalData = dataIncome.length;
        var totalMaj = dataMajikan.length;

        if (dataPotongan.length > totalData) {
            totalData = dataPotongan.length;
        }
        var totalIncome = 0.00;
        var totalPotongan = 0.00;
        var totalBersih = 0.00;

        while (counter < totalData) {

            var potongan1 = ""
            var potongan2 = ""
            var potongan3 = ""
           

            var income1 = ""
            var income2 = ""
            var income3 = ""
           

            if (dataIncome[counter] !== null && dataIncome[counter] !== undefined) {
                income1 = dataIncome[counter].Kod_Trans
                income2 = dataIncome[counter].Butiran
                income3 = parseFloat(dataIncome[counter].Amaun).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                totalIncome += parseFloat(dataIncome[counter].Amaun);
            }

            if (dataPotongan[counter] !== null && dataPotongan[counter] !== undefined) {
                potongan1 = dataPotongan[counter].Kod_Trans
                potongan2 = dataPotongan[counter].Butiran
                potongan3 = parseFloat(dataPotongan[counter].Amaun).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                totalPotongan += parseFloat(dataPotongan[counter].Amaun);
            }

            var tr = null;
            tr = $('<tr>')
                .append($('<td style = "text-align:center;">').html(income1))
                .append($('<td>').html(income2))
                .append($('<td style = "border-right:1px solid grey;text-align:right;">').html(income3)) 
                .append($('<td style = "text-align:center;">').html(potongan1))
                .append($('<td>').html(potongan2))
                .append($('<td style = "text-align:right">').html(potongan3))

            $('#tbllistbody').append(tr);
            counter += 1;
        }
        totalBersih = totalIncome - totalPotongan;
        $('#lblAmaunPendapatan').html(parseFloat(totalIncome).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })); 
        $('#lblAmaunPotongan').html(parseFloat(totalPotongan).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }));
        $('#lblAmaunbersih').html(parseFloat(totalBersih).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 }));


        $('#lblKwsp').html("");
        $('#lblPencen').html("");
        $('#lblSocso').html("");

        while (bil < totalMaj) {
            var kwsp = ""
            var socso = ""
            var pencen = ""


            if (dataMajikan[bil] !== null && dataMajikan[bil] !== undefined) {
                if (dataMajikan[bil].Kod_Trans == 'KWSM') {
                    kwsp = parseFloat(dataMajikan[bil].Amaun).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                    $('#lblKwsp').html(kwsp);
                }
                if (dataMajikan[bil].Kod_Trans == 'PENC') {
                    pencen = parseFloat(dataMajikan[bil].Amaun).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                    $('#lblPencen').html(pencen);
                   
                }
                if (dataMajikan[bil].Kod_Trans == 'SOCM') {
                    socso = parseFloat(dataMajikan[bil].Amaun).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
                    $('#lblSocso').html(socso);
                    
                }
            }
            bil += 1;
        }

    }

    async function getIncome() {
        var vBln = $('#hidBulan').text();
        var vThn = $('#hidTahun').text();
        var vNostaf = $('#lbl1').text();

        return new Promise((resolve, reject) => {
            $.ajax({
                url: "Transaksi_WS.asmx/LoadListIncome",
                method: 'POST',
                data: JSON.stringify({
                    nostaf: vNostaf,
                    tahun: vThn,
                    bulan: vBln
                }),
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
        })
    } 

    async function getPotongan() {
        var vBln = $('#hidBulan').text();
        var vThn = $('#hidTahun').text();
        var vNostaf = $('#lbl1').text();

        return new Promise((resolve, reject) => {
            $.ajax({
                url: "Transaksi_WS.asmx/LoadListPotonganSlip",
                method: 'POST',
                data: JSON.stringify({
                    nostaf: vNostaf,
                    tahun: vThn,
                    bulan: vBln
                }),
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
        })
    }

    async function getMajikan() {
        var vBln = $('#hidBulan').text();
        var vThn = $('#hidTahun').text();
        var vNostaf = $('#lbl1').text();

        return new Promise((resolve, reject) => {
            $.ajax({
                url: "Transaksi_WS.asmx/LoadListPotonganMaj",
                method: 'POST',
                data: JSON.stringify({
                    nostaf: vNostaf,
                    tahun: vThn,
                    bulan: vBln
                }),
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
        })
    } 

    

   

</script>
</asp:Content>
