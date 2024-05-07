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
    public class PilihanrayaseController : ApiController
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

        [Route("api/pilihanrayase/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
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
                    List<string> list = new List<string>();
                    list.Add("e-Undi Pemilihan Ahli Senat"); // NameGeneral = "PEMILIHAN SENAT  UTeM";
                    list.Add("14-12-2020"); // Tarikh = "TARIKH : 11-12-2029 - 13-12-2020";
                    list.Add("BIDANG 1"); // zon1_name = "ZON 1";
                    list.Add("3"); // zon1_kenaundi = 2;
                    list.Add("6"); // zon1_jumcalon = 3;
                    list.Add("BIDANG 2"); // zon2_name = "ZON 2";
                    list.Add("3"); // zon2_kenaundi = 2;
                    list.Add("7"); // zon2_jumcalon = 3;
                    list.Add("BIDANG 3"); // zon3_name = "ZON 3";
                    list.Add("3"); // zon3_kenaundi = 2;
                    list.Add("7"); // zon3_jumcalon = 3;
                    list.Add("0"); // zon_id = 0;
                    list.Add("1"); // zon1_id = 1;
                    list.Add("2"); // zon2_id = 2;
                    list.Add("3"); // zon3_id = 3;

                    IEnumerable<string> valuesx = SQLPilihanrayase.GetStatusicon_pilihanraya(user.UserName.ToString());
                    var myListxz = valuesx.ToList();
                    list.Add(myListxz[0]);  // icon
                    IEnumerable<string> values = SQLPilihanrayase.GetStatusOpenClose_pilihanraya(user.UserName.ToString());
                    var myListg = values.ToList();
                    list.Add(myListg[0]);  // bole undi

                    IEnumerable<string> ffvalues = SQLPilihanrayase.StatusPilihanraya(user.UserName.ToString(), "KAT1");
                    var ffmyListg = ffvalues.ToList();
                    list.Add(ffmyListg[0]);  // bole undi
                    IEnumerable<string> ffvalues2 = SQLPilihanrayase.StatusPilihanraya(user.UserName.ToString(), "KAT2");
                    var ffmyListg2 = ffvalues2.ToList();
                    list.Add(ffmyListg2[0]);  // bole undi
                    IEnumerable<string> ffvalues3 = SQLPilihanrayase.StatusPilihanraya(user.UserName.ToString(), "KAT3");
                    var ffmyListg3 = ffvalues3.ToList();
                    list.Add(ffmyListg3[0]);  // bole undi

                    string[] arrayx = list.ToArray();
                    return arrayx;

                }
                if (id == 2)
                {
                    return SQLPilihanrayase.GetCalonzon("KAT1");
                }
                if (id == 3)
                {
                    return SQLPilihanrayase.GetCalonzon("KAT2");
                }
                if (id == 4)
                {
                    return SQLPilihanrayase.GetCalonzon("KAT3");
                }

                if (id == 5)
                {
                   // List<string> list = new List<string>();
                  //  list.Add("Belum Selesai");
                  //  string[] arrayx = list.ToArray();
                  //  return arrayx;
                    return SQLPilihanrayase.StatusPilihanraya(user.UserName.ToString(), "KAT1");

                }
                if (id == 6)
                {
                 //   List<string> list = new List<string>();
                 //   list.Add("Belum Selesai");
                  //  string[] arrayx = list.ToArray();
                  //  return arrayx;
                    return SQLPilihanrayase.StatusPilihanraya(user.UserName.ToString(), "KAT2");

                }
                if (id == 7)
                {
                   // List<string> list = new List<string>();
                   // list.Add("Belum Selesai");
                  //  string[] arrayx = list.ToArray();
                  //  return arrayx;
                    return SQLPilihanrayase.StatusPilihanraya(user.UserName.ToString(), "KAT3");

                }

                if (id == 8)
                {
                    // insert  pilihan user bagi  umum
                    IEnumerable<string> valuesre1 = SQLPilihanrayase.GetStatusOpenClose_pilihanraya(user.UserName.ToString());
                    var myListgre1 = valuesre1.ToList();
                    List<string> listt1 = new List<string>();
                    if (myListgre1[0] == "1")
                    {
                        IEnumerable<string> ffvalueszz1 = SQLPilihanrayase.StatusPilihanraya(user.UserName.ToString(), "KAT1");
                        var ffmyListgzz1 = ffvalueszz1.ToList();
                        if (ffmyListgzz1[0] == "Belum Selesai")
                        {
                            IEnumerable<string> statumum = SQLPilihanrayase.TryUpdate1(user.UserName.ToString(), "KAT1");
                            var myListum = statumum.ToList();
                            if (myListum[0] == "1")
                            {
                                string dd = "";
                                listt1.Add("ok");
                                string[] namesArray = lat1.Split(',');
                                int tot = namesArray.Count() - 1;
                                for (int i = 0; i < tot; i++)
                                {
                                    dd = SQLPilihanrayase.WriteUmumPilihanraya(user.UserName.ToString(), namesArray[i], myListum[1]);
                                }

                            }
                            else
                            {
                                listt1.Add("Haraf maaf, rekod menunjukan anda telah mengundi");
                            }
                        }
                        else
                        {
                            listt1.Add("Haraf maaf, rekod menunjukan anda telah mengundi");
                        }
                    }
                    else
                    {
                        listt1.Add("Haraf maaf, waktu mengundi ditutup");
                    }
                    string[] arrayx = listt1.ToArray();
                    return arrayx;
                }
                if (id == 9)
                {
                    // insert  pilihan user bagi  umum
                    List<string> listt2 = new List<string>();
                    IEnumerable<string> valuesre2 = SQLPilihanrayase.GetStatusOpenClose_pilihanraya(user.UserName.ToString());
                    var myListgre2 = valuesre2.ToList();
                    if (myListgre2[0] == "1")
                    {
                        IEnumerable<string> ffvalueszz2 = SQLPilihanrayase.StatusPilihanraya(user.UserName.ToString(), "KAT2");
                        var ffmyListgzz2 = ffvalueszz2.ToList();
                        if (ffmyListgzz2[0] == "Belum Selesai")
                        {
                            IEnumerable<string> statumum = SQLPilihanrayase.TryUpdate1(user.UserName.ToString(), "KAT2");
                            var myListum = statumum.ToList();
                            if (myListum[0] == "1")
                            {
                                string dd = "";
                                listt2.Add("ok");
                                string[] namesArray = lat1.Split(',');
                                int tot = namesArray.Count() - 1;
                                for (int i = 0; i < tot; i++)
                                {
                                    dd = SQLPilihanrayase.WriteUmumPilihanraya(user.UserName.ToString(), namesArray[i], myListum[1]);
                                }

                            }
                            else
                            {
                                listt2.Add("Haraf maaf, rekod menunjukan anda telah mengundi");
                            }
                        }
                        else
                        {
                            listt2.Add("Haraf maaf, rekod menunjukan anda telah mengundi");
                        }
                    }
                      else
                      {
                          listt2.Add("Haraf maaf, waktu mengundi ditutup");
                      }
                    string[] arrayx = listt2.ToArray();
                    return arrayx;
                }
                if (id == 10)
                {
                    // insert  pilihan user bagi  umum
                    List<string> listt3 = new List<string>();
                    IEnumerable<string> valuesre3 = SQLPilihanrayase.GetStatusOpenClose_pilihanraya(user.UserName.ToString());
                    var myListgre3 = valuesre3.ToList();
                    if (myListgre3[0] == "1")
                    {
                            IEnumerable<string> ffvalueszz3 = SQLPilihanrayase.StatusPilihanraya(user.UserName.ToString(), "KAT3");
                            var ffmyListgzz3 = ffvalueszz3.ToList();
                            if (ffmyListgzz3[0] == "Belum Selesai")
                            {
                                IEnumerable<string> statumum = SQLPilihanrayase.TryUpdate1(user.UserName.ToString(), "KAT3");
                                var myListum = statumum.ToList();
                                if (myListum[0] == "1")
                                {
                                    string dd = "";
                                    listt3.Add("ok");
                                    string[] namesArray = lat1.Split(',');
                                    int tot = namesArray.Count() - 1;
                                    for (int i = 0; i < tot; i++)
                                    {
                                        dd = SQLPilihanrayase.WriteUmumPilihanraya(user.UserName.ToString(), namesArray[i], myListum[1]);
                                    }

                                }
                                else
                                {
                                    listt3.Add("Haraf maaf, rekod menunjukan anda telah mengundi");
                                }
                        }
                        else
                        {
                            listt3.Add("Haraf maaf, rekod menunjukan anda telah mengundi");
                        }
                    }
                      else
                      {
                          listt3.Add("Haraf maaf, waktu mengundi ditutup");
                      }
                    string[] arrayx = listt3.ToArray();
                    return arrayx;
                }
                return new string[] { "loginchanged" };
            }

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
