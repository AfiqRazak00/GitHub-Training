<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Tarikh_Gaji.aspx.vb" Inherits="SMKB_Web_Portal.Tarikh_Gaji" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <link type="text/css" rel="stylesheet" href="../../../Scripts/jquery 1.13.3/css/jquery.dataTables.min.css" />
    <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/dataTables.bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="../../../Scripts/bootstrap 3.3.7/bootstrap.min.js" />
    <link type="text/css" rel="stylesheet" href="../../../Scripts/cdn/css/responsive.bootstrap.min.css" />
    <script type="text/javascript" src="../../../Scripts/jquery 1.13.3/js/jquery.dataTables.min.js"></script>
    <style>
    

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
</style>
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

function SaveSucces() {
    $('#MessageModal').modal('toggle');
    $(".modal-body input").val("");
}
    function ShowPopup(elm) {

        if (elm == "1") {

            $(".modal-body input").val("");

            $('#<%=hdnSave.ClientID%>').val(elm);

            $('#tambah').modal('toggle');
        }
        else if (elm == "2") {
            $('#<%=hdnSave.ClientID%>').val(elm);

            $('#tambah').modal('toggle');

        }

    }
var win = null;
function OpenPopUp(mypage, myname, w, h, scroll, pos) {
    if (pos == "random") { LeftPosition = (screen.width) ? Math.floor(Math.random() * (screen.width - w)) : 100; TopPosition = (screen.height) ? Math.floor(Math.random() * ((screen.height - h) - 75)) : 100; }
    if (pos == "center") { LeftPosition = (screen.width) ? (screen.width - w) / 2 : 100; TopPosition = (screen.height) ? (screen.height - h) / 2 : 100; }
    else if ((pos != "center" && pos != "random") || pos == null) { LeftPosition = 0; TopPosition = 20 }
    settings = 'width=' + w + ',height=' + h + ',top=' + TopPosition + ',left=' + LeftPosition + ',scrollbars=' + scroll + ',location=no,directories=no,status=no,menubar=no,toolbar=no,resizable=yes';
    win = window.open(mypage, myname, settings);
    }

    function notification(msg) {
        $("#notify").html(msg)
        $("#NotifyModal").modal('show');
    }
</script>

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
        <div class="box-body" align="center" >               
            <asp:GridView ID="gvJenis" CssClass="table table-bordered table-striped grid" Width="100%" runat="server"
                    AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" >                                    
                <Columns>
                    <asp:BoundField DataField="bulan" HeaderText="Bulan">
                        <ItemStyle Width="10%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="tahun" HeaderText="Tahun">
                        <ItemStyle Width="10%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Tarikh_Byr_Gaji" HeaderText="Tarikh Gaji">
                        <ItemStyle Width="10%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Status" HeaderText="Status">
                        <ItemStyle Width="10%" HorizontalAlign="center" />
                    </asp:BoundField>
                   
                        <asp:TemplateField HeaderText="Kemaskini">
                            <ItemTemplate>

                                <asp:LinkButton ID="lbtnEdit" runat="server" ToolTip="Kemaskini" CommandName="EditRow" class="lnk" CommandArgument="<%# CType(Container, GridViewRow).RowIndex %>" >
                                        <i class="fa fa-edit"></i></asp:LinkButton>
    
                                    <asp:LinkButton ID="lbtnHapus" runat="server" ToolTip="Hapus" CommandName="DeleteRow" class="lnk" CommandArgument="<%# CType(Container, GridViewRow).RowIndex %>" OnClientClick="return confirm('Adakah anda pasti untuk padam rekod ini?');" >
                                        <i class="fa fa-trash-o delete"></i>
                                    </asp:LinkButton>

                            </ItemTemplate>
                            <ItemStyle Width="3%" HorizontalAlign="Center" />
                        </asp:TemplateField>
                </Columns>
            </asp:GridView>                   
        </div>

        <!-- Modal -->
        <div class="modal fade" id="tambah" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="eMCTitle">Tambah Tarikh Gaji</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                            <h6>Maklumat Tarikh Gaji</h6>
                            <hr>
                            <div class="row">
                                <input id="hdnSimpan" name="hdnSimpan"  runat="server" type="text" class="form-control" enable="true" visible="false">
                                <div class="col-md-6">
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            
                                             <select id="ddlMonths" runat="server" class="input-group__select ui search dropdown">
                                                  <option value="%">-- Sila Pilih --</option>
                                                  <option value="1">Januari</option>
                                                  <option value="2">Februari</option>
                                                  <option value="3">Mac</option>
                                                  <option value="4">April</option>
                                                  <option value="5">Mei</option>
                                                  <option value="6">Jun</option>
                                                  <option value="7">Julai</option>
                                                  <option value="8">Ogos</option>
                                                  <option value="9">September</option>
                                                  <option value="10">Oktober</option>
                                                  <option value="11">November</option>
                                                  <option value="12">Disember</option>
                                              </select>
                                            <label class="input-group__label" for="Bulan">Bulan</label>
                                        </div>
                                        <div class="form-group col-md-6">
                                            
                                            <select id="ddlyear" runat="server" class="input-group__select ui search dropdown">
                                                <option value="">-- Sila Pilih --</option>
                                                <option value="2024">2024</option>
                                                <option value="2023">2023</option>
                                                <option value="2022">2022</option>
                                                <option value="2021">2021</option>
                                                <option value="2020">2020</option>                                                   
                                            </select>
                                            <label class="input-group__label" for="Tahun">Tahun</label>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <asp:TextBox runat="server" ID="tkhGaji" CssClass="input-group__input" TextMode="Date" Style="width: 100%;text-transform:uppercase;"></asp:TextBox>
                                             <label class="input-group__label" for="Tarikh Gaji">Tarikh Gaji</label>
                                             <asp:RequiredFieldValidator ID="rqdTkhGaji" runat="server" ControlToValidate="tkhGaji" CssClass="text-danger" ErrorMessage="*Sila Masukkan Tarikh Gaji" ValidationGroup="Semak" Display="Dynamic"/>
                                        </div>

                                        <div class="form-group col-md-6">
                                                <asp:DropDownList ID="ddlStatus" CssClass="input-group__select ui search dropdown" runat="server">
                                                        <asp:ListItem  Value="">Sila Pilih</asp:ListItem>  
                                                        <asp:ListItem Value="AKTIF">AKTIF</asp:ListItem>  
                                                        <asp:ListItem Value="TIDAK AKTIF">TIDAK AKTIF</asp:ListItem>  
                                                </asp:DropDownList>
                                            <label class="input-group__label" for="Status">Status</label>
                                        </div>
                                    </div>
                                </div>
                                
                            </div>
                            <hr>  
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="$('#tambah').modal('hide'); return false;">Tutup</button>
                            <button type="button" runat="server" id="lbtnSave" class="btn btn-secondary">Simpan</button>

                    </div>
                    <div style="visibility:hidden">
    <asp:TextBox runat="server" ID="hdnSave" CssClass="input-group__input" Enabled="True" Style="width: 10%;" ></asp:TextBox>
 </div>
                </div>
            </div>
        </div>
    
        <!-- End Modal -->
       <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Makluman</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <asp:Label runat="server" ID="lblModalMessaage"/>                          
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                        
                        </div>
                    </div>
                </div>
            </div>
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

</asp:Content>
