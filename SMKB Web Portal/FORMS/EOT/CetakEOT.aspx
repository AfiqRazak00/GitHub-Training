<%@ Page Title="" Language="vb" AutoEventWireup="false"  CodeBehind="CetakEOT.aspx.vb" Inherits="SMKB_Web_Portal.CetakEOT" %>
<!DOCTYPE html>
  <script>
      function fnCetak() {
          window.print();

      }


  </script>
  <style>

 #dotted-line {
 border: none;
 color: rgb(7, 189, 245);
 margin: 1px 60px;
}
td {
font-size:16px;
}
    </style>
<html xmlns="http://www.w3.org/1999/xhtml">

<script type="text/javascript">
    $(document).ready(function () {
        window.print();
    });
</script>
  
 <head runat="server">
    <title>Cetak EOT</title>      
     <script src="https://code.jquery.com/jquery-3.5.1.js" crossorigin="anonymous"></script>
     <style type="text/css">
         P.pagebreakhere {page-break-before: always}
         hr {
          border: none;
          border-top: 1px dotted black;  
        }

          hr1 {
              border: none;
              border-top: 1px dotted black;
            
  
            }
           * {
            font-family: 'Arial', Times, serif;
        }
        /* Custom CSS for GridView styling */
        .table th {
            text-align: center;
            font-weight: bold;
        }

        body {
            /* Set page size to A4 (21cm x 29.7cm) and add margins */
            size: A4 portrait;
            margin: 2cm;
            max-width: 100%;
        }
         .auto-style7 {
             width: 77px;
         }
         .auto-style8 {
             width: 556px;
         }
         .auto-style9 {
             width: 95px;
         }
         .auto-style10 {
             width: 50px;
         }
         .auto-style15 {
             width: 35%;
         }
         .auto-style18 {
             height: 23px;
         }
         .auto-style19 {
             width: 50px;
             height: 23px;
         }
         .auto-style20 {
             width: 77px;
             height: 23px;
         }
         .auto-style21 {
             width: 556px;
             height: 23px;
         }
         .auto-style23 {
             width: 35%;
             height: 23px;
         }
         .auto-style24 {
             width: 1277px;
         }
         .auto-style31 {
             width: 50px;
             height: 22px;
         }
         .auto-style32 {
             height: 22px;
         }
         .auto-style34 {
             height: 38px;
         }
         .auto-style35 {
             width: 344px;
             height: 38px;
         }
         .auto-style37 {
             width: 344px;
             height: 23px;
         }
         .auto-style39 {
             margin-left: 0px;
         }
         .auto-style40 {
             width: 226px;
         }
         .auto-style44 {
             width: 49px;
         }
         .auto-style45 {
             width: 49px;
             height: 25px;
         }
         .auto-style46 {
             height: 25px;
         }
         .auto-style48 {
             width: 266px;
         }
         .auto-style49 {
             width: 247px;
         }
         .auto-style50 {
             width: 79%;
         }
         .auto-style51 {
             height: 25px;
             width: 79%;
         }
         .auto-style52 {
             width: 370px;
         }
         .auto-style53 {
             width: 370px;
             height: 23px;
         }
         .auto-style54 {
             height: 21px;
         }
         .auto-style55 {
             width: 344px;
         }

         @media print {
             body {
                  zoom: 100%;
                 margin: 0;
                 max-width: 100%;
                
             }

             @page {
                 /* Define page size and margins for printing */
                 size: Letter portrait;
                 margin: 1cm; /* Adjust margin to fit Letter size */
             }

             .container {
                 /* Adjust container styles for printing */
                 width: 100%;
                 margin: 0;
                 padding: 0;
             }
         }
         .auto-style56 {
             width: 49px;
             height: 23px;
         }
         .auto-style57 {
             width: 79%;
             height: 23px;
         }
         </style>
</head>
<body>


<form id="form1" runat="server">
      
 <table width="100%" border="0">
  <tr>      
    <td>&nbsp;</td>
            
    <td class="auto-style40">
        <div style="text-align: center;">
        <table width="50%" border="0">        
        
            <tr>
            <td style="height:40px"><img src="../../Images/LogoUTeM2.png" /></td>
            </tr>
                        
        </table>
        </div>
    </td>
           
    <td>
        <table width="100%" border="0" class="auto-style39">
          <tr>
            <td colspan="2" style="text-align: center; font-weight: bold">PERMOHONAN TUNTUTAN KERJA LEBIH MASA</td>
          </tr>
          <tr>
            <td colspan="2" style="text-align: center;font-weight: bold;font-size:18px">UNIVERSITI TEKNIKAL MALAYSIA MELAKA</td>
          </tr>
          <tr>
            <td style="text-align:right" class="auto-style53">Pejabat/Jabatan/Fakulti : </td>
               <td class="auto-style18"><label class="" id="lblPejabat" name="lblPejabat" runat="server"></label></td>
          </tr>
          <tr>
            <td style="text-align: right" class="auto-style52">Bulan :</td>
               <td><label class="" id="lblBulTahun" name="lblBulTahun" runat="server"></label></td>
          </tr>
        </table>
    </td>
   <td>&nbsp;</td>
  </tr>
</table>

<hr /> 
 <div>
    
            <table  class="form-control"  style="width: 100%;">
                <tr>
                    <td class="auto-style10">A.</td>
                    <td colspan="3">Kelulusan permohonan kerja lebih masa (Untuk diisi oleh pemohon dan pegawai penyelia)</td>
                  
                </tr>
                <tr>
                    <td class="auto-style19"></td>
                    <td class="auto-style20">No. Staf</td>
                    <td class="auto-style21" colspan="3"><label class="form-control" id="lblNostaf" name="lblNostaf" runat="server"></label></td>
                  
                </tr>
                <tr>
                    <td class="auto-style19"></td>
                    <td class="auto-style20">Nama</td>
                    <td class="auto-style21" colspan="3"><label class="form-control" id="lblNama" name="lblNama" runat="server"></label></td>
                    
                    
                </tr>
                <tr>
                    <td class="auto-style10">&nbsp;</td>
                    <td class="auto-style7">Jawatan</td>
                    <td class="auto-style8" colspan="3"><label class="form-control" id="lblJawatan" name="lblJawatan" runat="server"></label></td>
                  
                </tr>
                <tr>
                    <td class="auto-style10">&nbsp;</td>
                    <td class="auto-style7">No.Mohon</td>
                    <td class="auto-style8"><label class="" id="lblNoMohon" name="lblNoMohon" runat="server"></label></td>
                    <td class="auto-style9">Tel(Samb)</td>
                    <td><label class="" id="lblNoTel" name="lblNoTel" runat="server"></label></td>
                </tr>
                <tr>
                    <td colspan="5"> 
                            <hr />
                    </td>

                </tr>      
                <tr>
                    <td class="auto-style10">B.</td>
                    <td colspan="3">Pengesahan Kerja (untuk diisi oleh staf dan disokong oleh penyelia) </td>
                  
                </tr>
            </table>
        </div>
<table class="form-control"  style="width: 100%;">
   <tr>
      <td align="left" style="display: inline;font-weight:bold;font-size:18px" colspan="2" class="auto-style54">Peringatan :</td>
      
    </tr>
    <tr>
        <td align="center" style="display: inline;font-weight:bold;font-size:18px" class="auto-style15" colspan="3"><div align="left" class="style8">* Jam / Masa : 0600 - 2200 (kadar siang) 2200 - 0600 (kadar malam) </div></td>
    </tr>
    <tr>
        <td align="left" valign="top" class="auto-style49"><i>Kadar tuntutan kerja lebih masa :</i></td>
        <td align="left" class="auto-style48">
            <table  class="form-control"  style="width: 100%;border-right:solid 1px;border-left:solid 1px;border-bottom:solid 1px;border-top:solid 1px;border-color:#000000;">
                <tr style="background-color:darkgray"  >
                    <td style="width:20%;border-right:solid 1px;border-bottom:solid 1px;">Status</td>
                    <td style="border-right:solid 1px;border-bottom:solid 1px;" class="auto-style50">Hari tuntutan</td>
                    <td style="width:20%;border-bottom:solid 1px;">Kadar</td>
                </tr>
                <tr>
                    <td class="auto-style45" style="border-right:solid 1px;border-bottom:solid 1px;">1</td>
                    <td class="auto-style51" style="border-right:solid 1px;border-bottom:solid 1px;">Biasa Siang</td>
                    <td class="auto-style46" style="border-bottom:solid 1px;">1.125</td>
                </tr>
                <tr>
                    <td class="auto-style44" style="border-right:solid 1px;border-bottom:solid 1px;">2</td>
                    <td class="auto-style50" style="border-right:solid 1px;border-bottom:solid 1px;">Biasa Malam</td>
                    <td style="border-bottom:solid 1px;">1.250</td>
                </tr>
                <tr>
                    <td class="auto-style44" style="border-right:solid 1px;border-bottom:solid 1px;">3</td>
                    <td class="auto-style50" style="border-right:solid 1px;border-bottom:solid 1px;">Hujung Minggu Siang</td>
                    <td style="border-bottom:solid 1px;">1.250</td>
                </tr>
                <tr>
                    <td class="auto-style44" style="border-right:solid 1px;border-bottom:solid 1px;">4</td>
                    <td class="auto-style50" style="border-right:solid 1px;border-bottom:solid 1px;">Hujung Minggu Malam</td>
                    <td style="border-bottom:solid 1px;">1.500</td>
                </tr>
                <tr>
                    <td class="auto-style56" style="border-right:solid 1px;border-bottom:solid 1px;">5</td>
                    <td class="auto-style57" style="border-right:solid 1px;border-bottom:solid 1px;">Cuti Umum Siang</td>
                    <td style="border-bottom:solid 1px;" class="auto-style18">1.750</td>
                </tr>
                 <tr>
                    <td class="auto-style44" style="border-right:solid 1px;">6</td>
                    <td class="auto-style50" style="border-right:solid 1px;">Cuti Umum Malam</td>
                    <td>2.000</td>
                </tr>

            </table>

        </td>
     <td style="width:20%">&nbsp</td>

    </tr> 
</table>


<table>
    <tr>
        <td align="left" style="display: inline" class="auto-style23"><i>(Tertakluk kepada maksimum 104 jam/sebulan atau 1/3 daripada gaji pokok)</i></td>
    </tr>

</table>
<br />
    <div>
        <asp:GridView ID="EOTransaksi" runat="server" Width="100%" AutoGenerateColumns="False" HeaderStyle-BackColor="#cccccc" >
            <Columns>
                <asp:BoundField HeaderText="Bil" DataField="Bil" SortExpression="Bil" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Center" />
                <asp:BoundField HeaderText="Tarikh Tuntut" DataField="Tkh_Tuntut" SortExpression="Tkh_Tuntut" HeaderStyle-CssClass="centerAlign" ItemStyle-Width="40%" ItemStyle-HorizontalAlign="Justify" DataFormatString="{0:dd/MM/yyyy}"/>
                <asp:BoundField HeaderText="Jam Mula" DataField="Jam_Mula" SortExpression="Jam_Mula" HeaderStyle-CssClass="centerAlign" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField HeaderText="Jam Tamat" DataField="Jam_Tamat" SortExpression="Jam_Tamat" HeaderStyle-CssClass="centerAlign" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField HeaderText="jam Tuntut" DataField="Jum_Jam_Tuntut" SortExpression="Jum_Jam_Tuntut" HeaderStyle-CssClass="centerAlign" ItemStyle-Width="10%"  ItemStyle-HorizontalAlign="Center"/>
                <asp:BoundField HeaderText="Status Hari" DataField="StatusHari" SortExpression="StatusHari" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Center" />
              
            </Columns>
            
        </asp:GridView>
        <br />
     </div>
<div>
<table>
    <tr>
        <td align="center" style="display: inline;font-weight:bold" class="auto-style23"><div align="center" class="auto-style24">Butir-Butir Borang Tuntutan</div></td>
    </tr>

</table>

</div>
    <br />
    <div>
         <asp:GridView ID="EOTButir" runat="server" Width="100%" AutoGenerateColumns="False"  HeaderStyle-BackColor="#cccccc" >
                <Columns>
                    <asp:BoundField HeaderText="Bil" DataField="Bil" SortExpression="Bil" ItemStyle-Width="5%" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField HeaderText="Tarikh Tuntut" DataField="Tkh_Tuntut" SortExpression="Tkh_Tuntut" HeaderStyle-CssClass="centerAlign" ItemStyle-Width="10%" ItemStyle-HorizontalAlign="Justify" DataFormatString="{0:dd/MM/yyyy}"/>
                    <asp:BoundField HeaderText="Tujuan" DataField="Tujuan" SortExpression="Tujuan" HeaderStyle-CssClass="centerAlign" ItemStyle-Width="40%" ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField HeaderText="Catatan" DataField="Catatan" SortExpression="Catatan" HeaderStyle-CssClass="centerAlign" ItemStyle-Width="30%" ItemStyle-HorizontalAlign="Center"/>
               
                </Columns>
            
            </asp:GridView>
      
    </div>
<br />
 <P CLASS="pagebreakhere"></P>

 <table  class="form-control"  style="width: 100%;">
                <tr>
                    <td class="auto-style19">C.</td>
                    <td colspan="4" class="auto-style18">Adalah saya dengan ini telah menjalankan kerja lebih masa sebanyak
                         <label class="" id="lblJumJam2" name="lblJumJam2" runat="server"></label>
                        (jumlah jam kerja) sebagaimana yang telah diarahkan kepada saya.</td>
                  
                </tr>
                <tr>
                    <td colspan="5">&nbsp</td>
                                           
                </tr>
                <tr>
                    <td>&nbsp</td>
                    <td colspan="4">Tandatangan Staf</td>                                    
                </tr>
                <tr>
                    <td colspan="5">&nbsp</td>
                                           
                </tr>
              <tr>
                    <td>&nbsp</td>
                    <td>  <hr /> </td> 
                    <td colspan="3">&nbsp</td>    
                </tr>
                 <tr>
                    <td>&nbsp</td>
                    <td colspan="4">Tarikh :</td> 
                   
                </tr>
                <tr>
                    <td colspan="5">&nbsp</td>
                                           
                </tr>
                <tr>
                    <td class="auto-style10">D.</td>
                    <td colspan="4">Pengesahan Penyelia</td>
                  
                </tr>
                 <tr>
                    <td class="auto-style10"></td>
                    <td colspan="4">Saya sebagai penyelia kepada staf ini bersetuju dan menyokong tuntutan staf ini sebanyak 
                       <label class="" id="lblJumJam1" name="lblJumJam1" runat="server"></label>
                        (jumlah jam disokong)</td>
                  
                </tr>
                 <tr>
                    <td colspan="5">&nbsp</td>
                                           
                </tr>
                <tr>
                    <td>&nbsp</td>
                    <td colspan="4">Tandatangan Staf</td>                                    
                </tr>
                <tr>
                    <td colspan="5">&nbsp</td>
                                           
                </tr>
              <tr>
                    <td>&nbsp</td>
                    <td>  <hr /> </td> 
                    <td colspan="3">&nbsp</td>    
                </tr>
                 <tr>
                    <td>&nbsp</td>
                    <td colspan="4">Tarikh :</td> 
                   
                </tr>
                <tr>
                    <td colspan="5">&nbsp</td>
                                           
                </tr>
   </table>

     <table  class="form-control"  style="width: 100%;">
                <tr>
                    <td class="auto-style19">E.</td>
                    <td colspan="4" class="auto-style18">Sokongan Bayaran oleh Ketua Jabatan / Dekan</td>
                  
                </tr>
                <tr>
                    <td class="auto-style31"></td>
                    <td colspan="4" class="auto-style32">(Untuk diisi oleh pegawai yang bertanggungjawab menjaga peruntukan)</td>
                                           
                </tr>
                <tr>
                     <td class="auto-style19"></td>
                    <td colspan="4" class="auto-style18">Pembayaran kerja lebih masa diatas adalah disahkan dan disokong.</td>
                                           
                </tr>
                
                <tr>
                    <td colspan="5" class="auto-style18"></td>
                                           
                </tr>
                 <tr>
                    <td class="auto-style34"></td>
                    <td class="auto-style35"><img src="../../images/box.gif" width="30" height="30" />&nbsp;&nbsp;Sepenuhnya   </td>  
                    <td colspan="2" class="auto-style34"></td>
                </tr>
               <tr>
                    <td>&nbsp</td>
                    <td class="auto-style55"><img src="../../images/box.gif" width="30" height="30" />&nbsp;&nbsp;Dihadkan kepada  .......... jam .......... minit </td>
                    <td  colspan="2">&nbsp;</td>                    
                </tr>
               <tr>
                    <td colspan="5"></td>                    
                </tr>
                 <tr>
                    <td class="auto-style18"></td>
                    <td class="auto-style37">Tandatangan :</td>
                    <td colspan="3" class="auto-style18"> Jawatan : .............................   Tarikh : ...........................</td> 
                  
                </tr>
                <tr>
                    <td class="auto-style18"></td>
                    <td colspan="2" class="auto-style18">.....................................</td>
                    <td style="text-align:left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp(Cop)</td>    
                    <td class="auto-style18"></td>
                </tr>
</table>
 <table  class="form-control"  style="width: 100%;">
                <tr>
                    <td class="auto-style19">F.</td>
                    <tD colspan="4" class="auto-style18">Penerimaan Pejabat Bendahari</tD>
                  
                </tr>               
                <tr>
                    <td>&nbsp</td>
                    <td colspan="4">Tandatangan (Pegawai yang menjaga peruntukan)</td>                                    
                </tr>
                <tr>
                     <td>&nbsp</td>
                    <td colspan="4">Pejabat Bendahari telah menerima tuntutan elaun lebih masa Tuan/Puan sebanyak 
                        <label class="" id="lblJumJam" name="lblJumJam" runat="server"></label>
                        (jumlah jam tuntut)</td>
                                           
                </tr>
                <tr>
                    <td colspan="5">&nbsp</td>
                                           
                </tr>
              <tr>
                    <td>&nbsp</td>
                    <td>  <hr /> </td> 
                    <td colspan="3">&nbsp</td>    
                </tr>
                 <tr>
                    <td>&nbsp</td>
                    <td colspan="4">Tarikh :</td> 
                   
                </tr>
                
   </table>
  

</form>

</body>
    <script type="text/javascript">
        $(document).ready(function () {
          
            window.print();
        });
    </script>
</html>

