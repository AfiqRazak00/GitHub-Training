<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Sokong_EOT.aspx.vb" Inherits="SMKB_Web_Portal.Sokong_EOT" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <%@ Register Src="~/FORMS/EOT/Modal_Message.ascx" TagName="popupM" TagPrefix="Message" %>
    <style>
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

        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button {
        -webkit-appearance: none;
        margin: 0;
        }

        /* Firefox */
        input[type=number] {
        -moz-appearance: textfield;
        }
        .baccolor{
	        background-color:lightgray;
	    }
    </style>
   
   <%-- <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>--%>
    

    <!--div id="PermohonanTab" class="tabcontent" style="display: block"-->

        <!-- Modal -->
        <div id="permohonan">
            
                <div class="modal-content" >
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Permohonan Tuntutan Elaun Lebih Masa Yang Belum Diluluskan</h5>

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
                                            <th scope="col">Jumlah Jam Sah</th>
                                            <th scope="col">Jumlah Amaun Sah (RM)</th> 
                                            <th scope="col">Tarikh Sah</th>                                            
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_trans">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle2">Senarai Permohonan Tuntutan Elaun Lebih Masa Yang Telah Diluluskan</h5>

                    </div>
                    <div class=" -body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataSenarai_trans_Lulus" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>
                                            <th scope="col">No. Permohonan</th>
                                            <th scope="col">No. Staf</th>
                                            <th scope="col">Nama</th>
                                            <th scope="col">Tarikh Mohon</th>
                                            <th scope="col">Jumlah Jam Lulus</th>
                                            <th scope="col">Jumlah Lulus (RM)</th> 
                                            <th scope="col">Tarikh Sah</th> 
                                            <th scope="col">Tarikh Lulus</th> 
                                            
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_trans_Lulus">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
     </div>
    <!--- modal jadual -->

     <div class="modal fade" id="infojadual1" tabindex="-1" role="dialog" data-backdrop="static"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header baccolor">
                    <h5 class="modal-title" id="fMCTitlejadual">Kadar Tuntutan</h5>
                    <button type="button" class="btn btn-default tutupKadar"  aria-label="Close" data-dismiss="modal">
                        <span aria-hidden="true">X</span>
                    </button>
                </div>

                 <div class="modal-body">
                     <div class="form-row">
                        <div class="col-md-12">                        
                            <div class="transaction-table table-responsive">
                                <table id="tblDataJadual" class="table table-striped" style="width: 100%">
                                    <thead>
                                        <tr>                                            
                                            <th scope="col">Butiran</th>
                                            <th scope="col">Kadar</th>                                                                                                 
                                        </tr>
                                    </thead>
                                    <tbody id="tblDataJadual2">
                                               
                                    </tbody>     
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
 </div>
<div id="popupM">
    <!-- Modal -->
    <div class="modal fade" id="infostaf" tabindex="-1" role="dialog" data-backdrop="static"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="fMCTitle">Maklumat Kerja Lebih Masa</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                           <div class="form-row">
                               <div class="form-group col-md-12" align="left">
                                   
                                     <label for="lblMaklumat"><u>Maklumat Pemohon</u></label></div>

                           </div>
                            
                           <div class="form-row">

                                <div class="form-group col-md-3">
                                     <asp:TextBox runat="server" ID="txtNoMohon"  class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox> 
                                     <label for="NoMohon" class="input-group__label">No. Mohon</label>
                                                       
                                </div>
                                <div class="form-group col-md-3">
                                    <asp:TextBox runat="server" ID="txtNoStaf" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox> 
                                    <label for="NoStaf" class="input-group__label">No. Staf</label>                                                       
                                </div>

                                 <div class="form-group col-md-3">
                                      <asp:TextBox runat="server" ID="txtNama" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox>
                                    <label for="Nama" class="input-group__label">Nama</label>                                                                               
                                </div>
                                <div class="form-group col-md-3">
                                  
                                    <asp:TextBox runat="server" ID="txttkhMohon" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox>
                                      <label for="tarikhMohon" class="input-group__label">Tarikh Mohon</label>
                                </div>
                            </div>
                           
                            <div class="form-row">
                                <div class="form-group col-md-3">
                                  
                                    <asp:TextBox runat="server" ID="txtGaji" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox>
                                      <label for="GajiPokok" class="input-group__label">Gaji Pokok</label>
                                </div>
                                <div class="form-group col-md-3">
                                   
                                    <asp:TextBox runat="server" ID="txtJwtn" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox>
                                     <label for="Jawatan" class="input-group__label">Jawatan</label>
                                </div>
                                <div class="form-group col-md-6">
                                   
                                    <asp:TextBox runat="server" ID="txtPjbt" ReadOnly="true" class="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                     <label for="Pejabat" class="input-group__label">PTJ</label>                                
                                </div>                                                               
                            </div>
                          <div class="form-row">
                               <div class="form-group col-md-12" align="left">
                                   
                                     <label for="lblBajet"><u>Maklumat Bajet</u></label></div>

                           </div>
                        <div class="form-row">                              
                               <div class="form-group col-md-3">                                
                                    <asp:TextBox runat="server" ID="txtJumJamLulus" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox>
                                    <label for="jumjamtuntutlulus" class="input-group__label">Jumlah Jam Lulus </label>
                                </div>
                              <div class="form-group col-md-3">
                               
                                <asp:TextBox runat="server" ID="txtAmaunLulus" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox>
                                <label for="AmaunLulus" class="input-group__label">Jum Amaun Lulus</label>
                            </div>
                             
                              <div class="form-group col-md-3">
                               
                                <asp:TextBox runat="server" ID="txtJumJamTuntut" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox>
                                <label for="JumJamTuntut" class="input-group__label">Jum Jam Tuntutan Disahkan</label>
                              </div>

                               <div class="form-group col-md-3">
                               
                                <asp:TextBox runat="server" ID="txtAmaunTuntut" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox>
                                <label for="AmaunTuntut" class="input-group__label">Jumlah Tuntutan Disahkan</label>
                              </div>                           
                          </div>
                          <div class="form-row">
                              <div class="form-group col-md-3">
                                
                                <asp:TextBox runat="server" ID="txtOT" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox>
                                <label for="OT" class="input-group__label">OT(Belum Lulus)</label>
                                <input type="hidden" class="form-control"  id="hidOT" style="width:100px" readonly="readonly" />
                              </div>
                             
                                <div class="form-group col-md-3">                               
                                    <asp:TextBox runat="server" ID="txtPeruntukan" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox>
                                    <label for="PeruntukanKasar" class="input-group__label">Baki Peruntukan Kasar</label>
                                  
                                </div>

                               <div class="form-group col-md-3">                               
                                    <asp:TextBox runat="server" ID="txtPeruntukanOT" class="input-group__input" ReadOnly="true" Style="width: 100%;" ></asp:TextBox>
                                    <label for="PeruntukanLulus" class="input-group__label">Baki Peruntukan Selepas OT Diluluskan</label>             
                                </div>                           
                            </div>
                         <div class="form-row"> 
                            
                                   <div class="form-group col-md-6" align="left">  
                                       <label for="NamaLampiran" style="font-size:12px">Lampiran Surat Lewat &nbsp;&nbsp;&nbsp</label>
                                      <span id="uploadedFileNameLabel" style="display: inline"></span>
                                    </div>

                                    <div class="form-group col-md-6" align="right">                               
                                        <button id="btnJadual" type="button" class="btn btn-info btnJadual" data-toggle="modal"  data-target="#infojadual1" data-placement="bottom" title="Jadual">Jadual Kadar Tuntutan</button>
                               
                                    </div>
                             </div>
                        

                            <div class="form-row">
                                        <div class="col-md-12">
                                            <label for="lblTransaksiT"><u>Transaksi Permohonan Tuntutan Elaun Lebih Masa</u></label>
                                            <br />
                                            <div class="transaction-table table-responsive">
                                                <table id="tblData2" class="table table-striped" style="width: 100%">
                                                    <thead>
                                                        <tr>
                                                           
                                                            <th scope="col">Status Terima</th>
                                                            <th scope="col">No Turutan</th> 
                                                            <th scope="col">Tarikh Tuntut</th>
                                                            <th scope="col">Jam Mula</th>    
                                                            <th scope="col">Jam Tamat</th>    
                                                            <th scope="col">Jum Jam Sah</th>
                                                            <th scope="col">Kadar</th> 
                                                            <th scope="col">Amaun Sah</th> 
                                                            <th scope="col">OT PTJ</th> 
                                                            <th scope="col">Ulasan Sah</th> 
                                                             <th scope="col">id</th> 
                                                         
                                                            
                                                        </tr>
                                                    </thead>
                                                    <tbody id="tableID2">
                                               
                                                    </tbody>               
                                                   <tfoot>
                                                        <tr>
                                                            <td colspan ="4"></td>
                                                            <td colspan ="3"><strong>Jumlah Keseluruhan</strong></td>
                                                            <%--<td>
                                                                <input  type="text" class="form-control" id="totalKadar" runat="server"  style="text-align: right; font-weight: bold" width="10%" value="0.000" readonly />
                                                            </td>--%>
                                                            <td>
                                                                <input class="form-control" id="totalAmaunNomohon"  runat="server"  style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />
                                                            </td>
                                                        </tr>
                                                    </tfoot>            
                                            </table>                             
                                            </div>
                                        </div>
                                </div>
                            
                         <div class="form-row">  
                             <div class="form-group col-md-6" align="left" style="color:red"> ** Sila klik pada No Turutan untuk melihat Butiran Permohonan
                           
                            </div>
                            <div class="form-group col-md-6" align="right">
                               
                                <button id="btnShow" type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
                               
                            </div>
                        </div>
                       <div class="form-row">
                            <div class="col-md-12">
                                            <label for="butiranmohon"><u>Butiran Permohonan Pemohon</u></label>
                                            <br /></div>
                       </div>
                       <div class="form-row">
                                <div class="form-group col-md-4">
                                     <asp:TextBox runat="server" ID="txttkhTuntut"  class="input-group__input" ReadOnly="true" Style="width: 100%;" placeholder="&nbsp;" name="Tarikh Tuntut" ></asp:TextBox> 
                                     <label for="tkhtuntut" class="input-group__label">Tarikh Tuntut</label>

                                                   
                                </div>
                                <div class="form-group col-md-4">
                                    <asp:TextBox runat="server" ID="txtJamMulaTuntut" class="input-group__input" ReadOnly="true" Style="width: 100%;" placeholder="&nbsp;" name="Jam Mula" ></asp:TextBox> 
                                    <label for="jamumulatuntut" class="input-group__label">Jam Mula</label>                                                       
                                </div>

                                 <div class="form-group col-md-4">
                                      <asp:TextBox runat="server" ID="txtJamTamatTuntut" class="input-group__input" ReadOnly="true" Style="width: 100%;" placeholder="&nbsp;" name="Jam Tamat" ></asp:TextBox>
                                    <label for="jamtamattuntut" class="input-group__label">Jam Tamat</label>                                                                               
                                </div>
                        </div>
                        <div class="form-row">
                                <div class="form-group col-md-4">
                                  
                                    <asp:TextBox runat="server" ID="txtJamTuntut" class="input-group__input" ReadOnly="true" Style="width: 100%;" placeholder="&nbsp;" name="Jam Tuntut" ></asp:TextBox>
                                      <label for="jamtuntut" class="input-group__label">Jam Tuntut</label>
                                </div>
                                <div class="form-group col-md-4">
                                  
                                    <asp:TextBox runat="server" ID="txtKadarTuntut" class="input-group__input" ReadOnly="true" Style="width: 100%;" placeholder="&nbsp;"  name="Kadar"></asp:TextBox>
                                      <label for="kadartuntut" class="input-group__label">Kadar</label>
                                </div>
                                <div class="form-group col-md-4">
                                  
                                    <asp:TextBox runat="server" ID="txtAmnTuntut" class="input-group__input" ReadOnly="true" Style="width: 100%;" placeholder="&nbsp;"  name="Amaun(RM)"></asp:TextBox>
                                      <label for="Amauntuntut" class="input-group__label">Amaun(RM)</label>
                                   
                                </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-12">
                                            <label for="butiranLulus"><u>Butiran Permohonan Pengesahan</u></label>
                                            <br /></div>
                        </div>
                         <div class="form-row">
                                <div class="form-group col-md-4">
                                     <asp:TextBox runat="server" ID="txtPegawai"  class="input-group__input" ReadOnly="true" placeholder="&nbsp;" Style="width: 100%;" name="Pegawai" ></asp:TextBox> 
                                     <label for="Pegawai" class="input-group__label">Pegawai</label>
                                                       
                                </div>
                                <div class="form-group col-md-4">
                                    <asp:TextBox runat="server" ID="txtJamMulaSah" class="input-group__input" ReadOnly="true" placeholder="&nbsp;" Style="width: 100%;"  name="Jam Mula" ></asp:TextBox> 
                                    <label for="jamumulasah" class="input-group__label">Jam Mula</label>                                                       
                                </div>

                                 <div class="form-group col-md-4">
                                      <asp:TextBox runat="server" ID="txtJamTamatSah" class="input-group__input" ReadOnly="true" placeholder="&nbsp;" Style="width: 100%;" name="Jam Tamat" ></asp:TextBox>
                                    <label for="jamtamatsah" class="input-group__label">Jam Tamat</label>                                                                               
                                </div>
                        </div>
                    
                        <div class="form-row">
                                <div class="form-group col-md-4">
                                  
                                    <asp:TextBox runat="server" ID="txtJamSah" class="input-group__input" ReadOnly="true" placeholder="&nbsp;" Style="width: 100%;" name="Jam Tuntut" ></asp:TextBox>
                                      <label for="jamsah" class="input-group__label">Jam Tuntut</label>
                                </div>
                                <div class="form-group col-md-4">
                                  
                                    <asp:TextBox runat="server" ID="txtKadarSah" class="input-group__input" ReadOnly="true" placeholder="&nbsp;" Style="width: 100%;" name="Kadar"></asp:TextBox>
                                      <label for="kadarsah" class="input-group__label">Kadar</label>
                                </div>
                                <div class="form-group col-md-4">
                                  
                                    <asp:TextBox runat="server" ID="txtAmnSah" class="input-group__input" ReadOnly="true" placeholder="&nbsp;"  Style="width: 100%;" name="Amaun(RM)" ></asp:TextBox>
                                      <label for="Amaunsah" class="input-group__label">Amaun(RM)</label>
                                </div>
                        </div>
                    
                 </div>
            </div>

        </div>

    </div>
     <Message:popupM runat="server" ID="Notify" /> 
  </div>
    <!-- End Modal -->

  <%-- </!--div>   --%>  
  
 

<script type="text/javascript">
    var tbl = null;
    var tbl1 = null;
    var tbl2 = null;
    var tbl3 = null;
    var nomohonStaf = "";
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
                "url": "Transaksi_EOTs.asmx/LoadSenEOTSokongKJ",
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
            "rowCallback": function (row, data) {
                close_loader();
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
                { "data": "Jam_Sah" },
                { "data": "AmaunSah" },
                { "data": "Tkh_Sah" }
             
            ]
        });

        tbl1 = $("#tblDataSenarai_trans_Lulus").DataTable({
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
                "url": "Transaksi_EOTs.asmx/LoadSenEOTlulusKJ",
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

            "columns": [
                {
                    "data": "No_Mohon",
                    render: function (data, type, row, meta) {

                        if (type !== "display") {

                            return data;

                        }
                        var link = `<td style="width: 10%" >
                                                <label id="lblNoArahan1" name="lblNoArahan1" class="lblNoArahan1" value="${data}" >${data}</label>
                                                <input type ="hidden" class = "lblNoArahan1" value="${data}"/>
                                            </td>`;
                        return link;
                    }
                },
                { "data": "No_Staf" },
                { "data": "Nama" },
                { "data": "Tkh_Mohon" },
                { "data": "Jam_Lulus" },
                { "data": "AmaunLulus" },
                { "data": "Tkh_Sah" },
                { "data": "Tkh_Lulus" }
            ]
        });

        tbl2 = $("#tblData2").DataTable({
            "responsive": true,
            "searching": true,
            paging:false,
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
                "url": "Transaksi_EOTs.asmx/LoadListingOT",
                method: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: function () {
                    return JSON.stringify({ id: nomohonStaf });

                },
                "dataSrc": function (json) {
                    return JSON.parse(json.d);
                }

            },

            "columns": [
                {
                    "data": "statLulus",
                    render: function (data, type, row) {
                        // If 'data' is the column data for this cell
                        // if (data && type === 'display') {
                        // Define the select element with options
                        return '<select class = "form-control nospn ddlStatus" style="text-align: left ; width: 130px;"><option value="LULUS">Lulus</option><option value="TLULUS">Tidak Lulus</option><option value="Blulus">Belum Lulus</option></select>';
                        //  }
                        // For sorting and filtering, return the data
                        //   return data;
                    }

                },

                {
                    "data": "No_Turutan",
                    render: function (data, type, row, meta) {
                        return '<input type="number" class="form-control nospn Noturutan" placeholder="0"  name="Noturutan" style="text-align: right ; width: 50px;" value="' + data + '" readonly/>'
                    }
                },
                {
                    "data": "Tkh_Tuntut",
                    "render": function (data, type, row, meta) {
                        if (type === 'display' && data) {
                            var formattedDate = new Date(data);
                            console.log(formattedDate)
                            var yyyy = formattedDate.getFullYear();
                            var mm = String(formattedDate.getMonth() + 1).padStart(2, '0');
                            var dd = String(formattedDate.getDate()).padStart(2, '0');
                            var formattedDateString = yyyy + '-' + mm + '-' + dd;
                          
                            return '<input type="date" class="form-control nospn Tkhtuntut" placeholder="0" name="Tkhtuntut" style="text-align: left ; width: 130px;" value="' + formattedDateString + '" readonly />';
                        } else {
                            return data; // For other data types, return the data as is
                        }
                    }
                },
                {
                    "data": "Jam_Mula_Lulus",
                    render: function (data, type, row, meta) {
                        return ' <input type="number" class="form-control nospn underline-input multi quantity Jammulalulus" placeholder="0"  name="Jammulalulus" style="text-align: right ; width: 70px;" value="' + data + '"/>'
                    }
                },
                {
                    "data": "Jam_Tamat_Lulus",
                    render: function (data, type, row, meta) {
                        return ' <input type="number" class="form-control nospn underline-input multi quantity Jamtamatlulus" placeholder="0"  name="Jamtamatlulus" style="text-align: right ; width: 70px;" value="' + data + '"/>'
                    }
                },
                {
                    "data": "Jum_Jam_Lulus",
                    render: function (data, type, row, meta) {
                        return ' <input type="number" class="form-control nospn underline-input multi quantity Jumjamlulus" placeholder="0"   name="Jumjamlulus" style="text-align: right; width: 80px;" value="' + data + '" readonly />'
                    }
                },

                {
                    "data": "Kadar_Lulus",
                    "render": function (data, type, row) {
                     
                        if (type === 'display' || type === 'filter') {
                            return parseFloat(data).toFixed(3);
                        }
                        return data;
                    }
                },
                {
                    "data": "Amaun_Lulus",
                    "render": function (data, type, row) {
                        
                        if (type === 'display' || type === 'filter') {
                        
                            return ' <input type="number" class="form-control nospn underline-input multi quantity Amaunlulus" placeholder="0"  id="Amaunlulus" name="Amaunlulus" style="text-align: right; width: 80px;" value="' + data + '"/>'
                        }
                        return data;
                    }
                },
                { "data": "OT_Ptj" },
                {
                    "data": null,
                    render: function (data, type, row) {
                      

                        // Define an empty input field
                        return ' <textarea class="form-control  details UlasanLulus" data-id="' + data.ID + '" type="text" rows="3" maxlength="250" name="UlasanLulus" style="text-align: left; width: 160px;" value="' + data.Ulasan_Lulus + '" />'

                    }
                },
               
                {
                    "data": "ID", 
              
                    render: function (data, type, row) {
                     

                        if (typeof data !== 'undefined') {
                            return '<input class="form-control txtID" type="number" id="txtID" style="text-align: left; width: 80px;" name="txtID" value="' + data + '" />';
                        }
                        else {
                            return '';
                        }
                  
                       
                    }
                }
              
            ],
           
            "columnDefs": [
                { targets: 0, width: '10%' },
                { targets: 1, width: '1%' },
                { targets: 2, width: '9%' },
                { targets: 3, width: '9%' },
                { targets: 4, width: '9%' },
                { targets: 5, width: '10%' },
                { targets: 6, width: '9%' },
                { targets: 7, width: '9%' },
                { targets: 8, width: '9%' },
                { targets: 9, width: '25%' },
                { targets: 10,visible:false },
                
               
            ],

            "drawCallback": function (settings) {
                var api = this.api();
                var counter = 0;
                var listofdata = api.rows().data();
                var totaldata = listofdata.length;
                var jumlahAmaun = 0.00;
               
                while (counter < totaldata) {
                    
                    jumlahAmaun += parseFloat(listofdata[counter].Amaun_Lulus)
                    console.log(jumlahAmaun)
                    counter += 1;
                }

               
                var fixedAmaun = parseFloat(jumlahAmaun).toFixed(2);
                
                $('#MainContent_FormContents_totalAmaunNomohon').val(fixedAmaun);
                 

                   // Output the data for the visible rows to the browser's console
               }
        });


        tbl3 = $("#tblDataJadual").DataTable({
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
                "sLengthMenu": " Tunjuk _MENU_ rekod",
                "sZeroRecords": " Tiada rekod yang sepadan ditemui",
                "sInfo": "&nbsp Menunjukkan _END_ dari _TOTAL_ rekod",
                "sInfoEmpty": "&nbsp Menunjukkan 0 ke 0 dari rekod",
                "sInfoFiltered": " (ditapis dari _MAX_ jumlah rekod)",
                "sEmptyTable": " Tiada rekod."
              
            },
            "ajax": {
                "url": "Transaksi_EOTs.asmx/LoadJadual",
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
                { "data": "Butiran" },
                { "data": "Kadar" }              

            ]
        });

    });

   




    $('#tblData2').on('keyup', '.Jammulalulus, .Jamtamatlulus', function () {
        var $tr = $(this).closest("tr");
        var $objJamMula = $tr.find(".Jammulalulus");
        var $objJamTamat = $tr.find(".Jamtamatlulus");
        var $objJumlahJam = $tr.find(".Jumjamlulus");
        var $ddlStatus = $tr.find(".ddlStatus");
        var $objtkhtuntut = $tr.find(".Tkhtuntut");
        var $objAmaunlulus = $tr.find(".Amaunlulus");
      
      
        var mula = $objJamMula.val();
        var tamat = $objJamTamat.val();
        var tkhtuntut = $objtkhtuntut.val();

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
                $objJumlahJam.val(JamTuntut);
             

            }
        }


        var newArahan = {
            MohonEOT: {


                Tkh_Tuntut:tkhtuntut,
                Jam_Mula: mula,
                Jam_Tamat: tamat,

            }

        }

        $.ajax({

            url: 'Transaksi_EOTs.asmx/KiraAmtEOT',
            method: 'POST',
            data: JSON.stringify(newArahan),

            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                var response = JSON.parse(data.d)
                console.log(response);
                var payload = response.Payload;


                $objAmaunlulus.val(payload);

                // Calculate total of Amaunlulus for each row
                var total = 0;

                $('#tblData2 tbody tr').each(function (index, element) {
                    var $tr = $(element);
                    var $objAmaunlulus = $tr.find(".Amaunlulus");

                    $objAmaunlulus.each(function () {
                        var value = parseFloat($(this).val()) || 0;
                        total += value;
                    });
                });

                // Update the totalAmaunNomohon field with the calculated total
                $("#MainContent_FormContents_totalAmaunNomohon").val(formatPrice(total));

            },
            error: function (xhr, textStatus, errorThrown) {
                console.error('Error:', errorThrown);
                reject(false);
            }

     


        });

       

    });


    $('.btnSimpan').click(async function () {
        
        selectedDataAll = [];
        var acceptedRecord = 0;
        var nomohon = $('#<%=txtNoMohon.ClientID%>').val();
        var bakiperuntukan = $('#<%=txtPeruntukanOT.ClientID%>').val();
       
        if (bakiperuntukan < 0) {
             Notification ("Baki peruntukan tidak mencukupi")
             return

        }


        $('#tblData2').find("tbody tr").each(function () {
          //  if (index > 0) {
                var $tr = $(this).closest("tr");
                var $objJamMula = $tr.find(".Jammulalulus");
                var $objJamTamat = $tr.find(".Jamtamatlulus");
                var $objJumlahJam = $tr.find(".Jumjamlulus");
                var $objAmaunlulus = $tr.find(".Amaunlulus");
            var $obturutan = $tr.find(".Noturutan");
           
            var $obddlStatus = $tr.find(".ddlStatus");
            var $obUlasanLulus = $tr.find(".UlasanLulus");
            var $obID = $obUlasanLulus.data("id");

           

                var selectedData = {
                    Jammulalulus: $objJamMula.val(),
                    Jamtamatlulus: $objJamTamat.val(),
                    Jumjamlulus: $objJumlahJam.val(),
                    Amaunlulus: $objAmaunlulus.val(),
                    Turutan: $obturutan.val(),
                    ID: $obID,
                    StatusMohon: $obddlStatus.val(),
                    UlasanLulus: $obUlasanLulus.val()
                };
            console.log(selectedData)

                if (selectedData.Jammulalulus === "" || selectedData.Jamtamatlulus === "" || selectedData.Turutan =="" ||
                    selectedData.Jumjamlulus === "" || selectedData.Amaunlulus === "") {
                    return;
            }

            
                acceptedRecord += 1;
            
               selectedDataAll.push(selectedData);
             
              
       //     }

        });

        console.log(selectedDataAll)

      

        let confirm = false
        confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
       
        if (!confirm) {
            return
        }


        var result = JSON.parse(await ajaxSaveOrder(selectedDataAll, nomohon));
        //alert(result.Message);
        if (result.Status !== "Failed") {
            tbl.ajax.reload();
            $('#infostaf').modal('hide');
           

        }
         
    } );



    async function ajaxSaveOrder(order,nomohon) {

        return new Promise((resolve, reject) => {
            $.ajax({

                url: 'Transaksi_EOTs.asmx/SimpanSokongEOT',
                method: 'POST',
                data: JSON.stringify({ order: order, nomohon: nomohon}),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    resolve(data.d);
                    var response = JSON.parse(data.d);
                    Notification(response.Message);
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                    reject(false);
                }
            });
        })
        //console.log("tst")
    }






    $('#btnJadual').click(async function () {

       $('#infojadual1').modal('toggle');
        $('#infostaf').modal('toggle');
       
    });

    $('.tutupKadar').click(async function () {
        $('#infostaf').modal('toggle');

    });


    
    var tableID_Senarai = "#tblDataSenarai_trans";
    var tableID_SenaraiLulus = "#tblDataSenarai_trans_Lulus";
    var searchQuery = "";
    var curNumObject = 0;
    var oldSearchQuery = "";
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

    async function rowClickHandler(orderDetail) {
       
        $('#<%=txtNoMohon.ClientID%>').val(orderDetail.No_Mohon);
        $('#<%=txttkhMohon.ClientID%>').val(orderDetail.Tkh_Mohon);
        $('#<%=txtPjbt.ClientID%>').val(orderDetail.Pejabat);

        getJamDanAmaun(orderDetail.No_Mohon)
        getDataPeribadiPemohon(orderDetail.No_Staf)
       
        getOTBelumLulus(orderDetail.OT_Ptj)
        getBakiPeruntukan(orderDetail.OT_Ptj, orderDetail.No_Staf)

        var strFileName = orderDetail.File_name;
        var fileUrl = "~/UPLOAD/EOT/" + strFileName;

        var fileLink = $('<a></a>');
        fileLink.attr('href', fileUrl);
        fileLink.text(strFileName);
        $('#uploadedFileNameLabel').empty(); // Clear any existing content
        $('#uploadedFileNameLabel').append(fileLink);
        
        //getlistOT(orderDetail.No_Mohon)
       $('#infojadual1').modal('hide');
       $('#infostaf').modal('toggle');
        
        
        nomohonStaf = orderDetail.No_Mohon;
        tbl2.ajax.reload();
        

         //untuk detail pemermohoan pengesahan
        
    }


    $('#tblData2').on('click', '.Noturutan', function () {
      
        var $tr = $(this).closest("tr");
   
      var objtkhtuntutt = $tr.find(".Tkhtuntut");
      
        var noturutan = $tr.find(".Noturutan");
        
        var nomohon = $('#<%=txtNoMohon.ClientID%>').val();       
        GetPermohonanPemohonPengesahan(nomohon, noturutan.val());

    });


    function GetPermohonanPemohonPengesahan(nomohon, noturutan) {
       
        fetch('Transaksi_EOTs.asmx/GetPermohonanPemohonPengesahan', {
            method: 'POST',
            headers: {

                'Content-Type': "application/json"
            },
            body: JSON.stringify({ nomohon: nomohon, noturutan: noturutan  })
            
        })
            .then(response => response.json())
            .then(data => setPermohonanPemohonPengesahan(data.d))
    }


    function setPermohonanPemohonPengesahan(data) {
      
        data = JSON.parse(data);
       
        if (data.nomohon === "") {
            Notification("Tiada data");
            return false;
        }
      
        $('#<%=txtPegawai.ClientID%>').val(data[0].NamaPegawai);
        $('#<%=txttkhTuntut.ClientID%>').val(data[0].Tkh_Tuntut);
        $('#<%=txtJamMulaTuntut.ClientID%>').val(data[0].Jam_Mula);
        $('#<%=txtJamTamatTuntut.ClientID%>').val(data[0].Jam_Tamat);
        $('#<%=txtJamTuntut.ClientID%>').val(data[0].DetJam);
        $('#<%=txtKadarTuntut.ClientID%>').val(data[0].Kadar_Tuntut.toFixed(3));
        $('#<%=txtAmnTuntut.ClientID%>').val(data[0].AmaunTuntut.toFixed(2));
     
        $('#<%=txtJamMulaSah.ClientID%>').val(data[0].Jam_Mula_Sah);
        $('#<%=txtJamTamatSah.ClientID%>').val(data[0].Jam_Tamat_Sah);
        $('#<%=txtJamSah.ClientID%>').val(data[0].DetJamSah);
        $('#<%=txtAmnSah.ClientID%>').val(data[0].AmaunSah.toFixed(2));
        $('#<%=txtKadarSah.ClientID%>').val(data[0].Kadar_Lulus.toFixed(3));
       
    }

    async function getlistOT(id) {
     
        if (id !== "") {
           
            //    //BACA DETAIL JURNAL
            var recordDataOT = await AjaxGetDataOT(id);  //Baca data pada table Keperluan             
                //await clearAllRows();
               await SetDataOTKepadaRows(null, recordDataOT); //setData pada table
        }

        return false;
    }

    async function AjaxGetDataOT(id) {

        try {

            const response = await fetch('Transaksi_EOTs.asmx/LoadListingOT', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ id: id })
            });
            const data = await response.json();
            return JSON.parse(data.d);
        } catch (error) {
            console.error('Error:', error);
            return false;
        }
    }

    async function SetDataOTKepadaRows(totalClone, objOrder) {
        
        clearAllRows()
        var counter = 1;
        var table = $('#tblData2');
        var total = 0.00;

        if (objOrder !== null && objOrder !== undefined) {   //semak berapa object yang ada
            totalClone = objOrder.Payload.length;
        }
        var obj = objOrder.Payload;
        while (counter <= totalClone) {

            curNumObject += 1;

           /* txttkhtuntut, txtjammula, txtjamtamat, txtjumjamsah, txtkadar, txtamaun, txtOTptj, txtulasansah*/


            var newId_txttkhtuntut = "txttkhtuntut" + curNumObject; //create new object pada tble
            var newId_txtjammula = "txtjammula" + curNumObject;
            var newId_txtjamtamat = "txtjamtamat" + curNumObject;
            var newId_txtjumjamsah = "txtjumjamsah" + curNumObject;
            var newId_txtkadar = "txtkadar" + curNumObject;
            var newId_txtamaun = "txtamaun" + curNumObject;
            var newId_txtkadar = "txtOTptj" + curNumObject;
            var newId_hidItem = "hidItem" + curNumObject;
     

            var row = $('#tblData2 tbody>tr:first').clone(); // create dummy object pada tble
            var txttkhtuntutTextbox = $(row).find(".list-txttkhtuntut").attr("id", newId_txttkhtuntut);
            var txtjammulaTextbox = $(row).find(".list-txtjammula").attr("id", newId_txtjammula);
            var txtjamtamatTextbox = $(row).find(".list-txtjamtamat").attr("id", newId_txtjamtamat);
            var txtjumjamsahTextbox = $(row).find(".list-txtjumjamsah").attr("id", newId_txtjumjamsah);
            var txtkadarTextbox = $(row).find(".list-txtkadar").attr("id", newId_txtkadar);
            var txtamaunTextbox = $(row).find(".list-txtamaun").attr("id", newId_txtamaun);
            var txtOTptjTextbox = $(row).find(".list-txtOTptj").attr("id", newId_txtkadar);
            


            var hidItemNO = $(row).find(".hidItemNO").attr("id", newId_hidItem);

            txttkhtuntutTextbox.val(obj[counter - 1].Tkh_Tuntut);   //bind value setiap object dlm tbl
            txtjammulaTextbox.val(obj[counter - 1].Jam_Mula_Lulus);
            txtjamtamatTextbox.val(obj[counter - 1].Jam_Tamat_Lulus);
            txtjumjamsahTextbox.val(obj[counter - 1].Jum_Jam_Lulus);
            txtkadarTextbox.val(obj[counter - 1].Kadar_Lulus);
            txtamaunTextbox.val(obj[counter - 1].Amaun_Lulus);
            txtOTptjTextbox.val(obj[counter - 1].OT_Ptj);

            hidItemNO.val(obj[counter - 1].ID);
            //console.log(hidItemNO.val(obj[counter - 1].No_Item))
            //total += parseFloat(obj[counter - 1].Jumlah_anggaran);
            console.log(txtOTptjTextbox.val(obj[counter - 1].OT_Ptj))
           


            row.attr("style", "");  //style pada row

            $('#tblData2 tbody').append(row);  //bind data start pada row yang first pada tblData2

            counter += 1;
        }

        /*$('#totalKt').val(total) */ //total harga
    }

    async function clearAllRows() {
        $('#tblData2' + " > tbody > tr ").each(function (index, obj) {
            if (index > 0) {
                obj.remove();
            }
        })
       /* $(totalKt).val("0.00");*/

    }

  
   

    function getOTBelumLulus(ptj) {
       

        fetch('Transaksi_EOTs.asmx/GetOTBelumLulus', {
            method: 'POST',
            headers: {

                'Content-Type': "application/json"
            },
            //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify({ ptj: ptj })
        })
            .then(response => response.json())
            .then(data => setOTBelumLulus(data.d))
    }


    function setOTBelumLulus(data) {

        data = JSON.parse(data);

        if (data.Nostaf === "") {
            Notification("Tiada data");
            return false;
        }
       

        $('#hidOT').val(data[0].JumOtBL.toFixed(2));
        $('#<%=txtOT.ClientID%>').val(data[0].JumOtBL.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true }));
        
    }

    function getDataPeribadiPemohon(pemohon) {
     
        fetch('Transaksi_EOTs.asmx/GetUserInfo', {
            method: 'POST',
            headers: {

                'Content-Type': "application/json"
            },
                 //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
                 body: JSON.stringify({ nostaf: pemohon })
             })
             .then(response => response.json())
             .then(data => setDataPeribadi(data.d))
    }

   



    function setDataPeribadi(data) {
    
        data = JSON.parse(data);
      
        if (data.Nostaf === "") {
            Notification("Tiada data");
            return false;
        }      
        $('#<%=txtNama.ClientID%>').val(data[0].Param1);
        $('#<%=txtNoStaf.ClientID%>').val(data[0].StafNo);
        $('#<%=txtJwtn.ClientID%>').val(data[0].Param3);
        $('#<%=txtGaji.ClientID%>').val(data[0].MS02_JumlahGajiS.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true }));

   
        
    }

    function getJamDanAmaun(nomohonS) {

        fetch('Transaksi_EOTs.asmx/GetJumJamLulusdanAmaunTuntut', {
            method: 'POST',
            headers: {

                'Content-Type': "application/json"
            },
            //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify({ nomohon: nomohonS })
        })
             .then(response => response.json())
             .then(data => setDataJumLulusAmaun(data.d))
     }

    function setDataJumLulusAmaun(data) {
        
        data = JSON.parse(data);

        if (data.nomohon === "") {
            alert("Tiada data");
            return false;
        }
       
        $('#<%=txtJumJamLulus.ClientID%>').val(data[0].DetJamLulus);
        $('#<%=txtAmaunLulus.ClientID%>').val(data[0].AmaunLulus.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true }));
        $('#<%=txtJumJamTuntut.ClientID%>').val(data[0].DetJam);
        $('#<%=txtAmaunTuntut.ClientID%>').val(data[0].AmaunTuntut.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true }));


    }


    function getBakiPeruntukan(ptj, nostaf) {

     
        fetch('Transaksi_EOTs.asmx/BakiPeruntukanKasar', {
            method: 'POST',
            headers: {

                'Content-Type': "application/json"
            },
           
            body: JSON.stringify({ ptj: ptj, nostaf:nostaf})
        })
            .then(response => response.json())
            .then(data => setBakiPeruntukan(data.d))
    }


    function setBakiPeruntukan(data) {

        data = JSON.parse(data);
      
        if (data === "") {
            alert("Tiada data");
            return false;
        }

        var OTBlulus = $('#hidOT').val();
        $('#<%=txtPeruntukan.ClientID%>').val(data);

      //  var OTBlulus = $('#<%=txtOT.ClientID%>').val();       
        var BakiKasar = $('#<%=txtPeruntukan.ClientID%>').val();      
        var BakiBersih = parseFloat(OTBlulus) - parseFloat(BakiKasar);
       // var BakiBersih = parseFloat(BakiKasar) - parseFloat(OTBlulus);
   
        var formattedBakiBersih = BakiBersih.toLocaleString('en-MY', { style: 'currency', currency: 'MYR', minimumFractionDigits: 2, useGrouping: true });
        $('#<%=txtPeruntukanOT.ClientID%>').val(formattedBakiBersih);
        
        
    }


    async function AjaxSokongEot(id1) {

        try {

            const response = await fetch('Transaksi_EOTs.asmx/LoadSokongEOT', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ id: id1 })
            });
            const data = await response.json();
            //return JSON.parse(data.d);
            var result = JSON.parse(data.d);
            alert(result.Message)
            tbl.ajax.reload();
            tbl1.ajax.reload();

        } catch (error) {
            console.error('Error:', error);
            return false;
        }

    }


    function ShowPopup() {

            $('#infojadual').modal('toggle');

        
    }



</script>
    
</asp:Content>




