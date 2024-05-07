<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="KPT.aspx.vb" Inherits="SMKB_Web_Portal.KPT" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.7/css/jquery.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/rowreorder/1.4.1/css/rowReorder.dataTables.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.5.0/css/responsive.dataTables.min.css">
    <style>
        .modal-header--sticky {
            position: sticky;
            top: 0;
            background-color: inherit;
            z-index: 9999;
        }

        .modal-footer--sticky {
            position: sticky;
            bottom: 0;
            background-color: inherit;
            z-index: 9999;
        }

        .custom-table > tbody > tr:hover {
            background-color: #ffc83d !important;
        }

        #tblDataSenarai_permohonan td:hover {
            cursor: pointer;
        }





        .dropdown-list {
            width: 100%;
            /* You can adjust the width as needed */
        }

        .child-container {
            display: block; /* Initially visible */
        }
    </style>

    <div id="PermohonanTab" class="tabcontent" style="display: block">

        <!-- Modal -->
        <div id="permohonan">
            <div>
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Permohonan Perolehan</h5>

                    </div>

                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
                                <div class="col-sm-8">
                                    <div class="form-group ">
                                        <input readonly class="input-group__input form-control " id="txtTahun2" type="text" placeholder="&nbsp;" name="tahun" />
                                        <label class="input-group__label" for="masa">tahun</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class=" -body">
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table id="tblDataSenarai_permohonan" class="table table-striped" style="width: 95%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">No Mesyuarat</th>
                                            <th scope="col">Tempat</th>
                                            <th scope="col">Tarikh Mesyuarat</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>

                                </table>

                            </div>

                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- Modal -->

        <div class="modal fade" id="senaraiHargaModal" data-backdrop="static" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title">Senarai Sebut Harga / Tender Universiti </h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <div class="form-row">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <%--<table style=" width: 100%"  class="table table-striped" id="" >
                                                    <thead>
                                                        <tr>
                                                            <th scope="col">Bil</th>
                                                            <th scope="col">No Perolehan</th>
                                                            <th scope="col">Tujuan</th>
                                                            <th scope="col">Kategori</th>
                                                            <th scope="col">PTj</th>
                                                            <th scope="col">Status</th>
                                                            <th scope="col"></th>

                                                        </tr>
                                                    </thead>
                                                   <tbody >
                                                       <tr  class="table-list">
                                                           <td style="width: 5%">
                                                                1                 
                                                           </td>
                                                           <td style="width: 10%">
                                                                DS4300000000021123
                                                           </td>
                                                           <td style="width: 35%">
                                                                VERSION 2 - QUOTATION TO SUPPLY, DELIVER, INSTALL, TESTING, CONFIGURE, PROGRAMMED,INTEGRATE, COMMISSIONING, MAKE GOOD UPON COMPLETION AND PROPER HAND-OVER THE AS-MENTION-BELOW EQUIPMENTS TO BE PLACED IN THE RESPECTIVE DESIGNATED AREA, OFFICE AND/OR LABORATORY OF UTEM ICT INFRASTRUCTURE AS PER UNIVERSITI TEKNIKAL MALAYSIA MELAKA (UTEM) REQUIREMENTS.
                                                           </td>
                                                           <td style="width: 10%">
                                                               Bekalan
                                                           </td>
                                                           <td style="width: 20%">
                                                                PEJABAT KETUA PEGAWAI MAKLUMAT  
                                                           </td>
                                                           <td style="width: 15%">
                                                                LULUS PENENTUAN TEKNIKAL
                                                           </td>
                                                           <td style="width: 5%" >
                                                               <i onclick="ShowPopup(2)" class="fa fa-ellipsis-h fa-lg"></i>
                                                           </td>

                                                       </tr>
                                                   </tbody>
   
                                                </table>--%>
                                    <table style="width: 100%" class="table table-striped" id="tblDataPerolehan_MesyuaratDt">
                                        <thead>
                                            <tr>
                                                <th scope="col">Bil</th>
                                                <th scope="col">No Perolehan</th>
                                                <th scope="col">Tujuan</th>
                                                <th scope="col">Kategori</th>
                                                <th scope="col">PTj</th>
                                                <th scope="col">Status</th>

                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>

                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="modal fade" id="maklumatPermohonanModal" data-backdrop="static" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-xl" role="document">
                <div class="modal-content">
                    <div class="modal-header modal-header--sticky">
                        <h5 class="modal-title">Ringkasan Maklumat Permohonan Perolehan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <input class="input-group__input " id="txtNo_Permohonan" type="text" placeholder="&nbsp;" name="No Permohonan" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="No Permohonan">No Permohonan:	</label>
                                </div>

                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <input class="input-group__input " id="txtTarikh_Mohon" type="text" placeholder="&nbsp;" name="Tarikh Mohon" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="Tarikh Mohon">Tarikh Mohon:</label>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <input class="input-group__input " id="txtNo_Perolehan" type="text" placeholder="&nbsp;" name="No Perolehan" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="No Perolehan">No Perolehan :	</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">

                            <div class="col-md-12">
                                <div class=" form-group">
                                    <textarea class="input-group__input" id="txtTujuan" readonly style="background-color: #f0f0f0; height: auto" rows="4"></textarea>
                                    <label class="input-group__label" for="Tujuan">Tujuan :</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="col-md-12">
                                <div class=" form-group">
                                    <textarea class="input-group__input" id="txtSkop" readonly style="background-color: #f0f0f0; height: auto" rows="4"></textarea>
                                    <label class="input-group__label" for="Skop">Skop :</label>
                                </div>
                            </div>
                        </div>
                        <div class="form-row">

                            <div class="col-md-5">

                                <div class="form-group">
                                    <input class="input-group__input " id="txtPemohon" type="text" placeholder="&nbsp;" name="Pemohon" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="Pemohon">Pemohon :</label>
                                </div>

                            </div>
                            <div class="col-md-7">
                                <div class="form-group">
                                    <input class="input-group__input " id="txtPTJ" type="text" placeholder="&nbsp;" name="PTJ" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="PTJ">PTJ :</label>
                                </div>

                            </div>
                        </div>

                        <div class="form-row">

                            <div class="col-md-3">
                                <div class="form-group">
                                    <input class="input-group__input " id="txtKategori_Perolehan" type="text" placeholder="&nbsp;" name="Kategori Perolehan" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="Kategori Perolehan">Kategori Perolehan :</label>
                                </div>

                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <input class="input-group__input " id="txtKaedah_Perolehan" type="text" placeholder="&nbsp;" name="Kaedah Perolehan" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="Kaedah Perolehan">Kaedah Perolehan :	</label>
                                </div>

                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <input class="input-group__input " id="txtTarikh_Keperluan" type="text" placeholder="&nbsp;" name="Tarikh Keperluan" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="Tarikh Keperluan">Tarikh Keperluan :</label>
                                </div>

                            </div>
                            <div class="col-md-3">

                                <div class="form-group">
                                    <input class="input-group__input " id="txtRekod_Keperluan" type="text" placeholder="&nbsp;" name="Rekod Keperluan" readonly style="background-color: #f0f0f0" />
                                    <label class="input-group__label" for="Rekod Keperluan">Rekod Keperluan Terdahulu (RM) :</label>
                                </div>

                            </div>
                        </div>
                        <div class="form-row">

                            <div class="col-md-12">
                                <div class=" form-group">
                                    <textarea class="input-group__input" id="txtJustifikasi_Perolehan" readonly style="background-color: #f0f0f0; height: auto" rows="4"></textarea>
                                    <label class="input-group__label" for="Justifikasi Perolehan">Justifikasi Perolehan :</label>
                                </div>
                            </div>

                        </div>


                        <h6 class="m-3">Butiran Perolehan</h6>
                        <div class="col-md-12">
                            <div class="transaction-table table-responsive">
                                <table style="width: 100%" id="tblDataButiran_Perolehan" class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th class="text-center" scope="col">Bil</th>
                                            <th class="text-center" scope="col">KW</th>
                                            <th class="text-center" scope="col">KO</th>
                                            <th class="text-center" scope="col">PTJ</th>
                                            <th class="text-center" scope="col">Vot</th>
                                            <th class="text-center" scope="col">Barang / Perkara</th>
                                            <th class="text-center" scope="col">Kuantiti</th>
                                            <th class="text-center" scope="col">Ukuran</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>

                            </div>
                        </div>


                        <h6 class="m-3">Lampiran</h6>
                        <div class="col-md-12">
                            <%--<div class="secondaryContainer transaction-table table-responsive">
                                                 <table style=" width: 100%" id="tblDataLampiran"  class="table table-striped">
                                                     <thead>
                                                         <tr>
                                                             <th class="text-center" scope="col">Bil</th>
                                                             <th class="text-center" scope="col">Nama File</th>
                                                             <th class="text-center" scope="col"></th>
                                                            
                                                         </tr>
                                                     </thead>
                                                     <tbody >
                                


                                                     </tbody>
                                                 </table>

                                             </div>--%>
                            <div class="transaction-table table-responsive">
                                <table id="tblSimpanUpload" class="table table-striped" style="width: 99%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Bil</th>
                                            <th scope="col">Nama Fail</th>
                                            <th scope="col">Tindakan</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="form-row mt-3">

                            <div class="col-md-6">

                                <div class="form-group row">
                                    <div class="col-md-3">
                                        <h6>Spesifikasi :</h6>
                                    </div>
                                    <div class="col-md-9">
                                        <span class="badge badge-info p-2 m-1 lihat-spek-am" style="border-radius: 5px; cursor: pointer">
                                            <i class="fa fa-file" style="font-size: 14px"></i>
                                            <label style="margin-left: 5px; margin-bottom: 0px; font-size: 14px; cursor: pointer">Lihat Spesifikasi Am</label>
                                        </span>

                                        <span class="badge badge-info p-2 m-1 lihat-spek-teknikal" style="border-radius: 5px; cursor: pointer">
                                            <i class="fa fa-file" style="font-size: 14px"></i>
                                            <label style="margin-left: 5px; margin-bottom: 0px; font-size: 14px; cursor: pointer">Lihat Spesifikasi Teknikal</label>
                                        </span>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-6">
                                <div class="form-group row">
                                    <div class="col-md-3">
                                        <h6>Keputusan Mesyuarat :</h6>
                                    </div>

                                    <div class="col-md-9">
                                        <div class="form-check form-check-inline">
                                            <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" value="31">
                                            <label class="form-check-label" for="flexRadioDefault1">
                                                Lulus
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2">
                                            <label class="form-check-label" for="flexRadioDefault2">
                                                Lulus Dengan Pindaan
                                            </label>
                                        </div>
                                        <div class="child-container" style="display: none; margin-left: 15px;">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="RadioDefault" id="RadioDefault1" value="29">
                                                <label class="form-check-label" for="RadioDefault1">
                                                    Perlu Semakan Jawatankuasa
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="RadioDefault" id="RadioDefault2" value="30">
                                                <label class="form-check-label" for="RadioDefault2">
                                                    Tidak Perlu Semakan Jawatankuasa
                                                </label>
                                            </div>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault3" value="32">
                                            <label class="form-check-label" for="flexRadioDefault3">
                                                Batal
                                            </label>
                                        </div>
                                    </div>
                                </div>


                            </div>

                        </div>
                        <div class="form-row">

                            <div class="col-md-12">
                                <div class=" form-group">
                                    <textarea class="input-group__input" id="txtUlasan" style="background-color: #fff; height: auto" rows="3"></textarea>
                                    <label class="input-group__label" for="Ulasan">Ulasan :</label>
                                </div>
                            </div>
                        </div>
                        <div class="col text-center m-3">
                            <button type="button" id="btnSimpanHantar" class="btn btn-secondary " data-toggle="tooltip" data-placement="bottom" title="Draft">Hantar</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Modal Pengesahan-->

    <div class="modal fade" id="saveConfirmationModal10" tabindex="-1" role="dialog" aria-labelledby="saveConfirmationModalLabel" aria-hidden="true">
        <div class="modal-dialog " role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="saveConfirmationModalLabel10">Hantar Permohonan</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="confirmationMessage10"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tidak</button>
                    <button type="button" class="btn btn-secondary" id="confirmSaveButton10">Ya</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Result Lulus -->
    <div class="modal fade" id="resultModal10" tabindex="-1" role="dialog" aria-labelledby="resultModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="resultModalLabel10">Makluman</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p id="resultModalMessage10"></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.datatables.net/rowreorder/1.4.1/js/dataTables.rowReorder.min.js"></script>
    <script src="https://cdn.datatables.net/responsive/2.5.0/js/dataTables.responsive.min.js"></script>

    <%--Function to check if all input fields have data and enable the button accordingly--%>
    <script type="text/javascript">

        // Get references to the input fields and the button
        const txtUlasan = document.getElementById('txtUlasan');
        const btnSimpan = document.getElementById('btnSimpanHantar');
        const radioBtn = document.querySelectorAll('input[type="radio"]');

        btnSimpan.disabled = true;

        // Function to check if all input fields have data and enable the button accordingly
        function checkInputs(event) {

            const ulasanValue = txtUlasan.value.trim();



            console.log('ulasanValue', ulasanValue);

            //let checkedbleHasData = false;
            //if (event.target.checked) {
            //    checkedbleHasData = true;
            //}


            // If all fields have data, enable the button
            if (txtUlasan !== '') {
                btnSimpan.disabled = false;
            } else {
                btnSimpan.disabled = true;
            }
        }

        // Add event listeners to input fields
        txtUlasan.addEventListener('input', checkInputs);
        //radioBtn.forEach(radioButton => {
        //    radioButton.addEventListener('change', checkInputs);
        //});

    </script>

    <script type="text/javascript">

        var txtStatusDok = '';
        var selectedValue = '';

        // Get all radio buttons with the class "form-check-input"
        var radioButtons = document.querySelectorAll('.form-check-input');

        // Loop through each radio button
        radioButtons.forEach(function (radioButton) {
            // Add an event listener for the 'change' event
            radioButton.addEventListener('change', function () {
                // Check if the radio button is checked
                if (this.checked) {
                    // Get the value of the checked radio button
                    selectedValue = this.value;
                    txtStatusDok = this.value;
                    // Log or use the selected value as needed
                    console.log("Selected value: " + selectedValue);
                }
            });
        });


        // Get radio button elements
        const parentRadios = document.querySelectorAll('input[name="flexRadioDefault"]');
        const childContainer = document.querySelector('.child-container');

        // Add event listeners to parent radio buttons
        parentRadios.forEach(parentRadio => {
            parentRadio.addEventListener('change', function () {
                // Hide or show the child options container based on the selected parent radio
                childContainer.style.display = (this.id === 'flexRadioDefault1' || this.id === 'flexRadioDefault3') ? 'none' : 'block';

                // If the parent is checked, also uncheck the child options
                if (this.checked) {
                    document.querySelectorAll('.RadioDefault').forEach(RadioDefault => {
                        RadioDefault.checked = false;
                    });
                }
            });
        });




        $(' .is-floating-label .textarea-floating').on('focus blur', function (e) {
            $(this).parents('.is-floating-label').toggleClass('is-focused', (e.type === 'focus' || this.value.length > 0));
        }).trigger('blur');

        // Create a new Date object
        var currentDate = new Date();

        // Get the current year
        var currentYear = currentDate.getFullYear();
        var tahunSemasa = currentYear;
        //var tahunSemasa = '2022';

        document.getElementById("txtTahun2").value = tahunSemasa;


        $(document).ready(function () {



            tbl = $("#tblDataSenarai_permohonan").DataTable({
                "responsive": true,
                "searching": true,
                cache: true,



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
                    "sInfoEmpty": "Menunjukkan 0 ke 0 daripada rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },
                "ajax":
                {
                    "url":'<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadPerolehan_MesyPTeknikal") %>',
                    type: 'POST',
                    data: function (d) {
                        return "{ tahunSemasa: '" + tahunSemasa + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
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

                    // Add click event
                    $(row).on("click", function () {

                        ShowPopup(1, data.IDMesy, data.No_Mohon);

                    });
                },




                "columns": [

                    {
                        "data": null,
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        },
                        "width": "5%"
                    },
                    {
                        "data": "IDMesy",  // Assuming this is the column where you want the click event
                        "width": "10%",
                        //"render": function (data, type, row) {
                        //    //return '<a onclick="ShowPopup(1, \'' + data + '\', 1)">' + data + '</a>';

                        //    clearExistingRecord()
                        //    return `<a onclick="ShowPopup(1, '${data}', 1)">${data}</a>`;
                        //}
                    },
                    {
                        "data": "Tempat",
                        "width": "20%",

                    },
                    {
                        "data": "TarikhDaftar",
                        "type": "date", // This is optional but helps with sorting
                        render: function (data, type, row) {
                            // Format the date using moment.js
                            return moment(data).format('DD/MM/YYYY'); // Adjust the format as needed
                        },
                        "width": "10%"
                    },

                ],



            });
        });


        $(document).ready(function () {

            $('.lihat-spek-am').click(async function (evt) {
                evt.preventDefault();
                var result = await setMohonID();
                if (result) {
                    window.open(" <%=ResolveClientUrl("~/FORMS/PEROLEHAN/PERMOHONAN PEROLEHAN/Spesifikasi_Am.aspx")%>", "_blank");
                }
            })

            $('.lihat-spek-teknikal').click(async function (evt) {
                evt.preventDefault();
                var result = await setMohonID();
                if (result) {
                    window.open(" <%=ResolveClientUrl("~/FORMS/PEROLEHAN/PERMOHONAN PEROLEHAN/Spesifikasi_Teknikal.aspx")%>", "_blank");
                }
            })

        })


        async function setMohonID() {
            return new Promise((resolve, reject) => {
                $.ajax({
                    type: 'POST',
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/SetNoMohon") %>',
                    data: JSON.stringify({ IdMohon: Id_MohonDtl }),
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: function (response) {
                        resolve(response.d)
                    },
                    error: function (error) {
                    }
                });
            })
        }


        //var IDMesy = 'TM4100000000170124';
        var IDMesy = '';

        async function clearExistingRecord() {
            await clearAllRows_senarai();
        }

        $(document).ready(function () {
            $("#tblDataSenaraiSebutHarga").DataTable({
                "responsive": true,
                "searching": true,
                cache: true,
                dom: 'Bfrtip',


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
                    "sInfoEmpty": "Menunjukkan 0 ke 0 daripada rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },
                "ajax":
                {
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadPerolehan_MesyPTeknikal") %>',
                    type: 'POST',
                    data: function (d) {
                        return "{ tahunSemasa: '" + tahunSemasa + "'}"
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    }

                },



                "columns": [

                    {
                        "data": null,
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        },
                        "width": "5%"
                    },
                    {
                        "data": "IDMesy",
                    },
                    {
                        "data": "Tempat",
                    },
                    {
                        "data": "Kod_JK",
                    },
                    {
                        "data": "status",
                    },
                    {
                        "data": "Kod_JK",
                    },
                    {
                        "data": "status",
                    },
                    {
                        "data": null,
                        "defaultContent": ' <div class="row"> < div class= "col d-flex justify-content-end align-self-center" ><input id="chk_Id3" value="0" onClick="updateResult(3)" type="checkbox" aria-label="Checkbox for following text input"></div><div class="col"><input  id="sequence3" minlength="1" maxlength=1" size="1"  name="currentSequence3" type="text" class="form-control underline-input Debit m-1"  /></div></div> ',
                        "className": "text-center", // Center the icon within the cell
                        "width": "5%"
                    },
                ],
            });
        });



        // Declare Perolehan_MesyuaratDt as a global variable
        var Perolehan_MesyuaratDt;

        // Declare Perolehan_MesyuaratDt as a global variable
        var Id_MohonDtl = "";

        // Declare global variable 
        var IDMesyDataDT;

        var tblLampiran;

        var IDMesyDataDT;

        var Butiran_Perolehan; // Declare the variable globally


        async function ShowPopup(elm, IDMesyData, IdAm) {
            console.log("IDMesyData=", IDMesyData)
            console.log("IdAm=", IdAm)



            if (elm == "1") {


                // Update IDMesyDataDT with the new value
                IDMesyDataDT = IDMesyData;

                // Reload the DataTable
                Perolehan_MesyuaratDt.ajax.reload();

                $('#senaraiHargaModal').modal('toggle');


            }
            else if (elm == "2") {

                // Update Id_MohonDtl with the new value
                Id_MohonDtl = IdAm;
                //Id_MohonDtl = 'BS4100000000130124';

                // Reload the DataTable
                Butiran_Perolehan.ajax.reload(); // Now accessible

                // Reload the DataTable
                tblLampiran.ajax.reload();



                console.log("Id_MohonDtl=", Id_MohonDtl);


                $(document).ready(function () {
                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadMaklumat_Permohonan_Perolehan") %>',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify({ IdAm: Id_MohonDtl }), // Convert the data to a JSON string
                        success: function (data) {
                            // Parse the JSON data
                            var jsonData = JSON.parse(data.d);

                            // Assuming the query returns a single value, you can directly set the input value.
                            // If the query returns multiple rows, you may need to iterate through the data to display it appropriately.
                            $("#txtNo_Permohonan").val(jsonData[0].No_Mohon);
                            $("#txtNo_Perolehan").val(jsonData[0].No_Perolehan);
                            $("#txtTujuan").val(jsonData[0].Tujuan);
                            $("#txtKategori_Perolehan").val(jsonData[0].ButiranB);
                            //$("#txtKaedah_Perolehan").val(jsonData[0].Jenis_Dokumen);
                            $("#txtSkop").val(jsonData[0].Skop);
                            $("#txtPTJ").val(jsonData[0].KP);
                            $("#txtPemohon").val(jsonData[0].Nama);
                            $("#txtJustifikasi_Perolehan").val(jsonData[0].Justifikasi);
                            $("#txtUlasan").val(jsonData[0].Ulasan);

                            // Format the value as a decimal number with two decimal places and set it to txtRekod_Keperluan
                            $("#txtRekod_Keperluan").val(parseFloat(jsonData[0].Perolehan_Terdahulu).toFixed(2).replace(/\B(?=(\d{3})+(?!\d))/g, ","));

                            // Format the date and set it to txtTarikh_Mohon
                            //var Tarikh_Mohon = new Date(jsonData[0].Tarikh_Mohon);
                            // var formatTarikh_Mohon = Tarikh_Mohon.toLocaleDateString(); // Adjust the format as needed
                            $("#txtTarikh_Mohon").val(jsonData[0].Tarikh_Mohon);
                            //var Tarikh_Keperluan = new Date(jsonData[0].Tarikh_Perlu);
                            //var formatTarikh_Keperluan = Tarikh_Keperluan.toLocaleDateString(); // Adjust the format as needed
                            $("#txtTarikh_Keperluan").val(jsonData[0].Tarikh_Perlu);

                            showKaedahPerolehan();

                        },
                        error: function (error) {
                            console.log("Error: " + error);
                        }
                    });
                });

                $('#senaraiHargaModal').modal('toggle');
                $('#maklumatPermohonanModal').modal('toggle');
                tbl.ajax.reload();

            }
        }



        function showKaedahPerolehan() {
            var noMohon = $('#txtNo_Permohonan').val();
            $.ajax({
                type: 'POST',
                url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/GetKaedahPerolehan") %>',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                data: JSON.stringify({ noMohon: noMohon }),
                success: function (result) {
                    result = JSON.parse(result.d)
                    $('#txtKaedah_Perolehan').val(result[0].Kategori_Perolehan);
                },
                error: function (error) {
                    console.error('AJAX error:', error);
                }
            });
        }



        $(document).ready(function () {


            Butiran_Perolehan = $("#tblDataButiran_Perolehan").DataTable({
                "retrieve": true,
                "responsive": true,
                "searching": true,
                //cache: true,
                //dom: 'Bfrtip',


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
                    "sInfoEmpty": "Menunjukkan 0 ke 0 daripada rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },
                "ajax":
                {

                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadPerolehan_Permohonan_Dtl") %>',
                    type: 'POST',
                    data: function (d) {
                        return "{ NoMohon: '" + Id_MohonDtl + "'}";
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    error: function (xhr, status, error) {
                        console.error("AJAX Error:", status, error);
                    }

                },


                "columns": [

                    {
                        "data": null,
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        },
                        "width": "5%"
                    },
                    {
                        "data": "Kod_Kump_Wang",
                        "width": "10%"
                    },
                    {
                        "data": "Kod_Operasi",
                        "width": "10%"
                    },
                    {
                        "data": "Kod_Ptj",
                        "width": "10%"
                    },
                    {
                        "data": "Kod_Vot",
                        "width": "10%"
                    },
                    {
                        "data": "Butiran",
                        "width": "20%"
                    },
                    {
                        "data": "Kuantiti",
                        "width": "10%"
                    },
                    {
                        "data": "Ukuran",
                        "width": "10%"
                    },
                ],
            });


            Perolehan_MesyuaratDt = $("#tblDataPerolehan_MesyuaratDt").DataTable({
                "retrieve": true,
                "responsive": true,
                "searching": true,
                //cache: true,
                //dom: 'Bfrtip',


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
                    "sInfoEmpty": "Menunjukkan 0 ke 0 daripada rekod",
                    "sInfoFiltered": "(ditapis dari _MAX_ jumlah rekod)",
                    "sEmptyTable": "Tiada rekod.",
                    "sSearch": "Carian"
                },
                "ajax":
                {

                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadPerolehan_MesyuaratDt") %>',
                    type: 'POST',
                    "data": function (d) {
                        return "{IDMesy: '" + IDMesyDataDT + "'}";
                    },
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    "dataSrc": function (json) {
                        return JSON.parse(json.d);
                    },
                    error: function (xhr, status, error) {
                        console.error("AJAX Error:", status, error);
                    }

                },

                "rowCallback": function (row, data) {
                    // Add hover effect
                    $(row).hover(function () {
                        $(this).addClass("hover pe-auto bg-warning");
                    }, function () {
                        $(this).removeClass("hover pe-auto bg-warning");
                    });

                    // Add click event
                    $(row).on("click", function () {
                        //no_mohon = data.No_Mohon;
                        ShowPopup(2, data.ID_Mesy, data.No_Mohon);

                        //Id_MohonDtl = data.No_Mohon;
                        //Id_MohonDtl = 'BS4100000002211023';

                        // Reload the DataTable
                        //Butiran_Perolehan.ajax.reload(); // Now accessible

                        // Reload the DataTable
                        //tblLampiran.ajax.reload();

                    });
                },

                "columns": [

                    {
                        "data": null,
                        render: function (data, type, row, meta) {
                            return meta.row + meta.settings._iDisplayStart + 1;
                        },
                        "width": "5%"
                    },
                    {
                        "data": "No_Perolehan",
                        "width": "15%",
                        //"render": function (data, type, row) {
                        //    return `<a onclick="ShowPopup(2, 1, '${data}')">${data}</a>`;
                        //}
                    },
                    {
                        "data": "Tujuan",
                        "width": "25%"

                    },
                    {
                        "data": "Kategori",
                        "width": "15%"

                    },
                    {
                        "data": "Kod_Ptj_Mohon",
                        "width": "15%"

                    },
                    {
                        "data": "Status",
                        "width": "10%"

                    },

                ],
            });
            //var Id_MohonDtl = $('#txtNo_Permohonan').val();

            tblLampiran = $("#tblSimpanUpload").DataTable({
                //retrieve: true,
                info: false,
                ordering: false,
                paging: false,
                "responsive": true,
                "searching": false,
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
                    "url": '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/Load_Lampiran") %>',
                    type: 'POST',
                    "contentType": "application/json; charset=utf-8",
                    "dataType": "json",
                    data: function (d) {
                        return JSON.stringify({ id: Id_MohonDtl });
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
                    {

                        visible: true,
                        "data": null,
                        "render": function (data, type, row, meta) {
                            // Render the index/bil as row number
                            return meta.row + 1;
                        }
                    },
                    { "data": "Lampiran" },
                    {
                        "data": null,
                        "title": "Tindakan",
                        "render": function (data, type, row) {
                            return `
            <div class="row">
                <div class="col-md-1">
                    <button type="button" class="btn viewLampiran" style="padding:0px 0px 0px 0px" title="Papar">
                        <i class="fa fa-eye fa-lg"></i>
                    </button>
                </div>
            </div>
                        `;
                        }
                    }
                ],
            });

        });




        $("#tblSimpanUpload").off('click', '.viewLampiran').on("click", ".viewLampiran", function (event) {
            var data = tblLampiran.row($(this).parents('tr')).data();
            var fileName = data.Nama_Fail;
            var nomohon = $("#txtNo_Permohonan").val();

            // Call a function to open the PDF in a new tab
            openPDFInNewTab(fileName, nomohon);
        });

        function openPDFInNewTab(fileName, nomohon) {
            var pdfPath = '<%= ResolveClientUrl("~/UPLOAD/DOCUMENT/PEROLEHAN/PERMOHONAN/") %>' + nomohon + '/' + fileName;
            window.open(pdfPath, '_blank');
        }






        var tbl = null
        var isClicked = false;


        var searchQuery = "";
        var oldSearchQuery = "";
        var curNumObject = 0;
        var tableID = "#tblData";
        /*var tableID_permohonan = "#tblDataSenarai_permohonan";*/
        var shouldPop = true;
        var totalID = "#totalBeza";

        var totalDebit = "#totalDbt";
        var totalKredit = "#totalKt";

        var objMetadata = [{
            "obj1": {
                "id": "",
                "oldSearchQurey": "",
                "searchQuery": ""
            }
        }, {
            "obj2": {
                "id": "",
                "oldSearchQurey": "",
                "searchQuery": ""
            }
        }]


        // Simpan  Permohonan ulasan
        $('#btnSimpanHantar').off('click').on('click', async function () {
            var msg = "Anda pasti ingin menghantar maklumat Permohonan Perolehan ini?";
            $('#confirmationMessage10').text(msg);
            $('#saveConfirmationModal10').modal('show');
            //$('#maklumatPermohonanModal').modal('hide');


            $('#confirmSaveButton10').off('click').on('click', async function () {
                $('#saveConfirmationModal10').modal('hide');

                //var txtStatusDok = '03';

                //Id_MohonDtl = 'BS4100000002140923';
                //IDMesyDataDT = 'TM0000120124';

                var Flag_PenentuanTeknikal = ''

                if (txtStatusDok == '30') {
                    Flag_PenentuanTeknikal = 0
                }

                if (txtStatusDok == '29' || txtStatusDok == '31' || txtStatusDok == '32') {
                    Flag_PenentuanTeknikal = 1
                }



                var newHantarPerolehan_Mesyuarat_Dtl = {

                    HantarPerolehan_Mesyuarat_Dtl: {

                        txtNoMohonH: Id_MohonDtl,
                        txtIDMesyH: IDMesyDataDT,
                        txtUlasanH: $('#txtUlasan').val(),
                        txtStatusDokH: txtStatusDok,
                        txtFlag_PenentuanTeknikal: Flag_PenentuanTeknikal
                    }

                };


                //if (txtStatusDok == '31') {

                //    try {
                //        var Insert1 = JSON.parse(await UpdateSenarai_Jualan_Naskah(newHantarPerolehan_Mesyuarat_Dtl))
                //        if (Insert1.Status === true) {
                //            showModal10("Success", result.Message, "success");
                //            //$('#txtNoMohonR').val(result.Payload.txtNoMohon);
                //            tbl.ajax.reload();
                //            Perolehan_MesyuaratDt.ajax.reload();
                //        } else {
                //            showModal10("Error", result.Message, "error");
                //        }
                //    } catch (error) {
                //        console.error('Error:', error);
                //        showModal10("Error", "An error occurred during the request.", "error");
                //    }
                //}

                try {
                    var result = JSON.parse(await ajaxHantarPermohonan(newHantarPerolehan_Mesyuarat_Dtl));
                    if (result.Status === true) {
                        showModal10("Success", result.Message, "success");
                        $('#maklumatPermohonanModal').modal('toggle');
                        tbl.ajax.reload();
                        Perolehan_MesyuaratDt.ajax.reload();
                        //$('#txtNoMohonR').val(result.Payload.txtNoMohon);
                    } else {
                        showModal10("Error", result.Message, "error");
                    }

                } catch (error) {
                    console.error('Error:', error);
                    showModal10("Error", "An error occurred during the request.", "error");
                }

                try {
                    var update1 = JSON.parse(await HantarStatus_Dok_Permohonan_Hd(newHantarPerolehan_Mesyuarat_Dtl))

                    if (update1.Status === true) {
                        showModal10("Success", result.Message, "success");
                        //$('#txtNoMohonR').val(result.Payload.txtNoMohon);
                        tbl.ajax.reload();
                        Perolehan_MesyuaratDt.ajax.reload();
                    } else {
                        showModal10("Error", result.Message, "error");
                    }
                } catch (error) {
                    console.error('Error:', error);
                    showModal10("Error", "An error occurred during the request.", "error");
                }
            });
        });

        async function ajaxHantarPermohonan(HantarPerolehan_Mesyuarat_Dtl) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/HantarPerolehan_Mesyuarat_Data") %>',
                    method: 'POST',
                    data: JSON.stringify(HantarPerolehan_Mesyuarat_Dtl),
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
            });
        }

        async function HantarStatus_Dok_Permohonan_Hd(newHantarPerolehan_Mesyuarat_Dtl) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/HantarStatus_Dok_Permohonan_Hdr") %>',
                    method: 'POST',
                    data: JSON.stringify(newHantarPerolehan_Mesyuarat_Dtl),
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
            });
        }

        async function UpdateSenarai_Jualan_Naskah(newHantarPerolehan_Mesyuarat_Dtl) {
            return new Promise((resolve, reject) => {
                $.ajax({
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/UpdateSenarai_Jualan_Naskah") %>',
                    method: 'POST',
                    data: JSON.stringify(newHantarPerolehan_Mesyuarat_Dtl),
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    success: function (data) {
                        resolve(data.d);
                        // Reload the DataTable
                        Butiran_Perolehan.ajax.reload(); // Now accessible

                        // Reload the DataTable
                        tblLampiran.ajax.reload();
                    },
                    error: function (xhr, textStatus, errorThrown) {
                        console.error('Error:', errorThrown);
                        reject(false);
                    }
                });
            });
        }


        function showModal10(title, message, type) {
            $('#resultModalTitle10').text(title);
            $('#resultModalMessage10').text(message);
            if (type === "success") {
                $('#resultModal10').removeClass("modal-error").addClass("modal-success");
            } else if (type === "error") {
                $('#resultModal10').removeClass("modal-success").addClass("modal-error");
            }
            $('#resultModal10').modal('show');
        }





    </script>
</asp:Content>

