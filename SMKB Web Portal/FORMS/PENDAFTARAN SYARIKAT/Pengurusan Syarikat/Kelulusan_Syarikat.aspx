<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Kelulusan_Syarikat.aspx.vb" Inherits="SMKB_Web_Portal.Kelulusan_Syarikat" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

     <div id="PermohonanTab" class="tabcontent" style="display: block">
     <div id="SenaraiKelulusan">
         <div>
             <div class="modal-body">
                 <div class="modal-header">
                     <h5 class="modal-title">Senarai Syarikat</h5>
                 </div>
                 <!-- Create the dropdown filter -->
                 <div class="Search-Filter">
                     <div class="form-row col-sm-12" style="margin-top: 2%;">
                         <label for="tindakanFilter" class="col-sm-4 col-form-label" style="text-align: right;">Tindakan</label>
                         <div class="col-sm-3">
                             <select id="tindakanFilter" class="custom-select">
                                 <option value="1" selected>Kelulusan Pendaftaran Syarikat</option>
                                 <option value="2">Kelulusan Kemaskini Pedaftaran Syarikat</option>
                             </select>
                         </div>
                     </div>

                     <br />
                     <div class="form-row col-sm-12">
                         <label for="lblCarian" class="col-sm-4 col-form-label" style="text-align: right;">Carian</label>
                         <div class="col-sm-3">
                             <div class="input-group">
                                 <select id="categoryFilter" class="custom-select">
                                     <option value="" selected>Semua</option>
                                     <option value="1">Hari Ini</option>
                                     <option value="2">Semalam</option>
                                     <option value="3">7 Hari Lepas</option>
                                     <option value="4">30 Hari Lepas</option>
                                     <option value="5">60 Hari Lepas</option>
                                     <option value="6">Pilih Tarikh</option>
                                 </select>
                                 <div class="input-group-append">
                                     <button id="btnSearch" runat="server" class="btn btnSearch" type="button">
                                         <i class="fa fa-search"></i>
                                     </button>
                                 </div>
                             </div>
                         </div>
                         <div class="col-sm-10 mt-4 d-none mx-auto align-items-center" id="divDatePicker" style="display: none;">
                             <div class="d-flex flex-row justify-content-around">
                                 <div class="form-group row">
                                     <label class="col-sm-3 col-form-label text-nowrap">Mula:</label>
                                     <div class="col-sm-9">
                                         <input type="date" id="txtTarikhStart" name="txtTarikhStart" class="form-control date-range-filter">
                                     </div>
                                 </div>
                                 <div class="form-group row ml-3">
                                     <label class="col-sm-3 col-form-label text-nowrap">Tamat:</label>
                                     <div class="col-sm-9">
                                         <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" class="form-control date-range-filter">
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
                 <%--  <div class="search-filter">
                     <div class="form-row justify-content-center">
                         <div class="form-group row col-sm-12">
                             <label for="ddlTindakan" class="col-sm-2 col-form-label" style="text-align: right;">Tindakan</label>
                             <div class="col-sm-3">
                                 <select id="ddlTindakan" class="ui search dropdown" name="ddlTindakan"></select>
                             </div>
                         </div>
                         <br />
                         <div id="Tempoh_Daftar" class="justify-content-center">
                             <div class="form-row form-group row col-sm-12">
                                 <label for="categoryFilter" class="col-md-4 col-form-label" style="text-align: right;">Carian Bil</label>
                                 <div class="col-md-8">
                                     <div class="input-group">
                                         <select id="categoryFilter" class="custom-select">
                                             <option value="" selected>Semua</option>
                                             <option value="1">Hari Ini</option>
                                             <option value="2">Semalam</option>
                                             <option value="3">7 Hari Lepas</option>
                                             <option value="4">30 Hari Lepas</option>
                                             <option value="5">60 Hari Lepas</option>
                                             <option value="6">Pilih Tarikh</option>
                                         </select>
                                         <div class="input-group-append">
                                             <button id="btnSearchPenaja" runat="server" class="btn btnSearchPenaja" onclick="return beginSearch();" type="button">
                                                 <i class="fa fa-search"></i>
                                             </button>
                                         </div>
                                     </div>
                                 </div>
                                 <div class="col-sm-10 mt-4 d-none mx-auto align-items-center" id="divDatePicker" style="display: none;">
                                     <div class="d-flex flex-row justify-content-around">
                                         <div class="form-group row">
                                             <label class="col-sm-3 col-form-label text-nowrap">Mula:</label>
                                             <div class="col-sm-9">
                                                 <input type="date" id="txtTarikhStart" name="txtTarikhStart" class="form-control date-range-filter">
                                             </div>
                                         </div>
                                         <div class="form-group row ml-3">
                                             <label class="col-sm-3 col-form-label text-nowrap">Tamat:</label>
                                             <div class="col-sm-9">
                                                 <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" class="form-control date-range-filter">
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>--%>


                 <div id="divSyarikatBerdaftar" class="row">
                     <div class="col-md-12">
                         <div class="transaction-table table-responsive ">
                             <table id="tblDataSenaraiSyarikatBerdaftar" class="table table-striped ">
                                 <thead>
                                     <tr style="width: 100%">
                                         <th scope="col" style="width: 5%">Bil</th>
                                         <th scope="col" style="width: 10%">No. Pendaftaran Syarikat</th>
                                         <th scope="col" style="width: 10%">ID Syarikat</th>
                                         <th scope="col" style="width: 15%">Nama Syarikat</th>
                                         <th scope="col" style="width: 15%">Perniagaan Utama</th>
                                         <th scope="col" style="width: 10%">Tarikh Daftar</th>
                                         <th scope="col" style="width: 10%">Tarikh Lulus</th>
                                         <th scope="col" style="width: 10%">Status Aktif</th>
                                         <th scope="col" style="width: 12%">Tindakan</th>
                                     </tr>
                                 </thead>
                                 <tbody id=" ">
                                 </tbody>
                             </table>
                         </div>
                     </div>
                 </div>
                 <br />
                 <div class="modal-footer modal-footer--sticky" id="footerpenaja" style="display: none">
                     <div class="form-group col-md-12" align="right">
                         <%--<button type="button" class="btn btn-danger btnTidakLulus">Tidak Lulus</button>--%>
                         <span><b>Jumlah (<span id="stickyJumlahItem" style="margin-right: 5px">0</span> item) :RM <span id="stickyJumlah"
                             style="margin-right: 5px">0.00</span></b></span>
                         <button type="button" class="btn" id="showModalButton"><i class="fas fa-angle-up"></i></button>
                         <button type="button" class="btn btn-secondary btnCetakResit" data-toggle="tooltip" data-placement="bottom" title="Cetak Resit" style="display: none"><i class="fa fa-print" aria-hidden="true"></i>Cetak Resit</button>
                         <button type="button" class="btn btn-secondary btnCetak" data-toggle="tooltip" data-placement="bottom" title="Cetak Bil"><i class="fa fa-print" aria-hidden="true"></i>Cetak Bil</button>
                         <button type="button" class="btn btn-success btnBayar" data-toggle="tooltip" data-placement="bottom" title="Buat Bayaran">Bayar</button>
                         <%--<div class="form-row justify-content-end" >
                                 <div class="btn btn-primary btnBayarPenaja" onclick="ShowPopup('2')" >
                                     Bayar
                                 </div>
                             </div>--%>
                     </div>
                 </div>
             </div>
         </div>
     </div>
 </div>

 <script type="text/javascript">

     var tblDataSyaDaftar = null;
     $(document).ready(function () {
         let IsClicked = false;
         /* show_loader();*/
         tblDataSyaDaftar = $("#tblDataSenaraiSyarikatBerdaftar").DataTable({
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
                 "url": "SyarikatBerdaftar_WS.asmx/LoadList_KelulusanSyarikatDaftar",
                 "method": 'POST',
                 "contentType": "application/json; charset=utf-8",
                 "dataType": "json",
                 "dataSrc": function (json) {
                     return JSON.parse(json.d);
                 },
                 "data": function () {
                     //Filter category bermula dari sini - 20 julai 2023
                     var tkhMula = $('#txtTarikhStart').val();
                     var tkhTamat = $('#txtTarikhEnd').val();

                     return JSON.stringify({
                         category_filter: $('#categoryFilter').val(),
                         Tindakan: $('#tindakanFilter').val(),
                         isClicked: IsClicked,
                         tkhMula: tkhMula,
                         tkhTamat: tkhTamat
                     })
                     //akhir sini
                 }
             },
             "rowCallback": function (row, data) {
                 // Add hover effect
                 //$(row).hover(function () {
                 //    $(this).addClass("hover pe-auto bg-warning");
                 //}, function () {
                 //    $(this).removeClass("hover pe-auto bg-warning");
                 //});

                 // Add click event
                 //$(row).on("click", function () {
                 //    rowClickHandler(data);
                 //});
             },
             "drawCallback": function (settings) {
                 // Your function to be called after loading data
                 /*close_loader();*/
             },
             "columns": [
                 {
                     "target": 0,
                     "render": function (data, type, row, meta) {
                         return meta.row + 1;
                     },
                     "orderable": false,
                 },
                 { "data": "No_Sykt" },
                 { "data": "ID_Sykt" },
                 { "data": "Nama_Sykt" },
                 {
                     "data": null, // No specific data source
                     "render": function (data, type, row) {

                         var KatSya = [];

                         if (row.Bekalan == "true") {
                             var bekalan = "BEKALAN";
                             KatSya.push(bekalan);
                             //return "Bekalan";
                         }

                         if (row.Perkhidmatan == "true") {
                             var Perkhidmatan = "PERKHIDMATAN";
                             KatSya.push(Perkhidmatan);
                             //return "Perkhidmatan";
                         }

                         if (row.Kerja == "true") {
                             var Kerja = "KERJA";
                             KatSya.push(Kerja);
                             // return "Kerja";
                         }
                         //return bekalan + "," + Perkhidmatan + "," + Kerja;
                         KatSya.join(",");
                         return KatSya;
                         //return row.ID_Sykt + " (" + row.Bekalan + ")";
                     },
                     //"title": "CompanyWithSupply"
                 },
                 { "data": "Tkh_Daftar" },
                 { "data": "Tkh_Lulus" },
                 {
                     "data": "Status_Aktif",
                     render: function (data, type, row, meta) {
                         if (data === "00") {
                             return "TIDAK AKTIF";
                         } else {
                             return "AKTIF"
                         }
                     }
                 },
                 {
                     className: "btnEdit",
                     "data": "No_Sykt", //Confirmation id
                     render: function (data, type, row, meta) {
                         if (type !== "display") {
                             return data;
                         }

                         var link = `<button id="btnViewDetailVendor" runat="server" class="btn btnViewDetailVendor" value="${data}" type="button" data-toggle="tooltop" data-placement="top" title="Maklumat Vendor" onclick="ShowDetails('${data}', '070102')">
                                                 <img src="../../../Content/icon/money-check-dollar-svgrepo-com.svg" style="width:30px;height:30px"/>
                                     </button>`;

                         return link;
                     }
                 }

             ]
         });

         //btnSearch
         $('.btnSearch').click(async function () {
             IsClicked = true;
             tblDataSyaDaftar.ajax.reload();
         });

         $("#categoryFilter").change(function (e) {
             var selectedItem = $('#categoryFilter').val()
             if (selectedItem == "6" && selectedItem !== "") {
                 $('#divDatePicker').addClass("d-flex").removeClass("d-none");
                 $('#txtTarikhStart').val("")
                 $('#txtTarikhEnd').val("")
             }
             else {
                 $('#divDatePickerBilDijana').removeClass("d-flex").addClass("d-none");
                 $('#txtTarikhStart').val("")
                 $('#txtTarikhEnd').val("")
             }
         });
     });

     function ShowDetails(idSya , page) {
         if (idSya != "") {
             var Url = '<%=ResolveClientUrl("~/FORMS/PENDAFTARAN SYARIKAT/Pengurusan Syarikat/Mklmt_Vendor.aspx")%>?idSya=' + idSya + '&menu=' + page;
             window.location.href = Url;
         } else {
             return false;
         }
     }
 </script>

</asp:Content>
