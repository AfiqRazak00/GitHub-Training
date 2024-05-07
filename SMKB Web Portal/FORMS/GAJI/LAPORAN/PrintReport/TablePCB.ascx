<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TablePCB.ascx.vb" Inherits="SMKB_Web_Portal.TablePCB" %>

<table>
    <tr>
        <td runat="server" id="lblTajuk"></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>
</table>
<div runat="server" class="vot-list">
         <asp:Repeater runat="server" ID="rptone" OnItemDataBound="rptone_ItemDataBound">
             <ItemTemplate> 
                <div class="print-div">
                    <table class="table-with-border">
                        <thead>
                            <tr><td colspan="6">
                                <div class="header-space">&nbsp;</div>
                                </td>
                            </tr>
                            <tr runat="server" id="tableHeader">  <%--table-header  --%>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="repeaterDetail" runat="server">
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
             </ItemTemplate>
        </asp:Repeater>
</div>