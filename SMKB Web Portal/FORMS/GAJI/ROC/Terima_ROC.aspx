<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Terima_ROC.aspx.vb" Inherits="SMKB_Web_Portal.Terima_ROC" %>
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

        <label id="hidBulan" style="visibility:hidden" ></label>
        <label id="hidTahun" style="visibility:hidden"></label>
     <div class="hidParam" style="display:none"></div>
        <div class="form-row">
            <div class="form-group col-md-3">
                <asp:TextBox runat="server" ID="txtBlnThn" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>       
                <label class="input-group__label" for="Bulan/Tahun Gaji">Bulan/Tahun Gaji</label>
            </div>

        </div>


    <div class="card w-2" style="width: 40rem;align-content:center;">
        <h6 class="card-header">Rumusan</h6>
        <div class="card-body">
            Bil. Keseluruhan ROC :  <label id="jumroc" ></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bil. Belum Proses : <label id="jumgaji" ></label> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Bil. Telah Proses : <label id="jumelaun" ></label> 
        </div>
    </div>

        <asp:TextBox runat="server" ID="TextBox1" CssClass="form-control"  Visible="false" Style="width: 50%;" ></asp:TextBox>
     <asp:TextBox runat="server" ID="TextBox2" CssClass="form-control" Visible="false" Style="width: 50%;" ></asp:TextBox><br/>

   
    <div class="table-title">
        <h6>Paparan ROC Belum Diproses</h6>
        <hr>
        <button type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Proses">Proses</button>
        
    </div><br/>
    
        <div class=" -body">
                <div class="col-md-12">
                    <div class="transaction-table table-responsive">
                        <table id="tblListROC" class="table table-striped" style="width:100%">
                            <thead>
                                <tr>
                                    <th scope="col"><input type="checkbox" name="selectAll" id="selectAll" /></th>
                                    <th scope="col" style="width:100px">No. ROC</th>
                                    <th scope="col" style="width:250px">No. Staf | Nama</th>
                                    <th scope="col" style="width:100px">Tarikh Disahkan</th>
                                        <th scope="col" style="width:200px">No Ruj Surat</th>
                                    <th scope="col">Keterangan</th>
                                </tr>
                            </thead>
                            <tbody id="tableID_ListROC">
                                        
                            </tbody>

                        </table>
                    </div>
                </div>                  
        </div>

           

    <!-- Modal -->
                <div class="modal fade" id="infostaf" tabindex="-1" role="dialog"
                    aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="eMCTitle">Maklumat ROC</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="modal-body">

                                <h6 style="color:blue"><b>Maklumat Butiran Staf</b></h6>
                                <hr>

                                    <div class="form-row">
                                        <div class="form-group col-md-4">
<%--                                            <label for="idStaf" class="col-form-label">No.Permohonan:</label>
                                            <input type="text" class="form-control input-md" id="idStaf" style="background-color:#f3f3f3" >--%>
                                            
                                            <asp:TextBox runat="server" ID="txtNoStaf" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                            <label class="input-group__label" for="No. Staf">No. Staf</label>
                                        </div>

                                        <div class="form-group col-md-4">
                                           <%-- <label>No. KP</label>--%>
                                           <asp:TextBox runat="server" ID="txtNoKp" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                             <label class="input-group__label" for="No. KP">No. KP</label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            
                                            <asp:TextBox runat="server" ID="txtGjPokok" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                             <label class="input-group__label" for="Gaji Pokok">Gaji Pokok</label>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                           
                                            <asp:TextBox runat="server" ID="txtNama" TextMode="MultiLine" Rows="2" Enabled="false"  CssClass="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                              <label class="input-group__label" for="Nama">Nama</label>
                                        </div>

                                        <div class="form-group col-md-4">
                   
                                           <asp:TextBox runat="server" ID="txtJwtn" TextMode="MultiLine" Rows="2" Enabled="false"  CssClass="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                            <label class="input-group__label" for="Jawatan">Jawatan</label>
                                        </div>
                                        <div class="form-group col-md-4">
                   
                                            <asp:TextBox runat="server" ID="txtPjbt" TextMode="MultiLine" Rows="2" Enabled="false" CssClass="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                             <label class="input-group__label" for="Pejabat">Pejabat</label>
                                        </div>

                                    </div>
                                    <div class="form-row">
                                       <div class="form-group col-md-4">
                                        
                                            <asp:TextBox runat="server" ID="txtGred" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                            <label class="input-group__label" for="Gred Gaji">Gred Gaji</label>
                                        </div>

                                        <div class="form-group col-md-4">
                                          
                                           <asp:TextBox runat="server" ID="txtNoGaji" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                             <label class="input-group__label" for="No. Gaji">No. Gaji</label>
                                        </div>

                                        <div class="form-group col-md-4">

                                           <asp:TextBox runat="server" ID="txtSkim" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                             <label class="input-group__label" for="Skim">Skim</label>
                                        </div>

                                    </div>

                                    <h6 style="color:blue"><b>Maklumat Butiran ROC</b></h6>
                                    <hr>
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <asp:TextBox runat="server" ID="txtNoRoc" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                                 <label class="input-group__label" for="No. ROC">No. ROC</label>
                                            </div>

                                            <div class="form-group col-md-4">
                                               <asp:TextBox runat="server" ID="txtTkhRoc" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                                 <label class="input-group__label" for="Tarikh ROC">Tarikh ROC</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <asp:TextBox runat="server" ID="txtNoRuj" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                                 <label class="input-group__label" for="No. Ruj. Surat">No. Ruj. Surat</label>
                                            </div>
                                        </div>
                                       <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <asp:TextBox runat="server" ID="txtJenis" TextMode="MultiLine" Rows="2" Enabled="false" CssClass="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                              <label class="input-group__label" for="Jenis Perubahan">Jenis Perubahan</label>
                                            </div>

                                            <div class="form-group col-md-8">
                     
                                               <asp:TextBox runat="server" ID="txtKeterangan" TextMode="MultiLine" Rows="3" Enabled="false" CssClass="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                                 <label class="input-group__label" for="Keterangan">Keterangan</label>
                                           </div>
        
                                        </div>
 
                                    <hr>  

                                        <div class="row">
                                        <div class="col-md-12">
                                            <h6 style="color:blue"><B>Senarai Butiran Terperinci ROC</B></h6>
                                        <div class="transaction-table table-responsive">
                                        <table id="tblListDtROC" class="table table-striped" style="width:100%">
                                            <thead>
                                                <tr>
                                                     <th scope="col" style="width:10px">Bil</th>
                                                    <th scope="col" style="width:200px">Butiran</th>
                                                    <th scope="col" style="width:50px">Tarikh Mula</th>
                                                    <th scope="col" style="width:50px">Tarikh Tamat</th>
                                                     <th scope="col" style="width:50px">Jumlah (RM)</th>
                                                </tr>
                                            </thead>
                                            <tbody id="tableID_ListDtROC">
                                        
                                            </tbody>

                                        </table>
                                        </div>
                                        </div>
                                        </div> 
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="$('#infostaf').modal('hide'); return false;">Tutup</button>
                                
                            </div>
                        </div>
                    </div>
         </div>
            <!-- End Modal -->

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
                     <asp:Label runat="server" ID="lblModalMessaage" Text="Data selesai diproses."/>                          
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

    var tbl = null;
    var tbldt = "";
    var noroc_ = "";
    var bln = "";
    var thn = "";

    function notification(msg) {
        $("#notify").html(msg);
        $("#NotifyModal").modal('show');
    }
    $(document).ready(function () {
        show_loader();
        
        getBlnThn();
        //getRumusROC();


            tbl = $("#tblListROC").DataTable({
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
                    
                    "url": "ROC_WS.asmx/LoadListROC",
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
                drawCallback: function (settings) {
                    // Your function to be called after loading data
                    close_loader();
                },
                "columns": [
                    {
                        "data": "MS15_NoRoc",
                        'targets': 0,
                        'searchable': false,
                        'orderable': false,
                        render: function (data, type, row, meta) {
                            if (type !== "display") {
                                return data;

                            }

                            var link = ` <input type="checkbox" name="checkROC" class = "checkROC" id="checkROC" class="checkSingle"  />`;
                            return link;
                        }
                    },
                    {
                        "data": "MS15_NoRoc",
                        render: function (data, type, row, meta) {

                            if (type !== "display") {

                                return data;

                            }

                            var link = `<td style="width: 10%" >
                                            <label id="lblNo" name="lblNo"  class="lblNo" value="${data}" ><a id="myLink" class="yourButton" href="#" onclick="ShowPopup(this);">${data}</a></label>
                                            <input type ="hidden" class = "lblNo" value="${data}"/>
                                        </td>`;
                            return link;
                        }
                    },
                    { "data": "nama" },
                    { "data": "MS15_TkhDisahkan" },
                    { "data": "MS15_NoRujSurat" },
                    { "data": "MS15_Keterangan" }
                ]

            });

        tbldt = $("#tblListDtROC").DataTable({
            "responsive": true,
            "searching": false,
            "bLengthChange": false,
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

                "url": "ROC_WS.asmx/LoadDtROC",
                    method: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function () {
                        return JSON.stringify({ noroc: noroc_ })
                    },
                    "dataSrc": function (json) {
                        //var data = JSON.parse(json.d);
                        //console.log(data.Payload);
                        return JSON.parse(json.d);
                    }
                },
                "columns": [
                    {
                        "render": function (data, type, full, meta) {
                            return meta.row + 1;
                        }
                    },
                    { "data": "ROC01_Butiran" },
                    {
                        "data": "ROC01_TkhMulaB", className: "text-center"
                    },
                    {
                        "data": "ROC01_TkhTamatB", className: "text-center"
                    },
                    { "data": "roc01_amaunakandibayar", className: "text-right", render: $.fn.dataTable.render.number(',', '.', 2, '') }
                ]

            });
            ////delegation concept
            //$('#tableA').on('click', '#btnView1', function () {
            //})
        getRumusROC();
    });
    function getBlnThn() {
        //Cara Pertama

        fetch('ROC_WS.asmx/LoadBlnThnGaji', {
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
        if (data[0].bulan < 10) {
            sBulan = '0' + data[0].bulan;
        }
        else {
            sBulan = String(data[0].bulan);
        }
        $('#<%=txtBlnThn.ClientID%>').val(data[0].butir);
        $('#<%=TextBox1.ClientID%>').val(data[0].bulan);
        $('#<%=TextBox2.ClientID%>').val(data[0].tahun);
        $('#hidBulan').text(data[0].bulan);
        $('#hidTahun').text(data[0].tahun);
        $('.hidParam').html(data[0].tahun + sBulan);


    }
    //$("#selectAll").on("change", function () {
    //    //tbl.$("input[type='checkbox']").attr('checked', $(this.checked));
    //    if (this.checked) {
    //            $(".checkSingle").each(function () {
    //                this.checked = true;
    //            });
    //        } else {
    //            $(".checkSingle").each(function () {
    //                this.checked = false;
    //            });
    //        }

    //});
    $('#selectAll').click(function (e) {
        if ($(this).hasClass('checkedAll')) {
            $('input').prop('checked', false);
            $(this).removeClass('checkedAll');
        } else {
            $('input').prop('checked', true);
            $(this).addClass('checkedAll');
        }
    });

    $('#tblListROC').on('click', '.yourButton', function () {
        var val = $(this).closest('tr').find('td:eq(1)').text().trim(); // amend the index as needed
        var nostaf = $(this).closest('tr').find('td:eq(2)').text().trim().substring(0, 5);;
        noroc_ = val;
        //alert(nostaf)
        tbldt.ajax.reload();

        getInfoStaf(nostaf);
        getInfoROC(val);

        
    });
    function ShowPopup(obj) {
        $('#infostaf').modal('toggle');
    }
    function getRumusROC() {

        fetch('ROC_WS.asmx/LoadRumusROC', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },

            body: JSON.stringify()
        })
                .then(response => response.json())
            .then(data => setRumusROC(data.d))

    }
    function setRumusROC(data) {
        data = JSON.parse(data);
        
        if (data.totroc === "") {
            alert("Tiada data");
            return false;
        }

        $('#jumroc').text(data[0].totroc);
        $('#jumgaji').text(data[0].totbelum);
        $('#jumelaun').text(data[0].totterima);

        

        }
    function getInfoROC(noroc) {
        //Cara Pertama

        fetch('ROC_WS.asmx/LoadRekodROC', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
            //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify({ noroc: noroc })
        })
                .then(response => response.json())
            .then(data => setInfoROC(data.d))

    }
    function setInfoROC(data) {
        data = JSON.parse(data);
        if (data.R1NoROC === "") {
            alert("Tiada data");
            return false;
        }

        $('#<%=txtNoRoc.ClientID%>').val(data[0].R1NoROC);
        $('#<%=txtTkhRoc.ClientID%>').val(data[0].R1TkhRoc);
        $('#<%=txtNoRuj.ClientID%>').val(data[0].R1NoRujSurat);
        $('#<%=txtKeterangan.ClientID%>').val(data[0].R1Keterangan);
        $('#<%=txtJenis.ClientID%>').val(data[0].NamaROC);
    }

    function getInfoStaf(nostaf) {
        //Cara Pertama
        
        fetch('ROC_WS.asmx/LoadRekodStaf', {
                method: 'POST',
                headers: {
                    'Content-Type': "application/json"
                },
            //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify({ nostaf:nostaf  })
        })
        .then(response => response.json())
        .then(data => setInfoStaf(data.d))

    }

    function setInfoStaf(data) {
        data = JSON.parse(data);
        if (data.MS01_NoStaf === "") {
            alert("Tiada data");
            return false;
        }

        $('#<%=txtNoStaf.ClientID%>').val(data[0].MS01_NoStaf); 
        $('#<%=txtNoKp.ClientID%>').val(data[0].MS01_KpB); 
        $('#<%=txtNama.ClientID%>').val(data[0].MS01_Nama); 
        $('#<%=txtJwtn.ClientID%>').val(data[0].JawatanS); 
        $('#<%=txtGred.ClientID%>').val(data[0].gredgajis); 
        $('#<%=txtPjbt.ClientID%>').val(data[0].PejabatS); 
        $('#<%=txtSkim.ClientID%>').val(data[0].skim); 
        $('#<%=txtNoGaji.ClientID%>').val(data[0].MS01_NoStaf); 

    }

   
    //$(document).ready(function () {
    //    $("#checkedAll").change(function () {
    //        if (this.checked) {
    //            $(".checkSingle").each(function () {
    //                this.checked = true;
    //            });
    //        } else {
    //            $(".checkSingle").each(function () {
    //                this.checked = false;
    //            });
    //        }
    //    });

    //    $(".checkSingle").click(function () {
    //        if ($(this).is(":checked")) {
    //            var isAllChecked = 0;

    //            $(".checkSingle").each(function () {
    //                if (!this.checked)
    //                    isAllChecked = 1;
    //            });

    //            if (isAllChecked == 0) {
    //                $("#checkedAll").prop("checked", true);
    //            }
    //        }
    //        else {
    //            $("#checkedAll").prop("checked", false);
    //        }
    //    });
    //});


    //// Handle form submission event
    //$('#frm-example').on('submit', function (e) {
    //    var form = this;

    //    // Iterate over all checkboxes in the table
    //    table.$('input[type="checkbox"]').each(function () {
    //        // If checkbox doesn't exist in DOM
    //        if (!$.contains(document, this)) {
    //            // If checkbox is checked
    //            if (this.checked) {
    //                // Create a hidden element
    //                $(form).append(
    //                    $('<input>')
    //                        .attr('type', 'hidden')
    //                        .attr('name', this.name)
    //                        .val(this.value)
    //                );
    //            }
    //        }
    //    });
    //});

//});
    $('.btnSimpan').click(function () {
        var data = {
            data: []
        };
        var vparam = $('.hidParam').html();
        $('.checkROC:checked').each(function () {
            var tr = $(this).closest("tr");
            data.data.push({ NoStaf: tr.find("td:eq(2)").text(), NoROC: tr.find(".lblNo").text() })
        });   
  
        if (data.data.length === 0) {
            //alert('Sila buat pilihan untuk diproses.');
            notification('Sila buat pilihan terlebih dahulu pada checkbox dalam senarai untuk melaksanakan proses ROC.');
            return false;
        }
        show_loader();
        $.ajax({
            "url": "ROC_WS.asmx/SimpanROC",
            method: 'POST',
            "contentType": "application/json; charset=utf-8",
            "dataType": "json",
            data: JSON.stringify(data),
            success: function (response) {
                console.log('Success', response);
                var response = JSON.parse(response.d);
                console.log(response);
               
                notification(response.Message);
                tbl.ajax.reload();
               
            },
            error: function (xhr, textStatus, errorThrown) {
                console.error('Error:', errorThrown);
                reject(false);
            }

        });
    });
</script>
</asp:Content>
