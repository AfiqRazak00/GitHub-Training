<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="LaporanPengumuran.aspx.vb" Inherits="SMKB_Web_Portal.LaporanPengumuran" %>



<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
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
                            <h5 class="modal-title" id="exampleModalCenterTitle">Laporan Pengumuran</h5>
                        </div>
            
                        <!-- Create the dropdown filter -->
                        <div class="search-filter">
                            <div class="form-row justify-content-center">
                                <div class="form-group row col-md-8">
                                    <label for="tahun" class="col-sm-4 col-form-label" style="text-align: right">Kod Vot :</label>
                                    <div class="col-sm-6">
                                         <select id="ddlVot" class="ui search dropdown" name="ddlVot"></select>
                                    </div>
                                </div>
                            </div>

                            <div class="form-row justify-content-center mt-4" id="btnSearchSection">
                                <asp:Button ID="btnSearch" runat="server" Text="Laporan" CssClass="btn btn-primary btnSearch" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </contenttemplate>
    <script>
        var shouldPop = true;
        $(document).ready(function () {
            $('#ddlVot').dropdown({
                selectOnKeydown: true,
                fullTextSearch: true,
                apiSettings: {
                    url: 'LejarPenghutangLaporanWS.asmx/GetKodVotList?q={query}', // URL to your web service
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    beforeSend: function (settings) {
                        // Replace {query} placeholder in data with user-entered search term
                        settings.data = JSON.stringify({ q: settings.urlData.query });
                        //searchQuery = settings.urlData.query;
                        return settings;
                    },
                    onSuccess: function (response) {
                        var data = JSON.parse(response.d);

                        // Now data is an array of objects, each containing a "vot" property

                        // Clear the dropdown menu
                        var obj = $('#ddlVot');
                        obj.html('');

                        // Add new options to dropdown
                        if (data.length === 0) {
                            obj.dropdown("clear");
                            return false;
                        }

                        // Loop through the data and add options to the dropdown
                        $.each(data, function (index, option) {
                            obj.append($('<option>').attr('value', option.vot).text(option.vot));
                        });

                        // Refresh dropdown
                        obj.dropdown('refresh');

                        if (shouldPop === true) {
                            $(obj).dropdown('show');
                        }
                    },
                    error: function (error) {
                        console.log(error);
                    }
                        
                }
            });
        });
        $('.btnSearch').click(async function () {
            var params = `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;
            var kodVot = $('#ddlVot').val();
            if (kodVot == '') {
                alert('Sila pilih Kod Vot dahulu');
                return;
            }
            window.open('<%=ResolveClientUrl("~/FORMS/AKAUN PENERIMA/Laporan/CetakLaporanPengumuran.aspx")%>?kodvot=' + kodVot, '_blank', params);
        });
</script>
</asp:Content>
