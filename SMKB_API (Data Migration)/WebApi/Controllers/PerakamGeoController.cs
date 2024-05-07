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
    public class PerakamGeoController : ApiController
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

        [Route("api/perakamgeo/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
        public IEnumerable<string> Get(int id, string orderId, string app_Id, string mob_Id, string logincode_Id, string lat1, string long1)
        {
            string mystr = "";
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

                    //   return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1,  long1, "masuk");
                    return new string[] { "Rekod kedatangan tidak dapat direkodkan. Sistem mendapati anda menggunkan versi lama myUTeM. Sila download myUTeM versi baru di AppStore " };


                }
                if (id == 2)
                {
                    // get detailuser and app setting
                    // return SQLPerakamgeo.CheckOpenGateKeluar(user.UserName.ToString(), app_Id);
                //    if ()
                //        return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "keluar");
                //}
                //else
                //{
                    return new string[] { "Rekod kedatangan tidak dapat direkodkan. Sistem mendapati anda menggunkan versi lama myUTeM. Sila download myUTeM versi baru di PlayStore untuk Android atau AppStore untuk iOS" };
              //  }

                }


                if (id == 11)
                {
                    // get detailuser and app setting
                   // if (user.UserName.ToString() == "danny")
                   // {
                   //     return SQLPerakamgeo.CheckOpenGateMasuk_d(user.UserName.ToString(), app_Id, lat1, long1, "masuk");
                   // }
                    //else {
                 //   return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "masuk");
                    mystr =SQLPerakamgeo.reset24Hrs(user.UserName.ToString());
                       return new string[] { "** Rekod kedatangan tidak dapat direkodkan. Sistem mendapati anda menggunkan versi lama myUTeM. Sila download myUTeM versi baru di PlayStore untuk Android atau AppStore untuk iOS" };

                    // }

                }
                if (id == 12)
                {
                    // get detailuser and app setting
                    // return SQLPerakamgeo.CheckOpenGateKeluar(user.UserName.ToString(), app_Id);
                    // if (user.UserName.ToString() == "danny")
                    // {
                    //    return SQLPerakamgeo.CheckOpenGateMasuk_d(user.UserName.ToString(), app_Id, lat1, long1, "keluar");
                    // }
                    // else
                    // {
                    
                  //  return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "keluar");
                    mystr = SQLPerakamgeo.reset24Hrs(user.UserName.ToString());
                     return new string[] { "** Rekod kedatangan tidak dapat direkodkan. Sistem mendapati anda menggunkan versi lama myUTeM. Sila download myUTeM versi baru di PlayStore untuk Android atau AppStore untuk iOS" };

                    // }

                }






                if (id == 3)
                {
                    // get detailuser and app setting
                    return SQLPerakamgeo.GetInfo(user.UserName.ToString(), app_Id, "masuk");

                }
                if (id == 4)
                {
                    // get detailuser and app setting
                    return SQLPerakamgeo.GetInfo(user.UserName.ToString(), app_Id, "keluar");

                }
                if (id == 5)
                {
                    // get detailuser and app setting

                    return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "masuk");

                }
                if (id == 6)
                {
                    // get detailuser and app setting
                    // return SQLPerakamgeo.CheckOpenGateKeluar(user.UserName.ToString(), app_Id);
                    return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "keluar");

                }
                if (id == 7)
                {
                    return SQLPerakamgeo.GetListLogSatu(user.UserName.ToString(), app_Id);
                }
                if (id == 8)
                {
                    // hantar aduan
                    return SQLPerakamgeo.HantarAduan(user.UserName.ToString(), long1);
                }
                if (id == 9)
                {
                    // get perakam smsm
                    string tar = orderId + "-" + lat1 + "-" + long1;
                    string tar2 = long1 + "-" + lat1 + "-" + orderId;
                    if (user.UserName.ToString() == "danny")
                    {
                        return SQLPerakamgeo.GetSMSMPerakam("00578", tar, tar2);
                    }
                    else
                    {
                        return SQLPerakamgeo.GetSMSMPerakam(user.UserName.ToString(), tar, tar2);
                    }
                }

                if (id == 10)
                {
                    // check phone id

                }
                if (id == 21)
                {
                    string s1 = lat1.Replace("x", "-").Replace("y", ":");
                    DateTime gg = Convert.ToDateTime(s1);
                    string gg2 = gg.ToString("yyyy-MM-dd");
                    DateTime gg3 = Convert.ToDateTime(gg2);
                    return SQLPerakamgeo.GetListLogSatuBaru(user.UserName.ToString(), app_Id, gg3);
                   // return new string[] { "ok" };
                }

                if (id == 13)
                {
                    // return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "masuk");
                    IEnumerable<string> mas1 = SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "masuk");
                    var myListzz = mas1.ToList();
                    if (myListzz[0] == "punchinok")
                    {
                        return SQLPerakamgeo.GetInfoBaru(user.UserName.ToString(), app_Id, "masuk", myListzz[1]);
                    }
                    else
                    {
                        return mas1;
                    }


                }
                if (id == 14)
                {
                    //  return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "keluar");
                    IEnumerable<string> mas2 = SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "keluar");
                    var myListzxz = mas2.ToList();
                    if (myListzxz[0] == "punchinok")
                    {
                        return SQLPerakamgeo.GetInfoBaru(user.UserName.ToString(), app_Id, "keluar", myListzxz[1]);
                    }
                    else
                    {
                        return mas2;
                    }

                }

                if (id == 15)
                {
                    return SQLPerakamgeo.GetWhitelist(user.UserName.ToString(), app_Id, lat1, long1, "keluar");

                }

                if (id == 16)
                {
                    // return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "masuk");
                    IEnumerable<string> mas1 = SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "masuk");
                    var myListzz = mas1.ToList();
                    if (myListzz[0] == "punchinok")
                    {
                        return SQLPerakamgeo.GetInfoBaru(user.UserName.ToString(), app_Id, "masuk", myListzz[1]);
                    }
                    else
                    {
                        return mas1;
                    }


                }
                if (id == 17)
                {
                    //  return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "keluar");
                    IEnumerable<string> mas2 = SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "keluar");
                    var myListzxz = mas2.ToList();
                    if (myListzxz[0] == "punchinok")
                    {
                        return SQLPerakamgeo.GetInfoBaru(user.UserName.ToString(), app_Id, "keluar", myListzxz[1]);
                    }
                    else
                    {
                        return mas2;
                    }

                }
                if (id == 22)
                {
                    return SQLPerakamgeo.GetListLogSatuKursus(user.UserName.ToString(), app_Id);
                }


                if (id == 23)
                {
                    // get detailuser and app setting
                    return SQLPerakamgeo.GetInfoCam(user.UserName.ToString(), app_Id, "masuk");

                }
                if (id == 24)
                {
                    // get detailuser and app setting
                    return SQLPerakamgeo.GetInfoCam(user.UserName.ToString(), app_Id, "keluar");

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
