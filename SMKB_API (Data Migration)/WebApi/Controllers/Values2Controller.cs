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
    public class Values2Controller : ApiController
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
        public Tuple<string[,]> Get(int id)
        {
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
            if (id == 12)
            {
                return SQLKuliahStudent.GetStudentResult12(user.UserName.ToString());
            }
            if (id == 2)
            {
                string[,] arrayx = new string[,]
                {
                    {"cat", "car"},
                    {"dog", "plane"},
                };
                return Tuple.Create(arrayx);

            }
            return Tuple.Create(new string[,]
                {
                    {"catx", "carx"},
                    {"dogx", "planex"},
                });

            //  return new string[,]
            //    {
            //        {"catx", "carx"},
            //       {"dogx", "planex"},
            //   };
            //  return SQLAuth.finddatasmkb(user.UserName.ToString(), "nama", user.PasswordHash.ToString()) ;

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
