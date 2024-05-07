<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Kod_Transaksi.aspx.vb" Inherits="SMKB_Web_Portal.Kod_Transaksi" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
<script type="text/javascript">

    $(function () {
        $('#<%= gvJenis.ClientID%>').prepend($("<thead></thead>").append($("#<%= gvJenis.ClientID%>").find("tr:first"))).DataTable({
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

        //$("#hdnSimpan").val("1");
        //$(".modal-body #hdnSimpan").val("1");
        
        //$('.hdnSave').html(elm);

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

    <div class="search-filter">

        <div class="form-row justify-content-center">
            <div class="form-group row col-md-6">
                <label for="txtPerihal1" class="col-sm-2 col-form-label" style="text-align: right">Jenis Transaksi :</label>
                <div class="col-sm-7">
                    <div class="input-group">
                    <asp:DropDownList ID="ddlJenis" runat="server" CssClass="form-control" EnableFilterSearch="true" FilterType="StartsWith">
                        </asp:DropDownList>                                

                    </div>
                    <div class="input-group">
                        <asp:LinkButton ID="lbtnCari" OnClick="lbtnCari_Click" runat="server" autopostback ="true" CssClass="btn btn-outline" > 
                        <i class="fa fa-search"></i>Cari </asp:LinkButton>
                     
                    </div>
                </div>

            </div>

        </div>

    </div>


    <div class="table-title">
        <h6>Senarai Transaksi</h6>
        <hr>
        <div class="btn btn-primary"  onclick="ShowPopup('1')">
            <i class="fa fa-plus"></i>Tambah Transaksi              
        </div>&nbsp;&nbsp;
        
    </div>
           
        <div class="box-body" align="center" >               
            <asp:GridView ID="gvJenis" CssClass="table table-bordered table-striped grid" Width="100%" runat="server"
                    AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" >                                    
                <Columns>
                    <asp:BoundField DataField="jenis_trans" HeaderText="Jenis Transaksi" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle Width="5%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Kod_Trans" HeaderText="Kod Transaksi" ItemStyle-HorizontalAlign="Center">
                        <ItemStyle Width="7%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Butiran" HeaderText="Butiran" HeaderStyle-VerticalAlign="Middle" HeaderStyle-HorizontalAlign="Center">
                        <ItemStyle Width="30%" HorizontalAlign="Left" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Kira_Kwsp" HeaderText="Kira KWSP">
                        <ItemStyle Width="7%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Kira_Perkeso" HeaderText="Kira Perkeso">
                        <ItemStyle Width="7%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Kira_Cukai" HeaderText="Kira Cukai">
                        <ItemStyle Width="7%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Kira_Pencen" HeaderText="Kira Pencen">
                        <ItemStyle Width="7%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Vot_Tetap" HeaderText="Vot Tetap">
                        <ItemStyle Width="7%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Vot_Bukan_Tetap" HeaderText="Vot Bukan Tetap" >
                        <ItemStyle Width="7%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Masuk_AP"  Visible="false" >
                        <ItemStyle Width="5%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Jenis" Visible="false">
                        <ItemStyle Width="5%" HorizontalAlign="center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="kod_kerajaan" Visible="false">
                        <ItemStyle Width="5%" HorizontalAlign="center" />
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
                        <h5 class="modal-title" id="eMCTitle">Tambah Jenis Transaksi</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                            <h6><U><b>Maklumat Transaksi</b></U></h6>
                           <br />
                            <div class="row"> 
                                <div class="col-md-6">
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            
                                           <asp:DropDownList ID="DropDownList1" CssClass="input-group__select ui search dropdown" runat="server">
                                                        
                                            </asp:DropDownList>
                                            <label class="input-group__label" for="Jenis Transaksi">Jenis Transaksi</label>
                                            <asp:RequiredFieldValidator ID="rqdJenis" runat="server" ControlToValidate="DropDownList1" CssClass="text-danger" ErrorMessage="*Sila Masukkan Jenis" ValidationGroup="Semak" Display="Dynamic"/>

                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            
                                            <asp:TextBox runat="server" ID="txtJenis" CssClass="input-group__input" Style="width: 100%;text-transform:uppercase;" MaxLength="10" ></asp:TextBox>
                                            <label class="input-group__label" for="Kod Transaksi">Kod Transaksi</label>
                                            <asp:RequiredFieldValidator ID="rqdKod" runat="server" ControlToValidate="txtJenis" CssClass="text-danger" ErrorMessage="*Sila Masukkan Kod Transaksi" ValidationGroup="Semak" Display="Dynamic"/>

                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <asp:TextBox runat="server" ID="txtButir" CssClass="input-group__input" Style="width: 100%;text-transform:uppercase;" MaxLength="60" ></asp:TextBox>
                                            <label class="input-group__label" for="Butiran">Butiran</label>
                                            <asp:RequiredFieldValidator ID="rqdButir" runat="server" ControlToValidate="txtButir" CssClass="text-danger" ErrorMessage="*Sila Masukkan Butiran" ValidationGroup="Semak" Display="Dynamic"/>

                                        </div>
                                    </div>
                                   
                                    <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <asp:DropDownList ID="ddlVotTetap" CssClass="input-group__select ui search dropdown" runat="server">
                                                        
                                                    </asp:DropDownList>
                                                    <label class="input-group__label" for="Vot Tetap">Vot Tetap</label>
                                                    <asp:RequiredFieldValidator ID="rqdVotTetap" runat="server" ControlToValidate="ddlVotTetap" CssClass="text-danger" ErrorMessage="*Sila Masukkan Vot Tetap" ValidationGroup="Semak" Display="Dynamic"/>
                                                </div>
                                                
                                            </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-6">
    
                                                <asp:DropDownList ID="ddlVotBknTetap" CssClass="input-group__select ui search dropdown" runat="server">
        
                                                </asp:DropDownList>
                                                <label class="input-group__label" for="Vot Bukan Tetap">Vot Bukan Tetap</label>
                                                <asp:RequiredFieldValidator ID="rqdVotXTetap" runat="server" ControlToValidate="ddlVotBknTetap" CssClass="text-danger" ErrorMessage="*Sila Masukkan Vot Bukan Tetap" ValidationGroup="Semak" Display="Dynamic"/>


   
                                            </div>
                                        </div>
              
                                            <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label>Kira KWSP</label>
                                                    <div class="radio-btn-form">
                                                        <asp:RadioButtonList ID="rbKWSP" runat="server" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="1" Text="Ya">  </asp:ListItem>
                                                            <asp:ListItem Value="2" Text="Tidak"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>

                                                </div>
                                                <div class="form-group col-md-6">
                                                    <label>Kira Perkeso</label>
                                                    <div class="radio-btn-form">
                                                        <asp:RadioButtonList ID="rbPerkeso" runat="server" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="1" Text="Ya">  </asp:ListItem>
                                                            <asp:ListItem Value="2" Text="Tidak"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                            </div>
                                             <div class="form-row">
                                                <div class="form-group col-md-6">
                                                    <label>Kira Cukai</label>
                                                    <div class="radio-btn-form">
                                                        <asp:RadioButtonList ID="rbCukai" runat="server" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="1" Text="Ya">  </asp:ListItem>
                                                            <asp:ListItem Value="2" Text="Tidak"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>

                                                <div class="form-group col-md-6">
                                                    <label>Kira Pencen</label>
                                                    <div class="radio-btn-form">
                                                        <asp:RadioButtonList ID="rbPencen" runat="server" RepeatDirection="Horizontal">
                                                            <asp:ListItem Value="1" Text="Ya">  </asp:ListItem>
                                                            <asp:ListItem Value="2" Text="Tidak"></asp:ListItem>
                                                        </asp:RadioButtonList>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label>Kira AP</label>
                                                <div class="radio-btn-form">
                                                    <asp:RadioButtonList ID="rbAP" runat="server" RepeatDirection="Horizontal">
                                                        <asp:ListItem Value="1" Text="Ya">  </asp:ListItem>
                                                        <asp:ListItem Value="2" Text="Tidak"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </div>
                                            </div>
                                            </div>
                                    <div class="form-row" >
                                        <div class="form-group col-md-12">
                                                                                                
                                                    <asp:DropDownList ID="ddlJnsPot" CssClass="input-group__select ui search dropdown" runat="server">
                                                        
                                                    </asp:DropDownList>
                                                    <label class="input-group__label" for="Jenis Potongan">Jenis Potongan</label>
                                                    <asp:RequiredFieldValidator ID="rqdPot" runat="server" ControlToValidate="ddlJnsPot" CssClass="text-danger" ErrorMessage="*Sila Masukkan Vot Bukan Tetap" ValidationGroup="Semak" Display="Dynamic"/>

                                        </div>
                                    </div>
                                    <div class="form-row" >
                                        <div class="form-group col-md-12">                                                                            
                                                    <asp:DropDownList ID="ddlAgensi" CssClass="input-group__select ui search dropdown" runat="server">
                                                        
                                                    </asp:DropDownList>
                                                    <label class="input-group__label" for="Agensi">Agensi</label>
                                                    <asp:RequiredFieldValidator ID="rqdAgensi" runat="server" ControlToValidate="ddlAgensi" CssClass="text-danger" ErrorMessage="*Sila Masukkan Vot Bukan Tetap" ValidationGroup="Semak" Display="Dynamic"/>

                                                
                                        </div>
                                    </div>
                                   <div class="form-row">
                                   <div class="form-group col-md-6">
                                       <label>Potongan Staf</label>
                                       <div class="radio-btn-form">
                                           <asp:RadioButtonList ID="rbMohon" runat="server" RepeatDirection="Horizontal">
                                               <asp:ListItem Value="1" Text="Ya">  </asp:ListItem>
                                               <asp:ListItem Value="2" Text="Tidak"></asp:ListItem>
                                           </asp:RadioButtonList>
                                       </div>
                                   </div>
                                   </div>
                                </div>
                                
                            </div>
                    </div>

                     <div class="modal-footer">
                         
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                            <button type="button"  runat="server" id="lbtnSave" class="btn btn-secondary">Simpan</button>
                            
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
