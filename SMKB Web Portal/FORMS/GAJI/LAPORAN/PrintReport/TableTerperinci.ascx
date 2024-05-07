<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TableTerperinci.ascx.vb" Inherits="SMKB_Web_Portal.TableTerperinci" %>

<div runat="server" class="vot-list">
         <asp:Repeater runat="server" ID="rptone" OnItemDataBound="rptone_ItemDataBound">
             <ItemTemplate> 
                <div class="print-div">
                    <table>
                        <thead>
                            <tr>
                               <td colspan="4">
                                    <div class="header-space">&nbsp;</div>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 10%;" class="tdbg1" >Kod</td>
                                <td style="width: 10%;" class="tdbg1">Jenis</td>
                                <td style="width: 50%;" class="tdbg1">Butiran</td>
                                <td style="width: 30%;text-align:right;" class="tdbg1">Amaun</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="repeaterDetail" runat="server" OnItemDataBound="repeaterDetail_ItemDataBound">
                                     <ItemTemplate>
                                        <tr>
                                             <td><%#Eval("Kod_Trans")%></td>
                                             <td><%#Eval("Butiran_Jenis")%></td>
                                             <td><%#Eval("Butiran_Kod")%></td>
                                             <td style="text-align:right;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Amaun")) %></td>
                                      <tr/>
                                 </ItemTemplate>
                            </asp:Repeater>
                            <tr>
                                <td colspan="4" style="border-bottom: 2px solid #000;"></td>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align:right;"></td>
                                <td id="jumlah" runat="server" style="font-weight: bold;text-align:right;"></td>
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
