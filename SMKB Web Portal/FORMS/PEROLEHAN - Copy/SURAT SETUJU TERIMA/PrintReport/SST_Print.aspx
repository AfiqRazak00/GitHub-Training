<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SST_Print.aspx.vb" Inherits="SMKB_Web_Portal.SST_Print" %>
<!DOCTYPE html>
<html>
  <head>
    <title>SURAT SETUJU TERIMA (SST)</title>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
      <style>

        @page {
          size: A4; /* or letter, legal, etc. */
          margin: 1cm; /* adjust margins as needed */
        }
         /* Define styles for the table header */
         .header-table {
         width: 100%;
         border-collapse: collapse;
         margin-bottom: 10px;
         margin-top: -10px;
         /*position: fixed;*/ 
         top: 0; 
         z-index: 1000; 
         }

         .header-table th {
         /*background-color: #f2f2f2;*/
         border: 1px solid #dddddd;
         padding: 8px;
         text-align: left;
         }

         footer {
         position: fixed;
         text-align: justify;
         bottom: -15px;
         margin: 0 20px 0 20px;
         }
          .custom-class {
         text-align: justify;
         line-height: 1.5;
         }

         /* styles.css */
         .custom-space {
         text-align: justify;
         }

         /* styles.css */
         .custom-padding {
         text-align: justify;
         padding-left:20px;
         }

         /* styles.css */
         .custom-center{
         text-align: center;
         line-height: 0;
         }

         .signature-table td {
         padding-right: 30px;
         padding-bottom: 10px;
         }

         ol {
          list-style-type: none;
          counter-reset: item;
          padding-left: 60px;
         }

        ol li {
          counter-increment: item;
        }

        ol li:before {
          content: counter(item) ". ";
          margin-right: 5px;
        }

        ol ol {
          list-style-type: none;
          counter-reset: subitem;
        }

        ol ol li {
          counter-increment: subitem;
        }

        ol ol li:before {
          content: counter(item) "." counter(subitem) " ";
          margin-right: 5px;
        }

        ol[type="a"],
        ol[type="i"] {
          list-style-type: none;
          counter-reset: list-counter;
        }

        ol[type="a"] li::before {
          content: counter(list-counter, lower-alpha) ")";
          counter-increment: list-counter;
          margin-right: 5px;
        }

        ol[type="i"] li::before {
          content: counter(list-counter, lower-roman) ")";
          counter-increment: list-counter;
          margin-right: 5px;
        }

        .padded-text {
            padding-left: 61px; /* Adjust the padding value as needed */
        }
      </style>
  </head>
  <body>
 <form id="form1" runat="server">
    <div class="container">
         <!------------------------------------ PAGE 1 START------------------------------------>
         <div id="sst">
               <div class="MsoNormal" align="center" style="margin-top:10px; margin-bottom:10px"> 
                  <img src="../../../../Images/Letterhead.png" style="width:850px;" />
               </div>
               <h5 class="custom-center">PEJABAT BENDAHARI</h5>
               <div style="text-align: center; margin-bottom:10px">
                  Tel : +606 270 1018  |  Faks : +606 270 1035<br />Emel : pejabatbendahari@utem.edu.my
               </div>
               <div style="text-align: right; font-size: 13px; margin-bottom:90px">
                  <!-- Right-aligned content -->
                  <table align="right">
                     <tr>
                        <td style="text-align: left;">Rujukan Kami (Our Ref) : UTeM(S).03.02.02/400-23/2 Jilid 39 ( )</td>
                     </tr>
                     <tr>
                        <td style="text-align: left;">Rujukan Tuan (Your Ref) :</td>
                     </tr>
                     <tr>
                        <td style="text-align: left;">Tarikh (Date) : Jamadilawal 1445H/ November 2023</td>
                     </tr>
                  </table>
               </div>
               <h5 align='center'>SURAT SETUJU TERIMA</h5>
               <p class="custom-class" align='left'>
                  <span class="txtNamaSyarikat"></span>
                  <br />
                  <span class="txtAlamatSemasa1"></span>
                  <br />
                  <span class="txtAlamatSemasa2"></span>
                  <br />
                  <span class="txtPoskodSemasa"></span> <span id="txtBandarSemasa"></span> <span id="txtNegeriSemasa"></span><br />
                   Email : <span class="txtEmelSyarikat"></span>
               </p>
              
               <p class="custom-class" align='left'>
                  Tuan,
               </p>

               <table class="custom-class" style="margin-bottom:10px">
                  <tr valign="top">
                     <td>
                        <strong> 
                        <p><span class="txtTujuan text-uppercase" style="margin: 0;"></span><br />
                        NO. SEBUT HARGA : <span class="noSebutHarga text-uppercase" style="margin: 0;"></span></p>
                        </strong>
                     </td>
                  </tr>
               </table>
             
               <p class="custom-class">
                  Dengan ini dimaklumkan bahawa UTeM telah bersetuju menerima tawaran sebut harga syarikat tuan dengan harga <b class="totalHarga"></b> (<span class="totalHargaWords"></span>) yang merupakan harga kontrak bagi tempoh bekal selama <b> <span class="txtTempoh"></span> <span class="txtTempohBekal text-uppercase"></span> dari surat setuju terima ditandatangani oleh pembekal</b> tertakluk kepada dokumen sebut harga yang menjadi sebahagian daripada perolehan ini dan Surat Setuju Terima ini berserta Lampiran A kepada Surat Setuju Terima iaitu maklumat terperinci kontrak (selepas ini disebut sebagai “Surat ini”).
               </p>
          
               <p class="custom-class">
                  2.&nbsp;&nbsp;&nbsp;Dengan pengakuan penerimaan Surat ini, suatu kontrak yang mengikat terbentuk antara Universiti dengan syarikat tuan. Satu dokumen kontrak hendaklah ditandatangani dengan kadar segera dengan memasukkan semua terma sebagaimana dokumen sebut harga serta semua terma dalam Lampiran A. Sehingga dokumen kontrak tersebut ditandatangani, Surat ini hendaklah terus mengikat kedua-dua pihak. 
               </p>
      
               <p class="custom-class">
                  3.&nbsp;&nbsp;&nbsp;Harga kontrak ini adalah termasuk peruntukan Universiti sebanyak 6% cukai perkhidmatan memandangkan ini dikenakan cukai dan syarikat tuan berdaftar dengan Jabatan Kastam Diraja Malaysia (JKDM). Pembayaran cukai jualan ini adalah dikira berdasarkan tuntutan sebenar dan tarikh kuat kuasa pendaftaran syarikat tuan dengan JKDM.
               </p>
             
               <p class="custom-class">
                  4.&nbsp;&nbsp;&nbsp;Adalah dimaklumkan bahawa tiada pembekalan barang boleh dibuat melainkan jika syarikat tuan telah mengemukakan kepada Universiti dokumen-dokumen berikut :
               </p>
               <ol type="a" class="custom-class">
                  <li>
                     suatu bon pelaksanaan yang tidak boleh dibatalkan yang berjumlah <b><span class="totalHargaWords"></span> (<span class="totalHarga"></span>)</b>;
                  </li>
               </ol>
          
            <p class="custom-class">
               seperti yang ditetapkan dalam Lampiran A tidak melebihi 14 hari dari tarikh pengakuan penerimaan Surat ini oleh syarikat tuan. Apa-apa kegagalan dalam mematuhi kehendak di perenggan ini dalam tempoh masa yang ditetapkan, boleh mengakibatkan Surat ini terbatal dan Kerajaan tidaklah dengan apa-apa cara jua bertanggungan terhadap syarikat tuan melainkan jika penepian bertulis diberikan oleh orang yang diberi kuasa, bagi perkhidmatan yang perlu dibuat dengan segera atau serta-merta apabila kelewatan itu akan memudarat dan menjejaskan perkhidmatan dan kepentingan awam.
            </p>

              <p class="custom-class">
               5.&nbsp;&nbsp;&nbsp;Setelah arahan dikeluarkan oleh Universiti, syarikat tuan dikehendaki melaksanakan pembekalan barang dalam tempoh yang ditetapkan dan kualiti bekalan tersebut hendaklah memuaskan hati serta memenuhi kehendak Universiti. Sekiranya syarikat tuan gagal melaksanakan pembekalan barang dalam tempoh dan kualiti yang ditetapkan, Universiti berhak membatalkan arahan yang dikeluarkan atau mengenakan *Denda/ Tolakan/ <i>Liquidated & Ascertained Damages</i> (LAD) seperti yang ditetapkan dalam <b>Lampiran A</b>.
            </p>
          
           
               <p style="page-break-before: always;"></p>
            <!------------------------------------ PAGE 1 END------------------------------------>
            <!------------------------------------ PAGE 2 START------------------------------------>
            <!---- UTEM Header ---->
            <header>
               <table class="header-table" >
                  <thead>
                     <tr>
                        <th style="width: 30%; background-color: #F5F5F5; border: 1px solid #dddddd; padding: 8px; text-align: left;">No. Sebut Harga :</th>
                        <th class="noSebutHarga text-uppercase"></th>
                     </tr>
                  </thead>
               </table>
            </header>
            <!---- UTEM Header ---->
            <p class="custom-class">
               6.&nbsp;&nbsp;&nbsp;Syarikat tuan juga adalah diingatkan bahawa Universiti berhak untuk membatalkan Surat ini sekiranya :
            </p>
            <ol type="a" class="custom-class">
               <li>
                  syarikat tuan gagal mematuhi mana-mana terma di perenggan 4 dalam tempoh masa yang ditetapkan;
               </li>
               <li>
                  syarikat tuan gagal mematuhi mana-mana terma yang dinyatakan dalam Surat Akuan Pembida Berjaya;
               </li>
               <li>
                  syarikat tuan telah membuat salah nyataan (<i>misrepresentation</i>) atau mengemukakan maklumat palsu semasa berurusan dengan Universiti bagi perolehan ini atau melakukan apa- apa perbuatan lain, seperti memalsukan maklumat dalam Sijil Akuan Pendaftaran Syarikat, mengemukakan bon pelaksanaan atau dokumen lain yang palsu atau yang telah diubah suai;
               </li>
               <li>
                  syarikat tuan membenarkan Sijil Akuan Pendaftaran Syarikat disalahgunakan oleh individu/syarikat lain;
               </li>
               <li>
                  syarikat tuan terlibat dalam membuat pakatan harga dengan syarikat-syarikat lain atau apa- apa pakatan sepanjang proses sebut harga sehingga Surat ini ditandatangani;
               </li>
               <li>
                  syarikat tuan telah memberikan subkontrak sama ada sepenuhnya atau sebahagiannya pembekalan barang tanpa kelulusan Universiti terlebih dahulu;
               </li>
               <li>
                  syarikat gagal menyempurnakan perkhidmatan/membekalkan barang dalam tempoh yang ditetapkan seperti di <b>Lampiran A</b>;
               </li>
               <li>
                  syarikat tuan gagal mematuhi mana-mana terma/arahan di dalam dokumen sebut harga.
               </li>
               <li>
                  syarikat tuan/ pemilik/ rakan kongsi/ pengarah telah disabitkan atas kesalahan jenayah di dalam atau luar Malaysia;
               </li>
               <li>
                  syarikat tuan digulungkan;
               </li>
               <li>
                  syarikat tuan membekal barang-barang yang tidak tulen, bukan baharu atau yang terpakai;
               </li>
               <li>
                  syarikat gagal mematuhi spesifikasi pembekalan barang yang ditetapkan; 
               </li>
               <li>
                  syarikat tuan tidak mendapat kelulusan daripada Universiti terlebih dahulu bagi apa-apa penjualan atau pemindahan ekuiti sepanjang tempoh kontrak ini berkuat kuasa; atau
               </li>
               <li>
                  terdapat perkara yang melibatkan kepentingan awam atau keselamatan dan kepentingan negara. 
               </li>
            </ol>
         
            <p class="custom-class">
               7.&nbsp;&nbsp;&nbsp;Sekiranya Surat ini dibatalkan atas alasan seperti yang ditetapkan di perenggan 5, Universiti tidak akan bertanggungan terhadap apa-apa kerugian syarikat tuan termasuk kerugian masa hadapan.
            </p>
           
            <p class="custom-class">
               8.&nbsp;&nbsp;&nbsp;Bersama-sama Surat ini disertakan Surat Akuan Pembida Berjaya dan Surat Akuan Sumpah Syarikat seperti di Lampiran B dan Lampiran C untuk ditandatangani oleh syarikat tuan dan dikembalikan bersama-sama dengan Surat ini.
            </p>
             <p class="custom-class">
               9.&nbsp;&nbsp;&nbsp;Surat ini dihantar kepada syarikat tuan dalam tiga (3) salinan. Sila kembalikan ke Pejabat ini salinan asal dan kedua beserta lampiran yang berkaitan yang telah ditandatangani dengan sempurna oleh syarikat tuan dan saksi syarikat tuan tidak melebihi 14 hari dari tarikh Surat ini diterima untuk tindakan kami selanjutnya. Apa-apa kegagalan dalam mematuhi kehendak di perenggan ini dalam tempoh masa yang ditetapkan boleh mengakibatkan Surat ini terbatal dan Universiti tidaklah dengan apa-apa jua bertanggungan terhadap syarikat tuan.
            </p>

            <p class="custom-space">
               Sekian, terima kasih.
            </p>
            <p class="custom-space"><strong>“MALAYSIA MADANI”</strong><br />
            <strong>“BERKHIDMAT UNTUK NEGARA”</strong><br />
            <strong>“KOMPETENSI TERAS KEGEMILANGAN”</strong></p>
 
            <p class="custom-space">Saya yang menjalankan amanah,</p>
            <br />
            <p class="custom-space">
               ..........................................................
               <br />
               <strong>SABARINA BINTI ABDULLAH</strong>
               <br />
               Bendahari<br />
               Pejabat Bendahari
               b.p. Naib Canselor<br />
               Universiti Teknikal Malaysia Melaka<br />
               <i class="fa-solid fa-phone"></i>06-270 1018<br />
               <small class="form-text text-muted">AFIQ/SST/2023</small>
            </p>
            <p style="page-break-before: always;"></p>
            <!------------------------------------ PAGE 2 END------------------------------------>
            <!------------------------------------ PAGE 4 START------------------------------------>
               <!---- UTEM Header ---->
            <header>
               <table class="header-table" >
                  <thead>
                     <tr>
                        <th style="width: 30%; background-color: #F5F5F5; border: 1px solid #dddddd; padding: 8px; text-align: left;">No. Sebut Harga :</th>
                          <th class="noSebutHarga text-uppercase"></th>
                     </tr>
                  </thead>
               </table>
            </header>
            <!---- UTEM Header ---->
            <p class="custom-class"><strong>PENGAKUAN PENERIMAAN SURAT SETUJU TERIMA DAN LAMPIRAN YANG BERKAITAN OLEH SYARIKAT</strong></p>
            <p class="custom-class">Dengan ini disahkan bahawa yang bertandatangan di bawah ini mengakui penerimaan Surat ini dan lampiran yang berkaitan yang rujukannya ialah UTeM(S).03.02.02/400-23/2 Jilid 39 (           ) bertarikh ........................ November 2023 dan bersetuju dengan terma dan syarat yang terkandung dalam Surat ini tanpa syarat yang mana salinan kepada Surat ini telah pun disimpan, dan selanjutnya disahkan bahawa tiada apa-apa terma, syarat atau stipulasi tambahan kepada yang terkandung dalam dokumen sebut harga dan Surat ini telah dikenakan.</p>
            <br /> <br />
            <table width="100%" align="center" class="custom-class">
               <tr>
                  <th style="text-align:center">..................................................................</th>
                  <th>&nbsp;</th>
                  <th style="text-align:center">..................................................................</th>
               </tr>
               <tr>
                  <td align="center">Tandatangan Pemilik Syarikat</td>
                  <td>&nbsp;</td>
                  <td align="center">Meterai atau Cop Syarikat</td>
               </tr>
            </table>
            <br /> <br />
            <table width="59%" cellspacing="2" class="custom-class">
               <tr style="text-align:justify;">
                  <td>Nama Pemilik</td>
                  <td>:</td>
                  <td colspan="2">_____________________________________</td>
               </tr>
               <tr style="text-align:justify;">
                  <td>No. Kad Pengenalan</td>
                  <td>:</td>
                  <td colspan="2">_____________________________________</td>
               </tr>
               <tr style="text-align:justify;">
                  <td rowspan="2">Alamat</td>
                  <td rowspan="2">:</td>
                  <td colspan="2">_____________________________________</td>
               </tr>
               <tr style="text-align:justify;">
                  <td colspan="2">_____________________________________</td>
               </tr>
               <tr style="text-align:justify;">
                  <td>Tarikh</td>
                  <td>:</td>
                  <td colspan="2">_____________________________________</td>
               </tr>
            </table>
            <br /> <br />
            <table width="55%" align="left" class="custom-class">
               <tr>
                  <th style="text-align:center">..................................................................</th>
                  <th>&nbsp;</th>
                  <th align="center">&nbsp;</th>
               </tr>
               <tr>
                  <td align="center">Tandatangan Saksi Syarikat</td>
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
               </tr>
            </table>
            <br /> <br />
            <table width="59%" cellspacing="2" class="custom-class">
               <tr style="text-align:justify;">
                  <td>Nama Saksi</td>
                  <td>:</td>
                  <td colspan="2">_____________________________________</td>
               </tr>
               <tr style="text-align:justify;">
                  <td>No. Kad Pengenalan</td>
                  <td>:</td>
                  <td colspan="2">_____________________________________</td>
               </tr>
               <tr style="text-align:justify;">
                  <td rowspan="2">Alamat</td>
                  <td rowspan="2">:</td>
                  <td colspan="2">_____________________________________</td>
               </tr>
               <tr style="text-align:justify;">
                  <td colspan="2">_____________________________________</td>
               </tr>
               <tr style="text-align:justify;">
                  <td>Tarikh</td>
                  <td>:</td>
                  <td colspan="2">_____________________________________</td>
               </tr>
            </table>
            <footer>
               <table width="130%" style="text-align:center; margin: 0px 0px 0px 0px;">
                  <thead>
                     <tr>
                        <th> .............................. </th>
                        <th> .............................. </th>
                        <th> .............................. </th>
                        <th> .............................. </th>
                     </tr>
                  </thead>
                  <tbody>
                     <tr>
                        <td> Tandatangan UTeM </td>
                        <td> Cop UTeM </td>
                        <td> Tandatangan Syarikat </td>
                        <td> Cop Syarikat </td>
                     </tr>
                  </tbody>
               </table>
               <p><small>: Pegawai yang diberi kuasa oleh Lembaga Pengarah Universiti melalui Mesyuarat LPU Bil.4/2018 untuk menandatangani kontrak.<br />: Penama pada sijil pendaftaran untuk menandatangani Surat ini.</small></p>
            </footer>
            <p style="page-break-before: always;">&nbsp;</p>
            <!------------------------------------ PAGE 4 END------------------------------------>
            <!------------------------------------ PAGE 5 START------------------------------------>
               <!---- UTEM Header ---->
            <header>
               <table class="header-table" >
                  <thead>
                     <tr>
                        <th style="width: 30%; background-color: #F5F5F5; border: 1px solid #dddddd; padding: 8px; text-align: left;">No. Sebut Harga :</th>
                         <th class="noSebutHarga text-uppercase"></th>
                     </tr>
                  </thead>
               </table>
            </header>
            <!---- UTEM Header ---->
            <p style="text-align:right; font-weight:bold"><i>Lampiran A</i></p>
            <p style="text-align:center; font-weight:bold"><u>BUTIRAN KONTRAK</u></p>
            <p style="text-align:center; font-weight:bold"><span class="txtTujuan text-uppercase" style="margin: 0;"></span></p>
            <p class="custom-class">1.<b><u>Pendaftaran Syarikat Dengan Suruhanjaya Syarikat Malaysia (SSM) Atau Pendaftaran Koperasi Dengan Suruhanjaya Koperasi Malaysia (SKM) (jika berkaitan)</u></b></p>
            <table width="66%" cellspacing="2" cellpadding="10">
               <tr style="text-align:justify;">
                  <td>1.1. No. Pendaftaran</td>
                  <td>:</td>
                  <td><span class="txtNoSSM text-uppercase"></span></td>
               </tr>
               <tr style="text-align:justify;">
                  <td>1.2. Tempoh Sah Laku</td>
                  <td>:</td>
                  <td><span class="contractStatus text-uppercase"></span></td>
               </tr>
            </table>
            <p class="custom-class">2. <b><u>Pendaftaran dengan Kementerian Kewangan (jika berdaftar)</u></b></p>
            <table width="63%" cellspacing="2" cellpadding="10">
               <tr style="text-align:justify;">
                  <td >2.1. No. Pendaftaran</td>
                  <td>:</td>
                  <td class="txtNoMOF text-uppercase"></td>
               </tr>
               <tr style="text-align:justify;">
                  <td>2.2. Tempoh Sah Laku</td>
                  <td>:</td>
                  <td class="dateRange"></td>
               </tr>
               <tr style="text-align:justify;">
                  <td>2.3. Kod Bidang</td>
                  <td>:</td>
                  <td id="displayKodBidang1"></td>
               </tr>
               <tr style="text-align:justify;">
                  <td>2.4. Taraf Syarikat</td>
                  <td>:</td>
                  <td><span class="txtStatusBumi"></span></td>
               </tr>
               <tr style="text-align:justify;">
                  <td>2.5. Tempoh Sah Laku Taraf Bumiputera</td>
                  <td>:</td>
                  <td><span class="txtTempohSahBumi"></span></td>
               </tr>
            </table>
            <p class="custom-class">3. <b><u>Harga dan Tempoh Kontrak</u></b></p>
            <table width="100%" cellspacing="2" cellpadding="10">
               <tr style="text-align:justify;">
                  <td >3.1. Harga Sebut Harga (butiran harga <br />seperti di <i>Lampiran A1</i>)</td>
                  <td>:</td>
                  <td class="totalHarga text-uppercase"></td>
               </tr>
               <tr style="text-align:justify;">
                  <td>3.2. Fi Perkhidmatan ePerolehan <br /> (sekiranya berkaitan)</td>
                  <td>:</td>
                  <td>Tiada</td>
               </tr>
               <tr style="text-align:justify;">
                  <td>3.3. Harga Kontrak</td>
                  <td>:</td>
                  <td class="totalHarga text-uppercase"></td>
               </tr>
               <tr style="text-align:justify;">
                  <td>3.4. Tempoh Bekal</td>
                  <td>:</td>
                  <td><span class="txtTempoh text-uppercase"></span> <span class="txtTempohBekal text-uppercase"></span> dari surat setuju terima ditandatangani oleh pembekal</td>
               </tr>
               <tr style="text-align:justify;">
                  <td>3.5. Tempoh Kontrak</td>
                  <td>:</td>
                  <td class="Tempoh_Kontrak"></td>
               </tr>
               <tr style="text-align:justify;">
                  <td>3.6. Tarikh Mula Kontrak</td>
                  <td>:</td>
                  <td>Bermula dari surat setuju terima ditandatangani oleh pembekal</td>
               </tr>
               <tr style="text-align:justify;">
                  <td>3.7. Tarikh Tamat Kontrak</td>
                  <td>:</td>
                  <td><label class="Tempoh_Kontrak"></label> surat setuju terima ditandatangani oleh pembekal</td>
               </tr>
            </table>
            <p class="custom-class">4. <b><u>Tempoh dan Jadual Pembekalan Barang</u></b></p>
            <p class="custom-padding">*Senarai item, kuantiti, jenis perkhidmatan dan/atau tempoh serta jadual penyempurnaan perkhidmatan yang ditetapkan seperti di <i>Lampiran A2</i></p>
            <p class="custom-class">5. <b><u>Skop Pembekalan (sekiranya berkaitan)</u></b></p>
            <p class="custom-padding">*Skop pembekalan yang ditetapkan seperti di <i>Lampiran A3</i></p>
            <p style="page-break-before: always;">&nbsp;</p>
            <!------------------------------------ PAGE 5 END------------------------------------>
            <!------------------------------------ PAGE 6 START------------------------------------>
              <!---- UTEM Header ---->
            <header>
               <table class="header-table" >
                  <thead>
                     <tr>
                        <th style="width: 30%; background-color: #F5F5F5; border: 1px solid #dddddd; padding: 8px; text-align: left;">No. Sebut Harga :</th>
                        <th class="noSebutHarga text-uppercase"></th>
                     </tr>
                  </thead>
               </table>
            </header>
            <!---- UTEM Header ---->
            <p class="custom-class">6.<b><u>*Bon Pelaksanaan</u></b></p>
            <table width="100%"cellspacing="2" cellpadding="10">
               <tr style="text-align:justify;">
                  <td >6.1. Kadar Bon Pelaksanaan</td>
                  <td>:</td>
                  <td width="100%"><span class="bonSST"></span></td>
               </tr>
               <tr style="text-align:justify;">
                  <td width="37%">6.2. Formula Bon Pelaksanaan</td>
                  <td>:</td>
                  <td><span class="totalHarga text-uppercase"></span> x <span class="bonSST"></span></td>
               </tr>
               <tr style="text-align:justify;">
                  <td>6.3. Nilai Bon Pelaksanaan</td>
                  <td>:</td>
                  <td><span class="discountedTotalHarga text-uppercase"></span></td>
               </tr>
               <tr style="text-align:justify;">
                  <td>6.4. Bentuk Bon Pelaksanaan</td>
                  <td>:</td>
                  <td>Jaminan Bank/ Bank Islam/ Bank Pembangunan Malaysia Berhad; atau Jaminan Syarikat Kewangan; atau Jaminan Insurans/ Takaful.</td>
               </tr>
               <tr style="text-align:justify;">
                  <td>6.5. Tempoh Sah Laku</td>
                  <td>:</td>
                  <td>Dari tarikh kuat kuasa kontrak sehingga <label class="Tempoh_Kontrak"></label> selepas tarikh tamat kontrak atau tarikh obligasi terakhir mengikut mana yang terkemudian.</td>
               </tr>
            </table>
            <p class="custom-padding">Mengikut format yang ditetapkan oleh Universiti seperti di <i>Lampiran A4</i></p>
            <p class="custom-class">7.<b><u>*Polisi Insurans (jika berkaitan)</u></b></p>
            <table width="50%" cellspacing="2" cellpadding="10">
               <tr style="text-align:justify;">
                  <td>7.1. Nilai Polisi</td>
                  <td>:</td>
                  <td>Tiada</td>
               </tr>
               <tr style="text-align:justify;">
                  <td>7.2. Tempoh Perlindungan</td>
                  <td>:</td>
                  <td>Tiada</td>
               </tr>
            </table>
            <p class="custom-class">8. <b><u>Kenaan *Denda / Tolakan / <i>Liquidated & Ascertained Damages (LAD)</i></u></b></p>
            <table cellspacing="2" cellpadding="10">
               <tr style="text-align:justify;">
                  <td>8.1. Denda beramaun 2.5% daripada nilai barang-barang yang dipesan jika kelewatan itu tidak melebihi tempoh penyerahan sebanyak dua kali ganda lamanya</td>
               </tr>
               <tr style="text-align:justify;">
                  <td>8.2. Denda beramaun 5% daripada nilai barang-barang yang dipesan jika kelewatan itu adalah melebihi daripada dua kali ganda lamanya</td>
               </tr>
            </table>
            <p style="page-break-before: always;">&nbsp;</p>
            <!------------------------------------ PAGE 6 END ------------------------------------>
            <!------------------------------------ PAGE 7 START ------------------------------------>
              <!---- UTEM Header ---->
            <header>
               <table class="header-table" >
                  <thead>
                     <tr>
                        <th style="width: 30%; background-color: #F5F5F5; border: 1px solid #dddddd; padding: 8px; text-align: left;">No. Sebut Harga :</th>
                        <th class="noSebutHarga text-uppercase"></th>
                     </tr>
                  </thead>
               </table>
            </header>
            <!---- UTEM Header ---->
            <p class="custom-space"><b><u>Salinan Kepada</u></b></p>
            <p class="custom-space">
               Profesor Ir. Dr. Hambali bin Arep @ Ariff<br />
               Dekan<br />
               Fakulti Teknologi dan Kejuruteraan Industri dan Pembuatan
            </p>

            <p class="custom-space">
               Mohamad Yusof bin Mohamad Dan<br />
               Timbalan Pendaftar<br />
               Fakulti Teknologi dan Kejuruteraan Industri dan Pembuatan
            </p>

            <p class="custom-space">
               Ir. Ts. Dr. Lailatul Harina binti Paijan<br />
               Ketua Jabatan<br />
               Fakulti Teknologi dan Kejuruteraan Industri dan Pembuatan
            </p>

            <p class="custom-space">
               Encik Bakri bin Abu Bakar<br />
               Timbalan Bendahari Kanan <br />
               Bahagian Pengurusan Kewangan<br />
               Pejabat Bendahari
            </p>

            <p class="custom-space">
               Puan Siti Fatimah Zahra binti Hasan<br />
               Penolong Bendahari Kanan<br />
               Zon Kewangan PTJ B dan Penyelidikan<br />
               Bahagian Pengurusan Kewangan<br />
               Pejabat Bendahari
            </p>
 
            <p class="custom-space">Fail <span class="noSebutHarga text-uppercase"></span></p>
            <p style="page-break-before: always;"></p>
            <!------------------------------------ PAGE 7 END------------------------------------>
            <!------------------------------------ PAGE 8 START------------------------------------>
             <div class="flagBid">
               <!---- UTEM Header ---->
            <header>
               <table class="header-table" >
                  <thead>
                     <tr>
                        <th style="width: 30%; background-color: #F5F5F5; border: 1px solid #dddddd; padding: 8px; text-align: left;">No. Sebut Harga :</th>
                        <th class="noSebutHarga text-uppercase"></th>
                     </tr>
                  </thead>
               </table>
            </header>
            <!---- UTEM Header ---->
            <div class="akuan-pembida">
               <p style="text-align:right; font-weight:bold"><i>Lampiran B</i></p>
               <p style="text-align:center; font-weight:bold"><u>SURAT AKUAN PEMBIDA BERJAYA</u></p>
               <p style="text-align:center; font-weight:bold">QUOTATION FOR THE SUPPLY, OF CAR SPRAY PAINTING SYSTEM TO UNIVERSITI TEKNIKAL MALAYSIA MELAKA.</p>
               <p class="custom-class">Saya ............................................................................................................. nombor Kad Pengenalan .......................................................................... yang mewakili syarikat .............................................. bernombor pendaftaran (*MOF/CIDB/SSM) .......................................................... dengan ini mengisytiharkan bahawa saya atau mana-mana orang yang mewakili syarikat ini :</p>
               <ol type="i" class="custom-class">
                  <li>
                     tidak akan menawarkan, menjanjikan atau memberikan apa- apa suapan kepada mana-mana orang dalam mana-mana Universiti Teknikal Malaysia Melaka atau mana-mana orang lain sebagai suapan untuk dipilih dalam mana-mana perolehan; dan
                  </li>
                  <li>
                     tidak akan melakukan atau terlibat dengan tipuan bida dalam mana-mana perolehan.
                  </li>
               </ol>
               <p class="custom-class">Bersama ini dilampirkan Surat Perwakilan Kuasa bagi saya mewakili syarikat seperti tercatat di atas untuk membuat pengisytiharan ini.</p>
           
               <p class="custom-class">
                  2.&nbsp;&nbsp;&nbsp;Sekiranya saya atau mana-mana individu yang mewakili syarikat ini didapati terlibat dalam membuat pakatan harga dengan syarikat lain atau apa-apa pakatan sepanjang proses perolehan atau menawarkan, menjanjikan atau memberikan apa-apa suapan kepada mana-mana orang dalam Universiti Teknikal Malaysia Melaka atau mana-mana orang lain sebagai dorongan untuk dipilih dalam sebut harga seperti di atas, maka saya sebagai wakil syarikat bersetuju tindakan-tindakan berikut diambil: 
               </p>
             
               <p class="custom-class">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  2.1 Penarikan balik tawaran kontrak bagi sebut harga di atas; atau<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  2.2 Penamatan kontrak bagi sebut harga di atas; dan<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                  2.3 Lain-lain tindakan tatatertib mengikut peraturan perolehan Universiti yang berkuatkuasa.
               </p>
             
               <p class="custom-class">
                  3.&nbsp;&nbsp;&nbsp;Saya sesungguhnya faham bahawa tindakan berikut akan diambil : 
               </p>
             
               <p class="custom-class">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&ensp;&ensp;&ensp;
                  3.1 Didakwa bagi kesalahan** di bawah Akta Suruhanjaya Pencegahan Rasuah Malaysia 2009 [Akta 694] dan Kanun Keseksaan <span class="padded-text">[Akta 574] serta boleh dihukum di bawah undang-undang masing masing untuk kegagalan saya atau mana-mana orang yang <span class="padded-text">mewakili syarikat ini untuk mematuhi perkara (i); atau<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&ensp;&ensp;
                  3.2 tindakan boleh dikenakan ke atas syarikat di bawah Akta Persaingan 2010 [Akta 712] atas kegagalan saya atau mana-mana <span class="padded-text">orang yang mewakili syarikat ini untuk mematuhi perkara (ii). Sekiranya syarikat didapati melanggar peruntukan seksyen 4(2)(d) <span class="padded-text">Akta 712, syarikat boleh didenda tidak melebihi sepuluh peratus (10%) daripada pusing ganti (turn over) seluruh dunia <span class="padded-text">sepanjang tempoh suatu pelanggaran itu berlaku.
               </p>
              
               <p class="custom-class">
                  4.&nbsp;&nbsp;&nbsp;Sekiranya terdapat mana-mana orang cuba memperolehi atau meminta apa-apa suapan daripada saya atau mana-mana orang yang berkaitan dengan syarikat ini sebagai dorongan untuk dipilih dalam sebut harga seperti di atas, maka saya berjanji akan dengan segera melaporkan perbuatan tersebut kepada pejabat Suruhanjaya Pencegahan Rasuah Malaysia (SPRM) atau balai polis yang berhampiran. Saya sedar bahawa kegagalan saya berbuat demikian adalah merupakan suatu kesalahan di bawah seksyen 25 (1) Akta Suruhanjaya Pencegahan Rasuah Malaysia 2009 [Akta 694] dan boleh dihukum di bawah seksyen 25 (2) akta yang sama, apabila disabitkan boleh didenda tidak melebihi RM100,000 atau penjara selama tempoh tidak melebihi sepuluh tahun atau kedua-duanya.
               </p>

                  <p class="custom-class">
                  5.&nbsp;&nbsp;&nbsp;Saya sesungguhnya faham bahawa syarikat melakukan kesalahan jika seseorang yang bersekutu dengan syarikat memberikan, menjanjikan atau menawarkan suapan untuk memperoleh atau mengekalkan perniagaan atau faedah dalam menjalankan perniagaan di bawah seksyen 17A Akta Suruhanjaya Pencegahan Rasuah Malaysia 2009 [Akta 694], apabila disabitkan kesalahan boleh didenda tidak kurang daripada sepuluh kali ganda jumlah atau nilai suapan, atau RM1 juta, atau dipenjarakan selama tempoh tidak melebihi dua puluh tahun atau kedua-duanya.
               </p>

               <p class="custom-space">
                  Yang Benar,
               </p>
               <table class="signature-table custom-class" cellspacing="2">
                  <tr style="text-align:justify;">
                     <td colspan="2 "align="center">..................................................................</td>
                     <td colspan="2" align="center">..................................................................</td>
                  </tr>
                  <tr style="text-align:justify;">
                     <td colspan="2" align="center">Tandatangan Pemilik Syarikat</td>
                     <td colspan="2" align="center">Cop Syarikat</td>
                  </tr>
               </table>
  
               <table  cellspacing="2" class="custom-class">
                  <tr style="text-align:justify;">
                     <td>Nama</td>
                     <td>:</td>
                     <td colspan="2">_____________________________________</td>
                  </tr>
                  <tr style="text-align:justify;">
                     <td>No. Kad Pengenalan</td>
                     <td>:</td>
                     <td colspan="2">_____________________________________</td>
                  </tr>
                  <tr style="text-align:justify;">
                     <td>Tarikh</td>
                     <td>:</td>
                     <td colspan="2">_____________________________________</td>
                  </tr>
               </table>
            </div>
               <p style="page-break-before: always;">&nbsp;</p>
                 </div>
               <!------------------------------------ PAGE 8 END------------------------------------>
               <!------------------------------------ PAGE 9 START------------------------------------>
             
            <!------------------------------------ PAGE 9 END------------------------------------>
            <!------------------------------------ PAGE 10 START------------------------------------>
             <!---- UTEM Header ---->
            <header>
               <table class="header-table" >
                  <thead>
                     <tr>
                        <th style="width: 30%; background-color: #F5F5F5; border: 1px solid #dddddd; padding: 8px; text-align: left;">No. Sebut Harga :</th>
                         <th class="noSebutHarga text-uppercase"></th>
                     </tr>
                  </thead>
               </table>
            </header>
            <!---- UTEM Header ---->
            <div class="akuan-sumpah">
               <p style="text-align:right; font-weight:bold"><i>Lampiran C</i></p>
               <p style="text-align:center; font-weight:bold"><u>SURAT AKUAN SUMPAH</u></p>
               <p class="custom-class">Saya .................................................................................. nombor kad pengenalan ................................... yang mewakili syarikat .................................... bernombor pendaftaran (*MOF/CIDB/SSM) ..................................................................... dengan sesungguhnya dan sebenarnya mengaku bahawa:</p>
            
               <ol type="a" class="custom-class">
                  <li>
                     syarikat <b>TIDAK</b> membuat salah nyataan (misrepresentation) atau mengemukakan maklumat palsu semasa berurusan dengan Universiti bagi perolehan ini atau melakukan apa-apa perbuatan lain, seperti memalsukan maklumat dalam SIjil Akuan Pendaftaran Syarikat, mengemukakan bon pelaksanaan atau dokumen lain yang palsu atau yang telah diubah suai;
                  </li>
                  <li>
                     syarikat <b>TIDAK</b> membenarkan Sijil Akuan Pendaftaran Syarikat disalahgunakan oleh individu / syarikat lain;
                  </li>
                  <li>
                     syarikat <b>TIDAK</b> terlibat dalam membuat pakatan harga dengan syarikat-syarikat lain atau apa-apa pakatan sepanjang proses sebut harga sehingga dokumen kontrak ditandatangani;
                  </li>
                  <li>
                     syarikat / pemilik / rakan kongsi / pengarah <b>TIDAK</b> disabitkan atas kesalahan jenayah di dalam atau di luar negara Malaysia ; dan
                  </li>
                  <li>
                     syarikat <b>TIDAK</b> digulungkan.
                  </li>
               </ol>
           
               <p class="custom-class">Sekiranya pada bila-bila masa, dibuktikan bahawa pengisytiharan perenggan di atas adalah tidak benar, Universiti berhak menarik balik tawaran kontrak atau menamatkan perkhidmatan syarikat bagi projek ini.</p>
         
               <p class="custom-class">Dan saya membuat Surat Akuan Bersumpah ini dengan kepercayaan bahawa apa-apa yang tersebut di dalamnya adalah benar serta menurut Akta Akuan Berkanun 1960.</p>

               <table  cellspacing="2" class="custom-class">
                  <tr style="text-align:justify;">
                     <td>Diperbuat dan dengan</td>
                     <td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;)</td>
                     <td></td>
                  </tr>
                  <tr style="text-align:justify;">
                     <td>sebenar-benarnya diakui oleh</td>
                     <td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;)&ensp;&ensp;&ensp;&ensp;Tandatangan ..................................................................</</td>
                     <td></td>
                  </tr>
                  <tr style="text-align:justify;">
                     <td>..............................................................................</td>
                     <td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;)</td>
                     <td></td>
                  </tr>
                  <tr style="text-align:justify;">
                     <td>di ........................................................................</td>
                     <td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;)</td>
                     <td></td>
                  </tr>
                  <tr style="text-align:justify;">
                     <td>pada ..................................................................</td>
                     <td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;)</td>
                     <td></td>
                  </tr>
               </table>
               <p style="text-align:center;">Di hadapan saya,</p>
               <p style="text-align:center;">..................................................................<br>Pesuruhjaya Sumpah</p>
               <p class="custom-space">Nota:</p>
               <p class="custom-space">i.&nbsp;&nbsp;&nbsp;*Potong mana yang tidak berkenaan.<br>ii.&nbsp;&nbsp;&nbsp;Surat akuan ini hendaklah ditandatangani oleh hanya penama di sijil pendaftaran MOF/CIDB.</p>
            </div>
         </div>
      </div>
      <!------------------------------------ PAGE 10 END------------------------------------>
   </form>
  </body>

    <script>

        var txtTujuan = '';
        var totalHarga = '';
        var idSyarikat = '';
        var noSebutHarga = '';
        var txtNamaSyarikat = '';

        var noMohonValue = sessionStorage.getItem('noMohonValue');
        var noSebutHarga = sessionStorage.getItem('noSebutHarga');
        var txtTujuan = sessionStorage.getItem('txtTujuan');
        var idSyarikat = sessionStorage.getItem('idSyarikat');
        var totalHarga = sessionStorage.getItem('totalHarga');
        var txtNamaSyarikat = sessionStorage.getItem('txtNamaSyarikat');

        console.log("noMohonValue=", noMohonValue);

        // Check if the value exists
        if (noMohonValue !== null) {
            // Value exists, log it
            console.log("noMohonValue:", noMohonValue);
            console.log("txtNamaSyarikat:", txtNamaSyarikat);
            console.log("idSyarikat:", idSyarikat);
        } else {
            // Value does not exist in session storage
            console.log("noMohonValue not found in session storage");
        }

        // Get the text content of the label
        $(document).ready(function () {

            $(".txtTujuan").text(txtTujuan);
            $(".noSebutHarga").text(noSebutHarga);
            $(".totalHarga").text(totalHarga);
        });

        console.log("Data being sent:", JSON.stringify({ noMohonValue: noMohonValue, noSebutHarga: noSebutHarga, txtTujuan: txtTujuan, idSyarikat: idSyarikat, totalHarga: totalHarga, txtNamaSyarikat: txtNamaSyarikat }));

        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/LoadKelulusanPo") %>',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ noMohonValue: noMohonValue, noSebutHarga: noSebutHarga, txtTujuan: txtTujuan, idSyarikat: idSyarikat, totalHarga: totalHarga, txtNamaSyarikat: txtNamaSyarikat }),
                success: function (data) {

                    var bonSST;
                    var jsonData = JSON.parse(data.d);


                    
                    // Check totalHarga range and assign discount percentage accordingly
                    if (totalHarga >= 500000) {
                        bonSST = "5%"; // 5%
                    } else if (totalHarga >= 200000 && totalHarga < 500000) {
                        bonSST = "2.5%"; // 2.5%
                    } else {
                        bonSST = "TIADA"; // No discount
                    }

                    console.log("BON SST:", bonSST);

                    // Initialize discount percentage
                    var discountPercentage;

                    // Check totalHarga range and assign discount percentage accordingly
                    if (totalHarga >= 500000) {
                        discountPercentage = 0.05; // 5%
                    } else if (totalHarga >= 200000 && totalHarga < 500000) {
                        discountPercentage = 0.025; // 2.5%
                    } else {
                        discountPercentage = 0; // No discount
                    }
                    console.log("Discount Percentage:", discountPercentage);

                    // Apply discount
                    var discountedTotalHarga = totalHarga * discountPercentage;
                    // Round discountedTotalHarga to two decimal places
                    discountedTotalHarga = discountedTotalHarga.toFixed(2);
                    console.log("Rounded Discounted Total Harga:", discountedTotalHarga);

                    // Format totalHarga to RM1,310.00
                    var formattedTotalHarga = parseFloat(totalHarga).toLocaleString('en-MY', {
                        style: 'currency',
                        currency: 'MYR',
                        minimumFractionDigits: 2
                    });

                    var formattedDiscountedTotalHarga = parseFloat(discountedTotalHarga).toLocaleString('en-MY', {
                        style: 'currency',
                        currency: 'MYR',
                        minimumFractionDigits: 2
                    });

                    const totalHargaWords = convertToWords(totalHarga);

                    // Now you have totalHargaWords, you can use it as needed
                    //console.log("Total Harga in Words:", totalHargaWords);

                    // Set the value of the txtTempat element with the received data
                    $(".noSebutHarga").text(noSebutHarga);
                    $(".txtTujuan").text(txtTujuan);
                    $(".totalHarga").text(formattedTotalHarga);
                    $(".idSyarikat").text(idSyarikat);
                    $(".totalHargaWords").text(totalHargaWords);
                    $(".txtNamaSyarikat").text(txtNamaSyarikat);
                    $(".discountedTotalHarga").text(formattedDiscountedTotalHarga);
                    $(".bonSST").text(bonSST);
                    $(".txtNoSSM").text(jsonData[0].No_Daftar);

                    var currentDate = new Date();

                    // Get the current date components
                    var day = currentDate.getDate();
                    var month = currentDate.getMonth() + 1; // Months are zero-indexed, so we add 1
                    var year = currentDate.getFullYear();

                    // Pad single-digit day and month values with leading zeros
                    if (day < 10) {
                        day = '0' + day;
                    }
                    if (month < 10) {
                        month = '0' + month;
                    }

                    // Convert jsonData[0].Tkh_Tamat to Date object for comparison
                    var tamatDateParts = jsonData[0].Tkh_Tamat.split('/');
                    var tamatDate = new Date(tamatDateParts[2], tamatDateParts[1] - 1, tamatDateParts[0]); // Year, month (zero-based), day

                    if (tamatDate > currentDate) {
                        $(".contractStatus").text("Aktif");
                    } else {
                        $(".contractStatus").text("Tidak Aktif");
                    }

                    $(".txtNoMOF").text(jsonData[0].Kod_Daftar_KEW);
                    $(".dateRange").text(jsonData[0].Tarikh_Mula_KEW + " - " + jsonData[0].Tarikh_tamat_KEW);

                    if (jsonData[0].Taraf = 'BUMI') {
                        $(".txtStatusBumi").text('BUMIPUTRA');
                        $(".txtTempohSahBumi").text(jsonData[0].Tarikh_Mula_BUMI + " - " + jsonData[0].Tarikh_tamat_BUMI);
                    } else {
                        $(".txtStatusBumi").text('BUKAN BUMIPUTRA');
                        $(".txtTempohSahBumi").text('-');
                    }
                    $(".Tempoh_Kontrak").text(jsonData[0].Tempoh + " " + jsonData[0].Jenis_Tempoh_butiran);


                    $(".txtAlamatSemasa1").text(jsonData[0].Almt_Semasa_1);
                    $(".txtAlamatSemasa2").text(jsonData[0].Almt_Semasa_2);
                    $(".txtPoskodSemasa").text(jsonData[0].Poskod_Semasa);
                    $(".txtBandarSemasa").text(jsonData[0].Bandar_name); 
                    $(".txtNegeriSemasa").text(jsonData[0].Negeri_name);
                    $(".txtEmelSyarikat").text(jsonData[0].Emel_Semasa);
                                         
                },
                error: function (error) {
                    console.log("Error: " + error);
                }
            });
        });

      <%--  $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Load_SyarikatInfo") %>',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ noMohonValue: noMohonValue, noSebutHarga: noSebutHarga, txtTujuan: txtTujuan, idSyarikat: idSyarikat }),
                success: function (data) {
                    // Parse the JSON data received from the server
                    var jsonData = JSON.parse(data.d);

                    // Assuming Tempat is a property of the first object in jsonData
                    var txtEmelSyarikat = jsonData[0].Emel_Semasa;
                    var txtAlamatSemasa1 = jsonData[0].Almt_Semasa_1;
                    var txtAlamatSemasa2 = jsonData[0].Almt_Semasa_2;
                    var txtBandarSemasa = jsonData[0].Bandar;
                    var txtPoskodSemasa = jsonData[0].Poskod_Semasa;
                    var txtNegeriSemasa = jsonData[0].Negeri;

                    // Now you have totalHargaWords, you can use it as needed
                    console.log("txtEmelSyarikat:", txtEmelSyarikat);

                    // Set the value of the txtTempat element with the received data
                    $(".txtEmelSyarikat").text("Email: " + txtEmelSyarikat);
                    $(".txtAlamatSemasa1").text(txtAlamatSemasa1);
                    $(".txtAlamatSemasa2").text(txtAlamatSemasa2);
                    $(".txtBandarSemasa").text(txtBandarSemasa);
                    $(".txtPoskodSemasa").text(txtPoskodSemasa);
                    $(".txtNegeriSemasa").text(txtNegeriSemasa);
                },
                error: function (error) {
                    console.log("Error: " + error);
                }
            });
        });

        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Load_PerolehanSyarikat") %>',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ noMohonValue: noMohonValue }),
                success: function (data) {
                    // Parse the JSON data received from the server
                    var jsonData = JSON.parse(data.d);

                    // Assuming Tempat is a property of the first object in jsonData
                    var txtTempoh = jsonData[0].Tempoh;
                    var txtTempohBekal = jsonData[0].Tempoh_Bekal;

                    // Set the value of the txtTempat element with the received data
                    $(".txtTempohBekal").text(txtTempohBekal);
                    $(".txtTempoh").text(txtTempoh);
                },
                error: function (error) {
                    console.log("Error: " + error);
                }
            });
        });

        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/Display_ButiranKontrak") %>',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ noMohonValue: noMohonValue }),
                success: function (data) {
                    // Parse the JSON data received from the server
                    var jsonData = JSON.parse(data.d);

                    var txtNoSSM = jsonData[0].SSM;
                    var txtTkhMulaSSM = jsonData[0].tkhMula_SSM;
                    var txtTkhTamatSSM = jsonData[0].tkhTamat_SSM;
                    var txtNoMOF = jsonData[0].MOF;
                    var txtTkhMulaKEW = jsonData[0].tkhTamat_KEW;
                    var txtTkhTamatKEW = jsonData[0].tkhTamat_KEW;

                    // Convert tkhTamat to a Date object
                    var tkhTamatDate = new Date(txtTkhTamatSSM); // Example value

                    // Get the current date
                    var currentDate = new Date();

                    // Compare tkhTamatDate with the current date
                    var contractStatus;
                    if (tkhTamatDate < currentDate) {
                        contractStatus = "Tidak Aktif";
                    } else {
                        contractStatus = "Aktif";
                    }

                    $(".contractStatus").text(contractStatus);
                    // Log contract status to the console
                    /*console.log("Contract Status:", contractStatus);*/


                    // Set the value of the txtTempat element with the received data
                    $(".txtNoSSM").text(txtNoSSM);
                    $(".txtTkhMulaSSM").text(txtTkhMulaSSM);
                    $(".txtTkhTamatSSM").text(txtTkhTamatSSM);
                    $(".txtNoMOF").text(txtNoMOF);

                    // Display date range in the td element in DD/MM/YYYY format
                    $(".dateRange").each(function () {
                        var $this = $(this);
                        var startDate = formatDate(txtTkhMulaKEW);
                        var endDate = formatDate(txtTkhTamatKEW);
                        $this.text(startDate + " - " + endDate);
                    });

                    // Display date range in the td element in DD/MM/YYYY format
                    $(".dateRangeBumi").each(function () {
                        var $this = $(this);
                        var startDate = formatDate(txtTkhMulaKEW);
                        var endDate = formatDate(txtTkhTamatKEW);
                        $this.text(startDate + " - " + endDate);
                    });
                },
                error: function (error) {
                    console.log("Error: " + error);
                }
            });
        });--%>

       <%-- $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/ViewStatus_Bumi") %>',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify({ noMohonValue: noMohonValue }),
        success: function (data) {
            // Parse the JSON data received from the server
            var jsonData = JSON.parse(data.d);

            if (jsonData.length > 0 && jsonData[0].hasOwnProperty("Kod_Daftar")) {
                var txtKodBumi = jsonData[0].Kod_Daftar;
                var txtTkhMulaBUMI = jsonData[0].Tkh_Mula;
                var txtTkhTamatBUMI = jsonData[0].Tkh_Tamat;
                var txtStatusBumi = jsonData[0].Status_Bumi;

                console.log("txtKodBumi", txtKodBumi);
                console.log("txtTkhMulaBUMI", txtTkhMulaBUMI);
                console.log("txtTkhTamatBUMI", txtTkhTamatBUMI);
                console.log("txtStatusBumi", txtStatusBumi);

                var result;

                if (txtKodBumi && txtKodBumi.trim() !== "") { // Check if txtKodBumi is not null or empty
                    if (txtKodBumi.trim() === "BUMI") { // Check if txtKodBumi is "BUMI"
                        var startDate = new Date(txtTkhMulaBUMI);
                        var endDate = new Date(txtTkhTamatBUMI);

                        var startDay = ("0" + startDate.getDate()).slice(-2);
                        var startMonth = ("0" + (startDate.getMonth() + 1)).slice(-2);
                        var startYear = startDate.getFullYear();

                        var endDay = ("0" + endDate.getDate()).slice(-2);
                        var endMonth = ("0" + (endDate.getMonth() + 1)).slice(-2);
                        var endYear = endDate.getFullYear();

                        var dateRange = startDay + "/" + startMonth + "/" + startYear + " - " + endDay + "/" + endMonth + "/" + endYear;
                        result = dateRange;
                        txtStatusBumi = "BUMIPUTERA"; // Change txtStatusBumi to "BUMIPUTERA"
                    } else {
                        result = "TIADA";
                    }
                } else {
                    result = "TIADA";
                }

                $(".txtKodBumi").text(txtKodBumi);
                $(".txtTkhMulaBUMI").text(txtTkhMulaBUMI);
                $(".txtTkhTamatBUMI").text(txtTkhTamatBUMI);
                $(".txtStatusBumi").text(txtStatusBumi);
                $(".result").text(result);
            } else {
                // Handle the case where jsonData is empty or Kod_Daftar property doesn't exist 
                console.log("No data or Kod_Daftar property does not exist.");
                var txtStatusBumi = "TIADA";
                var result = "TIADA";
                $(".txtStatusBumi").text(txtStatusBumi);
                $(".result").text(result);
            }
        },
        error: function (error) {
            console.log("Error: " + error);
        }
    });
      });--%>

     

        function formatDate(dateString) {
            var date = new Date(dateString);
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();

            // Ensure leading zeros if necessary
            day = day < 10 ? '0' + day : day;
            month = month < 10 ? '0' + month : month;

            return day + '/' + month + '/' + year;
        }

        function convertToWords(amount) {
            // Arrays for number words in Malay
            var ones = ['', 'Satu', 'Dua', 'Tiga', 'Empat', 'Lima', 'Enam', 'Tujuh', 'Lapan', 'Sembilan'];
            var teens = ['Sepuluh', 'Sebelas', 'Dua Belas', 'Tiga Belas', 'Empat Belas', 'Lima Belas', 'Enam Belas', 'Tujuh Belas', 'Lapan Belas', 'Sembilan Belas'];
            var tens = ['', 'Sepuluh', 'Dua Puluh', 'Tiga Puluh', 'Empat Puluh', 'Lima Puluh', 'Enam Puluh', 'Tujuh Puluh', 'Lapan Puluh', 'Sembilan Puluh'];
            var scales = ['', 'Ribu', 'Juta', 'Bilion', 'Trilion']; // Scale for large numbers

            // Function to convert a number to words
            function convertGroup(num, scaleIndex) {
                var words = '';
                if (num === 0) {
                    return words; // If the number is 0, return empty string
                }

                // Extract hundreds, tens, and ones
                var hundreds = Math.floor(num / 100);
                var tensAndOnes = num % 100;

                if (hundreds > 0) {
                    words += ones[hundreds] + ' Ratus ';
                }

                if (tensAndOnes < 10) {
                    words += ones[tensAndOnes] + ' ';
                } else if (tensAndOnes < 20) {
                    words += teens[tensAndOnes - 10] + ' ';
                } else {
                    var tensIndex = Math.floor(tensAndOnes / 10);
                    var onesIndex = tensAndOnes % 10;
                    words += tens[tensIndex] + ' ' + ones[onesIndex] + ' ';
                }

                if (scaleIndex > 0) {
                    words += scales[scaleIndex] + ' ';
                }

                return words;
            }

            // Function to convert cents to words
            function convertCents(cents) {
                if (cents === 0) {
                    return '';
                }
                return convertGroup(cents, -1) + 'Sen';
            }

            var words = 'Ringgit Malaysia ';
            var remainingAmount = Math.floor(amount); // Extract integer part
            var cents = Math.round((amount - remainingAmount) * 100); // Extract decimal part and round to cents

            for (var i = scales.length - 1; i >= 0; i--) {
                var divisor = Math.pow(10, 3 * i); // Divide the number into groups of three digits
                var group = Math.floor(remainingAmount / divisor);

                if (group > 0) {
                    words += convertGroup(group, i);
                    remainingAmount %= divisor;
                }
            }

            if (words === 'Ringgit Malaysia ') {
                words += 'Kosong'; // If the amount is 0, return 'kosong'
            }

            words = words.trim(); // Trim any extra whitespace

            // Add cents conversion if there are any
            if (cents > 0) {
                words += ' Dan ' + convertCents(cents);
            }

            words += ' Sahaja'; // Add 'sahaja' at the end

            // Capitalize each word
            words = words.split(' ').map(function (word) {
                return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
            }).join(' ');

            return words;
        }

        $(document).ready(function () {
            // Call the server-side method on page load
            $.ajax({
                type: "POST", // or "GET" depending on your server-side configuration
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/ViewShow_PageAkuan") %>',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: JSON.stringify({ noMohonValue: noMohonValue }),
                success: function (response) {
                    // Check if the response is not empty (means Flag_Ebidding is 1)
                    if (response.d != "") {
                        // Show the flagBid div
                        $(".flagBid").show();
                    } else {
                        // Hide the flagBid div
                        $(".flagBid").hide();
                    }
                },
                error: function (xhr, status, error) {
                    console.log("Error:", error);
                }
            });
        });


        function getBidangKod() {
            var noMohonValue = sessionStorage.getItem('noMohonValue');
            $.ajax({
                type: 'POST',
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/pembuka.asmx/PaparStatusBidang") %>',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: JSON.stringify({ noMohonValue: noMohonValue }),
                success: function (result) {
                    result = JSON.parse(result.d)
                    console.log(result);
                    $('#displayKodBidang1').html(result.Payload);
                    $('#ringkasanL1').html(result.Payload);

                    callPrint();
                },
                error: function (error) {
                    // Handle the case when there is an AJAX error
                    console.error('AJAX error:', error);
                }
            });
        }
        getBidangKod();

        function callPrint() {
            if (window.addEventListener) {
                //getData();

                setTimeout(
                    function () {
                        window.print();
                    }, 1000);
               
                
            } else {
                setTimeout(
                    function () {
                        window.print();
                    }, 1000);

            }
        }

    </script>
</html>