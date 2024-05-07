<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TableRingkasanGaji.ascx.vb" Inherits="SMKB_Web_Portal.TableRingkasanGaji" %>
<%--<table>
    <tr>
        <td runat="server" id="lblTajuk"></td>
    </tr>
</table>--%>
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
                                <td style="text-align: center; width: 5%" class="tdbg1" rowspan="2">No</td>
                                <td style="text-align: center; width: 15%" class="tdbg1" rowspan="2">Nama</td>
                                <td style="text-align: center; width: 5%;" class="tdbg1" rowspan="2">Gaji Pokok</td>
                                <td style="text-align: center; width: 5%;" class="tdbg1" rowspan="2">Bonus</td>
                                <td style="text-align: center; width: 5%;" class="tdbg1" rowspan="2">Elaun</td>
                                <td style="text-align: center; width: 5%;" class="tdbg1" rowspan="2">OT</td>
                                <td style="text-align: center; width: 5%;" class="tdbg1" rowspan="2">Gaji Kasar</td>
                                <td style="text-align: center; width: 5%;" class="tdbg1" rowspan="2">Potongan</td>
                                <td style="text-align: center; width: 5%;" class="tdbg1" rowspan="2">Cuti</td>
                                <td style="text-align: center; width: 5%;" class="tdbg1" colspan="2">Pekerja</td>
                                <td style="text-align: center; width: 5%;" class="tdbg1" rowspan="2">PCB</td>
                                <td style="text-align: center; width: 5%;" class="tdbg1" rowspan="2">Gaji Bersih</td>
                                <td style="text-align: center; width: 5%;" class="tdbg1" colspan="2">Majikan</td>
                            </tr>
                            <tr>
                                <td class="tdbg1">KWSP</td>
                                <td class="tdbg1">Perkeso</td>
                                <td class="tdbg1">KWSP</td>
                                <td class="tdbg1">Perkeso</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="repeaterDetail" runat="server">
                                     <ItemTemplate>
                                     <tr>
                                         <td style="text-align: center;width: 5%"><%#Eval("No_Staf")%></td>
                                         <td style="width: 15%"><%#Eval("Nama")%></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "G")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "B")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "E")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "O")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Gaji_Kasar")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "P")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "C")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "K")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "S")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "T")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Gaji_Bersih")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "KWSM")) %></td>
                                         <td style="text-align: right; width: 5%;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "SOCM")) %></td>
                                      </tr>
                                 </ItemTemplate>
                            </asp:Repeater>
                            <script>
                            </script>
                        </tbody>
                    </table>
                </div>
             </ItemTemplate>
        </asp:Repeater>

</div> 