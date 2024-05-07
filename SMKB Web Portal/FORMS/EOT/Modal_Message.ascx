<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Modal_Message.ascx.vb" Inherits="SMKB_Web_Portal.Modal_Message" %>

       <!-- Modal message makluman -->
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
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Tutup</button>
                    </div>
                </div>
            </div>
        </div>

    <!--modal message pengesahan-->
        <div class="modal fade" id="MessageModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Pengesahan</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger btnTidak"
                            data-dismiss="modal">
                            Tidak</button>
                        <button type="button" class="btn btn-secondary btnYA" data-toggle="modal"
                            data-target="#ModulForm" data-dismiss="modal">
                            Ya</button>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">

            function show_message_async(msg, okfn, cancelfn) {

                $("#MessageModal .modal-body").text(msg);
                var decision = false
                return new Promise(function (resolve) {

                    $('.btnYA').click(function () {
                        console.log("rreessoollvveedd")
                        decision = true
                    });
                    $("#MessageModal").on('hidden.bs.modal', function () {
                        resolve(decision);
                    });


                    $("#MessageModal").modal('show');
                })

            }

            function Notification(msg) {
                $("#notify").html(msg);
                $("#NotifyModal").modal('show'); 
            }

        </script>