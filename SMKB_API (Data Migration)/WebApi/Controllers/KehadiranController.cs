using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;


using System.Web;

using Microsoft.AspNet.Identity.Owin;

using Microsoft.AspNet.Identity;


namespace WebApi.Controllers
{
    [Authorize]
    public class KehadiranController : ApiController
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

        [Route("api/kehadiran/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}")]
        public IEnumerable<string> Get(int id, string orderId, string app_Id, string mob_Id, string logincode_Id)
        {
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
                    // get detailuser and app setting
                    return SQLKehadiran.CheckOpenGate("masuk", app_Id);

                }
                if (id == 2)
                {
                    // get detailuser and app setting
                    return SQLKehadiran.CheckOpenGate("keluar", app_Id);

                }
                if (id == 3)
                {
                    // record kehadiran
                    return SQLKehadiran.CheckAttdRecord(user.UserName.ToString(), app_Id);

                }
                if (id == 4)
                {
                    // masuk
                    return SQLKehadiran.ProcessInsertUpdateRecord(user.UserName.ToString(), orderId, "masuk", app_Id, mob_Id);

                }
                if (id == 5)
                {
                    // masuk
                    return SQLKehadiran.ProcessInsertUpdateRecord(user.UserName.ToString(), orderId, "keluar", app_Id, mob_Id);

                }
                return new string[] { "loginchanged" };
                //  return SQLAuth.finddatasmkb(user.UserName.ToString(), "nama", user.PasswordHash.ToString()) ;
            }

        }


        // POST api/values
        public void Post([FromBody]string value)
        {
        }

        // PUT api/values/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
        }
    }
}
