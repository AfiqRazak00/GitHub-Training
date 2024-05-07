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
    public class PilihanrayaController : ApiController
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

        [Route("api/pilihanraya/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
        public IEnumerable<string> Get(int id, string orderId, string app_Id, string mob_Id, string logincode_Id, string lat1, string long1)
        {
            string mystr = "";
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
            IEnumerable<string> myValidLogin = SQLAuth.CheckValid_loginonly_pilihanraya(user.UserName.ToString(), logincode_Id);
            var myListx = myValidLogin.ToList();
            if (myListx[0] == "loginchanged")
            {
                return new string[] { "loginchanged" };
            }
            else
            {
               // IEnumerable<string> myValidLogin2 = SQLAuth.CheckValid_loginonly_pilihanraya(user.UserName.ToString(), logincode_Id);
              //  var myListx2 = myValidLogin2.ToList();
              //  if (myListx[0] == "loginchanged")
              //  {
              //      return new string[] { "loginchanged" };
              //  }
              //  else
              //  {
                    if (id == 1)
                    {
                        return SQLPilihanraya.GetCalonUmum(app_Id);

                    }
                    if (id == 11)
                    {
                        return SQLPilihanraya.GetCalonFakulti(app_Id);

                    }
                    if (id == 2)
                    {
                        // get data general pilihanraya sementara dbmobile
                        return SQLPilihanraya.GetGeneralSPR(orderId);
                    }

                    if (id == 3)
                    {
                        // insert  pilihan user bagi  umum
                        List<string> listt = new List<string>();
                        if ((SQLPilihanraya.pilihanrayamula() == true) && (SQLPilihanraya.pilihanraytamat() == false))
                        {
                            IEnumerable<string> statumum = SQLPilihanraya.TryUpdate1(user.UserName.ToString(), "umum");
                            var myListum = statumum.ToList();
                            if (myListum[0] == "1")
                            {
                                string dd = "";
                                listt.Add("ok");
                                string[] namesArray = lat1.Split(',');
                                int tot = namesArray.Count() - 1;
                                for (int i = 0; i < tot; i++)
                                {
                                    dd = SQLPilihanraya.WriteUmumPilihanraya(user.UserName.ToString(), namesArray[i], myListum[1]);
                                }

                            }
                            else
                            {
                                listt.Add("Haraf maaf, rekod menunjukan anda telah mengundi");
                            }
                        }
                        else
                        {
                            listt.Add("Haraf maaf, waktu mengundi ditutup");
                        }
                        string[] arrayx = listt.ToArray();
                        return arrayx;
                    }
                    if (id == 4)
                    {

                        // insert pilihan user bagi kawasan
                        List<string> listx = new List<string>();
                        if ((SQLPilihanraya.pilihanrayamula() == true) && (SQLPilihanraya.pilihanraytamat() == false))
                        {
                            IEnumerable<string> statfakulti = SQLPilihanraya.TryUpdate1(user.UserName.ToString(), "fakulti");
                            var myListfa = statfakulti.ToList();
                            if (myListfa[0] == "1")
                            {
                                string dd = "";
                                listx.Add("ok");
                                string[] namesArray = lat1.Split(',');
                                int tot = namesArray.Count() - 1;
                                for (int i = 0; i < tot; i++)
                                {
                                    dd = SQLPilihanraya.WriteKawasanPilihanraya(user.UserName.ToString(), namesArray[i], myListfa[1]);
                                }
                            }
                            else
                            {
                                listx.Add("Haraf maaf, rekod menunjukan anda telah mengundi");
                            }
                        }
                        else
                        {
                            listx.Add("Haraf maaf, waktu mengundi ditutup");
                        }
                        string[] arrayx = listx.ToArray();
                        return arrayx;

                    }
                    if (id == 5)
                    {
                        // cari status user umum
                        return SQLPilihanraya.StatusPilihanraya_umum(user.UserName.ToString());

                    }
                    if (id == 6)
                    {
                        // cari status user kawasan
                        //  return SQLPilihanraya.StatusPilihanraya_kawasan2(user.UserName.ToString(), app_Id);
                        return SQLPilihanraya.StatusPilihanraya_kawasan(user.UserName.ToString());

                    }

                    if (id == 7)
                    {
                        // Dapatkan info general pilihanraya

                        List<string> list = new List<string>();
                        list.Add("16-01-2023");
                        list.Add("8:00 pagi -5:00 petang");
                        list.Add("2022/2023");
                        list.Add("PEMILIHAN MAJLIS PERWAKILAN PELAJAR (PMPP) UTeM");

                        IEnumerable<string> values = SQLPilihanraya.StatusPilihanraya_umum(user.UserName.ToString());
                        var myList = values.ToList();
                        list.Add(myList[0]);  // status umum      
                        string values2bb = SQLPilihanraya.StatusPilihanraya_kawasan2(user.UserName.ToString());
                        list.Add(values2bb);  // status kawasan
                        if (SQLPilihanraya.pilihanrayamula() == true)
                        {
                            list.Add("1");   // mula
                        }
                        else
                        {
                            list.Add("0");   // mula
                        }
                        if (SQLPilihanraya.pilihanraytamat() == true)
                        {
                            list.Add("1");   // tamat
                        }
                        else
                        {
                            list.Add("0");   // tamat
                        }
                        string[] arrayx = list.ToArray();
                        return arrayx;




                    }


                    if (id == 8)
                    {
                        // check status pilihanraya open or close
                        return SQLPilihanraya.GetStatusOpenClose_pilihanraya();

                    }

                    if (id == 9)
                    {
                        // check status pilihanraya open or close
                        return SQLPilihanraya.GetStatusicon_pilihanraya(user.UserName.ToString());

                    }
                    return new string[] { "loginchanged" };
              //  }
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
