<%@ Page Title="" Language="vb" AutoEventWireup="false"  CodeBehind="loginsmkb.aspx.vb" Inherits="SMKB_Web_Portal.loginsmkb" %>

<html lang="en">
   <head>
      <title>SMKB</title>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

      <link rel="stylesheet" href="Content/css/login.css">

	   	
           <!-- CSS LOCAL -->
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/Content/css/styles.css")%>" />
    <%--<link rel="stylesheet" href="<%=ResolveClientUrl("~/Content/css/styles.css?ver=1.0")%>" />--%>
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/Content/css/dropdown.min.css")%>" />
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/Content/css/bootstrap.min.css")%>" />
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/Content/css/transition.min.css")%>" />
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/Content/css/stylemenu.css")%>" />
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/Content/css/jquery.dataTables.min.css")%>" />

     <link rel="stylesheet" href="Content/css/loader.css" />

    <!-- FONT LINK -->
    <%--<link href="Content/font-awesome/css/style.css" rel="stylesheet" />--%>

    <!-- ICON LINK -->
    <%--<link rel="stylesheet" href="<%=ResolveClientUrl("~/Content/css/line-awesome.min.css")%>">
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/Content/css/all.min.css")%>">
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/Content/css/fonts_Poppins.css")%>">
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/Content/css/font-awesome.min.css")%>">--%>
    <link rel="stylesheet"
        href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <link rel="stylesheet"
        href="https://maxst.icons8.com/vue-static/landings/line-awesome/font-awesome-line-awesome/css/all.min.css">

    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">--%>
    
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">	
    	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <!-- SCRIPT CDN -->
    <script src="<%=ResolveClientUrl("~/Content/js/SharedFunction.js")%> "></script>
    <script src="<%=ResolveClientUrl("~/Content/js/jquery.min.js")%> "></script>
    <script src="<%=ResolveClientUrl("~/Content/js/jquery.dataTables.min.js")%> "></script>
    <script src="<%=ResolveClientUrl("~/Content/js/popper.min.js")%>" crossorigin="anonymous"></script>
    <script src='<%=ResolveClientUrl("~/Content/js/bootstrap.min.js")%>'></script>
    <script src="<%=ResolveClientUrl("~/Content/js/selectize.min.js")%>" crossorigin="anonymous"></script>
    <script src="<%=ResolveClientUrl("~/Content/js/api.min.js")%>" crossorigin="anonymous"></script>
    <script src="<%=ResolveClientUrl("~/Content/js/transition.min.js")%>" crossorigin="anonymous"></script>
    <script src="<%=ResolveClientUrl("~/Content/js/dropdown.min.js")%>" crossorigin="anonymous"></script>
    <script src='<%=ResolveClientUrl("~/Content/script/d_loader.js")%>'></script>
    <script src="<%=ResolveClientUrl("~/Content/js/xlsx.full.min.js")%> "></script>
  

   <style>
	   
	  		.menu-card {
			background: #FFFFFF;
			border: 1px solid #CDCDCD;
			border-radius: 10px;
			padding: 30px;
			display: flex;
			flex-direction: column;
			justify-content: center;
			align-items: center;
			height: 170px;
			margin-bottom: 30px;
			cursor: pointer;
			
		}
		
		.menu-card:hover {
			filter: drop-shadow(0px 1px 10px rgba(0, 0, 0, 0.25));
			transition: all 200ms ease-out;
			background: #0d1b86;
			color:#FFFFFF;
		}	
	   
	   
	   .center2 {
			display: block;
			margin-left: auto;
			margin-right: auto;
			width: 50%;
		}
	   
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
   </style>
   </head>
   <body>


       <div class="texttengah2 headersmu3">
           <div class="container">
               <div class="row">
                   <span class="col-md-8">Selamat Datang Ke Sistem Maklumat Kewangan Bersepadu </span>
                

               </div>
           </div>
       </div>

       <div class="modal fade" id="myModal4" role="dialog" data-backdrop="static" data-keyboard="false">
           <div class="modal-dialog modal-dialog-centered">
               <div class="modal-content">
                   <div class="modal-header">
                       <h6 class="modal-title center1">Helpdesk</h6>
                       <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                   </div>
                   <div class="modal-body">
                       <span><strong>Helpdesk System</strong><br />
                       </span>
                       <span>No Tel:<a href="tel:+062701101">+06 270 1101</a> | Email:<a href="mailto:helpdeskinfo@utem.edu.my">helpdeskinfo@utem.edu.my</a><br />
                           <br />
                       </span>
                   </div>

               </div>
           </div>
       </div>
	   
		  
      <section class="ftco-section">
         <div class="container">

             <div class="row justify-content-center">

                 <div class="col-md-6 text-center mb-5">
                 </div>
             </div>
             <div class="row justify-content-center">
                 <div class="col-md-12 col-lg-10">
                     <div class="wrap d-md-flex">
                         <div class="img" style="background-image: url(Content/images/img_log.jpg);">
                         </div>
                         <div class="login-wrap p-4 p-md-5">
                             <img src="Content/images/utemlogo.png" class="center1"><br />
                             <div class="d-flex">
                                 <!-- 
                              <div class="w-100">
                                 			<h3 class="mb-4">Login</h3>
                                 		</div>
                              -->
                             </div>
                             <form action="#" class="signin-form" runat="server"  >
                                 <div class="form-group mb-3">
                                     <label class="label" for="name"><i class="fa fa-user icon"></i>User Id  </label>
                                     <a href="#" data-toggle="tooltip" title="Please do not use space or - eg:03999 "><i class="fa fa-question-circle" aria-hidden="true"></i></a>
                                     <input type="text" runat="server" id="txtIdStaf" name="txtIdStaf"  class="form-control txtIdStaf" placeholder="" readonly>
                                 </div>

                                 <div class="form-group mb-3">
                                     <label class="label" for="password"><i class="fa fa-key icon"></i>Password </label>
                                     <input type="password" runat="server" id="txtPassStaf" name="txtPassStaf" class="form-control txtPwd" placeholder="" required>
                                 </div>

                                 <div class="form-group mb-3"> <asp:LinkButton ID="btnLogin" runat="server"  class="form-control btn btn-primary rounded submit px-3 btnSimpan" >
                        &nbsp;&nbsp;&nbsp;Login
                                                            </asp:LinkButton><asp:HiddenField  ID="HdIdToken" runat="server"/>
                                 </div>
                             </form>

                             <div class="container" style="visibility:hidden">
                                 <div class="row">
                                     <div class="col-6">
                                         <a href="#" data-toggle="modal" data-target="#myModal3" data-backdrop="static" data-keyboard="false"><span class="float-left">Forgot Password</span></a>
                                         <div class="modal fade" id="myModal3" role="dialog">
                                             <div class="modal-dialog modal-dialog-centered">
                                                 <div class="modal-content">
                                                     <div class="modal-header">
                                                         <h6 class="modal-title center1">Forgot Password</h6>
                                                         <button type="button" class="close float-right" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                                     </div>
                                                     <div class="modal-body" style="padding: 10px 50px;">
                                                         <p>Please enter the information below to get a new password.</p>
                                                         <form role="form">
                                                             <div class="form-group">
                                                                 <label class="label" for="name"><i class="fa fa-user icon"></i>User ID</label>
                                                                 <a href="#" data-toggle="tooltip" title="User ID"><i class="fa fa-question-circle" aria-hidden="true"></i></a>
                                                                 <input type="text" class="form-control" placeholder="" required>
                                                             </div>
                                                             <div class="form-group mb-3">
                                                                 <label class="label" for="password"><i class="fa fa-id-card"></i>Passport No. / IC No.</label>
                                                                 <a href="#" data-toggle="tooltip" title="Without '-' and spaces eg:931213045221 / B661233 "><i class="fa fa-question-circle" aria-hidden="true"></i></a>
                                                                 <input type="text" class="form-control" placeholder="" required>
                                                             </div>
                                                         </form>
                                                     </div>
                                                     <div class="modal-footer">
                                                         <button type="button" class="btn buttonclose" data-dismiss="modal">Cancel</button>
                                                         <button type="button" class="btn buttonbiru" data-dismiss="modal">Submit</button>
                                                     </div>
                                                 </div>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                             </div>


                         </div>
                     </div>
                 </div>



             </div>
         </div>  	  
		  	  
		  	        <div class="modal fade" id="maklumanExpiredLink" tabindex="-1" role="dialog"  aria-labelledby="maklumanExpiredLink" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header modal-header--sticky">
                                <h5 class="modal-title" id="maklumanModalLabelBil_Hantar">Makluman</h5>
                               
                            </div>
                            <div class="modal-body">
                                Maaf, link diberikan tidak aktif. Anda akan dibawa ke Portal UTeM.
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn default-primary" id="tutupMaklumanBil_Hantar"
                                    data-dismiss="modal">Tutup</button>
                            </div>
                        </div>
                    </div>
                </div>	  
      </section>
   
	  <!-- Toottip script -->
   <%--   <script>$(document).ready(function () {
              $('[data-toggle="tooltip"]').tooltip();
        });

        
      </script>
	  
       <script>
           //$('.btnSimpan').click(async function () {
               
           //    var jumRecord = 0;
           //    var acceptedRecord = 0;
           //    var msg = "";
           //    var newOrder = {
           //        order: {

           //            Id_Staf: $('#txtIdStaf').val(),
           //            Password: $('#txtPwd').val()

           //        }
           //    }


           //    var result = JSON.parse(await ajakLogin(newOrder));         

           //});

           //async function ajakLogin(order) {
           //    //console.log(order)
           //    return new Promise((resolve, reject) => {
           //        $.ajax({
           //            url: 'PenyataBank_WS.asmx/SaveOrders',
           //            method: 'POST',
           //            data: JSON.stringify(order),
           //            dataType: 'json',
           //            contentType: 'application/json; charset=utf-8',
           //            success: function (data) {
           //                resolve(data.d);
           //                //alert(resolve(data.d));
           //            },
           //            error: function (xhr, textStatus, errorThrown) {
           //                console.error('Error:', errorThrown);
           //                reject(false);
           //            }

           //        });
           //    })

           //}

       </script>--%>
	 
	   
   </body>
</html>