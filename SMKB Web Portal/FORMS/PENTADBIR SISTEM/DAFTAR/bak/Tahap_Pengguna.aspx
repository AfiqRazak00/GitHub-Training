<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.Master" CodeBehind="Tahap_Pengguna.aspx.vb" EnableEventValidation="False" Inherits="SMKB_Web_Portal.Tahap_Pengguna" %>

<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    TAHAP PENGGUNA

        <div id="DaftarModul" class="tabcontent" style="display:block">
                    <div class="table-title">
                        <h6>Senarai Modul</h6>

                        <div class="btn btn-primary" data-toggle="modal" data-target="#MessageModal">+ Tambah Modul
                        </div>
                    </div>
                    <div class="filter-table-function">
                        <div class="show-record">
                            <p>Tunjukkan</p>
                            <select class="form-control">
                                <option>5</option>
                                <option>10</option>
                                <option>20</option>
                                <option>50</option>
                            </select>
                            <p>Rekod</p>
                        </div>
                        <div class="search-form">
                            <input class="form-control" type="text" placeholder="Cari">
                        </div>
                    </div>
                    <div class="table-list table-responsive">
                        <table class="table table-striped table-bordered">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">First</th>
                                    <th scope="col">Last</th>
                                    <th scope="col">Handle</th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr>
                                    <td colspan="4" class="data-table-empty">Tiada Rekod Ditemui</td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                    <div class="table-navigation">
                        <div class="table-record">
                            <p>Jumlah Rekod: 25</p>
                        </div>
                        <div class="table-page-nav">
                            <nav aria-label="...">
                                <ul class="pagination">
                                    <li class="page-item disabled">
                                        <span class="page-link">Sebelumnya</span>
                                    </li>
                                    <li class="page-item"><a class="page-link" href="#">1</a></li>
                                    <li class="page-item active">
                                        <span class="page-link">
                                            2
                                            <span class="sr-only">(current)</span>
                                        </span>
                                    </li>
                                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item">
                                        <a class="page-link" href="#">Seterusnya</a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>

                    <!-- Modal -->
                    <div class="modal fade" id="ModulForm" tabindex="-1" role="dialog"
                        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Tambah Modul Baharu</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>

                                <div class="modal-body">
                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label for="kodModul">Kod Modul</label>
                                            <input type="text" class="form-control" id="kod" placeholder="Kod Modul">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label for="kodModul">Nama Modul</label>
                                            <input type="text" class="form-control" id="kod" placeholder="Nama Modul">
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="kodModul">Nama Paparan</label>
                                        <input type="text" class="form-control" id="kod" placeholder="Nama Paparan">
                                    </div>

                                    <div class="form-row">
                                        <div class="form-group col-md-6">
                                            <label for="kodModul">Urutan</label>
                                            <input type="number" class="form-control" id="kod" placeholder="Urutan">
                                        </div>
                                        <div class="form-group col-md-6">
                                            <label>Status</label>
                                            <div class="radio-btn-form">
                                                <div class="form-check form-check-inline radio-size">
                                                    <input class="form-check-input" type="radio"
                                                        name="inlineRadioOptions" id="inlineRadio1" value="option1">
                                                    <label class="form-check-label" for="inlineRadio1">1</label>
                                                </div>
                                                <div class="form-check form-check-inline radio-size">
                                                    <input class="form-check-input" type="radio"
                                                        name="inlineRadioOptions" id="inlineRadio2" value="option2">
                                                    <label class="form-check-label" for="inlineRadio2">2</label>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Tutup</button>
                                    <button type="button" class="btn btn-secondary">Simpan</button>
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
                                        data-target="#ModulForm" data-dismiss="modal">Ya</button>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
</asp:Content>
