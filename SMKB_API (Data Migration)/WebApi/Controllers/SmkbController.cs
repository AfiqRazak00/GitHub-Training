using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.AspNet.Identity;

using System.Threading.Tasks;
using System.Management.Automation;
using System.Web.UI.WebControls.WebParts;

namespace WebApi.Controllers
{
    [Authorize]
    public class SmkbController : ApiController
    {
        private ApplicationUserManager _userManager;

    public ApplicationUserManager UserManager
    {
        get
        {

            return _userManager ?? System.Web.HttpContext.Current.GetOwinContext().GetUserManager<ApplicationUserManager>();
        }
        private set
        {
            _userManager = value;
        }
    }


    // POST api/aduan
    public void Post([FromBody] string value)
    {

    }

    // PUT api/aduan/5
    public void Put(int id, [FromBody] string value)
    {

    }

    // DELETE api/aduan/5
    public void Delete(int id)
    {

    }


    [Route("api/Smkb/Uploadfill")]
    [HttpPost]
    public async Task<HttpResponseMessage> Uploadfill()
    {
        var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
        var user = UserManager.FindById(userId);

        var request = HttpContext.Current.Request;
        string data1 = request.Form["data1"];
        string data2 = request.Form["data2"];
        HttpResponseMessage result = null;
        try
        {
            if (request.Files.Count == 0)
            {
                // result = Request.CreateResponse(HttpStatusCode.OK, "no1"); ;
            }
            var postedFile = request.Files[0]; // I am able to read file here. but i cannot get the Username

                IEnumerable<string> values2 = SQLsmkb.SimpanDataAdaGambar(data1, data2); // (user.UserName.ToString(), postedFile, data1, data2);
            var myList2 = values2.ToList();
            if (myList2[0] == "ok")
            {
                return Request.CreateResponse(HttpStatusCode.OK, "ok");
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, "not pk");
            }
        }
        catch (Exception)
        {
            IEnumerable<string> values2 = SQLsmkb.SimpanData(data1, data2);
            var myList2 = values2.ToList();
            if (myList2[0] == "ok")
            {
                return Request.CreateResponse(HttpStatusCode.OK, "ok");
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, "not ok");
            }
        }

    }
        //----------------
        [Route("api/Smkb/Fill_Lejar")]
        [HttpPost]
        public async Task<HttpResponseMessage> Fill_Lejar()
        {
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);

            var request = HttpContext.Current.Request;
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


            HttpResponseMessage result = null;
            try
            {
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
        //----------------


        [Route("api/Smkb/Fill")]
        [HttpPost]
        public async Task<HttpResponseMessage> Fill()
        {
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
            var request = HttpContext.Current.Request;
        string data1 = request.Form["data1"];
        string data2 = request.Form["data2"];
        HttpResponseMessage result = null;
        try
        {

            IEnumerable<string> values2 = SQLsmkb.SimpanData(data1, data2);
            var myList2 = values2.ToList();
            if (myList2[0] == "ok")
            {
                return Request.CreateResponse(HttpStatusCode.OK, "ok");
            }
            else
            {
                return Request.CreateResponse(HttpStatusCode.OK, "not ok");
            }
        }
        catch (Exception)
        {
            return Request.CreateResponse(HttpStatusCode.OK, "error");
        }

    }

    [Route("api/Smkb/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
    public IEnumerable<string> Get(int id, string orderId, string app_Id, string mob_Id, string logincode_Id, string lat1, string long1)
    {
        var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
        var user = UserManager.FindById(userId);
        IEnumerable<string> myValidLogin = SQLAuth.CheckValid_loginonly(user.UserName.ToString(), logincode_Id);
        var myListx = myValidLogin.ToList();
        if (id == 1)
        {
                return SQLsmkb.GetListData();
        }

        return new string[] { "loginchanged" };

    }

}
}
