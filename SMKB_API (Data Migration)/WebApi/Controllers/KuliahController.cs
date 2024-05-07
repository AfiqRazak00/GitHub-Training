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
    public class KuliahController : ApiController
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

        //    [Route("api/kuliah/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}")]
        //   public IEnumerable<string> Get(int id, string orderId, string app_Id, string mob_Id, string logincode_Id)
        [Route("api/kuliah/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
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
                    return SQLKuliah.GetListSubject(user.UserName.ToString());

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
                if (id == 11)
                {
                    return SQLKuliahStudent.GetStudentResult(user.UserName.ToString());
                  //  return SQLPerakamgeo.GetListLogSatu("00578", "3");

                }
                if (id == 12)
                {
                    //  return SQLKuliahStudent.GetStudentResult12(user.UserName.ToString());
                    //  return SQLPerakamgeo.GetListLogSatu("00578", "3");
                    return SQLKuliahStudent.GetStudentResultNew(user.UserName.ToString());

                }
                if (id == 13)
                {
                    //  result detail by student perlu sesi
                    string mysesi1 = lat1.Replace("x", "-").Replace("y", "/");
                    return SQLKuliahStudent.GetStudentResultDetNew(user.UserName.ToString(), mysesi1);

                }
                if (id == 14)
                {
                    //  senarai sessi by student
                    return SQLKuliahStudent.GetSessiList(user.UserName.ToString());

                }
                if (id == 15)
                {
                    //  senarai sessi by student perlu sesi Replace("-", "x").Replace("/", "y")
                    // sumary bawah
                    string mysesi2 = lat1.Replace("x", "-").Replace("y", "/");
                    return SQLKuliahStudent.GetSessiSum(user.UserName.ToString(), mysesi2);

                }
                if (id == 16)
                {
                    //  senarai sessi by student
                    if (
                       (user.ToString().Contains("d")) ||
                       (user.ToString().Contains("b")) 
                       )
                    {
                        return SQLKuliahStudent.GetHutang(user.UserName.ToString());
                    }
                    else if (
                       (user.ToString().Contains("bs")) 
                       )
                    {
                         return SQLKuliahStudent.GetHutang_pasca(user.UserName.ToString(), "bs");
                    }
                    else if (
                       (user.ToString().Contains("m")) ||
                       (user.ToString().Contains("p"))
                       )
                    {
                          return SQLKuliahStudent.GetHutang_pasca(user.UserName.ToString(), "mp");
                    }
                    else
                    {

                    }

                }
                if (id == 20)
                {
                    if (
                    (user.UserName.ToString().Contains("d")) ||
                    (user.UserName.ToString().Contains("b")) ||
                    (user.UserName.ToString().Contains("bs")) ||
                    (user.UserName.ToString().Contains("m")) ||
                    (user.UserName.ToString().Contains("p"))
                       )
                       {
                        return SQLKuliahStudent.GetStudentSaman(user.UserName.ToString(), "", "student");
                    }
                       else
                    {
                        //  return new string[] { "hghgd", "ffg", "hyy7","ggt" };
                        return SQLKuliahStudent.GetStudentSaman(user.UserName.ToString(), "", "staff");
                    }
                }
                if (id == 21)
                {
                    // string mysesi1 = lat1.Replace("x", "-").Replace("y", "/");
                    return SQLKuliahStudent.GetStudentSamanDetail(user.UserName.ToString(), lat1);
                }
                if (id == 22)
                {
                    string mysesi1 = long1.Replace("x", ".");
                    return SQLKuliahStudent.BayarSaman(user.UserName.ToString(), lat1, mysesi1);
                }
                if (id == 23)
                {
                    // string mysesi1 = lat1.Replace("x", "-").Replace("y", "/");
                    return SQLKuliahStudent.GetStudentSamanDetailPaid(user.UserName.ToString(), lat1);
                }

                if (id == 24)  
                {
                    //  result detail by student perlu sesi
                    string mysesi1 = lat1.Replace("x", "-").Replace("y", "/");
                    return SQLKuliahStudent.GetPenyataAkaun(user.UserName.ToString(), mysesi1);

                }
                if (id == 25)
                {
                    // string mysesi1 = lat1.Replace("x", "-").Replace("y", "/");
                    return SQLKuliahStudent.GetDetailResetPassword(orderId, user.UserName.ToString(), lat1);
                }
                if (id == 26)
                {
                    //  senarai sessi by student
                    return SQLKuliahStudent.GetBankList(user.UserName.ToString());

                }
                if (id == 27)
                {
                    //  senarai sessi by student
                    return SQLKuliahStudent.GetSumbList(user.UserName.ToString());

                }
                if (id == 28)
                {
                    // string mysesi1 = lat1.Replace("x", "-").Replace("y", "/");
                    return SQLKuliahStudent.GetDetailCuti(orderId, user.UserName.ToString(), lat1.Replace("x", ":").Replace("y", "/"));
                }
                if (id == 29)
                {
                      return SQLKuliahStudent.GetDetailBatalCuti(orderId, user.UserName.ToString(), lat1.Replace("x", ":").Replace("y", "/"));
                }
                if (id == 30)
                {
                    return SQLKuliahStudent.ConfirmBatalCuti(orderId, user.UserName.ToString(), lat1.Replace("x", ":").Replace("y", "/"));
                }
                return new string[] { "loginchanged" };
                //  return SQLAuth.finddatasmkb(user.UserName.ToString(), "nama", user.PasswordHash.ToString()) ;  0065224/03/202315:25:35
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
