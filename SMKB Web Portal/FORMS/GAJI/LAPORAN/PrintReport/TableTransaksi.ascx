<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TableTransaksi.ascx.vb" Inherits="SMKB_Web_Portal.TableTransaksi" %>

<div runat="server" class="vot-list">
         <asp:Repeater runat="server" ID="rptone" OnItemDataBound="rptone_ItemDataBound">
             <ItemTemplate> 
                <%--<div class="print-div">--%>
                    <table id="tableTransaksi" class="table-with-border"> <%--class="table-with-border"--%>
                        <thead>
                            <tr style="border: none;">
                               <td colspan="23">
                                    <div class="header-space">&nbsp;</div>
                                </td>
                            </tr>

                            <tr style="border: 1px solid #000;padding: 8px;text-align: left;">
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 No" rowspan="2">No</td>
                                <td style="text-align: center; width: 15%;border: 1px solid #000;padding: 8px;" class="tdbg1 Nama" rowspan="2">Nama</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 No_KP" rowspan="2">No KP</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 GredGaji" rowspan="2">Gred Gaji</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 Gaji_Pokok" rowspan="2">Gaji Pokok</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 Bonus" rowspan="2">Bonus</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 Elaun" rowspan="2">Elaun</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 OT" rowspan="2">OT</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 Gaji_Kasar" rowspan="2">Gaji Kasar</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 Potongan" rowspan="2">Potongan</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 Cuti" rowspan="2">Cuti</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 No_KWSP" rowspan="2">No KWSP</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 KWSP" colspan="2">KWSP</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 No_Cukai" rowspan="2">No Cukai</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 Kat_Cukai" rowspan="2">Kategori Cukai</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 Cukai" rowspan="2">Cukai</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 No_Perkeso" rowspan="2">No Perkeso</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 SOCP" colspan="2">Perkeso</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 Gaji_Bersih" rowspan="2">Gaji Bersih</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 No_Pencen" rowspan="2">No Pencen</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 Pencen" rowspan="2">Pencen</td>
                                <td style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;" class="tdbg1 ASB" rowspan="2">ASB</td>
                            </tr>
                            <tr style="border: 1px solid #000;padding: 8px;text-align: left;">
                                <td class="tdbg1 KWSP" style="text-align: center;border: 1px solid #000;padding: 8px;">Pekerja</td>
                                <td class="tdbg1 KWSM" style="text-align: center;border: 1px solid #000;padding: 8px;">Majikan</td>
                                <td class="tdbg1 SOCP" style="text-align: center;border: 1px solid #000;padding: 8px;">Pekerja</td>
                                <td class="tdbg1 SOCM" style="text-align: center;border: 1px solid #000;padding: 8px;">Majikan</td>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Repeater ID="repeaterDetail" runat="server" OnItemDataBound="repeaterDetail_ItemDataBound">
                                     <ItemTemplate>
                                        <tr style="border: 1px solid #000;padding: 8px;text-align: left;">
                                         <td class="column-to-hide No" style="text-align: center;width: 5%;border: 1px solid #000;padding: 8px;"><%#Eval("StaffNo")%></td>
                                         <td class="column-to-hide Nama" style="width: 15%;border: 1px solid #000;padding: 8px;"><%#Eval("Nama")%></td>
                                         <td class="column-to-hide No_KP" style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;"><%#Eval("KP")%></td>
                                         <td class="column-to-hide GredGaji" style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;"><%#Eval("GredGaji")%></td>
                                         <td class="column-to-hide Gaji_Pokok" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Gaji_Pokok")) %></td>
                                         <td class="column-to-hide Bonus" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Bonus")) %></td>
                                         <td class="column-to-hide Elaun" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Elaun")) %></td>
                                         <td class="column-to-hide OT" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "OT")) %></td>
                                         <td class="column-to-hide Gaji_Kasar" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Gaji_Kasar")) %></td>
                                         <td class="column-to-hide Potongan" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Potongan")) %></td>
                                         <td class="column-to-hide Cuti" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Cuti")) %></td>
                                         <td class="column-to-hide No_KWSP" style="text-align: center;width: 5%;border: 1px solid #000;padding: 8px;"><%#Eval("No_KWSP")%></td>
                                         <td class="column-to-hide KWSP" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "KWSP")) %></td>
                                         <td class="column-to-hide KWSM" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "KWSM")) %></td>
                                         <td class="column-to-hide No_Cukai" style="text-align: center;width: 5%;border: 1px solid #000;padding: 8px;"><%#Eval("No_Cukai")%></td>
                                         <td class="column-to-hide Kat_Cukai" style="text-align: center;width: 5%;border: 1px solid #000;padding: 8px;"><%#Eval("Kategori_Cukai")%></td>
                                         <td class="column-to-hide Cukai" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Cukai")) %></td>
                                         <td class="column-to-hide No_Perkeso" style="text-align: center;width: 5%;border: 1px solid #000;padding: 8px;"><%#Eval("No_Perkeso")%></td>
                                         <td class="column-to-hide SOCP" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "SOCP")) %></td>
                                         <td class="column-to-hide SOCM" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "SOCM")) %></td>
                                         <td class="column-to-hide Gaji_Bersih" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Gaji_Bersih")) %></td>
                                         <td class="column-to-hide No_Pencen" style="text-align: center; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "No_Pencen"))  %></td>
                                         <td class="column-to-hide Pencen" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "Pencen"))  %></td>
                                         <td class="column-to-hide ASB" style="text-align: right; width: 5%;border: 1px solid #000;padding: 8px;"><%# String.Format("{0:N2}", DataBinder.Eval(Container.DataItem, "ASB"))  %></td>
                                      <tr/>
                                 </ItemTemplate>
                            </asp:Repeater>
                             <tr style="border: 1px solid #000;padding: 8px;text-align: left;">
                                <td colspan="3" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;">Jumlah</td>
                                <td class="column-to-hide GredGaji" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide Gaji_Pokok" id="jumlahGajiPokok" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide Bonus" id="jumlahBonus" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide Elaun" id="jumlahElaun" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide OT" id="jumlahOT" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide Gaji_Kasar" id="jumlahGajiKasar" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide Potongan" id="jumlahPotongan" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide Cuti" id="jumlahCuti" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide No_KWSP" id="Td1" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide KWSP" id="jumlahKWSP" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide KWSM" id="jumlahKWSM" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide No_Cukai" id="Td2" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide Kat_Cukai" id="Td3" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide Cukai" id="jumlahCukai" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide No_Perkeso" id="Td4" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide SOCP" id="jumlahSOCP" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide SOCM" id="jumlahSOCM" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide Gaji_Bersih" id="jumlahGajiBersih" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide Pencen" colspan="2" id="jumlahPencen" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                                <td class="column-to-hide ASB" colspan="2" id="jumlahASB" runat="server" style="text-align:right;font-weight: bold;border: 1px solid #000;padding: 8px;"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
             </ItemTemplate>
        </asp:Repeater>
</div> 

<script type="text/javascript">
    $(document).ready(function () {
        hideAllColumnsByClass("tdbg1");
        hideAllColumnsByClass("column-to-hide");

        var columnClassMap = {
            0: "No",
            1: "Nama",
            2: "No_KP",
            3: "GredGaji",
            4: "Gaji_Pokok",
            5: "Bonus",
            6: "Elaun",
            7: "OT",
            8: "Gaji_Kasar",
            9: "Potongan",
            10: "Cuti",
            11: "No_KWSP",
            12: "KWSP",
            13: "KWSM",
            14: "No_Cukai",
            15: "Kat_Cukai",
            16: "Cukai",
            17: "No_Perkeso",
            18: "SOCP",
            19: "SOCM",
            20: "Gaji_Bersih",
            21: "No_Pencen",
            22: "Pencen",
            23: "ASB"
            // Add more mappings as needed
        };
        // Retrieve the serialized JSON string from the cookie
        var visibleColumnsJson = getCookie("VisibleColumns");

        if (visibleColumnsJson) {
            // Parse the JSON string to a JavaScript array
            var visibleColumns = JSON.parse(visibleColumnsJson);
            visibleColumns.forEach(function (index) {
                var columnClass = columnClassMap[index];
                hideColumnsByClass(columnClass, false);
            });
        }

        function hideColumnsByClass(className, isHidden) {
            var elements = document.querySelectorAll("." + className);
            for (var i = 0; i < elements.length; i++) {
                elements[i].style.display = isHidden ? "none" : "";
            }
        }

        // Function to initially hide all elements with the specified class
        function hideAllColumnsByClass(className) {
            var elements = document.querySelectorAll("." + className);
            for (var i = 0; i < elements.length; i++) {
                elements[i].style.display = "none";
            }
        }

        // Function to get a cookie value by name
        function getCookie(name) {
            var value = "; " + document.cookie;
            var parts = value.split("; " + name + "=");

            if (parts.length === 2) {
                return parts.pop().split(";").shift();
            }
        }

        
    });
   
</script>