<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="Individu.aspx.vb" Inherits="SMKB_Web_Portal.Individu" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">
    <style>

</style>
<div id="PermohonanTab" class="tabcontent" style="display: block">
<%--    <div class="table-title">
        <label id="lblTajuk" ><u></u></label>
        <hr>
    </div>--%>
    <div class="table-title">
        
<%--        <div class="col-sm-6 col-md-6">
            <div class="card border-white">
                <div class="card-header" style="text-align: left">
                    <label id="lbl1" style="color:blue;font-size:17px"></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label runat="server" ID="lblNoStaf"  Style="width: 100%;color:blue;font-size:17px" ></asp:Label>    
                    <asp:Label runat="server" ID="lblNama"  Style="width: 100%;color:blue;font-size:17px" ></asp:Label>  
                    <label id="hidNostaf" style="visibility:hidden"></label>
                    <label id="hidSave" style="visibility:hidden"></label>
                </div>
            </div>
        </div>--%>
        <div class="col-sm-6 col-md-3">
        </div>  
        &nbsp;&nbsp; 
    </div>
       
        <div class="form-row">
             
            <div class="col-md-12">
                
                <div class="transaction-table table-responsive">
                    
                    <table id="tblListMaster" class="table table-striped" style="width:100%">
                        <thead>
                            <tr>
                                <th scope="col" style="width:30px">Sumber</th>
                                <th scope="col" style="width:70px">Jenis Transaksi</th>
                                <th scope="col" style="width:50px">Kod Transaksi</th>
                                <th scope="col" style="width:70px">Tarikh Mula</th>
                                <th scope="col" style="width:70px">Tarikh Tamat</th>
                                <th scope="col" style="width:70px">Amaun (RM)</th>
                                <th scope="col" style="width:100px">No. Rujukan</th>
                                <th scope="col" style="width:120px">Catatan</th>
                                <th scope="col" style="width:50px">Status</th>
                            </tr>
                        </thead>
                        <tbody id="tableID_ListMaster">
                                        
                        </tbody>

                    </table>
                </div>
            </div>                  
        </div>

      <!-- Modal -->
    <div class="modal fade" id="infostaf" tabindex="-1" role="dialog"
        aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="fMCTitle">Maklumat Staf</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <h6 style="color:blue"><b>Maklumat Butiran Staf</b></h6>
                        <hr>
        
                        <div class="form-row">
                            <div class="form-group col-md-3">

                                <asp:TextBox runat="server" ID="txtNoStaf" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>       
                                 <label class="input-group__label" for="No. Staf">No. Staf</label>

                            </div>

                            <div class="form-group col-md-3">
                                <asp:TextBox runat="server" ID="txtNoKp" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="No. KP">No. KP</label>
                            </div>
                            <div class="form-group col-md-3">
                         
                                <asp:TextBox runat="server" ID="txtGjPokok" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Gaji Pokok">Gaji Pokok</label>
                            </div>
                            <div class="form-group col-md-3">
                   
                                <asp:TextBox runat="server" ID="txtStatus" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Status">Status</label>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-3">

                                <asp:TextBox runat="server" ID="txtNama" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                 <label class="input-group__label" for="Nama">Nama</label>           
                            </div>

                            <div class="form-group col-md-3">
 
                                <asp:TextBox runat="server" ID="txtJwtn" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Jawatan">Jawatan</label>     
                            </div>
                            <div class="form-group col-md-3">
                
                                <asp:TextBox runat="server" ID="txtPjbt" Enabled="false" CssClass="input-group__input" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Pejabat">Pejabat</label> 
                                
                            </div>
                           <div class="form-group col-md-3">
                       
                                <asp:TextBox runat="server" ID="txtTaraf" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                               <label class="input-group__label" for="Taraf">Taraf</label> 
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-3">
                        
                                <asp:TextBox runat="server" ID="txtGred" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Gred Gaji">Gred Gaji</label>
                                             
                            </div>

                            <div class="form-group col-md-3">
                           
                                <asp:TextBox runat="server" ID="txtTkhLantik" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Tarikh Lantik">Tarikh Lantik</label>
                            </div>

                            <div class="form-group col-md-3">
                                
                                <asp:TextBox runat="server" ID="txtSkim" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Skim">Skim</label>
                            </div>
                           <div class="form-group col-md-3">
                                
                                <asp:TextBox runat="server" ID="txtPilihan" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                               <label class="input-group__label" for="Pilihan">Pilihan</label>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-3">
                              
                                <asp:TextBox runat="server" ID="txtNoPencen" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="No. Pencen">No. Pencen</label>
                                             
                            </div>

                            <div class="form-group col-md-3">
                           
                                <asp:TextBox runat="server" ID="txtNoKwsp" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="No. KWSP">No. KWSP</label>
                            </div>

                            <div class="form-group col-md-3">
                       
                                <asp:TextBox runat="server" ID="txtNoPerkeso" CssClass="input-group__input" Enabled="True" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="No. Perkeso">No. Perkeso</label>
                            </div>
                           <div class="form-group col-md-3">
                     
                                <asp:TextBox runat="server" ID="txtNoCukai" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                               <label class="input-group__label" for="No. Cukai">No. Cukai</label>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-3">
       
                                <asp:TextBox runat="server" ID="txtBank" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                 <label class="input-group__label" for="Bank">Bank</label>
                                             
                            </div>

                            <div class="form-group col-md-3">
                                
                                <asp:TextBox runat="server" ID="txtNoAcc" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                 <label class="input-group__label" for="No. Akaun">No. Akaun</label>
                            </div>
                            <div class="form-group col-md-3">
                 
                                <asp:TextBox runat="server" ID="txtUmur" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                 <label class="input-group__label" for="Umur">Umur</label>
                            </div>
                        </div>
                    <h6 style="color:blue"><b>Maklumat Butiran Gaji</b></h6>
                        <hr>
        
                        <div class="form-row">
                            <div class="form-group col-md-4">
   
                                <asp:TextBox runat="server" ID="txtKwspPek" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>   
                                <label class="input-group__label" for="KWSP Pekerja (%)">KWSP Pekerja (%)</label>
                            </div>

                            <div class="form-group col-md-4">
         
                                <asp:TextBox runat="server" ID="txtKwspMaj" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="KWSP Majikan (%)">KWSP Majikan (%)</label>
                            </div>
                            <div class="form-group col-md-4">
                         
                                <asp:TextBox runat="server" ID="txtPencen" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                                <label class="input-group__label" for="Pencen (%)">Pencen (%)</label>
                            </div>
                        </div>
                        <div class="form-row">
                           <div class="form-group col-md-4">

<%--                                <asp:TextBox runat="server" ID="txtKatCukai" CssClass="input-group__input" Enabled="false" Style="width: 100%;" ></asp:TextBox>
                               <label class="input-group__label" for="Kategori Cukai">Kategori Cukai</label>--%>
                            </div>
                            <div class="form-group col-md-4">
                     
             <%--                       <asp:DropDownList ID="ddlKatSocso" runat="server" CssClass="input-group__select ui search dropdown" Width="70px">

                                    </asp:DropDownList>
                                   <label class="input-group__label" for="Kategori Perkeso">Kategori Perkeso</label>--%>
                            </div>

                            <div class="custom-control custom-checkbox">
                                <input type="checkbox" class="custom-control-input" id="chkTahanGaji">
                                <label class="custom-control-label" for="chkTahanGaji">Tahan Gaji</label>

                            </div>

      
                        </div>

                </div>

            </div>
        </div>
    </div>
    <!-- End Modal -->

</div>
<script type="text/javascript">
    var tbl = null;
    var nostaf = '<%=Session("ssusrID")%>'
    
    $(document).ready(function () {
        
        tbl = $("#tblListMaster").DataTable({
            "responsive": true,
            "searching": true,
            "rowCallback": function (row, data) {
                // Add hover effect
                //$(row).hover(function () {
                //    $(this).addClass("hover pe-auto bg-warning");
                //}, function () {
                //    $(this).removeClass("hover pe-auto bg-warning");
                //});
            },
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
                url: 'Pertanyaan_WS.asmx/LoadListMaster',
                type: 'POST',
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                "dataSrc": function (json) {
                    return JSON.parse(json.d);
                },
                "data": function () {
                    //var startDate = $('#txtTarikhStart').val();
                    //var endDate = $('#txtTarikhEnd').val();
                    return JSON.stringify({nostaf : nostaf})
                    console.log("Data sent to server:", data);
                    return JSON.stringify(data);
                },
                "error": function (xhr, error, thrown) {
                    console.log("Ajax error:", error);
                }
            },
            columnDefs: [
                { targets: [5] }
            ],
            "columns": [
                { "data": "Kod_Sumber", className: "text-center" },
                { "data": "Jenis_Trans", className: "right-center" },
                { "data": "Kod_Trans", className: "right-center" },
                { "data": "Tkh_Mula", className: "text-center" },
                { "data": "Tkh_Tamat", className: "text-center" },
                { "data": "Amaun", className: "text-right", render: $.fn.dataTable.render.number(',', '.', 2, '') },
                { "data": "no_trans", className: "text-center" },
                { "data": "catatan" },
                { "data": "status", className: "text-center" }
            ],
            //createdRow: function (row, data, dataIndex) {
            //    row.dataset.idrujukan = data["no_staf"]
            //    row.onclick = showInvoisData
            //}

        });
       // loadList();
    });


    async function showInvoisData(e) {
        var target = e.target
        if (target.tagName == "TD") {
            target = target.parentElement
        }
        //show_loader()
        let invHdr = await getInvoisHdr(target.dataset.idrujukan)
        //close_loader()

        $("#infostaf").modal('show');
    }

    function getInvoisHdr(nostaf) {
       // alert(nostaf);
        return new Promise(function (resolve, reject) {
            $.ajax({

                url: '<%= ResolveUrl("Pertanyaan_WS.asmx/LoadRekodStaf") %>',
                method: "POST",
                data: JSON.stringify({
                    nostaf: nostaf

                }),
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                success: async function (data) {
                    data = JSON.parse(data.d)
                    data = data.Payload
                    //setInfoProsesStaf(data.hdr[0])
                    //console.log('Kat_Pij ' + data.hdr[0].Kategori_Pinj)
                    //retrive table ulasan
                    //retrieveUlasanSokongan(data.hdr[0].Kategori_Pinj)
                    resolve(true)
                },
                error: function (xhr, status, error) {
                    console.error(error);
                    reject(false)
                }
            })
        })
        }
   
    function ShowPopup(obj, elm) {
        if (elm == "1") {

            $('#infostaf').modal('toggle');

            getInfoStaf($(obj).text());
            getInfoProses($(obj).text());

        }
        else if (elm == "2") {
            //$(".modal-body input").val("");
            if ($('#lbl1').text() === "") {
                alert("Sila pilih rekod dari senarai staf diatas")
            }
            else {
                $('#tambahgaji').modal('toggle');
                $('#hidSave').text("1");
                $('#eMCTitle').text("Tambah Transaksi");
                $('#lblnostaf').text($('#lbl1').text());
                $('#lblnama').text($('#lbl2').text());

             }   

             
        } 
        clear();
    }
    function getInfoDet(obj) {
        alert($(obj).text());


    }
    function getInfoStaf(nostaf) {
        //Cara Pertama
        //alert(nostaf);
        fetch('Transaksi_WS.asmx/LoadRekodStaf', {
            method: 'POST',
            headers: {
                'Content-Type': "application/json"
            },
            //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify({ nostaf: nostaf })
        })
            .then(response => response.json())
            .then(data => setInfoStaf(data.d))

    }
    function getInfoProses(nostaf) {
        //Cara Pertama
        //alert(nostaf);
        fetch('Transaksi_WS.asmx/LoadProsesStaf', {
            method: 'POST',
            headers: {
                'Content-Type': "application/json"
            },
            //body: JSON.stringify({ nostaf: '<%'=Session("ssusrID")%>' })
            body: JSON.stringify({ nostaf: nostaf })
        })
            .then(response => response.json())
            .then(data => setInfoProsesStaf(data.d))

    }
    function upper(ustr) {
        var str = ustr.value;
        ustr.value = str.toUpperCase();
    }
    function setInfoProsesStaf(data) {
        data = JSON.parse(data);
        if (data.No_Staf === "") {
            alert("Tiada data");
            return false;
        }
        
        if (data[0].Proses_Gaji == true) {
            $('#chkGaji').attr('checked', true);
           
        }
        if (data[0].Proses_Kwsp == true) {
            $('#chkKwsp').attr('checked', true);

        }
<%--        if (data[0].Proses_Kwsp == true) {

            $('#<%='chkKwsp.ClientID%>').attr('checked', true);
        }--%>
        if (data[0].Proses_Cukai == true) {

            $('#chkCukai').attr('checked', true);
      
        }
        if (data[0].Proses_Perkeso == true) {
            $('#chkPerkeso').attr('checked', true);

        }
        if (data[0].Proses_Pencen == true) {
            $('#chkPencen').attr('checked', true);
        }

        if (data[0].Tahan_Gaji == true) {
            $('#chkTahanGaji').attr('checked', true);

        }

    }
    function setInfoStaf(data) {
        data = JSON.parse(data);
        if (data.MS01_NoStaf === "") {
            alert("Tiada data");
            return false;
        }

    }
    $('#tblListMaster').on('click', '.btnEdit', function () {

        $('#tambahgaji').modal('toggle');
        $('#hidSave').text("2");
        $('#eMCTitle').text("Kemaskini Transaksi");
        $('#lblnostaf').text($('#lbl1').text());
        $('#lblnama').text($('#lbl2').text());


    });
    $('#tblListMaster').on('click', '.btnDelete', function () {

        $('#tambahgaji').modal('toggle');
        $('#hidSave').text("3");
        $('#eMCTitle').text("Hapus Transaksi");
        $('#lblnostaf').text($('#lbl1').text());
        $('#lblnama').text($('#lbl2').text());

    });


    function formatDate(tkh) {
        var date1 = tkh.split('/')
        var newDate = date1[2] + '-' + date1[1] + '-' + date1[0];
        return newDate;
       // var date = new Date(newDate);
       // alert(newDate);
    }
    $('#tblListStaf').on('click', '.btnView', function () {
        
        var val = $(this).closest('tr').find('td:eq(0)').text(); // amend the index as needed
        //alert(val);
        //var curTR = $(this).closest("tr");
        //var recordID = curTR.find("td > .noStaf");
        var icheck = "";
        //var bool = true;
       // var id = recordID.val();
        $('#lbl1').text(val);
        $('#hidNostaf').text(val);
        $('#lbl2').text($(this).closest('tr').find('td:eq(1)').text());
        $('#lblTajuk').text('Senarai Transaksi Gaji Berstatus Aktif');


        icheck = 1;
        ListMaster(val, icheck);
        //var data = table.row($(this).parents('tr')).data();

        //alert(data[0] + "'s salary is: " + data[5]);


        
        //$("div.header").html('Charges list');
    });
    $('#tblListStaf').on('click', '.btnAll', function () {

        var val = $(this).closest('tr').find('td:eq(0)').text();
        //var curTR = $(this).closest("tr");
        //var recordID = curTR.find("td > .noStaf");
        var icheck = "";
        //var bool = true;
        //var id = recordID.val();
        $('#lbl1').text(val);
        $('#hidNostaf').text(val);
        $('#lbl2').text($(this).closest('tr').find('td:eq(1)').text());
        $('#lblTajuk').text('Senarai Transaksi Gaji Keseluruhan');
        //alert(id);
        icheck = 2;
        ListMaster(val, icheck);
       
    });
    $('#tblListStaf').on('click', '.btnStaf', function () {

        var val = $(this).closest('tr').find('td:eq(0)').text();
        //var curTR = $(this).closest("tr");
        //var recordID = curTR.find("td > .noStaf");
        ////var bool = true;
        //var id = recordID.val();
        

        $('#infostaf').modal('toggle');

        getInfoStaf(val);
        getInfoProses(val);

    });

    function loadList() {
        show_loader()
        $.ajax({
            url: '<%= ResolveUrl("Pertanyaan_WS.asmx/LoadListMaster") %>',
            method: "POST",
            data: JSON.stringify(),
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            success: function (data) {
                close_loader()

                data = JSON.parse(data.d)
                // console.log(data);
                tbl.clear();
                tbl.rows.add(data.Payload).draw();
                
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
</script>

</asp:Content>
