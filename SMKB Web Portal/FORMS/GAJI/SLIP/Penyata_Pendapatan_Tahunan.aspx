<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Penyata_Pendapatan_Tahunan.aspx.vb" Inherits="SMKB_Web_Portal.Penyata_Pendapatan_Tahunan" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>

    <style>
        .dropdown-list {
            width: 100%;
            /* You can adjust the width as needed */
        }
    
        .align-right {
            text-align: right;
        }
    
        .center-align {
            text-align: center;
        }
    </style>

     <contenttemplate>
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <!-- Modal -->
            <div id="permohonan">
                <div>
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalCenterTitle">Laporan Penyata Pendapatan Tahunan</h5>
                        </div>
            
                        <!-- Create the dropdown filter -->
                        <div class="search-filter">
                            <div class="form-row justify-content-center">
                                <div class="form-group row col-md-6">
                                    <label for="txtPerihal1" class="col-sm-2 col-form-label" style="text-align: right">Tahun :</label>
                                    <div class="col-sm-7">
                                        <div class="input-group">
                                            <select id="ddlyear" class="ui search dropdown">
                                                <option value="">-- Sila Pilih --</option>
                                                <option value="2024">2024</option>
                                                <option value="2023">2023</option>
                                                <option value="2022">2022</option>
                                                <option value="2021">2021</option>
                                                <option value="2020">2020</option>
                                                <option value="2019">2019</option>
                                                <option value="2018">2018</option>                                                   
                                            </select>
                                        </div>
                                    </div>
                                    <button id="Button1" runat="server" class="btn btnSearch" type="button">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <br />
                        <br />
                        <br />
                        <br />
                        <br />

                    </div>
                </div>
            </div>
        </div>

         <script>
             $(document).ready(function () {
                 $(".ui.dropdown").dropdown({
                     fullTextSearch: true
                 });

                 $('.btnSearch').click(async function () {
                     /*      e.preventDefault();*/
                     var params = `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;

                     // Get the selected value of ddlBil
                     var year = $('#ddlyear').val();

                   /*  alert(year)*/

                     // Check if nobil is not empty or zero
                     if (year !== '0') {
                         // Redirect to CetakSuratPeringatan page with nobil as a query parameter
                         /* window.location.href = 'CetakSuratPeringatan.aspx?nobil=' + nobil;*/
                         window.open('<%=ResolveClientUrl("~/FORMS/GAJI/SLIP/reportPendapatanTahunan.aspx")%>?year=' + year, '_blank', params);
                     } else {
                         // Handle the case where nobil is empty or zero
                         alert('Please select a valid year');
                     }
                 });
             });
                                </script>
         
    </contenttemplate>
</asp:Content>