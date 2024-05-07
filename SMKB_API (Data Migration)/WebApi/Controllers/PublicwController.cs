using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using static WebApi.Controllers.PublicwController;
using System.Net.Sockets;
using System.Data.SqlClient;
using System.Data;
using System.Xml.Linq;
using System.Management.Automation.Language;

namespace WebApi.Controllers
{

    public class PublicwController : ApiController
    {
        public IEnumerable<string> Get()
        {
            string mm = "oo";
            return new string[] { "Connection OK " + mm };
        }

        // tran fer no token

        [Route("api/Publicw/Fill_Lejar")]
        [HttpPost]
        public async Task<HttpResponseMessage> Fill_Lejar()
        {

            //  string myticket = ticket.Ticket_id;
            string userid = "";
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];
            string data1 = request.Form["data1"];
            string data2 = request.Form["data2"];
            string data3 = request.Form["data3"];
            string data4 = request.Form["data4"];
            string data5 = request.Form["data5"];
            string data6 = request.Form["data6"];
            string data7 = request.Form["data7"];
            double data8 = double.Parse(request.Form["data8"]);
            string data9 = request.Form["data9"];
            string data10 = request.Form["data10"];
            string data11 = request.Form["data11"];
            if (SQLAuth.Check_ValidTicket(Ticket_id, "smkb", ref userid) == "yes")
            {
                try
                {

                    //HttpResponseMessage result = null;
                    IEnumerable<string> values2 = SQLsmkb.PostingLejar(data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11);
                    var myList2 = values2.ToList();
                    if (myList2[0] == "ok")
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, "ok");
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, myList2[0]);
                    }
                }
                catch (Exception)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "error");
                }
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, "invalidTicket");
            }
        }


        [Route("api/Publicw/Fill_LejarTest")]
        [HttpPost]
        public async Task<HttpResponseMessage> Fill_LejarTest()
        {

            //  string myticket = ticket.Ticket_id;
            string userid = "";
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];
            string data1 = request.Form["data1"];
            string data2 = request.Form["data2"];
            if (SQLAuth.Check_ValidTicket(Ticket_id, "smkb", ref userid) == "yes")
            {
                try
                {


                    return Request.CreateResponse(HttpStatusCode.OK, "xxxok " + data1);

                }
                catch (Exception)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, "error");
                }
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, "invalidTicket");
            }

        }
        //----------------

        //[Route("api/Publicw/get_KodPenghutang")]
        //[HttpPost]
        //public Task<HttpResponseMessage> get_KodPenghutang()
        //{
        //    var request = HttpContext.Current.Request;
        //    string Ticket_id = request.Form["Ticket_id"];
        //    string data1 = request.Form["data1"];

        //    HttpResponseMessage result = null;
        //    IEnumerable<string> values2 = SQLsmkb.getKodPenghutang(data1);
        //    var myList2 = values2.ToList();
        //    if (myList2[0] == "ok")
        //    {
        //        return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, "ok"));
        //    }
        //    else
        //    {
        //        return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myList2[0]));
        //    }



        //}
        //----------------



        [Route("api/Publicw/getProsesLejarResit")]
        [HttpPost]
        public Task<HttpResponseMessage> getProsesLejarResit()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];
            string data1 = request.Form["data1"];


            IEnumerable<string> mydata = SQLsmkb.getLejarResit();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

            if (myListx[0] == "no")
            {
                return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, "tak ok"));
            }
            else
            {
                return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, "transder done"));
            }

        }

        //-----------------------
        [Route("api/Publicw/getProsesBilHdr")]
        [HttpPost]
        public Task<HttpResponseMessage> getProsesBilHdr()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];

            IEnumerable<string> mydata = SQLsmkb.insertBil_Hdr();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        }
        //-----------------------

        //-----------------------
        [Route("api/Publicw/getProsesTerimaHdr")]
        [HttpPost]
        public Task<HttpResponseMessage> getProsesTerimaHdr()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];
           
            IEnumerable<string> mydata = SQLsmkb.insertTerima_Hdr();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        }
        //-----------------------


        //-----------------------
        [Route("api/Publicw/getProsesBilDtl")]
        [HttpPost]
        public Task<HttpResponseMessage> getProsesBilDtl()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];

            IEnumerable<string> mydata = SQLsmkb.insertBil_Dtl();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        }
        //-----------------------

        //-----------------------
        [Route("api/Publicw/getProsesTerimaDtl")]
        [HttpPost]
        public Task<HttpResponseMessage> getProsesTerimaDtl()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];

            IEnumerable<string> mydata = SQLsmkb.insertTerima_Dtl();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        }
        //-----------------------

        //-----------------------
        [Route("api/Publicw/getProsesInvoisDtl")]
        [HttpPost]
        public Task<HttpResponseMessage> getProsesInvoisDtl()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];

            IEnumerable<string> mydata = SQLsmkb.insertInvois_Dtl();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        }
        //-----------------------

        //-----------------------
        [Route("api/Publicw/getProsesBaucarHdr")]
        [HttpPost]
        public Task<HttpResponseMessage> getProsesBaucarHdr()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];

            IEnumerable<string> mydata = SQLsmkb.insertBaucar_Hdr();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        }
        //-----------------------

        //-----------------------
        [Route("api/Publicw/getProsesBaucarDtl")]
        [HttpPost]
        public Task<HttpResponseMessage> getProsesBaucarDtl()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];

            IEnumerable<string> mydata = SQLsmkb.insertBaucar_Dtl();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        }
        //-----------------------

        //-----------------------
        [Route("api/Publicw/getUpdateIDRujukan")]
        [HttpPost]
        public Task<HttpResponseMessage> getUpdateIDRujukan()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];

            IEnumerable<string> mydata = SQLsmkb.updateIDRujukan_Baucar();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        }
        //-----------------------

        //-----------------------
        [Route("api/Publicw/getTransaksiBank")]
        [HttpPost]
        public Task<HttpResponseMessage> getTransaksiBank()
        {
            try
            {
                var request = HttpContext.Current.Request;
                string Ticket_id = request.Form["Ticket_id"];
                string parKodBank = request.Form["kodbank"];
                string parBulan = request.Form["bulan"];
                string parTahun = request.Form["tahun"];

                IEnumerable<string> mydata = SQLsmkb.insertTransaksi_Bank(parKodBank, parBulan, parTahun);
                var myListx = mydata.ToList();
                return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));
            } catch(Exception ex)
            {
                return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, ex.Message.ToString()));
            }

        }

        [Route("api/Publicw/gettotaltransfer")]
        [HttpPost]
        public IEnumerable<string> gettotaltransfer()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];
            string parKodBank = request.Form["kodbank"];
            string parBulan = request.Form["bulan"];
            string parTahun = request.Form["tahun"];
            try
            {
                string dahTransfer = SQLsmkb.getCountTransBank(parKodBank, parBulan, parTahun);
                string jumlahData = SQLsmkb.getTotalTransBank(parKodBank, parBulan, parTahun);

                return new string[] { "200", dahTransfer , jumlahData };
                //return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, dahTransfer + "|" + jumlahData));
            }
            catch (Exception ex)
            {
                return new string[] { "500", ex.Message.ToString() };
                //return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, ex.Message.ToString()));
            }
        }
        //-----------------------


        //-----------------------
        [Route("api/Publicw/getUpdateEmailStaf")]
        [HttpPost]
        public Task<HttpResponseMessage> getUpdateEmailStaf()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];

            IEnumerable<string> mydata = SQLsmkb.updateEmail_Staf();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        }
        //-----------------------

        //-----------------------
        [Route("api/Publicw/getProsesTerimaTrans")]
        [HttpPost]
        public Task<HttpResponseMessage> getProsesTerimaTrans()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];

            IEnumerable<string> mydata = SQLsmkb.insertTerima_Trans();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        }
        //-----------------------

        //-----------------------
        //[Route("api/Publicw/tambahPenghutangMaster")]
        //[HttpPost]
        //public Task<HttpResponseMessage> tambahPenghutangMaster()
        //{

        //    var request = HttpContext.Current.Request;
        //    string Ticket_id = request.Form["Ticket_id"];

        //    //IEnumerable<string> mydata = SQLsmkb.insertPenghutangMasterResit();


        //    SQLsmkb.insertPenghutangMasterResit();
        //    var myListx = mydata.ToList();
        //    return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        //}

        //-----------------------

        [Route("api/Publicw/getProsesLejarBil")]
        [HttpPost]
        public Task<HttpResponseMessage> getProsesLejarBil()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];
            string data1 = request.Form["data1"];


            IEnumerable<string> mydata = SQLsmkb.getLejarBil();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

            if (myListx[0] == "no")
            {
                return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, "tak ok"));
            }
            else
            {
                return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, "transder done"));
            }

        }


        [Route("api/Publicw/getProsesLejarPemiutang")]
        [HttpPost]
        public Task<HttpResponseMessage> getProsesLejarPemiutang()
        {
            var request = HttpContext.Current.Request;
            string Ticket_id = request.Form["Ticket_id"];
            string data1 = request.Form["data1"];


            IEnumerable<string> mydata = SQLsmkb.getLejarPemiutang();
            var myListx = mydata.ToList();
            return Task.FromResult(Request.CreateResponse(HttpStatusCode.OK, myListx[0]));

        }




        // end tran fer no token
        //[Route("api/Publicw/SMKBticket")]
        //[HttpPost]
        ////   public IEnumerable<string> SMKBticket(MyTicket ticket)
        //public async Task<HttpResponseMessage> SMKBticket()
        //{
        //    string mystatus = "no";
        //    string myticket = ticket.Ticket_id;
        //    string userid = "";
        //    if (SQLAuth.Check_ValidTicket(myticket, "smkb", ref userid) == "yes")
        //    {

        //        // do your work
        //        mystatus = "zzok " + userid;
        //    }
        //    //  return new string[] { mystatus, "data1" };
        //    return Request.CreateResponse(HttpStatusCode.OK, mystatus);
        //}

        //  https://devmobile.utem.edu.my/smkb/api/Publicw/1/53453453/smkb/0/0/0/0
        [Route("api/Publicw/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
        public IEnumerable<string> Get(int id, string orderId, string app_Id, string mob_Id, string logincode_Id, string lat1, string long1)
        {
            string userid = "";
            if (id == 1)
            {
                string mystatus = "no";
                string myticket = orderId;
                if (SQLAuth.Check_ValidTicket(myticket, app_Id, ref userid) == "yes")
                {

                    // do your work
                    mystatus = "ok";
                }

                return new string[] { mystatus, "data1" };

            }
            else if (id == 2)
            {

                return new string[] { "uuu" };
            }
            else
            {
                return new string[] { "uuu" };
            }
        }
        public class MyTicket
        {
            public string Ticket_id { get; set; }
        }
    }
}
