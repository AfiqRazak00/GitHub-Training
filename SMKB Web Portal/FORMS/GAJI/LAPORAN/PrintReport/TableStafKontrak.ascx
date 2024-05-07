<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TableStafKontrak.ascx.vb" Inherits="SMKB_Web_Portal.TableStafKontrak" %>
<style>

    .tdbg, .tdbg2{

         border: 1px solid black;
         padding: 6px;
    }
</style>

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
                    <tr>
                    <td colspan="14" style="font-size: 14px;><span class="underline-text"><strong> <%#Eval("MS01_Warganegara")%> - <%#Eval("Warganegara")%> </strong></span></td>
                    </tr>                                     
                        <tr>
                                                                 
                             <th scope="col" class="tdbg" style="width: 5; text-align: center">Bil</th>
                             <th scope="col" class="tdbg" style="width: 10%; text-align: center">No</th>
                             <th scope="col" class="tdbg" style="width: 15%">Nama</th>
                             <th scope="col" class="tdbg" style="width: 10%; text-align: center;">Gred</th>
                             <th scope="col" class="tdbg" style="width: 10%; text-align: center;">Tahun Kelahiran</th>
                             <th scope="col" class="tdbg" style="width: 10%; text-align: center;">Umur</th>
                             <th scope="col" class="tdbg" style="width: 10%; text-align: center;">Warganegara</th>
                             <th scope="col" class="tdbg" style="width: 10%; text-align: center;">Tarikh Mula Kontrak Terkini</th>
                             <th scope="col" class="tdbg" style="width: 10%; text-align: center;">Tarikh Tamat Kontrak Terkini</th>
                             <th scope="col" class="tdbg" style="width: 10%; text-align: center;">Gaji Pokok (RM)</th>
                             <th scope="col" class="tdbg" style="width: 10%; text-align: center;">Caruman KWSP (%)</th>
                             <th scope="col" class="tdbg" style="width: 10%; text-align: center;">Tempoh Kontrak (Bulan)</th>
                         </tr>

                </thead>
                <tbody>
                    <asp:Repeater ID="repeaterDetail" runat="server" OnItemDataBound="repeaterDetail_ItemDataBound">
                                <ItemTemplate>
                                <tr>
                                     <td class="tdbg2" style="text-align:center;"><%# Container.ItemIndex + 1 %></td>
                                    <td class="tdbg2" style="text-align:center;"> <%#Eval("MS01_NoStaf")%></td>
                                    <td class="tdbg2"><%#Eval("MS01_Nama")%></td>
                                    <td class="tdbg2" style="text-align:center;"><%#Eval("Gred")%></td>
                                    <td class="tdbg2" style="text-align:center;"><%#Eval("TahunLahir")%></td>
                                    <td class="tdbg2" style="text-align:center;"><%#Eval("Umur")%></td>
                                    <td class="tdbg2" style="text-align:center;"><%#Eval("Warganegara")%></td>
                                    <td class="tdbg2" style="text-align:center;"><%#Eval("TkhMulaFormatted")%></td>
                                    <%--<td class="tdbg2" style="text-align:center;"><%# Convert.ToDateTime(Eval("MS09_TkhMula")).ToString("dd/MM/yyyy") %></td>--%>
                                    <td class="tdbg2" style="text-align:center;"><%#Eval("MS09_TkhTamat")%></td>
                                    <td class="tdbg2 text-right"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "gaji_pokok")) %></td>
                                    <td class="tdbg2" style="text-align:center;"><%#Eval("kwsp")%></td>
                                    <td class="tdbg2" style="text-align:center;"><%#Eval("TempohBulan")%></td>
                                </tr>

                            </ItemTemplate>
                    </asp:Repeater>
                                                                        <tr>
     <td colspan="8"></td>
     <td colspan="6" class="tdbg2" id="jumlahAmaun" runat="server" style="text-align:right;font-weight: bold"><br /></td>
 </tr>
     
                </tbody>
            </table>
             
        </div>
        </ItemTemplate>
</asp:Repeater>
</div>