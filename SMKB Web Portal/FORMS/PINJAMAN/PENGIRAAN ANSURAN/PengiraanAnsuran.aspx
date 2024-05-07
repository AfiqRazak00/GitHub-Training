<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="PengiraanAnsuran.aspx.vb" Inherits="SMKB_Web_Portal.PengiraanAnsuran" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
   <style>
      .ui.search.dropdown {
      height: 40px;
      }
      .tabcontent {
      padding: 0px 20px 20px 20px !important;
      }
      .table-title {
      padding-top: 0px !important;
      padding-bottom: 0px !important;
      }
      .custom-table > tbody > tr:hover {
      background-color: #ffc83d !important;
      }
      #tblDataSenarai_trans td:hover {
      cursor: pointer;
      }
      .default-primary {
      background-color: #007bff !important;
      color: white;
      }
      /*start sticky table tbody tfoot*/
      table {
      overflow: scroll;
      border-collapse: collapse;
      color: white;
      }
      .secondaryContainer {
      overflow: scroll;
      border-collapse: collapse;
      height: 500px;
      border-radius: 10px;
      }
      .sticky-footer {
      position: sticky;
      bottom: 0;
      background-color: white;
      z-index: 2; 
      }
      .sticky-footer th,
      .sticky-footer td {
      text-align: center; /* Center-align the content in footer cells */
      border-top: 1px solid #ddd; /* Add a border at the top to separate from data rows */
      padding: 10px; /* Adjust padding as needed */
      }
      #showModalButton:hover {
      background-color: #ffc107; /* Change background color on hover */
      color: #fff; /* Change text color on hover */
      border-color: #ffc107; /* Change border color on hover */
      cursor: pointer; /* Change cursor to indicate interactivity */
      }
      /*input CSS */
      .input-group {
      margin-bottom: 20px;
      position: relative;
      }
      .input-group__label {
      display: block;
      position: absolute;
      top: 0;
      line-height: 40px;
      color: #aaa;
      left: 5px;
      padding: 0 5px;
      transition: line-height 200ms ease-in-out, font-size 200ms ease-in-out, top 200ms ease-in-out;
      pointer-events: none;
      }
      .input-group__input {
      width: 100%;
      height: 40px;
      border: 1px solid #dddddd;
      border-radius: 5px;
      padding: 0 10px;
      }
      .input-group__input:not(:-moz-placeholder-shown) + label {
      background-color: white;
      line-height: 10px;
      opacity: 1;
      font-size: 10px;
      top: -5px;
      }
      .input-group__input:not(:-ms-input-placeholder) + label {
      background-color: white;
      line-height: 10px;
      opacity: 1;
      font-size: 10px;
      top: -5px;
      }
      .input-group__input:not(:placeholder-shown) + label, .input-group__input:focus + label {
      background-color: white;
      line-height: 10px;
      opacity: 1;
      font-size: 10px;
      top: -5px;
      }
      .input-group__input:focus {
      outline: none;
      border: 1px solid #01080D;
      }
      .input-group__input:focus + label {
      color: #01080D;
      }
      .input-group__select + label {
      background-color: white;
      line-height: 10px;
      opacity: 1;
      font-size: 10px;
      top: -5px;
      }
      .input-group__select:focus + label {
      color: #01080D;
      }
      /* Styles for the focused dropdown */
      .input-group__select:focus {
      outline: none;
      border: 1px solid #01080D;
      }
      .input-group__label-floated {
      /* Apply styles for the floating label */
      /* For example: */
      top: -5px;
      font-size: 10px;
      line-height: 10px;
      color: #01080D;
      opacity: 1;
      }
      .codx{
      display: none;
      visibility: hidden;
      }
   </style>
   <div class="col-md-12" style="padding-top: 20px; padding-left:20px; padding-bottom:5px;">
      <div>
         <h6 class="mb-3">Sila isikan jumlah amaun pinjaman dan tempoh untuk membuat pengiraan anggaran ansuran bayaran balik pinjaman.</h6>
      </div>
      <div class="row">
         <div class="col-md-5">
            <!-- Preferences  -->
            <fieldset class="form-group border p-3" style="border-radius: 5px;">
               <legend class="w-auto px-2 h6">Kategori</legend>
               <div class="form-check form-check-inline">
                  <input class="form-check-input radiobtn" type="radio" name="inlineRadioOptions" value="option1">
                  <label class="form-check-label" for="inlineRadio1">Kenderaan</label>
               </div>
               <div class="form-check form-check-inline">
                  <input class="form-check-input radiobtn" type="radio" name="inlineRadioOptions" value="option2">
                  <label class="form-check-label" for="inlineRadio2">Komputer/ Peralatan Sukan</label>
               </div>
            </fieldset>
         </div>
      </div>
      <div class="form-row">
         <div id="txtAmountDisp" class="form-group col-md-4">
            <input class="input-group__input form-control " id="txtAmaun" type="text" placeholder="&nbsp;" name="txtAmaun" value="0" size="22" maxlength="7">
            <label class="input-group__label" for="txtAmaun">Jumlah Amaun Pinjaman (RM)</label>
         </div>
         <div id="cmbAmaunDisp" class="form-group col-md-4">
            <div class="form-group input-group">
               <select class="input-group__select ui search dropdown"
                  placeholder="" name="cmbAmaun" id="cmbAmaun">
                  <option class="item" value="0">Pilih Amaun</option>
                  <option class="item" value="100">100</option>
                  <option class="item" value="200">200</option>
                  <option class="item" value="300">300</option>
                  <option class="item" value="400">400</option>
                  <option class="item" value="500">500</option>
                  <option class="item" value="600">600</option>
                  <option class="item" value="700">700</option>
                  <option class="item" value="800">800</option>
                  <option class="item" value="900">900</option>
                  <option class="item" value="1000">1000</option>
                  <option class="item" value="1100">1100</option>
                  <option class="item" value="1200">1200</option>
                  <option class="item" value="1300">1300</option>
                  <option class="item" value="1400">1400</option>
                  <option class="item" value="1500">1500</option>
                  <option class="item" value="1600">1600</option>
                  <option class="item" value="1700">1700</option>
                  <option class="item" value="1800">1800</option>
                  <option class="item" value="1900">1900</option>
                  <option class="item" value="2000">2000</option>
                  <option class="item" value="2100">2100</option>
                  <option class="item" value="2200">2200</option>
                  <option class="item" value="2300">2300</option>
                  <option class="item" value="2400">2400</option>
                  <option class="item" value="2500">2500</option>
                  <option class="item" value="2600">2600</option>
                  <option class="item" value="2700">2700</option>
                  <option class="item" value="2800">2800</option>
                  <option class="item" value="2900">2900</option>
                  <option class="item" value="3000">3000</option>
                  <option class="item" value="3100">3100</option>
                  <option class="item" value="3200">3200</option>
                  <option class="item" value="3300">3300</option>
                  <option class="item" value="3400">3400</option>
                  <option class="item" value="3500">3500</option>
                  <option class="item" value="3600">3600</option>
                  <option class="item" value="3700">3700</option>
                  <option class="item" value="3800">3800</option>
                  <option class="item" value="3900">3900</option>
                  <option class="item" value="4000">4000</option>
                  <option class="item" value="4100">4100</option>
                  <option class="item" value="4200">4200</option>
                  <option class="item" value="4300">4300</option>
                  <option class="item" value="4400">4400</option>
                  <option class="item" value="4500">4500</option>
                  <option class="item" value="4600">4600</option>
                  <option class="item" value="4700">4700</option>
                  <option class="item" value="4800">4800</option>
                  <option class="item" value="4900">4900</option>
                  <option class="item" value="5000">5000</option>
               </select>
               <label class="input-group__label">Jumlah Amaun Pinjaman (RM)</label>
            </div>
         </div>
      </div>
      <div class="form-row">
         <div id="cmbTempohKendDisp" class="form-group col-md-4">
            <div class="form-group input-group">
               <select class="input-group__select ui search dropdown"
                  placeholder="" name="cmbTempohKend" id="cmbTempohKend">
                  <option class="item" value="0" selected>Tempoh</option>
                  <option class="item" value="6">6</option>
                  <option class="item" value="12">12</option>
                  <option class="item" value="18">18</option>
                  <option class="item" value="24">24</option>
                  <option class="item" value="30">30</option>
                  <option class="item" value="36">36</option>
                  <option class="item" value="42">42</option>
                  <option class="item" value="48">48</option>
                  <option class="item" value="54">54</option>
                  <option class="item" value="60">60</option>
                  <option class="item" value="66">66</option>
                  <option class="item" value="72">72</option>
                  <option class="item" value="78">78</option>
                  <option class="item" value="84">84</option>
                  <option class="item" value="90">90</option>
                  <option class="item" value="96">96</option>
                  <option class="item" value="102">102</option>
                  <option class="item" value="108">108</option>
               </select>
               <label class="input-group__label">Tempoh (bulan)</label>
            </div>
         </div>
         <div id="cmbTempohKompDisp" class="form-group col-md-4">
            <div class="form-group input-group">
               <select class="input-group__select ui search dropdown"
                  placeholder="" name="cmbTempohKomp" id="cmbTempohKomp">
                  <option class="item" value="0" selected>Tempoh</option>
                  <option class="item" value="6">6</option>
                  <option class="item" value="12">12</option>
                  <option class="item" value="18">18</option>
                  <option class="item" value="24">24</option>
                  <option class="item" value="30">30</option>
                  <option class="item" value="36">36</option>
                  <option class="item" value="42">42</option>
                  <option class="item" value="48">48</option>
               </select>
               <label class="input-group__label">Tempoh (bulan)</label>
            </div>
         </div>
      </div>
      <div class="form-row">
         <div class="form-group col-md-4">
            <input class="input-group__input " id="kadar" type="text" placeholder="&nbsp;" name="kadar"  readonly style="background-color: #f0f0f0" value="4%" disabled/>
            <label class="input-group__label" for="kadar">Kadar</label>
         </div>
      </div>
      <div class="form-row txtAnsuran1Disp">
         <div class="form-group col-md-4">
            <input class="input-group__input " id="txtAnsuran1" type="text" placeholder="&nbsp;" name="txtAnsuran1"  readonly style="background-color: #f0f0f0" value="-" disabled/>
            <label class="input-group__label" for="txtAnsuran1">Bayaran Bulanan (RM)</label>
         </div>
      </div>
     <div class="form-row txtAnsuran2Disp">
        <div class="form-group col-md-4">
            <input class="input-group__input " id="txtAnsuran2" type="text" placeholder="&nbsp;" name="txtAnsuran2"  readonly style="background-color: #f0f0f0" value="-" disabled/>
            <label class="input-group__label" for="txtAnsuran2">Bayaran Bulanan (RM)</label>
        </div>
        </div>
      <div class="form-row pt-3">
         <div class="form-group col-md-12" align="left">
            <button id="btnReset" type="button" class="btn btn-danger">Isi Semula</button>
            <button id="btnCalc" type="button" class="btn btn-success btnHantar">Kira</button>                
         </div>
      </div>
      <p class="blockquote-footer">Nota : Kadar Tempoh pinjaman Basikal hanya 3 Tahun sahaja.</p>
      <input name="txtJenis" type="hidden" id="txtJenis" value="1" size="5" maxlength="1">
      <input name="txtTempoh" type="hidden" id="txtTempoh" value="6" size="5" maxlength="3">
   </div>
   <script>
       $('#cmbAmaun').dropdown({
           selectOnKeydown: true,
           fullTextSearch: true,
           placeholder: '',
           onChange: function (value, text, $selectedItem) {
               //check jenis enable amuan dicukai if relatable
               console.log(value);

           },
       });

       $('#cmbTempohKend').dropdown({
           selectOnKeydown: true,
           fullTextSearch: true,
           placeholder: '',
           onChange: function (value, text, $selectedItem) {
               //check jenis enable amuan dicukai if relatable
               $("#txtTempoh").val(value);

           },
       });

       $('#cmbTempohKomp').dropdown({
           selectOnKeydown: true,
           fullTextSearch: true,
           placeholder: '',
           onChange: function (value, text, $selectedItem) {
               //check jenis enable amuan dicukai if relatable
               $("#txtTempoh").val(value);
           },
       });

       $('input:radio[name=inlineRadioOptions]')[0].checked = true;

       $("#txtAmountDisp").removeClass("codx");
       $("#cmbAmaunDisp").addClass("codx");

       $("#cmbTempohKendDisp").removeClass("codx");
       $("#cmbTempohKompDisp").addClass("codx");

       $(".txtAnsuran1Disp").removeClass("codx");
       $(".txtAnsuran2Disp").addClass("codx");

       $(".radiobtn").click(function () {
           var value = $(this).val();

           if (value == "option1") {
               //kenderaan
               $("#txtJenis").val(1);
               $("#txtAmountDisp").removeClass("codx");
               $("#cmbAmaunDisp").addClass("codx");

               $("#cmbTempohKendDisp").removeClass("codx");
               $("#cmbTempohKompDisp").addClass("codx");

               $(".txtAnsuran1Disp").removeClass("codx");
               $(".txtAnsuran2Disp").addClass("codx");
           } else if (value == "option2") {
               //komputer
               $("#txtJenis").val(2);
               $("#txtAmountDisp").addClass("codx");
               $("#cmbAmaunDisp").removeClass("codx");

               $("#cmbTempohKendDisp").addClass("codx");
               $("#cmbTempohKompDisp").removeClass("codx");

               $(".txtAnsuran1Disp").addClass("codx");
               $(".txtAnsuran2Disp").removeClass("codx");
           }
       });

       $("#btnReset").click(function () {
           getReset();
       });

       function getReset() {
           //RESET FORM
           $("#txtJenis").val(1);
           $("#txtTempoh").val(0);
           $("#cmbTempohKomp").val($("#cmbTempohKomp option:first").val()).change();
           $("#cmbTempohKend").val($("#cmbTempohKend option:first").val()).change();
           $("#txtAmaun").val(0);
           $("#cmbAmaun").val($("#cmbAmaun option:first").val()).change();
           $("#txtAnsuran1").val('-');
           $("#txtAnsuran2").val('-');
       }

       $("#btnCalc").click(function () {
           var value = $("#txtJenis").val();

           if (value == "1") {
               //kenderaan
               var arrData = {
                   'Type': '1',
                   'InterestRate': '4',
                   'Period': 12,
                   'Principal': $('#txtAmaun').val().replace(',', ''),
                   'Month': $("#cmbTempohKend").val()
               };

               calculateLoan(arrData);
             
           } else if (value == "2") {
               //komputer
               var arrData = {
                   'Type': '2',
                   'InterestRate': '4',
                   'Period': 12,
                   'Principal': $('#cmbAmaun').val(),
                   'Month': $("#cmbTempohKomp").val()
               };

               calculateLoan(arrData);
              
           }
          
       });

       $("#txtAmaun").keypress(function () {
           if (String.fromCharCode(e.keyCode).match(/[^0-9]/g)) return false;
       });

       //NUMERIC INPUT Text
       $("#txtAmaun").keyup(function (e) {
           if (e.which >= 37 && e.which <= 40) return;
           $(this).val(function (index, value) {
               return value
                   // Keep only digits and decimal points:
                   .replace(/[^\d.]/g, "")
                   // Remove duplicated decimal point, if one exists:
                   .replace(/^(\d*\.)(.*)\.(.*)$/, '$1$2$3')
                   // Keep only two digits past the decimal point:
                   .replace(/\.(\d{2})\d+/, '.$1')
                   // Add thousands separators:
                   .replace(/\B(?=(\d{3})+(?!\d))/g, ",")
           });
       });

       function thousands_separators(num) {
           var num_parts = num.toString().split(".");
           num_parts[0] = num_parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
           return num_parts.join(".");
       }


       function calculateLoan(data) {
           var principal = parseInt(data['Principal']);
           var monthlyInterestRate = parseInt(data['InterestRate']) / 100 / 12; // Monthly interest rate
           var loanTermMonths = parseInt(data['Month']); // Loan term in months

           var monthlyPayment = principal * (monthlyInterestRate * Math.pow(1 + monthlyInterestRate, loanTermMonths)) / (Math.pow(1 + monthlyInterestRate, loanTermMonths) - 1);

           // Display the result
           if (data['Type'] == '1') {

               $('#txtAnsuran1').val(thousands_separators(monthlyPayment.toFixed(2)));
           } else {

               $('#txtAnsuran2').val(thousands_separators(monthlyPayment.toFixed(2)));
           }
       }

      

   </script>
</asp:Content>