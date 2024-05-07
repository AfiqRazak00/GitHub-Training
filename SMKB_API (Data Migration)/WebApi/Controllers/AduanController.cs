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

namespace WebApi.Controllers
{
    [Authorize]
    public class AduanController : ApiController
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
        public void Post([FromBody]string value)
        {

        }

        // PUT api/aduan/5
        public void Put(int id, [FromBody]string value)
        {

        }

        // DELETE api/aduan/5
        public void Delete(int id)
        {

        }
     

        [Route("api/Aduan/Uploadfill")]
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

                IEnumerable<string> values2 = SQLPerakamgeo.HantarDataDanFile(user.UserName.ToString(),  postedFile, data1, data2);
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
                IEnumerable<string> values2 = SQLPerakamgeo.HantarDataSahaja(user.UserName.ToString(),data1,data2);
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
        [Route("api/Aduan/Fill")]
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

                IEnumerable<string> values2 = SQLPerakamgeo.HantarDataSahaja(user.UserName.ToString(), data1, data2);
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
       
        [Route("api/Aduan/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
        public IEnumerable<string> Get(int id, string orderId, string app_Id, string mob_Id, string logincode_Id, string lat1, string long1)
        {
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
            IEnumerable<string> myValidLogin = SQLAuth.CheckValid_loginonly(user.UserName.ToString(), logincode_Id);
            var myListx = myValidLogin.ToList();
                 if (id == 1)
                {
                    // senarai kecemasan untuk user/pengadu
                    return SQLMigs.GetEmergencyButton(user.UserName.ToString());
                }
             
            return new string[] { "loginchanged" };

        }

     }
}
