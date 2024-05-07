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
    public class PerakamGeoRController : ApiController
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

        [Route("api/perakamgeor/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
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
               // return new string[] { "Tiada majlis rasmi UTeM yang didaftarkan" };
                if (id == 1)
                {
                    // get detailuser and app setting

                    return SQLPerakamgeor.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "masuk", orderId);

                }
                if (id == 2)
                {
                    // get detailuser and app setting
                    // return SQLPerakamgeo.CheckOpenGateKeluar(user.UserName.ToString(), app_Id);
                    return SQLPerakamgeor.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "keluar", orderId);

                }
               
                if (id == 3)
                {
                    // get detailuser and app setting
                    return SQLPerakamgeor.GetInfo(user.UserName.ToString(), app_Id, "masuk", orderId);

                }
                if (id == 4)
                {
                    // get detailuser and app setting
                    return SQLPerakamgeor.GetInfo(user.UserName.ToString(), app_Id, "keluar", orderId);

                }
                if (id == 5)
                {
                    // check masuk time

                   return SQLPerakamgeor.CheckTimeOpenGate( app_Id,  "masuk");

                }
                if (id == 6)
                {
                    // get detailuser and app setting
                     return SQLPerakamgeor.CheckTimeOpenGate(app_Id, "keluar");

                }
                if (id == 7)
                {
                    // get detailuser and app setting
                    IEnumerable<string> valuesw = SQLPerakamgeor.CheckTimeOpenGate(app_Id, "masuk");
                    var myListum = valuesw.ToList();
                    if (myListum[0] == "no")
                    {
                        return new string[] { "notutup", myListum[1], myListum[2], "ddd", "dsss" };
                    }
                    else
                    {
                        return SQLPerakamgeor.CheckOpenGateMasukQR(user.UserName.ToString(), app_Id, lat1, "masuk", orderId);
                    }

                }
                if (id == 8)
                {
                    IEnumerable<string> valuesw = SQLPerakamgeor.CheckTimeOpenGate(app_Id, "keluar");
                    var myListum = valuesw.ToList();
                    if (myListum[0] == "no")
                    {
                        return new string[] { "notutup", myListum[1], myListum[2], "ddd", "dsss" };
                    }
                    else
                    {
                        return SQLPerakamgeor.CheckOpenGateMasukQR(user.UserName.ToString(), app_Id, lat1, "keluar", orderId);
                    }
                }
                if (id == 9)
                {
                    // get detailuser and app setting

                    return SQLPerakamgeor.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "masuk", orderId);

                }
                if (id == 10)
                {
                    // get detailuser and app setting
                    // return SQLPerakamgeo.CheckOpenGateKeluar(user.UserName.ToString(), app_Id);
                    return SQLPerakamgeor.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "keluar", orderId);

                }
                if (id == 11)
                {
                    // get detailuser and app setting
                    DayOfWeek day = DateTime.Now.DayOfWeek;
                    if ((day == DayOfWeek.Sunday) ||  (day == DayOfWeek.Saturday) ||  (day == DayOfWeek.Tuesday) || (day == DayOfWeek.Thursday) )
                    {
                        return new string[] { "notweekday", "QR code hanya boleh digunakan pada hari Isnin, Rabu dan Jumaat", "QR code canot be used on Monday, Wednesday and Friday", "ddd", "dsss" };

                    }
                    else
                    {
                        return SQLPerakamgeor.CheckOpenGateMasukQRB40(user.UserName.ToString(), lat1);
                    }
                  
                    ////  return new string[] { "punchinok","dd","ddd","ddd","dsss" };

                }
                if (id == 12)
                {
                    // get detailuser and app setting
                    return SQLPerakamgeor.GetDataQRB40(user.UserName.ToString());


                }
                if (id == 13)
                {
                    // get detailuser and app setting
                    return SQLPerakamgeor.GetStatusDisclaimer(user.UserName.ToString());


                }
                if (id == 14)
                {
                    // get detailuser and app setting
                    return SQLPerakamgeor.UpdateStatusDisclaimer(user.UserName.ToString());


                }
                if (id == 15) // asal 3
                {
                    // get detailuser and app setting
                    return SQLPerakamgeor.GetInfoKehadiranKursus(user.UserName.ToString(), app_Id, "QR", orderId);
                   // return SQLPerakamgeor.GetInfo(user.UserName.ToString(), app_Id, "masuk", orderId);
                }
                if (id == 16) // asal 7
                {
                    //// get detailuser and app setting
                    //IEnumerable<string> valuesw = SQLPerakamgeor.CheckTimeOpenGate(app_Id, "masuk");
                    //var myListum = valuesw.ToList();
                    //if (myListum[0] == "no")
                    //{
                    //    return new string[] { "notutup", myListum[1], myListum[2], "ddd", "dsss" };
                    //}
                    //else
                    //{
                        return SQLPerakamgeor.CheckGateMasukKursusQR(user.UserName.ToString(), app_Id, lat1, "masuk", orderId);
                    //}

                }
                //if (id == 17)
                //{
                //    // get detailuser and app setting
                //    return SQLPerakamgeor.UpdateResetPassword(user.UserName.ToString(), lat1);


                //}

                //UpdateStatusDisclaimer
                return new string[] { "Tiada majlis rasmi UTeM yang didaftarkan" };
               // return new string[] { "loginchanged" };
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
