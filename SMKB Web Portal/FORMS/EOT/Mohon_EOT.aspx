<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Mohon_EOT.aspx.vb" Inherits="SMKB_Web_Portal.Mohon_EOT" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
     <%@ Register Src="~/FORMS/EOT/Modal_Message.ascx" TagName="popupM" TagPrefix="Message" %>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
     <style>
       

     .middle-align {
            text-align:center;
        }
      .right-align {
            text-align: right;
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

        .textbox-container {
  position: relative;
  display: inline-block;
}


    </style>
 <script>
     

 </script>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">

    <div id="PermohonanTab" class="tabcontent" style="display: block">
    <div class="modal fade" id="PilihStaf" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Arahan Kerja</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                     <!-- Create the dropdown filter -->
                    <div class="search-filter" id="SearchF">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
                                <label for="inputEmail3" class="col-sm-2 col-form-label" style="text-align:right">Carian :</label>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <select id="categoryFilter" class="custom-select" >
                                            <option value="">SEMUA</option>
                                            <option value="1" selected="selected">Hari Ini</option>
                                            <option value="2">Semalam</option>
                                            <option value="3">7 Hari Lepas</option>
                                            <option value="4">30 Hari Lepas</option>
                                            <option value="5">60 Hari Lepas</option>
                                            <option value="6">Pilih Tarikh</option>
                                        </select>
                                         <button id="btnSearch" runat="server" class="btn btnSearch" type="button">
                                                <i class="fa fa-search"></i>
                                            </button>
                                    </div>
                                </div>
                           <div class="col-md-5">
                                    <div class="form-row">
                                         <div class="form-group col-md-5">
                                           <br />
                                        </div>
                                        </div>
                               </div>
                                <div class="col-md-11">
                                    <div class="form-row">
                                        <div class="form-group col-md-1">
                                            <label id="lblMula" style="text-align: right;display:none;"  >Mula: </label>
                                        </div>
                                        
                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display:none;" class="form-control date-range-filter">
                                        </div>
                                         <div class="form-group col-md-1">
                                     
                                        </div>
                                        <div class="form-group col-md-1">
                                            <label id="lblTamat" style="text-align: right;display:none;" >Tamat: </label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display:none;" class="form-control date-range-filter">
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                   </div>
                   
                    <div class="modal-body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataSenarai_trans" class="table table-striped" style="width: 99%">
                                    <thead>
                                        <tr>
                                            <th scope="col">No. Arahan</th>
                                            <th scope="col">No. Staf</th>
                                            <th scope="col">No. Rujukan Surat</th> 
                                            <th scope="col">No. Staf Sah</th> 
                                            <th scope="col">Nama Staf Sah</th>
                                            <th scope="col">No. Staf Lulus</th> 
                                            <th scope="col">Nama Staf Lulus</th>
                                            <th scope="col">Kod PTJ</th> 
                                            <th scope="col">Pejabat</th> 
                                            <th scope="col">Tkh Mula</th> 
                                            <th scope="col">Tkh Tamat</th> 
                                            <th scope="col">Lokasi</th> 
                                            <th scope="col">PeneranganK</th> 
                                            <th scope="col">Nama Fail</th> 
                                          <%--  <th scope="col">Tindakan</th> --%>
                                            
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
        </div>
  
     
<div id="popupM">
  <div class="modal-body">
   
         <div class="row">
                    <div class="col-md-12">                    
                       <div class="form-row">  
                           <div class="form-group col-md-6" align="left">
                                <div class="btn btn-primary btnPaparStaf" onclick="ShowPopup('1')">
                                    <i class="fa fa-list"></i>Senarai Arahan Kerja
                                </div>
                            </div>
                            <div class="form-group col-md-6" align="right">
                                <button type="button" class="btn btn-warning btnCetak" data-toggle="tooltip" data-validation-group="Semak">Cetak</button> 
                            </div>
                        </div>
                      </div>
               
        </div>
  
  </div>


    <div class="container-fluid"> 
          <ul class="nav nav-tabs" id="myTab" role="tablist">
            <li class="nav-item active" role="presentation"><a class="nav-link active" data-toggle="tab" id="tab-pemohon" href="#home">Maklumat Arahan Kerja</a></li>
            <li class="nav-item" role="presentation"><a class="nav-link"  data-toggle="tab" id="tab-permohonan" href="#menu1">Permohonan Kerja Lebih Masa</a></li>
    
          </ul>
  
    <div class="tab-content">
    <div id="home" class="tab-pane fade in active show">
      
      <asp:Panel ID="Panel1" runat="server" >    
        <div class="modal-body">            
        <br>
         <div class="row">
            <dv class="col-md-12">                    
                    <div class="form-row">
                            <%--<div class="form-group col-md-4" style="left: 0px; top: 0px">
                            <label for="PTJ" class="col-form-label">PTj</label>
                            <input type="text" class="form-control" id="lblPTJ2" readonly="readonly" style="width:450px" > 
                                <input type="hidden" class="form-control"  id="hPTJ2" style="width:300px" readonly="readonly" /> 
                            </div>--%>
                             <div class="form-group col-md-3">
                                 <asp:TextBox ID="txtNoArahan" runat="server" Width="100%" class="input-group__input" name="No Arahan" placeholder="&nbsp;" ReadOnly="true"></asp:TextBox>
                                 <label for="NoArahan" class="input-group__label">No Arahan</label>                                                                                                                                                            
                            </div>  
                            <div class="form-group col-md-3">
                                <input type="text" class="input-group__input" id="txtNoSurat" runat="server" name="No Surat " placeholder="&nbsp;" style="width:100%" maxlength="30" readonly/> 
                                <label for="NoSurat" class="input-group__label">No Surat</label>                                                                         
                            </div>
                                                                 
                            <div class="form-group col-md-3">
                                 <input type="text" class="input-group__input" id="txtTkhMula"  name="Tarikh Mula Kerja" placeholder="&nbsp;" runat="server" style="width:100%" readonly /> 
                                <label for="TarikhMula"  class="input-group__label">Tarikh Mula Kerja</label>                         
                            
                             </div>    
                        
                            
                             <div class="form-group col-md-3">
                                <input type="text" class="input-group__input" id="txtTkhTamat" name="Tarikh Tamat Kerja"  placeholder="&nbsp;" runat="server" style="width:100%" readonly />
                                <label for="TarikhTamat"  class="input-group__label">Tarikh Tamat Kerja</label>
                               
                             </div>                                
                        </div>

                    <div class="form-row">
                        <div class="form-group col-md-3">
                             <asp:TextBox ID="txtLokasi" runat="server"   CssClass="input-group__input" style="width:100%"  name="Lokasi" placeholder="&nbsp;"  Rows="2" TextMode="MultiLine" MaxLength="50" ReadOnly="true" ></asp:TextBox>                    
                            <label for="Lokasi"  class="input-group__label">Lokasi</label>                                                                            
                        </div>
                                
                        <div class="form-group col-md-3">
                             <asp:TextBox ID="txtButirKerja" runat="server"   style="width:100%" CssClass="input-group__input" Rows="2" name="Penerangan Kerja" placeholder="&nbsp;" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                            <label for="Penerangan"  class="input-group__label">Penerangan Kerja</label>                                                       
                        </div>                                
                        <div class="form-group col-md-3">
                            <input type="text"  style="width:100%" Class="input-group__input" id="ddlPengesah"  name="Pegawai Pengesah" placeholder="&nbsp;"  ReadOnly="readonly" /> 
                            <label for="Pengesah" class="input-group__label">Pegawai Pengesah</label>                                      
                                <%--<select class="ui search dropdown Pengesah" name="ddlPengesah" id="ddlPengesah"  style="width:360px; left: 0px; top: 0px;"></select>  --%>                                                                                                           
                           
                            <input type="hidden" class="form-control"  id="hPengesah" style="width:50%" readonly="readonly" />
                            <%--<input type="checkbox" id ="chkAllPengesah" value ="1"  AutoPostBack = true/><label for="CatatPengesah">Senarai semua penyelia</label> --%>
                        </div>
                        <div class="form-group col-md-3">
                            <input type="text" Class="input-group__input"  id="lblKetuaPej" name="Ketua Jabatan" placeholder="&nbsp;"  style="width:100%" readonly="readonly" />
                            <label for="KetuaPej" class="input-group__label">Ketua Jabatan</label>                                    
                             
                              <input type="hidden" class="form-control"  id="hPelulus" style="width:100px" readonly="readonly" />
                             <input type="hidden" class="form-control"  id="hKodPtj" style="width:100px" readonly="readonly" />
                                <%-- <asp:RequiredFieldValidator ID="RqrKetuaPej" runat="server" ControlToValidate="lblKetuaPej" CssClass="text-danger" ErrorMessage="*Sila masukkan maklumat Ketua PTJ" ValidationGroup="Semak" Display="Dynamic"/>--%>

                                <%--<input type="hidden" class="form-control"  id="hidKetuaPej" style="width:300px" readonly="readonly" />   --%>
                        </div>
                                 
                    </div>

                    <div class="form-row"> 
                         <div class="form-group col-md-1">
                             <label for="lampiran"  style="font-size:12px">Surat Arahan</label>
                             
                         </div>
                        <div class="form-group col-md-2">
                             <button id="btfile"><i class="fa fa-download" aria-hidden="true"></i>&nbsp;&nbsp<span id="uploadedFileNameLabel" style="display: inline"></span></button>
                             
                         </div>
                        
                         <div class="form-group col-md-3">
                             <asp:TextBox ID="txtNoMohon" runat="server" Width="100%" CssClass="input-group__input" ReadOnly="true" name="No Mohon" placeholder="&nbsp;"></asp:TextBox>
                            <label for="NoArahan"  class="input-group__label">No Mohon</label>                                                                       
                        </div>   
                          
                    </div>                                                                                 
            </div>
          </div>  
         <%-- <div class="form-row">
            <div class="form-group col-md-11" align="right">
               
                <button type="button" class="btn btn-success btnHantar" data-toggle="tooltip" data-validation-group="Semak">Hantar</button> 
            
            </div>
             <div class="form-group col-md-1" style="left: 0px; top: 0px">
                           
             </div>
         </div>--%>
        </asp:Panel>
    
   </div>
   <div id="menu1" class="tab-pane fade in " role="tabpanel">     
       <asp:Panel ID="Panel2" runat="server" >
            <div class="modal-body">
                <br>
         <div class="row">
                            
       
             <div class="col-md-12"> 
                  <div class="form-row">
                    <div class="form-group col-md-1">
                        <select class="input-group__select ui search dropdown TahunTuntut" name="Tahun Tuntut" id="ddlTahunTuntut"  placeholder="&nbsp;"  style="width:100%">
                               
                        </select>
                        <label for="TahunTuntut" class="input-group__label">Tahun Tuntut</label>                                                  
                    </div>
                    <div class="form-group col-md-1">
                         <select class="input-group__select ui search dropdown TahunTuntut" name="Bulan Tuntut"  placeholder="&nbsp;" id="ddlBulanTuntut"  style="width:100%">
                               
                          </select>
                        <label for="BulanTuntut" class="input-group__label">Bulan Tuntut</label>
                       
                           
                    </div>                                       
                    <div class="form-group col-md-2">
                        <input type="date" class="input-group__input" id="txtTkhTuntut" runat="server" style="width:100%" name="Tarikh Tuntut"  placeholder="&nbsp;"/> 
                        <label for="TarikhTuntut" class="input-group__label">Tarikh Tuntut</label>
                         
                        <asp:LinkButton ID="LinkButton1" runat="server" ToolTip="Klik untuk papar kalendar">
                                        
                        </asp:LinkButton>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtTkhTuntut" CssClass="text-danger" ErrorMessage="*Sila pilih Tarikh Mula" ValidationGroup="Semak" Display="Dynamic"/>
                   
                   
                    </div> 
                      
                        <div class="form-group col-md-1">
                             <input type="text" class="input-group__input" id="txtJamMula"  runat="server"  style="text-align: right; width:100%" name="Jam Mula"  placeholder="&nbsp;" /> 
                            <label for="JamMula" class="input-group__label">Jam Mula</label>
                                 
                                <h9 style="color:#FF0000;font-size:11px;font-weight:bold"> (Nota : 2400 -> 0000)</h9>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtJamMula" CssClass="text-danger" ErrorMessage="*Sila Masukkan Jam Mula" ValidationGroup="Semak" Display="Dynamic"/>
                        </div> 
                        <div class="form-group col-md-1">
                             <input type="text" class="input-group__input" id="txtJamTamat" runat="server" style="text-align: right; width:100%" name="Jam Tamat"  placeholder="&nbsp;" />   
                            <label for="JamTamat" class="input-group__label">Jam Tamat</label>
                               
                        
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtJamTamat" CssClass="text-danger" ErrorMessage="*Sila Masukkan Jam Tamat" ValidationGroup="Semak" Display="Dynamic"/>
                        </div>
                        <div class="form-group col-md-1">  
                            <label for="ButKira"></label>                    
                            <button type="button" class="btn btn-info btnKira" style="margin-top:3px" data-toggle="tooltip"  data-validation-group="Semak">Kira</button>                
                        </div>
              
                        <div class="form-group col-md-1">
                            <input type="text" class="input-group__input" id="lblJamTuntut" name="Jam Tuntut" runat="server" style="text-align: right; width:100%" readonly  placeholder="&nbsp;" />                           
                            <label for="JamTuntut" class="input-group__label">Jam Tuntut</label>                              
                        </div>
                        <div class="form-group col-md-1">
                             <input type="text" class="input-group__input" id="lblAmnTuntut" runat="server" style="text-align: right; width:100%" name="Amaun Tuntut"  placeholder="&nbsp;"  readonly />   
                            <label for="AmaunTuntut" class="input-group__label">Amaun Tuntut</label>
                           
                        </div>
                       

                       <input type="hidden" class="form-control"  id="hTahun" style="width:100px" readonly="readonly" />
                       <input type="hidden" class="form-control"  id="hBulan" style="width:100px" readonly="readonly" />
                       <input type="hidden" class="form-control"  id="hNoArahan" style="width:100px" readonly="readonly" />
                       <input type="hidden" class="form-control"  id="hTujuan" style="width:100px" readonly="readonly" />
                       <input type="hidden" class="form-control"  id="hOTPtj" style="width:100px" readonly="readonly" />
                       <input type="hidden" class="form-control"  id="hNoStafLulus" style="width:100px" readonly="readonly" />
                             
                    </div>
               </div>
           
           </div>
           <div class="row">
             <div class="col-md-12"> 
                  <div class="form-row">
                        <div class="form-group col-md-2">
                            <div class="form-inline">
                                         
                                           <input type="file" id="fileInputTS" class="input-group__input choose-button"/>
                                           <label for="UploadSurat"  class="input-group__label">Muatnaik Surat Lewat</label>
                                            <input type="button" id="uploadButton" class="btn btn-secondary" value="Muatnaik" onclick="uploadFileTS()" />

                                                <span id="uploadedFileNameLabelTS" style="display: inline;"></span>
                                                <span id="">&nbsp</span>
                                                <span id="progressContainerTS"></span>
                                             <input type="hidden" class="form-control"  id="hidJenDokTS" style="width:300px" readonly="readonly" /> 
                                              <input type="hidden" class="form-control"  id="hidFileNameTS" style="width:300px" readonly="readonly" /> 
                                                                                   
                                         </div>    
                        </div>
                       <div class="form-group col-md-1">
                                        <asp:Label ID="lblMessageDokumen" runat="server" />
                                    </div>
                         <div class="form-group col-md-9" align="right">
                            <label for="ButSimpan">&nbsp</label>
                          
                            <button type="button" class="btn btn-secondary btnSimpan"  style="margin-top:3px" data-toggle="tooltip" data-validation-group="Semak">Simpan</button>                
                        </div>
                       
                        </div>              
              </div>

          </div>
     <div class="row">
                <div class="col-md-12">
                    <%--<h6><strong>Transaksi Tuntutan Kerja Lebih Masa</strong></h6>--%>
                    <label for="lbltajuk">Transaksi Tuntutan Kerja Lebih Masa</label>
                    <br />
                    <h6><i>** Sila klik pada rekod yang hendak dihapuskan.Kemudian sila buat kemaskini semula.</i></h6>
                    <div class="transaction-table table-responsive">
                        <table id="tblData" class="table table-striped" style="width: 100%">
                            <thead>
                                <tr>
                                    <%--<th scope="col">Turutan</th>--%>
                                    <th scope="col">Tahun</th>
                                    <th scope="col">Bulan</th>
                                    <th scope="col">TkhTuntut</th>
                                    <th scope="col">Jam Mula</th>
                                    <th scope="col">Jam Tamat</th>
                                    <th scope="col">Kadar Tuntut</th>
                                    <th scope="col">Amaun Tuntut</th> 
                                    
                                </tr>
                            </thead>
                            <tbody id="tableID">
                                        </tbody>               
                            <tfoot>
                                <tr>
                                    <td colspan ="4"></td>
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
         <div class="form-row">
            <div class="form-group col-md-12" align="right">
              <%--  <button type="button" class="btn btn-danger">Padam</button>           --%>                           
                <button type="button" class="btn btn-success btnHantar" data-toggle="tooltip" data-validation-group="Semak">Hantar</button>                
            </div>
             <div class="form-group col-md-1" style="left: 0px; top: 0px">
                           
             </div>
        </div>
       </div>
      </asp:Panel>
     </div>
    </div>   
   </div>
     <Message:popupM runat="server" ID="Notify" /> 
  </div>
 </div>


        <%--<div class="form-row">
           
            <div class="form-group col-md-6" align="left">
                 <div></div>
                <button type="button" class="btn btn-danger">Padam</button>
                <button type="button" class="btn btn-secondary btnSimpan">Simpan</button>
            </div>
        </div>--%>
       
    <script type="text/javascript">
        var isClicked = false;
        function ShowPopup(elm) {

            if (elm == "1") {

                $('#PilihStaf').modal('toggle');


            }
            else if (elm == "2") {

                $(".modal-body div").val("");
                $('#SenaraiStaf').modal('toggle');

            }
        }

        var tbl = null
        var tbl2 = null;

        $(document).ready(function () {
            show_loader();
            var currentYear = new Date().getFullYear();
            var previousYear = currentYear - 1;

            // Populate current year option
            $('<option>', {
                value: currentYear,
                text: currentYear
            }).appendTo('#ddlTahunTuntut');

            // Populate previous year option
            $('<option>', {
                value: previousYear,
                text: previousYear
            }).appendTo('#ddlTahunTuntut');

         
            // Function to get the name of the last three months
            function getLastThreeMonths() {
                var months = [];
                var currentDate = new Date();

                // Subtract 0, 1, and 2 from the current month to get the last three months
                for (var i = 2; i >= 0; i--) {
                    var month = currentDate.getMonth() - i;
                    var year = currentDate.getFullYear();

                    // Adjust the year if the month is less than 0 (January)
                    if (month < 0) {
                        month += 12;
                        year -= 1;
                    }

                    var monthName = new Date(year, month, 1).toLocaleString('default', { month: 'long' });


                    // Customize month names if needed
                    switch (monthName) {
                        case 'Jan':
                            monthName = 'Januari';
                            month = 1;
                            break;
                        case 'Feb':
                            monthName = 'Februari';
                            month = 2;
                            break;
                        case 'Mar':
                            monthName = 'Mac';
                            month = 3;
                            break;
                        case 'Apr':
                            monthName = 'April';
                            month = 4;
                            break;
                        case 'May':
                            monthName = 'Mei';
                            month = 5;
                            break;
                        case 'June':
                            monthName = 'Jun';
                            month = 6;
                            break;
                        case 'July':
                            monthName = 'Julai';
                            month = 7;
                            break;
                        case 'Aug':
                            monthName = 'Ogos';
                            month = 8;
                            break;
                        case 'Sept':
                            monthName = 'September';
                            month = 9;
                            break;
                        case 'Oct':
                            monthName = 'Oktober';
                            month = 10;
                            break;
                        case 'Nov':
                            monthName = 'November';
                            month = 11;
                            break;
                        case 'Dis':
                            monthName = 'Disember';
                            month = 12;
                            break;
                        // Add more cases for other month names if necessary
                        // case 'August':
                        //     monthName = 'AnotherName';
                        //     break;
                        // ...
                    }


                    //months.push(monthName);
                    months.push({ name: monthName, value: month + 1 });
                }

                return months;

            }


            // Insert the last three months into the combobox
            function insertMonthsIntoComboBox() {
                var months = getLastThreeMonths();
                var combobox = $("#ddlBulanTuntut");

                $.each(months, function (index, month) {
                    combobox.append($('<option>', {
                        value: month.value,
                        text: month.name
                    }));
                });
  

            }

            // Call the function to insert the months when the document is ready
            insertMonthsIntoComboBox();

           

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
                    "url": "Transaksi_EOTs.asmx/LoadRecordArahanInd",
                    method: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                       // return JSON.stringify({ No_Staf: $('#<%'=Session("ssusrID")%>').val() });
                        return JSON.stringify(d)
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    data: function () {
                        //Filter date bermula dari sini - 20 julai 2023
                        var startDate = $('#txtTarikhStart').val()
                        var endDate = $('#txtTarikhEnd').val()
                        
                        return JSON.stringify({
                            category_filter: $('#categoryFilter').val(),
                            isClicked: isClicked,
                            tkhMula: startDate,
                            tkhTamat: endDate,
                            <%--noID: $('#<%=Session("ssusrID")%>').val(),--%>
                        })
                        //akhir sini
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
                        rowClickHandler(data.No_Arahan);
                    });

                },

                "columns": [
                    {
                        "data": "No_Arahan",
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
                    { "data": "No_Surat" },
                    { "data": "No_Staf_SahB" },
                    { "data": "Nama_Staf_Sah" },
                    { "data": "No_Staf_LulusB" },
                    { "data": "Nama_Staf_LulusB" },
                    { "data": "Kod_PTJ" },
                    { "data": "pejabat" },
                    { "data": "Tkh_Mula" },
                    { "data": "Tkh_Tamat" },
                    { "data": "Lokasi" },
                    { "data": "PeneranganK" },
                    { "data": "File_name" }
                
                ]


            });

            $("#categoryFilter").change(function (e) {

                var selectedItem = $('#categoryFilter').val()
                if (selectedItem == "6") {
                    $('#txtTarikhStart').show();
                    $('#txtTarikhEnd').show();

                    $('#lblMula').show();
                    $('#lblTamat').show();

                    $('#txtTarikhStart').val("")
                    $('#txtTarikhEnd').val("")
                }
                else {
                    $('#txtTarikhStart').hide();
                    $('#txtTarikhEnd').hide();

                    $('#txtTarikhStart').val("")
                    $('#txtTarikhEnd').val("")

                    $('#lblMula').hide();
                    $('#lblTamat').hide();

                }

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
                    "url": "Transaksi_EOTs.asmx/LoadRecordEOTbyNoMohon",
                    method: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({ id: $('#<%=txtNoMohon.ClientID%>').val() });
                       
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

                    var strNomohon = $('#<%=txtNoMohon.ClientID%>').val();
                 
                    // Add click event
                    $(row).on("click", function () {
                        console.log(data);
                        rowClickHandler1(data.Tkh_Tuntut, strNomohon,data.Jam_Mula,data.Jam_Tamat);
                    });

                },

                "columns": [
                  //  { "data": "No_Turutan" },
                    { "data": "Tahun_Tuntut" },
                    { "data": "Bulan" },
                    { "data": "Tkh_Tuntut" },
                    { "data": "Jam_Mula" },
                    { "data": "Jam_Tamat" },
                    {
                        "data": "Kadar_Tuntut",
                        "render": function (data, type, row) {
                            // Format the Kadar_Tuntut column with three decimal places
                            if (type === 'display' || type === 'filter') {
                                return parseFloat(data).toFixed(3);
                            }
                            return data;
                        },
                        "className": "right-align"

                    },
                    {
                        "data": "Amaun_Tuntut",
                         "render": function (data, type, row) {
                            // Format the Kadar_Tuntut column with three decimal places
                            if (type === 'display' || type === 'filter') {
                                return parseFloat(data).toFixed(2);
                            }
                            return data;
                        },
                        "className": "right-align"


                    }
                ],

                "columnDefs": [
                    { "targets": [1, 2], "className": "middle-align" },
                    { "targets": [3, 4], "className": "middle-align" }
                ],
                "drawCallback": function (settings) {
                    var api = this.api();
                    var counter = 0;
                    var listofdata = api.rows().data();
                    var totaldata = listofdata.length;
                    var jumlahAmaun = 0.00;
                    var jumlahKadar = 0.000;
                    while (counter < totaldata) {
                        jumlahAmaun += parseFloat(listofdata[counter].Amaun_Tuntut)
                        jumlahKadar += parseFloat(listofdata[counter].Kadar_Tuntut)
                        counter += 1;
                    }


                    var fixedAmaun = parseFloat(jumlahAmaun).toFixed(2)
                  <%--  var amountContainer = $('#<%=totalAmaun.ClientID%>');
                    amountContainer.text(jumlahAmaun.toFixed(2));
                    amountContainer.css('text-align', 'right');--%>

                    <%--$('#<%=totalAmaun.ClientID%>').val(jumlahAmaun);--%>
                    $('#<%=totalAmaun.ClientID%>').val(fixedAmaun);
                    $('#<%=totalKadar.ClientID%>').val(jumlahKadar);
                   
                    // Output the data for the visible rows to the browser's console
                }
            });
           
            

            $('#lblPTJ').val('<%= Session("ssusrPTj")%>');
            $('#KodPTJ').val('<%= Session("ssusrKodPTj")%>');
            $('#hPTJ').html('<%= Session("ssusrKodPTj")%>');
            $('#lblPTJ').text('<%= Session("ssusrPTj")%>');
            $('#KodPTJ').text('<%= Session("ssusrKodPTj")%>');

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

                    // $('#lblKetuaPej').val(namass);
                    // $('#hidKetuaPej').val(nostafss);



                }
            });

        });

        $('.btnSearch').click(async function () {
            isClicked = true;
            tbl.ajax.reload();

        })


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
        //var totalID = "#totalBeza";

        var totalDebit = "#totalDbt";
        var totalKredit = "#totalKt";



        function OnSuccess(data, status) {
            $("#lblKetuaPej").html(data.d);

        }

        function OnError(request, status, error) {
            $("#lblKetuaPej").html(request.textStatus);

        }

     

        $('#btnOpenPilihStaf').click(function () {
            event.preventDefault();
            PilihanStafModule.NoArahan($('#<%=txtNoArahan.ClientID%>').val(), function () {
                ShowPopup(2);
            });
        });


       $('.btnSimpan').click(async function () {
            var jumRecord = 0;
            var acceptedRecord = 0;
            var msg = "";
           var result = await performCheck("Semak");

           var strTkhMula = $('#<%= txtTkhMula.ClientID%>').val();
           var strTkhTamat = $('#<%= txtTkhTamat.ClientID%>').val();
           var strTkhTuntut = $('#<%= txtTkhTuntut.ClientID%>').val();
           var strJam_Mula= $('#<%=txtJamMula.ClientID%>').val();
           var strJam_Tamat= $('#<%=txtJamTamat.ClientID%>').val();

           var parsedDate = new Date(strTkhTuntut);
           var formattedDate = ("0" + parsedDate.getDate()).slice(-2) + "/" + ("0" + (parsedDate.getMonth() + 1)).slice(-2) + "/" + parsedDate.getFullYear();


           //var strLenJamM = strJam_Mula.length;
           //var strLenJamT = strJam_Tamat.length;


         <%--  if (strLenJamM !== 4 || strLenJamT !== 4 || !isValidTimeFormat(strJam_Mula) || !isValidTimeFormat(strJam_Tamat)) {
               notification("Sila masukkan Jam Mula dan Jam Tamat mengikut format yang betul.");
               $('#<%=txtJamMula.ClientID%>').val("");
               $('#<%=txtJamTamat.ClientID%>').val("");
               $("#MainContent_FormContents_lblAmnTuntut").val("");
               $("#MainContent_FormContents_lblJamTuntut").val("");
               return false;
           }--%>


           if (formattedDate < strTkhMula || formattedDate > strTkhTamat) {
               Notification("Sila semak Tarikh Tuntut !!");
               return false;
           }


            if (result === false) {
                return false;
            }
           var newArahan = {
               MohonEOT: {

                   Tahun: $('#ddlTahunTuntut').val(),
                   Bulan: $('#ddlBulanTuntut').val(),
                   Tkh_Tuntut: $('#<%= txtTkhTuntut.ClientID%>').val(),
                   Jam_Mula: $('#<%=txtJamMula.ClientID%>').val(),
                   Jam_Tamat: $('#<%=txtJamTamat.ClientID%>').val(),
                   No_Arahan: $('#<%=txtNoArahan.ClientID%>').val(),
                   Catatan: $('#<%=txtButirKerja.ClientID%>').val(),
                   Tujuan: $('#<%=txtButirKerja.ClientID%>').val(),
                   OT_Ptj: $('#hKodPtj').val(),
                   No_Staf_Lulus: $('#hPelulus').val(),
                   No_Staf_Sah: $('#hPengesah').val(),
               //    Tkh_Mula :$('#<%'=txtTkhMula.ClientID%>').val(),
              //     Tkh_Tamat: $('#<%'=txtTkhTamat.ClientID%>').val(),
                   Amaun: $("#MainContent_FormContents_lblAmnTuntut").val(),
                   Kadar: $("#MainContent_FormContents_lblJamTuntut").val(),
                   Jen_Dok: $('#hidJenDokTS').val(),
                   File_Name: $('#hidFileNameTS').val(),
               }, q: $('#<%=txtNoMohon.ClientID%>').val()
           }

          
            console.log(newArahan);
           
            acceptedRecord += 1;

       
           if (newArahan.Amaun === "" || newArahan.Kadar === "") {
               Notification("Sila masukkan Jam Mula dan Jam Tamat");
           }



           let confirm = false
           confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
           console.log(confirm)
           if (!confirm) {
               return
           }
           else {

               (await ajaxSaveEOT(newArahan));

           }

           

        });



        async function ajaxSaveEOT(MohonEOT) {

            $.ajax({
              
                url: 'Transaksi_EOTs.asmx/SimpanEOT',
                method: 'POST',
                //data: JSON.stringify(MohonEOT),
                data: JSON.stringify(MohonEOT),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var response = JSON.parse(data.d);
                    Notification(response.Message);
                    var payload = response.Payload;
                    console.log(response.Payload);
                    /*Notification("Rekod berjaya disimpan");*/
                    $('#<%=txtNoMohon.ClientID%>').val(payload.No_Mohon);
                   
                    tbl2.ajax.reload();
                   

                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                    reject(false);
                }

            });

        }


        $('.btnHantar').click(async function () {
            var jumRecord = 0;
            var acceptedRecord = 0;
            var msg = "";
  
            var newEot = {
                MohonEOT: {
                    No_Mohon: $('#<%=txtNoMohon.ClientID%>').val(),
                    No_Arahan: $('#<%=txtNoArahan.ClientID%>').val(),
                    No_Staf: $('#<%=Session("ssusrID")%>').val(),
                    No_Staf_Sah: $('#hPengesah').val(),
                 }
             }



            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menghantar rekod ini?")
            console.log(confirm)
            if (!confirm) {
                return
            }
            else {

                (await ajaxHantarEOT(newEot));

            }



            // msg = "Anda pasti ingin menghantar rekod ini?"

            // if (!confirm(msg)) {
            //     return false;
            // }

            //(await ajaxHantarEOT(newEot));

             console.log(newEot)
            

         });


        async function ajaxHantarEOT(MohonEOT) {


            $.ajax({

                url: 'Transaksi_EOTs.asmx/HantarEOT',
                method: 'POST',
                data: JSON.stringify(MohonEOT),
             
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var response = JSON.parse(data.d)
                    Notification(response.Message)
                    

                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                    reject(false);
                }

            });

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
             var strTkhMula = $('#<%= txtTkhMula.ClientID%>').val();
             var strTkhTamat = $('#<%= txtTkhTamat.ClientID%>').val();
             var strTkhTuntut = $('#<%= txtTkhTuntut.ClientID%>').val();
             var mula = $('#<%=txtJamMula.ClientID%>').val();
             var tamat = $('#<%=txtJamTamat.ClientID%>').val();

             var parsedDate = new Date(strTkhTuntut);
             var formattedDate = ("0" + parsedDate.getDate()).slice(-2) + "/" + ("0" + (parsedDate.getMonth() + 1)).slice(-2) + "/" + parsedDate.getFullYear();

             var strLenJamM = mula.length;
             var strLenJamT = tamat.length;


             if (strLenJamM !== 4 || strLenJamT !== 4) {
                 Notification("Sila masukkan Jam Mula dan Jam Tamat mengikut format yang betul.");
                 $('#<%=txtJamMula.ClientID%>').val("");
                 $('#<%=txtJamTamat.ClientID%>').val("");

                 return false;
             }


             if (mula > tamat) {
                 Notification("Sila semak Jam !!");
                 $("#MainContent_FormContents_lblJamTuntut").val("");
                 $("#MainContent_FormContents_lblAmnTuntut").val("");
                 return false;

             }

             if (formattedDate < strTkhMula || formattedDate > strTkhTamat) {
                 Notification("Sila semak Tarikh Tuntut !!");
                 return false;
             }


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
                   
                     Tahun: $('#ddlTahunTuntut').val(),
                     Bulan: $('#ddlBulanTuntut').val(),
                     Tkh_Tuntut: $('#<%= txtTkhTuntut.ClientID%>').val(),
                     Jam_Mula: $('#<%=txtJamMula.ClientID%>').val(),
                     Jam_Tamat: $('#<%=txtJamTamat.ClientID%>').val(),
                   
                 }

             }

           
             var result = JSON.parse(await ajaxKiraAmtEOT(newArahan));
             Notification(result.Message)
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



       


        $('.btn-danger').click(async function () {
            //alert("test");
            //var result = JSON.parse(await ajaxDeleteOrder($('#lblNoJurnal').val()))
            $('#txtNoArahan').val("")
            await clearAllRows();
            await clearAllRowsHdr();
           
        });

        //$('.btnPapar').click(async function () {
        //    var record = await AjaxLoadOrderRecord_Senarai("");
        //    $('#txtNoArahan').val("")
        //    await clearAllRows_senarai();
        //    await paparSenarai(null, record);
        //});

        $('.btnPaparSen').on('click', async function () {
            tbl.ajax.reload();
        });

        $('.btnPaparStaf').click(async function () {
            console.log(tbl);
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
            $(tblData + " > tbody > tr ").each(function (index, obj) {
                if (index > 0) {
                    obj.remove();
                }
            })          
        }


        $('.btnCetak').click(async function () {
            var params = `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;
            
            var txtNoMohon = $('#<%=txtNoMohon.ClientID%>').val()
            if (txtNoMohon != "") {
                window.open('<%=ResolveClientUrl("~/FORMS/EOT/CetakEOT.aspx")%>?bilid=' + txtNoMohon, '_blank', params);
            }
            else {

                Notification("No permohonan belum wujud.")
            }

        });


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
                                url: "Transaksi_EOTs.asmx/UploadFile",
                                type: 'POST',
                                data: frmData,
                                cache: false,
                                contentType: false,
                                processData: false,
                                success: function (response) {

                                    // Clear the file input
                                    $("#fileInput").val("");
                                    $('#uploadedFileNameLabel').empty();
                                   // $("#uploadedFileNameLabel").text(fileName);
                                    var fileLink = document.createElement("a");
                                    fileLink.href = requestData.resolvedUrl + fileName;
                                    fileLink.textContent = fileName;

                                    var uploadedFileNameLabel = document.getElementById("uploadedFileNameLabel");
                                    uploadedFileNameLabel.appendChild(fileLink);

                                    // Show the uploaded file name on the screen
                                    $("#uploadedFileNameLabel").show();

                                  

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
                        Notification("Hanya Fail PDF dan Excel dibenarkan untuk muatnaik.");
                    }
                } else {
                    // File size exceeds the allowed limit
                    Notification("Saiz fail melebihi limit 3MB.");
                }
            } else {
                // No file selected
                Notification("Sila pilih fail untuk muatnaik.");
            }
        }


        function resolveAppUrl(relativeUrl) {
            // Make a separate AJAX request to the server to resolve the URL
            var resolvedUrl = "";
            $.ajax({
                type: "POST",
                url: "Transaksi_EOTs.asmx/ResolveAppUrl",
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

        async function rowClickHandler1(id1, id2,id3,id4) {
            var dateParts = id1.split('/'); // Split the date string into its components
            var day = parseInt(dateParts[0], 10); // Extract the day part and convert to integer
            var month = parseInt(dateParts[1], 10); // Extract the month part and convert to integer
            var year = parseInt(dateParts[2], 10); // Extract the year part and convert to integer
            var parsedDate = new Date(year, month - 1, day); // Note: Month is 0-indexed in JavaScript, so subtract 1

            var formattedDateid = parsedDate.getFullYear() + "-" + ("0" + (parsedDate.getMonth() + 1)).slice(-2) + "-" + ("0" + parsedDate.getDate()).slice(-2);
          
            var newDelOT = {
                MohonEOT: {

                    Tkh_Tuntut: formattedDateid,
                    No_Mohon: id2,
                    Jam_Mula: id3,
                    Jam_Tamat:id4,
                  
                   }

               }

            let confirm = false
            confirm = await show_message_async("Anda pasti ingin menghapus rekod pada tarikh ini ? ")
            console.log(confirm)
            if (!confirm) {
                return
            }
            else {

                (await AjaxDelTransaksi(newDelOT));

            }
         
        }


        async function AjaxDelTransaksi(MohonEOT) {
          
            $.ajax({

                url: 'Transaksi_EOTs.asmx/DelRecbyTkhNoMohn',
                method: 'POST',
                data: JSON.stringify(MohonEOT),

                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var response = JSON.parse(data.d)
                    Notification(response.Message)
                    tbl2.ajax.reload();

                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                    reject(false);
                }

            });

        }

       
        $(tableID_Senarai).on('click', '.btnView', async function () {

            event.preventDefault();
           
            var bool = true;
            //var id = recordID[0].val();
            var id = $(this).data("id")
            var id2 = $(this).attr("data-id")
         
            
            if (id !== "") {

                //BACA HEADER JURNAL
               
                var recordHdr = await AjaxGetRecordHdrEot(id);               
                console.log(recordHdr);
                await AddRowHeader(null, recordHdr);


            //    //BACA DETAIL JURNAL
            //    var record = await AjaxGetRecordJurnal(id);
            //    await clearAllRows();
            //    await AddRow(null, record);
            }

            return false;
        })


        async function rowClickHandler(id) {
          
            $("#PilihStaf").modal("hide");
         
            var bool = true;
          
            //var id = $(this).data("id")
            //var id2 = $(this).attr("data-id")

           
            if (id !== "") {

                //BACA HEADER JURNAL

                var recordHdr = await AjaxGetRecordHdrEot(id);
                console.log(recordHdr);
                await AddRowHeader(null, recordHdr);


                //  clear DETAIL OT              
               
                await clearAllRowsDetail();
                await ClearDetDatatable();
            }

            return false;
        }



        async function ClearDetDatatable() {
          
            var table = $('#tblData').DataTable();
            table.clear().draw();

        }

        async function clearAllRowsDetail() {
           
            //$('#<%'=txtTkhTuntut.ClientID%>').val("")
            $('#<%=txtJamMula.ClientID%>').val("")           
            $('#<%=txtJamTamat.ClientID%>').val("")          
            $('#<%=lblJamTuntut.ClientID%>').val("")            
            $('#<%=lblAmnTuntut.ClientID%>').val("")          
        }

        async function clearAllRowsHdr() {
                      
            $('#<%=txtNoSurat.ClientID%>').val("")
            $('#<%=txtNoArahan.ClientID%>').val("")
            $('#lblPTJ').val("")
            $('#<%=txtTkhMula.ClientID%>').val("")
            $('#<%=txtTkhTamat.ClientID%>').val("")
            $('#<%=txtLokasi.ClientID%>').val("")
            $('#<%=txtButirKerja.ClientID%>').val("")
            $('#ddlPengesah').empty()
            $('#lblKetuaPej').val("")
            $('#uploadedFileNameLabel').val("")
            $('#<%=txtNoMohon.ClientID%>').val("")

        }

        async function AddRowHeader(totalClone, objOrder) {
            var counter = 1;
            //var table = $('#tblDataSenarai');

            if (objOrder === null || objOrder === undefined) {
                return false;
            }

            await setValueToRow_HdrArahan(objOrder[0]);
            // console.log(objOrder)
        }

        
        async function setValueToRow_HdrArahan(orderDetail) {

            
         $('#<%=txtNoSurat.ClientID%>').val(orderDetail.No_Surat)
            $('#<%=txtNoArahan.ClientID%>').val(orderDetail.No_Arahan)
            $('#lblPTJ').val(orderDetail.pejabat)
            $('#<%=txtTkhMula.ClientID%>').val(orderDetail.Tkh_Mula)
            $('#<%=txtTkhTamat.ClientID%>').val(orderDetail.Tkh_Tamat)
            $('#<%=txtLokasi.ClientID%>').val(orderDetail.Lokasi)
            $('#<%=txtButirKerja.ClientID%>').val(orderDetail.PeneranganK)
          
            $('#lblKetuaPej').val(orderDetail.Staf_lulusB)
            $('#ddlPengesah').val(orderDetail.Nama_Sah)
            $('#hPengesah').val(orderDetail.No_Staf_SahB)
            $('#hPelulus').val(orderDetail.No_Staf_LulusB)
            $('#hKodPtj').val(orderDetail.Kod_PTJ)
           
            var dateParts = orderDetail.Tkh_Mula.split('/'); // Split the date string into parts
            var formattedDate = dateParts[2] + '-' + dateParts[1] + '-' + dateParts[0]; // Format as DD-MM-YYYY 
            
            $('#<%=txtTkhTuntut.ClientID%>').val(formattedDate);
            var strFileName = orderDetail.File_name;
            var fileUrl = "~/UPLOAD/EOT/" + strFileName;
           
            var fileLink = $('<a></a>');
            fileLink.attr('href', orderDetail.url);
            fileLink.text(strFileName);
            $('#uploadedFileNameLabel').empty(); // Clear any existing content
            $('#uploadedFileNameLabel').append(fileLink);
          
           
        }



        $(tableID_SenAK).on('click', '.btnView2', async function () {
            event.preventDefault();
            var curTR = $(this).closest("tr");
            var recordID = curTR.find("td > .lblNo2");
            

            return false;
        })

        async function AjaxGetRecordHdrEot(id) {

            try {

                const response = await fetch('Transaksi_EOTs.asmx/LoadRecordByNoArahan', {
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


  


        async function AjaxGetRecordDtlEot(id) {

            try {

                const response = await fetch('Transaksi_EOTs.asmx/LoadRecordStafArahan', {
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

        function uploadFileTS() {
            var fileInput = document.getElementById("fileInputTS");
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

                            frmData.append("fileSuratTS", $('input[id="fileInputTS"]').get(0).files[0]);
                            frmData.append("fileNameTS", fileName);
                            frmData.append("fileSizeTS", fileSize);

                            $("#hidJenDokTS").val(fileExtension);
                            $("#hidFileNameTS").val(fileName);

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
                                url: "Transaksi_EOTs.asmx/UploadFileTS",
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

                                    var uploadedFileNameLabel = document.getElementById("uploadedFileNameLabelTS");
                                    uploadedFileNameLabel.appendChild(fileLink);


                                    $("#uploadedFileNameLabelTS").show();
                                    // Clear the file input
                                    $("#fileInputTS").val("");

                                    $("#progressContainerTS").text("   Fail berjaya dimuatnaik.");
                                },
                                error: function () {
                                    $("#progressContainerTS").text("Muatnaik fail tidak berjaya.");
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
                notification("Sila pilih fail untuk muatnaik.");
            }
        }

      

    </script>


</asp:Content>
