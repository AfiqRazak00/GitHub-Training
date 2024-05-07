
<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TablePCBTerperinci.ascx.vb" Inherits="SMKB_Web_Portal.TablePCBTerperinci" %>


<style>

    .tdbg1 {
        border: 0.5px solid #999; /* Use a lighter color, such as #999 (gray) */

        font-weight: bold;
    }
    .tdbg2 {
        border: 0.5px solid #999; /* Use a lighter color, such as #999 (gray) */

    }

    .text-right {
         text-align: right;
    }
    .text-center{
         text-align:center;
     }
</style>

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
                                <td style="width: 10%;" class="tdbg1 text-center">No</td>
                                 <td style="width: 20%;" class="tdbg1 text-center">Nama</td>                            
                                <td style="width: 10%;" class="tdbg1 text-center" >Jumlah</td>
                                <td style="width: 10%;" class="tdbg1 text-center">Pot KWSP</td>
                                <td style="width: 10%;" class="tdbg1  text-center">Jum Pen PCB</td>
                                <td style="width: 10%;" class="tdbg1 text-center" >B/BER/BB/BTB</td>
                                <td style="width: 10%;" class="tdbg1 text-center">Anak Bwh 18</td>
                                <td style="width: 10%;" class="tdbg1  text-center">PCB</td>
                                <td style="width: 10%;" class="tdbg1 text-center">Pot Zakat</td>
                                <td style="width: 10%;" class="tdbg1  text-center">Pot PCB</td>
                            </tr>
                        </thead>
                        <tbody>
                          <asp:Repeater ID="repeaterDetail" runat="server" OnItemDataBound="repeaterDetail_ItemDataBound">
                                <ItemTemplate>
                                    <tr>
                                        <td class="tdbg2 text-center"><%#Eval("No_Staf")%></td>
                                        <td class="tdbg2 "><%#Eval("Nama")%></td>
                                        <td class="tdbg2 text-right"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Gaji")) %></td>
                                        <td class="tdbg2 text-right"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "KWSP")) %></td>
                                        <td class="tdbg2 text-right"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Jum_Pen_PCB")) %></td>
                                        <td class="tdbg2 text-center"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Kategori_Cukai")) %></td>
                                        <td class="tdbg2 text-center"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "anakbelow18")) %></td>
                                        <td class="tdbg2 text-right"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "PCB")) %></td>
                                        <td class="tdbg2 text-right"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Zakat")) %></td>
                                        <td class="tdbg2 text-right"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Pot_PCB")) %></td>
                                    </tr>
                                                                       
                                </ItemTemplate>

                            </asp:Repeater>
                               <tr>
                                  <td colspan="2" style="text-align:right;"  class="tdbg2"></td>
                                  <td  id="jum" runat="server" style="font-weight: bold;text-align:right;"  class="tdbg2"></td>
                                  <td  id="potKWSP" runat="server" style="font-weight: bold;text-align:right;" class="tdbg2"></td>
                                  <td  id="jumPen" runat="server" style="font-weight: bold;text-align:right;" class="tdbg2"></td>
                                 <td class="tdbg2"></td>
                                 <td class="tdbg2"></td>
                                  <td  id="PCB" runat="server" style="font-weight: bold;text-align:right;" class="tdbg2"></td>
                                  <td  id="potZakat" runat="server" style="font-weight: bold;text-align:right;" class="tdbg2"></td>
                                  <td  id="potPCB" runat="server" style="font-weight: bold;text-align:right;" class="tdbg2"></td>
                              </tr>    
                        </tbody>
                    </table>
                </div>
             </ItemTemplate>
        </asp:Repeater>
</div> 
