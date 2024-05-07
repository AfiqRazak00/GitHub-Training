using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.DirectoryServices;
using System.Web;
using System.DirectoryServices.AccountManagement;
using System.DirectoryServices;
using WebApi.Models;


using System.Globalization;















namespace WebApi
{
    public class SQLCutiTetap
    {
        public static IEnumerable<string> GetJenCuti(string Num)
        {
            //Jenis
            //   string[] ret = new string[3];
            var rec = new List<string>();
            // ret[0] = "no";

            //  string ret = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='DbStaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT FORMAT(PW09_Tarikh, 'dd/MM/yyyy') AS FormattedDate from V_MOBILEKALENDAR";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@SMK_ButiranJenis", Num);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    rec.Add(rdr.GetString(0));
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

            return rec;



        }

        public  static IEnumerable<string> SemakMohonCuti(string userid, string mula, string tamat, string prorate, string Mylang)
        {
            string[] ret = new string[5];
            ret[0] = "0";
            //ret[1] = "1";
            // return ret;
            //    mula = "29/03/2023";
            //   tamat = "29/03/2023";
            if (Semak_EL_Action(userid) == "1")
            {
                if (Mylang == "malay") { ret[1] = "Sila ke Portal UTeM 'https://portal.utem.edu.my/iutem' untuk mengisi maklumat cuti kecemasan didalam modul cuti SMSM"; }
                else
                {
                    ret[1] = "Please go to the UTeM Portal 'https://portal.utem.edu.my/iutem' to fill in the emergency leave information in the SMSM leave module";
                }
            }
            else
            {

                IEnumerable<string> valuesxx = SQLCutiTetap.GetProCuti(userid);
                var myListxx = valuesxx.ToList();
                prorate = myListxx[0];

                // ret[1] = "xBilangan";
                IEnumerable<string> values4 = SQLCutiTetap.GetJenCuti("");
                string dateFormat = "dd/MM/yyyy";

                DateTime startDate = Convert.ToDateTime(DateTime.ParseExact(mula, "dd/MM/yyyy", CultureInfo.InvariantCulture));
                DateTime endDate = Convert.ToDateTime(DateTime.ParseExact(tamat, "dd/MM/yyyy", CultureInfo.InvariantCulture));
                List<DateTime> publicHolidays = new List<DateTime>();
                foreach (string value in values4)
                {
                    if (!string.IsNullOrEmpty(value))
                    {
                        publicHolidays.Add(DateTime.ParseExact(value, dateFormat, CultureInfo.InvariantCulture));
                    }
                }
                int numberOfDays = 0;
                for (DateTime i = startDate; i <= endDate; i = i.AddDays(1))
                {
                    if (publicHolidays.Contains(i))
                    {

                        continue;
                    }
                    numberOfDays++;
                }
                if (numberOfDays == 0)
                {
                    if (Mylang == "malay") { ret[1] = "Tarikh pilihan bukan hari bekerja. Sila pilih semula"; }
                    else
                    {
                        ret[1] = "Selected date is not a working day. Please select again";
                    }

                }
                else if (numberOfDays <= Int32.Parse(prorate))
                {
                    //ValuesService GetInfox = new ValuesService();
                    //List<Jobs> dd1 = await GetInfox.GetDataList("/CutiTetap/negeri");
                    //ValuesService GetInfox2 = new ValuesService();
                    //List<Jobs> dd2 = await GetInfox2.GetDataList("/CutiTetap/negara");
                    //myLoader.myDialogClose(); await Navigation.PushAsync(new NavigationMasterDetail.Views.PerCuti(startDate, endDate, numberOfDays.ToString(), dd1, dd2));
                    //ok
                    if (Cuti_duplicateornot(userid, startDate, endDate) == "found")
                    {
                        ret[0] = "0";
                        if (Mylang == "malay") { ret[1] = "Rekod permohonan cuti sudah wujud dalam database. Sila pilih semula"; }
                        else
                        {
                            ret[1] = "Leave application already exist in database. Please select again";
                        }
                    }
                    else if (Cuti_duplicateornot(userid, startDate, endDate) == "err")
                    {
                        ret[0] = "0";
                        if (Mylang == "malay") { ret[1] = "errror"; }
                        else
                        {
                            ret[1] = "errorr";
                        }
                    }
                    else
                    {
                        ret[0] = "1";
                        ret[1] = numberOfDays.ToString();

                    }

                }
                else
                {
                    if (Mylang == "malay") { ret[1] = "Bilangan hari yang dipohon adalah melebihi bilangan hari yang layak. Sila pilih semula"; }
                    else
                    {
                        ret[1] = "The number of days requested exceeds the number of eligible days. Please select again";
                    }
                }

            }
            return ret;
        }


        public static string Semak_EL_Action(string userid)
        {

            String ConnectionString = "";
            string CommandText = "";
            string mjum = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //MS26_Tahun=@myYear
                ConnectionString = SQLAuth.dbase_dbstaf;
                CommandText = "SELECT     MS01_NoStaf from  MS26_CutiStaf where  MS01_NoStaf = @user_id AND MS26_StatusCuti = @cemas AND MS26_StaEL=1";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@user_id", userid);
                cmd.Parameters.AddWithValue("@cemas", "Kecemasan");
                cmd.Parameters.AddWithValue("@myYear", DateTime.Now.ToString("yyyy"));
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mjum = "1";
                    break;
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
            return mjum;
        }



        public static  List<SMSKelulusanCutiModel> GetDetailCuti()
        {
            //SecureId = Convert.ToInt32(dr["Id"]),
            //             CutiId = Convert.ToString(dr["Name"]),
            //             Nama = Convert.ToString(dr["City"]),
            //             TarikhDari = Convert.ToString(dr["Address"])

            List<SMSKelulusanCutiModel> studentlist = new List<SMSKelulusanCutiModel>();
            studentlist.Add(
                     new SMSKelulusanCutiModel
                     {
                         SecureId = "dgdf",
                         CutiId = "dgdf",
                         Nama = "dgdf",
                         TarikhDari = "dgdf",
                         TarikhHingga = "dgdf",
                         JumlahHari = "dgdf",
                         SebabCuti = "dgdf",
                         StatusCuti = "dgdf",
                         Nota = "dgdf"

                     });
            return studentlist;

        }
            public static IEnumerable<DateTime> EachCalendarDay(DateTime startDate, DateTime endDate)
        {
            for (var date = startDate.Date; date.Date <= endDate.Date; date = date.AddDays(1)) yield
            return date;
        }
        public static string Cuti_duplicateornot(string userid, DateTime startDate, DateTime EndDate)
        {

            String ConnectionString = "";
            string CommandText = "";
            string mjum = "no";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                foreach (DateTime myday in EachCalendarDay(startDate, EndDate))
                {
                    ConnectionString = SQLAuth.dbase_dbstaf;
                    CommandText = "SELECT * FROM MS26_CutiStaf ";
                    CommandText = CommandText + " WHERE MS01_NoStaf = @user_id ";
                    CommandText = CommandText + " AND YEAR(MS26_TkhMula)= YEAR(getdate()) ";
                    CommandText = CommandText + " AND MS26_StatusCuti<> 'Batal'  ";
                    CommandText = CommandText + " AND MS26_StatusCuti<> 'Tidak Lulus' AND MS26_StatusCuti<> 'Tidak Sokong' ";
                    CommandText = CommandText + " AND MS26_StatusCuti<> 'Pembetulan'  ";
                    CommandText = CommandText + " and  @myday  BETWEEN cast(MS26_TkhMula as date) and cast(MS26_TkhTamat as date) ";
                    // CommandText = CommandText + " AND @mula BETWEEN CAST(LEFT(MS26_TkhMula,11) AS DATETIME)  AND CAST(LEFT(MS26_TkhMula,11) AS DATETIME) ";
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@user_id", userid);
                    cmd.Parameters.AddWithValue("@myday", myday);
                    rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        mjum = "found";
                        break;
                    }
                    if (mjum == "found")
                    {

                        break;
                    }
                }
                return mjum;
            }
            catch (Exception)
            {
                return "err";
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }

        public static string Cuti_duplicateornotbak(string userid, DateTime startDate, DateTime EndDate)
        {

            String ConnectionString = "";
            string CommandText = "";
            string mjum = "no";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                ConnectionString = SQLAuth.dbase_dbstaf;
                CommandText = "SELECT * FROM MS26_CutiStaf ";
                CommandText = CommandText + " WHERE MS01_NoStaf = @user_id ";
                CommandText = CommandText + " AND YEAR(MS26_TkhMula)= YEAR(getdate()) ";
                CommandText = CommandText + " AND MS26_StatusCuti= 'Proses'  ";
                CommandText = CommandText + " AND MS26_StatusCuti<> 'Batal'  ";
                CommandText = CommandText + " AND MS26_StatusCuti<> 'Tidak Lulus' AND MS26_StatusCuti<> 'Tidak Sokong' ";
                CommandText = CommandText + " AND MS26_StatusCuti<> 'Pembetulan'  ";
                CommandText = CommandText + " and  cast(MS26_TkhMula as date)  BETWEEN @mula and @tamat ";
                // CommandText = CommandText + " AND @mula BETWEEN CAST(LEFT(MS26_TkhMula,11) AS DATETIME)  AND CAST(LEFT(MS26_TkhMula,11) AS DATETIME) ";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@user_id", userid);
                cmd.Parameters.AddWithValue("@mula", startDate);
                cmd.Parameters.AddWithValue("@tamat", EndDate);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mjum = "found";
                    break;
                }
                return mjum;
            }
            catch (Exception)
            {
                return "err";
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }

        public static IEnumerable<string> SemakMohonCutiDetail(string stafno, string seccode)
        {
            string[] ret = new string[5];
            ret[0] = "no";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                con = new SqlConnection(SQLAuth.dbase_dbstaf);
                con.Open();
                string CommandText = "SELECT MS26_SebabCuti,MS_Sumber, MS_SecCode, MS26_KodMohonCuti, MS01_NoStaf, CT_KodKategoriCuti, CT_KodCuti, MS26_Tahun, FORMAT(MS26_TkhMula, 'dd/MM/yyyy') AS mula , FORMAT(MS26_TkhTamat, 'dd/MM/yyyy') AS tamat  , MS26_BilHari, MS01_AlamatT1, MS01_AlamatT2, MS01_PoskodTetap, MS01_BandarTetap  ";
              //  CommandText = CommandText + " FROM MS26_CutiStaf where MS_SecCode=@seccode";
                CommandText = CommandText + " FROM MS26_CutiStaf where MS_SecCode=@seccode and MS01_NoStaf=@stafno and MS26_StatusCuti='Proses' ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@seccode", seccode);
                cmd.Parameters.AddWithValue("@stafno", stafno);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = rdr["MS01_NoStaf"].ToString().Trim() + "-" + SQLMigs.GetNama(rdr["MS01_NoStaf"].ToString().Trim());
                    ret[1] = rdr["mula"].ToString().Trim() + " - " + rdr["tamat"].ToString().Trim();
                    ret[2] = rdr["MS26_BilHari"].ToString().Trim();
                    ret[3] = rdr["MS26_SebabCuti"].ToString().Trim();


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
            return ret;
        }
        public static IEnumerable<string> GetProCuti(string Num)
        {
            //Jenis
            //   string[] ret = new string[3];
            var rec = new List<string>();
            // ret[0] = "no";
            string jum = "0";
            //  string ret = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='DbStaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT KelayakanCuti,BilCuti,BakiCutiThnLepas from V_BUTIRCUTIMOBILE where MS01_NoStaf = @MS01_NoStaf ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@MS01_NoStaf ", Num);
                rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    DateTime startDate = new DateTime(DateTime.Now.Year, 1, 1); // Get start date of current year
                    DateTime endDate = DateTime.Now.Date; // Get current date with time part set to midnight

                    TimeSpan duration = endDate - startDate;
                    int totalDays = duration.Days + 1;
                    string kelayakancuti = rdr["KelayakanCuti"].ToString();
                    string bilcuti = rdr["BilCuti"].ToString();
                    string bakicuti = rdr["BakiCutiThnLepas"].ToString();


                    double hari = totalDays / 365.0;

                    double pro = (hari * int.Parse(kelayakancuti)) + int.Parse(bakicuti) - int.Parse(bilcuti);
                    decimal prorate = (decimal)Math.Round(pro);

                    rec.Add(prorate.ToString());
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

            return rec;



        }
    }
}