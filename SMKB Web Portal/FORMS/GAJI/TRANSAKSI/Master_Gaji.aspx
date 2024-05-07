<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Master_Gaji.aspx.vb" Inherits="SMKB_Web_Portal.Master_Gaji" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

<style>

</style>
<div id="PermohonanTab" class="tabcontent" style="display: block">
        <div class="table-title">
        <br />
     </div>
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
                                <th scope="col" style="width:50px">No. Staf</th>
                                <th scope="col" style="width:200px">Nama</th>
                                <th scope="col" style="width:200px">Pejabat</th>
                                <th scope="col" style="width:50px; align-content:center">Tindakan</th>
                            </tr>
                        </thead>
                        <tbody id="tableID_ListStaf">
                                        
                        </tbody>

                    </table>
                </div>
            </div>                  
        </div>
    <div class="table-title">
        <br />
     </div>
    <div class="table-title">
        <label id="lblTajuk" ><u></u></label>
        <hr>
    </div>
    <div class="table-title">
        
        <div class="col-sm-6 col-md-6">
            <div class="card border-white">
                <div class="card-header" style="text-align: left">
                    <label id="lbl1" style="color:blue;font-size:17px"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <label id="lbl2" style="color:blue;font-size:17px"></label>
                     <label id="hidNostaf" style="visibility:hidden"></label>
                    <label id="hidSave" style="visibility:hidden"></label>
                </div>

            </div>
        </div>
        <div class="col-sm-6 col-md-3">
            </div>
         
        <div class="btn btn-primary" style="text-align:right" onclick="ShowPopup(this,'2');">
            <i class="fa fa-plus"></i>Tambah Transaksi              
        </div>
            
        &nbsp;&nbsp; 
        <%-- <asp:LinkButton ID="lbtnKira" runat="server" class="btn btn-primary" OnClientClick="return confirm('Adakah anda pasti untuk kira semula slip gaji rekod ini?');" >
                                    <i class="fa fa-plus"></i>Kiraan Semula Slip Gaji      
                                </asp:LinkButton>&nbsp;&nbsp;
        <div class="btn btn-primary"  onclick="OpenPopUp('View_Slip.aspx','mywin','1050','555','yes','center');return false">
            <i class="fa fa-plus"></i>Papar Slip Gaji              
        </div>--%>
    </div>
       
        <div class="form-row">
             
            <div class="col-md-12">
                
                <div class="transaction-table table-responsive">
                    
                    <table id="tblListMaster" class="table table-striped" style="width:100%">
                        <thead>
                            <tr>
                                <th scope="col" style="width:30px">Sumber</th>
                                <th scope="col" style="width:70px">Jenis Transaksi</th>
                                <th scope="col" style="width:50px">Kod Transaksi</th>
                                <th scope="col" style="width:70px">Tarikh Mula</th>
                                <th scope="col" style="width:70px">Tarikh Tamat</th>
                                <th scope="col" style="width:70px">Amaun (RM)</th>
                                <th scope="col" style="width:100px">No. Rujukan</th>
                                <th scope="col" style="width:120px">Catatan</th>
                                <th scope="col" style="width:50px">Status</th>
                                <th scope="col" style="width:100px">Tindakan</th>
                            </tr>
                        </thead>
                        <tbody id="tableID_ListMaster">
                                        
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
                    <h5 class="modal-title" id="fMCTitle">Maklumat Staf</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <h6 style="color:blue"><b>Maklumat Butiran Staf</b></h6>
                        <hr>
        
                        <div class="form-row">
                            <div class="form-group col-md-3">

                                <asp:TextBox runat="server" ID="txtNoStaf" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>       
                                 <label class="input-group__label" for="No. Staf">No. Staf</label>

                            </div>

                            <div class="form-group col-md-3">
                                <asp:TextBox runat="server" ID="txtNoKp" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="No. KP">No. KP</label>
                            </div>
                            <div class="form-group col-md-3">
                         
                                <asp:TextBox runat="server" ID="txtGjPokok" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Gaji Pokok">Gaji Pokok</label>
                            </div>
                            <div class="form-group col-md-3">
                   
                                <asp:TextBox runat="server" ID="txtStatus" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Status">Status</label>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-3">

                                <asp:TextBox runat="server" ID="txtNama" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                 <label class="input-group__label" for="Nama">Nama</label>           
                            </div>

                            <div class="form-group col-md-3">
 
                                <asp:TextBox runat="server" ID="txtJwtn" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Jawatan">Jawatan</label>     
                            </div>
                            <div class="form-group col-md-3">
                
                                <asp:TextBox runat="server" ID="txtPjbt" Enabled="false" CssClass="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Pejabat">Pejabat</label> 
                                
                            </div>
                           <div class="form-group col-md-3">
                       
                                <asp:TextBox runat="server" ID="txtTaraf" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                               <label class="input-group__label" for="Taraf">Taraf</label> 
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-3">
                        
                                <asp:TextBox runat="server" ID="txtGred" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Gred Gaji">Gred Gaji</label>
                                             
                            </div>

                            <div class="form-group col-md-3">
                           
                                <asp:TextBox runat="server" ID="txtTkhLantik" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Tarikh Lantik">Tarikh Lantik</label>
                            </div>

                            <div class="form-group col-md-3">
                                
                                <asp:TextBox runat="server" ID="txtSkim" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Skim">Skim</label>
                            </div>
                           <div class="form-group col-md-3">
                                
                                <asp:TextBox runat="server" ID="txtPilihan" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                               <label class="input-group__label" for="Pilihan">Pilihan</label>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-3">
                              
                                <asp:TextBox runat="server" ID="txtNoPencen" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="No. Pencen">No. Pencen</label>
                                             
                            </div>

                            <div class="form-group col-md-3">
                           
                                <asp:TextBox runat="server" ID="txtNoKwsp" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="No. KWSP">No. KWSP</label>
                            </div>

                            <div class="form-group col-md-3">
                       
                                <asp:TextBox runat="server" ID="txtNoPerkeso" CssClass="input-group__input" Enabled="True" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="No. Perkeso">No. Perkeso</label>
                            </div>
                           <div class="form-group col-md-3">
                     
                                <asp:TextBox runat="server" ID="txtNoCukai" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                               <label class="input-group__label" for="No. Cukai">No. Cukai</label>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-3">
       
                                <asp:TextBox runat="server" ID="txtBank" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                 <label class="input-group__label" for="Bank">Bank</label>
                                             
                            </div>

                            <div class="form-group col-md-3">
                                
                                <asp:TextBox runat="server" ID="txtNoAcc" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                 <label class="input-group__label" for="No. Akaun">No. Akaun</label>
                            </div>
                            <div class="form-group col-md-3">
                 
                                <asp:TextBox runat="server" ID="txtUmur" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                 <label class="input-group__label" for="Umur">Umur</label>
                            </div>
                        </div>
                    <h6 style="color:blue"><b>Maklumat Butiran Gaji</b></h6>
                        <hr>
        
                        <div class="form-row">
                            <div class="form-group col-md-4">
   
                                <asp:TextBox runat="server" ID="txtKwspPek" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>   
                                <label class="input-group__label" for="KWSP Pekerja (%)">KWSP Pekerja (%)</label>
                            </div>

                            <div class="form-group col-md-4">
         
                                <asp:TextBox runat="server" ID="txtKwspMaj" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="KWSP Majikan (%)">KWSP Majikan (%)</label>
                            </div>
                            <div class="form-group col-md-4">
                         
                                <asp:TextBox runat="server" ID="txtPencen" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Pencen (%)">Pencen (%)</label>
                            </div>
                        </div>
                        <div class="form-row">
                           <div class="form-group col-md-4">

                                <asp:TextBox runat="server" ID="txtKatCukai" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                               <label class="input-group__label" for="Kategori Cukai">Kategori Cukai</label>
                            </div>
                            <div class="form-group col-md-4">
                     
                                    <asp:DropDownList ID="ddlKatSocso" runat="server" CssClass="input-group__select ui search dropdown" Width="70px">

                                    </asp:DropDownList>
                                   <label class="input-group__label" for="Kategori Perkeso">Kategori Perkeso</label>
                            </div>

                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="chkTahanGaji">
                                <label class="custom-control-label" for="chkTahanGaji">Tahan Gaji</label>

                            </div>

      
                        </div>
                    <h6 style="color:blue"><b>Kawalan Proses</b></h6>
                    <hr>
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="chkGaji">
                        <label class="custom-control-label" for="chkGaji">Gaji</label>

                    </div>
                    <div class="custom-control custom-checkbox">
                         <input type="checkbox" class="custom-control-input" id="chkKwsp">
                         <label class="custom-control-label" for="chkKwsp">KWSP</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                         <input type="checkbox" class="custom-control-input" id="chkPencen">
                         <label class="custom-control-label" for="chkPencen">Pencen</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                         <input type="checkbox" class="custom-control-input" id="chkCukai">
                         <label class="custom-control-label" for="chkCukai">Cukai</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                         <input type="checkbox" class="custom-control-input" id="chkPerkeso">
                         <label class="custom-control-label" for="chkPerkeso">Perkeso</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                         <input type="checkbox" class="custom-control-input" id="chkBonus">
                         <label class="custom-control-label" for="chkBonus">Bonus</label>
                    </div>
                    <%--<asp:CheckBox ID="chkGaji" Text="Gaji" runat="server" class="custom-control-input"   /><br />--%>
<%--                    <asp:CheckBox ID="chkKwsp" Text="KWSP" runat="server"  /><br />--%>
<%--                    <asp:CheckBox ID="chkPencen" Text="Pencen" runat="server" /><br />
                    <asp:CheckBox ID="chkCukai" Text="Cukai" runat="server" /><br />
                    <asp:CheckBox ID="chkPerkeso" Text="Perkeso" runat="server" /><br />
                    <asp:CheckBox ID="chkBonus" Text="Bonus" runat="server" />--%>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="$('#tambahgaji').modal('hide'); return false;">Tutup</button>
                    <asp:LinkButton  runat="server" autopostback ="true"  CssClass="btn btn-secondary lbtnSimpanStaf"> 
                                    &nbsp;&nbsp;&nbsp;Simpan </asp:LinkButton>
                                
                </div>
            </div>
        </div>
    </div>
    <!-- End Modal -->

        <!-- Modal -->
        <div class="modal fade" id="tambahgaji" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eMCTitle">Tambah Transaksi</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                            <h6>Maklumat Transaksi</h6>
                            <hr>
                                    <label style="color:blue">No. Staf : </label>&nbsp;<label id="lblnostaf" style="color:blue"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    <label style="color:blue">Nama : </label>&nbsp;<label id="lblnama" style="color:blue"></label>
                                    <hr>
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                
                                            <input id="txtSumber" runat="server" type="text" class="input-group__input" disabled>
                                            <label class="input-group__label" for="Sumber">Sumber</label>
                                        </div>
                                        <div class="form-group col-md-4">
                                     
                                            <asp:DropDownList ID="ddlJenis"  CssClass="input-group__select ui search dropdown" data-validator="reqJenis|" runat="server">
                                                        
                                            </asp:DropDownList>    
                                            <label class="input-group__label" for="Jenis">Jenis</label>
                                             <asp:RequiredFieldValidator ID="rqdJenis" runat="server" ControlToValidate="ddlJenis" CssClass="text-danger" ErrorMessage="*Sila Masukkan Jenis" ValidationGroup="Semak" Display="Dynamic"/>
                                        </div>

                                        <div class="form-group col-md-4">
                                  
                                           <asp:DropDownList ID="ddlKodTrans" CssClass="input-group__select ui search dropdown" runat="server">
                                                        
                                            </asp:DropDownList>
                                            <label class="input-group__label" for="Kod">Kod</label>
                                            <asp:RequiredFieldValidator ID="rqdKod" runat="server" ControlToValidate="ddlKodTrans" CssClass="text-danger" ErrorMessage="*Sila Masukkan Kod" ValidationGroup="Semak" Display="Dynamic"/>
                                        </div>
                                    </div>

                                    <div class="form-row">
                                            <div class="form-group col-md-4">
              
                                                <input id="txtTkhMula" runat="server" type="date" class="input-group__input" enable="true">
                                                <label class="input-group__label" for="Tarikh Mula">Tarikh Mula</label>
                                                <asp:RequiredFieldValidator ID="rqdTkhMula" runat="server" ControlToValidate="txtTkhMula" CssClass="text-danger" ErrorMessage="*Sila Masukkan Tarikh Mula" ValidationGroup="Semak" Display="Dynamic"/>
                                            </div>

                                            <div class="form-group col-md-4">
                                        
                                                <input id="tkhTamat" runat="server" type="date" class="input-group__input" enable="true">
                                                <label class="input-group__label" for="Tarikh Tamat">Tarikh Tamat</label>
                                                <asp:RequiredFieldValidator ID="rqdTkhTmt" runat="server" ControlToValidate="tkhTamat" CssClass="text-danger" ErrorMessage="*Sila Masukkan Tarikh Tamat" ValidationGroup="Semak" Display="Dynamic"/>

                                            </div>
                                        <div class="form-group col-md-4">
                                            
                                            <%--<input id="txtamaun" runat="server" type="number" class="input-group__input" enable="true">--%>
                                            <input id="txtamaun" runat="server" type="number" data-decimal="2" oninput="enforceNumberValidation(this)" class="input-group__input" value="" />
                                            <label class="input-group__label" for="Amaun">Amaun</label>
                                            <asp:RequiredFieldValidator ID="rqdAmaun" runat="server" ControlToValidate="txtamaun" CssClass="text-danger" ErrorMessage="*Sila Masukkan Amaun" ValidationGroup="Semak" Display="Dynamic"/>

                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                           
                                            <input id="txtnoruj" runat="server" type="text" class="input-group__input" onkeyup="upper(this)" enable="true">
                                            <label class="input-group__label" for="No. Rujukan">No. Rujukan</label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            
                                            <input id="txtcatatan" runat="server" type="text" class="input-group__input" onkeyup="upper(this)" enable="true">
                                            <label class="input-group__label" for="Catatan">Catatan</label>
                                        </div>

                                        <div class="form-group col-md-4">
                                       
                                                <asp:DropDownList ID="ddlStatus" CssClass="input-group__select ui search dropdown" runat="server">
                                                        <asp:ListItem  Value="">Sila Pilih</asp:ListItem>  
                                                        <asp:ListItem Value="AKTIF">AKTIF</asp:ListItem>  
                                                        <asp:ListItem Value="BATAL">BATAL</asp:ListItem>  
                                                </asp:DropDownList>
                                            <label class="input-group__label" for="Status">Status</label>
                                            <asp:RequiredFieldValidator ID="rqdStatus" runat="server" ControlToValidate="ddlStatus" CssClass="text-danger" ErrorMessage="*Sila Masukkan Status" ValidationGroup="Semak" Display="Dynamic"/>

                                        </div>
                                    </div>
                                            
                                            

                            <hr>  
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="$('#tambahgaji').modal('hide'); return false;">Tutup</button>
                            <asp:LinkButton  runat="server" autopostback ="true"  CssClass="btn btn-secondary lbtnSimpan" data-validation-group="Semak"> 
                                    &nbsp;&nbsp;&nbsp;Simpan </asp:LinkButton>

                    </div>
                </div>
            </div>
        </div>
    
    <!-- End Modal -->

</div>
<script type="text/javascript">
    var tbl = null

    $(document).ready(function () {

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
                { "data": "MS01_NoStaf" },
                { "data": "MS01_Nama" },
                { "data": "PejabatS" },
                {
                    //className: "btnView",
                    "data": "MS01_NoStaf",
                    render: function (data, type, row, meta) {

                        if (type !== "display") {

                            return data;

                        }

                        var link = `<button id="btnView" runat="server" class="btn btnView" title="Senarai Transaksi Yang Aktif" type="button" style="color: blue" data-dismiss="modal">
                                                    <i class="far fa-edit"></i>
                                        </button><button id="btnAll" runat="server" class="btn btnAll" title="Senarai Transaksi Keseluruhan" type="button" style="color: blue" data-dismiss="modal">
                                                    <i class="far fa-list-alt"></i>
                                        </button><button id="btnStaf" runat="server" class="btn btnStaf" title="Papar Maklumat Staf" type="button" style="color: blue" data-dismiss="modal">
                                                   <i class="far fa-id-card"></i>
                                        </button>`;
                        return link;
                    }
                }
            ]

        });

    });
   
    function ShowPopup(obj, elm) {
        if (elm == "1") {

            $('#infostaf').modal('toggle');

            getInfoStaf($(obj).text());
            getInfoProses($(obj).text());

        }
        else if (elm == "2") {
            //$(".modal-body input").val("");
            if ($('#lbl1').text() === "") {
                alert("Sila pilih rekod dari senarai staf diatas")
            }
            else {
                $('#tambahgaji').modal('toggle');
                $('#hidSave').text("1");
                $('#eMCTitle').text("Tambah Transaksi");
                $('#lblnostaf').text($('#lbl1').text());
                $('#lblnama').text($('#lbl2').text());
                $('#<%=txtSumber.ClientID%>').val('GAJI');

                $("#<%=ddlJenis.ClientID%>").prop("disabled", false);
                $('#<%=ddlKodTrans.ClientID%>').val('');
                $('#<%=ddlJenis.ClientID%>').val('');
                $('#<%=txtamaun.ClientID%>').val('');
                $('#<%=txtTkhMula.ClientID%>').val('');
                $('#<%=tkhTamat.ClientID%>').val('');
                $('#<%=txtnoruj.ClientID%>').val('');
                $('#<%=txtcatatan.ClientID%>').val('');
                $('#<%=ddlStatus.ClientID%>').val('AKTIF');


                var ddlFruits = document.getElementById("<%=ddlStatus.ClientID %>");
                var selectedText = ddlFruits.options[ddlFruits.selectedIndex[1]].innerHTML;
                var selectedValue = ddlFruits.value;
               // alert("Selected Text: " + selectedText + " Value: " + selectedValue);

             }   

             
        } 
        clear();
    }
    function getInfoDet(obj) {
        alert($(obj).text());


    }
    function getInfoStaf(nostaf) {
        //Cara Pertama
        //alert(nostaf);
        fetch('Transaksi_WS.asmx/LoadRekodStaf', {
            method: 'POST',
            headers: {
                'Content-Type': "application/json"
            },
            //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify({ nostaf: nostaf })
        })
            .then(response => response.json())
            .then(data => setInfoStaf(data.d))

    }
    function getInfoProses(nostaf) {
        //Cara Pertama
        //alert(nostaf);
        fetch('Transaksi_WS.asmx/LoadProsesStaf', {
            method: 'POST',
            headers: {
                'Content-Type': "application/json"
            },
            //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify({ nostaf: nostaf })
        })
            .then(response => response.json())
            .then(data => setInfoProsesStaf(data.d))

    }
    function upper(ustr) {
        var str = ustr.value;
        ustr.value = str.toUpperCase();
    }
    function listStatus() {
        $('[id*=ddlStatus]').html('<option value="">Sila Pilih</option>');
        $('[id*=ddlStatus]').html('<option value="A">AKTIF</option>');
        $('[id*=ddlStatus]').html('<option value="B">BATAL</option>');
    }
    function setInfoProsesStaf(data) {
        data = JSON.parse(data);
        if (data.No_Staf === "") {
            alert("Tiada data");
            return false;
        }

        $('#<%=txtKatCukai.ClientID%>').val(data[0].Kategori_Cukai);
        $('#<%=txtNoPerkeso.ClientID%>').val(data[0].No_Perkeso);
        $('#<%=ddlKatSocso.ClientID%>').val(data[0].Kategori_Perkeso);
        
        if (data[0].Proses_Gaji == true) {
            $('#chkGaji').attr('checked', true);
           
        }
        if (data[0].Proses_Kwsp == true) {
            $('#chkKwsp').attr('checked', true);

        }
<%--        if (data[0].Proses_Kwsp == true) {

            $('#<%='chkKwsp.ClientID%>').attr('checked', true);
        }--%>
        if (data[0].Proses_Cukai == true) {

            $('#chkCukai').attr('checked', true);
      
        }
        if (data[0].Proses_Perkeso == true) {
            $('#chkPerkeso').attr('checked', true);

        }
        if (data[0].Proses_Pencen == true) {
            $('#chkPencen').attr('checked', true);
        }

        if (data[0].Tahan_Gaji == true) {
            $('#chkTahanGaji').attr('checked', true);

        }
<%--        if (data[0].Bayar_Cek == true) {

            $('#<%=chkByrCek.ClientID%>').attr('checked', true);
        }--%>



<%--        $('#<%=chkKwsp.ClientID%>').val(data[0].Proses_Kwsp); 
        $('#<%=chkCukai.ClientID%>').val(data[0].Proses_Cukai); 
        $('#<%=chkPerkeso.ClientID%>').val(data[0].Proses_Perkeso);
        $('#<%=chkPencen.ClientID%>').val(data[0].Proses_Pencen);--%>

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
        $('#<%=txtStatus.ClientID%>').val(data[0].status_staf);
        $('#<%=txtTaraf.ClientID%>').val(data[0].tarafkhidmat);
        $('#<%=txtGjPokok.ClientID%>').val(data[0].jumlahgajis);
        $('#<%=txtNoPencen.ClientID%>').val(data[0].MS01_NoPencen);
        $('#<%=txtNoKwsp.ClientID%>').val(data[0].MS01_NoKWSP);
        $('#<%=txtNoCukai.ClientID%>').val(data[0].MS01_NoCukai);
        $('#<%=txtUmur.ClientID%>').val(data[0].umur);
        $('#<%=txtNoAcc.ClientID%>').val(data[0].MS01_NoAkaun);
        $('#<%=txtTkhLantik.ClientID%>').val(data[0].MS01_TkhKhidmat);
        $('#<%=txtPilihan.ClientID%>').val(data[0].MS01_Pilihan);
        $('#<%=txtBank.ClientID%>').val(data[0].bank);
        

    }
    $('#tblListMaster').on('click', '.btnEdit', function () {

        $('#tambahgaji').modal('toggle');
        $('#hidSave').text("2");
        $('#eMCTitle').text("Kemaskini Transaksi");
        $('#lblnostaf').text($('#lbl1').text());
        $('#lblnama').text($('#lbl2').text());
        
        //GetDropDownData($(this).closest('tr').find('td:eq(1)').text())
   
        $('#<%=txtSumber.ClientID%>').val($(this).closest('tr').find('td:eq(0)').text());
        $('#<%=ddlJenis.ClientID%>').val($(this).closest('tr').find('td:eq(1)').text());  
        $("#<%=ddlJenis.ClientID%>").prop("disabled", true);
        $('#<%=txtamaun.ClientID%>').val($(this).closest('tr').find('td:eq(5)').text().replace(",", ""));   
        $('#<%=txtTkhMula.ClientID%>').val(formatDate($(this).closest('tr').find('td:eq(3)').text()));
        $('#<%=tkhTamat.ClientID%>').val(formatDate($(this).closest('tr').find('td:eq(4)').text()));
        $('#<%=txtnoruj.ClientID%>').val($(this).closest('tr').find('td:eq(6)').text());
        $('#<%=txtcatatan.ClientID%>').val($(this).closest('tr').find('td:eq(7)').text());
        $('#<%=ddlStatus.ClientID%>').val($(this).closest('tr').find('td:eq(8)').text());
        GetDropDownData($('#<%=ddlJenis.ClientID%>').val(), $(this).closest('tr').find('td:eq(2)').text())

    });
    $('#tblListMaster').on('click', '.btnDelete', function () {

        $('#tambahgaji').modal('toggle');
        $('#hidSave').text("3");
        $('#eMCTitle').text("Hapus Transaksi");
        $('#lblnostaf').text($('#lbl1').text());
        $('#lblnama').text($('#lbl2').text());

        //GetDropDownData($(this).closest('tr').find('td:eq(1)').text())

        $('#<%=txtSumber.ClientID%>').val($(this).closest('tr').find('td:eq(0)').text());
        $('#<%=ddlJenis.ClientID%>').val($(this).closest('tr').find('td:eq(1)').text());
        $("#<%=ddlJenis.ClientID%>").prop("disabled", true);
        $('#<%=txtamaun.ClientID%>').val($(this).closest('tr').find('td:eq(5)').text().replace(",", ""));
        $("#<%=txtamaun.ClientID%>").prop("disabled", true);
        $('#<%=txtTkhMula.ClientID%>').val(formatDate($(this).closest('tr').find('td:eq(3)').text()));
        $("#<%=txtTkhMula.ClientID%>").prop("disabled", true);
        $('#<%=tkhTamat.ClientID%>').val(formatDate($(this).closest('tr').find('td:eq(4)').text()));
        $("#<%=tkhTamat.ClientID%>").prop("disabled", true);
        $('#<%=txtnoruj.ClientID%>').val($(this).closest('tr').find('td:eq(6)').text());
        $("#<%=txtnoruj.ClientID%>").prop("disabled", true);
        $('#<%=txtcatatan.ClientID%>').val($(this).closest('tr').find('td:eq(7)').text());
        $("#<%=txtcatatan.ClientID%>").prop("disabled", true);
        $('#<%=ddlStatus.ClientID%>').val($(this).closest('tr').find('td:eq(8)').text());
        $("#<%=ddlStatus.ClientID%>").prop("disabled", true);
        $('#<%=ddlKodTrans.ClientID%>').val($(this).closest('tr').find('td:eq(2)').text());
        $("#<%=ddlKodTrans.ClientID%>").prop("disabled", true);
        GetDropDownData($('#<%=ddlJenis.ClientID%>').val(), $(this).closest('tr').find('td:eq(2)').text())
    });
    function clear() {
        $('#<%=txtSumber.ClientID%>').val('GAJI');
        $("#<%=ddlJenis.ClientID%>").prop("disabled", false);
        $('#<%=ddlKodTrans.ClientID%>').val('');
        $('#<%=ddlJenis.ClientID%>').val('');
        $('#<%=txtamaun.ClientID%>').val('');
        $('#<%=txtTkhMula.ClientID%>').val('');
        $('#<%=tkhTamat.ClientID%>').val('');
        $('#<%=txtnoruj.ClientID%>').val('');
        $('#<%=txtcatatan.ClientID%>').val('');
        $('#<%=ddlStatus.ClientID%>').val('');
       
    <%--    document.getElementById("<%=rqdKod.ClientID%>").style.visibility = "hidden"; 

        document.getElementById("<%=rqdKod.ClientID%>").enabled = false;--%>
        

    }

    function formatDate(tkh) {
        var date1 = tkh.split('/')
        var newDate = date1[2] + '-' + date1[1] + '-' + date1[0];
        return newDate;
       // var date = new Date(newDate);
       // alert(newDate);
    }
    $('#tblListStaf').on('click', '.btnView', function () {
        
        var val = $(this).closest('tr').find('td:eq(0)').text(); // amend the index as needed
        //alert(val);
        //var curTR = $(this).closest("tr");
        //var recordID = curTR.find("td > .noStaf");
        var icheck = "";
        //var bool = true;
       // var id = recordID.val();
        $('#lbl1').text(val);
        $('#hidNostaf').text(val);
        $('#lbl2').text($(this).closest('tr').find('td:eq(1)').text());
        $('#lblTajuk').text('Senarai Transaksi Gaji Berstatus Aktif');


        icheck = 1;
        ListMaster(val, icheck);
        //var data = table.row($(this).parents('tr')).data();

        //alert(data[0] + "'s salary is: " + data[5]);


        
        //$("div.header").html('Charges list');
    });
    $('#tblListStaf').on('click', '.btnAll', function () {

        var val = $(this).closest('tr').find('td:eq(0)').text();
        //var curTR = $(this).closest("tr");
        //var recordID = curTR.find("td > .noStaf");
        var icheck = "";
        //var bool = true;
        //var id = recordID.val();
        $('#lbl1').text(val);
        $('#hidNostaf').text(val);
        $('#lbl2').text($(this).closest('tr').find('td:eq(1)').text());
        $('#lblTajuk').text('Senarai Transaksi Gaji Keseluruhan');
        //alert(id);
        icheck = 2;
        ListMaster(val, icheck);
       
    });
    $('#tblListStaf').on('click', '.btnStaf', function () {

        var val = $(this).closest('tr').find('td:eq(0)').text();
        //var curTR = $(this).closest("tr");
        //var recordID = curTR.find("td > .noStaf");
        ////var bool = true;
        //var id = recordID.val();
        

        $('#infostaf').modal('toggle');

        getInfoStaf(val);
        getInfoProses(val);

    });
    function ListMaster(vNostaf,vcheck) {
        var urls = "";
        
        //alert(vcheck);
        if (vcheck === 1) {
            urls = "Transaksi_WS.asmx/LoadListMaster";
        } else {
            urls = "Transaksi_WS.asmx/LoadListMasterAll";
        }

        //alert(urls);

        tbl = $("#tblListMaster").DataTable({
            "bDestroy": true,
            "responsive": true,
            "searching": true,
            "bLengthChange": false,
            "aaSorting": [],
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
                "url": urls,
                method: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                data: function () {
                    return JSON.stringify({ nostaf: vNostaf })
                },
                "dataSrc": function (json) {
                    //var data = JSON.parse(json.d);
                    //console.log(data.Payload);
                    return JSON.parse(json.d);
                }
            },
            "columns": [
                { "data": "Kod_Sumber", className: "text-center" },
                { "data": "Jenis_Trans", className: "text-center" },
                { "data": "Kod_Trans", className: "text-center" },
                { "data": "Tkh_Mula", className: "text-center" },
                { "data": "Tkh_Tamat", className: "text-center" },
                { "data": "Amaun", className: "text-right", render: $.fn.dataTable.render.number(',', '.', 2, '') },
                { "data": "no_trans" },
                { "data": "catatan" },
                { "data": "status", className: "text-center" },
                {
                    //className: "btnEdit",
                    "data": "no_staf",
                    render: function (data, type, row, meta) {

                        var btnkuar;
                        var btnedit;
                        btnedit = `<button id="btnEdit" runat="server" class="btn btnEdit" title="Kemaskini" type="button" style="color: blue" data-dismiss="modal">
                                                    <i class="far fa-edit"></i> </button>`;


                        if (row.Kod_Sumber === 'ROC') {
                            //btnkuar = btnedit;
                            btnkuar = '';
                        }
                        else {
                            if (row.Jenis_Trans === 'K' || row.Jenis_Trans === 'S' || row.Jenis_Trans === 'N' || row.Jenis_Trans === 'T') {
                                btnkuar = '';
                            }
                            else {
                               
                                btnkuar = btnedit + `<button id="btnDelete" runat="server" class="btn btnDelete" title="Hapus" type="button" style="color: blue" data-dismiss="modal">
                                                    <i class="fas fa-trash-alt" style="color:red"></i>
                                        </button>`;
                            }
                            
                        };

                        return btnkuar;
                    }



                }
            ]

        });
    }
    $(document).ready(function () {

        $.ajax({

            "url": "Transaksi_WS.asmx/GetPerkeso",
            method: 'POST',
            "contentType": "application/json; charset=utf-8",
            "dataType": "json",
            success: function (data) {

                var json = JSON.parse(data.d);

                var option = json.map(x => "<option value='" + x.kod + "'>" + x.butiran + "</option>");

                $('[id*=ddlKatSocso]').html('<option value="">Sila Pilih</option>');
                $('[id*=ddlKatSocso]').append(option.join(' '));

            }

        });

    });
    $(document).ready(function () {

        $.ajax({

            "url": "Transaksi_WS.asmx/GetJenisTrans",
            method: 'POST',
            "contentType": "application/json; charset=utf-8",
            "dataType": "json",
            success: function (data) {

                var json = JSON.parse(data.d);

                var option = json.map(x => "<option value='" + x.Jenis_Trans + "'>" + x.Butiran + "</option>");

                $('[id*=ddlJenis]').html('<option value="">Sila Pilih</option>');
                $('[id*=ddlJenis]').append(option.join(' '));

            }

        });

        $("#<%=ddlJenis.ClientID%>").on("change", function () {
            var country = $("#<%=ddlJenis.ClientID%>").val();
            //alert(country)

            GetDropDownData(country)
            
            
        });  

    });

    function GetDropDownData(jenis, val) {
        $.ajax({
            type: "POST",
            url: "Transaksi_WS.asmx/GetKodTrans",
            data: { 'jenis': jenis },
            data: "{'jenis': '" + jenis + "'}",
            /*data: '{jenis: "P" }',*/
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data)
        {
                var json = JSON.parse(data.d);

                var option = json.map(x => "<option value='" + x.Kod_Trans + "'>" + x.Butiran + "</option>");

                $('[id*=ddlKodTrans]').html('<option value="">Sila Pilih</option>');
                $('[id*=ddlKodTrans]').append(option.join(' '));
                if (val !== null) {     
                    $('#<%=ddlKodTrans.ClientID%>').val(val);
                }
        },
        failure: function () {
            alert("Failed!");
        }
    });
    }


    $('.lbtnSimpan').click(async function (evt) {
        evt.preventDefault();
        
        var msg = "";
        var isave = $('#hidSave').text();

        var result = await performCheck("Semak");

        if (result === false) {
            return false;
        }

        var newMaster = {
            DataMaster: {
                   // Kod_PTJ: $('#<%'=hPTJ.ClientID%>').val(),
                    No_Staf: $('#lbl1').text(),
                    Kod_Sumber: $('#<%=txtSumber.ClientID%>').val(),
                    Jenis_Trans: $('#<%=ddlJenis.ClientID%>').val(),
                    Kod_Trans: $('#<%=ddlKodTrans.ClientID%>').val(),
                    Tkh_Mula_Trans: $('#<%=txtTkhMula.ClientID%>').val(),
                    Tkh_Tamat_Trans: $('#<%=tkhTamat.ClientID%>').val(),
                AmaunTrans: $('#<%=txtamaun.ClientID%>').val(),
                No_Trans: $('#<%=txtnoruj.ClientID%>').val(),
                Catatan: $('#<%=txtcatatan.ClientID%>').val(),
                Sta_Trans: $('#<%=ddlStatus.ClientID%>').val(),


            }
        }



        if (isave === "1")
        {
            //console.log(newMaster);
            msg = "Anda pasti ingin menyimpan rekod ini?"

            if (!confirm(msg) && result === true) {
                return false;
            }
            var response = await ajaxSaveMaster(newMaster);
        }
        else if (isave === "2")
        {
            //console.log(newMaster);
            msg = "Anda pasti ingin mengemaskini rekod ini?"

            if (!confirm(msg) && result === true) {
                return false;
            }
            var response = await ajaxUpdateMaster(newMaster);
        }
        else if (isave === "3") {
            //console.log(newMaster);
            msg = "Anda pasti ingin menghapus rekod ini?"

            if (!confirm(msg) && result === true) {
                return false;
            }
            var response = await ajaxDeleteMaster(newMaster);
        }
        
    });
    async function ajaxUpdateMaster(arahanK) {
        $.ajax({

            url: 'Transaksi_WS.asmx/UpdateMaster',
            method: 'POST',
            data: JSON.stringify(arahanK),

            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                var response = JSON.parse(data.d)
                console.log(response);
                alert(response.Message);
                var payload = response.Payload;
                $("#<%=txtNoStaf.ClientID%>").val(payload.No_Staf);
                $('#lbl1').text(payload.No_Staf);
         
                ListMaster(payload.No_Staf, 2);

            },
            error: function (xhr, textStatus, errorThrown) {
                console.error('Error:', errorThrown);
                reject(false);
            }
        });
    }
    async function ajaxDeleteMaster(arahanK) {
        $.ajax({

            url: 'Transaksi_WS.asmx/HapusMaster',
            method: 'POST',
            data: JSON.stringify(arahanK),

            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                var response = JSON.parse(data.d)
                console.log(response);
                alert(response.Message);
                var payload = response.Payload;
                $("#<%=txtNoStaf.ClientID%>").val(payload.No_Staf);
                $('#lbl1').text(payload.No_Staf);
                ListMaster(payload.No_Staf,1);

            },
            error: function (xhr, textStatus, errorThrown) {
                console.error('Error:', errorThrown);
                reject(false);
            }
        });
        }
    async function ajaxSaveMaster(arahanK) {
        $.ajax({

            url: 'Transaksi_WS.asmx/SimpanMaster',
            method: 'POST',
            data: JSON.stringify(arahanK),

            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                var response = JSON.parse(data.d)
                console.log(response);
                alert(response.Message);
                var payload = response.Payload;
                $("#<%=txtNoStaf.ClientID%>").val(payload.No_Staf);
                ListMaster(payload.No_Staf, 1);

            },
            error: function (xhr, textStatus, errorThrown) {
                console.error('Error:', errorThrown);
                reject(false);
            }

        });

         //})

    }

    $('.lbtnSimpanStaf').click(async function (evt) {
        evt.preventDefault();
        var msg = "";
        var katsocso = "";
        var igaji = 0;
        var itahan = 0;
        var ikwsp = 0;
        var isocso = 0;
        var ipencen = 0;
        var icukai = 0;
        var ibonus = 0;

        //var isave = $('#hidSave').text();
        //var result = await performCheck("Semak");

        //if (result === false) {
        //    return false;
        //}
        
        if ($('#<%=ddlKatSocso.ClientID%>').val() == null) {
            katsocso = "";
        }
        
        if ($('#chkGaji').is(':checked') == true) {
            igaji = 1;
        }
        if ($('#chkPencen').is(':checked') == true) {
            ipencen = 1;
        }
        if ($('#chkKwsp').is(':checked') == true) {
            ikwsp = 1;
        }
 <%--       if ($('<%='chkKwsp.ClientID %>').is(':checked') == true) {
            ikwsp = 1;
        }--%>
        if ($('#chkCukai').is(':checked') == true) {
            icukai = 1;
        }
        if ($('#chkPerkeso').is(':checked') == true) {
            isocso = 1;
        }
        if ($('#chkBonus').is(':checked') == true) {
            ibonus = 1;
        }
        if ($('#chkTahanGaji').is(':checked') == true)
        {
            itahan = 1;
        }
       // alert(igaji);
        //alert(itahan);

        var newStaf = {
            DataStaf: {
                   // Kod_PTJ: $('#<%'=hPTJ.ClientID%>').val(),
        
            No_Staf: $('#<%=txtNoStaf.ClientID%>').val(),
                Kat_Perkeso: katsocso,
                No_Perkeso: $('#<%=txtNoPerkeso.ClientID%>').val(),
                Proses_Gaji: igaji,
                Proses_Pencen: ipencen,
                Proses_Kwsp: ikwsp,
                Proses_Cukai: icukai,
                Proses_Perkeso: isocso,
                Proses_Bonus: ibonus,
                Tahan_Gaji: itahan,
                <%--Bayar_Cek: $('#<%='chkByrCek.ClientID%>').val(),--%>

                }
            }
        //console.log(newMaster);
                msg = "Anda pasti ingin menyimpan rekod ini?"

                if (!confirm(msg) && result === true) {
                    return false;
                }
        var response = await ajaxSaveStaf(newStaf);

    });
    async function ajaxSaveStaf(vStaf) {
        $.ajax({

            url: 'Transaksi_WS.asmx/SimpanStaf',
            method: 'POST',
            data: JSON.stringify(vStaf),

            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                var response = JSON.parse(data.d)
                console.log(response);
                alert(response.Message);
                var payload = response.Payload;
                $("#<%=txtNoStaf.ClientID%>").val(payload.No_Staf);

            },
            error: function (xhr, textStatus, errorThrown) {
                console.error('Error:', errorThrown);
                reject(false);
            }

        });

        //})

    }
    function clearValidation(){

        $("[id*=rqdJenis]").css("display", "none");
        $("[id*=rqdKod]").css("display", "none");
    }
    async function performCheck(e) {
        //alert(e);
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
    function enforceNumberValidation(ele) {
        if ($(ele).data('decimal') != null) {
            // found valid rule for decimal
            var decimal = parseInt($(ele).data('decimal')) || 0;
            var val = $(ele).val();
            if (decimal > 0) {
                var splitVal = val.split('.');
                if (splitVal.length == 2 && splitVal[1].length > decimal) {
                    // user entered invalid input
                    $(ele).val(splitVal[0] + '.' + splitVal[1].substr(0, decimal));
                }
            } else if (decimal == 0) {
                // do not allow decimal place
                var splitVal = val.split('.');
                if (splitVal.length > 1) {
                    // user entered invalid input
                    $(ele).val(splitVal[0]); // always trim everything after '.'
                }
            }
        }
    }

</script>
</asp:Content>
