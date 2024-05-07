using System.Collections.Generic;
using System.Net.Http;
using System.Web.Http;
using System.Web;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.AspNet.Identity;


using System;

using System.Data.SqlClient;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Device.Location;

using System.Data;
using System.IO;
namespace WebApi.Controllers
{
    [Authorize]
    public class CutiTetapController : ApiController
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
        [HttpGet]
        [Route("api/CutiTetap/ph")]
        public IEnumerable<string> ph()
        {
            return SQLCutiTetap.GetJenCuti("");
        }
        [HttpGet]
        [Route("api/CutiTetap/bandar")]
        public List<Jobs> bandar()
        {
            var students = new List<Jobs>() {
                new Jobs(){ JobsId = "1", Name="bandar1", Location="Bidfll1"},
                new Jobs(){ JobsId = "2", Name="bandar2", Location="Bifsll2"},
                new Jobs(){ JobsId = "3", Name="bandar3", Location="BiAll3"},
                new Jobs(){ JobsId = "4", Name="bandar4", Location="Bifsfll4"},
            };

            return students;
        }
        [HttpGet]
        [Route("api/CutiTetap/negeri")]
        public List<Jobs> negeri()
        {
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            var students = new List<Jobs>();
            try
            {
                int i = 0;
                CommandText = "SELECT        Kod, Negeri FROM VNegeri where Kod <> '-'";
                con = new SqlConnection(SQLAuth.dbase_dbstaf);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    students.Add(new Jobs() { JobsId = rdr["kod"].ToString().Trim(), Name = rdr["Negeri"].ToString().Trim(), Location = i.ToString() });
                    i++;
                }
            }
            catch (Exception)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }




            //var students = new List<Jobs>() {
            //    new Jobs(){ JobsId = "1", Name="negara1", Location="Bidfll1"},
            //    new Jobs(){ JobsId = "2", Name="negara2", Location="Bifsll2"},
            //    new Jobs(){ JobsId = "3", Name="negara3", Location="BiAll3"},
            //    new Jobs(){ JobsId = "4", Name="negara4", Location="Bifsfll4"},
            //};
          //  var studentsx = new List<Jobs>();
          //  studentsx.Add(new Jobs() { JobsId = "1", Name = "negara1", Location = "0" });
           // return studentsx;
            //var students = new List<Jobs>() {
            //    new Jobs(){ JobsId = "1", Name="negeri1", Location="Bidfll1"},
            //    new Jobs(){ JobsId = "2", Name="negeri2", Location="Bifsll2"},
            //    new Jobs(){ JobsId = "3", Name="negeri3", Location="BiAll3"},
            //    new Jobs(){ JobsId = "4", Name="negeri4", Location="Bifsfll4"},
            //};

            return students;
        }
        [HttpGet]
        [Route("api/CutiTetap/negara")]
        public List<Jobs> negara()
        {

            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            var students = new List<Jobs>();
            try
            {
                CommandText = "SELECT        Kod, Negara FROM VNegara where Kod <> '999'";
                con = new SqlConnection(SQLAuth.dbase_dbstaf);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                int i = 0;
                while (rdr.Read())
                {
                    students.Add(new Jobs() { JobsId = rdr["kod"].ToString().Trim(), Name = rdr["Negara"].ToString().Trim(), Location = i.ToString() });
                    i++;
                }
            }
            catch (Exception)
            {
                
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }




            //var students = new List<Jobs>() {
            //    new Jobs(){ JobsId = "1", Name="negara1", Location="Bidfll1"},
            //    new Jobs(){ JobsId = "2", Name="negara2", Location="Bifsll2"},
            //    new Jobs(){ JobsId = "3", Name="negara3", Location="BiAll3"},
            //    new Jobs(){ JobsId = "4", Name="negara4", Location="Bifsfll4"},
            //};
          // var studentsx = new List<Jobs>();
           // studentsx.Add(new Jobs() { JobsId = "1", Name = "negara1", Location = "0" });
            return students;
        }
        [HttpGet]
        [Route("api/CutiTetap/prorate/{nostaf}")]
        public IEnumerable<string> GetPro(string nostaf)
        {
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
            return SQLCutiTetap.GetProCuti(user.UserName.ToString());

        }
        public class Jobs
        {
            public string JobsId { get; set; }
            public string Name { get; set; }
            public string Location { get; set; }
        }

        [Route("api/CutiTetap/SemakCuti")]
        public IEnumerable<string> SemakCuti(MySemakCuti semak)
        {
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
          //  string mymulax = semak.mula.Replace("x", "/").Replace("y", ":");
          //  string mytamatx = semak.tamat.Replace("x", "/").Replace("y", ":");
            return  SQLCutiTetap.SemakMohonCuti(user.UserName.ToString(), semak.mula, semak.tamat, semak.prorate, semak.mylang);
        }
        public class MySemakCuti
        {
            public string mula { get; set; }
            public string tamat { get; set; }
            public string prorate { get; set; }
            public string mylang { get; set; }
        }
        [HttpGet]
        [Route("api/CutiTetap/reportcuti")]
        public List<DataCuti> reportcuti()
        {
            var userId = User.Identity.GetUserId(); //requires using Microsoft.AspNet.Identity;
            var user = UserManager.FindById(userId);
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            var students = new List<DataCuti>();
            try
            {
                CommandText = "  SELECT TOP(100) PERCENT MS26_CutiStaf.MS26_KodMohonCuti, MS26_CutiStaf.MS01_NoStaf, MS26_CutiStaf.CT_KodKategoriCuti, MS26_CutiStaf.CT_KodCuti, MS26_CutiStaf.MS26_Tahun, convert(varchar,MS26_CutiStaf.MS26_TkhMula, 103)   as mydatein ,    ";
                CommandText = CommandText + "      convert(varchar,MS26_CutiStaf.MS26_TkhTamat, 103)   as mydateout ,  MS26_CutiStaf.MS26_BilHari, MS26_CutiStaf.MS01_AlamatT1, MS26_CutiStaf.MS01_AlamatT2, MS26_CutiStaf.MS01_PoskodTetap, MS26_CutiStaf.MS01_BandarTetap,  ";
                CommandText = CommandText + "   MS26_CutiStaf.MS01_NegeriTetap, MS26_CutiStaf.MS01_NegaraTetap, MS26_CutiStaf.MS01_NoTelR1, MS26_CutiStaf.MS26_TkhMohon, MS26_CutiStaf.MS26_Penyokong, MS26_CutiStaf.MS26_Pelulus,  ";
                CommandText = CommandText + "  MS26_CutiStaf.MS26_TkhSokong, MS26_CutiStaf.MS26_TkhLulus, MS26_CutiStaf.MS26_IDBatal, MS26_CutiStaf.MS26_TkhBatal, MS26_CutiStaf.MS26_StatusCuti, MS26_CutiStaf.MS26_SebabTakLulus,  ";
                CommandText = CommandText + "    MS26_CutiStaf.MS26_SebabCuti, MS26_CutiStaf.MS26_SebabBatal, MS26_CutiStaf.MS26_NoPT, MS26_CutiStaf.MS26_TkhPT, MS26_CutiStaf.CT_BilHariMohon, MS26_CutiStaf.MS26_IDKemaskini,  ";
                CommandText = CommandText + "    MS26_CutiStaf.MS26_TkhKemaskini, MS26_CutiStaf.MS26_KlinikPanel, MS26_CutiStaf.MS26_KlinikLain, MS26_CutiStaf.MS26_NoResitKlinik, MS26_CutiStaf.MS26_TkhResit, MS26_CutiStaf.Tkh_Wujud,  ";
                CommandText = CommandText + "      MS26_CutiStaf.MS26_StaEL, MS26_CutiStaf.MS26_KateKlinik, MS26_CutiStaf.MS08_Pejabat, CT_KodCuti.CT_KodKategoriCuti AS Expr5, CT_KodCuti.CT_KodCuti AS Expr6, CT_KodCuti.CT_PeneranganKod,  ";
                CommandText = CommandText + "      CT_KodCuti.CT_BilHari, CT_KodCuti.CT_BilSetahun, CT_KodCuti.CT_Status, CT_KodCuti.CT_StSabtuAhad, CT_KodCuti.CT_PeneranganKod AS Expr1, CT_KodCuti.CT_KodKategoriCuti AS Expr2,  ";
                CommandText = CommandText + "     MS26_CutiStaf.MS01_NoStaf AS Expr3, MS26_CutiStaf.CT_KodCuti AS Expr4 ";
                CommandText = CommandText + " FROM            MS26_CutiStaf INNER JOIN ";
                CommandText = CommandText + "       CT_KodCuti ON MS26_CutiStaf.CT_KodCuti = CT_KodCuti.CT_KodCuti ";
                CommandText = CommandText + " WHERE(MS26_CutiStaf.MS01_NoStaf = @userid) AND(MS26_CutiStaf.MS26_Tahun = @myYear) AND(MS26_CutiStaf.MS26_StatusCuti <> 'KECEMASAN') ";
                CommandText = CommandText + " ORDER BY MS26_CutiStaf.Tkh_Wujud desc";
               // CommandText = CommandText + " ORDER BY  MS26_CutiStaf.Tkh_Wujud, MS26_CutiStaf.MS26_TkhMohon, MS26_CutiStaf.MS26_KodMohonCuti desc";

               //   CommandText = CommandText + " ORDER BY  MS26_CutiStaf.MS26_TkhMula, MS26_CutiStaf.MS26_TkhMohon, MS26_CutiStaf.MS26_KodMohonCuti";

                con = new SqlConnection(SQLAuth.dbase_dbstaf);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
               
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", user.UserName.ToString());
                cmd.Parameters.AddWithValue("@myYear", DateTime.Now.ToString("yyyy"));
                rdr = cmd.ExecuteReader();
                int i = 0;
                string mystat = "";
                string mystatel = "";
                string mystatup = "";
                while (rdr.Read())  //Pembetulan
                {

               
                    if (rdr["MS26_StatusCuti"].ToString().Trim() == "Lulus"){
                        if ((bool)rdr["MS26_StaEL"] == true) { mystatel = "PINK"; } else { mystatel = "WHITE"; }
                        mystat = "check1.png";
                        mystatup = "";
                    }
                    else if ((rdr["MS26_StatusCuti"].ToString().Trim() == "Pembetulan") || (rdr["MS26_StatusCuti"].ToString().Trim() == "Proses") || (rdr["MS26_StatusCuti"].ToString().Trim() == "Sokong") ) {
                        mystat = "processing1.png";
                        if (rdr["MS26_StatusCuti"].ToString().Trim() == "Proses") { mystatup = "receiptx.png"; } else { mystatup = ""; }

                    }
                    else { 
                        mystat = "failed.png";
                        mystatup = "";
                    }
                    students.Add(new DataCuti() { Dari = rdr["mydatein"].ToString().Trim(), Hingga = rdr["mydateout"].ToString().Trim(), JenisCuti = rdr["MS26_SebabCuti"].ToString().Trim(), BilHari = rdr["MS26_BilHari"].ToString().Trim(), StatusCuti = mystat, Kecemasan = mystatel, KodMohon= rdr["MS26_KodMohonCuti"].ToString().Trim(), MyUpdate = mystatup });
                    i++;
                }
            }
            catch (Exception)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }




            //var students = new List<Jobs>() {
            //    new Jobs(){ JobsId = "1", Name="negara1", Location="Bidfll1"},
            //    new Jobs(){ JobsId = "2", Name="negara2", Location="Bifsll2"},
            //    new Jobs(){ JobsId = "3", Name="negara3", Location="BiAll3"},
            //    new Jobs(){ JobsId = "4", Name="negara4", Location="Bifsfll4"},
            //};
            //var studentsx = new List<Jobs>();
            //studentsx.Add(new Jobs() { JobsId = "1", Name = "negara1", Location = "Bidfll1" });
            return students;
        }
        public class DataCuti
        {
            public string Dari { get; set; }
            public string Hingga { get; set; }
            public string JenisCuti { get; set; }
            public string BilHari { get; set; }
            public string StatusCuti { get; set; }
            public string Kecemasan { get; set; }
            public string KodMohon { get; set; }
            public string MyUpdate { get; set; }
        }
    }
}
