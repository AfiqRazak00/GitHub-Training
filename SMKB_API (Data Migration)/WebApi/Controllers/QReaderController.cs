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
    public class QReaderController : ApiController
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

        [Route("api/kuliah/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}")]
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
                    return SQLKuliah.CheckOpenGate(user.UserName.ToString(), app_Id, orderId);
                    //  return new string[] { "no" };

                }
                if (id == 2)
                {
                    // get detailuser and app setting
                    string e1xx = orderId.Replace("x", "-");
                    DateTime eexx = Convert.ToDateTime(e1xx);
                    string ee2xx = eexx.ToString("yyyy-MM-dd");
                    DateTime ee3xx = Convert.ToDateTime(ee2xx);
                    return SQLKuliah.GetListLogSatuKuliah(user.UserName.ToString(), ee3xx);

                }
                if (id == 3)
                {
                    // record kehadiran
                    return SQLKuliah.CheckAttdRecord(user.UserName.ToString(), app_Id);

                }
                if (id == 4)
                {
                    // masuk
                    return SQLKuliah.ProcessInsertUpdateRecord(user.UserName.ToString(), orderId, "masuk", app_Id, mob_Id);

                }
                if (id == 5)
                {
                    // masuk
                    return SQLKuliah.ProcessInsertUpdateRecord(user.UserName.ToString(), orderId, "keluar", app_Id, mob_Id);

                }
                if (id == 6)
                {
                    // masuk
                    return SQLKuliah.GetListSubject("01279");

                }
                if (id == 7)
                {
                    string[] namesArray = mob_Id.Split(',');
                    // masuk
                    string s1 = orderId.Replace("x", "-").Replace("y", ":");
                    DateTime gg = Convert.ToDateTime(s1);
                    string gg2 = gg.ToString("yyyy-MM-dd hh:mm tt");
                    DateTime gg3 = Convert.ToDateTime(gg2);

                    string e1 = app_Id.Replace("x", "-").Replace("y", ":");
                    DateTime ee = Convert.ToDateTime(e1);
                    string ee2 = ee.ToString("yyyy-MM-dd hh:mm tt");
                    DateTime ee3 = Convert.ToDateTime(ee2);
                    if (ee3 < DateTime.Now)
                    {
                        return new string[] { "Gagal membuat pendaftaran kuliah. Tarikh Tamat kuliah lebih kecil dari tarikh dan masa semasa" };
                    }
                    else
                    {
                        // return SQLKuliah.CheckClassExist(user.UserName.ToString(), gg3, ee3, namesArray[0], logincode_Id, namesArray[1], namesArray[2]);
                        return SQLKuliah.CheckClassExist(user.UserName.ToString(), gg3, ee3, namesArray[0], namesArray[0], namesArray[1].Replace("x", "/"), namesArray[2], namesArray[3]);
                    }


                }
                if (id == 8)
                {
                    // get detailuser and app setting
                    return SQLKuliah.GetListLecurerKuliah(user.UserName.ToString());

                }
                if (id == 9)
                {
                    // get detailuser and app setting
                    return SQLKuliah.HapusLecurerKuliah(user.UserName.ToString(), app_Id);

                }
                if (id == 10)
                {
                    // get detailuser and app setting
                    return SQLKuliah.GetmTAC(user.UserName.ToString());

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

