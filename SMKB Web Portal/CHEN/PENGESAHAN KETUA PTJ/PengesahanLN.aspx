<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="PengesahanLN.aspx.vb" Inherits="SMKB_Web_Portal.PengesahanLN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
<style>
    .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
            color: #000;
            font-weight: bold;
            background-color: #FFC83D;
        }

        .tab-pane {
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            border-radius: 0px 0px 5px 5px;
            padding: 10px;
        }

        .nav-tabs .nav-link {
            padding: 0.25rem 0.5rem;
        }
        #tblDataSenarai td:hover {
        cursor: pointer;
        }

        .ui.search.dropdown {
        height: 40px;
        }

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

        .input-group__label_td {
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

        .input-group__input_td {
            width: 100%;
            height: 40px;
            border: 1px solid #dddddd;
            border-radius: 5px;
            padding: 0 10px;
        }

        .input-group__input_RM {
            width: 100%;
            text-align :right;
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

        .input-group__subTitle_lable {
            background-color: white;
            line-height: 10px;
            opacity: 1;
            font-size: 15px;
            top: -5px;
        }
        .btn-change1{
            height: 50px;
            width: 150px;
            background: #FFC83D;
            margin: 20px;
            float: left;
            border: 0px;
            color: #000;
            box-shadow: 0 0 1px #ccc;
            -webkit-transition-duration: 0.5s;
            -webkit-box-shadow: 0px 0px 0 0 #31708f inset , 0px 0px 0 0 #31708f inset;
        }
        .btn-change1:hover{
            -webkit-box-shadow: 50px 0px 0 0 #31708f inset , -50px 0px 0 0 #31708f inset;
        }

        .btn-change{
            height: 40px;
            width: 170px;
            background: #007bff;
            margin: 20px;
            float: left;
            box-shadow: 0 0 1px #ccc;
            -webkit-transition: all 0.5s ease-in-out;
            border: 0px;
            border-radius: 8px;
            color: #FFF;
        }
        .btn-change:hover{
            -webkit-transform: scale(1.1);
            background: #007bff;
             color: white;

        }

        .nav-tabs .nav-item.show .nav-link, .nav-tabs .nav-link.active {
            color: #000;
            font-weight:normal;
            background-color: #FFC83D;
        }

        .tab-pane {
            border-left: 1px solid #ddd;
            border-right: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            border-radius: 0px 0px 5px 5px;
            padding: 10px;
        }

        .nav-tabs .nav-link {
            padding: 0.25rem 0.5rem;
        }       

        #Num{
            width: 50px;
        }
        .custom-select{
            background-color: #FFC83D;
        }

    .form-control-checkbox-tbl {
            display: block;
            width: 100%;
            /* height: calc(1.5em + .75rem + 2px); */
            padding: .375rem .75rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #495057;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: .25rem;
            transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    }
    .form-control-input-tbl{
        display: block;
        /* width: 100%; */
        height: calc(1.5em + .75rem + 2px);
        padding: .375rem .75rem;
        font-size: 1rem;
        font-weight: 400;
        line-height: 1.5;
        color: #495057;
        background-color: #fff;
        background-clip: padding-box;
        border: 1px solid #ced4da;
        border-radius: .25rem;
        transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
    }

</style>

    <!-- Create the dropdown filter -->
<div class="search-filter">
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
            <div class="col-md-12">
                <div class="form-row">
                    <div class="form-group col-md-6"> 
                        <input type="date" id="txtTarikhStart" name="txtTarikhStart" style="display:none;" class="input-group__input form-control input-sm">
                        <label class="input-group__label" id="lblMula" for="Mula" style="display:none;">Mula: </label>
                    </div>                                
                    <div class="form-group col-md-6">
                        <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" style="display:none;" class="input-group__input form-control input-sm">
                        <label class="input-group__label" id="lblTamat" for="Tamat" style="display:none;">Tamat: </label>
                    </div>                                        
                </div>
            </div>
        </div>
    </div>
</div>
<%-- tutup filtering--%>


<div class="modal-body">
    <div class="col-sm-12">
        <div class="transaction-table table-responsive">
            <table id="tblDataSenarai" class="table table-striped" style="width:95%">
                <thead>
                    <tr>
                        <th scope="col" style="width: 10%">No. Permohonan</th>
                        <th scope="col" style="width: 10%">Tarikh Mohon</th>
                        <th scope="col" style="width: 30%">Nama Pemohon</th>
                        <th scope="col" style="width: 20%">Tujuan</th>
                        <th scope="col" style="width: 15%">Jumlah Mohon (RM)</th>
                        <th scope="col" style="width: 15%">Status Terkini </th>                                          
                    </tr>
                </thead>
                <tbody id="tableID_SenaraiPermohonan">
                         
                </tbody>

            </table>

        </div>
    </div>                  
</div>

 <div class="modal fade" id="modalSenarai" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
                aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl modal-dialog-scrollable" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalCenterTitle">Maklumat Permohonan</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btnCloseModal">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
 <div class="modal-body">
      <div class="panel panel-default">
          <div class="panel-heading"></div>
              <div class="container"> 
                  <div class="form-row">
                    <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myPersonal">Maklumat Pegawai</button> <asp:Image ID="Image2" runat="server"  AlternateText="Klik Lihat Maklumat Pegawai" ImageUrl="~/assets/icon/info-solid.svg" Height="2%" Width="2%" />
                    <div class="col-sm-12"> 
                        <div class="form-group col-sm-5">  </div>
                    </div>
                </div> 
            </div>
       </div>
<div class="container-fluid"> 
   <ul class="nav nav-tabs" id="myTab" role="tablist">            
        <li class="nav-item" role="presentation"><a class="nav-link active" id="Permohonan" data-toggle="tab"  href="#menu1">Permohonan</a></li>            
        <li class="nav-item" role="presentation"><a class="nav-link" id="tab-Kenyataan" data-toggle="tab" href="#menu2" aria-selected="false">Maklumat Perjalanan</a></li>           
        <li class="nav-item" role="presentation"><a class="nav-link" id="tab-elaunMakan" data-toggle="tab" href="#elaunMakan" aria-selected="false">Elaun Makan/Harian</a></li>
        <li class="nav-item" role="presentation"><a class="nav-link" id="tab-sewaHotel" data-toggle="tab" href="#sewaHotel" aria-selected="false">Sewa Hotel/Lojing</a></li>
        <li class="nav-item" role="presentation"><a class="nav-link" id="tab-pelbagai" data-toggle="tab" href="#pelbagai" aria-selected="false">Pelbagai</a></li>
        <li class="nav-item" role="presentation"><a class="nav-link" id="tab-sumbangan" data-toggle="tab" href="#sumbangan" aria-selected="false">Sumbangan</a></li>
        <li class="nav-item" role="presentation"><a class="nav-link" id="tab-pengesahan" data-toggle="tab" href="#pengesahan" aria-selected="false">Pengesahan</a></li>   
    </ul>  
  
 <div class="tab-content">
      
 <%--content Info Pemohon--%>

  
 <%--content Info Permohonan--%>
      <br />
 <div id="menu1" class="tab-pane fade show active" role="tabpanel" aria-labelledby ="Permohonan">   <%--menu1--%>
    <asp:Panel ID="Panel1" runat="server" >  
        <div class="row">
             <div class="col-md-12"> 
                 <div class="form-row">
                    <div class="form-group col-md-4">                    
                        <input type="text" id="noPermohonan"  class="input-group__input form-control input-md" style="background-color: #f0f0f0"  readonly>
                        <label class="input-group__label" for="No.Permohonan" >No.Permohonan</label>
                    </div>
                    <div class="form-group col-md-4">
                        <select name="ddlTahun" id="ddlTahun"  class="input-group__select ui search dropdown tahun-list" placeholder="&nbsp;"></select>
                        <label class="input-group__label" for="Tahun">Tahun</label>                   
                    </div> 
                    <div class="form-group col-md-4">
                        <select name="ddlBulan" id="ddlBulan"  class="input-group__select ui search dropdown bulan-list" placeholder="&nbsp;"></select>
                        <label class="input-group__label" for="Bulan">Bulan</label>                   
                    </div>
                 </div>
             </div>
        </div>

        <div class="row">
            <div class="col-md-12"> 
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <input type ="hidden" id="selectedNoPendahuluan"/>
                        <input type ="hidden" id="selectedJumlah"/>
                        <input type ="hidden" id="monthInt"/>
                        <input type ="hidden" id="tkhMohonCL"/>
                   </div>
                </div>
            </div>
        </div>        
        <div class="row">
            <div class="col-md-12"> 
                <div class="form-row">
                    <div class="form-group col-md-3">
                        <select name="ddlKumpWang" id="ddlKumpWang"  class="input-group__select ui search dropdown KumWang-list" placeholder="&nbsp;"></select>
                        <label class="input-group__label" for="Kum_wang">Kumpulan Wang</label>              
                    </div>               
                    <div class="form-group col-md-3">
                        <select name="ddlOperasi" id="ddlOperasi"  class="input-group__select ui search dropdown KodOperasi-list" placeholder="&nbsp;"></select> 
                        <label class="input-group__label" for="Kod Operasi"> Kod Operasi</label> 
                    </div>               
                    <div class="form-group col-md-3">
                        <select name="ddlPTJ" id="ddlPTJ"  class="input-group__select ui search dropdown KodPTJ-list" placeholder="&nbsp;"></select>
                        <label class="input-group__label" for="Kod Projek">Kod PTj</label>                 
                    </div>             
                    <div class="form-group col-md-3">
                        <select name="ddlProjek" id="ddlProjek"  class="input-group__select ui search dropdown KodProjek-list" placeholder="&nbsp;"></select> 
                        <label class="input-group__label" for="Kod Projek"> Kod Projek</label>                                                                          
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12"> 
                <div class="form-row">
                    <div class="form-group col-md-4">
                        <textarea rows="2" cols="30" ID="txtTujuanLN" class="input-group__input form-control" placeholder="&nbsp;" MaxLength="500"></textarea>
                        <label class="input-group__label" for="Tujuan">Tujuan Perjalanan</label>
                    </div> 
                    <div class="form-group col-md-2">
                        <input type="date" id="TkhBertolak" class="input-group__input form-control"  placeholder="&nbsp;" onchange="updatedate();">                                       
                        <label class="input-group__label" for="Tarikh Mula">Tarikh Bertolak</label>                                   
                    </div>
                    <div class="form-group col-md-2">
                        <input type="text" ID="txtBertolakDari"  class="input-group__input form-control" placeholder="&nbsp;" ></input>                                     
                        <label class="input-group__label" for="Tempat">Bertolak Dari</label>   
                    </div> 
                    <div class="form-group col-md-2">                               
                       <select id="ddlJamTolakLN" name="ddlJamTolakLN" class="list_ddlJamTolak input-group__select ui search dropdown ">                                        
                           <option value="01">01</option>
                           <option value="02">02</option>
                           <option value="03">03</option>
                           <option value="04">04</option>
                           <option value="05">05</option>
                           <option value="06">06</option>
                           <option value="07">07</option>
                           <option value="08">08</option>
                           <option value="09">09</option>
                           <option value="10">10</option>
                           <option value="11">11</option>
                           <option value="12">12</option>
                           <option value="13">13</option>
                           <option value="14">14</option>
                           <option value="15">15</option>
                           <option value="16">16</option>
                           <option value="17">17</option>
                           <option value="18">18</option>
                           <option value="19">19</option>
                           <option value="20">20</option>
                           <option value="21">21</option>
                           <option value="22">22</option>
                           <option value="23">23</option>
                           <option value="00">00</option> 
                           </select>
                         <label class="input-group__label" for="Jam Bertolak">Jam Bertolak</label>
                    </div>
                    <div class="form-group col-md-2">
                       <select id="ddlMinitTolakLN" class="list_ddlMinitTolakLN input-group__select ui search dropdown">                                        
                            <option value="00">00</option>
                            <option value="10">10</option>
                            <option value="20">20</option>
                            <option value="30">30</option>
                            <option value="40">40</option>
                            <option value="50">50</option>
                            <option value="59">59</option>                                        
                        </select>    
                         <label class="input-group__label" for="Minit Bertolak">Minit Bertolak</label>
                    </div>
                </div>
        </div>
    </div>
    <div class="form-row">
        <h6>&nbsp;&nbsp;Kontra Pendahuluan (jika ada):</h6><br /><br>
    </div>
    <div class="table-title">
        <br />
        <h6> &nbsp;&nbsp;Senarai Pendahuluan Yang Telah Diterima</h6>   
        <hr />   
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="form-row">
                <div class="col-md-12">
                   <div class="transaction-table table-responsive">
                            <table id="tblListPend" class="table table-striped" style="width:98%">
                                <thead>
                                    <tr>
                                       <th><input type="checkbox" name="select_all" value="1" id="example-select-all"></th>
                                        <th scope="col" style="width:25%">No Pendahuluan</th>
                                        <th scope="col" style="width:35%">Program</th>
                                        <th scope="col" style="width:15%">Jumlah Cek (RM)</th>
                                        <th scope="col" style="width:20%">No Baucer</th>                                        
                                    </tr>
                                </thead>
                                <tbody id="tableID_ListPend">                                        
                                </tbody>
                            </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <div class="form-row">
                <div class="form-group col-md-8">
                    <textarea rows="2" cols="45" ID="txtsebab" name="txtsebab" class="input-group__input form-control" placeholder="&nbsp;" MaxLength="500"></textarea>
                    <label class="input-group__label" for="Sebab">Sebab-sebab kelewatan menghantar permohonan (jika ada)</label>
                </div>
            </div>
        </div>
    </div>   
            
   <%-- <div class="form-group col-md-12" align="right">   
        <button id="btnsimpanInfo" type="button" class="btn btn-secondary btnSimpanInfo">Simpan</button>
    </div>--%>
</asp:Panel>

</div>  <%-- Tutup menu1"--%>

 <%--content pnlKenyataan--%>
 <br />
 <div id="menu2" class="tab-pane fade" aria-labelledby="tab-Kenyataan" role="tabpanel">  <%--menu2--%>         
     <asp:Panel ID="pnlKenyataan" runat="server">  
          <div class="col-md-12">        
              <div class="form-row">
                  <div class="form-group col-md-4">
                  <input type="text"  id="txtMohonID"  class="input-group__input form-control" placeholder="&nbsp;" style="background-color:#f3f3f3">
                  <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>                       
                  </div>                    
                  <div class="form-group col-md-3">
                  <input type="date" id="tkhMohon2" class="input-group__input form-control input-sm" style="background-color:#f3f3f3" placeholder="&nbsp;" readonly>                                   
                  <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>                        
                  </div>  
                   <div class="form-group col-md-3">      
                       <div class="form-inline">      
                       <input type="file" id="fileInput" class="input-group__input choose-button"/>
                       <label for="UploadSurat"  class="input-group__label">Upload Lampiran A</label>
                       <input type="button" id="uploadButton" class="btn btn-secondary" value="Muatnaik" onclick="uploadFile()" />
                       <span id="uploadedFileNameLabel" style="display: inline;"></span>
                       <span id="">&nbsp</span>
                       <span id="progressContainer"></span>
                       <input type="hidden" class="form-control"  id="hidJenDok" style="width:300px" readonly="readonly" /> 
                       <input type="hidden" class="form-control"  id="hidFileName" style="width:300px" readonly="readonly" /> 
                       </div> 
                   </div>
             </div>
         </div>              
         
         <div class="modal-body">
           <div>  
               <h7>Kenyataan Tuntutan </h7>             
           </div>
             <br />
           <div class="col-sm-12">
           <div class="transaction-table table-responsive">
               <table id="tblKenyataan" class="table table-striped" style="width:100%">
                   <thead>
                       <tr>                                
                           <th width="5%" rowspan="2"><div align="center">Bil</div></th>
                           <th width="15%" rowspan="2"><div align="center">Jenis Tugas</div></th>
                           <th width="15%" rowspan="2"><div align="center">Negara</div></th>
                           <th width="15%" rowspan="2"><div align="center">Bandar</div></th>
                           <th colspan="2" align="center"><div align="center">Bertolak</div></th>
                           <th colspan="2" align="center"><div align="center">Tiba</div></th>                                                               
                        </tr>
                       <tr>
                           <th width="10%"><div align="center">Tarikh</div></th>
                           <th width="15%"><div align="center">Waktu</div></th>
                           <th width="10%"><div align="center">Tarikh</div></th>
                           <th width="15%"><div align="center">Waktu</div></th>
                       </tr>
                       
                   </thead>
                   <tbody id="tableID_KenyataanTuntutan">
                       <tr style="display:none;">                                
                           <td><input type="text"  ID="txtBil" class="list_Bil form-control-input-tbl" size="5" placeholder="&nbsp;" />  </td>
                           <td>
                               <select class="ui search dropdown JenisTugasLN-list" name="ddlJenisTugasLN" id="ddlJenisTugasLN"></select>
                               <label id="lblJenisTugasLN" name="lblJenisTugasLN" class="label-JenisTugasLN-list" style="text-align: center;visibility: hidden"></label>
                               <label id="HidJenisTugasLN-list" name="HidJenisTugasLN" class="Hid-JenisTugasLN-list" style="visibility: hidden"></label>
                           </td>
                           <td>
                                <select class="ui search dropdown JenisNegara-list" name="ddlJenisNegara" id="ddlJenisNegaraLN1"></select>
                                <label id="lblJenisNegara" name="lblJenisTugasLN" class="label-JenisNegara-list" style="text-align: center;visibility: hidden"></label>
                                <label id="HidJenisNegara-list" name="HidJenisTugasLN" class="Hid-JenisNegara-list" style="visibility: hidden"></label>
                            </td>
                           <td> 
                               <input type="text"  ID="txtBandar" class="list_Bandar form-control-input-tbl" placeholder="&nbsp;" />                                         
                           </td>
                           <td>                                
                               <input type="date" id="tkhBertolak" name="tkhBertolak" class="input-group__input form-control-tkhBertolak-list" placeholder="&nbsp;"> 
                           </td>
                            <td>                                
                                   <select id="ddlJamMula" name="ddlJamMula"  class="list_ddlJamMula input-group__select ui search dropdown3">                                        
                                       <option value="01">01</option>
                                       <option value="02">02</option>
                                       <option value="03">03</option>
                                       <option value="04">04</option>
                                       <option value="05">05</option>
                                       <option value="06">06</option>
                                       <option value="07">07</option>
                                       <option value="08">08</option>
                                       <option value="09">09</option>
                                       <option value="10">10</option>
                                       <option value="11">11</option>
                                       <option value="12">12</option>
                                       <option value="13">13</option>
                                       <option value="14">14</option>
                                       <option value="15">15</option>
                                       <option value="16">16</option>
                                       <option value="17">17</option>
                                       <option value="18">18</option>
                                       <option value="19">19</option>
                                       <option value="20">20</option>
                                       <option value="21">21</option>
                                       <option value="22">22</option>
                                       <option value="23">23</option>
                                       <option value="00">00</option>
                                       </select> :  <select id="ddlMinitMula" class="list_ddlMinitMula input-group__select ui search dropdown3">                                        
                                            <option value="00">00</option>
                                            <option value="10">10</option>
                                            <option value="20">20</option>
                                            <option value="30">30</option>
                                            <option value="40">40</option>
                                            <option value="50">50</option>
                                            <option value="59">59</option>                                        
                                        </select> 
                               </td>
                           <td>
                                <input type="date" id="tkhSampai"  class="input-group__input form-control-tkhSampai-list"  placeholder="&nbsp;">
                           </td>
                            
                           <td><div align="center">
                               <select id="ddlJamSampai"  class="list_ddlJamSampai input-group__select ui search dropdown3">                                        
                                   <option value="01">01</option>
                                   <option value="02">02</option>
                                   <option value="03">03</option>
                                   <option value="04">04</option>
                                   <option value="05">05</option>
                                   <option value="06">06</option>
                                   <option value="07">07</option>
                                   <option value="08">08</option>
                                   <option value="09">09</option>
                                   <option value="10">10</option>
                                   <option value="11">11</option>
                                   <option value="12">12</option>
                                   <option value="13">13</option>
                                   <option value="14">14</option>
                                   <option value="15">15</option>
                                   <option value="16">16</option>
                                   <option value="17">17</option>
                                   <option value="18">18</option>
                                   <option value="19">19</option>
                                   <option value="20">20</option>
                                   <option value="21">21</option>
                                   <option value="22">22</option>
                                   <option value="23">23</option>
                                   <option value="00">00</option>
                               </select>   : 
                                   <select id="ddlMinitSampai" class="list_ddlMinitSampai input-group__select ui search dropdown3">                                        
                                       <option value="00">00</option>
                                       <option value="10">10</option>
                                       <option value="20">20</option>
                                       <option value="30">30</option>
                                       <option value="40">40</option>
                                       <option value="50">50</option>
                                       <option value="59">59</option>                                        
                                   </select>  
                               </div>
                           </td> 
                           
                       </tr>
                      

                   </tbody>                            
                </table>                               

           </div>
           </div>
          

           <div class="row">
               <div class="col-md-8">
                   <div class="btn-group">
                       <button type="button" class="btn btn-warning btnAddRow-tabK font-weight-bold" data-val="1" value="1"><b>+ Tambah</b></button>
                       <button type="button" class="btn btn-warning dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                           <span class="sr-only">Toggle Dropdown</span>
                       </button>
                       <div class="dropdown-menu">
                           <a class="dropdown-item btnAddRow-tabK five" value="5" data-val="5">Tambah 5</a>
                           <a class="dropdown-item btnAddRow-tabK" value="10" data-val="10">Tambah 10</a>

                       </div>
                   </div>
               </div>
            </div>

       <div class="form-row">
       <%--<div class="form-group col-md-6">
       <asp:LinkButton id="lbtnKembali" class="btn btn-primary" runat="server" onclick="lbtnKembali_Click"><i class="las la-angle-left"></i>Kembali</asp:LinkButton>
       </div>--%>
           <div class="form-group col-md-12" align="right">
               <button type="button" class="btn btn-danger btnReset" onclick="btnReset()">Hapus</button>
               <button id="btnSaveKenyataan" type="button" class="btn btn-secondary btnSimpan2" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
           </div>
       </div>
       </div>

         <div><h6 style="color: #FF3300; font-size:12px">Klik Senarai Tuntutan untuk senarai tuntutan yang layak</h6></div>
           <div><h6 style="color: #FF3300; font-size:12px">Klik butang Tambah untuk menambah baik Kenyataan Tuntutan</h6></div>
           <div><h6 style="color: #FF3300; font-size:12px">Klik butang Hapus untuk hapus Kenyataan Tuntutan</h6></div>
     </asp:Panel>

</div>  <%--Tutup KenyataanTab--%>

<%--content tab-3--%> 
 <div id="elaunMakan" class="tab-pane fade" aria-labelledby="tab-elaunMakan" role="tabpanel"> <%--menu 5--%>
   <asp:Panel ID="Panel2" runat="server">  
        <div class="row">
           <div class="col-md-12">
               <div class="form-row">
                   <div class="form-group col-md-3 form-inline">                                       
                   <input type="checkbox" name="checkfield" id="chkHarian" value="false" />&nbsp;&nbsp;
                   <label id="ElaunHarian" for="Transit">Elaun Harian</label> 
                   </div>
               </div>
           </div>
       </div>
       <div class="row">
            <div class="col-md-12">
               <div class="form-row">  
                    <div class="form-group col-md-3">
                        <input type="text"  id="txtMohonID5"  class="input-group__input form-control" placeholder="&nbsp;" style="background-color:#f3f3f3">
                        <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>                       
                    </div> 
                   
                    <div class="form-group col-md-3">
                        <input type="date" id="tkhMohon5" class="input-group__input form-control" style="background-color:#f3f3f3" placeholder="&nbsp;" readonly>                                   
                        <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>                        
                    </div> 

                   <div class="form-group col-md-3">
                       <select class="input-group__select ui search dropdown" placeholder="Sila Pilih" name="ddlNamaNegara" id="ddlNamaNegara"></select>
                       <label class="input-group__label"  for="Nama Negara">Nama Negara</label>   
                   </div>

                   <div class="form-group col-md-3">
                       <select class="input-group__select ui search dropdown" name="ddlJenisTugasEM" id="ddlJenisTugasEM" placeholder="&nbsp;"></select>
                       <label class="input-group__label"  for="JenisTugas">Jenis Tugas</label>                  
                   </div>  
                   
                </div>
           </div> 
       </div>
      
       <div class="row">
            <div class="col-md-12">  
                <div class="form-row">
                   <div class="form-group col-md-3">
                       <select  class="input-group__select ui search dropdown mataWang-list" name="ddlmataWang" id="ddlmataWang" placeholder="&nbsp;"></select>
                       <label class="input-group__label"  for="Mata Wang">Mata Wang</label>
                   </div>                          
                    <div class="form-group col-md-3">
                        <input type="text"  ID="txtKadar" class="input-group__input form-control input-sm"  placeholder="&nbsp;" />  
                        <label class="input-group__label" for="Kadar">Kadar Pertukaran</label>
                   </div>                        
                    <div class="form-group col-md-3">
                       <input type="hidden"  ID="txtHidID_EM"  class="input-group__input form-control input-sm" placeholder="&nbsp;" /> 
                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="https://www.bnm.gov.my/index.php?tpl=exchangerates" Target="_blank">semak kadar</asp:HyperLink> 
                   </div>
                   <div class="form-group col-md-3">      
                       <div class="form-inline">      
                       <input type="file" id="fileInputRujukan" class="input-group__input choose-button"/>
                       <label for="UploadBelanja"  class="input-group__label">Muatnaik Rujukan/No.Invoice</label><br />
                       <input type="button" id="uploadRujukan" class="btn btn-secondary" value="Muatnaik" onclick="uploadFileRujukan()" />
                       <span id="uploadedFileNameLabelRujukan" style="display: inline;"></span>
                       <span id="">&nbsp</span>
                       <span id="progressContainerRujukan"></span>
                       <input type="hidden" class="form-control"  id="hidJenDokRujukan" style="width:300px" readonly="readonly" /> 
                       <input type="hidden" class="form-control"  id="hidFileNameRujukan" style="width:300px" readonly="readonly" /> 
                       </div> 
                   </div>
                
                </div>
             </div>                 
       </div>

       <div class="row">
            <div class="col-md-12">  
                <div class="form-row">
                     <div class="form-group col-md-2">
                        <input type="date" id="tkhMula" name="tkhMula" class="input-group__input form-control" placeholder="&nbsp;"> 
                        <label class="input-group__label" for="Tarikh Mula">Tarikh Mula</label>
                    </div>
                    <div class="form-group col-md-2">
                        <input type="date" id="tkhTamat"  class="input-group__input form-control"  placeholder="&nbsp;">
                        <label class="input-group__label" for="Tarikh Akhir">Tarikh Akhir</label>
                    </div>

                    <div class="form-group col-md-2">
                           <select id="ddlJamMula1" name="ddlJamMula1" class="input-group__select ui search dropdown" placeholder="Jam">                                        
                           <option value="01">01</option>
                           <option value="02">02</option>
                           <option value="03">03</option>
                           <option value="04">04</option>
                           <option value="05">05</option>
                           <option value="06">06</option>
                           <option value="07">07</option>
                           <option value="08">08</option>
                           <option value="09">09</option>
                           <option value="10">10</option>
                           <option value="11">11</option>
                           <option value="12">12</option>
                           <option value="13">13</option>
                           <option value="14">14</option>
                           <option value="15">15</option>
                           <option value="16">16</option>
                           <option value="17">17</option>
                           <option value="18">18</option>
                           <option value="19">19</option>
                           <option value="20">20</option>
                           <option value="21">21</option>
                           <option value="22">22</option>
                           <option value="23">23</option>
                           <option value="00">00</option>
                           </select>  
                            <label class="input-group__label" for="Jam Mula">Jam Mula</label>
                        </div>
                     
                     <div class="form-group col-md-2">  
                       <select id="ddlMinitMula2" class="list_ddlMinitMula2 input-group__select ui search dropdown" placeholder="Minit">                                        
                               <option value="00">00</option>
                               <option value="10">10</option>
                               <option value="20">20</option>
                               <option value="30">30</option>
                               <option value="40">40</option>
                               <option value="50">50</option>
                               <option value="59">59</option>                                        
                        </select>
                           <label class="input-group__label" for="Minit Mula">Minit Mula</label>
                           
                    </div>

                    <div class="form-group col-md-2">
                       <select id="ddlJamSampai2"   class="input-group__select ui search dropdown tempatlist" placeholder="&nbsp;">                                        
                       <option value="00">Pilih Jam</option>
                       <option value="01">01</option>
                       <option value="02">02</option>
                       <option value="03">03</option>
                       <option value="04">04</option>
                       <option value="05">05</option>
                       <option value="06">06</option>
                       <option value="07">07</option>
                       <option value="08">08</option>
                       <option value="09">09</option>
                       <option value="10">10</option>
                       <option value="11">11</option>
                       <option value="12">12</option>
                       <option value="13">13</option>
                       <option value="14">14</option>
                       <option value="15">15</option>
                       <option value="16">16</option>
                       <option value="17">17</option>
                       <option value="18">18</option>
                       <option value="19">19</option>
                       <option value="20">20</option>
                       <option value="21">21</option>
                       <option value="22">22</option>
                       <option value="23">23</option>
                       <option value="00">00</option>
                       </select>  
                         <label class="input-group__label" for="Jam Mula">Jam Akhir</label>
                        </div>
                     
                         <div class="form-group col-md-2">
                           <select id="ddlMinitSampai2" class="list_ddlMinitSampai2 input-group__select ui search dropdown">                                        
                           <option value="00">00</option>
                           <option value="10">10</option>
                           <option value="20">20</option>
                           <option value="30">30</option>
                           <option value="40">40</option>
                           <option value="50">50</option>
                           <option value="59">59</option>                                        
                          </select>  
                              <label class="input-group__label" for="MInit Akhir">Minit Akhir</label>
                    </div>
                </div>
            </div>
       </div>

       <div class="row">
          <div class="col-md-12">  
              <div class="form-row">
                    <div class="form-group col-md-3 form-inline">                                       
                       <input type="checkbox" name="checkfield" id="chkDN" value="true" />&nbsp;&nbsp;
                       <label id="lblTransit" for="Transit">Transit Melebihi 6 Jam</label> 
                   </div>
              </div>
          </div>
        </div>
       
   <panel id="transit" style="display:none;">                        
           <div class="row">
               <div class="col-md-12">  
                   <div class="form-row">
                       <div class="form-group col-md-2">
                           <input type="date" id="tkhTransitMula" name="tkhTransitMula" class="input-group__input form-control" placeholder="&nbsp;"> 
                           <label class="input-group__label" for="tkhTransitMula">Tarikh Tiba</label>
                       </div>
                           <div class="form-group col-md-2">
                           <input type="date" id="tkhTransitTamat"  class="input-group__input form-control"  placeholder="&nbsp;">
                           <label class="input-group__label" for="Tarikh Bertolak">Tarikh Bertolak</label>
                       </div>
                       <div class="form-group col-md-2">
                           <select id="ddlJamTransitMula" name="ddlJamTransitMula" class="input-group__select ui search dropdown" placeholder="&nbsp;">                                        
                           <option value="01">01</option>
                           <option value="02">02</option>
                           <option value="03">03</option>
                           <option value="04">04</option>
                           <option value="05">05</option>
                           <option value="06">06</option>
                           <option value="07">07</option>
                           <option value="08">08</option>
                           <option value="09">09</option>
                           <option value="10">10</option>
                           <option value="11">11</option>
                           <option value="12">12</option>
                           <option value="13">13</option>
                           <option value="14">14</option>
                           <option value="15">15</option>
                           <option value="16">16</option>
                           <option value="17">17</option>
                           <option value="18">18</option>
                           <option value="19">19</option>
                           <option value="20">20</option>
                           <option value="21">21</option>
                           <option value="22">22</option>
                           <option value="23">23</option>
                           <option value="00">00</option>

                           </select> 
                           <label class="input-group__label" for="Jam Mula">Jam Tiba</label>
                           </div>
                           <div class="form-group col-md-2">
                           <select id="ddlMinitTransitMula" class="ddlMinitTransitMula input-group__select ui search dropdown">                                        
                           <option value="00">00</option>
                           <option value="10">10</option>
                           <option value="20">20</option>
                           <option value="30">30</option>
                           <option value="40">40</option>
                           <option value="50">50</option>
                           <option value="59">59</option>                                        
                           </select>
                          <label class="input-group__label" for="Minit Mula">Minit Tiba</label>
                                  
                       </div>
                       <div class="form-group col-md-2">                               
                           <select id="ddlJamTransitTolak" class="input-group__select ui search dropdown ddlJamTransitSampai" placeholder="&nbsp;">                                        
                               <option value="01">01</option>
                               <option value="02">02</option>
                               <option value="03">03</option>
                               <option value="04">04</option>
                               <option value="05">05</option>
                               <option value="06">06</option>
                               <option value="07">07</option>
                               <option value="08">08</option>
                               <option value="09">09</option>
                               <option value="10">10</option>
                               <option value="11">11</option>
                               <option value="12">12</option>
                               <option value="13">13</option>
                               <option value="14">14</option>
                               <option value="15">15</option>
                               <option value="16">16</option>
                               <option value="17">17</option>
                               <option value="18">18</option>
                               <option value="19">19</option>
                               <option value="20">20</option>
                               <option value="21">21</option>
                               <option value="22">22</option>
                               <option value="23">23</option>
                               <option value="00">00</option>
                           </select>   
                            <label class="input-group__label" for="Jam Bertolak">Jam Bertolak</label>
                       </div>
                       <div class="form-group col-md-2">
                           <select id="ddlMinitTransitTolak" class="ddlMinitTransitSampai input-group__select ui search dropdown">                                        
                           <option value="00">00</option>
                           <option value="10">10</option>
                           <option value="20">20</option>
                           <option value="30">30</option>
                           <option value="40">40</option>
                           <option value="50">50</option>
                           <option value="59">59</option>                                        
                           </select>  
                           <label class="input-group__label" for="Minit Bertolak">Minit Bertolak</label>
                       </div>      
         
                   </div>
               </div>
           </div>
  </panel>

   <div class="row">
       <div class="col-md-12">  
           <div class="form-row">
                <div class="form-group col-md-4">
                    <input type="text"  ID="txtBilHari" class="input-group__input form-control input-sm"  placeholder="&nbsp;" style="text-align:right; font-weight: bold;" readonly/>  
                    <label class="input-group__label" for="Bil hari">Jumlah Hari</label>
               </div>
               <div class="form-group col-md-4">
                   <input type="text"  ID="txtElaunHarian" class="input-group__input form-control input-sm"  placeholder="&nbsp;" style="text-align:right; font-weight: bold;" readonly />  
                   <label class="input-group__label" for="Bil hari">Elaun Sehari (RM)</label>
               </div>
               <div class="form-group col-md-4">
                   <input type="text"  ID="txtJumlahEH" class="input-group__input form-control input-sm"  placeholder="&nbsp;"  style="text-align:right; font-weight: bold;" readonly/>  
                   <label class="input-group__label" for="Jumlah Elaun Harian">Jumlah Keseluruhan (RM)</label>
               </div>


           </div>
       </div>
    </div>

   <div class="row">
       <div class="col-md-12">
           <div class="form-row">
               <div class="form-group col-md-12" align="right">                     
                   <button id="btnSimpantab5" type="button" class="btn btn-secondary btnSimpantab5" data-toggle="tooltip" data-placement="bottom" title="Draft" >Simpan</button>
               </div>
           </div>
       </div>
   </div>
  
   <div class="modal-body">
   <div class="col-md-12">
       <br />
       <br />
      <div class="transaction-table table-responsive">
       <table id="tblElaunMakan" class="table table-striped" style="width:100%">
           <thead>
               <tr>
                   <th scope="col"  style="width:5%">No</th>
                   <th scope="col"  style="width:10%">Rujukan</th>
                   <th scope="col"  style="width:10%">Mata Wang</th>                        
                   <th scope="col"  style="width:10%">Kadar Pertukaran</th> 
                   <th scope="col"  style="width:5%">Jumlah Hari</th>
                   <th scope="col"  style="width:10%">Makan Pagi(20%)</th>
                   <th scope="col"  style="width:20%">Makan T/hari(40%)></th>
                   <th scope="col"  style="width:20%">Makan Malam(40%)</th>
                   <th scope="col"  style="width:10%">Jumlah (RM)</th>
                  </tr>
               
           </thead>
           <tbody id="tblElaunMakan-list">                                        
           </tbody>
       </table>
       </div>
   </div>
   <div class="col-md-12">
       <input type ="hidden" id="hidTotalEM" />
   </div>

   </div>
 </asp:Panel>
</div>  <%--tutup tab-elaunmakan--%>

    <div id="sewaHotel" class="tab-pane fade" aria-labelledby="tab-sewaHotel" role="tabpanel">   <%--menu 6--%>
         <asp:Panel ID="Panel3" runat="server" > 
              <div class="col-md-12">        
                 <div class="form-row">
                 <div class="form-group col-md-3">
                 <input type="text"  id="txtMohonID6"  class="input-group__input form-control" placeholder="&nbsp;" style="background-color:#f3f3f3">
                 <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>                       
                 </div>  
                  <div class="form-group col-md-3">
                    <select  class="input-group__select ui search dropdown ddlNegaraTuju-list" name="ddlNegaraTuju" id="ddlNegaraTuju" placeholder="&nbsp;"></select>
                    <label class="input-group__label"  for="Nama Negara">Nama Negara</label>                       
                   </div>   
                   <div class="form-group col-md-3">
                        <select  class="input-group__select ui search dropdown mataWangHotel-list" name="mataWangHotel" id="mataWangHotel" placeholder="&nbsp;"></select>
                        <label class="input-group__label"  for="Mata Wang">Mata Wang</label>
                    </div> 
                     <div class="form-group col-md-3">
                       <input type="text"  ID="kadarPertukaran" class="input-group__input form-control input-sm"  placeholder="&nbsp;" />  
                       <label class="input-group__label" for="Kadar">Kadar Pertukaran</label>
                    <%--<input type="date" id="tkhMohon6" class="input-group__input form-control input-sm" style="background-color:#f3f3f3" placeholder="&nbsp;" readonly>                                   
                    <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>     --%>                   
                    </div>  
                 </div>
            </div>  

            <div class="modal-body">
                  <div>
                      <h8>Tuntutan Bayaran Sewa Hotel </h8>         
                  </div>                 
                <div>
                    <div class="row">
    <div class="col-md-12">
        <div class="transaction-table table-responsive">
            <table class="table table-striped" id="tblSewaHotel" style="width: 100%;">
                <thead>
                    <tr style="width: 100%; text-align: center;">
                        <th scope="col" style="width: 5%;vertical-align:middle; text-align: left;">No</th>
                        <th scope="col" style="width: 15%;vertical-align:middle">Jenis Tugas</th>  
                        <th scope="col" style="width: 15%;vertical-align:middle">No Resit</th>
                        <th scope="col" style="width: 10%;vertical-align:middle">Hari</th>
                        <th scope="col" style="width: 15%;vertical-align:middle">Elaun(RM)/Hari</th> 
                        <th scope="col" style="width: 15%;vertical-align:middle">Amaun Tuntutan (RM)</th>
                        <th scope="col" style="width: 10%;vertical-align:middle">Upload Resit</th> 
                        <th scope="col" style="width: 15%;vertical-align:middle"></th> 
                    </tr>
                </thead>
                <tbody id="tblSewaHotelData">
                   
                <tr class="table-list" width: 100%" style="display:none;">
                    <td>
                    <input type="text" class="form-control input-md-txtBiltblHotel-list" id="txtBiltblHotel" style="background-color:#f3f3f3;font-size:small" >
                    <label class="lblBiltblHotel-list" id="lblBiltblHotel" name="bilhotel"></label>
                    </td>
                    <td>                                                      
                    <select class="ui search dropdown ddlJenisTugastblHotel-list" name="ddlJenisTugastblHotel" id="ddlJenisTugastblHotel"></select>
                    <input type="hidden" class="hidBil" value="" />                                     
                    <label id="lblJenisTugastblHotel" name="lblJenisTugastblHotel" class="label-JenisTugastblHotel-list" style="text-align: center;visibility: hidden"></label>
                    <label id="HidJenisTugastblHotel" name="HidJenisTugastblHotel" class="Hid-JenisTugastblHotel-list" style="visibility: hidden"></label>
                    </td>

                    <%--<td>                                                      
                    <select  class="ui search dropdown mataWangHotel-list" name="mataWangHotel" id="mataWangHotel" placeholder="&nbsp;"></select>
                    </td>--%>

                    <%--<td>
                    <input type="text" class="form-control input-md kdrPertukaran-list" id="kadarPertukaran" style="background-color:#f3f3f3;font-size:small;text-align: right; font-weight: bold" >
                    </td>--%>

                    <td>
                    <input type="text" class="form-control input-md resittblHotel-list" id="resittblHotel" style="font-size:small" >
                    <label class="lblresittblHotel-list" id="lblresittblHotel" name="lblresittblHotel"></label>
                    </td>

                     <td>
                     <input type="text" class="form-control input-md haritblHotel-list" id="haritblHotel" style="font-size:small" >
                     <label class="lblharitblHotel-list" id="lblharitblHotel" name="lblharitblHotel"></label>
                     </td>
                    
                    <td>
                    <input type="text" class="form-control input-md elauntblHotel-list" id="elauntblHotel" disabled="disabled" style="background-color:#f3f3f3;font-size:small;text-align: right; font-weight: bold">
                    <label class="lblelauntblHotel-list" id="lblelauntblHotel" name="lblelauntblHotel"></label>
                    </td>

                    <td>
                    <input type="text" class="form-control input-md amauntblHotel-list" id="amauntblHotel" style="background-color:#f3f3f3;font-size:small;text-align: right; font-weight: bold">
                    <label class="lblamauntblHotel-list" id="lblamauntblHotel" name="lblamauntblHotel"></label>
                    </td> 
                    
                    <td>                        
                     <div class="input-group col-md-8">    
                     <div class="form-inline">
                        <input type="file" id="fileInputHotel" class="fileInputHotel" style="width:250px" />
                         <a href ="#" class="tempFileHotel" target="_blank"></a>                                           
                        <span id="uploadResitHotel" style="display: inline;"></span>
                        <span id="">&nbsp</span>
                        <span id="progressContainer3"></span>
                        <input type ="hidden" id="txtNamaFileHotel" />
                        <input type="hidden" class="form-control"  id="hidFolderHotel" style="width:200px" readonly="readonly" /> 
                        <input type="hidden" class="form-control"  id="hidFileNameHotel" style="width:200px" readonly="readonly" /> 
                        </div>         
                    </div>
                    </td>
                    <td> 
                             <button id="btnSimpanTH" runat="server" class="btn btnSimpanHotel"  type="button" style="color: blue">
    <i class="fa fa-floppy-o"></i></button>
                         <%--<input type="button" class="btn btn-secondary btnSimpanTH" onclick="return SimpanTH(this);" id="btnSimpanTH" value="Simpan" />--%>
                        <button id="lbtnCari" runat="server" class="btn btnDeleteHotel" type="button" style="color: red">
    <i class="fa fa-trash"></i>
</button>
     
                    </td>
   

                </tr >

                </tbody>    
                    <tfoot>
                    <tr>
                        <td colspan="3"></td>
                        <td colspan="2"  style="text-align: right">
                            <%--<input class="form-control underline-input" id="totalDbt" name="totalDbt" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />--%>
                            <label style="font-size:medium;text-align:left"> Jumlah (RM) </label>
                        </td>
                        <td>
                            <input class="form-control underline-input" id="totaltblHotel" name="totaltblHotel" style="text-align: right; font-weight: bold" width="8%" value="0.00" readonly /></td>
                        <td colspan="1"></td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <div class="btn-group">
                                <button type="button" class="btn btn-warning btnAddRow-tabHotel One" data-val="1" value="1"><b>+ Tambah</b></button>
                                <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    <span class="sr-only">Toggle Dropdown</span>
                                </button>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item btnAddRow-tabHotel five" value="5" data-val="5">Tambah 5</a>
                                    <a class="dropdown-item btnAddRow-tabHotel" value="10" data-val="10">Tambah 10</a>

                                </div>
                            </div>
                        </td>
                    </tr>
                    </tfoot>
            </table>

            <%--<div class="form-row"> 
<div class="form-group col-md-12" align="right">                     
<button id="btnSimpanHotel" type="button" class="btn btn-secondary btnSimpanHotel" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
</div>
</div>--%>

        </div>

        

        
        </div>
    
    </div>

<div class="row">
     <div>
         <br />
     <h8>&nbsp;&nbsp;Tuntutan Bayaran Elaun Penginapan Lojing</h8>         
 </div>
<div class="col-md-12">
    <div class="transaction-table table-responsive">
        
        <table class="table table-striped" id="tblLojing" style="width: 100%;">
            <thead>
                <tr style="width: 100%; text-align: center;">
                    <th scope="col" style="width: 5%;vertical-align:middle; text-align: left;">No</th>
                    <th scope="col" style="width: 15%;vertical-align:middle">Jenis Tugas</th>                    
                    <th scope="col" style="width: 15%;vertical-align:middle">No Resit</th>                     
                    <th scope="col" style="width: 10%;vertical-align:middle">Hari</th>
                    <th scope="col" style="width: 15%;vertical-align:middle">Elaun(RM)/Hari</th>
                    <th scope="col" style="width: 15%;vertical-align:middle">Amaun Tuntutan (RM)</th>
                     <th scope="col" style="width:10%;vertical-align:middle">Upload Resit</th> 
                     <th scope="col" style="width:15%;vertical-align:middle"></th> 
                </tr>
            </thead>
            <tbody id="tblLojingData">
                <tr class="table-list" width: 100%" style="display:none;">
                    <td>
                    <input type="text" class="form-control input-md-txtBiltblLojing" id="txtBiltblLojing" style="background-color:#f3f3f3;font-size:small" >
                    <label class="lblAmaun" id="lblBiltblLojing" name="bilhotel"></label>
                    </td>
                    <td>                                                      
                    <select class="ui search dropdown ddlJenisTugastblLojingA-list" name="ddlJenisTugastblLojing" id="ddlJenisTugastblLojing"></select>
                     <input type="hidden" class="hidBilLojing" value="" />                                       
                    <label id="lblJenisTugastblLojing" name="lblJenisTugastblLojing" class="label-JenisTugastblLojing-list" style="text-align: center;visibility: hidden"></label>
                    <label id="HidJenisTugastblLojing" name="HidJenisTugastblLojing" class="Hid-JenisTugastblLojing-list" style="visibility: hidden"></label>
                    </td>                    
                    <td>
                    <input type="text" class="form-control input-md resittblLojing" id="resittblLojing" style="font-size:small" >
                    <label class="resit-list" id="lblresittblLojing" name="lblresittblLojing"></label>
                    </td>
                    <td>
                    <input type="text" class="form-control input-md haritblLojing-list" id="haritblLojing" style="font-size:small" >
                    <label class="lblharitblLojing-list" id="lblharitblLojing" name="lblharitblLojing"></label>
                    </td>
                    <td>
                    <input type="text" class="form-control input-md elauntblLojing-list" id="elauntblLojing" disabled="disabled" style="background-color:#f3f3f3;font-size:small;text-align: right; font-weight: bold">
                    <label class="lblAmaunLojing-list" id="lblelauntblLojing" name="lblelauntblLojing"></label>
                    </td>
                    <td>
                    <input type="text" class="form-control input-md amauntblLojing-list" id="amauntblLojing" style="background-color:#f3f3f3;font-size:small;text-align: right; font-weight: bold">
                    <label class="lblAmaunLojing-list" id="lblamauntblLojing" name="lblamauntblLojing"></label>
                    </td> 
                    
                   <td>                        
                     <div class="input-group col-md-10">    
                     <div class="form-inline">
                        <input type="file" id="fileInputLojing" class="fileInputLojing" style="width:250px" />
                         <a href ="#" class="tempFileLojing" target="_blank"></a>                                           
                        <span id="uploadResitLojing" style="display: inline;"></span>
                        <span id="">&nbsp</span>
                        <span id="progressContainer4"></span>
                        <input type ="hidden" id="txtNamaFileLojing" />
                        <input type="hidden" class="form-control"  id="hidFolderLojing" style="width:200px" readonly="readonly" /> 
                        <input type="hidden" class="form-control"  id="hidFileNameLojing" style="width:200px" readonly="readonly" /> 
                        </div>         
                    </div>
                    </td>

                    <td> 
                        <button id="Button3" runat="server" class="btn btnSimpanLojing"   type="button" style="color: blue">
                        <i class="fa fa-floppy-o"></i></button>
                        <%--<input type="button" class="btn btn-secondary btnSimpanTH" onclick="return SimpanTH(this);" id="btnSimpanTH" value="Simpan" />--%>
                        <button id="Button4" runat="server" class="btn btnDelLojing" type="button" style="color: red">
                        <i class="fa fa-trash"></i>
                        </button>
     
                    </td>

 
                </tr >

            </tbody>    
                <tfoot>
                <tr>                    
                    
                    <td colspan="3"></td>
                   
                    <td colspan="2"  style="text-align: right">
                        <%--<input class="form-control underline-input" id="totalDbt" name="totalDbt" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />--%>
                        <label style="font-size:medium; align-items:end"> Jumlah (RM) </label>
                    </td>
                    <td>
                        <input class="form-control underline-input" id="totalTblLojing" name="totalTblLojing" style="text-align: right; font-weight: bold" width="8%" value="0.00" readonly /></td>
                    <td colspan="1"></td>
                </tr>
                    
                <tr>
                    <td colspan="8">
                        <div class="btn-group">
                            <button type="button" class="btn btn-warning btnAddRow-tabLojing One" data-val="1" value="1"><b>+ Tambah</b></button>
                            <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="sr-only">Toggle Dropdown</span>
                            </button>
                            <div class="dropdown-menu">
                                <a class="dropdown-item btnAddRow-tabLojing five" value="5" data-val="5">Tambah 5</a>
                                <a class="dropdown-item btnAddRow-tabLojing" value="10" data-val="10">Tambah 10</a>

                            </div>
                        </div>
                    </td>
                </tr>
                </tfoot>
        </table>
    </div>
    </div>
</div>
              
</div> 
        <%--<div class="form-row"> 
            <div class="form-group col-md-12" align="right">                     
                <button id="btnSimpanLojing" type="button" class="btn btn-secondary btnSimpanLojing" data-toggle="tooltip" data-placement="bottom" title="Draft">Simpan</button>
            </div>
        </div>--%>
                  
              
             
</div>    
      
                 
    </asp:Panel>
  </div>

      <div id="pelbagai" class="tab-pane fade" aria-labelledby="tab-pelbagai" role="tabpanel">   <%--menu 7--%>
      <asp:Panel ID="Panel5" runat="server" >    
            <div class="col-md-12">        
                 <div class="form-row">
                 <div class="form-group col-md-3">
                 <input type="text"  id="txtMohonID7"  class="input-group__input form-control" placeholder="&nbsp;" style="background-color:#f3f3f3">
                 <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>                       
                 </div>                    
                <%-- <div class="form-group col-md-3">
                 <input type="date" id="tkhMohon7" class="input-group__input form-control input-sm" style="background-color:#f3f3f3" placeholder="&nbsp;" readonly>                                   
                 <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>                        
                 </div> --%>
                 <div class="form-group col-md-3">
                  <select  class="input-group__select ui search dropdown ddlNegaraTuju-Pelbagai" name="ddlNegaraTujuP" id="ddlNegaraTujuP" placeholder="Pilih Negara"></select>
                  <label class="input-group__label"  for="Nama Negara">Nama Negara</label>                       
                  </div>
                  <div class="form-group col-md-3">
                     <select  class="input-group__select ui search dropdown mataWangPelbagai-list" name="mataWangPelbagai" id="mataWangPelbagai" placeholder="&nbsp;"></select>
                     <label class="input-group__label"  for="Mata Wang">Mata Wang</label>
                 </div> 
                
                 </div>
            </div>   
      <div class="modal-body">
          <div>
              <h8>Tuntutan Pelbagai</h8>
              <br />
          </div>
        <br />
      <div>                           
      <div class="row">
          <div class="col-md-12">
              <div class="transaction-table table-responsive">
                   <table class="table table-striped" id="tblPelbagai" style="width: 100%;">
     <thead>
         <tr style="width: 100%; text-align: center;">
             <th scope="col" style="width: 5%;vertical-align:middle; text-align: left;">No</th>
             <th scope="col" style="width: 20%;vertical-align:middle; text-align: left;">Jenis Belanja Pelbagai</th>             
             <th scope="col" style="width: 10%;vertical-align:middle">Dengan Resit</th>
             <th scope="col" style="width: 10%;vertical-align:middle">Tanpa Resit</th>
             <th scope="col" style="width: 15%;vertical-align:middle">No Resit</th>
             <th scope="col" style="width: 15%;vertical-align:middle">Amaun(RM)</th> 
             <th scope="col" style="width: 15%;vertical-align:middle">Upload Resit</th> 
             <th scope="col" style="width: 10%;vertical-align:middle"></th> 
         </tr>
     </thead>
     <tbody id="tblPelbagaiList">
            <tr class="table-list" width: 100%" style="display:none;">
                <td>
                    <input type="text" class="form-control input-md-txtBilPelbagai" id="txtBilPelbagai" style="background-color:#f3f3f3;font-size:small" >
                </td>
                <td>                                                      
                    <select class="ui search dropdown JenisPelbagai-list" name="ddlJenisPelbagai" id="ddlJenisPelbagai"></select>
                     <label id="HidlblJenisPelbagai" name="HidlblJenisPelbagai" class="Hid-jenisPelbagai-list" style="visibility: hidden"></label>
                </td>               
                <td style="text-align:center">
                    <input type="checkbox" name="checkbox_DengResitBP" class="checkbox_DengResitBP-list" style="text-align:center; vertical-align: middle;" >
                    <label class="lblDengResitBP-list" id="lblDengResitBP" name="lblDengResitBP"></label>
                </td>
                <td style="text-align:center">
                    <input type="checkbox" name="checkbox_TanpaResitBP" class="checkbox_TanpaResitBP-list"  style="text-align:center; vertical-align: middle;" >
                    <label class="lblTanpaResitBP-list" id="lblTanpaResitBP" name="lblTanpaResitBP"></label>
                </td>
                <td >
                    <center><input type="text" class="form-control input-md-noResitBP" id="noResitBP" name="noResitBP" style="background-color:#fff;font-size:small"></center>
                    <label class="lblnoResitBP-list" id="lblnoResitBP" name="lblnoResitBP"></label>
                </td>
                <td>
                    <input type="text" class="form-control input-md-AmaunBP" id="AmaunBP" style="background-color:#fff;font-size:small;text-align: right" >
                    <label class="lblAmaunBP-list" id="lblAmaunBP" name="lblAmaunBP"></label>
                </td>

               <td>                        
                 <div class="input-group col-md-10">    
                 <div class="form-inline">
                    <input type="file" id="fileInputPelbagai" class="fileInputPelbagai" style="width:250px" />
                     <a href ="#" class="tempFilePelbagai" target="_blank"></a>                                           
                    <span id="uploadPelbagai" style="display: inline;"></span>
                    <span id="">&nbsp</span>
                    <span id="progressContainer2"></span>
                    <input type ="hidden" id="txtNamaFilePelbagai" />
                    <input type="hidden" class="form-control"  id="hidFolderPelbagai" style="width:200px" readonly="readonly" /> 
                    <input type="hidden" class="form-control"  id="hidFileNamePelbagai" style="width:200px" readonly="readonly" /> 
                    </div>         
                </div>
                </td>
                <%--<td> 
                     <input type="button" class="btn btn-secondary btnSimpanTP" onclick="return SimpanTP(this);" id="btnSimpanTP" value="Simpan" />
                </td>--%>

                 <td> 
                         <button id="Button5" runat="server" class="btn btnSimpanPelbagai" type="button" style="color: blue">
                         <i class="fa fa-floppy-o"></i></button>
                         <%--<input type="button" class="btn btn-secondary btnSimpanTH" onclick="return SimpanTH(this);" id="btnSimpanTH" value="Simpan" />--%>
                         <button id="Button6" runat="server" class="btn btnDelPelbagai" type="button" style="color: red">
                         <i class="fa fa-trash"></i>
                         </button>
     
                </td>

            <%--<td class="tindakan">
            <button class="btn btnDelete">
            <i class="fa fa-trash" style="color: red"></i>
            </button>
            <button class="btn"><i class="fa fa-trash"></i> Trash</button>
            </td>--%>
            </tr >

     </tbody>    
         <tfoot>
         <tr>
             <td colspan="3"></td>
             <td colspan="1" style="text-align: right">
                 <%--<input class="form-control underline-input" id="totalDbt" name="totalDbt" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />--%>
                 <label style="font-size:medium; align-items:end"> Jumlah (RM) </label>
             </td>
             <td colspan="1">
                 <input class="form-control underline-input" id="totalRm" name="totalRm" style="text-align: right; font-weight: bold" width="8%" value="0.00" readonly /></td>
             <td colspan="2"></td>
         </tr>
         <tr>
             <td colspan="7">
                 <div class="btn-group">
                     <button type="button" class="btn btn-warning btnAddRow-tabPelbagai One" data-val="1" value="1"><b>+ Tambah</b></button>
                     <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                         <span class="sr-only">Toggle Dropdown</span>
                     </button>
                     <div class="dropdown-menu">
                         <a class="dropdown-item btnAddRow-tabPelbagai five" value="5" data-val="5">Tambah 5</a>
                         <a class="dropdown-item btnAddRow-tabPelbagai" value="10" data-val="10">Tambah 10</a>

                     </div>
                 </div>
             </td>
         </tr>
         </tfoot>
 </table>
              </div>
    <div class="form-row"> 
    <%--<div class="form-group col-md-12" align="right">                     
        <button id="btnSimpantab7" type="button" class="btn btn-secondary btnSimpantab7" data-toggle="tooltip" data-placement="bottom" title="Draft" >Simpan</button>
    </div>--%>
</div>
          </div>

         
      </div>
      </div>

        </div> <%--Tutup Bahagian C modal-body--%>

         </asp:Panel>
     
     </div>

       <div id="sumbangan" class="tab-pane fade" aria-labelledby="tab-sumbangan" role="tabpanel">   <%--menu 7--%>
      <asp:Panel ID="Panel4" runat="server" >    
            <div class="col-md-10">        
                 <div class="form-row">
                 <div class="form-group col-md-5">
                 <input type="text"  id="txtMohonID9"  class="input-group__input form-control" placeholder="&nbsp;" style="background-color:#f3f3f3">
                 <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>                       
                 </div>                    
                 <%--<div class="form-group col-md-3">
                 <input type="date" id="tkhMohon9" class="input-group__input form-control input-sm" style="background-color:#f3f3f3" placeholder="&nbsp;" readonly>                                   
                 <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>                        
                 </div>    --%>            
                 </div>
            </div>   
      <div class="modal-body">
          <div>
              <h8>Sumbangan Tabung</h8>
              <br />
          </div>
        <br />
      <div>                           
    
      <div class="col-md-12"> 
          <div class="transaction-table table-responsive">
    <table  class="table table-striped" id="tblSumbangan" style="width: 100%;">
        <thead>
            <tr style="width: 100%; text-align: center;">
                <th scope="col" style="width: 5%;vertical-align:middle; text-align: left;">Bil</th>
                <th scope="col" style="width: 40%;vertical-align:middle">Nama Tabung</th>
                <th scope="col" style="width: 30%;vertical-align:middle">Jumlah (RM)</th> 
                <th scope="col" style="width: 25%;vertical-align:central">Tindakan</th>
            </tr>
        </thead>
         <tbody id="tblDataSumbangan">
             <tr class="table-list" width: 100%" style="display:none;">
                  <td>
                      <input type="text" class="form-control txtBilSumbangan-list" id="txtBilSumbangan" style="background-color:#f3f3f3;font-size:small" >
                  </td>

                 <td>
                     <select class="ui search dropdown JenisSumbangan-list" name="ddlSumbangan" id="ddlSumbangan"></select>
                     <label id="lblSumbangan" name="lblSumbangan" class="label-jenisSumbangan-list" style="text-align: center;visibility: hidden"></label>
                     <label id="HidlblSumbangan" name="HidlblSumbangan" class="Hid-jenisSumbangan-list" style="visibility: hidden"></label>
                 </td>                                   

                 <td>
                     <input type="text" class="form-control input-md-txtSumbangan" id="txtSumbangan" style="background-color:#fff;font-size:small;text-align: right" >
                 </td>
                 
                 <td style="text-align:center">
                     
                      <%--<input type="button" class="btn btn-secondary btnSimpanTH" onclick="return SimpanTH(this);" id="btnSimpanTH" value="Simpan" />--%>
                      <button id="btnDeSumbangan" runat="server" class="btn btnDeSumbangan" type="button" style="color: red">
                      <i class="fa fa-trash"></i>
                      </button>
                 </td>        

             </tr>
         </tbody>
        <tfoot>
            <tr>
               
                <td colspan="2" style="text-align: right">
                    <%--<input class="form-control underline-input" id="totalDbt" name="totalDbt" style="text-align: right; font-weight: bold" width="10%" value="0.00" readonly />--%>
                    <label style="font-size:medium"> Jumlah (RM) </label>
                </td>
                <td>
                    <input type="text" id="totalTabung" class="input-group__input form-control-totalTabung" placeholder="&nbsp;" style="background-color:#f3f3f3;text-align: right" >    
                </td>
            </tr>
              <tr>
                <td colspan="4">
                    <div class="btn-group">
                        <button type="button" class="btn btn-warning btnAddRow_tabSumbangan One" data-val="1" value="1"><b>+ Tambah</b></button>
                        <button type="button" class="btn btn-warning btnAddRow dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="sr-only">Toggle Dropdown</span>
                        </button>
                        <div class="dropdown-menu">
                            <a class="dropdown-item btnAddRow_tabSumbangan five" value="5" data-val="5">Tambah 5</a>
                            <a class="dropdown-item btnAddRow_tabSumbangan" value="10" data-val="10">Tambah 10</a>

                        </div>
                    </div>
                </td>               
            </tr>

            
        </tfoot>
     </table>
     </div>
          <div class="row">
    <div class="col-md-12">
        <div class="form-row">
            <div class="form-group col-md-12" align="right">                     
                <button id="btnSimpantab6" type="button" class="btn btn-secondary btnSimpantab5" data-toggle="tooltip" data-placement="bottom" title="Draft" >Simpan</button>
            </div>
        </div>
    </div>
</div>
</div>

         
     
      </div>

    </div> <%--Tutup Bahagian C modal-body--%>

    </asp:Panel>
     
     </div>

        <div id="pengesahan" class="tab-pane fade" aria-labelledby="tab-pengesahan" role="tabpanel">   <%--menu 8--%>
    <asp:Panel ID="Panel6" runat="server" >    
          <div class="col-md-10">        
               <div class="form-row">
               <div class="form-group col-md-5">
               <input type="text"  id="txtMohonID8"  class="input-group__input form-control" placeholder="&nbsp;" style="background-color:#f3f3f3">
               <label for="noPermohonan" class="input-group__label">No.Permohonan:</label>                       
               </div>                    
               <div class="form-group col-md-3">
               <input type="date" id="tkhMohon8" class="input-group__input form-control input-sm" style="background-color:#f3f3f3" placeholder="&nbsp;" readonly>                                   
               <label class="input-group__label" for="TarikhMohon">Tarikh Mohon:</label>                        
               </div>                
               </div>
          </div>   
    <div class="modal-body">
        <div class="row">
           <div class="col-md-12">
               Tuntutan-tuntutan Lain<br />
               <table class="table table-striped" style="width: 100%">
                 <tr>
                   <td width="64%"><strong>Tuntutan-tuntutan Lain</strong> </td>
                   <td width="26%"><strong>RM</strong></td>
                 </tr>
                 <tr>
                   <td>Jumlah Tuntutan Tempat Tuju </td>
                   <td><input type="text" name="txtJumTuntutan" id="txtJumTuntutan" style="text-align: right" readonly /></td>
                 </tr>
                 <tr>
                   <td>Gantirugi berkaitan dengan penukaran kepada matawang asing @ 3% </td>
                   <td><input type="text" name="txtGantiKadar" id="txtGantiKadar" style="text-align: right" value="0.00"  />
                    
                   </td>
                 </tr>
                 
                 <tr>
                   <td>Jumlah Keseluruhan Tuntutan </td>
                   <td><input type="text" name="txtJumlahK" id="txtJumlahK" style="text-align: right" readonly  /></td>
                 </tr>
                 <tr>
                   <td>Tolak : Jumlah Pendahuluan Yang Telah Diberi </td>
                   <td><input type="text" name="txtTolakPendahuluan" id="txtTolakPendahuluan"  style="text-align: right" readonly  /></td>
                 </tr>
                 <tr>
                   <td>Tolak: Jumlah Sumbangan </td>
                   <td><input type="text" name="txtTolakSumbangan" id="txtTolakSumbangan" style="text-align: right" readonly /></td>
                 </tr>
                 <tr>
                   <td>JUMLAH BESAR BAKI TUNTUTAN / BAKI DIBAYAR BALIK </td>
                   <td><input type="text" name="txtBakiBesar" id="txtBakiBesar" style="text-align: right" readonly  /></td>
                 </tr>
               </table>
              

           </div>
         </div>
        <div>
            <h8>Pengakuan Pegawai</h8>
            <br />
        </div>
      <br />
    <div>                           
    <div class="row">
        <div class="col-md-12">
           <input type="checkbox" ID="chckSah" value="1" checked /> Saya mengaku bahawa <br />
            a) Perjalanan pada tarikh-tarikh tersebut adalah benar dan telah dibuat atas urusan universiti. <br />
            b) Tuntutan ini dibuat mengikut Perintah Am Bab 'B'.<br /> 
            c) Perbelanjaan yang  berjumlah RM<input type="text" name="txtBelanja" id="txtBelanja" value="0.00"  style="text-align: right" /> telah menggunakan wang sendiri (sila kemukakan surat/memo akuan jika resit hilang/tidak diperolehi).<br /><br>
                <div class="form-group col-md-3">      
                    <div class="form-inline">      
                    <input type="file" id="fileInputBelanja" class="input-group__input choose-button"/>
                    <label for="UploadBelanja"  class="input-group__label">Muatnaik bukti belanja</label>
                    <input type="button" id="uploadBelanja" class="btn btn-secondary" value="Muatnaik" onclick="uploadFileBelanja()" />
                    <span id="uploadedFileNameLabelBelanja" style="display: inline;"></span>
                    <span id="">&nbsp</span>
                    <span id="progressContainerBelanja"></span>
                    <input type="hidden" class="form-control"  id="hidJenDokBelanja" style="width:300px" readonly="readonly" /> 
                    <input type="hidden" class="form-control"  id="hidFileNameBelanja" style="width:300px" readonly="readonly" /> 
                    </div> 
                </div>
            d) Semua butir - butir dalam tuntutan saya ini adalah benar belaka dan saya bertanggungjawab terhadapnya.

        </div>
    </div>
    </div>

         <div class="form-row">
    <div class="form-group col-md-12" align="right">
       <%-- <button type="button" class="btn btn-danger">Padam</button>--%>
        <button type="button" class="btn btn-secondary btnSimpan" style="display:inline">Simpan</button>
    </div>
</div>

      </div> <%--Tutup Bahagian Pengesahan modal-body--%>

       </asp:Panel>
   
   </div>  <%--Tutup tab 7--%> 

</div>
</div>
</div>

 <div class="modal-footer">   
    <button type="button"  runat="server"  class="btn btn-secondary Sokong" data-toggle="modal" data-target="#modalSah">Sokongan</button>
</div> 
           
        </div>  <%--tutup modal-content--%>
    </div>  <%--tutup class-document--%>
</div>


<div id="myPersonal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
       

    <!-- Modal content-->
    <div class="modal-content">
    <div class="modal-header"><h4>Maklumat Pegawai</h4> 
    <button type="button" class="close" data-dismiss="modal"></button>
    <h4 class="modal-title"></h4>
    </div>
    <div class="modal-body">
       
    <asp:Panel ID="Panel7" runat="server" >
     <div class="form-row">                                      
        <div class="form-group col-sm-6">
             <input type="text" id="txtNamaP" name="Nama" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0"/> 
            <label class="input-group__label" for="Nama">Nama</label>                                       
             <%--<asp:TextBox ID="txtNamaP" runat="server" Width="100%" class="form-control input-sm" style="background-color:#f3f3f3"></asp:TextBox>--%>
        </div>                                    
        <div class="form-group col-sm-6">
             <input type="text" ID="txtNoPekerja"  Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />  
            <label class="input-group__label"  for="No.Pekerja">No.Pekerja</label>
             
                                                
        </div>                               
    </div>

    <div class="form-row">
        <div class="form-group col-sm-6">
             <input type="text" ID="txtJawatan"  Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0"  />  
            <label class="input-group__label" for="kodModul">Jawatan</label>                        
        </div>
        <div class="form-group col-sm-6">
             <input type="text" ID="txtGredGaji" Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" /> 
            <label class="input-group__label" for="kodModul">Gred Gaji</label>                                     
        </div>
    </div>

     <div class="form-row">
        <div class="form-group col-sm-6">
            <input type="text" ID="txtPejabat"  Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" /> 
            <label class="input-group__label" for="kodModul">Pejabat/Jabatan/Fakulti</label>                                        
             <input type="hidden" ID="hidPtjPemohon" />
            
            <%-- <asp:TextBox ID="txtPejabat" runat="server" Width="100%" CssClass="form-control" style="background-color:#f3f3f3"></asp:TextBox>--%>
        </div>
        <div class="form-group col-sm-6">                                        
            <input type="text"  ID="txtKump"  Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0"/>
            <label class="input-group__label" for="Kumpulan">Kumpulan</label>
           <%--<asp:TextBox ID="txtKump" runat="server" Width="100%" CssClass="form-control" style="background-color:#f3f3f3"></asp:TextBox>--%>
        </div>
    </div>

   <div class="form-row">
        <div class="form-group col-sm-6">                                       
            <input type="text"  ID="txtMemangku"  Width="100%" class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0" />
             <label class="input-group__label" for="Memangku Jawatan">Memangku Jawatan</label>
            <%-- <asp:TextBox ID="txtMemangku" runat="server" Width="100%" CssClass="form-control" style="background-color:#f3f3f3"></asp:TextBox>--%>
        </div>
        <div class="form-group col-sm-6">
            <input type="text"  ID="txtTel"  Width="100%"  class="input-group__input" placeholder="&nbsp;" readonly style="background-color: #f0f0f0"  />
            <label class="input-group__label" for="Samb. Tel">Samb. Tel</label>                                      
           <%--<asp:TextBox ID="txtTel" runat="server" Width="100%" CssClass="form-control" style="background-color:#f3f3f3"></asp:TextBox>--%>
        </div>
    </div>
</asp:Panel>
    </div>
    <div class="modal-footer">
    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
    </div>
    </div>  <%--Tutup class="modal-content">--%>

    </div>
</div>

<!-- Modal Penerimaan -->
        <div id="modalSah" class="modal fade hide" role="dialog">
        <div class="modal-dialog modal-lg" role="dialog">
           
        <!-- Modal content-->
        <div class="modal-content">
        <div class="modal-header"><h4>Pengesahan Ketua PTj</h4>
        <button type="button" class="close" data-dismiss="modal"></button>
        <h4 class="modal-title" style="align-items:center"></h4> 
        </div>
        <div class="modal-body">
           
                 <asp:Panel ID="Panel8" runat="server" >
                             <div class="form-row">  
                                
                                <div class="form-group col-sm-6">
                                    <input type="text" id="namaPengesah"  class="input-group__input form-control"/>
                                    <label class="input-group__label" for="Disahkan Oleh">Disahkan Oleh</label>                                        
                                     <%--<asp:TextBox ID="txtNamaP" runat="server" Width="100%" class="form-control input-sm" style="background-color:#f3f3f3"></asp:TextBox>--%>
                                </div>                                    
                                <div class="form-group col-sm-6">
                                    <input type="text" ID="jwtnPengesah"  Width="100%" class="input-group__input form-control"/>                                       
                                    <label class="input-group__label" for="Jawatan Pengesah">Jawatan Pengesah</label>                                        
                                </div>                               
                           </div>

                            <fieldset>
                              <h6>Pengesahan Permohonan Pendahuluan Diri</h6>

                              <div>
                                <input type="radio"  class="radioBtnClass" name="status" value="05" checked />
                                <label for="huey">Sokong</label>
                              </div>

                              <div>
                                <input type="radio" class="radioBtnClass" name="status" value="14" />
                                <label for="dewey">Tidak Sokong</label>
                              </div>

                                <div class="form-group col-sm-6">                                        
                                    <input type="text" ID="txtCatatan"  Width="100%" class="input-group__input form-control"  />  
                                    <label class="input-group__label" for="Catatan">Catatan</label>                                        
                                </div>   

                            </fieldset>

                             
                </asp:Panel>
        </div>
        <div class="modal-footer">
        <button type="button" runat="server" class="btn btn-secondary btnSavePelulus"  data-dismiss="modal">Simpan</button>
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
    var curNumObject = 0;
    var tbl = null
    var tbl2 = null
    var shouldPop = true;
    var isClicked = false;
    var $tblElaunMakan = null;


    //const dateInput = document.getElementById('tkhMohonCL');
    //document.getElementById("tkhMohonCL").disabled = true;

    // ✅ Using the visitor's timezone
    //dateInput.value = formatDate();

    function formatDate(date = new Date()) {
        return [

            date.getFullYear(),
            padTo2Digits(date.getMonth() + 1),
            padTo2Digits(date.getDate()),
        ].join('-');
    }

    function padTo2Digits(num) {
        return num.toString().padStart(2, '0');
    }

    // Get the current year
    const currentYear = new Date().getFullYear();

    // Calculate the last year (current year - 1)
    const lastYear = currentYear - 1;

    // Get a reference to the select element for years
    const ddlTahun = document.getElementById("ddlTahun");

    // Create option elements for the current year and last year
    const currentYearOption = new Option(currentYear, currentYear);
    const lastYearOption = new Option(lastYear, lastYear);

    // Append the option elements to the select element
    ddlTahun.appendChild(currentYearOption);
    ddlTahun.appendChild(lastYearOption);

    // Get a reference to the select element
    const selectElement = document.getElementById("ddlBulan");

    // Array of month names
    const monthNames = [
        "Januari", "Februari", "March", "April", "Mei", "Jun",
        "Julai", "Ogos", "September", "Oktober", "November", "December"
    ];

    // Create option elements for each month and append them to the select element
    monthNames.forEach((month, index) => {
        const option = new Option(month, index + 1);
        selectElement.appendChild(option);
    });

    function ShowPopup(elm) {

        if (elm == "1") {
            $('#permohonan').modal('toggle');
        }
        else if (elm == "2") {            
            $(".modal-body div").val("");
            $('#SenaraiPermohonan').modal('toggle');

        }
    }


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

    $('.btnSearch').click(async function () {
        isClicked = true;
        tbl.ajax.reload();
    })

    $('.btn-change').click(async function () {
        $('#myPersonal').modal('toggle');
        $('#modalSenarai').modal('toggle');

    });

    $('.tutupInfo').click(async function () {
        //$('#myPersonal').modal('toggle');
        $('#modalSenarai').modal('toggle');

    });

    $(document).ready(function () {
        console.log("818")

        getDataPeribadi();
        //getHadMinPendahuluan();
        tbl = $("#tblDataSenarai").DataTable({
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
                "url": "PengesahanLN_WS.asmx/LoadOrderRecord_PermohonanSendiri",
                type: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                "dataSrc": function (json) {
                    //var data = JSON.parse(json.d);
                    //console.log(data.Payload);
                    return JSON.parse(json.d);
                },
                data: function () {
                    var startDate = $('#txtTarikhStart').val()
                    var endDate = $('#txtTarikhEnd').val()
                    return JSON.stringify({
                        category_filter: $('#categoryFilter').val(),
                        isClicked: isClicked,
                        tkhMula: startDate,
                        tkhTamat: endDate,
                        staffP: '<%=Session("ssusrID")%>'

                    //staffP: '<%'=Session("ssusrID")%>'

                    })
                },
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
                    "data": "No_Tuntutan",
                    render: function (data, type, row, meta) {

                        if (type !== "display") {
                            return data;
                        }

                        var link = `<td style="width: 10%" >
                       <label  name="noTuntutan"  value="${data}" >${data}</label>
                                   <input type ="hidden" class = "noTuntutan" value="${data}"/>
                               </td>`;
                        return link;
                    }
                },
                { "data": "Tarikh_Mohon" },
                { "data": "NamaPemohon" },
                { "data": "Tujuan_Tuntutan" },
                {
                    "data": "Jum_Pendahuluan",
                    render: function (data, type, full) {
                        return parseFloat(data).toFixed(2);
                    }

                },
                { "data": "Butiran" }

            ],
            "columnDefs": [
                { "targets": [4], "className": "right-align" }
            ],
        });
    });



    $(document).ready(function () {
        console.log("525")
        tbl2 = $("#tblListPend").DataTable({   //tbl load senarai permohonan PP
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
                "url": "PengesahanLN_WS.asmx/LoadRecord_PermohonanPP",
                type: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                "dataSrc": function (json) {
                    //var data = JSON.parse(json.d);
                    //console.log(data.Payload);
                    return JSON.parse(json.d);
                },

                data: function () {
                    return JSON.stringify({
                    //staffP: '<%=Session("ssusrID")%>'
                    staffP: $('#txtNoPekerja').val()
                })
            },


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
                console.log("data1");

                rowClickHandlerKeperluan(data);
            });

        },
        "columns": [
            {
                "data": "No_Pendahuluan",
                'targets': 0,
                'searchable': false,
                'orderable': false,
                render: function (data, type, row, meta) {
                    if (type !== "display") {
                        return data;

                    }
                    var checked = "";

                    if (data === $('#selectedNoPendahuluan').val()) {
                        checked = "checked";
                    }

                    var link = ` <input type="checkbox" data-nomohon="${data}" onclick="return setActiveNoPendahuluan(this);" name="checkPP" class = "checkPP" id="checkPP" class="checkSingle" ${checked} />`;
                    return link;
                }
            },
            {
                "data": "No_Pendahuluan",
                render: function (data, type, row, meta) {

                    if (type !== "display") {
                        return data;
                    }

                    var link = `<td style="width: 10%" >
           <label  name="noPermohonan1"  value="${data}" >${data}</label>
             <input type ="hidden" class = "noPermohonan1" value="${data}"/>
             </td>`;
                    return link;
                }
            },
            {
                "data": "Tujuan"
            },
            {
                "data": "Jum_Lulus",
                render: function (data, type, full) {
                    return parseFloat(data).toFixed(2);
                }
            },
            { "data": "No_Baucar" }


        ],
        "columnDefs": [
            { "targets": [3], "className": "right-align" }
        ],
    });
    });



    function setActiveNoPendahuluan(obj) {
        $('#selectedNoPendahuluan').val($(obj).data("nomohon"));
    }

    function rowClickHandlerKeperluan(orderDetail) {

        $('#selectedNoPendahuluan').val(orderDetail.No_Pendahuluan);
        $('#selectedJumlah').val(orderDetail.Jum_Lulus);
        console.log("1876")
        console.log(orderDetail.No_Pendahuluan);

    }

    function getDataPeribadi() {
        //Cara Pertama
        console.log("load info pemohon 2587")
        //var nostaf = $('#ddlStaf').val()
        var nostaf = '<%=Session("ssusrID")%>'

        fetch('PengesahanLN_WS.asmx/GetUserInfo', {
            method: 'POST',
            headers: {
                'Content-Type': "application/json"
            },
            body: JSON.stringify({ nostaf: '<%=Session("ssusrID")%>' })
            //body: JSON.stringify({ nostaf: nostaf })
        })
            .then(response => response.json())
            .then(data => setDataPeribadi(data.d))

    }

    function setDataPeribadi(data) {
        console.log(data)
        data = JSON.parse(data);
        if (data.Nostaf === "") {
            alert("Tiada data");
            return false;
        }

        $('#txtNamaP').val(data[0].Param1);
        $('#txtNoPekerja').val(data[0].StafNo);
        $('#txtJawatan').val(data[0].Param3);
        $('#txtGredGaji').val(data[0].Param6);
        $('#txtPejabat').val(data[0].Param5);
        $('#txtKump').val(data[0].Param4);
        $('#txtTel').val(data[0].Param7);
        $('#hidPtjPemohon').val(data[0].Param2)
        $('#txtNama').val(data[0].Param1);
        $('#txtNoStaf').val(data[0].StafNo);  
        $('#tblListPend').DataTable().ajax.reload();
     
    }

    function rowClickHandler(orderDetail) {
        //clearAllRows();
        console.log("rowclick")
        console.log(orderDetail.Nopemohon);
        $('#modalSenarai').modal('toggle')
        getDataPeribadiPemohon(orderDetail.Nopemohon)


        $('#noPermohonan').val(orderDetail.No_Tuntutan)
        $('#hidPtjPemohon').val(orderDetail.PTj)
        $('#ddlBulan').val(orderDetail.Bulan_Tuntut)
        $('#ddlTahun').val(orderDetail.Tahun_Tuntut)
        $('#txtTujuan').val(orderDetail.Tujuan_Tuntutan)
        $('#tkhMohon').val(orderDetail.Tarikh_Mohon)
        $('#tkhMohon2').val(orderDetail.Tarikh_Mohon)
        $('#selectedNoPendahuluan').val(orderDetail.No_Pendahuluan)
        $('#selectedJumlah').val(orderDetail.Jum_Pendahuluan)
        $('#txtTujuanLN').val(orderDetail.Tujuan_Tuntutan)
        $('#TkhBertolak').val(orderDetail.Tkh_Bertolak)
        $('#txtBertolakDari').val(orderDetail.Bertolak_Dari)
        $('#ddlJamTolakLN').val(orderDetail.jamSampai)
        $('#ddlMinitTolakLN').val(orderDetail.minitSampai)
      
        //ni digunakan untuk reload semula datatable  tblListPend n check nopendahuluan yang telah disimpan

        var newId = $('#ddlKumpWang')
        var ddlKumpWang = $('#ddlKumpWang')
        var ddlSearch = $('#ddlKumpWang')
        var ddlText = $('#ddlKumpWang')
        var selectObj_KumpWang = $('#ddlKumpWang')
        $(ddlKumpWang).dropdown('set selected', orderDetail.Kod_Kump_Wang);
        selectObj_KumpWang.append("<option value = '" + orderDetail.Kod_Kump_Wang + "'>" + orderDetail.colKW + "</option>")

        var newId = $('#ddlOperasi')
        var ddlKO = $('#ddlOperasi')
        var ddlSearch = $('#ddlOperasi')
        var ddlText = $('#ddlOperasi')
        var selectObj_ddlKO = $('#ddlOperasi')
        $(ddlKO).dropdown('set selected', orderDetail.Kod_Operasi);
        selectObj_ddlKO.append("<option value = '" + orderDetail.Kod_Operasi + "'>" + orderDetail.colKO + "</option>")

        var newId = $('#ddlProjek')
        var ddlKP = $('#ddlProjek')
        var ddlSearch = $('#ddlProjek')
        var ddlText = $('#ddlProjek')
        var selectObj_ddlKP = $('#ddlProjek')
        $(ddlKP).dropdown('set selected', orderDetail.Kod_Projek);
        selectObj_ddlKP.append("<option value = '" + orderDetail.Kod_Projek + "'>" + orderDetail.colKp + "</option>")

        var newId = $('#ddlPTJ')
        var ddlKPtj = $('#ddlPTJ')
        var ddlSearch = $('#ddlPTJ')
        var ddlText = $('#ddlPTJ')
        var selectObj_ddlKPtj = $('#ddlPTJ')
        $(ddlKPtj).dropdown('set selected', orderDetail.Kod_PTJ);
        selectObj_ddlKPtj.append("<option value = '" + orderDetail.Kod_PTJ + "'>" + orderDetail.ButiranPTJ + "</option>")
    }

    function getDataPeribadiPemohon(pemohon) {
        //Cara Pertama
        console.log("getDataPeribadiPemohon")
        console.log(pemohon)
        var nostaf = pemohon
        console.log(nostaf)
        //alert(pemohon)

        fetch('PengesahanLN_WS.asmx/GetUserInfo', {
            method: 'POST',
            headers: {

                'Content-Type': "application/json"
            },
         //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify({ nostaf: nostaf })
     })
         .then(response => response.json())
         .then(data => setDataPeribadi(data.d))
    }


    function generateDropdown_list(id, url, param, fn) {      
        var inParam = "";

        if (param !== null && param !== undefined) {
            inParam = param;
        }
        $(id).dropdown({
            fullTextSearch: false,
            onChange: function () {
                if (fn !== null && fn !== undefined) {
                    return fn();
                }
            },
            apiSettings: {
                url: url + '?q={query}&' + inParam,
                method: 'POST',
                dataType: "json",
                contentType: 'application/json; charset=utf-8',
                cache: false,
                beforeSend: function (settings) {
                    // Replace {query} placeholder in data with user-entered search term
                    settings.data = JSON.stringify({ q: settings.urlData.query });
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

                    $.each(listOptions, function (index, option) {
                        $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                    });


                    // Refresh dropdown
                    $(obj).dropdown('refresh');

                    $(obj).dropdown('show');
                }
            }
        });
    }

    //function bila klil pada Tab-Kenyataan
    //function bila klik pada Tab-Maklumat Perjalanan
    $('#tab-Kenyataan').click(async function () {
        console.log("masuk tab_Kenyataan  jjjj")
        $('#noPermohonan').val();
        $('#tkhMohon').val();
        var id = $('#noPermohonan').val();
        var tkhMhn = $('#tkhMohonCL').val()
        $('#txtMohonID').val(id);
        /*$('#tkhMohon2').val(tkhMhn);*/


        if (id !== "") {
            clearAlltblKenyataan();
            //BACA DETAIL JURNAL
            var recordDataKPerjalanan = await AjaxGetDataPerjalanan(id);  //Baca data pada table Keperluan             
            //await clearAllRows();
            await SetDataPerjalananRows(null, recordDataKPerjalanan); //setData pada table
        }

        return false;
    })

    async function clearAlltblKenyataan() {
        console.log("masuk clearAlltblKenyataan 3026 ")
        $('#tblKenyataan' + " > tbody > tr ").each(function (index, obj) {
            if (index > 0) {
                obj.remove();
            }
        })

    }

    async function AjaxGetDataPerjalanan(id) {

        try {

            const response = await fetch('PengesahanLN_WS.asmx/LoadListPerjalanan', {
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

    async function clearAlltblKenyataan() {        
        $('#tblKenyataan' + " > tbody > tr ").each(function (index, obj) {
            if (index > 0) {
                obj.remove();
            }
        })     
    }

    async function SetDataPerjalananRows(totalClone, objOrder) {


        var counter = 1;
        var table = $('#tblKenyataan');
        var total = 0.00;


        console.log("masuk  SetDataKenyataanKepadaRows Maklumat Perjalanan ")
        if (objOrder !== null && objOrder !== undefined) {   //semak berapa object yang ada
            totalClone = objOrder.length;
        }


        while (counter <= totalClone) {
            curNumObject += 1;

            var newId_Bil = "list_Bil" + curNumObject; //create new object pada table
            var newId_JnsTugas = "JenisTugasLN-list" + curNumObject;
            var newId_JnsNegara = "JenisNegara-list" + curNumObject;
            var newId_Bandar = "list_Bandar" + curNumObject;
            var newId_TkhBertolak = "form-control-tkhBertolak-list" + curNumObject;
            var newId_JamBertolak = "list_ddlJamMula" + curNumObject;
            var newId_MinitBertolak = "list_ddlMinitMula" + curNumObject;
            var newId_TkhSampai = "form-control-tkhSampai-list" + curNumObject;
            var newId_JamTiba = "list_ddlJamSampai" + curNumObject;
            var newId_MInitTiba = "list_ddlMinitSampai" + curNumObject;
            var newId_list_Amaun = "list_Amaun" + curNumObject;

            var row = $('#tblKenyataan tbody>tr:first').clone();

            // var dropdown5 = $(row).find(".COA-list").attr("id", newId_coa);
            var Bil = $(row).find(".list_Bil").attr("id", newId_Bil);
            var JenisTugas = $(row).find(".JenisTugasLN-list").attr("id", newId_JnsTugas);
            var JnsNegara = $(row).find(".JenisNegara-list").attr("id", newId_JnsNegara);
            var Bandar = $(row).find(".list_Bandar").attr("id", newId_Bandar);
            var TkhBertolak = $(row).find(".form-control-tkhBertolak-list").attr("id", newId_TkhBertolak);
            var JamTolak = $(row).find(".list_ddlJamMula").attr("id", newId_JamBertolak);
            var MinitTolak = $(row).find(".list_ddlMinitMula").attr("id", newId_MinitBertolak);
            var TkhTiba = $(row).find(".form-control-tkhSampai-list").attr("id", newId_TkhSampai);
            var JamTiba = $(row).find(".list_ddlJamSampai").attr("id", newId_JamTiba);
            var MinitTiba = $(row).find(".list_ddlMinitSampai").attr("id", newId_MInitTiba);
            var Amaun = $(row).find(".list_Amaun").attr("id", newId_list_Amaun);


            //var $objBil = $(row).find("#txtBil");
            //$objBil.attr("id", newBil);

            $('#tblKenyataan tbody').append(row);  //bind data start pada row yang first pada tblData2

            generateDropdown_list("#" + newId_JnsTugas, "PengesahanLN_WS.asmx/GetJenisTugas", null)
            generateDropdown_list("#" + newId_JnsNegara, "PengesahanLN_WS.asmx/GetJenisNegara", null)

            if (objOrder !== null && objOrder !== undefined) {
                var obj = objOrder;

                $('#hidJenDok').val(obj[counter - 1].Path_LampiranA)
                $('#hidFileName').val(obj[counter - 1].Nama_Fail_LampiranA)
                $('#uploadedFileNameLabel').val(fileName)

                //$('#txtNamaFile').val(obj[counter - 1].Nama_Fail_LampiranA)
                //Checkbox2.val(obj[counter - 1].Flag_Muzla);

                var fileName = obj[counter - 1].Nama_Fail_LampiranA
                //var resolvedUrl = "../UPLOAD/DOCUMENT/PENDAHULUAN DAN TUNTUTAN/PD/"
                var fileLink = document.createElement("a");
                fileLink.href = obj[counter - 1].Path_LampiranA;
                fileLink.textContent = fileName;

                var uploadedFileNameLabel = document.getElementById("uploadedFileNameLabel");
                uploadedFileNameLabel.innerHTML = "";
                uploadedFileNameLabel.appendChild(fileLink);


                //$("#uploadedFileNameLabel").show();
                // Clear the file input
                $("#fileInput").val("");

                console.log(obj[counter - 1].Bil);
                console.log(obj[counter - 1].jamTolak);
                console.log(obj[counter - 1].minitTolak);
                console.log(obj[counter - 1].Jenis_Tugas_LN);
                console.log(obj[counter - 1].Bandar_LN);
                console.log(obj[counter - 1].Tarikh_Mohon);
                console.log("NExt");
                //Checkbox2.val(obj[counter - 1].Flag_Muzla);


                Bil.val(obj[counter - 1].Bil)
                JenisTugas.val(obj[counter - 1].Jenis_Tugas_LN);
                JnsNegara.val(obj[counter - 1].Negara);
                Bandar.val(obj[counter - 1].Bandar_LN);
                TkhBertolak.val(obj[counter - 1].Tarikh);
                JamTolak.val(obj[counter - 1].jamTolak);
                MinitTolak.val(obj[counter - 1].minitTolak);
                TkhTiba.val(obj[counter - 1].Tarikh_Tiba);
                JamTiba.val(obj[counter - 1].jamSampai);
                MinitTiba.val(obj[counter - 1].minitSampai);
                Amaun.val("0.00");


                var selectObj_JenisTugas = $('#' + newId_JnsTugas)
                JenisTugas.dropdown('set selected', obj[counter - 1].Jenis_Tugas_LN);
                selectObj_JenisTugas.append("<option value = '" + obj[counter - 1].Jenis_Tugas_LN + "'>" + obj[counter - 1].Jenis_Tugas_LN + "</option>")



                var selectObj_JnsNegara = $('#' + newId_JnsNegara)
                JnsNegara.dropdown('set selected', obj[counter - 1].Negara);
                selectObj_JnsNegara.append("<option value = '" + obj[counter - 1].Negara + "'>" + obj[counter - 1].Negara + "</option>")

                console.log("2726");
                console.log(JnsNegara.val());
            } else {
                Bil.val($('.list_Bil').length - 1);
            }

            //total += parseFloat(obj[counter - 1].Jumlah_anggaran);
            Amaun.val("0.00");
            row.attr("style", "");  //style pada row
            counter += 1;
        }
    }


    //Bila klik Tab tab-elaunPjln
    $('#tab-elaunPjln').click(async function () {

        console.log("masuk elaunPjln")
        $('#noPermohonan').val();
        var id = $('#noPermohonan').val();
        var tkh = $('#tkhMohon').val();  
        $('#txtMohonID3').val(id);
        $('#tkhMohon3').val(tkh);
        //loadDataKenyataan(id)

        if (id !== "") {
            clearAlltblElaunPjln();
            //BACA DETAIL JURNAL
            var recordDataElaunPjln = await AjaxGetDataElaunPjln(id);  //Baca data pada table Keperluan             
            //await clearAllRows();
            await SetDataDataElaunPjlnRows(null, recordDataElaunPjln); //setData pada table
        }
        return false;
    })


    async function AjaxGetDataElaunPjln(id) {

        try {
            const response = await fetch('PengesahanDN_WS.asmx/GetDataFromKenyataan', {
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

    async function clearAlltblElaunPjln() {        
        $('#tblDataEP' + " > tbody > tr ").each(function (index, obj) {
            if (index > 0) {
                obj.remove();
            }
        })      

    }

    async function SetDataDataElaunPjlnRows(totalClone, objOrder) {
        var counter = 1;
        var table = $('#tblDataEP');
        var total = 0.00;
        var totalJarak;

        console.log("masuk  SetDataDataElaunPjlnRows  tblDataEP ")
        if (objOrder !== null && objOrder !== undefined) {   //semak berapa object yang ada
            totalClone = objOrder.Payload.length;
        }


        while (counter <= totalClone) {
            curNumObject += 1;            

            var newId_kiraKilo = "txtKiraKilometer" + curNumObject; //create new object pada table
            var newId_hidJnsKend = "hidJnsKend" + curNumObject;
            //var newId_hidKM = "hidkm" + curNumObject;
            var newId_kenderaanEP = "txtKenderaanEP" + curNumObject;
            var newId_jarakEP = "txtJumJarakEP" + curNumObject;
            var newId_kadarEP = "txtKadarEP" + curNumObject;
            var newId_jumlahEP = "txtJumlahEP" + curNumObject;
            var newId_hidNostafK = "hidNostafKend" + curNumObject;
            var newBil = "hidkm" + curNumObject;

            var row = $('#tblDataEP tbody>tr:first').clone();

            // var dropdown5 = $(row).find(".COA-list").attr("id", newId_coa);
            //var hidKM = $(row).find(".hidkm-list").attr("id", newId_hidKM);
            var txtKiraKM = $(row).find(".list-txtKiraKilometer").attr("id", newId_kiraKilo);
            var kenderaanEP = $(row).find(".list-txtKenderaanEP").attr("id", newId_kenderaanEP);
            var hidJnsKendEP = $(row).find(".hidJnsKend-list").attr("id", newId_hidJnsKend);
            var jarakEP = $(row).find(".list-txtJumJarakEP").attr("id", newId_jarakEP);
            var kadarEP = $(row).find(".list-txtKadarEP").attr("id", newId_kadarEP);
            var hidNoStafKend = $(row).find(".hidNostafKend-list").attr("id", newId_hidNostafK);
            var jumlahEP = $(row).find(".list-txtJumlahEP").attr("id", newId_jumlahEP);

            var $objBil = $(row).find(".hidkm-list");
            $objBil.attr("id", newBil);

            if (objOrder !== null && objOrder !== undefined) {
                var obj = objOrder.Payload;

                console.log(obj[counter - 1].jumjarak);
                console.log(obj[counter - 1].kadarHarga);
                console.log(obj[counter - 1].Jenis_Kenderaan);
                console.log(obj[counter - 1].No_Kend);
                console.log(obj[counter - 1].KM);
                console.log(obj[counter - 1].Jenis_Kenderaan);
                console.log(obj[counter - 1].No_Staf);
                console.log("Next");


                $objBil.val($('.hidkm-list').length);
                txtKiraKM.val(obj[counter - 1].KM);
                //hidKM.val(obj[counter - 1].jumjarak);
                kenderaanEP.val(obj[counter - 1].No_Kend);
                hidJnsKendEP.val(obj[counter - 1].Jenis_Kenderaan)
                jarakEP.val(obj[counter - 1].jumjarak);
                kadarEP.val(obj[counter - 1].kadarHarga);
                hidNoStafKend.val(obj[counter - 1].No_Staf);

                totalJarak = jarakEP.val() * kadarEP.val();

                jumlahEP.val(parseFloat(totalJarak).toFixed(2));

                total += jumlahEP.val();

                console.log($objBil.val($('.hidkm-list').length));
                console.log("3134");
            }
            else {
                //$objBil.val($('.list_Bil').length);
            }

            //total += parseFloat(obj[counter - 1].Jumlah_anggaran);

            row.attr("style", "");  //style pada row

            $('#tblDataEP tbody').append(row);  //bind data start pada row yang first pada tblData2

            counter += 1;
        }
        $('#totalEP').val(parseFloat(total).toFixed(2));
    }


    //Bila klik  tab-pengangkutan
    $('#tab-pengangkutan').click(async function () {
        console.log("masuk tab-pengangkutann")
        $('#noPermohonan').val();
        var id = $('#noPermohonan').val();
        var tkh = $('#tkhMohon').val();  
        $('#txtMohonID4').val(id);
        $('#tkhMohon4').val(tkh);
        //loadDataKenyataan(id)

        if (id !== "") {
            clearAlltblKenderaanAwam();
            //BACA DETAIL JURNAL
            var recordDataKendAwam = await AjaxGetDataKenderaanAwam(id);  //Baca data pada table Keperluan             
            //await clearAllRows();
            await SetDataDataKenderaanAwam(null, recordDataKendAwam); //setData pada table
        }
        return false;
    })

    async function AjaxGetDataKenderaanAwam(id) {
        try {
            const response = await fetch('PengesahanDN_WS.asmx/GetDataKendAwam', {
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

    async function clearAlltblKenderaanAwam() {
        console.log("masuk clearAlltblPengankutan 3214 ")
        $('#tblTambang' + " > tbody > tr ").each(function (index, obj) {
            if (index > 0) {
                obj.remove();
            }
        })    
    }

    async function SetDataDataKenderaanAwam(totalClone, objOrder) {
        console.log("masuk SetDataDataKenderaanAwam")
        var counter = 1;
        var total = 0.00;
        var table = $('#tblTambang');
        var jumlah = 0.00;
        console.log(totalClone)
        var curNumObject = 0;

        if (objOrder !== null && objOrder !== undefined) {
            totalClone = objOrder.length;
        }
        while (counter <= totalClone) {

            curNumObject += 1;

            //var newId_coa = "ddlCOA" + curNumObject;
            var newId_JenisTambang = "ddlJenisTambangtblAwam-list" + curNumObject; //create new object pada table
            var newId_lbljenisTambang = "label-jenisTam-list" + curNumObject;
            var newId_hidjenisTambang = "Hid-jenisTam-list" + curNumObject;
            var newId_DengResit = "checkbox_DengResit" + curNumObject;
            var newId_TanpaResit = "checkbox_TanpaResit" + curNumObject;
            var newId_noResit = "noResit" + curNumObject;
            var newId_AmaunTamb = "lblAmaunTambang" + curNumObject;
            var newId_attResit = "fileInputSurat" + curNumObject;
            var newBil = "data-id" + curNumObject;

            var row = $('#tblTambang tbody>tr:first').clone();

            var JenisTambang = $(row).find(".ddlJenisTambangtblAwam-list").attr("id", newId_JenisTambang);
            var lblJenisTamb = $(row).find(".label-jenisTam-list").attr("id", newId_lbljenisTambang);
            var hidJenisTamb = $(row).find(".Hid-jenisTam-list").attr("id", newId_hidjenisTambang);
            var DengResit = $(row).find(".lblDengResit_list").attr("id", newId_DengResit);
            var TanpaResit = $(row).find(".lblTanpaResit-list").attr("id", newId_TanpaResit);
            var noResit = $(row).find(".lblnoResit-list").attr("id", newId_noResit);
            var AmaunTamb = $(row).find(".AmaunTambang-list").attr("id", newId_AmaunTamb);
            var AttResit = $(row).find(".fileInputSurat").attr("id", newId_attResit);
            var Lampiran = $(row).find(".tempFile").attr("id", "tempFile" + curNumObject);
            var objBil = $(row).find(".data-id");
            objBil.attr("id", newBil);

            if (objOrder !== null && objOrder !== undefined) {
                var obj = objOrder;
                console.log(obj[counter - 1].No_Tuntutan);
                console.log(obj[counter - 1].Jns_Dtl_Tuntutan);
                console.log(obj[counter - 1].No_Item);
                console.log(obj[counter - 1].Jenis_Tambang);
                console.log(obj[counter - 1].Flag_Resit);
                console.log(obj[counter - 1].No_Resit);
                console.log(obj[counter - 1].Jumlah_anggaran);
                console.log(obj[counter - 1].Butiran);
                //objBil.val($('.data-id').length);

                console.log("next")
                console.log(objBil.val())
                if (obj[counter - 1].Flag_Resit === true) {
                    console.log("masuk checked")
                    $(row).find(".lblDengResit_list").prop("checked", true);
                }

                if (obj[counter - 1].Flag_Resit === false) {
                    console.log("masuk checked")
                    TanpaResit.prop("checked", true);

                }
                var $tempFilePreview = $(row).find(".tempFile");
                var $link1 = obj[counter - 1].Path

                objBil.val(obj[counter - 1].No_Item)
                JenisTambang.val(obj[counter - 1].Jenis_Tambang);
                noResit.val(obj[counter - 1].No_Resit);
                AmaunTamb.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));
                //AttResit.val(obj[counter - 1].Nama_Fail)
                $tempFilePreview.attr("href", $link1);
                $tempFilePreview.html(obj[counter - 1].Nama_Fail);
                console.log("NExt");
                console.log(obj[counter - 1].No_Item);
                jumlah = (obj[counter - 1].Jumlah_anggaran);
                total += jumlah;
                console.log(total)
                $('#totalTblTambang').val(parseFloat(total).toFixed(2))
            }
            else {
                console.log("masuk else")
                objBil.val($('.data-id').length);
            }
            row.attr("style", "");

            $('#tblTambang tbody').append(row);

            generateDropdown_list("#" + newId_JenisTambang, "PengesahanDN_WS.asmx/GetKendAwam")

            var selectObj_KendAwam = $('#' + newId_JenisTambang)
            JenisTambang.dropdown('set selected', objOrder[counter - 1].Butiran);
            selectObj_KendAwam.append("<option value = '" + objOrder[counter - 1].Jenis_Tambang + "'>" + objOrder[counter - 1].Jenis_Tambang + " - " + objOrder[counter - 1].Butiran + "</option>")

            counter += 1;          

        }

    }

    //function bila klil pada tab-elaunMakan
    $('#tab-elaunMakan').click(async function () {
        console.log("masuk tab-elaun makan  jjjj")
        $('#noPermohonan').val();
        var id = $('#noPermohonan').val();
        var tkhMohon = $('#tkhMohon2').val();
        $('#txtMohonID5').val(id);
        $('#tkhMohon5').val(tkhMohon);


        if (id !== "") {
            //clearAlltblKenyataan();
            //BACA DETAIL JURNAL
            //var recordDataElaunMakan = await AjaxGetDataElaunMakan(id);  //Baca data pada table Keperluan
            //await clearAllRows();
            //await SetDataElaunMakanLN(null, recordDataElaunMakan); //setData pada table
            await totalElaunMakan(id);
            $tblElaunMakan.ajax.reload();
        }

        return false;

    });


    async function totalElaunMakan(id) {

        fetch('LuarNegara1_WS.asmx/GetTotalElaunMakan', {
            method: 'POST',
            headers: {
                'Content-Type': "application/json"
            },
        //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
        body: JSON.stringify({ id: id })
    })
            .then(response => response.json())
            .then(data => setTotalElaunMakan(data.d))
    }

    function setTotalElaunMakan(data) {
        data = JSON.parse(data);
        if (data.id === "") {
            alert("Tiada data");
            return false;
        }

        $('#hidTotalEM').val(data[0].harga);

    }


    async function AjaxGetDataElaunMakan(id) {
        console.log("masuk AJAX AjaxGetDataElaunMakan ")

        try {

            const response = await fetch('PengesahanLN_WS.asmx/GetDataElaunMakan', {
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



    $tblElaunMakan = $("#tblElaunMakan").DataTable({   //tbl load senarai permohonan PP
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
            "url": "PengesahanLN_WS.asmx/GetDataElaunMakan",
            type: 'POST',
            "contentType": "application/json; charset=utf-8",
            "dataType": "json",
            "dataSrc": function (json) {
                var data = JSON.parse(json.d);
                var payload = data.Payload;
                if (payload === null) {
                    payload = [];
                }
                console.log("masuk payload");
                console.log(payload);
                return (payload);
            },

            data: function () {
                return JSON.stringify({
                 //staffP: '<%=Session("ssusrID")%>'
                 id: $('#txtMohonID5').val()
             })
         },


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
             console.log("data1");
             rowClickHandlerKeperluan(data);
         });

     },
     "columns": [
         {
             "data": "listItem",

         },
         {
             "data": "No_Tuntutan",

         },
         {
             "data": "Matawang"
         },
         {
             "data": "Kadar_Pertukaran",
             render: function (data, type, full) {
                 return parseFloat(data).toFixed(2);
             }
         },
         { "data": "Bil_Hari" },
         { "data": "Flag_Mkn_Pagi" },
         { "data": "Flag_Mkn_Tghari" },
         { "data": "Flag_Mkn_Mlm" },
         {
             "data": "Jumlah_anggaran",
             render: function (data, type, full) {
                 return parseFloat(data).toFixed(2);
             }
         }


     ],
     "columnDefs": [
         { targets: '[3, 8]', className: 'dt-left' },
         { className: 'dt-center', targets: '[0,1,2,4,5,6,7]' }
     ],
 });


    async function clearAlltblElaunMakan() {
        console.log("masuk clearAlltblKenyataan 3026 ")
        $('#tblElaunMkn' + " > tbody > tr ").each(function (index, obj) {
            if (index > 0) {
                obj.remove();
            }
        })
        //$(totalKt).val("0.00");
    }

    async function SetDataElaunMakanKepadaRows(totalClone, objOrder) {
        var counter = 1;
        var table = $('#tblElaunMkn');
        var total = 0.00;
        var jumlah = 0.00;


        if (objOrder !== null && objOrder !== undefined) {
            totalClone = objOrder.Payload.length;
            // totalClone = objOrder.length;
        }

        while (counter <= totalClone) {

            curNumObject += 1;
            //var newId_coa = "ddlCOA" + curNumObject;
            var newId_hari = "txtbilEL" + curNumObject;
            var newId_bil = "form-control-hidIDEL" + curNumObject; //create new object pada table
            var newId_TugasEL = "ddlJenisTugasElaunMkn" + curNumObject;
            var newId_lblTugas = "label-JenisTugasElaunMkn-list" + curNumObject;
            var newId_hidTugas = "Hid-JenisTugasElaunMkn-list" + curNumObject;
            var newId_pagi = "chckPagi" + curNumObject;
            var newId_tghari = "chckTghari" + curNumObject;
            var newId_petand = "chckPtg" + curNumObject;
            var newId_tempatEL = "ddlTmptElaunMkn" + curNumObject;
            var newId_lblTempatEL = "lblJnstempatElaunMkn" + curNumObject;
            var newId_hidTempatEL = "HidJnstempatElaunMkn" + curNumObject;
            var newId_hargaEL = "txtHargaEL-list" + curNumObject;
            var newId_JumlahEL = "txtJumlahEL" + curNumObject;

            var row = $('#tblElaunMkn tbody>tr:first').clone();

            //var bilEL = $(row).find(".txtbilEL").attr("id", newId_bil);
            var bilHari = $(row).find(".form-control-txtbilEL").attr("id", newId_hari);
            var jenisTugasEL = $(row).find(".JenisTugasElaunMkn-list").attr("id", newId_TugasEL);
            var lblTugasEL = $(row).find(".label-JenisTugasElaunMkn-list").attr("id", newId_lblTugas);
            var hidTugasEL = $(row).find(".Hid-JenisTugasElaunMkn-list").attr("id", newId_hidTugas);
            var mPagi = $(row).find(".pagi").attr("id", newId_pagi);
            var mTghari = $(row).find(".tghari").attr("id", newId_tghari);
            var mMalam = $(row).find(".malam").attr("id", newId_petand);
            var jenisTempatEL = $(row).find(".JnstempatElaunMkn-list").attr("id", newId_tempatEL);
            var lblTempatEL = $(row).find(".label-JnstempatElaunMkn-list").attr("id", newId_lblTempatEL);
            var hidTempatEL = $(row).find(".Hid-JnstempatElaunMkn-list").attr("id", newId_hidTempatEL);
            var AmaunEL = $(row).find(".form-control-txtHargaEL").attr("id", newId_hargaEL);
            var JumlahEL = $(row).find(".form-control-txtJumlahEL").attr("id", newId_JumlahEL)
            var $objBil = $(row).find(".form-control-hidIDEL");
            $objBil.attr("id", newId_bil);

            $('#tblElaunMkn tbody').append(row);

            generateDropdown_list("#" + newId_TugasEL, "PengesahanDN_WS.asmx/GetJenisTugasTblSewaHotel", null)
            generateDropdown_list("#" + newId_tempatEL, "PengesahanDN_WS.asmx/GetTempatTblHotel", null)

            if (objOrder !== null && objOrder !== undefined) {
                var obj = objOrder.Payload;

                bilHari.val(obj[counter - 1].Bil_Hari);
                if (Object.keys(obj[counter - 1]).length > 2) {

                    if ((obj[counter - 1].Flag_Mkn_Pagi) === 1) {
                        var $checkPagi = 1
                    }

                    console.log("next")

                    if (obj[counter - 1].Flag_Mkn_Pagi === true) {
                        console.log("masuk checked")
                        $(row).find(".pagi").prop("checked", true);
                    }


                    if (obj[counter - 1].Flag_Mkn_Tghari === true) {
                        console.log("masuk checked")
                        $(row).find(".tghari").prop("checked", true);
                    }

                    if (obj[counter - 1].Flag_Mkn_Mlm === true) {
                        console.log("masuk checked")
                        $(row).find(".malam").prop("checked", true);

                    }

                    $objBil.val(obj[counter - 1].No_Item)

                    jenisTugasEL.val(obj[counter - 1].Jenis_Tugas);
                    //mPagi.val(obj[counter - 1].Flag_Mkn_Pagi);
                    //mTghari.val(obj[counter - 1].Flag_Mkn_Tghari);
                    //mMalam.val(obj[counter - 1].Flag_Mkn_Mlm);
                    jenisTempatEL.val(obj[counter - 1].Jenis_Tempat);
                    AmaunEL.val(parseFloat(obj[counter - 1].Kadar_Harga).toFixed(2));
                    JumlahEL.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));
                    var selectObj_jnstugasHotel = $('#' + newId_TugasEL)
                    jenisTugasEL.dropdown('set selected', obj[counter - 1].JenisTugas);
                    selectObj_jnstugasHotel.append("<option value = '" + obj[counter - 1].Jenis_Tugas + "'>" + obj[counter - 1].JenisTugas + "</option>")

                    var selectObj_jnstempatHotel = $('#' + newId_tempatEL)
                    jenisTempatEL.dropdown('set selected', obj[counter - 1].Tempat);
                    selectObj_jnstempatHotel.append("<option value = '" + obj[counter - 1].Jenis_Tempat + "'>" + obj[counter - 1].Tempat + "</option>")

                    jumlah = (obj[counter - 1].Jumlah_anggaran);
                    total += jumlah;

                    $('#totalEL').val(parseFloat(total).toFixed(2))
                }
                else {
                    $objBil.val(counter)
                }

            }
            else {
                $objBil.val($('.form-control-hidIDEL').length);
            }

            row.attr("style", "");
            var val = "";

            counter += 1;
        }
    }

    $('#tab-sewaHotel').click(async function () {
        console.log("masuk sewa hotel")
        $('#noPermohonan').val();
        var id = $('#noPermohonan').val();
        var tkh = $('#tkhMohon').val();  
        $('#txtMohonID6').val(id);
        $('#tkhMohon6').val(tkh);
        //loadDataKenyataan(id)

        if (id !== "") {
            clearAlltblSewaHotel();
            //BACA DETAIL JURNAL
            var recordDataSewaHotel = await AjaxRecordSewaHotel(id);  //Baca data pada table Keperluan             
            //await clearAllRows();
            await SetDataSewaHotel(null, recordDataSewaHotel); //setData pada table
            clearAlltblLojing();
            var recordDataElaunLojing = await AjaxRecordElaunLojing(id);  //Baca data pada table Keperluan             
            //await clearAllRows();
            await SetDataElaunLojing(null, recordDataElaunLojing); //setData pada table

        }
        return false;
    })

    async function clearAlltblSewaHotel() {
        console.log("masuk clearAlltblSewaHotel 3242 ")
        $('#tblSewaHotel' + " > tbody > tr ").each(function (index, obj) {
            if (index > 0) {
                obj.remove();
            }
        })

    }

    async function clearAlltblLojing() {
        console.log("masuk clearAlltblLojing 3309 ")
        $('#tblLojing' + " > tbody > tr ").each(function (index, obj) {
            if (index > 0) {
                obj.remove();
            }
        })

    }


    async function SetDataElaunLojing(totalClone, objOrder) {
        console.log("SetDataElaunLojing")
        var counter = 1;
        var table = $('#tblLojing');
        var total = 0.00;

        if (objOrder !== null && objOrder !== undefined) {
            //totalClone = objOrder.Payload.OrderDetails.length;
            totalClone = objOrder.length;

        }

        while (counter <= totalClone) {

            curNumObject += 1;

            var bil = $(obj).find('.input-md-txtBiltblLojing').length;


            //var newId_coa = "ddlCOA" + curNumObject;
            var newId_bilLojing = "txtBiltblLojing" + curNumObject; //create new object pada table
            var newId_jnstugasLojing = "ddlJenisTugastblLojingA" + curNumObject;
            var newId_lbltempatLojing = "label-JnstempattblLojing-list" + curNumObject;
            var newId_resitLojing = "resittblLojing" + curNumObject;
            var newId_lblresitLojing = "resit-list" + curNumObject;
            var newId_elaunLojing = "elauntblLojing-list" + curNumObject;
            var newId_lblelaunLojing = "lblAmaunLojing-list" + curNumObject;
            var newId_hariLojing = "haritblLojing-list" + curNumObject;
            var newId_lblhariLojing = "lblharitblLojing-list" + curNumObject;
            var newId_amaunLojing = "mauntblLojing-list" + curNumObject;
            var newId_lblamaunLojing = "lblAmaunLojing-list" + curNumObject;
            var newId_attResit = "fileInputLojing" + curNumObject;
            var newId_Alamat = "txtAlamatLojing" + curNumObject;
            var newBil = "txtBil" + curNumObject;

            console.log("2955")

            var row = $('#tblLojing tbody>tr:first').clone();


            var $objBil = $(row).find(".input-md-txtBiltblLojing").attr("id", newId_bilLojing);
            var jnstugasLojing = $(row).find(".ddlJenisTugastblLojingA-list").attr("id", newId_jnstugasLojing);
            var resitLojing = $(row).find(".input-md.resittblLojing").attr("id", newId_resitLojing);
            var elaunLojing = $(row).find(".input-md.elauntblLojing-list").attr("id", newId_elaunLojing);
            var hariLojing = $(row).find(".input-md.haritblLojing-list").attr("id", newId_hariLojing);
            var amaunLojing = $(row).find(".amauntblLojing-list").attr("id", newId_amaunLojing);
            var AttResit = $(row).find(".fileInputLojing").attr("id", newId_attResit);
            var Lampiran = $(row).find(".tempFileLojing").attr("id", "tempFileLojing" + curNumObject);


            var $objBil = $(row).find('.input-md-txtBiltblLojing');
            $objBil.attr("id", newBil);



            if (objOrder !== null && objOrder !== undefined) {
                var obj = objOrder;

                console.log(obj[counter - 1].No_Item);
                console.log(obj[counter - 1].Jenis_Tugas);
                console.log(obj[counter - 1].Bil_Hari);
                console.log(obj[counter - 1].No_Resit);
                console.log(obj[counter - 1].Kadar_Harga);
                console.log(obj[counter - 1].Jumlah_anggaran);


                var $tempFilePreview = $(row).find(".tempFileLojing");
                var $link1 = obj[counter - 1].Path

                console.log($objBil.val($('.input-md-txtBiltblLojing').val()));

                $objBil.val(obj[counter - 1].No_Item);

                jnstugasLojing.val(obj[counter - 1].Jenis_Tugas);
                resitLojing.val(obj[counter - 1].No_Resit);
                hariLojing.val(obj[counter - 1].Bil_Hari);
                amaunLojing.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));
                elaunLojing.val(parseFloat(obj[counter - 1].Kadar_Harga).toFixed(2));

                $tempFilePreview.attr("href", $link1);
                $tempFilePreview.html(obj[counter - 1].Nama_Fail);
                console.log($tempFilePreview.html());
                console.log($objBil.val(obj[counter - 1].No_Item));
                console.log("NExt");
                jumlah = (obj[counter - 1].Jumlah_anggaran);
                total += jumlah;
                console.log(total)

                $('#totalTblLojing').val(parseFloat(total).toFixed(2));

                //var selectObj_jnstugasLojing = $('#' + newId_jnstugasLojing)
                //selectObj_jnstugasLojing.dropdown('queryRemote', '', function () {
                //    selectObj_jnstugasLojing.dropdown("set selected", obj[counter - 1].JenisTugas)
                //    alert("masuk");
                //});

                //var selectObj_jnstugasLojing = $('#' + newId_jnstugasLojing)
                //jnstugasLojing.dropdown('set selected', obj[counter - 1].JenisTugas);
                //selectObj_jnstugasLojing.append("<option value = '" + obj[counter - 1].Butiran + "'>" + obj[counter - 1].Butiran + "</option>")

                //var selectObj_jnsMataWang = $('#' + newId_MtWangLojing)
                //selectObj_jnsMataWang.dropdown('queryRemote', '', function () {
                //    selectObj_jnsMataWang.dropdown("set selected", obj[counter - 1].Matawang)
                //});
                //var selectObj_tempatLojing = $('#' + newId_MtWangLojing)
                //tempatLojing.dropdown('set selected', obj[counter - 1].Matawang);
                //selectObj_tempatLojing.append("<option value = '" + obj[counter - 1].Matawang + "'>" + obj[counter - 1].Matawang + "</option>")

            }
            else {
                $objBil.val($('.input-md-txtBiltblLojing').length);
            }

            row.attr("style", "");
            $('#tblLojing tbody').append(row);

            generateDropdown_list("#" + newId_jnstugasLojing, "PengesahanLN_WS.asmx/GetJenisTugasTblSewaHotel", null)
            //generateDropdown_list("#" + newId_MtWangLojing, "LuarNegara1_WS.asmx/GetMataWang", null) 


            var selectObj_jnstugasLojing = $('#' + newId_jnstugasLojing)
            jnstugasLojing.dropdown('set selected', objOrder[counter - 1].Jenis_Tugas);
            selectObj_jnstugasLojing.append("<option value = '" + objOrder[counter - 1].Jenis_Tugas + "'>" + objOrder[counter - 1].Jenis_Tugas + " - " + objOrder[counter - 1].JenisTugas + "</option>")

            //var selectObj_MataWangLojing = $('#' + newId_MtWangLojing)
            //MataWangLojing.dropdown('set selected', objOrder[counter - 1].Matawang);
            //selectObj_MataWangLojing.append("<option value = '" + objOrder[counter - 1].Matawang + "'>" + objOrder[counter - 1].Matawang + " - " + objOrder[counter - 1].Matawang + "</option>")

            var val = "";

            counter += 1;

        }

    }

    $('#tblLojing').on('change', '.ddlJenisTugastblLojingA-list', async function (evt) {
        var $tr = $(this).closest("tr");
        console.log("masuk function 3113");
        var $ddlTugas = $tr.find(".ddlJenisTugastblLojingA-list");
        var $ddlNegara = $('#ddlNegaraTuju').val();

        if ($ddlTugas[0].firstChild.value === "") {
            return;
        }

        var amaun = await GetAmaunFromDB($ddlTugas[0].firstChild.value, $('#ddlNegaraTuju').val());
        var $elaun = $tr.find(".input-md.elauntblLojing-list");

        $elaun.val(parseFloat(amaun.Payload[0].ElnLojing).toFixed(2));
        console.log($elaun.val());
        CalculateAmountLojing($tr);
    })

    $('#tblLojing').on('keyup', '.input-md.haritblLojing-list', async function (evt) {
        var $tr = $(this).closest("tr");
        CalculateAmountLojing($tr);
    })

    async function CalculateAmountLojing($tr) {
        var $ddlTugas = $tr.find(".ddlJenisTugastblLojingA-list");
        var $ddlNegara = $('#ddlNegaraTuju').val();
        var $hari = $tr.find(".input-md.haritblLojing-list");
        var $elaun = $tr.find(".input-md.elauntblLojing-list");
        var $amaun = $tr.find(".input-md.amauntblLojing-list");

        if (isNaN($hari.val())) {
            $hari.val(0)
        }

        if (isNaN($elaun.val())) {
            $elaun.val(0);
        }
        var total = $hari.val() * $elaun.val();
        var KeseluruhanAmaun = 0.00;

        var $allAmaunt = $('.input-md.amauntblLojing-list');
        $amaun.val(total);

        $allAmaunt.each(function (ind, amaunObj) {
            if (amaunObj.value === "") {
                return;
            }

            KeseluruhanAmaun += parseFloat(amaunObj.value);
        })

        $('#totalTblLojing').val(KeseluruhanAmaun)
    }

    //di digunakan untuk kiraan auto calculate Jumlah setiap table
    $('#tblLojing').on('keyup', '.input-md.amauntblLojing-list', async function (evt) {
        console.log("keyup")
        var $tr = $(this).closest("tr");
        CalculateLojing($tr);
    })

    async function CalculateLojing($tr) {
        console.log("3701")
        var $amaun = $tr.find(".input-md.amauntblLojing-list");
        console.log($amaun.val())
        if (isNaN($amaun.val())) {
            $amaun.val(0)
        }

        var KeseluruhanAmaun = 0.00;
        var $allAmaunt = $('.input-md.amauntblLojing-list');

        $allAmaunt.each(function (ind, amaunObj) {
            if (amaunObj.value === "") {
                return;
            }

            KeseluruhanAmaun += parseFloat(amaunObj.value);
        })

        $('#totalTblLojing').val(KeseluruhanAmaun)
    }

    async function AjaxRecordElaunLojing(id) {
        console.log("masuk AJAX AjaxRecordElaunLojing ")

        try {

            const response = await fetch('PengesahanLN_WS.asmx/GetDataElaunLojing', {
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

    async function AjaxRecordSewaHotel(id) {
        console.log("masuk AJAX AjaxRecordSewaHotel ")

        try {

            const response = await fetch('PengesahanLN_WS.asmx/GetDataSewaHotel', {
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



    async function SetDataSewaHotel(totalClone, objOrder) {
        console.log("SetDataSewaHotel")
        var counter = 1;
        var table = $('#tblSewaHotel');
        var total = 0.00;


        if (objOrder !== null && objOrder !== undefined) {
            //totalClone = objOrder.Payload.OrderDetails.length;
            totalClone = objOrder.length;

        }

        while (counter <= totalClone) {

            curNumObject += 1;

            //var newId_coa = "ddlCOA" + curNumObject;
            var newId_bilHotel = "txtBiltblHotel" + curNumObject; //create new object pada table
            var newId_jnstugasHotel = "ddlJenisTugastblHotel" + curNumObject;
            var newId_resitHotel = "resittblHotel" + curNumObject;
            var newId_elaunHotel = "elauntblHotel" + curNumObject;
            var newId_hariHotel = "haritblHotel" + curNumObject;
            var newId_amaunHotel = "amauntblHotel" + curNumObject;
            var newId_attResit = "fileInputHotel" + curNumObject;
            var newBil = "txtBil" + curNumObject;


            var row = $('#tblSewaHotel tbody>tr:first').clone();

            // var dropdown5 = $(row).find(".COA-list").attr("id", newId_coa);
            //var bilHotel = $(row).find(".input-md-txtBiltblHotel-list").attr("id", newId_bilHotel).val($(".input-md-txtBiltblHotel-list").length);
            var $objBil = $(row).find(".input-md-txtBiltblHotel-list").attr("id", newId_bilHotel);
            var jnstugasHotel = $(row).find(".ddlJenisTugastblHotel-list").attr("id", newId_jnstugasHotel);
            var resitHotel = $(row).find(".resittblHotel-list").attr("id", newId_resitHotel);
            var elaunHotel = $(row).find(".elauntblHotel-list").attr("id", newId_elaunHotel);
            var hariHotel = $(row).find(".haritblHotel-list").attr("id", newId_hariHotel);
            var amaunHotel = $(row).find(".amauntblHotel-list").attr("id", newId_amaunHotel);
            var AttResit = $(row).find(".fileInputHotel").attr("id", newId_attResit);
            var Lampiran = $(row).find(".tempFileHotel").attr("id", "tempFile" + curNumObject);


            var $objBil = $(row).find('.input-md-txtBiltblHotel-list');
            $objBil.attr("id", newBil);


            if (objOrder !== null && objOrder !== undefined) {
                var obj = objOrder;

                console.log(obj[counter - 1].No_Item);
                console.log(obj[counter - 1].Jenis_Tugas);
                console.log(obj[counter - 1].Bil_Hari);
                console.log(obj[counter - 1].No_Resit);
                console.log(obj[counter - 1].Kadar_Harga);
                console.log(obj[counter - 1].Jumlah_anggaran);
                console.log(objOrder[counter - 1].Kadar_Pertukaran);
                $('#kadarPertukaran').val(objOrder[counter - 1].Kadar_Pertukaran);

                var newId = $('#ddlNegaraTuju')
                var ddlNegaraTuju = $('#ddlNegaraTuju')
                var ddlSearch = $('#ddlNegaraTuju')
                var ddlText = $('#ddlNegaraTuju')
                var selectObj_Negara = $('#ddlNegaraTuju')
                $(ddlNegaraTuju).dropdown('set selected', objOrder[counter - 1].Negara);
                selectObj_Negara.append("<option value = '" + objOrder[counter - 1].Negara + "'>" + objOrder[counter - 1].Negara + "</option>")

                var newId = $('#mataWangHotel')
                var ddlMataWang = $('#mataWangHotel')
                var ddlSearch = $('#mataWangHotel')
                var ddlText = $('#mataWangHotel')
                var selectObj_MataWang = $('#mataWangHotel')
                $(ddlMataWang).dropdown('set selected', objOrder[counter - 1].Matawang);
                selectObj_MataWang.append("<option value = '" + objOrder[counter - 1].Matawang + "'>" + objOrder[counter - 1].Matawang + "</option>")

                var $tempFilePreview = $(row).find(".tempFileHotel");
                var $link1 = obj[counter - 1].Path

                console.log($objBil.val($('.input-md-txtBiltblHotel-list').length));

                $objBil.val(obj[counter - 1].No_Item)

                jnstugasHotel.val(obj[counter - 1].Jenis_Tugas);
                resitHotel.val(obj[counter - 1].No_Resit);
                hariHotel.val(obj[counter - 1].Bil_Hari);
                amaunHotel.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));
                elaunHotel.val(parseFloat(obj[counter - 1].Kadar_Harga).toFixed(2));


                $tempFilePreview.attr("href", $link1);
                $tempFilePreview.html(obj[counter - 1].Nama_Fail);
                console.log($tempFilePreview.html());
                console.log($objBil.val(obj[counter - 1].No_Item));
                console.log("NExt");
                jumlah = (obj[counter - 1].Jumlah_anggaran);
                total += jumlah;
                console.log(total)
                $('#totaltblHotel').val(parseFloat(total).toFixed(2));


                //var selectObj_jnstugasHotel = $('#' + newId_jnstugasHotel)
                //selectObj_jnstugasHotel.dropdown('queryRemote', '', function () {
                //    selectObj_jnstugasHotel.dropdown("set selected", obj[counter - 1].JenisTugas)
                //    alert("masuk");
                //});

                //var selectObj_jnsMataWang = $('#' + newId_Matawang)
                //selectObj_jnsMataWang.dropdown('queryRemote', '', function () {
                //    selectObj_jnsMataWang.dropdown("set selected", obj[counter - 1].Matawang)
                //    alert("masuk 2");
                //});
            }
            else {
                $objBil.val($('.input-md-txtBiltblHotel-list').length);
            }

            row.attr("style", "");

            $('#tblSewaHotel tbody').append(row);

            generateDropdown_list("#" + newId_jnstugasHotel, "PengesahanLN_WS.asmx/GetJenisTugasTblSewaHotel", null)
            //generateDropdown_list("#" + newId_Matawang, "LuarNegara1_WS.asmx/GetMataWang", null)

            var selectObj_jnstugasHotel = $('#' + newId_jnstugasHotel)
            jnstugasHotel.dropdown('set selected', objOrder[counter - 1].Jenis_Tugas);
            selectObj_jnstugasHotel.append("<option value = '" + objOrder[counter - 1].Jenis_Tugas + "'>" + objOrder[counter - 1].Jenis_Tugas + " - " + objOrder[counter - 1].JenisTugas + "</option>")

            //var selectObj_MataWangHotel = $('#' + newId_Matawang)
            //MataWangHotel.dropdown('set selected', objOrder[counter - 1].Matawang);
            //selectObj_MataWangHotel.append("<option value = '" + objOrder[counter - 1].Matawang + "'>" + objOrder[counter - 1].Matawang + " - " + objOrder[counter - 1].Jenis_Tugas + "</option>")



            var val = "";
            counter += 1;
        }

    }



    $('#tblSewaHotel').on('change', '.ddlJenisTugastblHotel-list', async function (evt) {
        var $tr = $(this).closest("tr");

        var $ddlTugas = $tr.find(".ddlJenisTugastblHotel-list");
        var $ddlNegara = $('#ddlNegaraTuju').val();

        if ($ddlTugas[0].firstChild.value === "") {
            return;
        }

        var amaun = await GetAmaunFromDB($ddlTugas[0].firstChild.value, $('#ddlNegaraTuju').val());
        var $elaun = $tr.find(".elauntblHotel-list");

        $elaun.val(amaun.Payload[0].SewaHotel);
        CalculateAmount($tr);
    })


    async function GetAmaunFromDB(jnsTugas, jnsNegara) {

        console.log({ jnsTugas: jnsTugas, jnsNegara: jnsNegara });
        try {

            const response = await fetch('PengesahanLN_WS.asmx/kiraElaunHotel', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ jnsTugas: jnsTugas, jnsNegara: jnsNegara })
            });
            const data = await response.json();
            return JSON.parse(data.d);
        } catch (error) {
            console.error('Error:', error);
            return error;
        }
    }

    $('#tblSewaHotel').on('keyup', '.haritblHotel-list', async function (evt) {
        var $tr = $(this).closest("tr");
        CalculateAmount($tr);
    })

    //di digunakan untuk kiraan auto calculate Jumlah setiap table
    $('#tblSewaHotel').on('keyup', '.amauntblHotel-list', async function (evt) {
        console.log("keyup")
        var $tr = $(this).closest("tr");
        CalculateHotel($tr);
    })

    async function CalculateAmount($tr) {
        var $ddlTugas = $tr.find(".ddlJenisTugastblHotel-list");
        var $ddlNegara = $('#ddlNegaraTuju').val();
        var $hari = $tr.find(".input-md.haritblHotel-list");
        var $elaun = $tr.find(".input-md.elauntblHotel-list");
        var $amaun = $tr.find(".input-md.amauntblHotel-list");

        if (isNaN($hari.val())) {
            $hari.val(0)
        }

        if (isNaN($elaun.val())) {
            $elaun.val(0);
        }
        var total = $hari.val() * $elaun.val();
        var KeseluruhanAmaun = 0.00;

        var $allAmaunt = $('.input-md.amauntblHotel-list');
        $amaun.val(total);

        $allAmaunt.each(function (ind, amaunObj) {
            if (amaunObj.value === "") {
                return;
            }

            KeseluruhanAmaun += parseFloat(amaunObj.value);
        })

        $('#totaltblHotel').val(KeseluruhanAmaun)
    }

    async function CalculateHotel($tr) {
        console.log("3701")
        var $amaun = $tr.find(".amauntblHotel-list");
        console.log($amaun.val())
        if (isNaN($amaun.val())) {
            $amaun.val(0)
        }

        var KeseluruhanAmaun = 0.00;
        var $allAmaunt = $('.amauntblHotel-list');

        $allAmaunt.each(function (ind, amaunObj) {
            if (amaunObj.value === "") {
                return;
            }

            KeseluruhanAmaun += parseFloat(amaunObj.value);
        })

        $('#totaltblHotel').val(KeseluruhanAmaun)
    }

    //function addrow bagi tab lojing
    $(function () {
        $('.btnAddRow-tabLojing.One').click();
    });

    $('.btnAddRow-tabLojing').click(async function () {

        var totalClone = $(this).data("val");
        await SetDataElaunLojing(totalClone);
    });

    //di digunakan untuk kiraan auto calculate Jumlah setiap table
    $('#tblLojing').on('keyup', '.amauntblLojing-list', async function (evt) {
        console.log("keyup")
        var $tr = $(this).closest("tr");
        CalculateLojing($tr);
    })

    async function CalculateLojing($tr) {
        console.log("3701")
        var $amaun = $tr.find(".amauntblLojing-list");
        console.log($amaun.val())
        if (isNaN($amaun.val())) {
            $amaun.val(0)
        }

        var KeseluruhanAmaun = 0.00;
        var $allAmaunt = $('.amauntblLojing-list');

        $allAmaunt.each(function (ind, amaunObj) {
            if (amaunObj.value === "") {
                return;
            }

            KeseluruhanAmaun += parseFloat(amaunObj.value);
        })

        $('#totalTblLojing').val(KeseluruhanAmaun)
    }

    //klik tab-pelbagai
    $('#tab-pelbagai').click(async function () {

        console.log("masuk tab-pelbagai")
        $('#noPermohonan').val();
        var id = $('#noPermohonan').val();
        var tkhMohon1 = $('#tkhMohon2').val();
        $('#txtMohonID7').val(id);
        $('#tkhMohon7').val(tkhMohon1);    

        if (id !== "") {
            clearAlltblPelbagai();
            //BACA DETAIL JURNAL
            var recordDataPelbagai = await AjaxGetDataPelbagai(id);  //Baca data pada table Keperluan             
            //await clearAllRows();
            await SetDataPelbagaiRows(null, recordDataPelbagai); //setData pada table
        }

        return false;

    })

    async function AjaxGetDataPelbagai(id) {
        try {

            const response = await fetch('PengesahanLN_WS.asmx/GetDataPelbagai', {
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

    async function clearAlltblPelbagai() {
        console.log("masuk clearAlltblPelbagai")
        $('#tblPelbagai' + " > tbody > tr ").each(function (index, obj) {
            if (index > 0) {
                obj.remove();
            }
        })

    }

    async function SetDataPelbagaiRows(totalClone, objOrder) {

        var counter = 1;
        var table = $('#tblPelbagai');
        var total = 0.00;
        var jumlah = 0.00;


        $('#tkhMohon7').val(objOrder[counter - 1].Tarikh_Mohon)

        if (objOrder !== null && objOrder !== undefined) {
            //totalClone = objOrder.Payload.OrderDetails.length;
            totalClone = objOrder.length;

        }

        while (counter <= totalClone) {

            curNumObject += 1;

            //var newId_coa = "ddlCOA" + curNumObject;
            var newBil = "txtBil" + curNumObject;
            var newId_jenisBP = "JenisPelbagai-list" + curNumObject;
            var newId_lbljenisBP = "lblJenisPelbagai" + curNumObject;
            var newId_hidjenisBP = "HidlblJenisPelbagai" + curNumObject;
            var newId_DengResitBP = "checkbox_DengResitBP" + curNumObject;
            var newId_lblDengResitBP = "lblDengResitBP" + curNumObject;
            var newId_TanpaResitBP = "checkbox_TanpaResitBP" + curNumObject;
            var newId_lblTanpaResitBP = "lblTanpaResitBP" + curNumObject;
            var newId_noResitBP = "noResitBP" + curNumObject;
            var newId_lblnoResitBP = "lblnoResitBP" + curNumObject;
            var newId_AmaunBP = "AmaunBP" + curNumObject;
            var newId_lblAmaunBP = "lblAmaunBP" + curNumObject;
            var newId_attResit = "fileInputPelbagai" + curNumObject;

            var row = $('#tblPelbagai tbody>tr:first').clone();


            var JenisPelbagaiBP = $(row).find(".JenisPelbagai-list").attr("id", newId_jenisBP);
            var lbljnsPelbagaiBP = $(row).find(".label-jenisPelbagai-list").attr("id", newId_lbljenisBP);
            var hidjnsPelbagaiBP = $(row).find(".Hid-jenisPelbagai-list").attr("id", newId_hidjenisBP);
            var checkbox_DengResitBP = $(row).find(".checkbox_DengResitBP-list").attr("id", newId_DengResitBP);
            var lblDengResitBP = $(row).find(".lblDengResitBP-list").attr("id", newId_lblDengResitBP);
            var checkbox_TanpaResitBP = $(row).find(".checkbox_TanpaResitBP-list").attr("id", newId_TanpaResitBP);
            var lblTanpaResitBP = $(row).find(".lblTanpaResitBP-list").attr("id", newId_lblTanpaResitBP);
            var noResitBP = $(row).find(".input-md-noResitBP").attr("id", newId_noResitBP);
            var lblnoResitBP = $(row).find(".lblnoResitBP-list").attr("id", newId_lblnoResitBP);
            var amaunBP = $(row).find(".input-md-AmaunBP").attr("id", newId_AmaunBP);
            var lblAmaunBP = $(row).find(".lblAmaunBP-list").attr("id", newId_lblAmaunBP);
            var AttResit = $(row).find(".fileInputPelbagai").attr("id", newId_attResit);
            var Lampiran = $(row).find(".tempFilePelbagai").attr("id", "tempFilePelbagai" + curNumObject);
            var $objBil = $(row).find('.txtBil');
            $objBil.attr("id", newBil);


            if (objOrder !== null && objOrder !== undefined) {
                var obj = objOrder;

                console.log(obj[counter - 1].No_Item);
                console.log(obj[counter - 1].Butiran);
                console.log(obj[counter - 1].Flag_Resit);
                console.log(obj[counter - 1].No_Resit);
                console.log(obj[counter - 1].Jumlah_anggaran);
               
                 
                console.log("next")
                if (obj[counter - 1].Flag_Resit === true) {
                    console.log("masuk checked")
                    $(row).find(".checkbox_DengResitBP-list").prop("checked", true);
                }


                if (obj[counter - 1].Flag_Resit === false) {
                    console.log("masuk checked")
                    checkbox_TanpaResitBP.prop("checked", true);

                }

                var $tempFilePreview = $(row).find(".tempFilePelbagai");
                var $link1 = obj[counter - 1].Path
                console.log($objBil.val($('.txtBil').length));

               
                $objBil.val(obj[counter - 1].No_Item)
                JenisPelbagaiBP.val(obj[counter - 1].Butiran);
                lbljnsPelbagaiBP.val(obj[counter - 1].Jenis_Tambang);
                hidjnsPelbagaiBP.val(obj[counter - 1].Jenis_Tambang);
                noResitBP.val(obj[counter - 1].No_Resit);
                amaunBP.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));
                $tempFilePreview.attr("href", $link1);
                $tempFilePreview.html(obj[counter - 1].Nama_Fail);

                var newId = $('#ddlNegaraTujuP')
                var ddlNegaraTuju = $('#ddlNegaraTujuP')
                var ddlSearch = $('#ddlNegaraTujuP')
                var ddlText = $('#ddlNegaraTujuP')
                var selectObj_Negara = $('#ddlNegaraTujuP')
                $(ddlNegaraTuju).dropdown('set selected', objOrder[counter - 1].Negara);
                selectObj_Negara.append("<option value = '" + objOrder[counter - 1].Negara + "'>" + objOrder[counter - 1].Negara + "</option>")

                var newId = $('#mataWangPelbagai')
                var ddlMataWang = $('#mataWangPelbagai')
                var ddlSearch = $('#mataWangPelbagai')
                var ddlText = $('#mataWangPelbagai')
                var selectObj_MataWang = $('#mataWangPelbagai')
                $(ddlMataWang).dropdown('set selected', objOrder[counter - 1].Matawang);
                selectObj_MataWang.append("<option value = '" + objOrder[counter - 1].Matawang + "'>" + objOrder[counter - 1].Matawang + "</option>")

                console.log($objBil.val(obj[counter - 1].No_Item));
                console.log("NExt");
                jumlah = (obj[counter - 1].Jumlah_anggaran);
                total += jumlah;
                console.log(total)
                $('#totalRm').val(parseFloat(total).toFixed(2))
            }
            else {
                $objBil.val($('.txtBil').length);
            }

            row.attr("style", "");
            var val = "";

            $('#tblPelbagai tbody').append(row);

            generateDropdown_list("#" + newId_jenisBP, "PengesahanLN_WS.asmx/GetJenisPelbagai")
            var selectObj_JenisBP = $('#' + newId_jenisBP)
            JenisPelbagaiBP.dropdown('set selected', obj[counter - 1].Butiran);
            selectObj_JenisBP.append("<option value = '" + obj[counter - 1].Jenis_Belanja_Pelbagai + "'>" + obj[counter - 1].Butiran + "</option>")


            counter += 1;
        }
    }

    async function clearAlltblSumbangan() {
        console.log("masuk clearAlltblSumbangan ")
        $('#tblSumbangan' + " > tbody > tr ").each(function (index, obj) {
            if (index > 0) {
                obj.remove();
            }
        })

    }
    //Bila klik Tab tab-Sumbangan
    $('#tab-sumbangan').click(async function () {       
        $('#noPermohonan').val();
        var id = $('#noPermohonan').val();
        var tkhMohon = $('#tkhMohon2').val();
        $('#txtMohonID9').val(id);
        $('#tkhMohon9').val(tkhMohon);
        //loadDataKenyataan(id)

        if (id !== "") {
            clearAlltblSumbangan();
            //BACA DETAIL JURNAL
            var recordDataSumbangan = await AjaxGetDataSumbangan(id);  //Baca data pada table Keperluan             
            //await clearAllRows();
            await SetDataSumbanganRows(null, recordDataSumbangan); //setData pada table
        }

        return false;
    })

    async function AjaxGetDataSumbangan(id) {

        try {

            const response = await fetch('PengesahanLN_WS.asmx/GetDatSumbangan', {
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

    async function SetDataSumbanganRows(totalClone, objOrder) {

        var counter = 1
        var table = $('#tblSumbangan');
        var total = 0.00;
        var totalJarak;

        if (objOrder !== null && objOrder !== undefined) {   //semak berapa object yang ada
            totalClone = objOrder.length;
        }


        while (counter <= totalClone) {
            curNumObject += 1;
            console.log("curNumObject")
            console.log(curNumObject)

            var newId_bil = "txtBilSumbangan-list" + curNumObject; //create new object pada table
            var newId_JnsTabung = "ddlSumbangan" + curNumObject;
            var newId_jumlahSumbangan = "txtSumbangan" + curNumObject;


            var row = $('#tblSumbangan tbody>tr:first').clone();

            var $objBil = $(row).find(".txtBilSumbangan-list").attr("id", newId_bil);
            var jnsTabung = $(row).find(".JenisSumbangan-list").attr("id", newId_JnsTabung);
            var jumlahSumbang = $(row).find(".input-md-txtSumbangan").attr("id", newId_jumlahSumbangan);


            if (objOrder !== null && objOrder !== undefined) {
                var obj = objOrder;
                console.log(obj[counter - 1].Butiran);
                console.log(obj[counter - 1].Jumlah_anggaran);

                console.log("Next");
                jnsTabung.val(obj[counter - 1].Butiran);
                jumlahSumbang.val(parseFloat(obj[counter - 1].Jumlah_anggaran).toFixed(2));


                total += jumlahSumbang.val();

                console.log($objBil.val($('.txtBilSumbangan-list').length));
                console.log("3134");

            }
            else {
                $objBil.val($('.txtBilSumbangan-list').length);
            }


            row.attr("style", "");  //style pada row
            $('#tblSumbangan tbody').append(row);  //bind data start pada row yang first pada tblData2

            generateDropdown_list("#" + newId_JnsTabung, "PengesahanLN_WS.asmx/GetJenisSumbangan")

            var selectObj_JenisTabung = $('#' + newId_JnsTabung)
            jnsTabung.dropdown('set selected', objOrder[counter - 1].Kod_Tabung);
            selectObj_JenisTabung.append("<option value = '" + objOrder[counter - 1].Kod_Tabung + "'>" + objOrder[counter - 1].Kod_Tabung + " - " + objOrder[counter - 1].Butiran + "</option>")


            counter += 1;
        }
        $('#totalTabung').val(parseFloat(total).toFixed(2));

    }


    //di digunakan untuk kiraan auto calculate Jumlah setiap table
    $('#tblSumbangan').on('keyup', '.input-md-txtSumbangan', async function (evt) {
        console.log("keyup")
        var $tr = $(this).closest("tr");
        CalculateTabung($tr);
    })

    async function CalculateTabung($tr) {
        console.log("3701")
        var $amaun = $tr.find(".input-md-txtSumbangan");
        console.log($amaun.val())
        if (isNaN($amaun.val())) {
            $amaun.val(0)
        }

        var KeseluruhanAmaun = 0.00;
        var $allAmaunt = $('.input-md-txtSumbangan');

        $allAmaunt.each(function (ind, amaunObj) {
            if (amaunObj.value === "") {
                return;
            }

            KeseluruhanAmaun += parseFloat(amaunObj.value);
        })

        $('#totalTabung').val(parseFloat(KeseluruhanAmaun).toFixed(2))
    }

    //Bila klik  tab-pengesahan
    $('#tab-pengesahan').click(async function () {
        console.log("masuk tab-pengangkutann")
        $('#noPermohonan').val();
        var id = $('#noPermohonan').val();
        $('#txtMohonID4').val(id);
        var totalPelbagai = parseFloat($('#totalRm').val()).toFixed(2);
        console.log(totalPelbagai);


        if (id !== "") {
            //BACA DETAIL JURNAL

            var recordDataPengesahan = await AjaxDataPengesahan(id);  //Baca data pada table Keperluan             
            //await clearAllRows();
            await setDataPengesahan(recordDataPengesahan); //setData pada table
            //getDataPengesahan();

        }
        return false;
    })


    async function AjaxDataPengesahan(id) {

        try {

            const response = await fetch('PengesahanLN_WS.asmx/LoadListPengesahan', {
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

    async function setDataPengesahan(data) {
        console.log(data)
        var jumHotel
        var jumElaunMakan
        var jumPelbagai
        var totalKeseluruhan
        var tolakSumbangan
        var tolakPendahuluan
        var totalTolak
        var TotalTuntutan
        //data = JSON.parse(data);
        //if (data.id === "") {
        //    alert("Tiada data");
        //    return false;
        //}
        console.log("setDataPengesahan ")
        //$('#txtGantiKadar').val(data[0].Param2)
        jumHotel = data[0].Jumlah_Sewa_HotelLojing
        jumElaunMakan = data[0].Jumlah_Elaun_Mkn
        jumPelbagai = data[0].Jumlah_Belanja_Pelbagai
        tolakSumbangan = data[0].Jum_Sumbangan
        tolakPendahuluan = data[0].Jum_Pendahuluan
        totalTolak = parseFloat(tolakSumbangan) + parseFloat(tolakPendahuluan)

        totalKeseluruhan = parseFloat(jumHotel) + parseFloat(jumElaunMakan) + parseFloat(jumPelbagai)
        console.log(totalKeseluruhan)
        $('#txtMohonID8').val(data[0].No_Tuntutan);
        $('#tkhMohon8').val(data[0].Tarikh_Mohon);
        $('#txtJumTuntutan').val(parseFloat(totalKeseluruhan).toFixed(2));
        $('#txtTolakSumbangan').val(parseFloat(data[0].Jum_Sumbangan).toFixed(2));
        $('#txtTolakPendahuluan').val(parseFloat(data[0].Jum_Pendahuluan).toFixed(2));
        $('#txtGantiKadar').val(parseFloat(data[0].Jum_Gantirugi).toFixed(2));
        $('#txtJumlahK').val(parseFloat(data[0].Jum_Tuntut).toFixed(2));
        $('#txtBakiBesar').val(parseFloat(data[0].Jum_Baki_Tuntut).toFixed(2));
        $('#txtBelanja').val(parseFloat(data[0].Jum_Belanja_Sendiri).toFixed(2));

        $('#hidJenDokBelanja').val(data[0].Path_Belanja)
        $('#hidFileNameBelanja').val(data[0].Nama_Fail_Belanja)
        $('#uploadedFileNameLabelBelanja').val(fileName)

        //$('#txtNamaFile').val(obj[counter - 1].Nama_Fail_LampiranA)
        //Checkbox2.val(obj[counter - 1].Flag_Muzla);

        var fileName = data[0].Nama_Fail_Belanja
        //var resolvedUrl = "../UPLOAD/DOCUMENT/PENDAHULUAN DAN TUNTUTAN/PD/"
        var fileLink = document.createElement("a");
        fileLink.href = data[0].Path_Belanja;
        fileLink.textContent = fileName;

        var uploadedFileNameLabel = document.getElementById("uploadedFileNameLabelBelanja");
        uploadedFileNameLabel.innerHTML = "";
        uploadedFileNameLabel.appendChild(fileLink);


        //$("#uploadedFileNameLabel").show();
        // Clear the file input
        $("#fileInputBelanja").val("");


        $('#txtGantiKadar').keyup(async function () {

            CalculateGantiRugi($('#txtGantiKadar'));
            TotalTuntutan = $('#txtJumlahK').val()
            bakiBersih = parseFloat(TotalTuntutan) - parseFloat(totalTolak);
            console.log(bakiBersih)
            $('#txtBakiBesar').val(parseFloat(bakiBersih).toFixed(2));
        });

    }


    async function CalculateGantiRugi(kadarGanti) {
        var jumtuntutan = $('#txtJumTuntutan').val();
        var kdrGanti = $('#txtGantiKadar').val();
        var totalKadar
        console.log("masuk kira jadar ganti")
        console.log(jumtuntutan);
        console.log(kdrGanti);

        totalKadar = parseFloat(jumtuntutan) + parseFloat(kdrGanti);
        $('#txtJumlahK').val(parseFloat(totalKadar).toFixed(2));

    }


   <%-- function getDataPengesahan() {
        $('#noPermohonan').val();
        var id = $('#noPermohonan').val();


        fetch('PengesahanLN_WS.asmx/GetDataPengesahanLN', {
            method: 'POST',
            headers: {
                'Content-Type': "application/json"
            },
         //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
         body: JSON.stringify({ id: id })
     })
            .then(response => response.json())
            .then(data => setDataPengesahan(data.d))
    }--%>

   


   


    $('.Sokong').click(async function () {
        $('#modalSah').modal('toggle');
        $('#modalSenarai').modal('toggle');
        loadRecordPelulus($('#noPermohonan').val())
    });

    function loadRecordPelulus(nomohon) {
        //Cara Pertama

        var mohonID = nomohon
        console.log(mohonID)

        fetch('PengesahanLN_WS.asmx/GetDataPelulus', {
            method: 'POST',
            headers: {
                'Content-Type': "application/json"
            },
             //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
        body: JSON.stringify({ mohonID: mohonID })
    })
           .then(response => response.json())
           .then(data => setDataPelulus(data.d))

   }

   function setDataPelulus(data) {
       data = JSON.parse(data);
       if (data.mohonID === "") {
           alert("Tiada data");
           return false;
       }
       //console.log(data);
       $('#namaPengesah').val(data[0].NamaPelulus);
       $('#jwtnPengesah').val(data[0].Jawatan);

         //$('#<%'=txtMemangku.ClientID%>').val(data[0].Param3);

    }

    $('.btnSavePelulus').click(async function () {


        $('#modalSenarai').modal('hide');
        //$('#penerimaan').modal('hide');

        if ($("input[type='radio'].radioBtnClass").is(':checked')) {
            var card_type = $("input[type='radio'].radioBtnClass:checked").val();
            // alert(card_type);
        }

        //console.log("status")
        //console.log(card_type)

        var UpdateData = {
            SokongLN: {
                mohonID: $('#noPermohonan').val(),
                stafID: '<%=Session("ssusrID")%>',
                catatan: $('#txtCatatan').val(),
                statusDok: card_type,

            }
        }

        let confirm = false
        confirm = await show_message_async("Anda pasti ingin menyimpan rekod ini?")
        console.log(confirm)
        if (!confirm) {
            return
        }
        else {

            show_loader();
            var result = JSON.parse(await ajaxSavePelulus(UpdateData));
            close_loader();
            tbl.ajax.reload();
        }

    });

    async function ajaxSavePelulus(id) {

        return new Promise((resolve, reject) => {
            $.ajax({
                url: 'PengesahanLN_WS.asmx/SaveRecordSokong',
                method: 'POST',
                data: JSON.stringify(id),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (data) {
                    var response = JSON.parse(data.d)
                    console.log(response);
                    notification(response.Message);
                    resolve(data.d);
                    //alert(resolve(data.d));
                },
                error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                    reject(false);
                }

            });
        })

    }

    function notification(msg) {
        $("#notify").html(msg);
        $("#NotifyModal").modal('show');
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




</script>


</asp:Content>
