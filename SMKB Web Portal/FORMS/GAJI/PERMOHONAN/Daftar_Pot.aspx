<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Daftar_Pot.aspx.vb" Inherits="SMKB_Web_Portal.Daftar_Pot" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <style>
   .nospn {
   -moz-appearance: textfield;
   }
   .nospn::-webkit-outer-spin-button,
   .nospn::-webkit-inner-spin-button {
   -webkit-appearance: none;
   margin: 0;
   }
   #permohonan .modal-body {
   max-height: 70vh;
   /* Adjust height as needed to fit your layout */
   min-height: 70vh;
   overflow-y: scroll;
   scrollbar-width: thin;
   }
   #subTab a {
   cursor: pointer;
   }
   #tblData {
   margin: 0 auto;
   border-collapse: collapse;
   table-layout: fixed;
   }
   .sticky-col-start {
   position: sticky;
   left: 0;
   box-sizing: border-box !important;
   u
   }
   .col-ddl:focus-within {
   z-index: 1;
   }
   .sticky-col-end {
   position: sticky;
   right: 0;
   box-sizing: border-box !important;
   }
   .left-200 {
   left: 200px;
   }
   .right-50 {
   right: 50px;
   }
   .spn-ddl-dtl {
   display: none;
   }
   .ddlKodVot:focus-within .spn-ddl-dtl {
   display: inline-block;
   }
   .spn-dtl {
   width: 100%;
   cursor: pointer;
   }
   .spn-dtl::after {
   top: 0;
   font-size: .8em;
   line-height: 1em;
   vertical-align: text-top;
   content: "\f05a";
   /* Unicode for the FontAwesome icon you want to use */
   font-family: FontAwesome;
   /* Specify the font family */
   margin-left: 2px;
   /* Adjust as needed for spacing */
   }
   .codx {
   display: none;
   visibility: hidden;
   } .file-upload-container {
   position: relative;
   }
   .delete-button {
   cursor: pointer;
   color: red;
   }.file-name-label {
   margin-top: 5px;
   cursor: pointer;
   }.disableDdlIcon{
   pointer-events: none;
   }
   @keyframes blink {
   0% {
   opacity: 1;
   }
   50% {
   opacity: 0.5;
   }
   100% {
   opacity: 1;
   }
   }
   .blink_badge {
   animation: blink 1s infinite;
   }
   .incolor{
   background-color: #e9ecef;
   color: #ffffff;
   }
</style>
<link rel="stylesheet" href="../style.css" />
    <div id="PermohonanTab" class="tabcontent" style="display: block">
                    <div class="table-title">
               <h6 class="font-weight-bold">Maklumat Pemohon <i class="fas fa-info-circle fa-lg text-primary"  data-toggle="modal" data-target="#modalB1"></i></h6>
            </div>
            <div class="row">
               <div class="col-md-12">
                  <div class="row">
                     <div class="col-lg-5 col-md-6">
                        <div class="form-group input-group">
                           <input id="noMohon" type="text" runat="server" class=" input-group__input form-control input-sm" placeholder="" readonly disabled />
                           <label class="input-group__label">No. Mohon</label>
                        </div>
                     </div>
                     <div class="col-md-12"></div>
                     <div class="col-lg-5 col-md-6">
                        <div class="form-group input-group">
                           <input type="text" class="id_nama input-group__input form-control input-sm" placeholder="" name="" value="" readonly disabled />
                           <label class="input-group__label">Nama Penuh</label>
                        </div>
                     </div>
                     <div class="col-lg-2 col-md-6">
                        <div class="form-group input-group">
                           <input type="text" class="id_staff input-group__input form-control input-sm" placeholder="" name="" value="" readonly disabled />
                           <label class="input-group__label">No. Pekerja</label>
                        </div>
                     </div>
                     <div class="col-md-12"></div>
                      <div class="col-lg-3 col-md-6">
                       <div class="form-group">
                          <div class="form-group input-group">
                                    <asp:DropDownList ID="ddlKodTrans" CssClass="input-group__select ui search dropdown" runat="server">
                                                        
                                </asp:DropDownList>
                                <label class="input-group__label" for="Potongan">Potongan</label>
                                <asp:RequiredFieldValidator ID="rqdKod" runat="server" ControlToValidate="ddlKodTrans" CssClass="text-danger" ErrorMessage="*Sila Masukkan Kod" ValidationGroup="Semak" Display="Dynamic"/>
                          </div>
                       </div>
                    </div>
                      <div class="col-md-12"></div>
                        <div class="col-lg-3 col-md-8">
                           <div class="form-group">
                                 <div class="form-group input-group">
                                     <div class="form-group col-md-6">
                                        <input id="txtMula" runat="server" type="date" class="input-group__input" enable="true">
                                        <label class="input-group__label" for="Tarikh Mula">Tarikh Mula</label>
                                        <asp:RequiredFieldValidator ID="rqdTkhMula" runat="server" ControlToValidate="txtMula" CssClass="text-danger" ErrorMessage="*Sila Masukkan Tarikh Mula" ValidationGroup="Semak" Display="Dynamic"/>
                                    </div>

                                    <div class="form-group col-md-6">
                                        
                                    <input id="txtTamat" runat="server" type="date" class="input-group__input" enable="true">
                                    <label class="input-group__label" for="Tarikh Tamat">Tarikh Tamat</label>
                                    <asp:RequiredFieldValidator ID="rqdTkhTmt" runat="server" ControlToValidate="txtTamat" CssClass="text-danger" ErrorMessage="*Sila Masukkan Tarikh Tamat" ValidationGroup="Semak" Display="Dynamic"/>

                                    </div>
                                </div>
                             </div>
                          </div>
                     <div class="col-lg-3 col-md-6">
                        <div class="form-group input-group">
                                <input id="txtamaun" runat="server" type="number" class="input-group__input" enable="true">
                                <label class="input-group__label" for="Amaun">Amaun</label>
                                <asp:RequiredFieldValidator ID="rqdAmaun" runat="server" ControlToValidate="txtamaun" CssClass="text-danger" ErrorMessage="*Sila Masukkan Amaun" ValidationGroup="Semak" Display="Dynamic"/>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
<label id="hidSave" style="visibility:hidden"></label>
        <div class="sticky-footer">
           <br>
           <div class="form-row">
              <div class="form-group col-md-12">
                 <div id="showBtn" class="float-right">
                         <asp:LinkButton  runat="server" autopostback ="true"  CssClass="btn btn-secondary lbtnReset"> 
&nbsp;&nbsp;&nbsp;Reset </asp:LinkButton>
                    <asp:LinkButton  runat="server" autopostback ="true"  CssClass="btn btn-secondary lbtnSimpan"> 
                &nbsp;&nbsp;&nbsp;Simpan </asp:LinkButton>
                 </div>
              </div>
           </div>
        </div>

              <%--Modal - Senarai Permohonan--%>
      <div class="form-row">
     
    <div class="col-md-12">
        
        <div class="transaction-table table-responsive">
            
            <table id="tblListMaster" class="table table-striped" style="width:100%">
                <thead>
                    <tr>
                        <th scope="col" style="width:30px">Bil</th>
                        <th scope="col" style="width:70px">No. Mohon</th>
                        <th scope="col" style="width:50px">Kod</th>
                        <th scope="col" style="width:50px">Potongan</th>
                         <th scope="col" style="width:50px">Tarikh Mula</th>
                         <th scope="col" style="width:50px">Tarikh Tamat</th>
                        <th scope="col" style="width:70px">Amaun (RM)</th>
                        <th scope="col" style="width:70px">Status</th>
                        <th scope="col" style="width:70px">Ulasan</th>     
                        <th scope="col" style="width:100px">Tindakan</th>
                        <th scope="col" style="width:0px"></th>
                    </tr>
                </thead>
                <tbody id="tableID_ListMaster">
                                
                </tbody>

            </table>
        </div>
    </div>                  
</div>

         <!-- Confirmation Modal Submit Bil -->
         <div class="modal fade" id="confirmationModalSubmit" tabindex="-1" role="dialog"
            aria-labelledby="confirmationModalLabelSubmit" aria-hidden="true">
            <div class="modal-dialog" role="document">
               <div class="modal-content">
                  <div class="modal-header">
                     <h5 class="modal-title" id="confirmationModalLabelSubmit">Pengesahan</h5>
                     <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                     </button>
                  </div>
                  <div class="modal-body">
                     Anda pasti ingin menyimpan rekod ini?
                  </div>
                  <div class="modal-footer">
                     <button type="button" class="btn btn-danger"
                        data-dismiss="modal">Tidak</button>
                     <button id="btnYaSubmit" type="button" class="btn default-primary">Ya</button>
                  </div>
               </div>
            </div>
         </div>

</div>
          

 <script type="text/javascript">
     //$(document).ready(function () {


     //});
     var tbl = '';
     var shouldPop = true, searchQuery = "", oldSearchQuery = "", tempNoPinjaman = "", navId = '', delDataId = '', withStatus = false, jumlahFail = 0, ttlCklist = 0, curCklist = 0;
     var tempArrChecklist = {}, tempArrPnjmin = [], tempSenaraiSemak = [];
     var nostaf = '<%=Session("ssusrID")%>'
     /*init function*/
     init();

     function init() {
         //Mulakan loader
         //show_loader();

         $.ajax({

             "url": "Mohon_WS.asmx/GetKodTrans",
             method: 'POST',
             "contentType": "application/json; charset=utf-8",
             "dataType": "json",
             success: function (data) {

                 var json = JSON.parse(data.d);

                 var option = json.map(x => "<option value='" + x.Kod_Trans + "'>" + x.Butiran + "</option>");

                 $('[id*=ddlKodTrans]').html('<option value="">Sila Pilih</option>');
                 $('[id*=ddlKodTrans]').append(option.join(' '));

             }

         });

         getDataPeribadi();
         ListMaster();
     }

     function ListMaster() {
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
                 "url": "Mohon_WS.asmx/LoadListMaster",
                 method: 'POST',
                 "contentType": "application/json; charset=utf-8",
                 "dataType": "json",
                 data: function () {
                     return JSON.stringify({ nostaf: nostaf })
                 },
                 "dataSrc": function (json) {
                     //var data = JSON.parse(json.d);
                     //console.log(data.Payload);
                     return JSON.parse(json.d);
                 }
             },
             "columns": [
                 { "data": "row_num", className: "text-center" },
                 { "data": "id_mohon", className: "text-center" },
                 { "data": "kod_trans", className: "text-left" },
                 { "data": "butiran", className: "text-left" },
                 { "data": "Tkh_Mula", className: "text-center" },
                 { "data": "Tkh_Tamat", className: "text-center" },
                 { "data": "amaun", className: "text-right", render: $.fn.dataTable.render.number(',', '.', 2, '') },
                 { "data": "status_dok", className: "text-center" },
                 { "data": "ulasan" },
                 {
                     "data": "id_mohon",
                     render: function (data, type, row, meta) {

                         if (type !== "display") {

                             return data;

                         }

                         var link = `<button id="btnView" runat="server" class="btn btnView" type="button" style="color: blue" data-dismiss="modal">
                        <i class="far fa-edit"></i></button>`;

                         return link;
                     }
                 }
             ]

         });



     }


     // Read values from the 3rd column (index 2), which is hidden
    
     function formatNumber(number) {
         return new Intl.NumberFormat('en-US', {
             style: 'decimal',
             minimumFractionDigits: 2,
             maximumFractionDigits: 2
         }).format(number);
     }

     function resizeTextarea(target) {
         var textarea = $(target);
         var text = textarea.val();
         var textLength = text.length;
         var spaces = (text.match(/ /g) || []).length; // Count spaces in the text
         var minRows = 2; // Minimum number of rows
         var maxRows = 10; // Maximum number of rows
         var charsPerRow = 20; // Adjust this value based on your layout

         // Calculate the number of rows based on text length and spaces
         var rows = Math.ceil((textLength + spaces) / charsPerRow);

         // Ensure the number of rows is within the specified range
         rows = Math.max(minRows, Math.min(maxRows, rows));

         // Set the textarea rows
         textarea.attr('rows', rows);
     }



     function buildDdl(id, kodVal, txtVal) {
         if (isSet(kodVal) && isSet(txtVal)) {
             $("#" + id).append("<option value = '" + kodVal + "'>" + txtVal + "</option>")
             $("#" + id).dropdown('set selected', kodVal);
         }
     }



     function getDataPeribadi()
    {
             //Cara Pertama
             fetch('Mohon_WS.asmx/GetUserInfo', {
                 method: 'POST',
                 headers: {
                     'Content-Type': "application/json"
                 },
            body: JSON.stringify({ nostaf:nostaf  })
        })
        .then(response => response.json())
         .then(data => setDataPeribadi(data.d))

    }

    function setDataPeribadi(data) {
        data = JSON.parse(data);
        if (data.StafNo === "") {
            alert("Tiada data"); 
            return false;
        }

        $(".id_nama").val(data[0].Param1);
        $(".id_staff").val(data[0].StafNo);


    
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
     $('.lbtnReset').click(async function (evt)
     {
         evt.preventDefault();
         var msg = "";
         var isave = "";

         $('#<%=noMohon.ClientID%>').val('');
         $('#<%=ddlKodTrans.ClientID%>').val('');
         $('#<%=txtamaun.ClientID%>').val('');
     });
     $('.lbtnSimpan').click(async function (evt) {
         evt.preventDefault();
         
         var msg = "";
         var isave = $('#hidSave').text();

         var result = await performCheck("Semak");

         if (result === false) {
             return false;
         }
         
         var newMaster = {
             DataMohonPot: {
                   // Kod_PTJ: $('#<%'=hPTJ.ClientID%>').val(),
                No_Mohon: $('#<%=noMohon.ClientID%>').val(),
                No_Staf: nostaf,
                Kod_Trans: $('#<%=ddlKodTrans.ClientID%>').val(),
                AmaunTrans: $('#<%=txtamaun.ClientID%>').val(),
                Tkh_Mula: $('#<%=txtMula.ClientID%>').val(),
                Tkh_Tamat: $('#<%=txtTamat.ClientID%>').val(),


             }
         }



         if (isave === "2") {
             //console.log(newMaster);
             msg = "Anda pasti ingin menyimpan rekod ini?"

             if (!confirm(msg) && result === true) {
                 return false;
             }
             var response = await ajaxUpdateMaster(newMaster);
         }
         else {
             msg = "Anda pasti ingin menyimpan rekod ini?"

             if (!confirm(msg) && result === true) {
                 return false;
             }
             var response = await ajaxSaveMaster(newMaster);
         }


     });

     async function ajaxSaveMaster(arahanK) {
         $.ajax({

             url: 'Mohon_WS.asmx/SimpanMaster',
             method: 'POST',
             data: JSON.stringify(arahanK),

             dataType: 'json',
             contentType: 'application/json; charset=utf-8',
             success: function (data) {
                 var response = JSON.parse(data.d)
                 console.log(response);
                 alert(response.Message);
                 var payload = response.Payload;
                 $('#<%=noMohon.ClientID%>').val(payload.No_Mohon);
                 ListMaster();
                    //ListMaster(payload.No_Staf, 1);

             },
             error: function (xhr, textStatus, errorThrown) {
                 console.error('Error:', errorThrown);
                 reject(false);
             }

        });
     }

     async function ajaxUpdateMaster(arahanK) {
         $.ajax({

             url: 'Mohon_WS.asmx/UpdateMaster',
             method: 'POST',
             data: JSON.stringify(arahanK),

             dataType: 'json',
             contentType: 'application/json; charset=utf-8',
             success: function (data) {
                 var response = JSON.parse(data.d)
                 console.log(response);
                 alert(response.Message);
                 var payload = response.Payload;
                 $('#<%=noMohon.ClientID%>').val(payload.No_Mohon);
                 ListMaster();
                 //ListMaster(payload.No_Staf, 1);

             },
             error: function (xhr, textStatus, errorThrown) {
                 console.error('Error:', errorThrown);
                 reject(false);
             }

         });
     }

     $('#tblListMaster').on('click', '.btnView', function () {
         $('#hidSave').text("2");
         $('#<%=noMohon.ClientID%>').val($(this).closest('tr').find('td:eq(1)').text());
         $('#<%=ddlKodTrans.ClientID%>').val($(this).closest('tr').find('td:eq(2)').text()); 
         $('#<%=txtMula.ClientID%>').val(formatDate($(this).closest('tr').find('td:eq(4)').text()));
         $('#<%=txtTamat.ClientID%>').val(formatDate($(this).closest('tr').find('td:eq(5)').text()));
         $('#<%=txtamaun.ClientID%>').val($(this).closest('tr').find('td:eq(6)').text().replace(",", ""));


      });





     


 </script>


</asp:Content>
