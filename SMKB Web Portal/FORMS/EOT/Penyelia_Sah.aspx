<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Penyelia_Sah.aspx.vb" Inherits="SMKB_Web_Portal.Penyelia_Sah" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
 <%@ Register Src="~/FORMS/EOT/Modal_Message.ascx" TagName="popupM" TagPrefix="Message" %>
     <style>
        .checkbox-spacing {
    margin-right: 50px; /* Adjust the margin value as needed */
}

           /*input CSS for placeholder */
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
        color:black;
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
        color:black;
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
        .input-readonly {
         background-color: lightgray;
        }
    </style>
    <div id="PermohonanTab" class="tabcontent" style="display: block">

        <!-- Modal -->
        <div id="permohonan">
            
                <div class="modal-content" >
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Pengesahan Penyelia Untuk Tuntutan kerja Lebih Masa</h5>
                    </div>
                    <div class=" -body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataSenarai_trans" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>
                                            <th scope="col">No. Permohonan</th>
                                            <th scope="col">No. Staf</th>
                                            <th scope="col">Nama</th>
                                            <th scope="col">Tarikh Mohon</th>
                                            <th scope="col">Jumlah Jam Tuntut</th>
                                            <th scope="col">Jumlah (RM)</th> 
                                            <th scope="col">Surat Lewat</th> 
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_trans">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>        
             </div>

<div id="popupM">
         <div class="modal fade" id="Pengesahan" tabindex="-1" role="dialog"
                aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalCenterTitle1">Pengesahan EOT</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">
                             <label for="lblTuntutan"><u>Butir Borang Tuntutan</u></label>
                      
                            <br />
                              <%-- <asp:Panel ID="Panel2" runat="server" >--%>
                                 <div class="form-row">  
                                    
                                    <div class="form-group col-sm-2">

                                        <asp:TextBox ID="txtNoMohon" runat="server" Width="100%" CssClass="input-group__input" ReadOnly="true"></asp:TextBox>
                                        <label for="NoPermohonan" class="input-group__label">No. Permohonan</label><br />
                                       <%-- <input type="text" id="txtNoMohon"  class="form-control" style="width: 20%" />--%>
                                      
                                        
                                    </div>  
                                       <div class="form-group col-sm-2">
                                        <asp:TextBox ID="txtNoStaf" runat="server" Width="100%" CssClass="input-group__input" ReadOnly="true"></asp:TextBox>
                                        <label for="NoStaf" class="input-group__label">No. Staf</label><br />
                                       <%-- <input type="text" id="txtNoStaf"  class="form-control" style="width: 20%" />--%>
                                     
                                        
                                    </div>
                                       <div class="form-group col-sm-6">
                                        <asp:TextBox ID="txtNama" runat="server" Width="100%" CssClass="input-group__input" ReadOnly="true"></asp:TextBox>
                                        <label for="Nama" class="input-group__label">Nama</label><br />
                                       <%-- <input type="text" id="txtNoMohon"  class="form-control" style="width: 20%" />--%>
                                      
                                        
                                    </div>
                                </div>
                                <div class="form-row"> 
                                  
                                    <div class="form-group col-md-2">
                                         <label for="NamaLampiran" style="font-size:12px">Lampiran Surat Lewat &nbsp;&nbsp;&nbsp</label>
                                      
                                         <span id="uploadedFileNameLabel" style="display: inline"></span>
                                        
                                    </div>
                                </div>
                             <%-- </asp:Panel>--%>
                            <hr>                           
                               <div class="col-md-12">                                   
                                <table id="tblDataSenaraiEOT_trans" class="table table-striped" style="width: 99%">
                                    <thead>                                                                             
                                        <tr>
                                            <th scope="col">Sah</th>
                                            <th scope="col">Tidak Sah</th>
                                            <th scope="col">No Mohon</th>
                                            <th scope="col">Tarikh Tuntut</th>                                         
                                            <th scope="col">Jam Tuntut</th> 
                                            <th scope="col">Kadar</th> 
                                            <th scope="col">Amaun (RM)</th>
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_SenaraiEOT_trans">
                                    </tbody>
                                </table>
                            </div>
                             <div class="col-md-12">
                                <div class="form-row">  
                                      <div class="form-group col-md-10"> <h6 style="color:#FF0000;font-style:italic; align-content:center">** Sila klik rekod untuk lihat Transaksi Tuntutan </h6> </div>
                                      <div class="form-group col-md-1">
                                       <label for="ButSah">&nbsp</label>                          
                                            <button type="button" class="btn btn-secondary btnSah"  style="margin-top:32px" data-toggle="tooltip">Pengesahan</button>     
                                      </div>
                                </div>
                            </div>
                           <hr />
                             <div class="row">
                                        <div class="col-md-12">
                                            <label for="lblTransaksiT"><u>Transaksi Tuntutan</u></label>
                                            <br />
                                            <div class="transaction-table table-responsive">
                                                <table id="tblData" class="table table-striped" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                            <%--<th scope="col">Turutan</th>--%>
                                                            <th scope="col">Tarikh Tuntut</th>
                                                            <th scope="col">Jam Mula</th>
                                                            <th scope="col">Jam Tamat</th>    
                                                            <th scope="col">Jum Jam Tuntut</th>    
                                                            <th scope="col">Kadar Tuntut</th>
                                                            <th scope="col">Amaun Tuntut</th> 
                                                           
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tableID">
                                                                </tbody>               
                                                    <tfoot>
                                                        <tr>
                                                            <td colspan ="3"></td>
                                                            <td><strong>Jumlah Keseluruhan</strong></td>
                                                            <td>
                                                                <input  type="text" class="form-control" id="totalKadar" runat="server"  style="text-align: right; font-weight: bold" width="10%" value="0.000" readonly />
                                                            </td>
                                                            <td>
                                                                <input class="form-control" id="totalAmaun" runat="server"  style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />
                                                            </td>
                                                        </tr>
                                                    </tfoot>                
                                            </table>                             
                                            </div>
                                        </div>
                                </div>
                              <div class="col-md-12">
                                <div class="form-row">  
                                      <div class="form-group col-md-11"> <h6 style="color:#FF0000;font-style:italic; align-content:center">** Klik rekod untuk Kemaskini Transaksi Tuntutan </h6> </div>
                                     
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-row"> 
                                    <div class="form-group col-md-2">
                                     <label for="lbltajuk"><u>Kemaskini Transaksi Tuntutan</u></label>
                                     </div>
                                </div>

                            </div>
                             <div class="col-md-12">                    
                                <div class="form-row">
                                   <div class="form-group col-md-2">
                                        <input type="text" class="input-group__input" id="txtTkhTuntut" placeholder="&nbsp;" name="Tarikh Tuntut" runat="server" style="width:150px" readonly/> 
                                        <label  class="input-group__label" >Tarikh Tuntut</label>                                           
                                      
                                    </div>    
                                
                                   <div class="form-group col-md-2">
                                         <input type="text" class="input-group__input" id="txtJamMula" name="Jam Mula"  placeholder="&nbsp;"   runat="server"  style="text-align: right; width:100px" />                                        
                                         <label class="input-group__label" >Jam Mula</label>
                                         <br />
                                         <h9 style="color:#FF0000;font-size:12px"> (Nota : 2400 -> 0000)</h9> 
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtJamMula" CssClass="text-danger" ErrorMessage="*Sila Masukkan Jam Mula" ValidationGroup="Semak" Display="Dynamic"/>
                                    
                                   </div>
                              
                                
                                     <div class="form-group col-md-1">
                                            <input type="text" class="input-group__input" id="txtJamTamat" placeholder="&nbsp;" name="Jam Tamat" runat="server" style="text-align: right; width:80px" />   
                                            <label class="input-group__label" >Jam Tamat</label>
                                              
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtJamTamat" CssClass="text-danger" ErrorMessage="*Sila Masukkan Jam Tamat" ValidationGroup="Semak" Display="Dynamic"/>
                                     </div>
                                    <div class="form-group col-md-2">  
                                        <label for="ButKira"></label>
                    
                                        <button type="button" class="btn btn-info btnKira" style="margin-top:3px" data-toggle="tooltip"  data-validation-group="Semak">Kira</button>                
                                    </div>
                                </div>
                              </div>
                               <div class="col-md-12">      
                                <div class="form-row">
                                  
                                  <div class="form-group col-md-2">
                                         <input type="text" class="input-group__input input-readonly"  id="lblKadar" name="lblKadar" runat="server" style="text-align: right; width:100px" readonly />   
                                        <label for="Kadar" class="input-group__label" >Kadar Tuntut</label>                                                                   
                                  </div>  
                                  <div class="form-group col-md-2">
                                         <input type="text" class="input-group__input input-readonly" id="lblJamTuntut"  name="lblJamTuntut" runat="server" style="text-align: right; width:100px" readonly />   
                                        <label for="JamTuntut" class="input-group__label" >Jam Tuntut</label>                                                                   
                                  </div>                               
                                  <div class="form-group col-md-2">
                                         <input type="text" class="input-group__input input-readonly" id="lblAmnTuntut" runat="server" style="text-align: right; width:100px" readonly /> 
                                        <label for="AmaunTuntut" class="input-group__label" >Amaun Tuntut</label>
                                         
                                    </div>
                                
                               
                                    <div class="form-group col-md-4">
                                        <input type="text" class="input-group__input" id="txtUlasan" runat="server" placeholder="&nbsp;" name="Ulasan" style="text-align: left; width:360px"  Rows="2" TextMode="MultiLine" /> 
                                        <label for="Ulasan" class="input-group__label" >Ulasan</label>
                                          <input type="hidden" class="form-control"  id="hID" runat="server" readonly="readonly" />  
                                          
                                    </div>
                                       <div class="form-group col-md-2">
                                            <label for="ButSimpan">&nbsp</label>                          
                                            <button type="button" class="btn btn-secondary btnSimpan"  style="margin-top:1px" data-toggle="tooltip" data-validation-group="Semak">Simpan</button>                
                                    </div>
                                 </div>
                             </div>

                                                     
                          </div>                           
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>                           
                        </div>
                    </div>
                </div>
           
             </div>
              <Message:popupM runat="server" ID="Notify" /> 
           </div>   
         </div>

 
<script>
    function showModalAndReadSessionData() {
        var modalElement = document.getElementById('transaksi');
        var modal = new bootstrap.Modal(modalElement, {
            backdrop: 'static',
            dataBackdrop: 'false'
        });

        btnHome.style.visibility = 'visible';
        btnSignOut.style.visibility = 'visible';
        btnClose.style.visibility = 'hidden';


        var iconElement = document.createElement('i');

        iconElement.classList.add("fa", "fa-home");

        // Clear the existing content of btnModalLulus and append the iconElement
        btnHome.innerHTML = '';
        btnHome.appendChild(iconElement);
        // Set visibility of btnHome to 'visible'
        btnHome.style.visibility = 'visible';


        var iconElement2 = document.createElement('i');

        iconElement2.classList.add("fa", "fa-sign-out");


        // Clear the existing content of btnModalLulus and append the iconElement
        btnSignOut.innerHTML = '';
        btnSignOut.appendChild(iconElement2);

        modalElement.classList.add('modal-background');
        modal.show();

        // Call the function to read session data
        readSessionData();
    }

    function readSessionData() {
        $.ajax({
            type: "POST",
            url: '<%= ResolveUrl("~/FORMS/JURNAL/JURNAL KEWANGAN/Transaksi_WS.asmx/GetSessionData") %>',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //console.log("Session data:", response.d);
                
                    var id = response.d;   

                    // Find the DataTable instance
                    var table = $("#tblDataSenarai_trans").DataTable();
                  

                    // Search for the row with the matching No_Mohon value
                    var matchedRow = table.rows().data().filter(function (row) {
                     
                        return row.No_Mohon === id;
                    });

                    // Check if a matching row is found
                    if (matchedRow.length > 0) {
                        // Access the first matched row's data
                        var rowData = matchedRow[0];
                        ssss
                        // Perform any action with the matched row data
                        console.log("Matched row data:", rowData);

                        // Pass the matched row data to another function if needed
                        rowClickHandler(rowData);
                    } else {
                        console.log("No row found with ID:", id);
                    }

                    //$('#tblDataSenarai_trans').dataTable().fnDestroy();

                    // Handle the session data received from the server as needed
                },
                error: function (xhr, status, error) {
                    console.error("Error reading session:", error);
                    // Handle errors
                }
            });
        }
</script>
<script type="text/javascript">


    var tbl = null;
   
    var selectedData1 = [];
    var selectedData2 = [];
    var selectedIdMohon = "";
    var tbl1 = null;
    var tbl2 = null;
    var formattedDate = "";

    $(document).ready(function () {
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
                "url": "Transaksi_EOTs.asmx/LoadSenEOTPengesahanPenyelia",
                method: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: function () {
                    return JSON.stringify({ NoPegSah: '<%=Session("ssusrID")%>' });
                },
                "dataSrc": function (json) {
                    return JSON.parse(json.d);
                }

            },

            drawCallback: function (settings) {
                // Your function to be called after loading data
                close_loader();
            },


            "rowCallback": function (row, data) {

                // Add hover effect
                $(row).hover(function () {
                    $(this).addClass("hover pe-auto bg-warning");
                }, function () {
                    $(this).removeClass("hover pe-auto bg-warning");
                });

                // Add click event
                $(row).on("click", function () {
                    console.log(data);
                    
                    rowClickHandler(data);
                });

            },
            "columns": [
               
                {
                    "data": "No_Mohon",
                    render: function (data, type, row, meta) {

                        if (type !== "display") {

                            return data;

                        }
                        var link = `<td style="width: 10%" >
                                                <label id="lblNoArahan" name="lblNoArahan" class="lblNoArahan" value="${data}" >${data}</label>
                                                <input type ="hidden" class = "lblNoArahan" value="${data}"/>
                                            </td>`;
                        return link;
                    }
                },
                { "data": "No_Staf" },
                { "data": "Nama" },
                { "data": "Tkh_Mohon" },
                { "data": "Jam" },
                { "data": "AmaunTuntut" },
                { "data": "Filename" }
                //{
                //    className: "btnView",
                //    "data": "No_Mohon",
                //    render: function (data, type, row, meta) {

                //        if (type !== "display") {

                //            return data;

                //        }

                //        var link = `<button id="btnView" runat="server" data-id = "${data}" class="btn btnView" type="button" style="color: blue">
                //                                    <i class="fa fa-edit"></i>
                //                        </button>`;
                //        return link;
                //    }
                //}
            ]
        });



       

        
        tbl1 = $("#tblDataSenaraiEOT_trans").DataTable({
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
                "url": "Transaksi_EOTs.asmx/LoadSenEOTPengesahanPenyeliaDtl",
                method: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: function () {
                    return JSON.stringify({ id: selectedIdMohon });
                },
                "dataSrc": function (json) {
                    return JSON.parse(json.d);
                }

            },

            "rowCallback": function (row, data) {

                // Add hover effect
                $(row).hover(function () {
                    $(this).addClass("hover pe-auto bg-warning");
                }, function () {
                    $(this).removeClass("hover pe-auto bg-warning");
                });

                // Add click event
                $(row).on("click", function () {

                    var tujuan = data.Tujuan;
                    var catatan = data.Catatan;
                    var nostafsah = data.No_Staf_Sah;
                    var otptj = data.OT_Ptj;
                    var bulantuntut = data.Bulan_Tuntut;
                    var tahuntuntut = data.Tahun_Tuntut;
                    var nostaflulus = data.No_Staf_Lulus;
                   
                    var test = data.NoStaf;
                    console.log(data);
                    rowClickHandler1(data);
                });



             


            },


            "columns": [
                {
                    className: "btnView1",
                    "data": "Tkh_Tuntut",
                    render: function (data, type, row, meta) {

                        if (type !== "display") {

                            return data;

                        }

                        var checkboxes = `<input type="checkbox" class="checkbox-spacing checkbox-single column1-checkbox" name="check1" data-id="${data}">`;

                        return checkboxes;

                    }
                },
                {
                    className: "btnView2",
                    "data": "Tkh_Tuntut",
                    render: function (data, type, row, meta) {

                        if (type !== "display") {

                            return data;

                        }

                        var checkboxes = `<input type="checkbox" class="checkbox-spacing checkbox-single column2-checkbox" name="check2" data-id="${data}">`;

                        return checkboxes;

                    }
                },
                {

                    "data": "No_Mohon",
                    render: function (data, type, row, meta) {

                        if (type !== "display") {

                            return data;

                        }
                        var link = `<td style="width: 10%" >
                                                <label id="lblNoMohon1" name="lblNoMohon1" class="lblNoMohon1" value="${data}" >${data}</label>
                                            
                                            </td>`;
                        return link;
                    }
                },
                {
                    "data": "Tkh_Tuntut",
                    render: function (data, type, row, meta) {

                        if (type !== "display") {

                            return data;

                        }
                        var link = `<td style="width: 10%" >
                                                <label id="lblTkh" name="lblTkh" class="lblTkh" value="${data}" >${data}</label>
                                            
                                            </td>`;
                        return link;

                    }
                },

              
                { "data": "Jum_Jam_Sah" },
                { "data": "Kadar_Sah" },
                { "data": "Amaun_Sah" },
                { "data": "Tujuan", "visible": false },
                { "data": "Catatan", "visible": false },
                { "data": "No_Staf_Sah", "visible": false },
                { "data": "OT_Ptj", "visible": false },
                { "data": "Bulan_Tuntut", "visible": false },
                { "data": "Tahun_Tuntut", "visible": false },
                { "data": "No_Staf_Lulus", "visible": false }
            ]

        });

        tbl2 = $("#tblData").DataTable({
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
                "url": "Transaksi_EOTs.asmx/LoadRecordEOTbyNoMohonPenyelia",
                method: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: function (d) {
                    return JSON.stringify({ id: $('#<%=txtNoMohon.ClientID%>').val(), Tarikhtuntut: formattedDate });

                },
                "dataSrc": function (json) {
                    return JSON.parse(json.d);
                }
            },

            "rowCallback": function (row, data) {

                // Add hover effect
                $(row).hover(function () {
                    $(this).addClass("hover pe-auto bg-warning");
                }, function () {
                    $(this).removeClass("hover pe-auto bg-warning");
                });

                // Add click event
                $(row).on("click", function () {

                   
                    console.log(data);
                    rowClickHandler2(data);
                });


            },

            "columns": [
                //  { "data": "No_Turutan" },
                { "data": "Tkh_Tuntut" },
                { "data": "Jam_Mula_Sah" },
                { "data": "Jam_Tamat_Sah" },
                { "data": "Jum_Jam_Sah" },
                {
                    "data": "Kadar_Sah", className: "text-right",
                    "render": function (data, type, row) {
                        // Format the Kadar_Tuntut column with three decimal places
                        if (type === 'display' || type === 'filter') {
                            return parseFloat(data).toFixed(3);
                        }
                        return data;
                    }


                },
                {
                    "data": "Amaun_Sah", className: "text-right",
                    "render": function (data, type, row) {
                        // Format the Kadar_Tuntut column with three decimal places
                        if (type === 'display' || type === 'filter') {
                            return parseFloat(data).toFixed(2);
                        }
                        return data;
                    }


                },
                { "data": "ID", "visible": false }
               
            ],

            "drawCallback": function (settings) {
                var api = this.api();
                var counter = 0;
                var listofdata = api.rows().data();
                var totaldata = listofdata.length;
                var jumlahAmaun = 0.00;
                var jumlahKadar = 0.000;
                while (counter < totaldata) {
                    jumlahAmaun += parseFloat(listofdata[counter].Amaun_Sah)
                    jumlahKadar += parseFloat(listofdata[counter].Kadar_Sah)
                    counter += 1;
                }

                var jumlahKadar = parseFloat(jumlahKadar).toFixed(3);
                var fixedAmaun = parseFloat(jumlahAmaun).toFixed(2);
             
                <%--$('#<%=totalAmaun.ClientID%>').val(jumlahAmaun);--%>
                $('#<%=totalAmaun.ClientID%>').val(fixedAmaun);
               $('#<%=totalKadar.ClientID%>').val(jumlahKadar);

             //   $("#MainContent_FormContents_totalAmaun").val(fixedAmaun);
              //  $("#MainContent_FormContents_totalKadar").val(jumlahKadar);

                // Output the data for the visible rows to the browser's console
            }
        });

    });
        var tableID_Senarai = "#tblDataSenarai_trans";
        var searchQuery = "";
        var oldSearchQuery = "";
        var tableID = "#tblData";
        var objMetadata = [{
            "obj1": {
                "id": "",
                "oldSearchQurey": "",
                "searchQuery": ""
            }
        }, {
            "obj2": {
                "id": "",
                "oldSearchQurey": "",
                "searchQuery": ""
            }
        }]


    // andling the row click event
    async function rowClickHandler(orderDetail) {
       // clearAllRowsHdr();
        $('#Pengesahan').modal('toggle');
        var id = orderDetail.No_Mohon;
        var TkhTuntut = orderDetail.TkhTuntut;
        $('#<%=txtNoStaf.ClientID%>').val(orderDetail.No_Staf);
        $('#<%=txtNama.ClientID%>').val(orderDetail.Nama);
        $('#<%=txtNoMohon.ClientID%>').val(id);

        var strFileName = orderDetail.Filename;
        var fileUrl = "~/UPLOAD/EOT/" + strFileName;

        var fileLink = $('<a></a>');
        fileLink.attr('href', fileUrl);
        fileLink.text(strFileName);
        $('#uploadedFileNameLabel').empty(); // Clear any existing content
        $('#uploadedFileNameLabel').append(fileLink);

       
        selectedIdMohon = id;
        tbl1.ajax.reload();
     
       
        
    }

 


    // Add event listeners to synchronize checkbox states
    $('#tblDataSenaraiEOT_trans').on('change', '.column1-checkbox', function () {
        var dataId = $(this).data('id');
        var column2Checkbox = $('.column2-checkbox[data-id="' + dataId + '"]');

        if ($(this).is(':checked')) {
            column2Checkbox.prop('checked', false);
        }
    });

    $('#tblDataSenaraiEOT_trans').on('change', '.column2-checkbox', function () {
        var dataId = $(this).data('id');
        var column1Checkbox = $('.column1-checkbox[data-id="' + dataId + '"]');

        if ($(this).is(':checked')) {
            column1Checkbox.prop('checked', false);
        }
    });


    $(document).on('change', '.column1-checkbox', function () {
        //var checkedCheckboxes1 = $('.column1-checkbox:checked');

        //if (checkedCheckboxes1.length > 0) {
        //    selectedData1 = [];

        //    checkedCheckboxes1.each(function () {
        //        selectedData1.push($(this).data("id"));
        //    });

        //}
    });


    $(document).on('change', '.column2-checkbox', function () {
        //var checkedCheckboxes2 = $('.column2-checkbox:checked');

        //if (checkedCheckboxes2.length > 0) {
        //    selectedData2 = [];

        //    checkedCheckboxes2.each(function () {
        //        var data = $(this).closest('tr').find('td:first-child input').val();
        //        selectedData2.push(data);
        //    });

        //}
    });

    async function rowClickHandler1(tranEOT) {
        var nomohon = tranEOT.No_Mohon;
        var tkhtuntut = tranEOT.Tkh_Tuntut;

        $('#<%=txtTkhTuntut.ClientID%>').val(tranEOT.Tkh_Tuntut)
       
        <%--$('#<%=txtTujuan.ClientID%>').val(tranEOT.Tujuan)
        $('#<%=txtCatatan.ClientID%>').val(tranEOT.Catatan)
        $('#<%=txtNoStafSah.ClientID%>').val(tranEOT.No_Staf_Sah)
        $('#<%=txtOTPtj.ClientID%>').val(tranEOT.OT_Ptj)
        $('#<%=txtBulantuntut.ClientID%>').val(tranEOT.Bulan_Tuntut)
        $('#<%=txtTahuntuntut.ClientID%>').val(tranEOT.Tahun_Tuntut)
        $('#<%=txtNoStafLulus.ClientID%>').val(tranEOT.No_Staf_Lulus)--%>
       
        //var dateObject = new Date(tkhtuntut);
        
      
        // Format the date as "yyyy-DD-mm"

        //formattedDate = dateObject.getFullYear() + "-" + ("0" + (dateObject.getMonth() + 1)).slice(-2) + "-" + ("0" + dateObject.getDate()).slice(-2);
        var arrTarikh = tkhtuntut.split("/");
        formattedDate = arrTarikh[2] + "-" + arrTarikh[1] + "-" + arrTarikh[0]
        tbl2.ajax.reload();
  
    }

    async function rowClickHandler2(tranEOT1) {
       
        console.log(tranEOT1);       
        $('#<%=txtTkhTuntut.ClientID%>').val(tranEOT1.Tkh_Tuntut)
        $('#<%=lblKadar.ClientID%>').val(tranEOT1.Kadar_Sah)
        $('#<%=txtJamMula.ClientID%>').val(tranEOT1.Jam_Mula_Sah)
        $('#<%=txtJamTamat.ClientID%>').val(tranEOT1.Jam_Tamat_Sah)
        $('#<%=lblJamTuntut.ClientID%>').val(tranEOT1.Jum_Jam_Sah)
        $('#<%=lblAmnTuntut.ClientID%>').val(tranEOT1.Amaun_Sah)
        $('#<%=hID.ClientID%>').val(tranEOT1.ID)
        

     
      }


    $('.btnKira').click(async function () {
        var jumRecord = 0;
        var acceptedRecord = 0;
        var msg = "";
        var result = await performCheck("Semak");
        var bezaJam;
        var JamTuntut;
        var Jam;
        var Minit;
        
        if (result === false) {
            return false;
        }

        var mula = $('#<%=txtJamMula.ClientID%>').val();
         var tamat = $('#<%=txtJamTamat.ClientID%>').val();


         var JMula = parseInt(mula.substring(0, 2), 10);
         var JTamat = parseInt(tamat.substring(0, 2), 10);
         var MMula = parseInt(mula.substring(2, 4), 10);
         var MTamat = parseInt(tamat.substring(2, 4), 10);

         if (tamat !== "0000") {
             if (JTamat >= JMula) {
                 var bezaJam = ((JTamat * 60) + MTamat) - ((JMula * 60) + MMula);
                 var JamTuntut = "";


                 if (parseInt(bezaJam / 60) === 0) {
                     var Minit = parseInt(bezaJam % 60);
                     Minit = Minit < 10 ? "000" + Minit : "00" + Minit;
                     JamTuntut = Minit;

                 } else {
                     if (parseInt(bezaJam % 60) === 0) {
                         var Jam = parseInt(bezaJam / 60);
                         if (Jam >= 8) {
                             Jam = Jam - 1;
                         }
                         Jam = Jam < 10 ? "0" + Jam + "00" : Jam + "00";
                         JamTuntut = Jam;

                     } else {
                         var Jam = parseInt(bezaJam / 60);
                         var Minit = parseInt(bezaJam % 60);
                         if (Jam >= 8) {
                             Jam = Jam - 1;
                         }
                         Jam = Jam < 10 ? "0" + Jam : Jam;
                         Minit = Minit < 10 ? "0" + Minit : Minit;
                         JamTuntut = Jam + "" + Minit;

                     }
                 }
                
                 /* $("#lblJamTuntut").val(JamTuntut);*/
                 $("#MainContent_FormContents_lblJamTuntut").val(JamTuntut);

             }
         }


         var newArahan = {
             MohonEOT: {

                
                 Tkh_Tuntut: $('#<%= txtTkhTuntut.ClientID%>').val(),
                     Jam_Mula: $('#<%=txtJamMula.ClientID%>').val(),
                 Jam_Tamat: $('#<%=txtJamTamat.ClientID%>').val(),

             }

         }

         var result = JSON.parse(await ajaxKiraAmtEOT(newArahan));
       // notification(result.Message);
     });


    async function ajaxKiraAmtEOT(MohonEOT) {

        $.ajax({

            url: 'Transaksi_EOTs.asmx/KiraAmtEOT',
            method: 'POST',
            data: JSON.stringify(MohonEOT),

            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                var response = JSON.parse(data.d)
             
                console.log(response);
                var payload = response.Payload;

                $("#MainContent_FormContents_lblAmnTuntut").val(payload);

            },
            error: function (xhr, textStatus, errorThrown) {
                console.error('Error:', errorThrown);
                reject(false);
            }

        });

    }

    async function performCheck(e) {
        if (e === undefined || e === null) {
            e = "groupone";
        }
        if (await checkValidationGroup(e)) {
            //alert('it is valid');
            return true;
        }
        else {
            //alert("not valid");
            return false;
        }
    }


    async function checkValidationGroup(valGrp) {
        var rtnVal = true;
        var errCheck = 0;
        //$('#ContentPlaceHolder1_msg2').html("");

        for (i = 0; i < Page_Validators.length; i++) {
            if (Page_Validators[i].validationGroup == valGrp) {
                if (document.getElementById(Page_Validators[i].controltovalidate) != null) {
                    ValidatorValidate(Page_Validators[i]);
                    //console.log(+ "---" + Page_Validators[i].isValid);
                    if (!Page_Validators[i].isvalid) {
                        errCheck = 1;
                        rtnVal = false;
                        //break; //exit for-loop, we are done.
                    }
                }
            }
        }

        return rtnVal;
    }



    $('.btnSimpan').click(async function () {
        var jumRecord = 0;
        var acceptedRecord = 0;
        var msg = "";
        var result = await performCheck("Semak");

        var tkhtuntut = $('#<%= txtTkhTuntut.ClientID%>').val();
        var idn = $('#<%=hID.ClientID%>').val();
        var lala = $("#MainContent_FormContents_lblAmnTuntut").val()
        
        var arrTarikh = tkhtuntut.split("/");
        formattedDate = arrTarikh[2] + "-" + arrTarikh[1] + "-" + arrTarikh[0]
      
        if (result === false) {
            return false;
        }
        var newArahan = {
            MohonEOT: {

                    Tkh_Tuntut: formattedDate,
                    Jam_Mula: $('#<%=txtJamMula.ClientID%>').val(),
                    Jam_Tamat: $('#<%=txtJamTamat.ClientID%>').val(),                 
                    Amaun: $("#MainContent_FormContents_lblAmnTuntut").val(),
                    Jum_Jam: $("#MainContent_FormContents_lblJamTuntut").val(),
                    Kadar: $("#MainContent_FormContents_lblKadar").val(),
                    Ulasan: $('#<%=txtUlasan.ClientID%>').val(),
                    ID: idn,
                  
                    }, q: $('#<%=txtNoMohon.ClientID%>').val()
           }

          
            console.log(newArahan);
           
            acceptedRecord += 1;


        let confirm = false
        confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
        console.log(confirm)
        if (!confirm) {
            return
        }
        else {

            (await ajaxSaveEOT(newArahan));

        }

            //msg = "Anda pasti ingin menyimpan tuntutan rekod ini?"

            //if (!confirm(msg)) {
            //    return false;
            //}

            //(await ajaxSaveEOT(newArahan));
           

    });

    $('.btnSah').click(async function () {

        var checkedCheckboxes1 = $('.column1-checkbox:checked');
        selectedData1 = [];
        if (checkedCheckboxes1.length > 0) {
            checkedCheckboxes1.each(function () {
                selectedData1.push($(this).data("id"));
            });

        }


        var checkedCheckboxes2 = $('.column2-checkbox:checked');
        selectedData2 = [];
        if (checkedCheckboxes2.length > 0) {
            checkedCheckboxes2.each(function () {
                selectedData2.push($(this).data("id"));
            });

        }
      
        if (selectedData1.length > 0) {
            $.ajax({
                url: 'Transaksi_EOTs.asmx/SimpanSahPenyelia',
                method: 'POST',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ senaraiSah: selectedData1, senaraiTidakSah: selectedData2, nomohon: $('#<%=txtNoMohon.ClientID%>').val() }),
                success: function (data) {
                    // Handle the success response
                    console.log('Success:', data.d);
                    var response = JSON.parse(data.d)
                    Notification(response.Message)
                    tbl.ajax.reload();
                    //closeModal();

                    $('#Pengesahan').modal('hide');


                },
                error: function (xhr, status, error) {
                    // Handle the error response
                    console.error('Error:', error);
                }
            });
        }
    });




        async function ajaxSaveEOT(MohonEOT) {
         
            $.ajax({
              
                url: 'Transaksi_EOTs.asmx/SimpanEOTPenyelia',
                method: 'POST',
                //data: JSON.stringify(MohonEOT),
                data: JSON.stringify(MohonEOT),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var response = JSON.parse(data.d)
                    Notification(response.Message)
                  
                    tbl.ajax.reload();
                    tbl1.ajax.reload();
                    tbl2.ajax.reload();


                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                    reject(false);
                }

            });

    }


</script>



</asp:Content>
