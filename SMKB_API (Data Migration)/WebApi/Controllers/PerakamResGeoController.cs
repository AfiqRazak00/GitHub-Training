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
    public class PerakamResGeoController : ApiController
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
      //  [Route("api/perakamgeo/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]

        [Route("api/perakamresgeo/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
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
                    return SQLResearcher.GetListLogSatunew_ra(user.UserName.ToString(), "3");
                }


                if (id == 2)
                {
                    // get perakam smsm
                    string tar = orderId + "-" + lat1 + "-" + long1;
                    string tar2 = long1 + "-" + lat1 + "-" + orderId;
                    return SQLResearcher.GetSMSMPerakam_ra(user.UserName.ToString(), tar, tar2);
                }
             //   if (id == 7)
              //  {
                    // senarai kecemasan untuk user/pengadu
               //     return SQLResearcher.GetpaparLogKehadiran(user.UserName.ToString());
               // }
                /////   start attendane GRA
                if (id == 25)
                {
                    // get detailuser and app setting
                    return SQLResearcher.GetInfo_ra(user.UserName.ToString(), app_Id, "masuk");
                   // return SQLResearcher.GetInfoBaru_ra(user.UserName.ToString(), app_Id, "masuk", "");

                }
                if (id == 26)
                {
                    // get detailuser and app setting
                   return SQLResearcher.GetInfo_ra(user.UserName.ToString(), app_Id, "keluar");
                  //  return SQLResearcher.GetInfoBaru_ra(user.UserName.ToString(), app_Id, "keluar", "");


                }

                if (id == 28)
                {
                    // return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "masuk");
                    IEnumerable<string> mas1 = SQLResearcher.New_CheckOpenGateMasuk_ra(user.UserName.ToString(), app_Id, lat1, long1, "masuk");
                    var myListzz = mas1.ToList();
                    if (myListzz[0] == "punchinok")
                    {
                        return SQLResearcher.GetInfoBaru_ra(user.UserName.ToString(), app_Id, "masuk", myListzz[1]);
                    }
                    else
                    {
                        return mas1;
                    }
                    if (id == 29)
                    {
                        // return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "masuk");
                        IEnumerable<string> mas1zz = SQLResearcher.New_CheckOpenGateMasuk_ra(user.UserName.ToString(), app_Id, lat1, long1, "masuk");
                        var myListzzf = mas1zz.ToList();
                        if (myListzzf[0] == "punchinok")
                        {
                            return SQLResearcher.GetInfoBaru_ra(user.UserName.ToString(), app_Id, "masuk", myListzzf[1]);
                        }
                        else
                        {
                            return mas1;
                        }


                    }

                }
                if (id == 30)
                {
                    //  return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "keluar");
                    IEnumerable<string> mas2 = SQLResearcher.New_CheckOpenGateMasuk_ra(user.UserName.ToString(), app_Id, lat1, long1, "keluar");
                    var myListzxz = mas2.ToList();
                    if (myListzxz[0] == "punchinok")
                    {
                        return SQLResearcher.GetInfoBaru_ra(user.UserName.ToString(), app_Id, "keluar", myListzxz[1]);
                    }
                    else
                    {
                        return mas2;
                    }

                }
                if (id == 31)
                {
                    //  return SQLPerakamgeo.CheckOpenGateMasuk(user.UserName.ToString(), app_Id, lat1, long1, "keluar");
                    IEnumerable<string> mas2 = SQLResearcher.New_CheckOpenGateMasuk_ra(user.UserName.ToString(), app_Id, lat1, long1, "keluar");
                    var myListzxz = mas2.ToList();
                    if (myListzxz[0] == "punchinok")
                    {
                        return SQLResearcher.GetInfoBaru_ra(user.UserName.ToString(), app_Id, "keluar", myListzxz[1]);
                    }
                    else
                    {
                        return mas2;
                    }

                }
                if (id == 32)
                {
                    return SQLResearcher.GetListLogSatu_ra(user.UserName.ToString(), app_Id);
                }
                if (id == 33)
                {
                    // get perakam smsm
                    string tar = orderId + "-" + lat1 + "-" + long1;
                    string tar2 = long1 + "-" + lat1 + "-" + orderId;
                    if (user.UserName.ToString() == "danny")
                    {
                        return SQLResearcher.GetSMSMPerakam_ra("00578", tar, tar2);
                    }
                    else
                    {
                        // dbstaf PW01_Hadir
                        return SQLResearcher.GetSMSMPerakam_ra(user.UserName.ToString(), tar, tar2);
                    }
                }
                /////  end attendane GRA



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