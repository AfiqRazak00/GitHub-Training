
<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TableOTBulanan.ascx.vb" Inherits="SMKB_Web_Portal.TableOTBulanan" %>
<table>
    <tr>
    </tr>
</table>
<div runat="server" class="vot-list">
    <asp:Repeater runat="server" ID="rptone" OnItemDataBound="rptone_ItemDataBound">
        <ItemTemplate> 
        <div class="print-div">
            <table>
                <thead>
                    <tr>
                        <td colspan="3"><div class="header-space">&nbsp;</div></td>
                    </tr>
                    <tr>
                        <td class="tdbg1 valuetengah" rowspan ="2">No</td>
                        <td class="tdbg1 valuetengah" rowspan ="2">Nama</td>
                        <td class="tdbg1 valuetengah" rowspan ="2">Tarikh</td>
                        <td class="tdbg1 valuetengah" rowspan ="2">Gaji</td>
                        <td class="tdbg1 valuetengah" colspan ="3">Tuntut</td>
                        <td class="tdbg1 valuetengah" colspan ="3">Sah</td>
                        <td class="tdbg1 valuetengah" colspan ="3">Lulus</td>
                    </tr>
                    <tr>
                        <td class="tdbg1 valuetengah">Jam</td>
                        <td class="tdbg1 valuetengah">Kadar</td>
                        <td class="tdbg1 valuetengah">Amaun</td>
                        <td class="tdbg1 valuetengah">Jam</td>
                        <td class="tdbg1 valuetengah">Kadar</td>
                        <td class="tdbg1 valuetengah">Amaun</td>
                        <td class="tdbg1 valuetengah">Jam</td>
                        <td class="tdbg1 valuetengah">Kadar</td>
                        <td class="tdbg1 valuetengah">Amaun</td>
                    </tr>
                    <tr>
                        <td colspan="14" class="tdbg1"><span class="underline-text">PTJ: <%#Eval("OT_Ptj")%> - <%#Eval("Pejabat")%></span></td>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="repeaterDetail" runat="server" OnItemDataBound="repeaterDetail_ItemDataBound">
                                <ItemTemplate>
                                <tr>
                                    <td class="valuetengah"><%#Eval("No_Staf")%></td>
                                    <td><%#Eval("Nama")%></td>
                                    <td style="text-align:center"><%#Eval("formatted_date")%></td>
                                    <td style="text-align:right"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Gaji")) %> </td>
                                    <td style="text-align:center"><%#Eval("Jum_Jam_Tuntut")%></td>
                                    <td style="text-align:center"><%#Eval("Kadar_Tuntut")%></td>
                                    <td style="text-align:right"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Amaun_Tuntut")) %> </td>
                                    <td style="text-align:center"><%#Eval("Jum_Jam_Sah")%></td>
                                    <td style="text-align:center"><%#Eval("Kadar_Sah")%></td>
                                    <td style="text-align:right"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Amaun_Sah")) %> </td>
                                    <td style="text-align:center"><%#Eval("Jum_Jam_Lulus")%></td>
                                    <td style="text-align:center"><%#Eval("Kadar_Lulus")%></td>
                                    <td style="text-align:right"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Amaun_Lulus")) %> </td>
                                </tr>
                            </ItemTemplate>
                    </asp:Repeater>
                    <tr>
                        <td colspan="16" style="border-bottom: 1px solid #000;"></td>
                    </tr>
                    <tr>
                        <td colspan="8"></td>
                        <td colspan="6" id="jumlahAmaun" runat="server" style="text-align:right;font-weight: bold"></td>
                    </tr>
                    <tr>
                        <td colspan="16" style="border-bottom: 1px solid #000;"></td>
                    </tr>
                </tbody>
            </table>
             
        </div>
        </ItemTemplate>
</asp:Repeater>
</div> 