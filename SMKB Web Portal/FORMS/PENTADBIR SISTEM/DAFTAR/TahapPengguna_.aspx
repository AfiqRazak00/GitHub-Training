﻿<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="TahapPengguna_.aspx.vb" Inherits="SMKB_Web_Portal.TahapPengguna" %>

<asp:Content ID="FormContents" ContentPlaceHolderID="FormContents" runat="server">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/css/select2.min.css" />
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/select2@4.0.13/dist/js/select2.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $("[id*=ddlCariNamaUser]").select2();
        });
    </script>

    <link type="text/css" rel="stylesheet" href="../../../Scripts/jquery 1.13.3/css/jquery.dataTables.min.css" />
    <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/dataTables.bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/responsive.bootstrap.min.css" />
    <script type="text/javascript" src="../../../Scripts/jquery 1.13.3/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="../mod_function.js"></script>

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

            initDropdown("<%=ddlCariNamaUser.ClientID%>",
                "<%=ResolveClientUrl("~/Module/smkb_mod_function.asmx")%>/getListNamaUser?q={query}")

      <%--      initDropdown("<%=ddlCariNamaUser.ClientID%>",
                 "<%=ResolveClientUrl("~/Module/smkb_mod_function.asmx")%>/getListMasterLookup?desc={query}&kod={kod}", null,
                 function (settings) {
                     settings.urlData.kod = $('#ddlatas').val();
                     settings.data = JSON.stringify({ q: settings.urlData.query, kod: settings.urlData.kod });
                     //searchQuery = settings.urlData.query;
                     return settings;
                 })--%>

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

        function SaveSucces() {
            $('#MessageModal').modal('toggle');

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

        

        //cara kalau ada pass parameter tambahan, lain nama field
       /* initDropdown("ddlMasterLookup", "smkb_mod_function.aspx/getListMasterLookup?q={query}", {
            value: 'ddlvot',      // specify which column is for data
            name: 'details'      // specify which column is for text
        }, function (settings) {
            //settings.urlData.kodbangunan = document.getElementById("ddlBangunan").value;
            settings.data = JSON.stringify({ q: settings.urlData.query});
            return settings;
        })*/

    </script>

    

<style>
    option[style*="display: none;"] {
        display: none;
    }
</style>


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
    </style>

  
        <div id="PermohonanTab" class="tabcontent" style="display: block">
                <div class="search-filter">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
                                <label for="inputEmail3" class="col-sm-3 col-form-label">Nama Pengguna :</label>
                                <div class="col-sm-8">
                                    <div id="divautocomplete" class="tt-menu" style="display:none">
                                        <div class="input-group">
                                        </div>
                                    </div>
                                    <div class="input-group">
                                        <%--<asp:DropDownList ID="ddlCariNamaUser" runat="server" CssClass="ui search dropdown"  EnableFilterSearch="true" FilterType="StartsWith" onchange="selectCountry()" onkeyup="filterCountries()"></asp:DropDownList>--%>

                                        <asp:DropDownList ID="ddlCariNamaUser" runat="server" CssClass="form-control"  EnableFilterSearch="true" FilterType="StartsWith"></asp:DropDownList>

                                        <div class="input-group-append">
                                            <button id="lbtnCari" runat="server" class="btn btn-outline" type="button"><i
                                            class="fa fa-search"></i>Cari</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

            <div class="table-title">
                <h6>Tahap Pengguna</h6>
                <div class="btn btn-primary" onclick="ShowPopup('2')">
                    <i class="fa fa-plus"></i>Tambah Senarai              
                </div>

            </div>

                    , Butiran, Keutamaan, Tarikh_Mula, Tarikh_Tamat, status, Dibuat_Oleh, Tarikh_Dibuat

       
            <div class="box-body" align="center">
                 <asp:GridView ID="gvKod" CssClass="table table-bordered table-striped grid" Width="100%" runat="server"
                     AutoGenerateColumns="false" ShowHeaderWhenEmpty ="true">
                    <Columns>
                        <asp:BoundField DataField="Kod_Detail" HeaderText="Code" HeaderStyle-HorizontalAlign="Center"> 
                            <ItemStyle Width="5%" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Butiran" ItemStyle-Width="20%">
                            <ItemTemplate>
                                <asp:LinkButton runat="server"
                                    Style="text-decoration: none; font: bold; color: blue"
                                    Text='<%# DataBinder.Eval(Container.DataItem, "Butiran") %>' class="lnk" CommandArgument="<%# CType(Container, GridViewRow).RowIndex %>" CommandName="Select" ssClass="btn-xs" ToolTip="Pilih" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Tarikh_Mula" HeaderText="Tarikh Mula" >
                            <ItemStyle Width="8%" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Status" HeaderText="Status" ItemStyle-Width="10%" />

                        <asp:BoundField DataField="Dibuat_Oleh" HeaderText="Dibuat Oleh" >
                            <ItemStyle Width="8%" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Tarikh_Dibuat" HeaderText="Tarikh Dibuat" >
                            <ItemStyle Width="8%" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Tindakan">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" class="lnk" CommandArgument="<%# CType(Container, GridViewRow).RowIndex %>" CommandName="Select" CssClass="btn-xs" Text="Edit" ToolTip="Tindakan untuk Kemaskini atau Hapus rekod.">
                                <i class="las la-edit"></i></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Width="3%" HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

            </div>

            <!-- Modal -->
            <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
                aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-s" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalCenterTitle">Tambah Tahap Pengguna                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <div class="modal-body">

                            <h6>Tahap Pengguna</h6>
                            <hr>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="row">
                                        <div class="form-group col-md-12">
                                            <label>Tahap</label>
                                            <asp:DropDownList ID="ddlMasterLookup" runat="server" CssClass="form-control" ></asp:DropDownList>
                                        </div>

                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label>Code</label>
                                            <input id="txtCode" runat="server" type="text" class="form-control" enable="true">
                                        </div>
                                        <div class="form-group col-md-12">
                                            <label>Description</label>
                                            <input id="txtDescription" runat="server" type="text" class="form-control" enable="true">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label>Start Date</label>
                                            <input id="txtStartDate1" runat="server" type="date" class="form-control" enable="true">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>End Date</label>
                                            <input id="txtEndDate1" runat="server" type="date" class="form-control" enable="true">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group col-md-6">
                                            <label>Status</label>
                                            <asp:RadioButtonList runat="server" ID="rblStatus" RepeatDirection="Horizontal">
                                                <asp:ListItem Selected="True" Value="1">Aktif </asp:ListItem>
                                                <asp:ListItem Value="0"> Tidak Aktif</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>Priority Indicator</label>
                                            <asp:RadioButtonList runat="server" ID="rblpriority_indicator" RepeatDirection="Horizontal">
                                                <asp:ListItem Selected="True" Value="1">Aktif </asp:ListItem>
                                                <asp:ListItem Value="0"> Tidak Aktif</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                            <button type="button" runat="server" id="lbtnSimpan" class="btn btn-secondary">Simpan</button>

                        </div>
                    </div>
                </div>
            </div>

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
        
    </script>

    <script type="text/javascript">
        var countries = document.getElementById("<%= ddlCariNamaUser.ClientID %>").getElementsByTagName("option");
        function filterCountries() {
            var input, filter, i;
            input = document.getElementById("<%= ddlCariNamaUser.ClientID %>");
        filter = input.value.toUpperCase();
        for (i = 0; i < countries.length; i++) {
            if (countries[i].innerHTML.toUpperCase().indexOf(filter) > -1) {
                countries[i].style.display = "";
            } else {
                countries[i].style.display = "none";
            }
        }
    }
    function selectCountry() {
        var input, filter, i;
        input = document.getElementById("<%= ddlCariNamaUser.ClientID %>");
            filter = input.value.toUpperCase();
            for (i = 0; i < countries.length; i++) {
                if (countries[i].innerHTML.toUpperCase().startsWith(filter)) {
                    input.value = countries[i].innerHTML;
                    break;
                }
            }
        }
    </script>
</asp:Content>