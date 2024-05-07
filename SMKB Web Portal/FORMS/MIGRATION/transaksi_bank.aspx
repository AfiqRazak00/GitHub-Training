<%@ Page Title="" Language="vb" AutoEventWireup="false" Async="true"  MasterPageFile="~/NestedMasterPage2.master" CodeBehind="transaksi_bank.aspx.vb" Inherits="SMKB_Web_Portal.transaksi_bank" %>

<asp:Content ID="FormContents" ContentPlaceHolderID="FormContents" runat="server">


    <link type="text/css" rel="stylesheet" href="../../../Scripts/jquery 1.13.3/css/jquery.dataTables.min.css" />
    <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/dataTables.bootstrap.min.css" />
   
    <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/responsive.bootstrap.min.css" />
    <script type="text/javascript" src="../../../Scripts/jquery 1.13.3/js/jquery.dataTables.min.js"></script>

 
   
  
<%--    <script type="text/javascript">
        var gvTestClientId = '<% =gvkod.ClientID %>';
    </script>--%>

    <script type="text/javascript">

        $(function () {
            $(".grid").prepend($("<thead></thead>").append($(this).find("tr:first"))).DataTable({
                "responsive": true,
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
                }
            });
        })

        function Search_Gridview(strKey, strGV) {
            var strData = strKey.value.toLowerCase().split(" ");
            var tblData = document.getElementById(strGV);

            var rowData;
            for (var i = 1; i < tblData.rows.length; i++) {
                rowData = tblData.rows[i].innerHTML;
                var styleDisplay = 'none';
                for (var j = 0; j < strData.length; j++) {
                    if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                        styleDisplay = '';
                    else {
                        styleDisplay = 'none';
                        break;
                    }
                }
                tblData.rows[i].style.display = styleDisplay;
            }
        }

        function SaveSucces(data) {
            //close_loader();
            $('#<%=lblModalMessaage.ClientID%>').html(data);
            //$('#MessageModal').modal('toggle');

        }

        function ShowPopup(elm) {

            if (elm == "1") {
                $('#permohonan').modal('toggle');

            }
            else if (elm == "2") {

                $(".modal-body input").val("");
                $('#permohonan').modal('toggle');
            }

        }

        $(function () {
            $('#txtSearch').keyup(function () {
                $.ajax({
                    url: "VOT.aspx/GetAutoCompleteData",
                    data: "{'username':'" + $('#txtSearch').val() + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        var val = '<ul id="userlist">';
                        $.map(data.d, function (item) {
                            var itemval = item.split('/')[0];
                            val += '<li class=tt-suggestion>' + itemval + '</li>'
                        })
                        val += '</ul>'
                        $('#divautocomplete').show();
                        $('#divautocomplete').html(val);
                        $('#userlist li').click(function () {
                            $('#txtSearch').val($(this).text());
                            $('#divautocomplete').hide();
                        })
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            })
            $(document).mouseup(function (e) {
                var closediv = $("#divautocomplete");
                if (closediv.has(e.target).length == 0) {
                    closediv.hide();
                }
            });
        });
    </script>

    <style type="text/css">
        .hideGridColumn {
            display: none;
        }

      .dataTables_wrapper .dataTables_paginate .paginate_button {
            padding : 7px;
            margin-left: 5px;
            display: inline;
            border: 1px;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button:hover {
            border: 1px;
        }
       
        .ul li
        {
        list-style: none;
        }

        #myProgress {
            width: 100%;
            background-color: #ddd;
        }

        #myBar {
          width: 0%;
          height: 30px;
          background-color: #04AA6D;
          text-align: center;
          line-height: 30px;
          color: white;
          transition: width 2s;
        }
    </style>

  
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <div class="search-filter">
     
                <div class="box-body" align="left">
                    <div class="form-group row col-sm-12">
                        <label class="col-sm-12 col-form-label">Data Migration to table SMKB_Trasaksi_Bank </label>
                    </div>  
                    <div>
                        <span id="errorMessage" runat="server" style="color: red;"></span>
                    </div>
                    <br><br><br>

                    <div class="row rowbody">
                        <div class="form-group col-sm-2 lblinput">
                            <label >Bulan</label>                                   
                        </div>
                        <div class="form-group col-sm-3"> 
                            <asp:DropDownList ID="ddlBulan" runat="server" CssClass="form-control textinput" ></asp:DropDownList>
                        </div>
                        <div class="form-group col-sm-2 lblinput">
                            <label >Tahun</label>                                   
                        </div>
                        <div class="form-group col-sm-3"> 
                            <asp:DropDownList ID="ddlTahun" runat="server" CssClass="form-control textinput" ></asp:DropDownList>
                        </div>
                    </div>
                    <br>
                    <div class="row rowbody">
                        <div class="form-group col-sm-2 lblinput">
                            <label >Kod Bank</label>                                   
                        </div>
                        <div class="form-group col-sm-8"> 
                            <asp:DropDownList ID="ddlKodBank" runat="server" CssClass="form-control textinput" ></asp:DropDownList>
                        </div>
                    </div>                    
                    <br>
                    <div class="col-sm-8">
                        <div class="row">
                            <div>
                                <asp:Button ID="btnTransBank" runat="server" class="btn btn-success btnHantar" 
                                    data-toggle="tooltip" data-placement="bottom"
                                title="Transfer Data ke SMKB_Transaksi_Bank" Text="Transfer Transaksi Bank"/>
                            </div>

                            <%--<button id="btnLoader">Loader</button>--%>
                        </div>
                    </div>
                        <br>

                    <div class="col-sm-10">
                        <div class="row">
                            <div id="myProgress">
                              <div id="myBar">0%</div>
                            </div>
                        </div>    
                    </div>
                    <br>  
                    <br>
            </div>

            <!-- Modal -->
            

            <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h6 class="modal-title" id="exampleModalLabel">Sistem Maklumat Kewangan Bersepadu</h6>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <asp:Label runat="server" ID="lblModalMessaage" />
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                            
                        </div>
                    </div>
                </div>
            </div>

            </div>
        </div>

    <script type="text/javascript">
        $('#<%=btnTransBank.ClientID%>').click(async function (evt) {
            evt.preventDefault();
            //alert("testt");
            var tahun = "";
            //show_loader();
            //move(); //call pogress bar

            beginTransfer();
            setTimeout(beginTimer, 5000);
        });

        //$('#btnLoader').click(function (evt) {
        //    evt.preventDefault();

        //    beginTimer();
        //});

        async function beginTransfer() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: 'MigrationServices2.asmx/TransferData',
                data: JSON.stringify({
                    kodbank: $('#<%=ddlKodBank.ClientID%>').val(),
                    bulan: $('#<%=ddlBulan.ClientID%>').val(),
                    tahun: $('#<%=ddlTahun.ClientID%>').val()
               }),
               success: function () {
                   SaveSucces
               }
           });

        }

        async function beginTimer() {
            setTimeout(getProgress, 5000);
        }

        async function getProgress() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: 'MigrationServices2.asmx/GetTotalTransfer',
                data: JSON.stringify({
                    kodbank: $('#<%=ddlKodBank.ClientID%>').val(),
                    bulan: $('#<%=ddlBulan.ClientID%>').val(),
                    tahun: $('#<%=ddlTahun.ClientID%>').val()
                 }),
                success: function (data) {
                    SuccessProgress(data.d.Result)
                }
            });
        }

        async function SuccessProgress(result) {
            move(parseInt(result));
            if (result < 100) {
                beginTimer();
            } else {
                //getJumlahDebitKredit();
            }
        }

        async function getJumlahDebitKredit() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: 'MigrationServices2.asmx/GetTotalTransfer',
                data: JSON.stringify({
                    kodbank: $('#<%=ddlKodBank.ClientID%>').val(),
            bulan: $('#<%=ddlBulan.ClientID%>').val(),
            tahun: $('#<%=ddlTahun.ClientID%>').val()
        }),
        success: function (data) {
            SuccessProgress(data.d.Result)
        }
    });
        }

        var i = 0;
        async function move(percent) {
            var elem = document.getElementById("myBar");
            elem.style.width = percent + "%";
            elem.innerHTML = percent + "%";

            //if (i == 0) {
            //    i = 1;
            //    var elem = document.getElementById("myBar");
            //    var width = 10;
            //    var id = setInterval(frame, 10);
            //    function frame() {
            //        if (width >= 100) {
            //            clearInterval(id);
            //            i = 0;
            //        } else {
            //            width++;
            //            elem.style.width = width + "%";
            //            elem.innerHTML = width + "%";
            //        }
            //    }
            //}
        }
    </script>
</asp:Content>
