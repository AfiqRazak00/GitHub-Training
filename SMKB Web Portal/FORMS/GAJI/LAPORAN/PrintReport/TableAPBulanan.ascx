<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TableAPBulanan.ascx.vb" Inherits="SMKB_Web_Portal.TableAPBulanan" %>

<table>
    <tr>
        <td runat="server" id="lblTajuk"></td>
    </tr>
</table>
<div runat="server" class="vot-list">
         <asp:Repeater runat="server" ID="rptone" OnItemDataBound="rptone_ItemDataBound">
             <ItemTemplate> 
                <div class="print-div">
                    <table>
                        <thead>
                            <tr><td colspan="6">
                                <div class="header-space">&nbsp;</div>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center; width: 10%;" class="tdbg1">Kw</td>
                                <td style="text-align: center; width: 10%;" class="tdbg1">Ptj</td>
                                <td style="text-align: center; width: 10%;" class="tdbg1">Vot</td>
                                <td style="text-align: center; width: 15%;" class="tdbg1">Status</td>
                                <td style="text-align: center; width: 25%;" class="tdbg1">Butiran</td>
                                <td style="text-align: center; width: 15%;" class="tdbg1">Debit</td>
                                <td style="text-align: center; width: 15%;" class="tdbg1">Kredit</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="repeaterDetail" runat="server" OnItemDataBound="repeaterDetail_ItemDataBound">
                                     <ItemTemplate>
                                     <tr>
                                         <td style="text-align: center;width: 10%;"><%#Eval("Kod_Kump_Wang")%></td>
                                         <td style="text-align: center;width: 10%;"><%#Eval("Kod_PTJ")%></td>
                                         <td style="text-align: center;width: 10%;"><%#Eval("Kod_Vot")%></td>
                                         <td style="text-align: center;width: 15%;"><%#Eval("Status")%></td>
                                         <td style="width: 25%;"><%#Eval("Butiran")%></td>
                                         <td style="text-align: right;width: 15%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Debit")) %></td>
                                         <td style="text-align: right;width: 15%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Kredit")) %></td>
                                     </tr>
                                 </ItemTemplate>
                            </asp:Repeater>
                            <tr>
                                <td colspan="7" style="border-bottom: 1px solid #000;"></td>
                            </tr>
                            <tr>
                                <td colspan="5" style="text-align:right;font-weight: bold">Jumlah</td>
                                <td id="jumlahDebit" runat="server" style="text-align:right;font-weight: bold"></td>
                                <td id="jumlahKredit" runat="server" style="text-align:right;font-weight: bold"></td>
                            </tr>
                            <tr>
                                <td colspan="7" class="double-line"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
             </ItemTemplate>
        </asp:Repeater>

</div> 