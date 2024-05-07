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
    public class PerakamGeoArrController : ApiController
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

        [Route("api/perakamgeoarr/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
        public string[,] Get(int id, string orderId, string app_Id, string mob_Id, string logincode_Id, string lat1, string long1)
        {
            string[,] twoDimensionalx;
            twoDimensionalx = new string[1, 1];
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
            IEnumerable<string> myValidLogin = SQLAuth.CheckValid_loginonly(user.UserName.ToString(), logincode_Id);
            var myListx = myValidLogin.ToList();
            if (myListx[0] == "loginchanged")
            {
                //return twoDimensionalx[0, 0] =  "dede";
                twoDimensionalx[0, 0] = "loginchanged";
                return twoDimensionalx;
            }
            else
            {

                if (id == 1)
                {
                    // get detailuser and app setting

                    return SQLPerakamgeo.GetListLog(user.UserName.ToString(), app_Id);

                }


                twoDimensionalx[0, 0] = "loginchanged";
                return twoDimensionalx;
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
