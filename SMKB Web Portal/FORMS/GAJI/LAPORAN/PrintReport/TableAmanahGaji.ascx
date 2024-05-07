<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TableAmanahGaji.ascx.vb" Inherits="SMKB_Web_Portal.TableAmanahGaji" %>

<div runat="server" class="vot-list">
         <asp:Repeater runat="server" ID="rptone" OnItemDataBound="rptone_ItemDataBound">
             <ItemTemplate> 
                <div class="print-div">
                    <table>
                        <thead>
                            <tr>
                               <td colspan="3">
                                    <div class="header-space">&nbsp;</div>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 10%;" class="tdbg1" >No Staf</td>
                                 <td style="width: 10%;" class="tdbg1"></td>                            
                                <td style="width: 60%;" class="tdbg1">Nama</td>
                                <td style="width: 30%; text-align:right;" class="tdbg1">Amaun (RM)</td>                            

                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="repeaterDetail" runat="server" OnItemDataBound="repeaterDetail_ItemDataBound">
                                     <ItemTemplate>
                                        <tr>
                                             <td><%#Eval("No_Staf")%></td>
                                             <td></td>

                                             <td><%#Eval("Nama")%></td>
                                             <td style="text-align:right;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Gaji_Bersih")) %></td>
                                      <tr/>
                                 </ItemTemplate>
                            </asp:Repeater>
                            <tr>
                                <td colspan="4" style="border-bottom: 2px solid #000;"></td>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align:right;"></td>
                                <td  id="jumlah" runat="server" style="font-weight: bold;text-align:right;"></td>
                            </tr>
                            <tr>
                                <td colspan="4" style="border-bottom: 2px solid #000;"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
             </ItemTemplate>
        </asp:Repeater>
</div> 
