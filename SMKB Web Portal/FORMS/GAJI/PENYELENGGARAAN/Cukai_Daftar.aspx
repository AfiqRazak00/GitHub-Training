<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Cukai_Daftar.aspx.vb" Inherits="SMKB_Web_Portal.Cukai_Daftar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
           <div id="PermohonanTab" class="tabcontent" style="display: block">
       <br/>
       <div class="table-title">
           <h6>Senarai Transaksi</h6>
           <hr>
           <div class="btn btn-primary"  onclick="ShowPopup('1')">
               <i class="fa fa-plus"></i>Tambah Transaksi              
           </div>&nbsp;&nbsp;
       
       </div>

      <br/>
       <div class="form-row">

           <div class="col-md-12">
               
               <div class="transaction-table table-responsive">
                   
                   <table id="tblListHdr" class="table table-striped" style="width:100%">
                       <thead>
                           <tr>
                               <th scope="col" style="width:50px">Kod</th>
                               <th scope="col" style="width:200px">Butiran</th>
                               <th scope="col" style="width:100px">Tindakan</th>
                           </tr>
                       </thead>
                       <tbody id="tableID_ListHdr">
                                       
                       </tbody>

                   </table>
               </div>
           </div>                  
       </div>
      <div class="table-title">

       <div class="col-sm-6 col-md-6">
           <div class="card border-white">
               <div class="card-header" style="text-align: left">
                   <label id="lbl1" style="color:blue"></label>
                   <label id="lbl2" style="color:blue"></label>
                    <label id="hidNostaf" style="visibility:hidden"></label>
                   <label id="hidSave" style="visibility:hidden"></label>
               </div>

           </div>
       </div>
       <div class="col-sm-6 col-md-3">
           </div>
        
       <div class="btn btn-primary" style="text-align:right" onclick="ShowPopup('2');">
           <i class="fa fa-plus"></i>Tambah Transaksi              
       </div>
           
       &nbsp;&nbsp; 
      
   </div>


           <div class="form-row">
            
           <div class="col-md-12">
               
               <div class="transaction-table table-responsive">
                   
                   <table id="tblListDet" class="table table-striped" style="width:100%">
                       <thead>
                           <tr>
                                <th scope="col" style="width:30px">Kod</th>
                               <th scope="col" style="width:30px">Amaun (RM)</th>
                               <th scope="col" style="width:70px">Pekerja (RM)</th>
                               <th scope="col" style="width:50px">Majikan (RM)</th>
                               <th scope="col" style="width:100px">Tindakan</th>
                           </tr>
                       </thead>
                       <tbody id="tableID_ListDet">
                                       
                       </tbody>

                   </table>
               </div>
           </div>                  
           </div>

               <!-- Modal -->
       <div class="modal fade" id="infohdr" tabindex="-1" role="dialog"
           aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
           <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
               <div class="modal-content">
                   <div class="modal-header">
                       <h5 class="modal-title" id="eMCTitle">Tambah Cukai</h5>
                       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                           <span aria-hidden="true">&times;</span>
                       </button>
                   </div>

                   <div class="modal-body">
                           <h6>Maklumat Cukai</h6>
                           <hr>
                
                               <%--<input id="hdnSimpan" name="hdnSimpan"  runat="server" type="text" class="form-control" enable="true">--%>

                                   <div class="form-row">
                                       <div class="form-group col-md-8">
                 
                                           <asp:TextBox runat="server" ID="txtKodHdr" CssClass="input-group__input" Style="width: 50%;" ></asp:TextBox>
                                           <label class="input-group__label" for="Kod">Kod</label>
                                           <asp:RequiredFieldValidator ID="rqdKod" runat="server" ControlToValidate="txtKodHdr" CssClass="text-danger" ErrorMessage="*Sila Masukkan Kod" ValidationGroup="Semak" Display="Dynamic"/>
                                       </div>
                                       <div class="form-group col-md-8">
                                           <asp:TextBox runat="server" ID="txtButir" CssClass="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                           <label class="input-group__label" for="Butiran">Butiran</label>
                                           <asp:RequiredFieldValidator ID="rqdButir" runat="server" ControlToValidate="txtButir" CssClass="text-danger" ErrorMessage="*Sila Masukkan Butiran" ValidationGroup="Semak" Display="Dynamic"/>
                                       </div>

                                   </div> 

                   </div>
                   <div class="modal-footer">
                       <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                       <asp:LinkButton  runat="server" autopostback ="true"  CssClass="btn btn-secondary lbtnSave"> 
&nbsp;&nbsp;&nbsp;Simpan </asp:LinkButton>

                   </div>
               </div>
           </div>
       </div>
   
       <!-- End Modal -->


               <!-- Modal -->
       <div class="modal fade" id="infodet" tabindex="-1" role="dialog"
           aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
           <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
               <div class="modal-content">
                   <div class="modal-header">
                       <h5 class="modal-title" id="eMCDet">Tambah Perkeso</h5>
                       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                           <span aria-hidden="true">&times;</span>
                       </button>
                   </div>

                   <div class="modal-body">
                           <h6>Maklumat Cukai Teperinci</h6>
                           <hr>
                
                               <%--<input id="hdnSimpan" name="hdnSimpan"  runat="server" type="text" class="form-control" enable="true">--%>

                                   <div class="form-row">
                                        <div class="form-group col-md-4">
                  
                                            <asp:TextBox runat="server" ID="TextBox1" CssClass="input-group__input" Enabled="false" Style="width: 50%;text-transform:uppercase;" ></asp:TextBox>
                                            <label class="input-group__label" for="Kod">Kod</label>
                                            <asp:RequiredFieldValidator ID="rqdTxt1" runat="server" ControlToValidate="TextBox1" CssClass="text-danger" ErrorMessage="*Sila Masukkan Kod" ValidationGroup="SemakDet" Display="Dynamic"/>

                                        </div>
                                        <div class="form-group col-md-8">
                                            <asp:TextBox runat="server" ID="TextBox2" CssClass="input-group__input" Style="width: 50%;" ></asp:TextBox>
                                            <label class="input-group__label" for="Butiran">Amaun</label>
                                           <asp:RequiredFieldValidator ID="rqdTxt2" runat="server" ControlToValidate="TextBox2" CssClass="text-danger" ErrorMessage="*Sila Masukkan Amaun" ValidationGroup="SemakDet" Display="Dynamic"/>

                                        </div>
                                        <div class="form-group col-md-4">
                                            <asp:TextBox runat="server" ID="TextBox3" CssClass="input-group__input" Style="width: 50%;" ></asp:TextBox>
                                            <label class="input-group__label" for="Pekerja (%)">Pekerja (%)</label>
                                            <asp:RequiredFieldValidator ID="rqdTxt3" runat="server" ControlToValidate="TextBox3" CssClass="text-danger" ErrorMessage="*Sila Masukkan Pekerja" ValidationGroup="SemakDet" Display="Dynamic"/>

       
                                        </div>
                                         <div class="form-group col-md-8">
                                               <asp:TextBox runat="server" ID="TextBox4" CssClass="input-group__input" Style="width: 50%;" ></asp:TextBox>
                                               <label class="input-group__label" for="Majikan (%)">Majikan (%)</label>
                                               <asp:RequiredFieldValidator ID="rqdTxt4" runat="server" ControlToValidate="TextBox4" CssClass="text-danger" ErrorMessage="*Sila Masukkan Majikan" ValidationGroup="SemakDet" Display="Dynamic"/>

 
                                         </div>
                                    </div> 

                   </div>
                   <div class="modal-footer">
                       <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                       <asp:LinkButton  runat="server" autopostback ="true"  CssClass="btn btn-secondary lbtnSaveDt"> 
&nbsp;&nbsp;&nbsp;Simpan </asp:LinkButton>

                   </div>
               </div>
           </div>
       </div>
   
       <!-- End Modal -->
                <!-- notify modal start-->
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
<!-- notify modal end-->
   </div>
   <script type="text/javascript">
       var tbl = null

       $(document).ready(function () {

           tbl = $("#tblListHdr").DataTable({
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
                   "url": "Utiliti_WS.asmx/LoadListCukaiHdr",
                   method: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function () {
                       return JSON.stringify()
                   },
                   "dataSrc": function (json) {
                       return JSON.parse(json.d);
                   }
               },
               "columns": [
                   {
                       "data": "kod",

                   },
                   { "data": "butiran" },
                   {
                       "data": "kod",
                       render: function (data, type, row, meta) {

                           if (type !== "display") {

                               return data;

                           }

                           var link = `<button id="btnView" runat="server" class="btn btnView" type="button" style="color: blue" data-dismiss="modal">
                                                   <i class="far fa-edit"></i>
                                       </button><button id="btnAll" runat="server" class="btn btnAll" type="button" style="color: blue" data-dismiss="modal">
                                                   <i class="far fa-list-alt"></i>
                                       </button>`;
                           return link;
                       }
                   }
                   
               ]

           });

       });
       function notification(msg) {
           $("#notify").html(msg);
           $("#NotifyModal").modal('show');
       }

       $('#tblListHdr').on('click', '.btnView', function () {

           var val = $(this).closest('tr').find('td:eq(0)').text();
           //var curTR = $(this).closest("tr");
           //var recordID = curTR.find("td > .noStaf");
           ////var bool = true;
           //var id = recordID.val();

           $('#hidSave').text('2');
           $('#infohdr').modal('toggle');
           $('#<%=txtKodHdr.ClientID%>').val($(this).closest('tr').find('td:eq(0)').text());
           $('#<%=txtButir.ClientID%>').val($(this).closest('tr').find('td:eq(1)').text());
           document.getElementById('<%=txtKodHdr.ClientID %>').disabled = true;

           //getInfoStaf(val);
           //getInfoProses(val);

       });
       $('#tblListHdr').on('click', '.btnAll', function () {

           var val = $(this).closest('tr').find('td:eq(0)').text();

           $('#lbl1').text(val);
           $('#hidNostaf').text(val);
           $('#lbl2').text($(this).closest('tr').find('td:eq(1)').text());
           //alert(val);
           ListMaster(val);

       });

       function ListMaster(vNostaf)
       {

           //alert(urls);

           tbl = $("#tblListDet").DataTable({
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
                   "url": "Utiliti_WS.asmx/LoadListDetCukai",
                   method: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   data: function () {
                       return JSON.stringify({ kodhdr: vNostaf })
                   },
                   "dataSrc": function (json) {
                       //var data = JSON.parse(json.d);
                       //console.log(data.Payload);
                       return JSON.parse(json.d);
                   }
               },
               "columns": [
                   { "data": "kod", className: "text-center" },
                   { "data": "amaun", className: "text-center" },
                   { "data": "cukai_pek", className: "text-center" },
                   { "data": "cukai_maj", className: "text-center" },
                   {
                       "data": "kod",
                       render: function (data, type, row, meta) {

                           var btnedit;
                           btnedit = `<button id="btnEdit" runat="server" class="btn btnEdit" type="button" style="color: blue" data-dismiss="modal">
                                               <i class="far fa-edit"></i> </button>`;

                           return btnedit;
                       }



                   }
               ]

           });
       }

       $('#tblListDet').on('click', '.btnEdit', function () {

           $('#infodet').modal('toggle');
           $('#hidSave').text("4");
           $('#eMCTitle').text("Kemaskini Transaksi");
           $('#lblnostaf').text($('#lbl1').text());
           $('#lblnama').text($('#lbl2').text());
           
           $('#<%=TextBox1.ClientID%>').val($(this).closest('tr').find('td:eq(0)').text());
           $('#<%=TextBox2.ClientID%>').val($(this).closest('tr').find('td:eq(1)').text());
           $('#<%=TextBox3.ClientID%>').val($(this).closest('tr').find('td:eq(2)').text());
           $('#<%=TextBox4.ClientID%>').val($(this).closest('tr').find('td:eq(3)').text());
           document.getElementById('<%=TextBox1.ClientID %>').disabled = true;

       });

       function ShowPopup(elm) {

           if (elm == "1") {

               $(".modal-body input").val("");

               $(".modal-body #hdnSimpan").val('1');
               document.getElementById('<%=txtKodHdr.ClientID %>').disabled = false;
               $('#infohdr').modal('toggle');
           }
           else if (elm == "3") {
              //$("#hdnSimpan").val("2");
               $(".modal-body input").val("");
               $('#infodet').modal('toggle');
               document.getElementById('<%=TextBox1.ClientID %>').disabled = false;
           }

       }

       $('.lbtnSave').click(async function (evt) {
          
           evt.preventDefault();

           var msg = "";
           var isave = $('#hidSave').text();

           var result = await performCheck("Semak");

           if (result === false) {
               return false;
           }
          
           var newHdr = {
               DataCukaiHeader: {
                  // Kod_PTJ: $('#<%'=hPTJ.ClientID%>').val(),
                    Kod: $('#<%=txtKodHdr.ClientID%>').val(),
                    Butiran: $('#<%=txtButir.ClientID%>').val(),

                }
           }

           if (isave === "1") {
               //console.log(newMaster);
               msg = "Anda pasti ingin menyimpan rekod ini?"

               if (!confirm(msg) && result === true) {
                   return false;
               }
               var response = await ajaxSaveHdr(newHdr);
           }
           else if (isave === "2") {
               //console.log(newMaster);
               msg = "Anda pasti ingin mengemaskini rekod ini?"

               if (!confirm(msg) && result === true) {
                   return false;
               }
               var response = await ajaxUpdateHdr(newHdr);
           }
           //else if (isave === "3") {
           //    //console.log(newMaster);
           //    msg = "Anda pasti ingin menghapus rekod ini?"

           //    if (!confirm(msg) && result === true) {
           //        return false;
           //    }
           //    var response = await ajaxDeleteHdr(newHdr);
           //}

       });

       async function ajaxUpdateHdr(arahanK) {
           $.ajax({

               url: 'Utiliti_WS.asmx/UpdateHdrCukai',
               method: 'POST',
               data: JSON.stringify(arahanK),
               dataType: 'json',
               contentType: 'application/json; charset=utf-8',
               success: function (data) {
                   var response = JSON.parse(data.d)
                   console.log(response);
                   notification(response.Message);
                   var payload = response.Payload;
                  
                   // $('#lbl1').text(payload.No_Staf);
                   // ListMaster(payload.No_Staf);

                 },
                error: function (xhr, textStatus, errorThrown) {
                console.error('Error:', errorThrown);
                reject(false);
                }
            });
       }
       async function ajaxDeleteHdr(arahanK) {
           $.ajax({

               url: 'Utiliti_WS.asmx/HapusCukaiHdr',
               method: 'POST',
               data: JSON.stringify(arahanK),
               dataType: 'json',
               contentType: 'application/json; charset=utf-8',
               success: function (data) {
                   var response = JSON.parse(data.d)
                   console.log(response);
                   notification(response.Message);
                   var payload = response.Payload;
                  
                    //$('#lbl1').text(payload.No_Staf);
                   // ListMaster(payload.No_Staf);

                },
                    error: function (xhr, textStatus, errorThrown) {
                    console.error('Error:', errorThrown);
                    reject(false);
                }
           });
       }

    async function ajaxSaveHdr(arahanK) {
        $.ajax({

            url: 'Utiliti_WS.asmx/SimpanCukaiHdr',
            method: 'POST',
            data: JSON.stringify(arahanK),

            dataType: 'json',
            contentType: 'application/json; charset=utf-8',
            success: function (data) {
                var response = JSON.parse(data.d)
                console.log(response);
                notification(response.Message);
                var payload = response.Payload;
            

            },
            error: function (xhr, textStatus, errorThrown) {
                console.error('Error:', errorThrown);
                reject(false);
            }

        });
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
       function notification(msg) {
           $("#notify").html(msg)
           $("#NotifyModal").modal('show');
       }

       $('.lbtnSaveDt').click(async function (evt) {

           evt.preventDefault();

           var msg = "";
           var isave = $('#hidSave').text();

           var resultdet = await performCheck("SemakDet");

           if (resultdet === false) {
               return false;
           }
           // alert(isave);

           var newDet = {
               DataCukaiDet: {
                    KodDet: $('#<%=TextBox1.ClientID%>').val(),
                    AmaunDet: $('#<%=TextBox2.ClientID%>').val(),
                    AmaunPek: $('#<%=TextBox3.ClientID%>').val(),
                    AmaunMaj: $('#<%=TextBox4.ClientID%>').val(),



               }
           }



           if (isave === "3") {
               //console.log(newMaster);
               msg = "Anda pasti ingin menyimpan rekod ini?"

               if (!confirm(msg) && result === true) {
                   return false;
               }
               var response = await ajaxSaveDet(newDet);
           }
           else if (isave === "4") {
               //console.log(newMaster);
               msg = "Anda pasti ingin mengemaskini rekod ini?"

               if (!confirm(msg) && result === true) {
                   return false;
               }
               var response = await ajaxUpdateDet(newDet);
           }
           //else if (isave === "3") {
           //    //console.log(newMaster);
           //    msg = "Anda pasti ingin menghapus rekod ini?"

           //    if (!confirm(msg) && result === true) {
           //        return false;
           //    }
           //    var response = await ajaxDeleteHdr(newHdr);
           //}

       });

       async function ajaxSaveDet(arahanK) {
           $.ajax({

               url: 'Utiliti_WS.asmx/SimpanCukaiDet',
               method: 'POST',
               data: JSON.stringify(arahanK),

               dataType: 'json',
               contentType: 'application/json; charset=utf-8',
               success: function (data) {
                   var response = JSON.parse(data.d)
                   console.log(response);
                   notification(response.Message);
                   var payload = response.Payload;
                   ListDet(payload.KodDet);

               },
               error: function (xhr, textStatus, errorThrown) {
                   console.error('Error:', errorThrown);
                   reject(false);
               }

           });

           //})

       }


       async function ajaxUpdateDet(arahanK) {
           $.ajax({

               url: 'Utiliti_WS.asmx/UpdateDetCukai',
               method: 'POST',
               data: JSON.stringify(arahanK),

               dataType: 'json',
               contentType: 'application/json; charset=utf-8',
               success: function (data) {
                   var response = JSON.parse(data.d)
                   console.log(response);
                   notification(response.Message);
                   var payload = response.Payload;
                   ListDet(payload.KodDet);

               },
               error: function (xhr, textStatus, errorThrown) {
                   console.error('Error:', errorThrown);
                   reject(false);
               }
           });
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

   </script>    
</asp:Content>
