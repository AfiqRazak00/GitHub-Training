<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Kumpulan_Pengguna.aspx.vb" Inherits="SMKB_Web_Portal.Kumpulan_Pengguna" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%= Convert.ToString(Request.QueryString("Title")) %></h1>
        <link rel="stylesheet" type="text/css" href="../../../Content/Site.css">

			<asp:UpdatePanel ID="UpdatePanel1" runat="server">        
				<ContentTemplate>
					<div class="row">
						<div class="col-sm-9 col-md-6 col-lg-8">
							<p></p>
                            <div class="panel panel-default" style="width:100%">
                            <div class="panel-body">
							<table style="width:100%" class="table table table-borderless" >
                            <tr>
								<td>
									<asp:Label ID="Label3" runat="server" Text="Kod Tahap" style="width: 20%;"></asp:Label>
								</td>
								<td>
									<asp:textbox ID="txtKodTahap" runat="server" CssClass="form-control" style="width: 100px;" MaxLength="5"></asp:textbox>
									<asp:RequiredFieldValidator ID="rfvtxtKodTahap" runat="server" ControlToValidate="txtKodTahap" ErrorMessage="" ForeColor="#820303" Text="*Sila Isi" ValidationGroup="btnSimpan" Display="Dynamic" CssClass="fontValidatation" ></asp:RequiredFieldValidator>
								</td>
							</tr>
							<tr>
								<td style="width: 20%;">
									<asp:Label ID="Label1" runat="server" Text="Jenis Tahap"></asp:Label>
								</td>
								<td style="width: 80%;">
									<asp:textbox ID="txtJenisTahap" runat="server"  CssClass="form-control" width="80%" ></asp:textbox>
                                    <asp:RequiredFieldValidator ID="rfvJnsTahap" runat="server" ControlToValidate="txtJenisTahap" ErrorMessage="" ForeColor="#820303" Text="*Sila Isi" ValidationGroup="btnSimpan" Display="Dynamic" CssClass="fontValidatation" ></asp:RequiredFieldValidator>
								</td>
							</tr>
							
							</table>

							<br />
						    <div class="row">
				            <div style="text-align:center">
					           <asp:LinkButton ID="lbtnReset" runat="server" CssClass="btn btn-info" ToolTip="Kosongkan Butiran Perbelanjaan">
						            <i class="fas fa-sync-alt fa-lg"></i>&nbsp;&nbsp;&nbsp;Reset
                            </asp:LinkButton>
                            &nbsp;&nbsp;&nbsp;
					            <asp:LinkButton ID="lbtnSimpan" runat="server" CssClass="btn btn-info" ValidationGroup="btnSimpan">
						            <i class="far fa-save fa-lg"></i>&nbsp;&nbsp;&nbsp;Simpan
                                </asp:LinkButton>
                            <asp:LinkButton ID="lbtnKemaskini" runat="server" CssClass="btn btn-info" ToolTip="Kemaskini" ValidationGroup="btnSimpan">
                                    <i class="fas fa-edit fa-lg"></i>&nbsp;&nbsp;&nbsp;Kemaskini
                            </asp:LinkButton>
                            &nbsp;&nbsp;
                                <asp:LinkButton ID="lbtnUndo" runat="server" CssClass="btn btn-info" ToolTip="Kemaskini">
                                    <i class="fas fa-undo fa-lg"></i>&nbsp;&nbsp;&nbsp;Undo
                                </asp:LinkButton>                     
				            </div>
			                </div>
                                <br />
                            
                                <div class="GvTopPanel" style="height: 33px;">
                        <div style="float: left; margin-top: 5px; margin-left: 10px;">
                            Jumlah rekod :&nbsp;
                            <asp:Label ID="lblJumRekodS" runat="server" style="color: mediumblue;" ></asp:Label>

                            &nbsp;&nbsp;   <b style="color: #969696;">|</b> &nbsp;&nbsp;

                            Saiz Rekod : 
                            <asp:DropDownList ID="ddlSaizRekod" runat="server" Width="50px" AutoPostBack="True" class="form-control">
                                <asp:ListItem Text="25" Value="25" Selected="True" />
                                <asp:ListItem Text="50" Value="50" />
                                <asp:ListItem Text="100" Value="100" />
                                <asp:ListItem Text="500" Value="500" />
                            </asp:DropDownList>
                            
                        </div>
                    </div>
	  <asp:GridView ID="gvKumpPengguna" runat="server" ShowHeaderWhenEmpty="True" AutoGenerateColumns="False" AllowSorting="true" AllowPaging="true" pagesize="250"
		CssClass= "table table-striped table-bordered table-hover" Width="100%"  Font-Size="8pt"  BorderStyle="Solid" >
		<columns>
			<asp:TemplateField HeaderText = "Bil" SortExpression="Bil" HeaderStyle-CssClass="centerAlign" ItemStyle-HorizontalAlign="Center">
				<ItemTemplate>
					<asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
				</ItemTemplate>
			</asp:TemplateField>
			<asp:BoundField HeaderText="Kod Tahap" DataField="KodTahap" SortExpression="KodTahap" ItemStyle-HorizontalAlign="Center" />
			<asp:BoundField HeaderText="Jenis Tahap" DataField="JenTahap" SortExpression="JenTahap" />				  
			<asp:TemplateField>
				<ItemTemplate>
					<asp:LinkButton ID="lbtnSelect" runat="server" CommandName="Select" CssClass="btn-xs" ToolTip="Pilih Kemaskini">
						<i class="fas fa-edit fa-lg"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" CssClass="btn-xs" ToolTip="Padam"
                                        OnClientClick="return confirm('Anda pasti untuk padam rekod ini?');">
						<i class="fas fa-trash-alt fa-lg"></i>   
                                        </asp:LinkButton>                         
				</ItemTemplate>
				<ItemStyle Width="6%" HorizontalAlign="Center" />
			</asp:TemplateField>
	</columns>
		  <SelectedRowStyle  ForeColor="#0000FF" />
	</asp:GridView>
					</div></div>
                    </div></div>
				</ContentTemplate>
			</asp:UpdatePanel>
</asp:Content>
