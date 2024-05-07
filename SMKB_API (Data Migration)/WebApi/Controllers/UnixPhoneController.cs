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
    public class UnixPhoneController : ApiController
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

        [Route("api/unixphone/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
        public IEnumerable<string> Get(int id, string orderId, string app_Id, string mob_Id, string logincode_Id, string lat1, string long1)
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
                    // set phone id wher belong and set to x

                    IEnumerable<string> myValidLoginxx = SQLUnixphone.Updatetoxphoneid(user.UserName.ToString(), lat1);
                    return SQLUnixphone.Updatetophoneid(user.UserName.ToString(), lat1);

                }
                if (id == 2)
                {
                    // set phone id wher belong and set to x

                    IEnumerable<string> myValidLoginxx = SQLUnixphone.Updatetoxphoneid(user.UserName.ToString(), lat1);
                    return SQLUnixphone.Updatetophoneiddate(user.UserName.ToString(), lat1);

                }
                if (id == 3)
                {
                    // set phone id wher belong and set to x

                    IEnumerable<string> myValidLoginxx = SQLUnixphone.Updatetoxphoneid(user.UserName.ToString(), lat1);
                    return SQLPerakam.UpdateBiometric(user.UserName.ToString(), mob_Id);

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
