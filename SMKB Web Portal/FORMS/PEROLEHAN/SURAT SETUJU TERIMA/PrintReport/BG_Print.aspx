<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BG_Print.aspx.vb" Inherits="SMKB_Web_Portal.BG_Print" %>

<!DOCTYPE html>
<html>
 <head>
    <title>BANK JAMINAN (BG)</title>
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
            <div class="bg">
                   <div class="MsoNormal" align="center" style="margin-top:10px; margin-bottom:30px"> 
                       <h5 align='center'>BORANG JAMINAN BANK UNTUK BON PELAKSANAAN<br />
                           (KONTRAK BEKALAN/PERKHIDMATAN)<br />NO. SEBUT HARGA : <span class="noSebutHarga text-uppercase" style="margin: 0;"></span>
                       </h5>

                       <h5><span class="txtTujuan text-uppercase" style="margin: 0;"></span></h5>
                   </div>

                <p class="custom-class">Sebagai balasan kepada kontrak <b>No. <span class="noSebutHarga text-uppercase" style="margin: 0;"></span></b> yang dibuat antara <b>UNIVERSITI TEKNIKAL MALAYSIA MELAKA</b>, kemudian daripada ini dirujuk sebagai “Kerajaan” dan <b><span class="txtNamaSyarikat text-uppercase" style="margin: 0;"></span></b> kemudian daripada ini dirujuk sebagai “Kontraktor”, bagi <b>perkhidmatan/pembekalan</b> kemudian daripada ini dirujuk sebagai “Kontrak”, kami yang bertandatangan di bawah, atas permohonan Kontraktor, mengaku janji yang tidak boleh batal untuk memberi Jaminan kepada Kerajaan ke atas pelaksanaan yang sepatutnya Kontrak tersebut mengikut cara sebagaimana yang terdapat kemudian daripada ini.</p>

                <p class="custom-class"><b>MAKA Penjamin dengan ini bersetuju dengan Kerajaan seperti berikut:</b></p>

                <p class="custom-class">
                  1.&ensp;&ensp;&ensp;&ensp;Apabila Kerajaan membuat tuntutan bertulis, maka Penjamin hendaklah dengan serta merta membayar kepada Kerajaan nilai yang ditentukan di dalam tuntutan tersebut tanpa mengira sama ada terdapat apa-apa bantahan atau tentangan daripada Kontraktor atau Penjamin atau mana-mana pihak Ketiga yang lain dan tanpa bukti atau bersyarat. Dengan syarat sentiasanya bahawa jumlah tuntutan yang dibuat tidak melebihi sebanyak <b class="totalHarga"></b> <b>(<span class="totalHargaWords"></span>)</b> dan bahawa tanggungan penjamin untuk membayar kepada Kerajaan di bawah perjanjian ini tidak melebihi nilai tersebut di atas. 
                </p>

                <p class="custom-class">
                  2.&ensp;&ensp;&ensp;&ensp;Kerajaan berhak untuk membuat apa-apa tuntutan separa jika dikehendakinya dan jumlah kesemua tuntutan separa itu hendaklah tidak melebihi nilai <b class="totalHarga"></b> <b>(<span class="totalHargaWords"></span>)</b> dan liabiliti Penjamin untuk membayar kepada Kerajaan jumlah yang disebutkan terdahulu hendaklah dikurangkan dengan perkadaran yang bersamaan dengan apa-apa bayaran separa yang telah dibuat oleh Penjamin. 
               </p>

                <p class="custom-class">
                  3.&ensp;&ensp;&ensp;&ensp;Penjamin tidak boleh dibebaskan atau dilepaskan dari Jaminan ini oleh sebarang perkiraan yang dibuat antara Kontraktor Dan Kerajaan sama ada dengan atau tanpa persetujuan Penjamin atau oleh sebarang perubahan tentang kewajipan yang diaku janji oleh Kontraktor atau oleh sebarang penangguhan sama ada dari segi pelaksanaan, masa, pembayaran atau sebaliknya. 
               </p> 

                 <p class="custom-class">
                  4.&ensp;&ensp;&ensp;&ensp;Jaminan ini adalah Jaminan yang berterusan dan tidak boleh batal dan berkuat kuasa sehingga .................................................... (kemudian daripada ini disebut “Tarikh Mati Asal”) (Initial Expiry Date) iaitu dua belas (12) bulan selepas tarikh tamat Kontrak atau selepas penghantaran terakhir mengikut mana yang terkemudian atau di dalam keadaan di mana Kontrak dibatalkan, satu (1) tahun selepas tarikh Kontrak dibatalkan. Penjamin hendaklah melanjutkan Tarikh Mati Asal (Initial Expiry Date) jaminan ini untuk tempoh tambahan selama tidak melebihi satu (1) tahun daripada Tarikh Mati Asal (Initial Expiry Date) (kemudian daripada ini disebut “Tarikh Mati Lanjutan ”) (Extended Expiry Date) apabila diminta oleh Kerajaan dan Jaminan ini adalah dengan ini dilanjutkan. Jumlah agregat maksimum yang kerajaan berhak di bawah Perjanjian ini mestilah sentiasa dipastikan tidak melebihi jumlah <b class="totalHarga"></b> <b>(<span class="totalHargaWords"></span>)</b>. Apa-apa tanggungjawab dan tanggungan penjamin di bawah Perjanjian ini hendaklah luput apabila Perjanjian ini tamat pada Tarikh Mati Asal (Initial Expiry Date) atau Tarikh Mati Lanjutan (Extended Expiry Date) melainkan jika sebelumnya Kerajaan telah meminta secara bertulis kepada Penjamin untuk membayar sejumlah wang tertentu yang masih belum dijelaskan mengikut peruntukan kontrak. 
               </p>
                                
                <p class="custom-class">
                  5.&ensp;&ensp;&ensp;&ensp;SEMUA TUNTUTAN BERKAITAN DENGAN JAMINAN INI, JIKA ADA, MESTILAH DITERIMA OLEH PIHAK BANK/SYARIKAT KEWANGAN/SYARIKAT INSURANS DALAM TEMPOH SAH LAKU JAMINAN INI ATAUPUN DALAM MASA EMPAT (4) MINGGU DARI TAMATNYA TARIKH JAMINAN INI, MENGIKUT MANA YANG LEBIH KEMUDIAN.
               </p>

                <p class="custom-class">
                    PADA MENYAKSIKAN HAL DI ATAS pihak-pihak kepada Perjanjian ini telah menurunkan tandatangan dan meteri mereka pada hari dan tahun yang mula-mula tertulis di atas.
                </p>

                 <table  cellspacing="2" class="custom-class" style="margin-top:30px; margin-bottom:30px">
                  <tr style="text-align:justify;">
                     <td>Ditandatangani untuk</td>
                     <td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;)</td>
                     <td colspan="2">&ensp;&ensp;&ensp;&ensp;......................................................................................</td>
                  </tr>
                  <tr style="text-align:justify;">
                     <td>dan bagi pihak Penjamin</td>
                     <td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;)</td>
                     <td colspan="2">&ensp;&ensp;&ensp;&ensp;Nama : ......................................................................</td>
                  </tr>
                  <tr style="text-align:justify;">
                     <td>di hadapan</td>
                     <td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;)</td>
                     <td colspan="2">&ensp;&ensp;&ensp;&ensp;Jawatan : ..................................................................</td>
                  </tr>
                   <tr style="text-align:justify;">
                     <td></td>
                     <td>&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;&ensp;)</td>
                     <td colspan="2">&ensp;&ensp;&ensp;&ensp;Cap Bank/Syarikat Kewangan/Syarikat Insurans :</td>
                  </tr>
               </table>

                <table class="custom-class" style="margin-top:30px; margin-bottom:30px">
                   <tr>
                      <td>..................................................................</td>
                   </tr>
                   <tr>
                      <td align="center">(Saksi)</td>
                   </tr>
                </table>

                 <table class="custom-class">
                   <tr>
                      <td>Nama</td>
                      <td>:</td>
                      <td style="text-align:center">..................................................................</td>
                   </tr>
                   <tr>
                      <td>Jawatan </td>
                      <td>:</td>
                      <td align="center">..................................................................</td>
                   </tr>
                    <tr>
                      <td>Cap Bank/Syarikat Kewangan/Syarikat Insurans</td>
                      <td>:</td>
                      <td align="center"></td>
                   </tr>
            </table>
            </div>
        </div>
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

           // Check if the value exists
           if (noMohonValue !== null) {
               // Value exists, log it
               //console.log("noMohonValue:", noMohonValue);
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
                    // Format totalHarga to RM1,310.00
                    var formattedTotalHarga = parseFloat(totalHarga).toLocaleString('en-MY', {
                        style: 'currency',
                        currency: 'MYR',
                        minimumFractionDigits: 2
                    });

                    const totalHargaWords = convertToWords(totalHarga);

                    // Now you have totalHargaWords, you can use it as needed
                    console.log("txtTujuan:", txtTujuan);
                    console.log("noSebutHarga:", noSebutHarga);
                    console.log("idSyarikat:", idSyarikat);

                    // Set the value of the txtTempat element with the received data
                    $(".noSebutHarga").text(noSebutHarga);
                    $(".txtTujuan").text(txtTujuan);
                    $(".totalHarga").text(formattedTotalHarga);
                    $(".idSyarikat").text(idSyarikat);
                    $(".totalHargaWords").text(totalHargaWords);
                    $(".txtNamaSyarikat").text(txtNamaSyarikat);

                    callPrint();
                },
                error: function (error) {
                    console.log("Error: " + error);
                }
            });
        });

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

           function callPrint() {
               if (window.addEventListener) {
                   //getData();
                   window.print();
               } else {
                   window.print();


               }
           }

       </script>
</html>


