<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/NestedMasterPage2.master" CodeBehind="WebForm5.aspx.vb" Inherits="SMKB_Web_Portal.WebForm5" %>
<asp:Content ID="Content1" ContentPlaceHolderID="FormContents" runat="server">

    <script>
        //table MesyPembuka
        var tbl = null;
        var isClicked6 = false;
        $(document).ready(function () {
            tbl = $("#tblKelulusan").DataTable({
                "responsive": true,
                "searching": true,
                "info": false,
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
                    url: '<%= ResolveClientUrl("~/FORMS/PEROLEHAN/PermohonanPoWS.asmx/LoadMesyPH") %>',
                   //"url": "PermohonanPoWS.asmx/LoadKelulusanPo",
                   type: 'POST',
                   "contentType": "application/json; charset=utf-8",
                   "dataType": "json",
                   "dataSrc": function (json) {
                       return JSON.parse(json.d);
                   },
                   "data": function () {

                       var startDate = $('#txtTarikhStart').val()
                       var endDate = $('#txtTarikhEnd').val()

                       return JSON.stringify({
                           category_filter: $('#categoryFilter').val(),
                           isClicked6: isClicked6,
                           tkhMula: startDate,
                           tkhTamat: endDate
                       })
                   }
               },
               "rowCallback": function (row, data) {
                   // Add hover effect
                   $(row).hover(function () {
                       $(this).addClass("hover pe-auto bg-warning");
                   }, function () {
                       $(this).removeClass("hover pe-auto bg-warning");
                   });
                   // Add click event ---> untuk baca/get data dari db
                   $(row).on("click", function () {
                       console.log(data);
                       var rowData = data;

                       no_mohon = rowData.No_Mohon;
                       // Update the modal content with the No_Mohon and Tujuan values
                       $("#lblStatus1").val(rowData.IDMesy); //BOLEH GUNA NO MOHON UNTUK KELUARKAN DATA
                       $("#lblStatus2").val(rowData.Tempat);
                       $("#lblStatus3").val(rowData.TarikhMasa);

                   });
               },
               "columns": [

                   {
                       "data": "Bil",
                       render: function (data, type, row, meta) {
                           return meta.row + meta.settings._iDisplayStart + 1;
                       },
                       "width": "5%"
                   },
                   {
                       "data": "IDMesy",
                       "width": "10%"
                   },
                   {
                       "data": "Kod_JK",
                       "width": "20%"
                   },
                   {
                       "data": "Tempat",
                       "width": "20%"
                   },
                   {
                       "data": "TarikhMasa",
                       //"type": "date", // This is optional but helps with sorting
                       //render: function (data, type, row) {
                       // Format the date using moment.js
                       //return moment(data).format('DD/MM/YYYY'); // Adjust the format as needed
                       //},
                       "width": "10%"
                   }
                   //{
                   //    "data": null,
                   //    "defaultContent": '<i onclick="ShowPopup(1)" class="fa fa-ellipsis-h fa-lg"></i>',
                   //    "className": "text-center", // Center the icon within the cell
                   //    "width": "5%"
                   //}
               ]
           });

           $('.btnSearch').click(async function () {
               show_loader();
               isClicked6 = true;
               tbl.ajax.reload();
           })

       });

        $("#categoryFilter").change(function (e) {
            var selectedItem = $('#categoryFilter').val()
            if (selectedItem == "6" && selectedItem !== "") {
                $('#divDatePicker').addClass("d-flex").removeClass("d-none");
                $('#txtTarikhStart').val("")
                $('#txtTarikhEnd').val("")
            }
            else {
                $('#divDatePicker').removeClass("d-flex").addClass("d-none");
                $('#txtTarikhStart').val("")
                $('#txtTarikhEnd').val("")
            }
        });
    </script>
</asp:Content>
