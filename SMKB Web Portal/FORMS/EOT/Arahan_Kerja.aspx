<%@ Page Title=""  Language="vb" AutoEventWireup="false" ValidateRequest="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Arahan_Kerja.aspx.vb" Inherits="SMKB_Web_Portal.Arahan_Kerja" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>  

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>
    <style>
     /*    #KodPTJ {
    font-weight: bold;
     
  }*/
     .upload-button {
        background-color:coral;
        color: black;
        border: none;
        padding: 10px 10px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 14px;
        border-radius: 5px;
        cursor: pointer;
     }

        .choose-button {
        background-color:beige;
        color: black;
        border: none;
        padding: 10px 10px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 14px;
        border-radius: 5px;
        cursor: pointer;
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
        color :black;
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
        color :black;
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
         background-color:lightgrey;

        }

    </style>
    <script>
        function validateDates(source, args) {
            alert("hree")
            var txtTkhMula = document.getElementById('<%= txtTkhMula.ClientID %>').value;
        var txtTkhTamat = document.getElementById('<%= txtTkhTamat.ClientID %>').value;

            if (txtTkhMula !== '' && txtTkhTamat !== '') {
                var dateMula = new Date(txtTkhMula);
                var dateTamat = new Date(txtTkhTamat);

                if (dateMula > dateTamat) {
                    args.IsValid = false;
                } else {
                    args.IsValid = true;
                }
            }
        }
    </script>
    <div id="PermohonanTab" class="tabcontent" style="display: block">

    <div class="modal fade" id="PilihStaf" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Pilih Staf Untuk Arahan Kerja</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataSenarai_trans" class="table table-striped" style="width: 99%">
                                    <thead>
                                        <tr>
                                            <th scope="col">No. Staf</th>
                                            <th scope="col">Nama</th>
                                            <th scope="col">PTJ</th> 
                                            <th scope="col">Tindakan</th> 
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_Senarai_trans">
                                    </tbody>                                                                         
                                   </table>
                                     <div class="modal-footer">
                                           <%-- <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>--%>
                                            <button type="button" runat="server" id="lbtnSimStafAK" class="btn btn-secondary btnSimpanST" data-dismiss="modal"> Simpan</button>
                                     </div>
                            </div>
                        </div>                  
                    </div>
                </div>
            </div>
        </div>
      <div class="modal fade" id="SenaraiStaf" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="centerTitle">Senarai Staf Untuk Arahan Kerja</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>                    
                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataSenAK_trans" CssClass="table table-striped" style="width: 99%">
                                    <thead>
                                        <tr>
                                            <th scope="col">No. Staf</th>
                                            <th scope="col">Nama</th>
                                            <th scope="col">PTJ</th>  
                                            <th scope="col">Tindakan</th> 
                                        </tr>
                                    </thead>
                                    <tbody id="tableID_SenAK_trans">
                                      <%--  <tr style="display: none; width: 100%" class="table-list">
                                            
                                            <td style="width: 10%">
                                                <label id="lblNoStaf2" name="lblNoStaf2" class="lblNoStaf2"></label>
                                                <input type ="hidden" class = "lblNoStaf2" value=""/>
                                            </td>
                                            <td style="width: 10%">
                                                <label id="lblNama2" name="lblNama2" class="lblNama2"></label>
                                            </td>
                                            <td style="width: 10%">
                                                <label id="lblPtj2" name="lblPtj2" class="lblPtj2"></label>
                                            </td>
                                           
                                            <td style="width: 5%">
                                                <button id="Button1" runat="server" class="btn btnView" type="button" style="color: blue" data-dismiss="modal">
                                                    <i class="fa fa-edit"></i>
                                                </button>
                                            </td>
                                        </tr>--%>
                                    </tbody>

                                </table>

                           </div>
                        </div>                  
                    </div>
                </div>
            </div>
        </div>

<div class="container-fluid"> 
    <ul class="nav nav-tabs" id="myTab" role="tablist">
     <li class="nav-item active" role="presentation"><a class="nav-link active" data-toggle="tab" id="tab-pemohon" href="#home">Maklumat Arahan Kerja</a></li>
     <li class="nav-item" role="presentation"><a class="nav-link"  data-toggle="tab" id="tab-permohonan" href="#menu1">Senarai Staf</a></li>
    </ul>
  
 <div class="tab-content">
    <div id="home" class="tab-pane fade in active show">
      
    <asp:Panel ID="Panel1" runat="server" >  
    <div class="modal-body">

            <%--<div class="table-title">
                <h6>Maklumat Arahan Kerja</h6>              
             </div>--%>
             <div class="row">
                   <div class="col-md-12" align="left">
                    <h6 style="color:#FF0000;font-style:italic; align-content:center;font-weight:bold">Sila Simpan maklumat Arahan kerja sebelum menekan butang Pilih Staf </h6>             
                   </div>
                            
            </div>
            <div class="row">
                  <div class="col-md-12" align="right">
                       <div  align="right" class="btn btn-primary btnPaparStaf" onclick="ShowPopup('1')">
                                    <i class="fa fa-plus"></i>Pilih Staf 
                       </div>  
                  </div>  
            </div>
     
         <div class="form-row">

            <h6>Transaksi</h6>            

            <div class="col-md-12">
                <div class="">
                    <table  id="tblData"  class="table table-striped"><%-- class="table table-bordered"--%>
                        <thead>
                            <tr>
                                <th scope="col" style="width: 30%;">Vot</th>
                                <th scope="col"  style="width: 20%;">PTj</th>
                                <th scope="col"  style="width: 20%;">Kumpulan Wang</th>
                                <th scope="col"  style="width: 15%;">Operasi</th>
                                <th scope="col"  style="width: 15%;">Projek</th>
                            </tr>
                        </thead>
                        <tbody id="tableID">
                            <tr  class="table-list">
                                <td>
                                    <select class="ui search dropdown  COA-list" name="ddlCOA" id="ddlCOA" style="width:300px"></select>
                                    <input type="hidden" class="data-id" value="" />
                                    <label id="hidVot" name="hidVot" class="Hid-vot-list" style="visibility:hidden"></label>
                                </td>
                                <td>
                                    <label id="lblPTj" name="lblPTj" class="label-ptj-list" style="justify-items:center" ></label>
                                    <label id="HidlblPTj" name="HidlblPTj" class="Hid-ptj-list" style="visibility: hidden"></label>
                                </td>

                                <td>
                                    <label id="lblKw" name="lblKw" class="label-kw-list" style="justify-items:center"></label>
                                    <label id="HidlblKw" name="HidlblKw" class="Hid-kw-list" style="visibility: hidden"></label>
                                </td>
                                <td>
                                    <label id="lblKo" name="lblKo" class="label-ko-list" style="justify-items:center"></label>
                                    <label id="HidlblKo" name="HidlblKo" class="Hid-ko-list" style="visibility: hidden"></label>
                                </td>
                                <td>
                                    <label id="lblKp" name="lblKp" class="label-kp-list" style="justify-items:center"></label>
                                    <label id="HidlblKp" name="HidlblKp" class="Hid-kp-list" style="visibility: hidden"></label>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                </div>
            </div>

        </div>
               
            <div class="row">
                <div class="col-md-12">                    
                                <div class="form-row">
                                     <%-- <div class="form-group col-md-6" style="left: 0px; top: 0px">
                                        <label for="PTJ" class="col-form-label">PTj</label>
                                        <input type="text" class="form-control" id="lblPTJ1" readonly="readonly" style="width:450px" > 
                                     
                                          <input type="hidden" class="form-control"  id="hPTJ1" style="width:300px" readonly="readonly" />  
       

                                        
                                      </div>--%>
                                      <div class="form-group col-md-4">

                                        <input class="input-group__input" name="No Surat" id="txtNoSurat"  style="width:100%" maxlength="30" runat="server" placeholder="&nbsp;"/>
                                        <label class="input-group__label" for=">NoSurat">No Surat</label>
                                        
                                         <%-- <input type="text" class="input-group__input" runat="server" id="txtNoSurat" style="width:350px" maxlength="30" placeholder="&nbsp;" name="No Surat"/> 
                                          <label for="NoSurat" class="input-group__label">No Surat</label>--%>
                                          <asp:RequiredFieldValidator ID="RqrNoSurat" runat="server" ControlToValidate="txtNoSurat" CssClass="text-danger" ErrorMessage="*Sila Masukkan No Surat" ValidationGroup="Semak" Display="Dynamic"/>
                                      </div>
                                                                     
                                    <div class="form-group col-md-4">
                                        
                                        <input type="date" class="input-group__input" id="txtTkhMula" runat="server" style="width:100%" placeholder="&nbsp;" name="Tarikh Mula Kerja"/> 
                                        <label for="TarikhMula" class="input-group__label">Tarikh Mula Kerja</label>
                                        <asp:LinkButton ID="lbtntxtTkhMula" runat="server" ToolTip="Klik untuk papar kalendar">
                                        
                                        </asp:LinkButton>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTkhMula" CssClass="text-danger" ErrorMessage="*Sila pilih Tarikh Mula" ValidationGroup="Semak" Display="Dynamic"/>
                                    
                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="txtTkhMula" ControlToCompare="txtTkhTamat" Operator="LessThanEqual" Type="Date" CssClass="text-danger" ErrorMessage="** Tarikh Mula Tidak Boleh Besar Dari Tarikh Tamat" ValidationGroup="Semak" Display="Dynamic"></asp:CompareValidator>

                                    
                                    </div>                                    
                                      <div class="form-group col-md-4">                                         
                                          <input type="date" class="input-group__input" id="txtTkhTamat" runat="server" style="width:100%" placeholder="&nbsp;" name="Tarikh Tamat Kerja" />   
                                          <label for="TarikhTamat" class="input-group__label">Tarikh Tamat Kerja</label>
                                            <asp:LinkButton ID="lbtntxtTkhTamat" runat="server" ToolTip="Klik untuk papar kalendar">
                                                   
                                           </asp:LinkButton>
                                           <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtTkhTamat" CssClass="text-danger" ErrorMessage="*Sila pilih Tarikh Tamat" ValidationGroup="Semak" Display="Dynamic" />
                                           <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="txtTkhTamat" ControlToCompare="txtTkhMula" Operator="GreaterThanEqual" CssClass="text-danger" Type="Date" ErrorMessage=" ** Tarikh Tamat Tidak boleh Kurang Dari Tarikh Mula" ValidationGroup="Semak" Display="Dynamic"></asp:CompareValidator>
                                          </div>                                
                               </div>

                                <div class="form-row">
                                    <div class="form-group col-md-4">                                       
                                         <asp:TextBox ID="txtLokasi" runat="server"  CssClass="input-group__input" style="width:100%" Rows="2" TextMode="MultiLine" MaxLength="50" placeholder="&nbsp;" name="Lokasi"></asp:TextBox>    
                                         <label for="Lokasi"  class="input-group__label">Lokasi</label> 
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLokasi" CssClass="text-danger" ErrorMessage="*Sila masukkan Lokasi
                                            " ValidationGroup="Semak" Display="Dynamic"/>
                                    </div>
                                
                                    <div class="form-group col-md-4">                                       
                                         <asp:TextBox ID="txtButirKerja" runat="server" style="width:100%" CssClass="input-group__input" Rows="2" TextMode="MultiLine" placeholder="&nbsp;" name="Penerangan Kerja"></asp:TextBox>
                                         <label for="Penerangan"  class="input-group__label">Penerangan Kerja</label>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtButirKerja" CssClass="text-danger" ErrorMessage="*Sila masukkan Keterangan Kerja" ValidationGroup="Semak" Display="Dynamic"/>
                                    </div>
                                    <div class="form-group col-md-4">
                                            
                                        <%--   <asp:DropDownList ID="ddlPengesah" runat="server" CssClass="input-group__select ui search dropdown Pengesah" 
                                                name="Pegawai Pengesah" placeholder="" style="width:100px"></asp:DropDownList>
                                            <label for="Pengesah" class="input-group__label">Pegawai Pengesah</label>

                                            <asp:RequiredFieldValidator ID="rfvPengesah" runat="server" ControlToValidate="ddlPengesah"
                                                ErrorMessage="*Sila pilih Pegawai Pengesah" Display="Dynamic" CssClass="error-message"></asp:RequiredFieldValidator>--%>


                                            <select class="input-group__select ui search dropdown Pengesah" name="Pegawai Pengesah" placeholder="" id="ddlPengesah" style="width:100%"></select>   
                                            <label for="Pengesah"  class="input-group__label">Pegawai Pengesah</label> 
                                      
                                            <input type="checkbox" id ="chkAllPengesah" value ="1" style="display:none" /> 
                                         
                                        <%--<label for="CatatPengesah">Senarai semua penyelia</label>--%>
                                    </div>
                                </div>

                                 <div class="form-row">
                                    
                                       <div class="form-group col-md-4">
                                                                            
                                            <select class="input-group__select ui search dropdown KetuaJabatan" name="Ketua Jabatan" placeholder="" id="ddlKetuaJabatan" style="width:100%"></select>
                                             <label for="KetuaJabatan"  class="input-group__label">Ketua Jabatan</label> 
                                        <input type="checkbox" id ="chkAllKetuaJabatan" value ="1" style="display:none"/> 
                                      
                                           <%--<label for="CatatPengesah">Senarai semua Ketua Jabatan</label>--%>
                                    </div>

                                
                                  <%--  <div class="form-group col-md-4">
                                        <label for="kodModul">Ketua Jabatan</label>                                    
                                            <input type="text" class="form-control"  id="lblKetuaPej" style="width:300px" readonly="readonly" />   
                                        <input type="hidden" class="form-control"  id="hidKetuaPej" style="width:300px" readonly="readonly" /> 
                                        <input type="hidden" class="form-control"  id="hidNo_Staf_Peg_ak" style="width:20px" readonly="readonly" />  
                                  
                                    </div>--%>
                                
                                    <div class="form-group col-md-3">
                                         
                                         <div class="form-inline">
                                         
                                           <input type="file" id="fileInput" class="input-group__input choose-button"/>
                                           <label for="UploadSurat"  class="input-group__label">Upload surat</label>
                                            <input type="button" id="uploadButton" class="btn btn-secondary" value="Muatnaik" onclick="uploadFile()" />

                                                <span id="uploadedFileNameLabel" style="display: inline;"></span>
                                                <span id="">&nbsp</span>
                                                <span id="progressContainer"></span>
                                             <input type="hidden" class="form-control"  id="hidJenDok" style="width:300px" readonly="readonly" /> 
                                              <input type="hidden" class="form-control"  id="hidFileName" style="width:300px" readonly="readonly" /> 
                                                                                   
                                         </div>    
                                         
                                   </div>

                                    <div class="form-group col-md-1">
                                        <asp:Label ID="lblMessageDokumen" runat="server" />
                                    </div>
                               
                                    <div class="form-group col-md-4">                                       
                                        <asp:TextBox ID="txtNoArahan" runat="server" Width="100%" CssClass="input-group__input input-readonly" ReadOnly="true" placeholder="&nbsp;" name=">No Arahan" ></asp:TextBox>
                                        <label for="NoArahan"  class="input-group__label">No Arahan</label>                                         
                                    </div>                                  
                                </div>                                                                                               
                    </div>
                </div>
                
             <div class="form-row">
                <div class="form-group col-md-11" align="right">
                    <button type="button" class="btn btn-danger">Padam</button>
                    <button type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-validation-group="Semak">Simpan</button>                
                </div>
                 <div class="form-group col-md-1" style="left: 0px; top: 0px">
                           
                 </div>
            </div>
             <!-- end div modal-body -->
            </div>
           </asp:Panel>
         </div>
         <div id="menu1" class="tab-pane fade in " role="tabpanel">     
             <asp:Panel ID="Panel2" runat="server" >
                <div class="modal-body">
                    <div class="row">
                         <div class="col-md-12">
                            
                                <div class="transaction-table table-responsive">
                                    <table id="tblDataSenarai_Staf" CssClass="table table-striped" style="width: 99%">
                                        <thead>                                       
                                            <tr>
                                                <th scope="col">No. Arahan</th>
                                                <th scope="col">No. Staf</th>
                                                <th scope="col">Nama</th>                                          
                                                <th scope="col">Tindakan</th> 
                                            </tr>
                                        </thead>
                                        <tbody id="tableID_Senarai_Staf">                                     
                                        </tbody>

                                    </table>

                                </div>
                            </div>          
                    </div>
                </div>
            </asp:Panel>
         </div>
        </div>
        <!-- end div container-fluid -->
      </div>
    <!-- end div permohonan -->
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

   
        <!--modal message-->
        <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger btnTidak"
                            data-dismiss="modal">
                            Tidak</button>
                        <button type="button" class="btn btn-secondary btnYA" data-toggle="modal"
                            data-target="#ModulForm" data-dismiss="modal">
                            Ya</button>
                    </div>
                </div>
            </div>
        </div>

    <script type="text/javascript">

        function ShowPopup(elm) {

            if (elm == "1") {

                var NoArahan = $('#<%= txtNoArahan.ClientID %>').val();

                if (NoArahan === "" || NoArahan === undefined) {
                  
                    notification("Sila simpan maklumat Arahan Kerja terlebih dahulu sebelum memilih staf.")
                    $("#PilihStaf").modal("hide");
                }
                else {
                    $('#PilihStaf').modal('toggle');
                }
            }
            else if (elm == "2") {

                $(".modal-body div").val("");
                $('#SenaraiStaf').modal('toggle');

            }
        }

        

        var tbl = null;
        var tbl1 = null;
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
                    "url": "Transaksi_EOTs.asmx/LoadRecordStaf",
                    method: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify(d)
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },
                drawCallback: function (settings) {
                    // Your function to be called after loading data
                    close_loader();
                },
                "columns": [
                    {
                        "data": "MS01_NOSTAF",
                        render: function (data, type, row, meta) {

                            if (type !== "display") {

                                return data;

                            }
                            var link = `<td style="width: 10%" >
                                                <label id="lblNo" name="lblNo" class="lblNo" value="${data}" >${data}</label>
                                                <input type ="hidden" class = "lblNo" value="${data}"/>
                                            </td>`;
                            return link;
                        }
                    },                    
                    { "data": "MS01_NAMA" },
                    { "data": "Singkatan" },
                    {
                        className: "text-center",
                        "data": "MS01_NOSTAF",
                        render: function (data, type, row, meta) {

                            if (type !== "display") {

                                return data;

                            }

                            return '<input type="checkbox"  class="_check" name="check" value="' + data.id + '">';
                            this.width= "5%";
                        }
                        
                    }
                ]
            });

           
            $('#lblPTJ').val('<%= Session("ssusrPTj")%>');
            $('#KodPTJ').val('<%= Session("ssusrKodPTj")%>');
            $('#hPTJ').html('<%= Session("ssusrKodPTj")%>');
            $('#lblPTJ').text('<%= Session("ssusrPTj")%>');
            $('#KodPTJ').text('<%= Session("ssusrKodPTj")%>');
            $('#hidNo_Staf_Peg_ak').html('<%=Session("ssusrID")%>');
            initDropdownCOA("ddlCOA");
           
           

            $.ajax({
                url: "Transaksi_EOTs.asmx/getKJ",
                data: "{ 'ptj': '" + <%=Session("ssusrKodPTj")%> +  "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    //alert(data.d)
                    json = JSON.parse(data.d);
                    for (var i in json) {
                        //alert(json[i].NamaStaf);
                        var nostafss = json[i].MS01_NoStaf;
                        var namass = json[i].NamaStaf;
                        var ptjss = json[i].KodPejabat;
                        
                 
                    }

                    $('#lblKetuaPej').val(namass);
                    $('#hidKetuaPej').val(nostafss);

                  //  $('#hPTJ').val(ptjss);
               
                   


                }
            });



            $.ajax({
                type: "POST",
                url: "Transaksi_EOTs.asmx/GenerateEOTID",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    $('#<%= txtNoArahan.ClientID %>').val(response.d);
                 },
                 error: function (xhr, textStatus, error) {
                     console.log(xhr.statusText);
                 }
            });


            tbl1 = $("#tblDataSenarai_Staf").DataTable({
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
                    "url": "Transaksi_EOTs.asmx/LoadRecordStafArahan",
                    method: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function () {
                        return JSON.stringify({ idarahan: $('#<%=txtNoArahan.ClientID%>').val() });
                     },
                     "dataSrc": function (json) {
                         return JSON.parse(json.d);
                     }

                 },

                 "columns": [
                     {
                         "data": "No_Arahan",
                         render: function (data, type, row, meta) {

                             if (type !== "display") {

                                 return data;

                             }
                             var link = `<td style="width: 10%" >
                                                <label id="lblNoArahan3" name="lblNoArahan3" class="lblNoArahan3" value="${data}" >${data}</label>
                                                <input type ="hidden" class = "lblNoArahan3" value="${data}"/>
                                            </td>`;
                             return link;
                         }
                     },
                     { "data": "No_Staf" },
                     { "data": "MS01_Nama" },
                     {
                         className: "btnView3",
                         "data": "No_Staf",
                         render: function (data, type, row, meta) {

                             if (type !== "display") {

                                 return data;

                             }

                             var link = `<button id="btnView3" runat="server"  data-id = "${data}" class="btn btnView3" type="button" style="color: blue" data-dismiss="modal">
                                                    <i class="fa fa-trash"></i>
                                        </button>`;
                             return link;
                         }
                     }
                 ]
             });
            
        });


        var selectedData = [];

        $(document).on('change', 'input[name="check"]', function () {
            var checkedCheckboxes = $('input[name="check"]:checked');

            if (checkedCheckboxes.length > 0) {
                selectedData = [];

                checkedCheckboxes.each(function () {
                    var data = $(this).closest('tr').find('td:first-child input').val();
                    selectedData.push(data);
                });

                console.log("Selected data:", selectedData);
            }
        });

        


        async function initDropdownCOA(id) {

            $('#' + id).dropdown({
                fullTextSearch: true,
                onChange: function (value, text, $selectedItem) {

                    console.log($selectedItem);

                    var curTR = $(this).closest("tr");

                    var recordIDVotHd = curTR.find("td > .Hid-vot-list");
                    recordIDVotHd.html($($selectedItem).data("value"));

                    //var selectObj = $($selectedItem).find("td > .COA-list > select");
                    //selectObj.val($($selectedItem).data("coltambah5"));



                    var recordIDPtj = curTR.find("td > .label-ptj-list");
                    recordIDPtj.html($($selectedItem).data("coltambah1"));

                    var recordIDPtjHd = curTR.find("td > .Hid-ptj-list");
                    recordIDPtjHd.html($($selectedItem).data("coltambah5"));

                    var recordID_ = curTR.find("td > .label-kw-list");
                    recordID_.html($($selectedItem).data("coltambah2"));

                    var recordIDkwHd = curTR.find("td > .Hid-kw-list");
                    recordIDkwHd.html($($selectedItem).data("coltambah6"));

                    var recordID_ko = curTR.find("td > .label-ko-list");
                    recordID_ko.html($($selectedItem).data("coltambah3"));

                    var recordIDkoHd = curTR.find("td > .Hid-ko-list");
                    recordIDkoHd.html($($selectedItem).data("coltambah7"));

                    var recordID_kp = curTR.find("td > .label-kp-list");
                    recordID_kp.html($($selectedItem).data("coltambah4"));

                    var recordIDkpHd = curTR.find("td > .Hid-kp-list");
                    recordIDkpHd.html($($selectedItem).data("coltambah8"));


                },
                apiSettings: {
                    url: 'Transaksi_EOTs.asmx/GetVotCOA?q={query}&ptj={ptj}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    fields: {

                        value: "value",      // specify which column is for data
                        name: "text",      // specify which column is for text
                        colPTJ: "colPTJ",
                        colhidptj: "colhidptj",
                        colKW: "colKW",
                        colhidkw: "colhidkw",
                        colKO: "colKO",
                        colhidko: "colhidko",
                        colKp: "colKp",
                        colhidkp: "colhidkp",

                    },
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term

                        //settings.urlData.param2 = "secondvalue";
                        settings.urlData.ptj = '<%=Session("ssusrKodPTj")%>';
                       
                        settings.data = JSON.stringify({ q: settings.urlData.query, ptj: settings.urlData.ptj });


                        //searchQuery = settings.urlData.query;

                        return settings;
                    },
                    onSuccess: function (response) {
                        // Clear existing dropdown options
                        var obj = $(this);

                        var objItem = $(this).find('.menu');
                        $(objItem).html('');

                        // Add new options to dropdown
                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        if (listOptions.length === 0) {
                            $(objItem).html('<div class="message">Rekod Tidak Dijumpai.</div>');
                            return false;
                        }


                        $.each(listOptions, function (index, option) {
                            //$(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                            $(objItem).append($('<div class="item" data-value="' + option.value + '" data-coltambah1="' + option.colPTJ + '" data-coltambah5="' + option.colhidptj + '" data-coltambah2="' + option.colKW + '" data-coltambah6="' + option.colhidkw + '" data-coltambah3="' + option.colKO + '" data-coltambah7="' + option.colhidko + '" data-coltambah4="' + option.colKp + '" data-coltambah8="' + option.colhidkp + '" >').html(option.text));
                        });

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        if (shouldPop === true) {
                            $(obj).dropdown('show');
                        }
                    }
                }

            });

        }

      


        $('.btnSimpanST').on('click', function () {
            if (selectedData.length > 0) {
               
                //var noArahan = $('#txtNoArahan').val();

                var noArahan = $('#<%=txtNoArahan.ClientID%>').val();
              
                $.ajax({
                    url: 'Transaksi_EOTs.asmx/SimpanStafAK',
                    method: 'POST',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({ selectedData: selectedData, noarahan: noArahan}),
                    success: function (data) {
                        // Handle the success response
                        console.log('Success:', data.d);
                        var response = JSON.parse(data.d);
                        notification(response.Message);
                        tbl1.ajax.reload();
                    },
                    error: function (xhr, status, error) {
                        // Handle the error response
                        console.error('Error:', error);
                    }
                });
            }
        });

      
      
        function OnSuccess(data, status) {
            $("#lblKetuaPej").html(data.d);

        }

        function OnError(request, status, error) {
            $("#lblKetuaPej").html(request.textStatus);

        }

       

        var searchQuery = "";
        var oldSearchQuery = "";
        var curNumObject = 0;
        var tableID = "#tblData";
        var tableID_Senarai = "#tblDataSenarai_trans";
        var tableID_SenAK = "#tblDataSenAK_trans";

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
        
        var shouldPop = true;
       

        $(document).ready(function () {
            
            // alert("test")
            $('#ddlPengesah').dropdown({
                fullTextSearch: false,
                apiSettings: {
                    url: 'Transaksi_EOTs.asmx/GetPegPengesah?q={query}&chk={chk}&ptj={ptj}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    fields: {
                        value: "MS01_NoStaf",      // specify which column is for data
                        name: "MS01_Nama"      // specify which column is for text
                    },

                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        var isChecked = document.getElementById("chkAllPengesah").checked;

                        settings.urlData.chk = isChecked;
                        settings.urlData.ptj = '<%=Session("ssusrKodPTj")%>';
                        settings.data = JSON.stringify({ q: settings.urlData.query, chk: settings.urlData.chk, ptj: settings.urlData.ptj });
                        searchQuery = settings.urlData.query;
                        
                        return settings;
                    },
                    onSuccess: function (response) {
                        // Clear existing dropdown options
                        var obj = $(this);

                        var objItem = $(this).find('.menu');
                        $(objItem).html('');

                        // Add new options to dropdown
                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        if (listOptions.length === 0) {
                            $(objItem).html('<div class="message">Rekod Tidak Dijumpai.</div>');
                            return false;
                        }



                        $.each(listOptions, function (index, option) {
                            $(objItem).append($('<div class="item" data-value="' + option.MS01_NoStaf + '">').html(option.MS01_NoStaf  + ' - ' + option.MS01_Nama));
                        });

                        //if (searchQuery !== oldSearchQuery) {
                        // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
                        //}

                        //oldSearchQuery = searchQuery;

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        if (shouldPop === true) {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });

            $('.ui.Pengesah .dropdown').on('click', function () {
                $('.Pengesah .menu').html("");
            })
        });



        $(document).ready(function () {

            // alert("test")
            $('#ddlKetuaJabatan').dropdown({
                fullTextSearch: false,
                apiSettings: {
                    url: 'Transaksi_EOTs.asmx/GetKetuaJabatan?q={query}&chk={chk}&ptj={ptj}',
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    fields: {
                        value: "MS01_NoStaf",      // specify which column is for data
                        name: "MS01_Nama"      // specify which column is for text
                    },

                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        var isChecked = document.getElementById("chkAllKetuaJabatan").checked;

                        settings.urlData.chk = isChecked;
                        settings.urlData.ptj = '<%=Session("ssusrKodPTj")%>';
                        settings.data = JSON.stringify({ q: settings.urlData.query, chk: settings.urlData.chk, ptj: settings.urlData.ptj });
                        searchQuery = settings.urlData.query;

                        return settings;
                    },
                    onSuccess: function (response) {
                        // Clear existing dropdown options
                        var obj = $(this);

                        var objItem = $(this).find('.menu');
                        $(objItem).html('');

                        // Add new options to dropdown
                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        if (listOptions.length === 0) {
                            $(objItem).html('<div class="message">Rekod Tidak Dijumpai.</div>');
                            return false;
                        }


                        $.each(listOptions, function (index, option) {
                            $(objItem).append($('<div class="item" data-value="' + option.MS01_NoStaf + '">').html(option.MS01_NoStaf + ' - ' + option.MS01_Nama));
                        });

                        //if (searchQuery !== oldSearchQuery) {
                        // $(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
                        //}

                        //oldSearchQuery = searchQuery;

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        if (shouldPop === true) {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });

            $('.ui.KetuaJabatan .dropdown').on('click', function () {
                $('.KetuaJabatan .menu').html("");
             })
         });




        $(function () {
            callFunction1();
            //callfunction2();

        });

        function callFunction1() {

        }

        $('.btnSimpan').click(async function () {
            var jumRecord = 0;
            var acceptedRecord = 0;
            var msg = "";
            var result = await performCheck("Semak");
           
            if (result === false) {
                return false;
            }
            

            var newArahan = {
                ArahanK: {
                  
                  
                    kod_PTj: $('.Hid-ptj-list').eq(0).html(),
                    Kod_Vot: $('.Hid-vot-list').eq(0).html(),
                    KW : $('.Hid-kw-list').eq(0).html(),
                    No_Surat: $('#<%=txtNoSurat.ClientID%>').val(),
                    Tkh_Mula: $('#<%=txtTkhMula.ClientID%>').val(),
                    Tkh_Tamat: $('#<%=txtTkhTamat.ClientID%>').val(),
                    Lokasi: $('#<%=txtLokasi.ClientID%>').val(),
                    PeneranganK: $('#<%=txtButirKerja.ClientID%>').val(),
                    No_Staf_Sah: $('#ddlPengesah').val(),
                    No_Staf_Lulus: $('#ddlKetuaJabatan').val(),
                    No_Staf_Peg_AK: $('#hidNo_Staf_Peg_ak').val(),
                    /*Ketua_PTJ: $('#hidKetuaPej').val(),*/
                    Jen_Dok: $('#hidJenDok').val(),
                    File_Name: $('#hidFileName').val(),
                    No_Arahan: $('#<%=txtNoArahan.ClientID%>').val(),
                }
            }
            
            console.log(newArahan);
            // ----
            acceptedRecord += 1;
           
           // var NamaFail = $('#hidFileName').val();
           
            if (newArahan.No_Staf_Sah === "" || newArahan.No_Staf_Lulus === "") {
                notification("Sila pastikan tiada ruangan kosong.")
                return false;
            }


            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
            console.log(confirm)
            if (!confirm)
            {
                return
            }
            else {

                var result = JSON.parse(await ajaxSaveEOT(newArahan));
            }
       

        });

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

        async function ajaxSaveEOT(arahanK) {

         

               
                $.ajax({
                   
                    url: 'Transaksi_EOTs.asmx/SimpanAK',
                    method: 'POST',
                    data: JSON.stringify(arahanK),
                    
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        var response = JSON.parse(data.d)
                        console.log(response);
                        notification(response.Message);
                        var payload = response.Payload;
                        $("#<%=txtNoArahan.ClientID%>").val(payload.No_Arahan);
                                               
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }

                });

            //})

        }
        
        function show_message_async(msg, okfn, cancelfn) {

            $("#MessageModal .modal-body").text(msg);
            var decision = false
            return new Promise(function (resolve) {

                $('.btnYA').click(function () {
                    console.log("rreessoollvveedd")
                    decision = true
                });
                $("#MessageModal").on('hidden.bs.modal', function () {
                    resolve(decision);
                });


                $("#MessageModal").modal('show');
            })

        }

        $('.btn-danger').click(async function () {
            //alert("test");
            //var result = JSON.parse(await ajaxDeleteOrder($('#lblNoJurnal').val()))
            $('#txtNoArahan').val("")
            await clearAllRows();
            //await clearAllRowsHdr();
           // AddRow(5);
        });

       

        $('.btnPaparSen').on('click', async function () {
          
            tbl.ajax.reload();
        });

        $('.btnPaparStaf').click(async function () {
          
            tbl.ajax.reload();
           
        });


        async function loadExistingRecordSen() {
            var record = await AjaxLoadOrderRecordSen($('#txtNoArahan').val());
            await clearAllRows();
            await AddRow(null, record);
        }


        //$('.btnPaparStaf').on('click', async function () {
        //    loadExistingRecordsStaf();
        //});

        async function loadExistingRecordStaf() {
            var record = await AjaxLoadOrderRecordStaf();
            await clearAllRows();
            await AddRow(null, record);
        }
        async function clearAllRows() {
            $(tableID + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })


            $('#lblPTJ').val("");
            $('#txtNoSurat').val("");
            $('#txtTkhMula').val("");
            $('#txtTkhTamat').val("");
            $('#txtLokasi').val("");
            $('#txtButirkerja').val("");
            $('#ddlPengesah').empty();
           /* $('#txtKetuaPej').val("");*/
            $('#txtNoArahan').val("");

          
        }

        function uploadFile() {
            var fileInput = document.getElementById("fileInput");
            var file = fileInput.files[0];

            if (file) {
                var fileSize = file.size; // File size in bytes
                var maxSize = 3 * 1024 * 1024; // Maximum size in bytes (3MB)

                if (fileSize <= maxSize) {
                    // File size is within the allowed limit

                    var fileName = file.name;
                    var fileExtension = fileName.split('.').pop().toLowerCase();

                    // Check if the file extension is PDF or Excel
                    if (fileExtension === 'pdf' || fileExtension === 'xlsx' || fileExtension === 'xls') {
                        var reader = new FileReader();
                        reader.onload = function (e) {
                           


                            var fileData = e.target.result; // Base64 string representation of the file data
                            var fileName = file.name;

                            var requestData = {
                                fileData: "test",
                                fileName: fileName,
                                resolvedUrl: resolveAppUrl("~/UPLOAD/EOT/")
                            };
                            
                            var frmData = new FormData();
                            
                            frmData.append("fileSurat", $('input[id="fileInput"]').get(0).files[0]);
                            frmData.append("fileName", fileName);
                            frmData.append("fileSize", fileSize);

                            $("#hidJenDok").val(fileExtension);
                            $("#hidFileName").val(fileName);
                            
                            $.ajax({
                                type: "POST",
                                url: "Transaksi_EOTs.asmx/GetBaseUrl",
                                data: JSON.stringify({ relativeUrl: "test" }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: false, // Ensure synchronous execution for simplicity
                                success: function (response) {
                                    resolvedUrl = response.d;
                                }
                            });
                            $.ajax({
                                url: "Transaksi_EOTs.asmx/UploadFile",
                                type: 'POST',
                                method: "POST",
                                data: frmData,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (response) {
                                    // Show the uploaded file name on the screen
                                   // $("#uploadedFileNameLabel").text(fileName);

                                    var fileLink = document.createElement("a");
                                    fileLink.href = requestData.resolvedUrl + fileName;
                                    fileLink.textContent = fileName;

                                    var uploadedFileNameLabel = document.getElementById("uploadedFileNameLabel");
                                    uploadedFileNameLabel.appendChild(fileLink);


                                    $("#uploadedFileNameLabel").show();
                                    // Clear the file input
                                    $("#fileInput").val("");

                                    $("#progressContainer").text("   Fail berjaya dimuatnaik.");
                                },
                                error: function () {
                                    $("#progressContainer").text("Muatnaik fail tidak berjaya.");
                                }
                            });
                        };

                        reader.readAsArrayBuffer(file);
                    } else {
                        // Invalid file type
                        notification("Hanya fail PDF dan Excel dibenarkan untuk muatnaik.");
                    }
                } else {
                    // File size exceeds the allowed limit
                    notification("Saiz fail melebihi limit 3MB.");
                }
            } else {
                // No file selected
                notification("Sila fail untuk muatnaik.");
            }
        }

        function resolveAppUrl(relativeUrl) {
            // Make a separate AJAX request to the server to resolve the URL
            var resolvedUrl = "";
            $.ajax({
                type: "POST",
                url: "Transaksi_EOTs.asmx/GetBaseUrl",
                data: JSON.stringify({ relativeUrl: relativeUrl }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false, // Ensure synchronous execution for simplicity
                success: function (response) {
                    resolvedUrl = response.d;
                }
            });
            return resolvedUrl;
        }

        async function paparSenaraiAK(totalClone, objOrder) {
            var counter = 1;
            var table = $('#tblDataSenAK');

            if (objOrder !== null && objOrder !== undefined) {
                totalClone = objOrder.Payload.length;

            }
            // console.log(objOrder)

            while (counter <= totalClone) {


                var row = $('#tblDataSenAK tbody>tr:first').clone();
                row.attr("style", "");
                var val = "";

                $('#tblDataSenAK tbody').append(row);

                if (objOrder !== null && objOrder !== undefined) {

                    if (counter <= objOrder.Payload.length) {
                        await setValueToRow(row, objOrder.Payload[counter - 1]);
                    }
                }

                counter += 1;
            }
        }


        function notification(msg) {
            $("#notify").html(msg);
            $("#NotifyModal").modal('show');
        }

        //async function clearAllRowsHdr() {

        //    $('#lblNoJurnal').val("");
        //    $('#txtNoRujukan').val("");
        //    $('#txtTarikh').val("");
        //    $('#txtPerihal').val("");
        //    $('#ddlJenTransaksi').empty();


        //}

        async function clearAllRows_senarai() {
            $(tableID_Senarai + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
        }

        async function clearAllRows_senarai() {
            $(tableID_SenAK + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })
        }

        $(tableID).on('click', '.btnDelete', async function () {
            event.preventDefault();
            var curTR = $(this).closest("tr");
            var recordID = curTR.find("td > .data-id");
            var bool = true;
            var id = setDefault(recordID.val());

            if (id !== "") {
                bool = await DelRecord(id);
            }

            if (bool === true) {
                curTR.remove();
            }

            calculateGrandTotal();
            return false;
        })


        async function AjaxLoadOrderRecordSen(id) {

            try {

                const response = await fetch('Transaksi_EOTs.asmx/LoadSenarai', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                   // body: JSON.stringify({ id: id })
                });
                const data = await response.json();
                return JSON.parse(data.d);

            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

        async function AjaxLoadOrderRecordStaf() {

            try {

                const response = await fetch('Transaksi_EOTs.asmx/LoadRecordStaf', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    //body: JSON.stringify({ id: id })
                    body: JSON.stringify({ })
                });
                const data = await response.json();
                return JSON.parse(data.d);
            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

     

        $(tableID_Senarai).on('click', '.btnView', async function () {
            event.preventDefault();
            var curTR = $(this).closest("tr");
            var recordID = curTR.find("td > .lblNo");
          

            return false;
        })


        $(tableID_SenAK).on('click', '.btnView2', async function () {
            event.preventDefault();
            var curTR = $(this).closest("tr");
            var recordID = curTR.find("td > .lblNo2");
           

            return false;
        })
        
        $(tblDataSenarai_Staf).on('click', '.btnView3', async function () {

            event.preventDefault();

            var bool = true;
            //var id = recordID[0].val();
            var id = $(this).data("id")
            var id2 = $(this).attr("data-id")
            var id1 = $(this).closest('tr').find('td:first-child input').val();
            if (id !== "") {


                //var recordHdr = await AjaxGetRecDelDtlEot(id, id1);
                bool = await DelRecord(id, id1);

            }

            if (bool === true) {
                id.remove();
            }

            return false;
        })

        async function DelRecord(id, id1) {
            var bool = false;

            //var result_ = id.split('|');
            //var nobil = result_[0];
            //var noitem = result_[1];
            //console.log(nobil, noitem)

            var result = JSON.parse(await AjaxGetRecDelDtlEot(id, id1));

            if (result.Code === "00") {
                bool = true;
            }

            return bool;
        }

        async function AjaxGetRecDelDtlEot(id, id1) {

            try {

                const response = await fetch('Transaksi_EOTs.asmx/LoadDeleteStafAK', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ id: id, id1: id1 })
                });
                const data = await response.json();
                // return JSON.parse(data.d);

                var result = JSON.parse(data.d);
                
                notification(result.Message);
                tbl1.ajax.reload();


            } catch (error) {
                console.error('Error:', error);
                return false;
            }
        }

       
       
      
    </script>
</asp:Content>
