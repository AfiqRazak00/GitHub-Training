<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="JadualBayarBalik.aspx.vb" Inherits="SMKB_Web_Portal.JadualBayarBalik" %>

<asp:Content ID="FormContents" ContentPlaceHolderID="FormContents" runat="server">

    <style>
        .dropdown-list {
            width: 100%; /* You can adjust the width as needed */
        }

        .align-right {
            text-align: right;
        }

        .center-align {
            text-align: center;
        }

        .TableTransaksi {
            display: none;
        }

        #PermohonanTab {
            width: 100vw; /* 100% of the viewport width */
            height: 100vh; /* 100% of the viewport height */
        }
        .modal-content {
            width: 80%;
        }

    </style>
   
    <div id="PermohonanTab" class="tabcontent" style="display: block">
        <!-- Modal -->
        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Jadual Bayar Balik</h5>
                    </div>

                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-10">
                                <label for="tahun" class="col-sm-4 col-form-label" style="text-align: right">Carian :</label>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <div class="form-group input-group">
                                            <select class="input-group__select ui search dropdown" placeholder="" name="ddlSenaraiPinj" id="ddlSenaraiPinj">
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-row justify-content-center mt-4" id="btnSearchSection" style="">
                            <button id="btnSearch" class="btn btn-primary btnSearch" onclick="" type="button">Lihat Jadual Bayar Balik</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--Modal Alert--%>
    <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h6 class="modal-title">Sistem Maklumat Kewangan Bersepadu</h6>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="lblMessageModal"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>

    <script>

        $(document).ready(function () {
            /*generateDropdown("id", "path", "place holder", "flag send data to web services or either", "parent dropdown (dependable)","function after ajax success");*/
            generateDropdown("ddlSenaraiPinj", "BayarBalikWS.asmx/GetSenaraiPinjaman", "-- Sila Pilih --", false, null);
        });

        var shouldPop = true, searchQuery = "", oldSearchQuery = "";

        $("#btnSearch").off('click').on('click', async function () {
            var selectedValue = $('#ddlSenaraiPinj').val();
            var params = `scrollbars=no,resizable=no,status=no,location=no,toolbar=no,menubar=no,width=0,height=0,left=-1000,top=-1000`;
            if (isSet(selectedValue)) {
                //Dptkan data dari ws
                var data = await ajaxPost("BayarBalikWS.asmx/FetchData", { NoPinj: selectedValue }, false);
                if (data.Status) {
                    //data4cjbb = data for cetak jadual bayar balik
                    sessionStorage.setItem("data4cjbb", JSON.stringify(data.Payload));// simpan data di session storage
                    window.open('<%=ResolveClientUrl("~/FORMS/PINJAMAN/BAYAR BALIK/CetakJadualBayarBalik.aspx")%>', '_blank', params);
                }
            } else {
                $("#lblMessageModal").text("Sila buat pilihan bagi carian dibawah")
                $("#MessageModal").modal("toggle");
            }
        });

        function isSet(value) {
            if (value === null || value === '' || value === undefined) {
                return false;
            } else {
                return true;
            }
        }

        async function ajaxPost(url, postData, enableLoader, fn) {
            if (enableLoader) show_loader();

            var dtToString = JSON.stringify(postData);

            return new Promise((resolve, reject) => {
                $.ajax({
                    url: url,
                    method: "POST",
                    dataType: "json",
                    data: JSON.stringify({ postData: dtToString }),
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        result = JSON.parse(data.d);
                        if (fn !== null && fn !== undefined) {
                            fn(result);
                        }
                        if (enableLoader) close_loader();
                        resolve(result);
                    },
                    error: function (xhr, status, error) {
                        if (enableLoader) close_loader();
                        console.error("Error fetching details:" + error);
                        reject(false);
                    }
                });
            })
        }

        async function generateDropdown(id, url, plchldr, send2ws, sendData, fn) {

            var param = '';
            (sendData !== null && sendData !== undefined) ? param = '' : param = '?q={query}';

            $('#' + id).dropdown({
                fullTextSearch: true,
                placeholder: plchldr,
                apiSettings: {
                    url: url + param,
                    method: 'POST',
                    dataType: "json",
                    contentType: 'application/json; charset=utf-8',
                    cache: false,
                    //onChange: function (value, text, $selectedItem) {
                    //    if (fn !== null && fn !== undefined) {
                    //        return fn();
                    //    }
                    //},
                    beforeSend: function (settings) {
                        if (send2ws) {
                            settings.data = JSON.stringify({
                                q: settings.urlData.query,
                                data: $('#' + sendData).val()
                            });
                            searchQuery = settings.urlData.query;
                            return settings;
                        } else {
                            // Replace {query} placeholder in data with user-entered search term
                            settings.data = JSON.stringify({ q: settings.urlData.query });
                            searchQuery = settings.urlData.query;
                            return settings;
                        }
                    },
                    onSuccess: function (response) {
                        // Clear existing dropdown options
                        var obj = $(this);

                        var objItem = $(this).find('.menu');
                        $(objItem).html('');

                        // Add new options to dropdown
                        if (response.d.length === 0) {
                            $(obj.dropdown("clear"));
                            return false;
                        }

                        var listOptions = JSON.parse(response.d);

                        $.each(listOptions, function (index, option) {
                            $(objItem).append($('<div class="item" data-value="' + option.value + '">').html(option.text));
                        });

                        if (fn !== null && fn !== undefined) {
                            fn();
                        }

                        /*dependable ddl if sendata value == empty clear all option*/
                        if (sendData !== null && sendData !== undefined) {
                            var tempDt = $('#' + sendData).val();
                            if (tempDt == null && tempDt == undefined) {
                                $('#' + id + ' .dropdown').addClass("disableDdlIcon");
                                return false;
                            }
                        }

                        //if (searchQuery !== oldSearchQuery) {
                        //$(obj).dropdown('set selected', $(this).find('.menu .item').first().data('value'));
                        //}

                        //oldSearchQuery = searchQuery;

                        // Refresh dropdown
                        $(obj).dropdown('refresh');

                        if (shouldPop === true) {
                            $(obj).dropdown('show');
                        }
                    }
                }
            });
        }
    </script>
</asp:Content>
