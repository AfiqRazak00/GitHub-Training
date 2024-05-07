<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Pinj_Bayar_Balik.aspx.vb" Inherits="SMKB_Web_Portal.Bayar_Balik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js" crossorigin="anonymous"></script>

    
    <style>
         #permohonan .modal-body {
            max-height: 60vh; /*Adjust height as needed to fit your layout */
            min-height: 60vh;
            overflow-y: scroll;
            scrollbar-width: thin;
        }
        .text-right {
            text-align: right;
        }

        .default-primary {
            background-color: #007bff !important;
            color: white;
        }


       /*start sticky table tbody tfoot*/
        table {
            
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

        #showModalButton:hover {
            /* Add your hover styles here */
            background-color: #ffc107; /* Change background color on hover */
            color: #fff; /* Change text color on hover */
            border-color: #ffc107; /* Change border color on hover */
            cursor: pointer; /* Change cursor to indicate interactivity */
        }

         #tblSenaraiPermohonan tr:hover {
            cursor: pointer; /* Change cursor to indicate interactivity */
         }

         #tblPenjamin tr:hover {
            cursor: pointer; /* Change cursor to indicate interactivity */
         }

         #tblPotongan tr:hover {
            cursor: pointer; /* Change cursor to indicate interactivity */
         }

    </style>
    <contenttemplate>   
        <div id="PermohonanTab" class="tabcontent" style="display: block">
            <div id="divpendaftaraninv" runat="server" visible="true">
                <div class="modal-body ">
                    <div class="table-title form-row">
                        <div class="justify-content-around">
                            <h5>Maklumat Pembiayaan</h5>
                        </div>
                        <div class="form-row justify-content-end" >
                            <div class="btn btn-primary btnPapar" onclick="ShowPopup('2')">
                                Senarai Rekod Pembiayaan
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="">
                        <div class="form-row">
                            <div class="form-group col-md-4">
                                <input type="text" class="form-control input-group__input" id="txtnopinj" name="txtnopinj" readonly/>
                                <label class="input-group__label" for="txtnopinj">No Pembiayaan </label>
                            </div>
                                <div class="form-group col-md-4">
                                <input type="text" class="form-control input-group__input" id="txtnostaff" name="txtnostaff" readonly/>
                                <label class="input-group__label" for="txtnostaff">No Staf </label>
                            </div>
                                <div class="form-group col-md-4">
                                <input type="text" class="form-control input-group__input" id="txtnama" name="txtnama" readonly/>
                                <label class="input-group__label" for="txtnama">Nama </label>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-4">
                                <%--<input type="text" class="form-control input-group__input" placeholder="" id="txtbaucar" name="txtbaucar" readonly/>--%>
                                <input type="text" class="form-control input-group__input" id="txtbaucar" name="txtbaucar" readonly/>
                                <label class="input-group__label" for="txtbaucar">No Baucar </label>
                            </div>
                            <div class="form-group col-md-4">
                                <input type="text" class="form-control input-group__input" id="txtnocek" name="txtnocek" readonly/>
                                <label class="input-group__label" for="txtnocek">No Cek </label>
                            </div>
                            <div class="form-group col-md-2 input-group">
                                <select class="input-group__select ui search dropdown" placeholder="" name="ddlBulanPotongan" id="ddlBulanPotongan"></select>
                                <label class="input-group__label" for="ddlBulanPotongan">Bulan Potongan</label>
                            </div>
                            <div class="form-group col-md-2 input-group">
                                <select class="input-group__select ui search dropdown" name="ddlTahunPotongan" id="ddlTahunPotongan"></select>
                                <label class="input-group__label" for="ddlTahunPotongan">Tahun Potongan</label>
                            </div>
                        </div>
                        <br>
                        <ul class="nav nav-tabs" id="subTab">
                            <li class="nav-item">
                                <a class="nav-link active text-uppercase"data-toggle="tab" href="#InfoPemohon" >Info Pemohon</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link text-uppercase" data-toggle="tab" href="#InfoPinjaman" >Info Pembiayaan</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link text-uppercase" data-toggle="tab" href="#InfoKenderaan" >Info Kenderaan</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link text-uppercase" data-toggle="tab" href="#InfoKomputer" >Info Komputer/Telefon Pintar</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link text-uppercase" data-toggle="tab" href="#InfoSukan" >Info Peralatan Sukan</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link text-uppercase" data-toggle="tab" href="#InfoPenjamin" >Info Penjamin</a>
                            </li>
                            <li class="nav-item" role="presentation">
                                <a class="nav-link text-uppercase" data-toggle="tab" href="#InfoPotongan" >Info Potongan Gaji</a>
                            </li>
                        </ul>
                        <div class="modal-body">
                            <div class="tab-content" id="myTabContent">
                                <br>
                                <div class="tab-pane fade show active" id="InfoPemohon" role="tabpanel">
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control" id="txtnokp" name="txtnokp" readonly />
                                                    <label class="input-group__label">No K/P</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtdob" id="txtdob" readonly>
                                                    <label class="input-group__label">Tarikh Lahir</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtumur" id="txtumur" readonly>
                                                    <label class="input-group__label">Umur Pada Tarikh Memohon</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txttarafpkhd" id="txttarafpkhd" readonly>
                                                    <label class="input-group__label">Taraf Perkhidmatan</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtkumppkhd" id="txtkumppkhd" readonly>
                                                    <label class="input-group__label">Kumpulan Perkhidmatan</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " id="txtgredgaji" name="txtgredgaji" readonly>
                                                    <label class="input-group__label">Gred Gaji</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                
                                                 <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " id="txttarikhsah" name="txttarikhsah" readonly>
                                                    <label class="input-group__label">Tarikh Sah</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="date" class=" input-group__input form-control input-sm " name="txttarikhlantikan" id="txttarikhlantikan" readonly>
                                                    <label class="input-group__label">Tarikh Lantikan</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class="input-group__input form-control input-sm text-right" id="txtgajipokok" name="txtgajipokok" readonly>
                                                    <label class="input-group__label">Gaji Pokok</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                
                                                 <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " id="txtnolesen" name="txtnolesen" readonly>
                                                    <label class="input-group__label">No Lesen</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtkelasmemandu" id="txtkelasmemandu" readonly>
                                                    <label class="input-group__label">Kelas Memandu</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " id="txttkhtmtlesen" name="txttkhtmtlesen" readonly>
                                                    <label class="input-group__label">Tarikh Tamat Lesen Memandu</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                               <div class="form-group col-md-8">
                                                    <input type="text" class="input-group__input form-control input-sm " id="txtjawatan" name="txtjawatan" readonly>
                                                    <label class="input-group__label">Jawatan</label>
                                                </div>
                                                 <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " id="txtvoipno" name="txtvoipno" readonly>
                                                    <label class="input-group__label">VoIP No.</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                               <div class="form-group col-md-8">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtjabatan" id="txtjabatan" readonly>
                                                    <label class="input-group__label">Jabatan</label>
                                                </div>
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade " id="InfoPinjaman" role="tabpanel">
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm  " id="txtkatpinj" name="txtkatpinj" readonly />
                                                    <label class="input-group__label">Kategori Pembiayaan</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txttkhmohon" id="txttkhmohon" readonly>
                                                    <label class="input-group__label">Tarikh Mohon</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm text-right" name="txtamaunmohon" id="txtamaunmohon" readonly>
                                                    <label class="input-group__label">Amaun Mohon(RM)</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm  " id="txtjenpinj" name="txtjenpinj" readonly />
                                                    <label class="input-group__label">Jenis Pembiayaan</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txttkhlulus" id="txttkhlulus" readonly>
                                                    <label class="input-group__label">Tarikh Lulus</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm text-right" name="txtamaunlulus" id="txtamaunlulus" readonly>
                                                    <label class="input-group__label">Amaun Lulus(RM)</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm  " id="txttempoh" name="txttempoh" readonly />
                                                    <label class="input-group__label">Tempoh Pembiayaan</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm text-right" name="txtansuran" id="txtansuran" readonly>
                                                    <label class="input-group__label">Ansuran Bulanan(RM)</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtkelayakan" id="txtkelayakan" readonly>
                                                    <label class="input-group__label">Kelayakan</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-8">
                                                    <textarea class="input-group__input form-control input-sm" rows="2"  data-enable-grammarly="false" id="txtkendSediaAda" maxlength="250" readonly></textarea>
                                                    <label class="input-group__label">Jenis kenderaan yang digunakan sekarang semasa menjalankan tugas rasmi</label>
                                                </div>
                                                 <div class="form-group col-md-8">
                                                    <textarea class="input-group__input form-control input-sm" rows="2" data-enable-grammarly="false" id="txtjwtnPerluKend" maxlength="300" readonly></textarea>
                                                    <label class="input-group__label">Tugas jawatan yang menunjukkan perlu menggunakan kenderaan sendiri </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade " id="InfoPenjamin" role="tabpanel">
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <table class="table table-striped" id="tblPenjamin" style="width: 100%;">
                                                <thead>
                                                    <tr style="width: 100%; text-align: center">
                                                        <th scope="col" style="width: 5%; text-align:center">Bil</th>
                                                        <th scope="col" style="width: 15%; text-align:center">No Staf</th>
                                                        <th scope="col" style="width: 25%; text-align:center">Nama</th>
                                                        <th scope="col" style="width: 25%; text-align:center">Jabatan</th>
                                                        <th scope="col" style="width: 10%; text-align:center">Pengesahan</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tableIDPenjamin">
                                                </tbody>
                                            </table>
                                        </div>  
                                    </div>
                                </div>
                                <div class="tab-pane fade " id="InfoKenderaan" role="tabpanel">
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm  " id="txtmodel" name="txtmodel" readonly />
                                                    <label class="input-group__label">Model</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtbuatan" id="txtbuatan" readonly>
                                                    <label class="input-group__label">Buatan</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm text-right" name="txthargabersih" id="txthargabersih" readonly>
                                                    <label class="input-group__label">Harga Bersih(RM)</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <div class="form-row">
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtsukatsilinder" id="txtsukatsilinder" readonly>
                                                    <label class="input-group__label">Sukat Silinder</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " name="txtnochasis" id="txtnochasis" readonly>
                                                    <label class="input-group__label">No Chasis</label>
                                                </div>
                                                <div class="form-group col-md-4">
                                                    <input type="text" class=" input-group__input form-control input-sm " id="txtnoenjin" name="txtnoenjin" readonly>
                                                    <label class="input-group__label">No Enjin</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade " id="InfoKomputer" role="tabpanel">
                                <div class="row ">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="jenispinjkomp" name="jenispinjkomp" readonly />
                                                <label class="input-group__label">Jenis Peranti</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="jenamakomp" name="jenamakomp" readonly />
                                                <label class="input-group__label">Jenama Komputer/Telefon Pintar</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="kapasiticakera" name="kapasiticakera" readonly />
                                                <label class="input-group__label">Kapasiti Cakera Keras (Hardisk)</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row ">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="ram" name="ram" readonly />
                                                <label class="input-group__label">Ingatan (RAM)</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="jenamamonitor" name="jenamamonitor" readonly />
                                                <label class="input-group__label">Jenama Monitor</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="jenamapencetak" name="jenamapencetak" readonly />
                                                <label class="input-group__label">Jenama Pencetak</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="papankekunci" name="papankekunci" readonly />
                                                <label class="input-group__label">Jenis Papan Kekunci</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="jenamamodem" name="jenamamodem" readonly />
                                                <label class="input-group__label">Jenama Modem</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="kadbunyi" name="kadbunyi" readonly />
                                                <label class="input-group__label">Jenama Kad Bunyi (Sound Card)</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="pemacucakera" name="pemacucakera" readonly />
                                                <label class="input-group__label">Jenama Pemacu Cakera (CD/DVD-ROM)</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="tetikus" name="tetikus" readonly />
                                                <label class="input-group__label">Jenama Tetikus (Mouse)</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm text-right" id="hargakomp" name="hargakomp" readonly />
                                                <label class="input-group__label">Harga Komputer/Telefon Pintar (RM)</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                <div class="tab-pane fade " id="InfoSukan" role="tabpanel">
                                <div class="row ">
                                    <div class="col-md-12">
                                        <div class="form-row">
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm" id="jenispinjsukan" name="jenispinjsukan" readonly />
                                                <label class="input-group__label">Jenis Pembiayaan Sukan</label>
                                            </div>
                                            <div class="form-group col-md-4">
                                                <input type="text" class="input-group__input form-control input-sm text-right" id="hargasukan" name="hargasukan" readonly />
                                                <label class="input-group__label">Harga (RM)</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                <div class="tab-pane fade " id="InfoPotongan" role="tabpanel">
                                    <div class="row ">
                                        <div class="col-md-12">
                                            <table class="table table-striped" id="tblPotongan" style="width: 100%;">
                                                <thead>
                                                    <tr style="width: 100%; text-align: center">
                                                        <th scope="col" style="width: 5%; text-align:center">Bil</th>
                                                        <th scope="col" style="width: 75%; text-align:center">Jenis Pembiayaan</th>
                                                        <th scope="col" style="width: 20%; text-align:center">Jumlah Potongan(RM)</th>
                                                    </tr>
                                                </thead>
                                                <tbody id="tableIDPotongan">
                                                </tbody>
                                            </table>
                                        </div>  
                                    </div>
                                    <div class="sticky-footer">
                                       <br>
                                       <div class="form-row">
                                          <div class="form-group col-md-12">
                                             <div class="float-right">
                                                <button type="button" class="btn" id="showModalButton">
                                                <i class="fas fa-angle-up"></i>
                                                </button>
                                                <span style="font-family: roboto!important; font-size: 16px!important"><b>Jumlah : RM
                                                <span id="totalPotongan" style="margin-right: 25px"></span></b></span>
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="sticky-footer">
                    <br>
                    <div class="form-row">
                       <div class="form-group col-md-12">
                          <div id="showBtn" class="float-right">
                             <button type="button" class="btn btn-setsemula btnreset">Rekod Baru</button>
                             <button type="button" class="btn btn-secondary btnSimpan">Simpan</button>
                          </div>
                       </div>
                    </div>
                 </div> 
            </div>
        </div>
        <!-- Modal detail potongan-->
        <div class="modal fade" id="detailTotal" tabindex="-1" aria-labelledby="showDetails" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="row justify-content-end mt-2">
                            <div class="col-md-6 text-right">
                                <label class="col-form-label ">Butiran Hutang/Potongan (RM)</label>
                            </div>
                            <div class="col-md-6">
                                <input class="form-control  underline-input text-right" id="totalPotonganSum" name="totalPotonganSum" style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00" readonly />
                            </div>
                        </div>
                        <div class="row justify-content-end mt-2">
                            <div class="col-md-6 text-right">
                                <label class="col-form-label ">Jumlah Gaji (RM)</label>
                            </div>
                            <div class="col-md-6">
                                <input class="form-control  underline-input text-right" id="totalGajiSum" name="totalGajiSum" style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00" readonly />
                            </div>
                        </div>
                        <div class="row justify-content-end mt-2">
                            <div class="col-md-6 text-right">
                                <label class="col-form-label ">Peratus Potongan (%)</label>
                            </div>
                            <div class="col-md-6">
                                <input class="form-control  underline-input text-right" id="perPotonganSum" name="perPotonganSum" style="text-align: right; font-size: medium; font-weight: bold" placeholder="0.00" readonly />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal senarai-->
        <div class="modal fade" id="permohonan" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl" style="min-width: 60%" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalCenterTitle">Senarai Rekod Pembiayaan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!-- Create the dropdown filter -->
                    <div class="search-filter">
                        <div class="form-row justify-content-center">
                            <div class="form-group row col-md-6">
                                <label for="" class="col-sm-4 col-form-label">Carian:</label>
                                <div class="col-sm-8">
                                    <div class="input-group">
                                        <select id="pinjamanDateFilter" class="custom-select" onchange="dateFilterHandler(event)">
                                            <option value="all">SEMUA</option>
                                            <option value="0" selected="selected">Hari Ini</option>
                                            <option value="1">Semalam</option>
                                            <option value="7">7 Hari Lepas</option>
                                            <option value="30">30 Hari Lepas</option>
                                            <option value="60">60 Hari Lepas</option>
                                            <option value="select">Pilih Tarikh</option>
                                        </select>
                                        <button id="btnSearch" runat="server" class="btn btn-outline btnSearch" type="button" onclick="loadPermohonan()">
                                            <i class="fa fa-search"></i>Cari
                                        </button>

                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <div class="form-row">
                                        <div class="form-group col-md-5">
                                            <br />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-11" id="specificDateFilter" style="display: none">
                                    <div class="form-row">
                                        <div class="form-group col-md-1">
                                            <label id="lblMula" style="text-align: right;">Mula:</label>
                                        </div>

                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhStart" name="txtTarikhStart" class="form-control input-sm date-range-filter">
                                        </div>
                                        <div class="form-group col-md-1">
                                        </div>
                                        <div class="form-group col-md-1">
                                            <label id="lblTamat" style="text-align: right;">Tamat:</label>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <input type="date" id="txtTarikhEnd" name="txtTarikhEnd" class="form-control input-sm date-range-filter">
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-body">
                            <div class="col-md-12">
                                <div class="transaction-table table-responsive">
                                    <table id="tblSenaraiPermohonan" class="table table-striped" style="width: 100%">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="text-align: center;width: 5%">Bil</th>
                                                <th scope="col" style="text-align: center;width: 15%">No Pembiayaan</th>
                                                <th scope="col" style="text-align: center;width: 10%">No Staf</th>
                                                <th scope="col" style="text-align: center;width: 30%">Nama</th>
                                                <th scope="col" style="text-align: center;width: 15%">Tarikh Mohon</th>
                                                <th scope="col" style="text-align: center;width: 15%">Jenis Pembiayaan</th>
                                                <th scope="col" style="text-align: center;width: 15%">Amaun(RM)</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tableID_Senarai">
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Info Penjamin-->
        <div class="modal fade" id="modalPenjamin" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="static">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-lg"
                role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addNewPenghutangModal">Maklumat Penjamin</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"
                            id="btnCloseModal">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>

                    <div class="modal-body">
                        <div class="col-md-12">
                           <div class="form-row">
                                <div class="form-group col-md-6">
                                    <input type="text" class="form-control input-group__input" id="txtpenjaminnostaf" name="txtpenjaminnostaf" readonly/>
                                    <label class="input-group__label" for="txtpenjaminnostaf">No Staf </label>
                                </div>
                                <div class="form-group col-md-6">
                                    <input type="text" class="form-control input-group__input" id="txtpenjaminnama" name="txtpenjaminnama" readonly/>
                                    <label class="input-group__label" for="txtpenjaminnama">Nama </label>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <input type="text" class="form-control input-group__input" id="txtpenjamindob" name="txtpenjamindob" readonly/>
                                    <label class="input-group__label" for="txtpenjamindob">Tarikh Lahir</label>
                                </div>
                                <div class="form-group col-md-6">
                                    <input type="text" class="form-control input-group__input" id="txtpenjamintkhsah" name="txtpenjamintkhsah" readonly/>
                                    <label class="input-group__label" for="txtpenjamintkhsah">Tarikh Sah </label>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <input type="text" class="form-control input-group__input" id="txtpenjamintaraf" name="txtpenjamintaraf" readonly/>
                                    <label class="input-group__label" for="txtpenjamintaraf">Taraf </label>
                                </div>
                                <div class="form-group col-md-6">
                                    <input type="text" class="form-control input-group__input" id="txtpenjaminkump" name="txtpenjaminkump" readonly/>
                                    <label class="input-group__label" for="txtpenjaminkump">Kumpulan </label>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-12">
                                    <input type="text" class="form-control input-group__input" id="txtpenjaminjawatan" name="txtpenjaminjawatan" readonly/>
                                    <label class="input-group__label" for="txtpenjaminjawatan">Jawatan </label>
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group col-md-12">
                                    <input type="text" class="form-control input-group__input" id="txtpenjaminjabatan" name="txtpenjaminjabatan" readonly/>
                                    <label class="input-group__label" for="txtpenjaminjabatan">Jabatan </label>
                                </div>
                            </div>
                            <%--<div class="form-row">
                                <div class="form-group col-md-6">
                                    <input type="text" class="form-control input-group__input" id="txtpenjaminhutang" name="txtpenjaminhutang" readonly/>
                                    <label class="input-group__label" for="txtpenjaminhutang">Butiran Hutang/Potongan </label>
                                </div>
                            </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Confirmation Modal Proses Bayar Balik -->
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
                            data-dismiss="modal">Tidak</button>
                        <button type="button" class="btn default-primary btnYaConfirmation">Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- notify modal start-->
        <div class="modal fade" id="NotifyModal" role="dialog" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="lblNotify">Makluman</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="notify"></p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary tutupButton" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            function addMonthsToDropdown() {
                var ddlBulanPotongan = document.getElementById("ddlBulanPotongan");
                for (var i = 1; i <= 12; i++) {
                    var option = document.createElement("option");
                    option.value = i;
                    option.text = i;
                    ddlBulanPotongan.appendChild(option);
                }
                var currentMonth = new Date().getMonth() + 1; // JavaScript months are zero-based
                // Set the default selected option to the current month
                ddlBulanPotongan.value = currentMonth;
            }

            function addYearsToDropdown() {
                var ddlTahunPotongan = document.getElementById("ddlTahunPotongan");
                var currentYear = new Date().getFullYear();
                for (var i = currentYear; i >= currentYear - 1; i--) {
                    var option = document.createElement("option");
                    option.value = i;
                    option.text = i;
                    ddlTahunPotongan.appendChild(option);
                }
                ddlTahunPotongan.value = currentYear;
            }

            function getDateBeforeDays(days) {
                let pastDate = new Date();
                pastDate.setDate(pastDate.getDate() - days);
                return pastDate;
            }

            function dateFilterHandler(e) {
                if (e.target.value == "select") {
                    $("#specificDateFilter").show()
                }
                else {
                    $("#specificDateFilter").hide()
                }
            }

            function loadPermohonan() {
                if ($("#pinjamanDateFilter").val() == "select") {
                    let dateStart = $("#txtTarikhStart").val()
                    let dateEnd = $("#txtTarikhEnd").val()
                    if (dateStart == "") {
                        dialogMakluman("sila pilih tarikh carian")
                        return
                    }
                    loadPermohonanLists(dateStart, dateEnd)
                }
                else if ($("#pinjamanDateFilter").val() == "all") {
                    loadPermohonanLists()

                }
                else {
                    let days = $("#pinjamanDateFilter").val()
                    let dateString = toSqlDateString(getDateBeforeDays(days))
                    loadPermohonanLists(dateString, "")
                }
            }

            function loadPermohonanLists(dateStart, dateEnd) {
                console.log('load list permohonan')

                if (!dateEnd) {
                    dateEnd = ""
                }
                if (!dateStart) {
                    dateStart = ""
                }

                show_loader()
                $.ajax({
                    url: '<%= ResolveUrl("~/FORMS/PINJAMAN/BAYAR BALIK/Pinj_BayarBalik_WS.asmx/loadListPermohonanData") %>',
                    method: "POST",
                    data: JSON.stringify({
                        DateStart: dateStart,
                        DateEnd: dateEnd
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        close_loader()
                        data = JSON.parse(data.d)
                        tbl.clear()
                        tbl.rows.add(data.Payload).draw()
                    },
                    drawCallback: function (settings) {
                        // Your function to be called after loading data
                        close_loader();
                    },
                    error: function (xhr, status, error) {
                        close_loader()
                        console.error(error);
                    }
                })
            }

            const showModalButton = document.getElementById('showModalButton');
            const detailTotalModal = new bootstrap.Modal(document.getElementById('detailTotal'));

            showModalButton.addEventListener('click', () => {
                detailTotalModal.show();
            });

            showModalButton.addEventListener('mouseenter', () => {
                const buttonRect = showModalButton.getBoundingClientRect();
                const modalDialog = detailTotalModal._dialog;

                // Position the modal above and to the left of the button with adjusted offsets
                const offsetLeft = 360; // Adjust this value to move the modal to the left
                const offsetBottom = -30; // Adjust this value to move the modal downwards
                modalDialog.style.position = 'fixed';
                modalDialog.style.left = buttonRect.left - offsetLeft + 'px'; // Subtract the offset
                modalDialog.style.bottom = window.innerHeight - buttonRect.top + offsetBottom + 'px'; // Add the offset

                detailTotalModal.show();
            });

            showModalButton.addEventListener('mouseleave', () => {
                detailTotalModal.hide();
            });

            var selectedCategory = null;
            function ShowPopup(elm) {
                if (elm == "1") {
                    $('#permohonan').modal('toggle');
                }
                else if (elm == "2") { // open modal and load data

                    $(".modal-body div").val("");
                    $('#permohonan').modal('toggle');

                    // set datepicker to empty and hide it as default state
                    $('#txtTarikhStart').val("");
                    $('#txtTarikhEnd').val("");
                    $('#divDatePicker').removeClass("d-flex").addClass("d-none");
                }
            }
            
            var tbl = null
            var tblPenjamin = null
            var tblPotongan = null

            $(document).ready(function () {
                $(".ui.dropdown").dropdown({
                    fullTextSearch: true
                });

                addMonthsToDropdown()
                addYearsToDropdown()

                hideTab('#InfoKenderaan')
                hideTab('#InfoSukan')
                hideTab('#InfoKomputer')

                var today = toSqlDateString(new Date())

                document.getElementById('txtTarikhStart').setAttribute('max', today);
                document.getElementById('txtTarikhEnd').setAttribute('max', today);

                tbl = $("#tblSenaraiPermohonan").DataTable({
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
                    columnDefs: [
                        { targets: [6] }
                    ],
                    "columns": [
                        { "data": "Bil", "className": "text-center" },
                        { "data": "No_Pinj", "className": "text-center" },
                        { "data": "No_Staf", "className": "text-center" },
                        { "data": "MS01_Nama" },
                        { "data": "FormattedDate", "className": "text-center" },
                        { "data": "Jenis_Pinj_Desc" },
                        { "data": "Amaun", "className": "text-right" }
                    ],
                    "rowCallback": function (row, data) {
                        // Add hover effect
                        $(row).hover(function () {
                            $(this).addClass("hover pe-auto bg-warning");
                        }, function () {
                            $(this).removeClass("hover pe-auto bg-warning");
                        });
                    },
                    createdRow: function (row, data, dataIndex) {
                        row.dataset.idrujukan = data["No_Pinj"]
                        row.onclick = showPermohonanData
                    }
                    

                });

                tblPenjamin = $("#tblPenjamin").DataTable({
                    "responsive": true,
                    "searching": false,
                    "sorting": false,
                    "paging": false,
                    "bInfo": false,
                    "columns":[
                            { "data": "Bil", "className": "text-center" },
                            { "data": "No_Staf", "className": "text-center" },
                            { "data": "MS01_Nama" },
                            { "data": "Pejabat" },
                            { "data": "pengesahan", "className": "text-center" }
                    ],
                    "rowCallback": function (row, data) {
                        // Add hover effect
                        $(row).hover(function () {
                            $(this).addClass("hover pe-auto bg-warning");
                        }, function () {
                            $(this).removeClass("hover pe-auto bg-warning");
                        });
                    },
                    "language": {
                        "emptyTable": " "
                    },
                    createdRow: function (row, data, dataIndex) {
                        row.dataset.idrujukan = data["No_Staf"];
                        row.onclick = showMaklumatPenjamin
                    }
                });

                tblPotongan = $("#tblPotongan").DataTable({
                    "responsive": true,
                    "searching": false,
                    "sorting": false,
                    "paging": false,
                    "bInfo": false,
                    "columns":[
                            { "data": "Bil", "className": "text-center" },
                            { "data": "Butiran" },
                            { "data": "AmaunFormatted", "className": "text-right" }
                    ],
                    "rowCallback": function (row, data) {
                        // Add hover effect
                        $(row).hover(function () {
                            $(this).addClass("hover pe-auto bg-warning");
                        }, function () {
                            $(this).removeClass("hover pe-auto bg-warning");
                        });
                    },
                    "language": {
                        "emptyTable": " "
                    },
                    createdRow: function (row, data, dataIndex) {
                    }
                });
            });
            //load data into modal
            async function showPermohonanData(e) {
                // modal dismiss
                $('#permohonan').modal('toggle');
                var target = e.target
                if (target.tagName == "TD") {
                    target = target.parentElement
                }
                show_loader()
                
                let pinjHdr = await getPinjamanHdr(target.dataset.idrujukan)
                close_loader()
            }

            //load data into modal
            async function showMaklumatPenjamin(e) {
                // modal show
                debugger
                $("#modalPenjamin").modal('show');
                var target = e.target
                if (target.tagName == "TD") {
                    target = target.parentElement
                }
                let penjamin = await getMaklumatPenjamin(target.dataset.idrujukan)
            }

            function getPinjamanHdr(No_Pinj) {
                return new Promise(function (resolve, reject) {
                    $.ajax({
                       <%-- url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Invois_WS.asmx/getFullInvoisData") %>',--%>
                        url: '<%= ResolveUrl("~/FORMS/PINJAMAN/BAYAR BALIK/Pinj_BayarBalik_WS.asmx/LoadMaklumatPinjaman") %>',
                        method: "POST",
                        data: JSON.stringify({
                            No_Pinj: No_Pinj

                        }),
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        success: async function (data) {
                            debugger
                            data = JSON.parse(data.d)
                            data = data.Payload
                            fillPinjamanHdr(data[0])
                            retrieveInfoPenjamin(data[0].No_Pinj)
                            retrieveInfoPotonganGaji(data[0].No_Staf)
                            retrieveSummaryPotonganGaji(data[0].No_Staf)
                            showinfotab(data[0].Kategori_Pinj)
                            resolve(true)
                        },
                        error: function (xhr, status, error) {
                            console.error(error);
                            reject(false)
                        }
                    })
                })
            }

            function getMaklumatPenjamin(No_Staf) {
                return new Promise(function (resolve, reject) {
                    $.ajax({
                       <%-- url: '<%= ResolveUrl("~/FORMS/PEMBAYARAN/Invois_WS.asmx/getFullInvoisData") %>',--%>
                        url: '<%= ResolveUrl("~/FORMS/PINJAMAN/BAYAR BALIK/Pinj_BayarBalik_WS.asmx/LoadMaklumatPenjamin") %>',
                        method: "POST",
                        data: JSON.stringify({
                            No_Staf: No_Staf

                        }),
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        success: async function (data) {
                            debugger
                            data = JSON.parse(data.d)
                            data = data.Payload
                            fillMaklumatPenjamin(data[0])
                            $("#totalPotongan").text(data[0].totpotongan)
                            resolve(true)
                        },
                        error: function (xhr, status, error) {
                            console.error(error);
                            reject(false)
                        }
                    })
                })
            }

            function retrieveInfoPenjamin(No_Pinj) {
                $.ajax({
                    url: '<%= ResolveUrl("~/FORMS/PINJAMAN/BAYAR BALIK/Pinj_BayarBalik_WS.asmx/loadInfoPenjamin") %>',
                    method: "POST",
                    data: JSON.stringify({
                        No_Pinj: No_Pinj,
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        debugger
                        data = JSON.parse(data.d)
                        tblPenjamin.clear()
                        tblPenjamin.rows.add(data.Payload).draw()
                        //tblPotongan.clear()
                        //tblPotongan.rows.add(data.Payload).draw()
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                    }
                })
            }

            function retrieveInfoPotonganGaji(no_staf) {
                $.ajax({
                    url: '<%= ResolveUrl("~/FORMS/PINJAMAN/BAYAR BALIK/Pinj_BayarBalik_WS.asmx/loadInfoPotonganGaji") %>',
                    method: "POST",
                    data: JSON.stringify({
                        no_staf: no_staf,
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        data = JSON.parse(data.d)
                        tblPotongan.clear()
                        tblPotongan.rows.add(data.Payload).draw()
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                    }
                })
            }

            function retrieveSummaryPotonganGaji(no_staf) {
                $.ajax({
                    url: '<%= ResolveUrl("~/FORMS/PINJAMAN/BAYAR BALIK/Pinj_BayarBalik_WS.asmx/loadSummaryPotonganGaji") %>',
                    method: "POST",
                    data: JSON.stringify({
                        no_staf: no_staf,
                    }),
                    dataType: "json",
                    contentType: "application/json;charset=utf-8",
                    success: function (data) {
                        debugger;
                        data = JSON.parse(data.d)
                        data = data.Payload
                        $("#totalPotongan").text(data[0].totpotongan)
                        $("#totalPotonganSum").val(data[0].totpotongan)
                        $("#totalGajiSum").val(data[0].gajipluselaun)
                        $("#perPotonganSum").val(data[0].potonganpercent)
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                    }
                })
            }

            var cachePinjaman = null
            function fillPinjamanHdr(pinj) {
                cachePinjaman = pinj
                $("#txtnopinj").val(pinj.No_Pinj)
                $("#txtnama").val(pinj.Nama)
                $("#txtnostaff").val(pinj.No_Staf)
                $("#txtbaucar").val(pinj.No_Baucer)
                $("#txtnocek").val(pinj.No_Cek)

                $("#txtnokp").val(pinj.nokp)
                $("#txtdob").val(pinj.MS01_TkhLahir)
                $("#txtumur").val(pinj.AgeFormatted)
                $("#txttarafpkhd").val(pinj.Taraf)
                $("#txtkumppkhd").val(pinj.Kumpulan)
                $("#txtgredgaji").val(pinj.MS02_GredGajiS)
                $("#txtjawatan").val(pinj.Jawatan)
                $("#txtgajipokok").val(pinj.MS02_JumlahGajiS)
                $("#txtjabatan").val(pinj.Pejabat)
                $("#txtvoipno").val(pinj.MS01_VoIP)
                $("#txttarikhsah").val(pinj.MS02_TkhSah)
                $("#txttarikhlantikan").val(pinj.MS02_TkhLapor)
                $("#txtnolesen").val(pinj.No_Lesen)
                $("#txtkelasmemandu").val(pinj.Kod_Kelas_Lesen)
                $("#txttkhtmtlesen").val(pinj.Tkh_Tmt_Lesen_Formatted)

                $("#txtkatpinj").val(pinj.Kat_Pinj_Desc)
                $("#txttkhmohon").val(pinj.Tkh_Mohon_Formatted)
                $("#txtamaunmohon").val(pinj.Amaun_Mohon_Formatted)
                $("#txtjenpinj").val(pinj.Jenis_Pinj_Desc)
                $("#txttkhlulus").val(pinj.Tkh_Lulus_Formatted)
                $("#txtamaunlulus").val(pinj.Amaun_Formatted)
                $("#txttempoh").val(pinj.Tempoh_Pinj)
                $("#txtansuran").val(pinj.Ansuran_Formatted)
                $("#txtkelayakan").val(pinj.Status_Layak_Desc)
                $("#txtkendSediaAda").val(pinj.Kend_Sediada)
                $("#txtjwtnPerluKend").val(pinj.Jwtn_Perlu_Kereta)

                $("#txtmodel").val(pinj.Model)
                $("#txtbuatan").val(pinj.Buatan)
                $("#txthargabersih").val(pinj.Harga_Bersih)
                $("#txtsukatsilinder").val(pinj.Sukat_Silinder)
                $("#txtnochasis").val(pinj.No_Casis)
                $("#txtnoenjin").val(pinj.No_Enjin)

                $("#jenispinjkomp").val(pinj.jenispinjkomp || ' - ');
                $("#jenamakomp").val(pinj.jenamakomp || ' - ');
                $("#kapasiticakera").val(pinj.kapasiticakera || ' - ');
                $("#ram").val(pinj.ram || ' - ');
                $("#jenamamonitor").val(pinj.jenamamonitor || ' - ');
                $("#jenamapencetak").val(pinj.jenamapencetak || ' - ');
                $("#papankekunci").val(pinj.papankekunci || ' - ');
                $("#jenamamodem").val(pinj.jenamamodem || ' - ');
                $("#pemacucakera").val(pinj.pemacucakera || ' - ');
                $("#tetikus").val(pinj.tetikus || ' - ');
                $("#hargakomp").val(pinj.hargakomp || ' - ');
                $("#kadbunyi").val(pinj.kadbunyi || ' - ');

                $("#jenispinjsukan").val(pinj.jenispinjsukan || ' - ');
                $("#hargasukan").val(pinj.hargasukan || ' - ');
            }

            var cachePenjamin = null
            function fillMaklumatPenjamin(penjamin) {
                cachePenjamin = penjamin
                $("#txtpenjaminnostaf").val(penjamin.MS01_NoStaf)
                $("#txtpenjaminnama").val(penjamin.MS01_Nama)
                $("#txtpenjamindob").val(penjamin.MS01_TkhLahir)
                $("#txtpenjamintkhsah").val(penjamin.MS02_TkhSah)
                $("#txtpenjamintaraf").val(penjamin.tarafkhidmat)
                $("#txtpenjaminkump").val(penjamin.kumpulan)
                $("#txtpenjaminjawatan").val(penjamin.jawatan)
                $("#txtpenjaminjabatan").val(penjamin.pejabat)
                $("#txtpenjaminhutang").val(penjamin.butiranhutang)
            }

            function showinfotab(Kategori_Pinj) {
                if (Kategori_Pinj == 'K00001') {
                    showTab('#InfoKenderaan')
                    hideTab('#InfoSukan');
                    hideTab('#InfoKomputer');
                } else if (Kategori_Pinj == 'K00002') {
                    showTab('#InfoKomputer')
                    hideTab('#InfoKenderaan');
                    hideTab('#InfoSukan');
                } else if (Kategori_Pinj == 'K00003') {
                    showTab('#InfoSukan')
                    hideTab('#InfoKenderaan');
                    hideTab('#InfoKomputer');
                }
            }

            function hideTab(tabHref) {
                var tab = document.querySelector('a[href="' + tabHref + '"]');
                if (tab) {
                    tab.parentElement.style.display = 'none';
                }
            }

            function showTab(tabHref) {
                var tab = document.querySelector('a[href="' + tabHref + '"]');
                if (tab) {
                    tab.parentElement.style.display = 'block';
                }
            }

            $('.btnSimpan').click(async function () {
                $('#confirmationModal').modal('toggle');
            })

            // confirmation button in confirmation modal
            $('.btnYaConfirmation').click(async function () {
                debugger
                //close modal confirmation
                $('#confirmationModal').modal('toggle');
                let fulldata = cachePinjaman
                let startingMonth = $("#ddlBulanPotongan").val()
                let startingYear = $("#ddlTahunPotongan").val()
                let errmsg = null
                let res = await saveProsesBayarBalik(fulldata, startingMonth, startingYear).catch(function (err) {
                    console.log(err)
                    errmsg = err
                })
                if (res != null) {
                    notification(res)
                    return
                }
                else {
                    notification(errmsg)
                }
            });

            function notification(msg) {
                $("#notify").html(msg)
                $("#NotifyModal").modal('show');
            }

            function saveProsesBayarBalik(pinjaman, startingMonth, startingYear) {
                debugger
                return new Promise(function (resolve, reject) {
                    let url = '<%= ResolveUrl("~/FORMS/PINJAMAN/BAYAR BALIK/Pinj_BayarBalik_WS.asmx/saveProsesBayarBalik") %>'
                    $.ajax({
                        url: url,
                        method: "POST",
                        data: JSON.stringify({
                            "pinjaman": pinjaman,
                            "startingMonth": startingMonth,
                            "startingYear": startingYear,
                        }),
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        success: function (data) {
                            debugger
                            console.log(data)
                            var jsondata = JSON.parse(data.d)
                            if (jsondata.Code == "200") {
                                resolve(jsondata.Message)
                            }
                            else {
                                reject(jsondata.Message)
                            }
                        }
                    })
                })

            }

            $('.tutupButton').on('click', async function () {
                location.reload();
            });

            $('.btnreset').on('click', async function () {
                location.reload();

            });

        </script>
    </contenttemplate>
</asp:Content>