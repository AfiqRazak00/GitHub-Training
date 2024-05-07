<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Penyediaan_Semakan_Bendahari.aspx.vb" Inherits="SMKB_Web_Portal.Penyediaan_Semakan_Bendahari" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <style>
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

        /*  #tblDataSenarai_trans td:hover {
            cursor: pointer;
        }*/


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
            font-size: 12PX;
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
            line-height: 10px;
            color: #01080D;
            opacity: 1;
        }
    </style>



    <div id="PermohonanTab" class="tabcontent" style="display: block">

        <!-- Modal -->
        <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Semakan Bajet</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal-body">
          <%--  <div class="table-title">
                <h5>Semakan Bajet</h5>
                <div class="btn btn-primary btnPapar" onclick="ShowPopup('2')">
                    Permohonan Pusat 
                </div>

            </div>--%>

            <hr>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-row">
                        <div class="form-group col-md-3">
                            <input class="input-group__input" id="lblTahun" type="text" placeholder="&nbsp;" name="Tahun" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="Tahun">Tahun</label>
                        </div>
                    <%--    <div class="form-group col-md-9">
                            <input class="input-group__input" id="lblPTJ" type="text" placeholder="&nbsp;" name="PTJ / PBU" readonly style="background-color: #f0f0f0" />
                            <label class="input-group__label" for="PTJ">PTJ / PBU</label>
                        </div>--%>
                                                <div class="form-group col-md-4">
                            <select class="input-group__select ui search dropdown ListKW" name="ddlKW" id="ddlKW" placeholder="&nbsp;">
                            </select>
                            <label class="input-group__label" for="ddlKW">Kumpulan Wang</label>
                        </div>
                        <div class="form-group col-md-4">
                            <select class="input-group__select ui search dropdown ListOperasi" name="ddlKO" id="ddlKO" placeholder="&nbsp;">
                            </select>
                            <label class="input-group__label" for="ddlKO">Kod Operasi</label>
                        </div>
                        <div class="input-group-append">
                            <button id="Button1" runat="server" class="btn btn-outline btnSearch" type="button" style="width: auto; height: auto">
                                <i class="fa fa-search"></i>
                                Cari
                            </button>
                        </div>

                    </div>
                </div>
          
                 <div class="modal-header">
                    <h6 class="modal-title">Peruntukan Objek Am</h6>

                </div>
                <div class="col-md-12" style=" padding-bottom: 30px;">
                    <div class="transaction-table table-responsive">
                        <table id="tblDataPerolehanDtl" class="table table-striped" style="width: 99%">
                            <thead>
                                <tr>
                                    <th scope="col">Id_Mohon_Dtl</th>
                                    <th scope="col">Bil</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <%--  <th scope="col">KO</th>
                                    <th scope="col">PTJ</th>
                                    <th scope="col">KP</th>
                                    <th scope="col">Vot</th>
                                    <th scope="col" class="text-right">Baki Peruntukan (RM)</th>
                                    <th scope="col">Barang / Perkara</th>
                                    <th scope="col">Kuantiti</th>
                                    <th scope="col">Ukuran</th>
                                    <th scope="col" class="text-right">Anggaran Harga Seunit (RM)</th>
                                    <th scope="col" class="text-right">Jumlah Anggaran Harga (RM)</th>--%>
                                    <th scope="col">Tindakan</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>


                        </table>

                    </div>
                </div>
               
                <div class="modal-header">
                    <h6 class="modal-title">Senarai Peruntukan Objek Sebagai</h6>

                </div>
                <div class="col-md-12">
                    <div class="transaction-table table-responsive">
                        <table id="tblDataPerolehanDtl_Sbg" class="table table-striped" style="width: 99%">
                            <thead>
                                <tr>
                                    <th scope="col">Id_Mohon_Dtl</th>
                                    <th scope="col">Bil</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                                    <th scope="col">KW</th>
                      
                                    <th scope="col">Tindakan</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>


                        </table>

                    </div>
                </div>
            </div>
        </div>
        <%--        <div class="sticky-footer">
            <br />
            <div class="form-row">
                <div class="form-group col-md-12">

                    <div class="float-right">
                        <button type="button" class="btn btn-setsemula btnSet">Rekod Baru</button>
                        <button type="button" class="btn btn-secondary btnSimpan" data-toggle="tooltip" data-placement="bottom" title="Simpan Draft">Simpan</button>
                        <button type="button" class="btn btn-success btnHantar" data-toggle="tooltip" data-placement="bottom" title="Simpan dan Hantar">Hantar</button>
                    </div>


                </div>
            </div>
        </div>--%>

        <!-- Modal Update tblDataPerolehanDtl        name id: updateTblPoDtl -->
        <div class="modal fade" id="updateTblPoDtl" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Maklumat Komitmen</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">


                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">

                                    <div class="form-group col-lg-2">
                                        <label>Kod PTj</label>
                                        <input type="text" class="form-control" placeholder="Kod PTj" id="txtPTJ" name="txtPTJ" readonly />
                                    </div>

                                    <div class="form-group col-lg-2">
                                        <label>Kumpulan Wang</label>
                                        <input type="text" class="form-control" placeholder="Kumpulan Wang" id="txtKW" name="txtKW" readonly />
                                    </div>

                                    <div class="form-group col-lg-2">
                                        <label>Kod Operasi</label>
                                        <input type="text" class="form-control" placeholder="Kod Operasi" id="txtKO" name="txtKO" readonly />
                                    </div>

                                    <div class="form-group col-lg-2">
                                        <label>Kod Projek</label>
                                        <input type="text" class="form-control" placeholder="Kod Projek" id="txtKP" name="txtKP" readonly />
                                    </div>

                                    <div class="form-group col-lg-2">
                                        <label>Objek Sebagai</label>
                                        <input type="text" class="form-control" placeholder="Objek Sebagai" id="txtObjSbg" name="txtObjSbg" readonly />
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label>Justifikasi</label>
                                        <textarea class="form-control" placeholder="Justifikasi" id="txtJustifikasi" name="txtJustifikasi"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-row">
                                    <div class="form-group col-md-6">
                                        <label>Komitmen (RM)</label>
                                        <input class="form-control" placeholder="Komitmen (RM)" id="txtKomitmen" name="txtKomitmen" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger btnReset" data-placement="bottom" title="Padam">Padam</button>
                        <!-- reset -->
                        <button type="button" class="btn btn-secondary btnKemaskini" data-placement="bottom" title="Simpan">Simpan</button>
                    </div>
                    <br />
                    <div class="modal-header">
                        <h5 class="modal-title">Senarai Komitmen</h5>

                    </div>
                    <div class="col-md-12">
                        <div class="transaction-table table-responsive">
                            <table id="tblSenaraiKomitmen_PTJ" class="table table-striped" style="width: 99%">
                                <thead>
                                    <tr>
                                        <th scope="col">Id_Mohon_Dtl</th>
                                        <th scope="col">Bil</th>
                                        <th scope="col">KW</th>
                                        <th scope="col">KW</th>
                                        <th scope="col">KW</th>
                                        <th scope="col">KW</th>
                                         <th scope="col">KW</th>
                                        <th scope="col">Tindakan</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>


                            </table>

                        </div>
                        <br />
                    </div>
                </div>
            </div>
        </div>

        <!-- Confirmation Modal  -->
        <div class="modal fade" id="confirmationModal" tabindex="-1" role="dialog"
            aria-labelledby="confirmationModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmationModalLabel">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Anda pasti ingin menyimpan rekod ini?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger"
                            data-dismiss="modal">
                            Tidak</button>
                        <button type="button" class="btn default-primary btnYa" runat="server">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Confirmation Modal Hantar  -->
        <div class="modal fade" id="confirmationModal_Hantar" tabindex="-1" role="dialog"
            aria-labelledby="confirmationModalLabelHantar" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="confirmationModalLabel_Hantar">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Anda pasti ingin menyimpan rekod ini?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger"
                            data-dismiss="modal">
                            Tidak</button>
                        <button id="EmailJurnal3" runat="server" type="button" class="btn default-primary btnYa_Hantar">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Makluman Modal Bil -->
        <div class="modal fade" id="maklumanModalBil" tabindex="-1" role="dialog"
            aria-labelledby="maklumanModalLabelBil" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="maklumanModalLabelBil">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <span id="detailMaklumanBil"></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn default-primary" id="tutupMaklumanBil"
                            data-dismiss="modal">
                            Tutup</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Makluman Modal Bil -->
        <div class="modal fade" id="maklumanModalBil_Hantar" tabindex="-1" role="dialog"
            aria-labelledby="maklumanModalLabelBil_Hantar" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="maklumanModalLabelBil_Hantar">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <span id="detailMaklumanBil_Hantar"></span>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn default-primary" id="tutupMaklumanBil_Hantar"
                            data-dismiss="modal">
                            Tutup</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Message Box -->
        <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Tolong Sahkan?</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Adakah anda pasti mahu menambah modul?
                               
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn btn-secondary" data-toggle="modal"
                            data-target="#ModulForm" data-dismiss="modal">
                            Ya</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Update Pengesahan-->
    <div class="modal fade" id="saveConfirmationModalUpdate3" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="saveConfirmationModalLabelUpdate3">Pengesahan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="confirmationMessageUpdate3"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                    <button type="button" class="btn btn-secondary" id="confirmSaveButtonUpdate3">Ya</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Update Result -->
    <div class="modal fade" id="resultModalUpdate3" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resultModalLabelUpdate3">Makluman</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="resultModalMessageUpdate3"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal Delete Pengesahan-->
    <div class="modal fade" id="saveConfirmationModalDelete3" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="saveConfirmationModalLabelDelete3">Pengesahan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="confirmationMessageDelete3"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                    <button type="button" class="btn btn-secondary" id="confirmSaveButtonDelete3">Ya</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal Delete Result -->
    <div class="modal fade" id="resultModalDelete3" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resultModalLabelDelete3">Makluman</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="resultModalMessageDelete3"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">


        function ShowPopup(elm) {

            if (elm == "1") {

                $('#permohonan').modal('toggle');

            }
            else if (elm == "2") {

                $(".modal-body div").val("");
                $('#permohonan').modal('toggle');

            }
        }

        $(document).ready(function () {
            //alert("a")
            //generateDropdown("ddlKW", "Pertengahan_Tahun_WS.asmx/GetListKW", null, false, null);
            //enerateDropdown("ddlKO", "Pertengahan_Tahun_WS.asmx/GetListKO", null, false, null);
            tbl2.clear().draw();
            getDateNow();
            getPTJ();

            /*generateDropdown("id", "path", "place holder", "flag send data to web services or either", "parent dropdown (dependable)","function after ajax success");*/
            //debugger

            //generateDropdown("ddlKP", "Awal_Tahun_WS.asmx/GetListKP", null, false, null);
            //generateDropdown("ddlDasar", "Awal_Tahun_WS.asmx/GetListDasar", null, true, null);
            //generateDropdown("ddlUnit", "Awal_Tahun_WS.asmx/GetListUnit", null, true, "ddlBahagian");
            //generateDropdown("ddlPTJPusat", "Awal_Tahun_WS.asmx/GetListPTJPusat", null, false, null);
        });

        //Dropdown KW (update modal)
        $('#ddlKW').dropdown({
            selectOnKeydown: true,
            fullTextSearch: true,
            apiSettings: {
                url: '<%= ResolveClientUrl("~/FORMS/BAJET/PERTENGAHAN TAHUN/Pertengahan_Tahun_WS.asmx/GetListKW?q={query}") %>',
                //url: 'PermohonanPoWs.asmx/GetUkuran?q={query}',
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
                        $(objItem).append($('<div class="item" data-value="' + option.value + '" data-text="' + option.text + '" >').html(option.text));
                    });

                    $('.item', objItem).on('click', function () {
                        ukuranValue = $(this).data('value'); // Store the value ('04')
                        ukuranText = $(this).data('text'); // Retrieve the text ('KM')
                    });

                    // Refresh dropdown
                    $(obj).dropdown('refresh');

                    //if (shouldPop === true) {
                    $(obj).dropdown('show');
                    //}
                }
            }
        });

        //Dropdown KW (update modal)
        $('#ddlKO').dropdown({
            selectOnKeydown: true,
            fullTextSearch: true,
            apiSettings: {
                url: '<%= ResolveClientUrl("~/FORMS/BAJET/PERTENGAHAN TAHUN/Pertengahan_Tahun_WS.asmx/GetListKO?q={query}") %>',
                //url: 'PermohonanPoWs.asmx/GetUkuran?q={query}',
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
                        $(objItem).append($('<div class="item" data-value="' + option.value + '" data-text="' + option.text + '" >').html(option.text));
                    });

                    $('.item', objItem).on('click', function () {
                        ukuranValue = $(this).data('value'); // Store the value ('04')
                        ukuranText = $(this).data('text'); // Retrieve the text ('KM')
                    });

                    // Refresh dropdown
                    $(obj).dropdown('refresh');

                    //if (shouldPop === true) {
                    $(obj).dropdown('show');
                    //}
                }
            }
        });
        //DataTable for Maklumat Bajet dan Spesifikasi
        var tbl = null;
        var isClicked = false;
        $(document).ready(function () {
            tbl = $("#tblDataPerolehanDtl").DataTable({
                "responsive": true,
                "searching": false,
                "info": false,
                "paging": false,
                "ordering": false,
                "sPaginationType": "full_numbers",
                "oLanguage": {
                    "oPaginate": {
                        "sNext": '<i class="fa fa-forward"></i>',
                        "sPrevious": '<i class="fa fa-backward"></i>',
                        "sFirst": '<i class="fa fa-step-backward"></i>',
                        "sLast": '<i class="fa fa-step-forward"></i>'
                    },
                    "sLengthMenu": "Tunjuk _MENU_ rekod",
                    "sZeroRecords": "Tiada rekod yang sepadan ditemui",
                    "sInfo": "Menunjukkan _END_ dari _TOTAL_ rekod",
                    "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },
                "ajax": {
                    "url": '<%= ResolveClientUrl("~/FORMS/BAJET/PERTENGAHAN TAHUN/Pertengahan_Tahun_WS.asmx/LoadOrderRecord_DataReviewPTJ_Bend") %>',
                    //"url": "PermohonanPoWS.asmx/LoadOrderRecord_PerolehanDtl",
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({
                            tahun: $('#lblTahun').val(),
                            //ptj: $('#lblPTJ').val().substring(0, 6),
                            isClicked: isClicked,
                            kw: $('#ddlKW').val(),
                            ko: $('#ddlKO').val()

                        })
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);

                        var data = JSON.parse(response.d);

                    }
                },



                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });
                },
                "columns": [
                    { "data": "KodVot", "title": "Id_Mohon_Dtl" }, //Hidden
                    { "data": "Butiran", "title": "Bil" }, // Empty column for index/bil
                    { "data": "KodVot", "title": "PERKARA" },
                    { "data": "Butiran", "title": "Butiran" },
                    {
                        "data": "Bajet_Asal",
                        "title": "PERUNTUKAN ASAL \n(A)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                   
                    {
                        "data": "Bajet_TK", "title": "PINDAAN TAMBAH KURANG \n(B)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_Viremen", "title": "PINDAAN PERUNTUKAN (C)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Jumlah_Peruntukan", "title": "PERUNTUKAN SELEPAS PINDAH PERUNTUKAN (D) = (A)+(B)+(C)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_Belanja", "title": "BELANJA SEBENAR (E1)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_PT", "title": "PT BELUM SELESAI (E2)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Jumlah_BAKI_PERUNTUKAN", "title": "BAKI PERUNTUKAN SEMASA (E3)=(D)-(E1)-(E2)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_Komitemen", "title": "KOMITMEN(E4)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA", "title": "BAKI PERUNTUKAN SEDIA ADA (E5)=(E4)-(E3)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right

                    },
                    {
                        "data": "Bajet_Lebihan_Peruntukan", "title": "LEBIHAN PERUNTUKAN",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_Pengurangan_Peruntukan", "title": "PENGURANGAN PERUNTUKAN",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    { "data": null, "title": "Papar Peruntukan" }
                ],
                "columnDefs": [
                    {
                        "targets": 0,
                        visible: false,
                        searchable: false
                    },
                    {
                        "targets": 1,
                        "data": null,
                        "render": function (data, type, row, meta) {
                            // Render the index/bil as row number
                            return meta.row + 1;
                        }
                    },
                    {
                        "targets": -1, // Target the last column (Delete column)                           
                        //data": "KodVot",
                        "render": function (data, type, row) {
                            //  console.log(data);
                            return `
                                <div class="row">
                                    <div class="col-md-2">
                                        <button type="button" class="btn editBtn" value="${data.KodVot}" data-toggle="tooltip" data-placement="top"  title="Papar" onclick="rowClickVotAm('${data.KodVot}')">
                                        <i class="far fa-edit fa-lg"></i>
                                        </button>
                                    </div>                                  
                                

                                </div>`;
                        }
                    }
                ]
            });


            // Event listener for Delete button on tblDataPerolehanDtl
            $("#tblDataPerolehanDtl").off('click', '.deleteBtn').on("click", ".deleteBtn", function (event) {
                var row = $(this).closest('tr');
                var dataTable = $('#tblDataPerolehanDtl').DataTable();

                id_mohon_dtl_hidden = dataTable.cell(row, 0).data(); //DELETE ROWS BASED ON THIS ID

                var msg = "Anda pasti ingin memadam rekod ini? (maklumat bajet dan spesifikasi)";
                $('#confirmationMessageDelete3').text(msg);
                $('#saveConfirmationModalDelete3').modal('show'); // Open the Bootstrap modal

                $('#confirmSaveButtonDelete3').off('click').on('click', async function () {
                    $('#saveConfirmationModalDelete3').modal('hide'); // Hide the modal                   
                    var result = JSON.parse(await ajaxdeleteKomitmen(id_mohon_dtl_hidden));
                    //alert("delete")
                    if (result.Status === "true") {
                        showModalDelete3("Success", result.Message, "true");
                    } else {
                        showModalDelete3("Error", result.Message, "error");
                    }
                    //Reload datatable
                    tbl.ajax.reload();
                    tbl2.ajax.reload();
                    tbl3.ajax.reload();
                });
            });



            // Event listener for Update & Edit button on tblDataPerolehanDtl
            $("#tblSenaraiKomitmen_PTJ").off('click', '.editBtnKomitmen').on("click", ".editBtnKomitmen", function (event) {
                //Get row id
                var row = $(this).closest('tr');
                var dataTable = $('#tblSenaraiKomitmen_PTJ').DataTable();

                id_mohon_dtl_hidden = dataTable.cell(row, 0).data(); //EDIT & UPDATE ROWS BASED ON THIS ID
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadPoDtlRowData") %>',
                    //url: "PermohonanPoWS.asmx/LoadPoDtlRowData",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ id: id_mohon_dtl_hidden }),
                    success: function (data) {
                        var jsonData = JSON.parse(data.d);

                        //Get the data from LoadPoDtlRowData and assign it's values
                      

                        $("#txtJustifikasi").val(jsonData[0].Justifikasi);
                        $("#txtKomitmen").val(jsonData[0].JumlahKomitmen);
                       
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                    }
                });

            });



            //Get butiran(Barang/Perkara) for display on spesifikasi teknikal modal
            $("#tblDataPerolehanDtl").on("click", ".modalSpekTeknikalBtn", function () {
                var row = $(this).closest('tr');
                var dataTable = $('#tblDataPerolehanDtl').DataTable();

                id_mohon_dtl_hidden = dataTable.cell(row, 0).data(); //Get the  value from the hidden column (first column)
                var barang_perkara = dataTable.cell(row, 8).data(); // Get the value from the 9th column

                console.log(id_mohon_dtl_hidden + "             " + barang_perkara);
                $('#spekTeknikalModal #butiran').val(barang_perkara);

                //Datatable Spesifikasi Teknikal Modal
                $(document).ready(function () {
                    tblModal = $('#tblSpekTeknikal').DataTable({
                        "responsive": true,
                        "searching": true,
                        "sPaginationType": "full_numbers",
                        "oLanguage": {
                            "oPaginate": {
                                "sNext": '<i class="fa fa-forward"></i>',
                                "sPrevious": '<i class="fa fa-backward"></i>',
                                "sFirst": '<i class="fa fa-step-backward"></i>',
                                "sLast": '<i class="fa fa-step-forward"></i>'
                            },
                            "sLengthMenu": "Tunjuk _MENU_ rekod",
                            "sZeroRecords": "Tiada rekod yang sepadan ditemui",
                            "sInfo": "Menunjukkan _END_ dari _TOTAL_ rekod",
                            "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                            "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                            "sEmptyTable": "Tiada rekod.",
                            "sSearch": "Carian"
                        },
                        "ajax": {
                            "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadOrderRecord_SpekTeknikal") %>',
                            //"url": "PermohonanPoWS.asmx/LoadOrderRecord_SpekTeknikal",
                            type: 'POST',
                            "contentType": "application/json; charset=utf-8",
                            "dataType": "json",
                            data: function (d) {
                                return JSON.stringify({
                                    id: $('#txtNoMohon').val(), //haha5
                                    hidden: id_mohon_dtl_hidden
                                })
                            },
                            "dataSrc": function (json) {
                                return JSON.parse(json.d);
                            }
                        },
                        "rowCallback": function (row, data) {
                            // Add hover effect
                            $(row).hover(function () {
                                $(this).addClass("hover pe-auto bg-warning");
                            }, function () {
                                $(this).removeClass("hover pe-auto bg-warning");
                            });
                        },
                        "columns": [
                            { "data": "Id_Teknikal", "title": "Id_Teknikal" }, //Hidden
                            { "data": "", "width": "10%", "title": "Bil" }, // Empty column for index/bil
                            { "data": "Butiran", "width": "60%", "title": "Spesifikasi Teknikal" },
                            { "data": "Wajaran", "width": "15%", "title": "Wajaran" },
                            { "data": null, "width": "15%", "title": "Tindakan" }
                        ],
                        "columnDefs": [
                            {
                                "targets": 0,
                                visible: false,
                                searchable: false
                            },
                            {
                                "targets": 1,
                                "data": null,
                                "render": function (data, type, row, meta) {
                                    // Render the index/bil as row number
                                    return meta.row + 1;
                                }
                            },
                            {
                                "targets": 4, // Target the last column (Delete column)
                                "data": null,
                                "render": function (data, type, row) {
                                    return `
                                <div class="row">
                                    <div class="col-md-2">
                                        <button type="button" class="btn editBtn2" style="padding:0px 0px 0px 0px" title="Kemaskini"><i class="far fa-edit fa-lg"></i></button>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="button" class= "btn deleteBtn2" style="padding:0px 0px 0px 0px" title="Padam"><i class="far fa-trash-alt fa-lg"></i></button>
                                    </div>
                                </div>`;
                                }
                            }
                        ],
                        "autoWidth": false
                    });
                    // Event listener for Delete button on tblSpekTeknikal
                    $('#tblSpekTeknikal').off('click').on("click", ".deleteBtn2", function () {
                        var row = $(this).closest("tr");
                        var dataTable = $('#tblSpekTeknikal').DataTable();

                        id_teknikal_hidden = dataTable.cell(row, 0).data(); //DELETE ROWS BASED ON THIS ID
                        console.log(id_teknikal_hidden);

                        var msg = "Anda pasti ingin memadam rekod ini? (Maklumat Spesifikasi Teknikal)";
                        $('#confirmationMessageDeleteSpekTek3').text(msg);
                        $('#saveConfirmationModalDeleteSpekTek3').modal('show'); // Open the Bootstrap modal

                        $('#confirmSaveButtonDeleteSpekTek3').off('click').on('click', async function () {
                            $('#saveConfirmationModalDeleteSpekTek3').modal('hide'); // Hide the modal
                            var result = JSON.parse(await ajaxdeletePoSpekTeknikal(id_teknikal_hidden));
                            if (result.Status === "success") {
                                showModalDeleteSpekTek3("Success", result.Message, "success");
                            } else {
                                showModalDeleteSpekTek3("Error", result.Message, "error");
                            }
                            tblModal.ajax.reload(); //Reload datatable
                        });
                    });
                    async function ajaxdeletePoSpekTeknikal(id_teknikal_hidden) {

                        return new Promise((resolve, reject) => {
                            $.ajax({
                                type: "POST",
                                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/DeletePoSpekTeknikal") %>',
                                //url: "PermohonanPoWS.asmx/DeletePoSpekTeknikal",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: JSON.stringify({ id: id_teknikal_hidden }),
                                success: function (data) {
                                    resolve(data.d);
                                },
                                error: function (error) {
                                    console.log("Error: " + error);
                                    reject(false);
                                }
                            });
                        })
                        console.log("tst")
                    }
                    function showModalDeleteSpekTek3(title, message, type) {
                        $('#resultModalTitleDeleteSpekTek3').text(title);
                        $('#resultModalMessageDeleteSpekTek3').text(message);
                        if (type === "success") {
                            $('#resultModalDeleteSpekTek3').removeClass("modal-error").addClass("modal-success");
                        } else if (type === "error") {
                            $('#resultModalDeleteSpekTek3').removeClass("modal-success").addClass("modal-error");
                        }
                        $('#resultModalDeleteSpekTek3').modal('show');
                    }


                    // Event listener for Update & Edit button on tblSpekTeknikal
                    $("#tblSpekTeknikal").off('click', '.editBtn2').on("click", ".editBtn2", function (event) {
                        // Hide the "Tambah" button
                        $(".btnTambah2").hide();
                        // Display both "Undo" and "Kemaskini" buttons
                        $(".btnUndo2").show();
                        $(".btnKemaskini2").show();

                        //Get row id
                        var row = $(this).closest('tr');
                        var dataTable = $('#tblSpekTeknikal').DataTable();

                        id_teknikal_hidden = dataTable.cell(row, 0).data(); //EDIT & UPDATE ROWS BASED ON THIS ID
                        $.ajax({
                            type: "POST",
                            url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadSpekTekRowData") %>',
                            //url: "PermohonanPoWS.asmx/LoadSpekTekRowData",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: JSON.stringify({ id: id_teknikal_hidden }),
                            success: function (data) {
                                var jsonData = JSON.parse(data.d);

                                //Get the data from LoadSpekTekRowData and assign it's values
                                $("#spesifikasi").val(jsonData[0].Butiran);
                                $("#wajaran").val(jsonData[0].Wajaran);
                            },
                            error: function (error) {
                                console.log("Error: " + error);
                            }
                        });

                    });


                });
            });
        });



        async function generateDropdown(id, url, plchldr, send2ws, sendData, fn) {
            //console.log("a")
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

        //Display PTj
        $(document).ready(function () {
            var ssusrKodPTj = '<%= Session("ssusrKodPTj") %>';
            $.ajax({
                type: "POST",
                url: '<%= ResolveClientUrl("~/FORMS/BAJET/PERTENGAHAN TAHUN/Pertengahan_Tahun_WS.asmx/GetPTj") %>',
                //url: "PermohonanPoWS.asmx/GetPTjPO",
                data: JSON.stringify({ ssusrKodPTj: ssusrKodPTj }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // Parse the JSON data
                    var jsonData = JSON.parse(data.d);
                    $("#lblPTJ").val(jsonData[0].text);
                },
                error: function (error) {
                    console.log("Error: " + error);
                }
            });
        });

        //Display PTj
        $(document).ready(function () {
            $.ajax({
                type: "POST",
                url: '<%= ResolveClientUrl("~/FORMS/BAJET/PERTENGAHAN TAHUN/Pertengahan_Tahun_WS.asmx/LoadDateNow") %>',
                //url: "PermohonanPoWS.asmx/GetPTjPO",
                //data: JSON.stringify({ ssusrKodPTj: ssusrKodPTj }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    // Parse the JSON data
                    var jsonData = JSON.parse(data.d);
                    $("#lblTahun").val(jsonData[0].text);
                },
                error: function (error) {
                    console.log("Error: " + error);
                }
            });
        });

        // add clickable event in DataTable row
        async function rowClickVotAm(kodVotam, PTJ) {



            tbl2 = null
            $('#tblDataPerolehanDtl_Sbg').DataTable().destroy();

            tbl2 = $("#tblDataPerolehanDtl_Sbg").DataTable({
                "responsive": true,
                "searching": false,
                "info": false,
                "paging": false,
                "ordering": false,
                "sPaginationType": "full_numbers",
                "oLanguage": {
                    "oPaginate": {
                        "sNext": '<i class="fa fa-forward"></i>',
                        "sPrevious": '<i class="fa fa-backward"></i>',
                        "sFirst": '<i class="fa fa-step-backward"></i>',
                        "sLast": '<i class="fa fa-step-forward"></i>'
                    },
                    "sLengthMenu": "Tunjuk _MENU_ rekod",
                    "sZeroRecords": "Tiada rekod yang sepadan ditemui",
                    "sInfo": "Menunjukkan _END_ dari _TOTAL_ rekod",
                    "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },
                "ajax": {
                    "url": '<%= ResolveClientUrl("~/FORMS/BAJET/PERTENGAHAN TAHUN/Pertengahan_Tahun_WS.asmx/LoadOrderRecord_DataReviewPTJ_Sbg") %>',
                    //"url": "PermohonanPoWS.asmx/LoadOrderRecord_PerolehanDtl",
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({
                            tahun: $('#lblTahun').val(),
                            kodVotam: kodVotam,
                            ptj: $('#lblPTJ').val().substring(0, 6),
                            kw: $('#ddlKW').val(),
                            ko: $('#ddlKO').val()
                        })
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);

                        var data = JSON.parse(response.d);

                    }
                },



                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });
                },
                "columns": [
                    { "data": "KodVot", "title": "Id_Mohon_Dtl" }, //Hidden
                    { "data": "Butiran", "title": "Bil" }, // Empty column for index/bil
                    { "data": "KodVot", "title": "PERKARA" },
                    { "data": "Butiran", "title": "Butiran" },
                    {
                        "data": "Bajet_Asal", "title": "PERUNTUKAN ASAL \n(A)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_TK", "title": "PINDAAN TAMBAH KURANG \n(B)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_Viremen", "title": "PINDAAN PERUNTUKAN (C)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Jumlah_Peruntukan", "title": "PERUNTUKAN SELEPAS PINDAH PERUNTUKAN (D) = (A)+(B)+(C)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_Belanja", "title": "BELANJA SEBENAR (E1)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_PT", "title": "PT BELUM SELESAI (E2)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Jumlah_BAKI_PERUNTUKAN", "title": "BAKI PERUNTUKAN SEMASA (E3)=(D)-(E1)-(E2)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_Komitemen", "title": "KOMITMEN(E4)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Jumlah_BAKI_PERUNTUKAN_SEDIA_ADA", "title": "BAKI PERUNTUKAN SEDIA ADA (E5)=(E4)-(E3)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_Lebihan_Peruntukan", "title": "LEBIHAN PERUNTUKAN",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    {
                        "data": "Bajet_Pengurangan_Peruntukan", "title": "PENGURANGAN PERUNTUKAN",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    { "data": null, "title": "Papar Peruntukan" }
                ],
                "columnDefs": [
                    {
                        "targets": 0,
                        visible: false,
                        searchable: false
                    },
                    {
                        "targets": 1,
                        "data": null,
                        "render": function (data, type, row, meta) {
                            // Render the index/bil as row number
                            return meta.row + 1;
                        }
                    },
                    {
                        "targets": -1, // Target the last column (Delete column)                           
                        "data": "KodVot",
                        "render": function (data, type, row) {
                            //console.log(data);
                            return `
                                <div class="row">
                                    <div class="col-md-2">
                                        <button type="button" class="btn editBtn" style="padding:0px 0px 0px 0px" title="Kemaskini" data-toggle="modal" data-target="#updateTblPoDtl" onclick="rowClickVot_Komitmen('${data.KodVot}')">
                                        <i class="far fa-edit fa-lg"></i>
                                        </button>
                                    </div>                                  
                                

                                </div>`;
                        }
                    }
                ]
            });


        }

        async function rowClickVot_Komitmen(kodVotSbg) {
            //alert("k" + kodVotam)
            $("#txtObjSbg").val(kodVotSbg)
            $("#txtPTJ").val($('#lblPTJ').val().substring(0, 6))
            $("#txtKW").val($('#ddlKW').val())
            $("#txtKO").val($('#ddlKO').val())
            $("#txtKP").val("0000000")


            tbl3 = null
            $('#tblSenaraiKomitmen_PTJ').DataTable().destroy();
            //alert("A")/8
            tbl3 = $("#tblSenaraiKomitmen_PTJ").DataTable({
                "responsive": true,
                "searching": false,
                "info": false,
                "paging": false,
                "ordering": false,
                "sPaginationType": "full_numbers",
                "oLanguage": {
                    "oPaginate": {
                        "sNext": '<i class="fa fa-forward"></i>',
                        "sPrevious": '<i class="fa fa-backward"></i>',
                        "sFirst": '<i class="fa fa-step-backward"></i>',
                        "sLast": '<i class="fa fa-step-forward"></i>'
                    },
                    "sLengthMenu": "Tunjuk _MENU_ rekod",
                    "sZeroRecords": "Tiada rekod yang sepadan ditemui",
                    "sInfo": "Menunjukkan _END_ dari _TOTAL_ rekod",
                    "sInfoEmpty": "Menunjukkan 0 ke 0 dari rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },
                "ajax": {
                    "url": '<%= ResolveClientUrl("~/FORMS/BAJET/PERTENGAHAN TAHUN/Pertengahan_Tahun_WS.asmx/LoadOrderRecord_Komitmen_Sbg") %>',
                    //"url": "PermohonanPoWS.asmx/LoadOrderRecord_PerolehanDtl",
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({
                            tahun: $('#lblTahun').val(),
                            kodVotSbg: kodVotSbg,
                            PTJ: $('#lblPTJ').val().substring(0, 6),
                            KW: $('#ddlKW').val(),
                            KO: $('#ddlKO').val()
                        })
                    },
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);

                        var data = JSON.parse(response.d);

                    }
                },



                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });
                },
                "columns": [
                    { "data": "id", "title": "id_hidden" },
                    { "data": "KodKW", "title": "Bil" },
                    { "data": "KodKW", "title": "KW" },
                    { "data": "KodKO", "title": "KO" },
                    { "data": "KodVot", "title": "Vot" },
                    { "data": "Justifikasi", "title": "Justifikasi" },
                    {
                        "data": "JumlahKomitmen", "title": "Jumlah Komitmen (RM)",
                        "render": function (data) {
                            return parseFloat(data).toLocaleString('en-US', { valute: 'USD', minimumFractionDigits: 2 });
                        }, "className": "text-right" // Add this line to align the content to the right
                    },
                    { "data": null, "title": "Papar Peruntukan" }
                ],
                "columnDefs": [
                    {
                        "targets": 0,
                        visible: false,
                        searchable: false
                    },
                    {
                        "targets": 1,
                        "data": null,
                        "render": function (data, type, row, meta) {
                            // Render the index/bil as row number
                            return meta.row + 1;
                        }
                    },
                    {
                        "targets": -1, // Target the last column (Delete column)                           

                        "data": "JumlahKomitmen",
                        "render": function (data, type, row) {
                            //console.log(data);
                            return `
                                <div class="row">
                                    <div class="col-md-2">
                                        <button type="button" class="btn editBtnKomitmen" style="padding:0px 0px 0px 0px" title="Kemaskini" data-toggle="modal" data-target="#updateTblPoDtl" onclick="rowClickVot_Komitmen('${data.JumlahKomitmen}')">
                                        <i class="far fa-edit fa-lg"></i>
                                        </button>
                                    </div>

  <div class="col-md-2">
                                        <button type="button" class= "btn deleteBtn" style="padding:0px 0px 0px 0px" title="Padam">
                                        <i class="far fa-trash-alt fa-lg"></i>
                                        </button>
                                    </div>
                                </div>`;
                        }
                    }
                ]
            });


        }
        // Event listener for Delete button on tblSenaraiKomitmen_PTJ
        $("#tblSenaraiKomitmen_PTJ").off('click', '.deleteBtn').on("click", ".deleteBtn", function (event) {
            var row = $(this).closest('tr');
            var dataTable = $('#tblSenaraiKomitmen_PTJ').DataTable();

            id_mohon_dtl_hidden = dataTable.cell(row, 0).data(); //DELETE ROWS BASED ON THIS ID

            var msg = "Anda pasti ingin memadam rekod ini?";
            $('#confirmationMessageDelete3').text(msg);
            $('#saveConfirmationModalDelete3').modal('show'); // Open the Bootstrap modal
           // alert(id_mohon_dtl_hidden)
            $('#confirmSaveButtonDelete3').off('click').on('click', async function () {
                $('#saveConfirmationModalDelete3').modal('hide'); // Hide the modal
                var result = JSON.parse(await ajaxdeleteKomitmen(id_mohon_dtl_hidden));
                if (result.Status === "true") {
                    showModalDelete3("Success", result.Message, "true");
                } else {
                    showModalDelete3("Error", result.Message, "error");
                }
                tbl.ajax.reload(); //Reload datatable
                tbl2.ajax.reload();
                tbl3.ajax.reload();
            });
        });
        //Insert data with bootstrap modal
        $('.btnKemaskini').off('click').on('click', async function () {
            var jumRecord = 0;
            var acceptedRecord = 0;
            var msg = "";

            // Remove commas from the input value 
            var txtPTJ = $('#txtPTJ').val().replace(/,/g, '');
            var txtKW = $('#txtKW').val().replace(/,/g, '');
            var txtKO = $('#txtKO').val().replace(/,/g, '');
            var txtObjSbg = $('#txtObjSbg').val().replace(/,/g, '');
            var txtJustifikasi = $('#txtJustifikasi').val().replace(/,/g, '');
            var txtKomitmen = $('#txtKomitmen').val().replace(/,/g, '');

            // Set message in the modal
            var msg = "Anda pasti ingin mengemaskini rekod ini?";
            $('#confirmationMessageUpdate3').text(msg);
            // Open the Bootstrap modal
            $('#saveConfirmationModalUpdate3').modal('show');

            $('#confirmSaveButtonUpdate3').off('click').on('click', async function () {
                $('#saveConfirmationModalUpdate3').modal('hide'); // Hide the modal


                var newPermohonanPoDtl = {
                    mohonDetails: {
                        tahun: $('#lblTahun').val(),
                        PTJ: $('#lblPTJ').val().substring(0, 6),
                        KW: $('#ddlKW').val(),
                        KO: $('#ddlKO').val(),
                        ObjSbg: txtObjSbg,
                        Justifikasi: txtJustifikasi,
                        Komitmen: txtKomitmen
                    }
                }

                var result = JSON.parse(await ajax_Komitmen(newPermohonanPoDtl));
                //alert(result.Message)
                if (result.Status === "true") {
                    showModalUpdate3("Success", result.Message, "true");
                } else {
                    showModalUpdate3("Error", result.Message, "error");
                }

                $('#txtJustifikasi').val("")
                $('#txtKomitmen').val("")

                tbl.ajax.reload(); //Reload datatable
                tbl2.ajax.reload();
                tbl3.ajax.reload();
            });
        });




        function showModalDelete3(title, message, type) {
            $('#resultModalTitleDelete3').text(title);
            $('#resultModalMessageDelete3').text(message);
            if (type === "success") {
                $('#resultModalDelete3').removeClass("modal-error").addClass("modal-success");
            } else if (type === "error") {
                $('#resultModalDelete3').removeClass("modal-success").addClass("modal-error");
            }
            $('#resultModalDelete3').modal('show');
        }
        function showModalUpdate3(title, message, type) {
            $('#resultModalTitleUpdate3').text(title);
            $('#resultModalMessageUpdate3').text(message);
            if (type === "success") {
                $('#resultModalUpdate3').removeClass("modal-error").addClass("modal-success");
            } else if (type === "error") {
                $('#resultModalUpdate3').removeClass("modal-success").addClass("modal-error");
            }
            $('#resultModalUpdate3').modal('show');
        }
        async function ajax_Komitmen(mohonDetails) {
            //console.log(mohonPoDetail)
            //console.log("a")
            return new Promise((resolve, reject) => {

                $.ajax({
                    "url": '<%= ResolveClientUrl("~/FORMS/BAJET/PERTENGAHAN TAHUN/Pertengahan_Tahun_WS.asmx/SaveKomitmen_PTJ") %>',
                    //url: 'PermohonanPoWS.asmx/UpdatePO_BajetSpesifikasi',
                    method: 'POST',
                    data: JSON.stringify(mohonDetails),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            })
            //clear after save


        }

        async function ajaxdeleteKomitmen(id_mohon_dtl_hidden) {
            //alert("abc " + id_mohon_dtl_hidden)
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: "POST",
                    url: '<%= ResolveClientUrl("~/FORMS/BAJET/PERTENGAHAN TAHUN/Pertengahan_Tahun_WS.asmx/DeleteKomitmen_PTJ") %>',
                    //url: "PermohonanPoWS.asmx/DeletePoDtl",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({ id: id_mohon_dtl_hidden }),
                    success: function (data) {
                        resolve(data.d);
                    },
                    error: function (error) {
                        console.log("Error: " + error);
                        reject(false);
                    }
                });


            })

            //console.log("tst")
        }

        $('.btnSearch').click(async function () {

            load_loader();
            //alert("a")
            isClicked = true;
            tbl.ajax.reload();
            tbl2.clear().draw();
            tbl3.clear().draw();

            close_loader();
        })

    </script>

</asp:Content>
