using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.AspNet.Identity;
using System.Globalization;
namespace WebApi.Controllers
{
    [Authorize]
    public class MigsController : ApiController
    {
        // GET: Migs
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
        // GET api/aduan
        //  public IEnumerable<string> Get()
        //  {

        //     return new string[] { "bbb" };
        //  }

        // khalid

        [Route("api/migs/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
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
                    // get detailuser and app setting  GetSumbanganDetailPaid(string userid, string sid)
                    return SQLMigs.GetMIGSSumbangan(user.UserName.ToString());
                }
                if (id == 2)
                {
                    // get detailuser and app setting  GetSumbanganDetailPaid(string userid, string sid)
                   // return new string[] { lat1 };
                    return SQLMigs.GetSumbanganDetailPaid(user.UserName.ToString(), lat1);
                }
                return new string[] { "loginchanged" };
            }
          
        }

         // end khalid







                // GET api/aduan/5

                public IEnumerable<string> Get([FromUri] MIGSModel stud)
        {
            return new string[] { "okk " + stud.Namamodul.ToString() };
        }


        // POST api/aduan
        public void Post([FromBody] string value)
        {

        }

        // PUT api/aduan/5
        public void Put(int id, [FromBody] string value)
        {

        }

        // DELETE api/aduan/5
        public void Delete(int id)
        {

        }
        // POST api/Account/Register 

        [Route("api/Migs/Register")]
        public IEnumerable<string> Register(MIGSModel mypay)
        {

            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
           string myjenistran  = "";
            myjenistran  = "" + mypay.Param3;
            //  return SQLMigs.GetHutang("dd");
            ////  return SQLPerakamgeo.HantarAduan(user.UserName.ToString(), stud.Name);
           if ((myjenistran.Trim() == "") || (myjenistran.Trim() == "card")) { 
                        string data = SQLMigs.Writetrybayarmigs(mypay.Namamodul, user.UserName.ToString(), mypay.Jumlah, mypay.Nota, mypay.Param1, mypay.Param2, mypay.Param3);
                        if (data == "no")
                        {
                            return new string[] { "no" };
                        }
                        else
                        {
                           return new string[] { data };
                        }
                        }
            else {
                //string data = SQLMigs.Writetrybayarfpx(mypay.Namamodul, user.UserName.ToString(), mypay.Jumlah, mypay.Nota, mypay.Param1, mypay.Param2, mypay.Param3);
                //if (data == "no")
                //{
                //    return new string[] { "no" };
                //}
                //else
                //{
                //    return new string[] { data, SQLMigs.getcodebank(mypay.Param3) };
                //}
                ////  return new string[] { "loginchanged" };
                ///

                IEnumerable<string> mydata = SQLMigs.WritetrybayarfpxNew(mypay.Namamodul, user.UserName.ToString(), mypay.Jumlah, mypay.Nota, mypay.Param1, mypay.Param2, mypay.Param3);
                var myListx = mydata.ToList();
                if (myListx[0] == "no")
                {
                    return new string[] { "no", myListx[1] };
                }
                else
                {
                    return new string[] { myListx[0], myListx[1] };
                }



                }


        
            // return SQLPerakamgeo.HantarAduan(user.UserName.ToString(), mypay.Namamodul);

        }
        public class MIGSModel
        {

            public string Namamodul { get; set; }


            public string Jumlah { get; set; }
            public string Nota { get; set; }

            public string Param1 { get; set; }

            public string Param2 { get; set; }

            public string Param3 { get; set; }




        }
        [Route("api/Migs/ResetPass")]
        public IEnumerable<string> ResetPass(ResetModel mypay)
        {

            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
            // string data = "";
            //  return SQLMigs.GetHutang("dd");
            ////  return SQLPerakamgeo.HantarAduan(user.UserName.ToString(), stud.Name);
           if (mypay.Mymodul.ToString().Trim() == "Portal")
           {
                if (SQLMigs.StatusResetPassword(user.UserName.ToString(), mypay.Mymodul) == "no")
                {
                    string data = SQLMigs.ResetPasswordPortal(user.UserName.ToString(), mypay.Mymodul, mypay.Mypass, mypay.Mytype, mypay.Myemail, mypay.Mylang);
                    if (data == "no")
                    {
                        return new string[] { "no" };
                    }
                    else
                    {
                        return new string[] { data };
                    }
                }
                else
                {
                    return new string[] { "Sedang dalam prosess. Sila tunggu" };
                }
              
            }
            else
            {
            if (SQLMigs.StatusResetPassword(user.UserName.ToString(), mypay.Mymodul) == "no") {
                string data = SQLMigs.ResetPassword(user.UserName.ToString(), mypay.Mymodul, mypay.Mypass, mypay.Mytype, mypay.Myemail, mypay.Mylang);
                if (data == "no")
                {
                    return new string[] { "no" };
                }
                else
                {
                    return new string[] { data };
                }
            }
            else
            {
                return new string[] { "Sedang dalam prosess. Sila tunggu" };
            }
            }
            // return SQLPerakamgeo.HantarAduan(user.UserName.ToString(), mypay.Namamodul);

        }
        public class ResetModel
        {

            public string Mymodul { get; set; }
            public string Mypass { get; set; }
            public string Mytype { get; set; }
            public string Myemail { get; set; }
            public string Mylang { get; set; }




        }
        [Route("api/Migs/CutiSetData")]
        public IEnumerable<string> CutiSetData(CutiSet mycutiset)
        {

            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);


            if (SQLCutiTetap.Semak_EL_Action(user.UserName.ToString()) == "1")
            {
                return new string[] { "no" };
            }
            else
            {

                DateTime startDate = Convert.ToDateTime(DateTime.ParseExact(mycutiset.MystartDate, "dd/MM/yyyy", CultureInfo.InvariantCulture));
                DateTime endDate = Convert.ToDateTime(DateTime.ParseExact(mycutiset.MyendDate, "dd/MM/yyyy", CultureInfo.InvariantCulture));
                if (SQLCutiTetap.Cuti_duplicateornot(user.UserName.ToString(), startDate, endDate) == "found")
                {
                    return new string[] { "no" };
                }
                else if (SQLCutiTetap.Cuti_duplicateornot(user.UserName.ToString(), startDate, endDate) == "err")
                {
                    return new string[] { "no" };
                }
                else
                {




                    string data = SQLMigs.InsertCutiSetting(user.UserName.ToString(),
                                                                                        mycutiset.MystartDate,
                                                                                        mycutiset.MyendDate,
                                                                                        mycutiset.MynumberOfDays,
                                                                                        mycutiset.Myalamat,
                                                                                        mycutiset.Myposkod,
                                                                                        mycutiset.Mybandar,
                                                                                        mycutiset.Mytelefon,
                                                                                        mycutiset.Mysebab,
                                                                                        mycutiset.Mynegeri,
                                                                                        mycutiset.Mynegara,
                                                                                        mycutiset.Myemail,
                                                                                        mycutiset.Mylang);
                    if (data == "no")
                    {
                        return new string[] { "no" };
                    }
                    else
                    {
                        return new string[] { data };
                    }
                }
            }
        }
        public class CutiSet
        {
            public string MystartDate { get; set; }
            public string MyendDate { get; set; }
            public string MynumberOfDays { get; set; }

            public string Myalamat { get; set; }
            public string Myposkod { get; set; }
            public string Mybandar { get; set; }
            public string Mytelefon { get; set; }
            public string Mysebab { get; set; }
            public string Mynegeri { get; set; }
            public string Mynegara { get; set; }
            public string Myemail { get; set; }
            public string Mylang { get; set; }
       


        }
    }
}