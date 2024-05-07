<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TableStokBarang.ascx.vb" Inherits="SMKB_Web_Portal.TableStokBarang" %>
<div runat="server" class="vot-list">
    <asp:Repeater runat="server" ID="rptone" OnItemDataBound="rptone_ItemDataBound">
        <ItemTemplate>
            <div class="print-div">
                <table class="header-table">
                    <thead>
                        <tr>
                            <td colspan="8" class="header-space">&nbsp;</td>
                        </tr>
                    </thead>
                </table>

                <table>
                    <thead>
                        <tr>
                            <td class="tdbg1">No</td>
                            <td class="tdbg1">Kod Barang</td>
                            <td class="tdbg1">Barang</td>
                            <td class="tdbg1">Ukuran</td>
                            <td class="tdbg1">Takat Minima</td>
                            <td class="tdbg1">Takat Maksima</td>
                            <td class="tdbg1">Takat Menokok</td>
                            <td class="tdbg1">Baki</td>
                        </tr>
                    </thead>
                    <tbody>
                      <asp:Repeater ID="repeaterDetail" runat="server" OnItemDataBound="repeaterDetail_ItemDataBound">
                        <ItemTemplate>
                            <tr style='<%# GetBakiStyle(Eval("Baki"), Eval("takat_Min"), Eval("Takat_menokok")) %>'>
                                <td style="text-align:center;"><%#Eval("No")%></td>
                                <td style="text-align:center;"><%#Eval("Kod_Brg")%></td>
                                <td style="text-align:left;"><%# Eval("Butiran")%></td>
                                <td style="text-align:left;"><%# Eval("Ukuran")%></td>
                                <td style="text-align:center;"><%# Eval("takat_Min") %></td>
                                <td style="text-align:center;"><%# Eval("takat_max") %></td>
                                <td style="text-align:center;"><%# Eval("Takat_menokok") %></td>
                                <td style="text-align:center;"><%# Eval("Baki") %></td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>

                    </tbody>
                </table>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>

<%--<style>
    .tdbg1 {
        text-align: center;
        padding: 5px; /* Adding padding for better spacing */
        color: lime;
    }

</style>--%>
