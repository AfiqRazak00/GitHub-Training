using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

using System.Data.SqlClient;
using System.Data;
using System.Web;

using Microsoft.AspNet.Identity;
using WebApi.Models;
using Microsoft.AspNet.Identity.Owin;






namespace WebApi.Controllers
{
    [Authorize]
    public class ValuesController : ApiController
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
        // GET api/values
        public IEnumerable<string> Get()
        {
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);

            return new string[] { SQLAuth.finddata(user.UserName.ToString(), "nama", user.PasswordHash.ToString()), SQLAuth.finddata(user.UserName.ToString(), "dept", user.PasswordHash.ToString()), SQLAuth.finddata(user.UserName.ToString(), "email", user.PasswordHash.ToString()) };


        }

        // GET api/values/5
     //   [RequireHttps]
        public IEnumerable<string> Get(int id)
        {
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
            if (id == 1)
            {
                //// start new
                ///
                IEnumerable<string> myCheck = SQLAuth.sqlCheckGRA(user.UserName.ToString());
                var myListx = myCheck.ToList();
                if (myListx[0] == "no")
                {
                    if (user.UserName.ToString().Contains("pd"))
                    {
                        return SQLAuth.finddataNew(user.UserName.ToString());  //staf only
                    }
                    else if (
                      (user.UserName.ToString().Contains("d")) ||
                      (user.UserName.ToString().Contains("b")) ||
                      (user.UserName.ToString().Contains("bs")) ||
                      (user.UserName.ToString().Contains("m")) ||
                      (user.UserName.ToString().Contains("p"))
                     )
                    {
                        return SQLAuth.finddataNew_pelajar(user.UserName.ToString(), "Pelajar");  //pelajar only
                    }
                    else
                    {
                        return SQLAuth.finddataNew(user.UserName.ToString());  //staf only

                    }
                }
                else
                {
                    if ((myListx[2] == "AHLI PORTAL") || (myListx[2] == "AHLI PENYELIDIK") )
                    {
                        return SQLAuth.finddataNew_GRA(user.UserName.ToString());  // GRA
                    }
                    else
                    {
                        return SQLAuth.finddataNew_pelajar(user.UserName.ToString(), "Pelajar_gra");  //pelajar gra
                    }


                }


                // end new




                //if (SQLAuth.sqlCheckGRA(user.UserName.ToString())) {
                //    // gra
                //    return SQLAuth.finddataNew_GRA(user.UserName.ToString());
                //}
                //else {
                //    if (
                //        (user.UserName.ToString().Contains("d")) ||
                //         (user.UserName.ToString().Contains("b")) ||
                //          (user.UserName.ToString().Contains("bs")) ||
                //        (user.UserName.ToString().Contains("m")) ||
                //        (user.UserName.ToString().Contains("p"))
                //        )
                //    {
                //        return SQLAuth.finddataNew_pelajar(user.UserName.ToString());
                //        //return SQLAuth.finddataNew(user.UserName.ToString());
                //    }
                //    else
                //    {
                //        return SQLAuth.finddataNew(user.UserName.ToString());

                //    }
                //}
            }


            if (id == 2)
            {
          

            }

            return new string[] { "" };
            //  return SQLAuth.finddatasmkb(user.UserName.ToString(), "nama", user.PasswordHash.ToString()) ;

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
