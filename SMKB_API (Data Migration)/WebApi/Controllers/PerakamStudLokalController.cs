using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;




using System.Web;

using Microsoft.AspNet.Identity.Owin;

using Microsoft.AspNet.Identity;
using System.IO;
using System.Text;
using System.Data;
using System.Xml.Linq;

namespace WebApi.Controllers
{
    [Authorize]
    public class PerakamStudLokalController : ApiController
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
        public IEnumerable<string> Get()
        {
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);

            return new string[] { SQLAuth.finddata(user.UserName.ToString(), "nama", user.PasswordHash.ToString()), SQLAuth.finddata(user.UserName.ToString(), "dept", user.PasswordHash.ToString()), SQLAuth.finddata(user.UserName.ToString(), "email", user.PasswordHash.ToString()) };


        }

        // GET api/values/5
        // routeTemplate: "api/{controller}/{id}/{orderId}/{app_Id}/{mob_Id}",

        [Route("api/PerakamStudLokal/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
        public IEnumerable<string> Get(int id, string orderId, string app_Id, string mob_Id, string logincode_Id, string lat1, string long1)
        {
            var userIdxx = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var userxx = UserManager.FindById(userIdxx);

            //  string mymsg = "Status di dalam Sistem eTAP Tuan/Puan adalah 'Tidak Bergejala [Hijau]' .Anda tidak perlu menggunakan modul 'WFH-LOKALITI' untuk hari ini";
            // string mymsg = "Untuk hari ini anda tidak perlu menggunakan modul ini. <a href='https://pkp.utem.edu.my/papar.php?v=" + userxx.UserName.ToString() + "'>Status Sistem eTAP</a>  menunjukan anda dibenarkan berada di kawasan UTeM";
            string mymsg = "Status Sistem eTAP menunjukan anda dibenarkan berada di kawasan UTeM. Anda tidak perlu menggunakan modul 'WFH-LOKALITI' untuk hari ini";

            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
            IEnumerable<string> myValidLogin = SQLAuth.CheckValid_loginonly(user.UserName.ToString(), logincode_Id);
            var myListx = myValidLogin.ToList();
            if (myListx[0] == "loginchanged")
            {
                return new string[] { "loginchanged" };
            }
            else
            {

                if (id == 1)
                {
                    if (lat1.ToString().Contains(";"))
                    {
                        string[] myLat = lat1.Split(';');
                        string[] myData = long1.Split(';');
                        return SQLWFHStaff.StudGateMasuk(user.UserName.ToString(), app_Id, "masuk", orderId, myLat[0], myLat[1], myData[0], myData[1]);

                    }
                    else
                    {
                        string myinput = orderId;
                        string result = myinput.Substring(myinput.Length - 5, 5);
                        return SQLWFHStaff.StudGateMasuk(user.UserName.ToString(), app_Id, "masuk", orderId, lat1, long1, "", result);


                    }
                 //   return SQLWFHStaff.StudGateMasuk(user.UserName.ToString(), app_Id,  "masuk", orderId, myLat[0], myLat[1], myData[0], myData[1]);

                }

                if (id == 3)
                {
                    // get detailuser and app setting
                    return SQLWFHStaff.GetInfoStud(user.UserName.ToString(), app_Id, "masuk");

                }


                if (id == 7)
                {

                    return SQLWFHStaff.GetListLogSatuStud(user.UserName.ToString(), app_Id);
                }

                return new string[] { "loginchanged" };
            }

        }


        // POST api/values
        public void Post([FromBody] string value)
        {
        }

        // PUT api/values/5
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
        }

    }
}
