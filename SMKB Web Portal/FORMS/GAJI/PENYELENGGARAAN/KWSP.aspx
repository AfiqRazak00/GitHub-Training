<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="KWSP.aspx.vb" Inherits="SMKB_Web_Portal.KWSP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
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
        $('#<%= gvKwsp.ClientID%>').prepend($("<thead></thead>").append($("#<%= gvKwsp.ClientID%>").find("tr:first"))).DataTable({
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
       // $(".modal-body #hdnSimpan").val('1'); 
       
        $('#tambah').modal('toggle');
    }
    else if (elm == "2") {
       // $("#hdnSimpan").val("2");
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
        <h6>Senarai KWSP</h6>
        <hr>
        <div class="btn btn-primary"  onclick="ShowPopup('1')">
            <i class="fa fa-plus"></i>Tambah KWSP              
        </div>&nbsp;&nbsp;
        
    </div>
           <br/>
        <div class="box-body" align="center" >               
            <asp:GridView ID="gvKwsp" CssClass="table table-bordered table-striped grid" Width="100%" runat="server"
                    AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" >                                    
                <Columns>
                    <asp:BoundField DataField="Kod" HeaderText="Kod">
                        <ItemStyle Width="10%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Butiran" HeaderText="Butiran">
                        <ItemStyle Width="50%" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Kwsp_Maj" HeaderText="Majikan (%)">
                        <ItemStyle Width="20%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Kwsp_Pek" HeaderText="Pekerja (%)">
                        <ItemStyle Width="20%" HorizontalAlign="center" />
                    </asp:BoundField>
                   
                        <asp:TemplateField HeaderText="Kemaskini">
                            <ItemTemplate>

                                <asp:LinkButton ID="lbtnEdit" runat="server" ToolTip="Kemaskini" CommandName="EditRow" class="lnk" CssClass="btn-xs" CommandArgument="<%# CType(Container, GridViewRow).RowIndex %>" >
                                        <i class="fa fa-edit"></i></asp:LinkButton>
    
                                    <asp:LinkButton ID="lbtnHapus" runat="server" ToolTip="Hapus" CommandName="DeleteRow" class="lnk" CssClass="btn-xs" CommandArgument="<%# CType(Container, GridViewRow).RowIndex %>" OnClientClick="return confirm('Adakah anda pasti untuk padam rekod ini?');" >
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
                        <h5 class="modal-title" id="eMCTitle">Tambah Kwsp</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                            <h6>Maklumat Kwsp</h6>
                            <hr>
                 
                                <%--<input id="hdnSimpan" name="hdnSimpan"  runat="server" type="text" class="form-control" enable="true">--%>

                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                  
                                            <asp:TextBox runat="server" ID="txtJenis" CssClass="input-group__input" Style="width: 50%;text-transform:uppercase;" ></asp:TextBox>
                                            <label class="input-group__label" for="Kod">Kod</label>
                                        </div>
                                        <div class="form-group col-md-8">
                                            <asp:TextBox runat="server" ID="txtButir" CssClass="input-group__input" Style="width: 100%;text-transform:uppercase;" ></asp:TextBox>
                                            <label class="input-group__label" for="Butiran">Butiran</label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <asp:TextBox runat="server" ID="txtMaj" CssClass="input-group__input" Style="width: 50%;" ></asp:TextBox>
                                            <label class="input-group__label" for="Majikan (%)">Majikan (%)</label>
       
                                        </div>
                                         <div class="form-group col-md-8">
                                               <asp:TextBox runat="server" ID="txtPek" CssClass="input-group__input" Style="width: 50%;" ></asp:TextBox>
                                               <label class="input-group__label" for="Pekerja (%)">Pekerja (%)</label>
 
                                         </div>
                                    </div> 

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
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
                            <h5 class="modal-title" id="exampleModalLabel">Tolong Sahkan?</h5>
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
