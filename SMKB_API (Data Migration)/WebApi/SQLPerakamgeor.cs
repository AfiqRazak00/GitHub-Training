using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Device.Location;

using System.Data;
namespace WebApi
{
    public class SQLPerakamgeor
    {

        public static IEnumerable<string> GetInfoKehadiranKursus(string userid, string app_Id, string jenis, string jenislogin)
        {
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[6];
            ret[0] = "notfound";
            try
            {
                //           CommandText = "SELECT   att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_user_rasmi where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime desc";

                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //         CommandText = "SELECT   att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_user_rasmi where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime desc";

                CommandText = "SELECT      TOP(1)  krs02_id, krs02_id_kursus, krs02_id_peserta, convert(varchar,krs02_tkh_wujud, 120)  as mydatein, krs02_jenis_transaksi FROM krs02_kehadiran_peserta    where  krs02_id_peserta = @userid  and cast(krs02_tkh_wujud as date) = cast(getdate() as date) and krs02_jenis_transaksi = @jenis order by krs02_id asc";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@jenis", jenis);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "found";
                    ret[1] = rdr["mydatein"].ToString();
                    IEnumerable<string> values = GetKursusDetail(rdr["krs02_id_kursus"].ToString());
                    var myListy = values.ToList();
                    ret[2] = myListy[0].ToString();
                    ret[3] = myListy[3].ToString();
                    // ret[4] = rdr["Lokasi"].ToString();
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
        public static IEnumerable<string> GetInfo(string userid, string app_Id, string jenis, string jenislogin)
        {
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[6];
            ret[0] = "notfound";
            //if (app_Id == "4") {
            var result = GetEventID(jenislogin);
            ret[4] = result.Item1;
            ret[5] = result.Item2;

           // }
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   att04_id, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_datetime, att04_date
                if (jenis == "masuk")
                {
                    CommandText = "SELECT   att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_user_rasmi where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime desc";

                }
                else
                {
                    CommandText = "SELECT   att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_user_rasmi where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime asc";

                }
             //   string CommandText = "SELECT  att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 13)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_user_rasmi where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime asc";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", ret[4]);
                cmd.Parameters.AddWithValue("@jenis", jenis);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "found";
                    ret[1] = rdr["mydatein"].ToString();
                    ret[2] = GetBangunanNamaBaru(rdr["att01_id"].ToString()); 
                    ret[3] = rdr["att04_status"].ToString();
                   // ret[4] = rdr["Lokasi"].ToString();
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
        public static Tuple<string, string> GetEventID(string typeuser)
        {
            DateTime mydate = DateTime.Now;
            string CommandText = "";
            string lokasi = "";
            string mybol = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                if (typeuser == "Staf")
                {
                     CommandText = "SELECT  Lokasi, att01_id, ap01_id FROM  att01_attd_system where att01_status='1' or att01_status='4' or att01_status='11' or att01_status='44'  and ( @mydate BETWEEN att01_start_checkin AND att01_end_checkout)  order by att01_id desc";
                }
                else
                {
                    CommandText = "SELECT  Lokasi, att01_id, ap01_id FROM  att01_attd_system where att01_status='4' or att01_status='3' or att01_status='44' or att01_status='33'  and ( @mydate BETWEEN att01_start_checkin AND att01_end_checkout)  order by att01_id desc";
                }
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile; //   @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@mydate", mydate);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["att01_id"].ToString();
                    lokasi = rdr["Lokasi"].ToString();

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

            return Tuple.Create(mybol,  lokasi);
        }
        public static IEnumerable<string> CheckOpenGateMasuk2(string userid, string app_Id, string lat1, string long1)
        {
            string clientAddress = "";
            int bgnid = 6;
            //  clientAddress = GetGeoCustomer(bgnid, lat1, long1); // HttpContext.Current.Request.UserHostAddress;
            var result = GetGeoCustomer(bgnid, lat1, long1);
            // Console.WriteLine(result.Item1);
            // Console.WriteLine(result.Item2);
            clientAddress = result.Item1;
            string CommandText = "";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            DateTime mydate = DateTime.Now;
            string[] ret = new string[6];
            ret[0] = "no";


            if (clientAddress.Trim() == "ok")
            {
                //insert new
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                //  att04_id, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_datetime, att04_date
                CommandText = "INSERT INTO  att04_attd_list_user_rasmi ( att01_id, att04_userid, att04_timepunch, att04_bangunan_id,masa) values (@app_id,@USERID,@MYDATE,@BGNID, @Time2)";
                con = new SqlConnection(ConnectionString);
                con.Open();

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                cmd.Parameters.AddWithValue("@BGNID", bgnid);
                cmd.Parameters.AddWithValue("@Time2", DateTime.Now.ToString("HH:mm"));

                rdr = cmd.ExecuteReader();
                ret[0] = "punchinok";
                ret[1] = mydate.ToString();
                ret[2] = result.Item2;
                ret[3] = result.Item3;
                ret[4] = "OK";
            }
            else
            {
                ret[0] = "outrange";
                ret[1] = "";
                ret[2] = result.Item2;
                ret[3] = result.Item3;
                ret[4] = "LUAR KAWASAN";
            }
            return ret;
        }




        public static Tuple<string, string, string> GetGeoCustomer(int idbangunan, string lat, string longtitud)
        {
            double mydist = 0;
            double db_lat = 0;
            double db_long = 0;
            double db_range = 0;
            string CustomerIP = "notok";
            string bangunan = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT   ap04_id, ap04_nama, ap04_nama_lokasi, app04_latitud, app04_longitud, app04_range FROM ap04_pejabat_latitud where ap04_id=@idb";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@idb", idbangunan);

                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    db_lat = Double.Parse(rdr["app04_latitud"].ToString());
                    db_long = Double.Parse(rdr["app04_longitud"].ToString());
                    db_range = Double.Parse(rdr["app04_range"].ToString());
                    bangunan = rdr["ap04_nama"].ToString();
                }
                if (db_long == 0)
                {
                    CustomerIP = "notok";
                }
                else
                {
                    mydist = GPS_Distance(lat, longtitud, db_lat, db_long);

                    if (mydist <= db_range)
                    {
                        CustomerIP = "ok";
                    }
                    else
                    {
                        CustomerIP = "notok";  //"n2otokz" + mydist.ToString() + "===" + db_range.ToString();
                    }

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
            return Tuple.Create(CustomerIP, mydist.ToString("0.00"), bangunan);
        }
        public static double GPS_Distancex(string latitude, string longitude, double Lat2, double Long2)
        {
            var sCoord = new GeoCoordinate(Convert.ToDouble(latitude), Convert.ToDouble(longitude));
            var eCoord = new GeoCoordinate(Lat2, Long2);

            return sCoord.GetDistanceTo(eCoord);
        }
        public static double GPS_Distance(string latitude, string longitude, double Lat2, double Long2)
        {
            double Lat1 = Convert.ToDouble(latitude);
            double Long1 = Convert.ToDouble(longitude);

            //  double Lat2 = 30.678;
            // double Long2 = 45.786;
            double circumference = 40000.0; // Earth's circumference at the equator in km
            double distance = 0.0;
            double latitude1Rad = DegreesToRadians(Lat1);
            double latititude2Rad = DegreesToRadians(Lat2);
            double longitude1Rad = DegreesToRadians(Long1);
            double longitude2Rad = DegreesToRadians(Long2);
            double logitudeDiff = Math.Abs(longitude1Rad - longitude2Rad);
            if (logitudeDiff > Math.PI)
            {
                logitudeDiff = 2.0 * Math.PI - logitudeDiff;
            }
            double angleCalculation =
                Math.Acos(
                  Math.Sin(latititude2Rad) * Math.Sin(latitude1Rad) +
                  Math.Cos(latititude2Rad) * Math.Cos(latitude1Rad) * Math.Cos(logitudeDiff));
            distance = circumference * angleCalculation / (2.0 * Math.PI);


            return distance;
        }
        public static double DegreesToRadians(double angle)
        {
            return Math.PI * angle / 180.0;
        }
        private static bool QrCodeValidB40(string user, string mycode)
        {
            bool mybol = false;
            string CommandText = "";
            String ConnectionString = SQLAuth.dbase_dbmobile;  
            CommandText = "SELECT   id, MK_NoMatrik, MK_Status, MK_TkhMasa, MK_IdKafe FROM MK01_Daftar where cast(MK_TkhMasa as date) = cast(getdate() as date) and MK_NoMatrik=@user  ";
            //and MK_IdKafe=@mycode
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@user", user);
                    cmd.Parameters.AddWithValue("@mycode", mycode);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                mybol = true;
                       
                            }
                        }

                        conn.Close();
                    }
                    catch (SqlException e)
                    {

                    }
                }
            }
            return mybol;
        }
        private static bool ValidCafeB40(string mycode)
        {
            bool mybol = false;
            string CommandText = "";
            String ConnectionString = SQLAuth.dbase_dbmobile;
            CommandText = "SELECT    MK_IdKafe FROM    MK_Kafe where  MK_IdKafe=@mycode";

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@mycode", mycode);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                mybol = true;

                            }
                        }

                        conn.Close();
                    }
                    catch (SqlException e)
                    {

                    }
                }
            }

            return mybol;
        }

        private static string ValidCafeB40_Name(string mycode)
        {
            string mybol = "";
            string CommandText = "";
            String ConnectionString = SQLAuth.dbase_dbmobile;
            CommandText = "SELECT    MK_IdKafe,  MK_Nama, MK_Lokasi, MK_Pengusaha FROM    MK_Kafe where  MK_IdKafe=@mycode";

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@mycode", mycode);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                mybol = reader["MK_Nama"].ToString() + "-" + reader["MK_Lokasi"].ToString() + "-" + reader["MK_Pengusaha"].ToString();

                            }
                        }

                        conn.Close();
                    }
                    catch (SqlException e)
                    {

                    }
                }
            }

            return mybol;
        }
        private static bool QrCodeValid(string qrcode, string app_Id, string jenis)
        {
            bool mybol = false;
            string CommandText = "";
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            if (jenis == "masuk")
            {
                CommandText = "select top 1  att01_id, ap01_id, att01_name, att01_status, att01_start_checkin, att01_end_checkin, att01_start_checkout, att01_end_checkout, att01_audience, att01_qr_in, att01_qr_out from att01_attd_system  where att01_id = @app_Id and att01_qr_in=@mydate";
            }
            else
            {
                CommandText = "select top 1  att01_id, ap01_id, att01_name, att01_status, att01_start_checkin, att01_end_checkin, att01_start_checkout, att01_end_checkout, att01_audience, att01_qr_in, att01_qr_out from att01_attd_system  where att01_id = @app_Id and att01_qr_out=@mydate";
            }
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@mydate", qrcode);
                    cmd.Parameters.AddWithValue("@app_Id", app_Id);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                mybol = true;
                                //Console.WriteLine(String.Format("{0}", reader["id"]));
                            }
                        }

                        conn.Close();
                        // other codes
                        // to fetch the record
                    }
                    catch (SqlException e)
                    {
                        // do something with 
                        // e.ToString()
                    }
                }
            }

            return mybol;
        }
        public static string GetSemEventHepa(string kod_Id)
        {
            string mybol = kod_Id;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT        P_Kod, P_Nama, P_Desc, P_Anjuran, P_Penganjur, P_Lokasi, P_Catatan, P_TkhDari, P_TkhHingga, P_Budget, P_Kuota, P_Testimoni, P_SesiSem, SMP20_NoStaf, TP_Kod, P_Wakil, SMP_KodPeringkat FROM SMP_08_Program  where P_Kod  = @idbangunan";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@idbangunan", kod_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["P_SesiSem"].ToString();

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

            return mybol;
        }
        public static string GetKodEventHepa(string kod_Id)
        {
            string mybol = kod_Id;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT hepa_code  FROM  att01_attd_system  where att01_id  = @idbangunan";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@idbangunan", kod_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["hepa_code"].ToString();

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

            return mybol;
        }
        private static bool StudenEventQRHEPA(string user, string kod_Id)
        {
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            bool mybol = false;
            if (
                    (user.ToString().Contains("d")) ||
                    (user.ToString().Contains("b")) ||
                    (user.ToString().Contains("bs")) ||
                    (user.ToString().Contains("m")) ||
                    (user.ToString().Contains("p"))
                    )
            {
                try
                {
                    DateTime mydate = DateTime.Now;
                    string mytime = DateTime.Now.ToShortTimeString();
                    string mydateshort = DateTime.Now.ToString("dd/MM/yyyy");

                    String ConnectionString = SQLAuth.dbase_dbstudent;
                    //CommandText = "insert into SMP_08_ProgPL (SMP01_NoMatrik, P_Kod, PP_Pencapaian, PP_StatusHadir,PP_SesiSem,  PP_TkhDaftar, PP_TkhHadir) values (@USERID,@app_id,@capai,@statush,@sem,@MYDATE,@MYDATE)";
                    //con = new SqlConnection(ConnectionString);
                    //con.Open();
                    //cmd = new SqlCommand(CommandText);
                    //cmd.Connection = con;
                    //cmd.Parameters.AddWithValue("@USERID", user);
                    //cmd.Parameters.AddWithValue("@MYDATE", mydate);
                    //cmd.Parameters.AddWithValue("@app_id", GetKodEventHepa(kod_Id));
                    //cmd.Parameters.AddWithValue("@capai", "PESERTA");
                    //cmd.Parameters.AddWithValue("@statush", "H");
                    CommandText = "insert into    TUAH03_AktProgram (SMP01_NoMatrik,TUAH02_IDProgram ,TUAH03_StaHadir ,TUAH03_KodSesiSem ,TUAH03_TkhDaftar ) values ( @USERID,@app_id, @statush,@sem, @MYDATE)";
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@USERID", user);
                    cmd.Parameters.AddWithValue("@app_id", GetKodEventHepa(kod_Id));
                    cmd.Parameters.AddWithValue("@statush", "H");
                    cmd.Parameters.AddWithValue("@sem", GetSemEventHepa(GetKodEventHepa(kod_Id)));
                    cmd.Parameters.AddWithValue("@MYDATE", mydate);
                    
                  //  cmd.Parameters.AddWithValue("@capai", "PESERTA");
                   
                   // cmd.Parameters.AddWithValue("@sem", GetSemEventHepa(GetKodEventHepa(kod_Id)));
                    rdr = cmd.ExecuteReader();
              
                
                
                
                }
                catch (SqlException e)
                {
                    // do something with 
                    // e.ToString()
                }


            }
            return mybol;


        }
        //GetStatusDisclaimer
        public static IEnumerable<string> GetStatusDisclaimer(string studentid)
        {

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[4];
            ret[0] = "no";

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbeqcas; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "select tuah from  live_user where att15=@studentid";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@studentid", studentid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if (rdr["tuah"].ToString().Trim() == "1")
                    {
                        ret[0] = "ok";
                    }
                    else
                    {

                    }
                   // ret[0] = "punchinok";
                  //  ret[1] = Convert.ToDateTime(rdr["MK_TkhMasa"]).ToString("dd/MM/yyyy");
                   // ret[2] = Convert.ToDateTime(rdr["MK_TkhMasa"]).ToString("hh:mm tt");
                   // ret[3] = rdr["phonenumber"].ToString() + "-" + rdr["MK_Lokasi"].ToString() + "-" + rdr["MK_Pengusaha"].ToString();
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
        //public static IEnumerable<string> UpdateResetPassword(string studentid, string mylang)
        //{

        //    SqlDataReader rdr = null;
        //    SqlConnection con = null;
        //    SqlCommand cmd = null;
        //    string[] ret = new string[4];
        //    ret[0] = "no";

        //    try
        //    {
        //        // Open connection to the database
        //        String ConnectionString = SQLAuth.dbase_dbmobile; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
        //        con = new SqlConnection(ConnectionString);
        //        con.Open();

        //        string CommandText = "insert into AspNetResetEmail ( user_id, email, mypassword, mydate, mymodul, mytype, status, note ) values ()";
        //        cmd = new SqlCommand(CommandText);
        //        cmd.Connection = con;
        //        cmd.Parameters.AddWithValue("@userid", studentid);
        //        cmd.Parameters.AddWithValue("@mypass", studentid);
        //        cmd.Parameters.AddWithValue("@myemail", studentid);
        //        cmd.Parameters.AddWithValue("@mydate", studentid);
        //        cmd.Parameters.AddWithValue("@mymodul", studentid);
        //        cmd.Parameters.AddWithValue("@mytype", studentid);
        //        cmd.Parameters.AddWithValue("@status", studentid);
        //        cmd.Parameters.AddWithValue("@note", studentid);
        //        int mybol = cmd.ExecuteNonQuery();
        //        ret[0] = "ok";


        //    }
        //    catch (Exception)
        //    {

        //    }
        //    finally
        //    {
        //        if (rdr != null)
        //            rdr.Close();

        //        if (con.State == ConnectionState.Open)
        //            con.Close();
        //    }

        //    return ret;
        //}
        public static IEnumerable<string> UpdateStatusDisclaimer(string studentid)
        {

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[4];
            ret[0] = "no";

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbeqcas; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "update live_user set tuah='1'  where att15=@studentid";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@studentid", studentid);
                int mybol = cmd.ExecuteNonQuery();
                ret[0] = "ok";


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
        public static IEnumerable<string> GetDataQRB40(string studentid)
        {

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[4];
            ret[0] = "no";

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT  a.MK_NoMatrik, a.MK_Status, a.MK_TkhMasa, a.MK_IdKafe, b.MK_Nama, b.MK_Lokasi, b.MK_Pengusaha from    MK01_Daftar as a, MK_Kafe as b where a.MK_IdKafe=b.MK_IdKafe and a.MK_NoMatrik=@studentid and  cast(a.MK_TkhMasa as date) = cast(getdate() as date) ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@studentid", studentid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "punchinok";
                    ret[1] =  Convert.ToDateTime(rdr["MK_TkhMasa"]).ToString("dd/MM/yyyy");
                    ret[2] =  Convert.ToDateTime(rdr["MK_TkhMasa"]).ToString("hh:mm tt");
                    ret[3] =  rdr["MK_Nama"].ToString() + "-" + rdr["MK_Lokasi"].ToString() + "-" + rdr["MK_Pengusaha"].ToString();
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
        public static IEnumerable<string> CheckOpenGateMasukQRB40(string userid, string mycode)
        {
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[6];
            ret[0] = "no";

            if (QrCodeValidB40(userid, mycode) == true)
            {
                // error telah diguna pada hari ini
                ret[0] = "Kod QR Tuah Care Food@Campus telah digunakan pada hari ini";
                ret[1] = "Tuah Care Food@Campus QR code has been used today";

            }
            else if (ValidCafeB40(mycode) == false)
            {
                // error invalid cafe qr kode
                ret[0] = "QR Kod Kafe yang digunakan tidak sah";
                ret[0] = "Invalid QR Code  Cafe";

            }
            else { 
                DateTime mydate = DateTime.Now;
                string mytime = DateTime.Now.ToShortTimeString();
                string mydateshort = DateTime.Now.ToString("dd/MM/yyyy");

                String ConnectionString = SQLAuth.dbase_dbmobile;
                CommandText = "INSERT INTO   MK01_Daftar ( MK_NoMatrik, MK_Status, MK_TkhMasa, MK_IdKafe, MK_alarm ) values (@USERID, '1', @MYDATE, @mycode, @myalarm)";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
                cmd.Parameters.AddWithValue("@mycode", mycode);
                cmd.Parameters.AddWithValue("@Tarikh", mydate.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@Time2", mydate.ToString("HH:mm:ss"));
                cmd.Parameters.AddWithValue("@myalarm", "baru");
                rdr = cmd.ExecuteReader();
                ret[0] = "punchinok";
                ret[1] = mydate.ToString("yyyy-MM-dd");
                ret[2] = mydate.ToString("hh:mm tt");
                ret[3] = ValidCafeB40_Name(mycode);


            }
           // else
           // {
            //    ret[0] = "Menu Keluarga UTeM telah digunakan";
           // }

            return ret;
        }
        private static bool QrKursusCodeValid(string qrcode)
        {
            bool mybol = false;
            string CommandText = "";
            String ConnectionString = SQLAuth.dbase_dbmobile;
            CommandText = "SELECT      krs01_id_kursus, krs01_nama_kursus, krs01_tkh_mula, krs01_tkh_tamat, krs01_tempat, krs01_kod_qr, krs01_owner_kod FROM krs01_kursus where krs01_kod_qr = @kod_qr";
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@kod_qr", qrcode);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                mybol = true;
                            }
                        }

                        conn.Close();
                        // other codes
                        // to fetch the record
                    }
                    catch (SqlException e)
                    {
                        // do something with 
                        // e.ToString()
                    }
                }
            }

            return mybol;
        }
        public static IEnumerable<string> CheckGateMasukKursusQR(string userid, string app_Id, string qrcode, string jenisk, string jenislogin)
        {
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[6];
            ret[0] = "no";

            if (QrKursusCodeValid(qrcode) == true)
            {
                string[] namesArray = qrcode.Split('-');
                DateTime mydate = DateTime.Now;
                string mytime = DateTime.Now.ToShortTimeString();
                string mydateshort = DateTime.Now.ToString("dd/MM/yyyy");

                String ConnectionString = SQLAuth.dbase_dbmobile;
                CommandText = "INSERT INTO  krs02_kehadiran_peserta ( krs02_id_kursus, krs02_id_peserta,  krs02_jenis_transaksi, krs02_tkh_wujud, krs02_nama ) values (@id_kursus, @id_peserta,  @jenis_transaksi, @tkh_wujud, @nama)";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@id_peserta", userid);
                cmd.Parameters.AddWithValue("@nama", SQLAuth.finddataok(userid, "nama", ""));
                cmd.Parameters.AddWithValue("@id_kursus", namesArray[0]);
                cmd.Parameters.AddWithValue("@tkh_wujud", mydate);
                cmd.Parameters.AddWithValue("@jenis_transaksi", "QR");

                rdr = cmd.ExecuteReader();
                IEnumerable<string> values = GetKursusDetail(namesArray[0]);
                var myListy = values.ToList();
                ret[0] = "punchinok";
                //  mymasuk.Text = Mylanguage.Bahasa("Waktu Masuk") + " :" + Convert.ToDateTime(myList[1]).ToString("hh:mm:ss tt");

                ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss"); //mydate.ToString();
                ret[2] = myListy[0].ToString();
                ret[3] = myListy[3].ToString();
                ret[4] = "OK";

            }
            else
            {
                ret[0] = "QR Code tidak sah";
            }
            return ret;
        }

        public static IEnumerable<string> GetKursusDetail(string userid)
        {
            //  string[,] twoDimensional;
            //  twoDimensional = new string[1, 4];
            string[] ret = new string[2];
            ret[0] = "no";
            string vv = "";
            List<string> myList = new List<string>();

            //   string[] twoDimensionalx;
            //   twoDimensionalx = new string[20];
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();
                //  string CommandText = "SELECT        LT03_Kalendar.LT03_KodLthn, MS24_Latihan.MS24_NamaLatihan,LT03_Kalendar.LT03_TkhMula, LT03_Kalendar.LT03_TkhTamat, LT03_Kalendar.LT03_Tempat,   LT03_Kalendar.LT03_Tahun, LT03_Kalendar.LT03_KodBdgKerja, LT03_Kalendar.LT03_KodLatihan,                    LT03_Kalendar.LT03_Penceramah, LT03_Kalendar.LT03_Tentatif, LT03_Kalendar.LT03_BilPeserta, LT03_Kalendar.LT03_StLatihan, LT03_Kalendar.LT03_KodKategori, LT03_Kalendar.LT03_Penganjur,                    LT03_Kalendar.LT03_AlmtPenganjur, LT03_Kalendar.LT03_Info, LT03_Kalendar.LT03_TkhMulaCeramah, LT03_Kalendar.LT03_TkhTamatCeramah, LT03_Kalendar.LT03_Anjuran, LT03_Kalendar.LT03_JenAnjuran,                         LT03_Kalendar.LT03_KodKomponen, LT03_Kalendar.LT03_KodKompetensi, LT03_Kalendar.LT03_Tahap, LT03_Kalendar.LT03_KodKaedah FROM            LT03_Kalendar INNER JOIN                        MS24_Latihan ON LT03_Kalendar.LT03_KodLthn = MS24_Latihan.MS24_KodLthn WHERE     (LT03_Kalendar.LT03_KodBdgKerja = N'2') and (LT03_Kalendar.LT03_KodLthn = @userid) ";
                string CommandText = "SELECT      krs01_id_kursus, krs01_nama_kursus, krs01_tkh_mula, krs01_tkh_tamat, krs01_tempat, krs01_kod_qr, krs01_owner_kod FROM krs01_kursus where  krs01_id_kursus = @userid";


                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid.Replace("-", "/"));

                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    //  myList.Add(rdr["MS24_NamaLatihan"].ToString());
                    //  myList.Add(rdr["LT03_TkhMula"].ToString());
                    //  myList.Add(rdr["LT03_TkhTamat"].ToString());
                    //  myList.Add(rdr["LT03_Tempat"].ToString());

                    myList.Add(rdr["krs01_nama_kursus"].ToString());
                    myList.Add(rdr["krs01_tkh_mula"].ToString());
                    myList.Add(rdr["krs01_tkh_tamat"].ToString());
                    myList.Add(rdr["krs01_tempat"].ToString());


                }
                return myList;
            }
            catch (Exception)
            {
                return ret;
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
                // return twoDimensionalx;
            }

            //  twoDimensionalx[0] = count.;

        }
        public static IEnumerable<string> CheckOpenGateMasukQR(string userid, string app_Id, string qrcode, string jenisk, string jenislogin)
        {
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[6];
            ret[0] = "no";

            if (QrCodeValid(qrcode, app_Id, jenisk) == true)
            {
                DateTime mydate = DateTime.Now;
                string mytime = DateTime.Now.ToShortTimeString();
                string mydateshort = DateTime.Now.ToString("dd/MM/yyyy");

                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                CommandText = "INSERT INTO  att04_attd_list_user_rasmi ( att04_status, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_jenis_transaksi,Lokasi, masa ) values (@status, @app_id,@USERID,@MYDATE,@BGNID,@jenistransaksi,@NAMA, @Time2)";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                cmd.Parameters.AddWithValue("@BGNID", "");
                cmd.Parameters.AddWithValue("@NAMA", "QRCode");
                cmd.Parameters.AddWithValue("@jenistransaksi", jenisk);
                cmd.Parameters.AddWithValue("@status", "OK");
                cmd.Parameters.AddWithValue("@Time2", DateTime.Now.ToString("HH:mm"));
                rdr = cmd.ExecuteReader();
                ret[0] = "punchinok";
                ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss"); //mydate.ToString();
                ret[2] = "";
                ret[3] = "";
                ret[4] = "OK";
                bool bb = StudenEventQRHEPA(userid, app_Id);
            }
            else
            {
                ret[0] = "QR Code tidak sah";
            }
          
            return ret;
        }
        public static IEnumerable<string> CheckOpenGateMasuk(string userid, string app_Id, string lat1, string long1, string jenisk, string jenislogin)
        {
            string status2 = "";
            var result = GetGeoCustomer2b(userid, lat1, long1, app_Id);
            string myresult = "";
            string status = result.Item1;
            string dist = result.Item2;
            string idbangunan = result.Item3;
            string namabangunan = result.Item4;
            string mynamastaf = result.Item5;
            string jenistransaksi = jenisk;
            string Wiegand = GetWeghang(userid);
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

 


            DateTime mydate = DateTime.Now;
            string mytime = DateTime.Now.ToShortTimeString();
            string mydateshort = DateTime.Now.ToString("dd/MM/yyyy");
            string[] ret = new string[6];
            ret[0] = "no";
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
      
            if (status.Trim() == "ok")
            {
                status2 = "OK";
                CommandText = "INSERT INTO  att04_attd_list_user_rasmi ( att04_status, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_jenis_transaksi,Lokasi, masa ) values (@status, @app_id,@USERID,@MYDATE,@BGNID,@jenistransaksi,@NAMA, @Time2)";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                cmd.Parameters.AddWithValue("@BGNID", idbangunan);
                cmd.Parameters.AddWithValue("@NAMA", namabangunan);
                cmd.Parameters.AddWithValue("@jenistransaksi", jenistransaksi);
                cmd.Parameters.AddWithValue("@status", status2);
                cmd.Parameters.AddWithValue("@Time2", DateTime.Now.ToString("HH:mm"));
                rdr = cmd.ExecuteReader();

                //CommandText = "INSERT INTO  att_VTranMindRasmi (ID, TkhMasa, TrController, TrName, Wiegand) values (@USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand)";

                //con = new SqlConnection(ConnectionString);
                //con.Open();
                //cmd = new SqlCommand(CommandText);
                //cmd.Connection = con;
                //cmd.Parameters.AddWithValue("@USERID", userid);
                //cmd.Parameters.AddWithValue("@MYDATE", mydate);
                //cmd.Parameters.AddWithValue("@BGNID", namabangunan);
                //cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                //cmd.Parameters.AddWithValue("@Wiegand", Wiegand);
                //rdr = cmd.ExecuteReader();

                if (myresult == "")
                {
                    ret[0] = "punchinok";
                    ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss"); //mydate.ToString();
                    ret[2] = dist;
                    ret[3] = namabangunan;
                    ret[4] = "OK";
                    bool bb = StudenEventQRHEPA(userid, app_Id);
                }
                else
                {
                    ret[0] = myresult;
                }
            }
            else
            {

                    ret[2] = dist;
                    ret[0] = "outrange";
                    ret[1] = "-";
                    ret[3] = "Anda berada " + dist + "meter dari lokasi " + namabangunan; //"LUAR KAWASAN";
                ret[4] = "LUAR KAWASAN";
              
   

            }
            return ret;
        }

      


        public static IEnumerable<string> CheckTimeOpenGate(string app_Id, string jenis)
        {
            string CommandText = "";
            DateTime mydate = DateTime.Now;
            string[] ret = new string[4];
          //  app_Id = "5";
            ret[0] = "no";
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            if (jenis == "masuk")
            {
                CommandText = "select top 1  att01_id, ap01_id, att01_name, att01_status, att01_start_checkin, att01_end_checkin, att01_start_checkout, att01_end_checkout, att01_audience, att01_qr_in, att01_qr_out from att01_attd_system  where att01_id = @app_id and @mydate BETWEEN att01_start_checkin AND att01_end_checkin";
            }
            else
            {
                CommandText = "select top 1  att01_id, ap01_id, att01_name, att01_status, att01_start_checkin, att01_end_checkin, att01_start_checkout, att01_end_checkout, att01_audience, att01_qr_in, att01_qr_out from att01_attd_system  where att01_id = @app_id and  @mydate BETWEEN att01_start_checkout AND att01_end_checkout";
            }
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@mydate", mydate);
                    cmd.Parameters.AddWithValue("@app_id", app_Id);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                ret[0] = "yes";
                                if (jenis == "masuk")
                                {
                                    ret[1] = reader["att01_start_checkin"].ToString();
                                    ret[2] = reader["att01_end_checkin"].ToString();
                                    ret[3] = reader["att01_qr_in"].ToString();
                                    //     ret[2] = reader["att01_end_checkin"].ToString();
                                }
                                else
                                {
                                    ret[1] = reader["att01_start_checkout"].ToString();
                                    ret[2] = reader["att01_end_checkout"].ToString();
                                    ret[3] = reader["att01_qr_out"].ToString();
                                    //     ret[2] = reader["att01_end_checkout"].ToString();
                                }
                                //Console.WriteLine(String.Format("{0}", reader["id"]));
                            }
                        }

                        conn.Close();
                        // other codes
                        // to fetch the record
                    }
                    catch (SqlException e)
                    {
                        // do something with 
                        // e.ToString()
                    }
                }
            }
            if (ret[0] == "no")
            {
                CommandText = "select top 1  att01_id, ap01_id, att01_name, att01_status, att01_start_checkin, att01_end_checkin, att01_start_checkout, att01_end_checkout, att01_audience, att01_qr_in, att01_qr_out from att01_attd_system  where att01_id = @app_idx ";

                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.Connection = conn;
                        cmd.CommandText = CommandText;
                        cmd.Parameters.AddWithValue("@app_idx", app_Id);
                        //   cmd.Parameters.AddWithValue("@mydate", mydate);
                        try
                        {
                            conn.Open();
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    // ret[0] = "yes";
                                    if (jenis == "masuk")
                                    {
                                        ret[1] = reader["att01_start_checkin"].ToString();
                                        ret[2] = reader["att01_end_checkin"].ToString();
                                    }
                                    else
                                    {
                                        ret[1] = reader["att01_start_checkout"].ToString();
                                        ret[2] = reader["att01_end_checkout"].ToString();
                                    }
                                    //Console.WriteLine(String.Format("{0}", reader["id"]));
                                }
                            }

                            conn.Close();
                            // other codes
                            // to fetch the record
                        }
                        catch (SqlException e)
                        {
                            // do something with 
                            // e.ToString()
                        }
                    }
                }

            }
            return ret;
        }



        //public static IEnumerable<string> HantarProgramRasmiPelajar(string xSMP01_NoMatrik, string xP_Kod, string xPP_Pencapaian, string xPP_TkhDaftar, string xPP_StatusHadir, string xPP_SesiSem, string xPP_StaPenyertaan, string xPP_TkhHadir)
        //{
        //    string[] ret = new string[1];
        //    ret[0] = "no";
        //    try
        //    {
        //        using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbstudent))
        //        {
        //            using (SqlCommand cmd = new SqlCommand())
        //            {
        //                //SELECT        SMP01_NoMatrik, P_Kod, PP_Pencapaian, PP_TkhDaftar, PP_StatusHadir, PP_TkhHadir, PP_SesiSem, PP_StaPenyertaan
        //               // FROM SMP_08_ProgPL
        //                cmd.CommandText = @"INSERT INTO  SMP_08_ProgPL ( SMP01_NoMatrik, P_Kod, PP_Pencapaian, PP_TkhDaftar, PP_TkhHadir, PP_StatusHadir, PP_SesiSem, PP_StaPenyertaan) values ( @xSMP01_NoMatrik, @xP_Kod, @xPP_Pencapaian, @xPP_TkhDaftar, @xPP_TkhHadir, @xPP_StatusHadir, @xPP_SesiSem, @xPP_StaPenyertaan)";
        //                cmd.Connection = sqlConn;
        //                cmd.Parameters.AddWithValue("@xSMP01_NoMatrik", xSMP01_NoMatrik);
        //                cmd.Parameters.AddWithValue("@xP_Kod", xP_Kod);
        //                cmd.Parameters.AddWithValue("@xPP_Pencapaian", xPP_Pencapaian);
        //                cmd.Parameters.AddWithValue("@xPP_TkhDaftar", xPP_TkhDaftar);
        //                cmd.Parameters.AddWithValue("@xPP_StatusHadir", xPP_StatusHadir);
        //                cmd.Parameters.AddWithValue("@xPP_SesiSem", xPP_SesiSem);
        //                cmd.Parameters.AddWithValue("@xPP_StaPenyertaan", xPP_StaPenyertaan);
        //                cmd.Parameters.AddWithValue("@xPP_TkhHadir", xPP_TkhHadir);


        //                try
        //                {
        //                    sqlConn.Open();
        //                    cmd.ExecuteNonQuery();
        //                    ret[0] = "ok";
        //                }
        //                catch (SqlException e)
        //                {
        //                    ret[0] = "A " + e.Message.ToString();
        //                }

        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        ret[0] = "B " + ex.Message.ToString();
        //    }

        //    return ret;
        //}






        public static Tuple<string, string, string, string, string> GetGeoCustomer2test(string nostaf, string lat, string longtitud)
        {
            string Status = "";

            //  var result = GetInfoBgnStaff(nostaf);
            string idbngnan = "6";
            string namabangunan = "Pusat Komputer";
            double mylat = 233;
            double mylong = 455;
            double myrange = 344;
            string mynamastaf = "";
            double mydist = 200;
            // if (mydist <= myrange)
            // {
            Status = "ok";
            // }
            // else
            // {
            //    Status = "notok";  //"n2otokz" + mydist.ToString() + "===" + db_range.ToString();
            // }
            return Tuple.Create(Status, mydist.ToString("0.00"), idbngnan, namabangunan, mynamastaf);
        }
        public static Tuple<string, string, string, string, string> GetGeoCustomer2b(string nostaf, string lat, string longtitud, string app_Id)
        {
            string Status = "";

            var result = GetInfoBgnStaffb(app_Id);
            string idbngnan = result.Item1;
            string namabangunan = result.Item2;
            double mylat = Convert.ToDouble(result.Item3);
            double mylong = Convert.ToDouble(result.Item4);
            double myrange = Convert.ToDouble(result.Item5);
            string mynamastaf = result.Item6;
            double mydist = (GPS_Distance(lat, longtitud, mylat, mylong) * 1000);
            // double mydist = (GPS_Distance(lat, longtitud, mylat, mylong) );
            if (mydist <= myrange)
            {
                Status = "ok";
            }
            else
            {
                Status = "notok";  //"n2otokz" + mydist.ToString() + "===" + db_range.ToString();
            }
            return Tuple.Create(Status, mydist.ToString("0.00"), idbngnan, namabangunan, mynamastaf);
        }
        public static Tuple<string, string, string, string, string, string> GetInfoBgnStaffb(string app_Id)
        {
            string mynamastaf = "";
            double mylat = 0;
            double mylong = 0;
            double myrange = 0;
            double myidbangunan = 99;
            string namabangunan = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT   att01_id, ap01_id,  Latitud, Longitud, Range, Lokasi FROM            att01_attd_system where att01_id = @app_Id";
              //  string CommandText = "SELECT   c.MS01_Nama, b.Latitud, b.Longitud, b.Range, b.NamaBangunan, a.MS21_NoStaf, a.MS21_JenHdr, a.MS21_StaHdr, a.MS21_IDBangunan, a.MS21_TkhKemaskini FROM MS21_PerakamWaktu as a, PW_Bangunan as b , MS01_Peribadi as c where a.MS21_NoStaf = c.MS01_NoStaf  and b.IDBangunan = a.MS21_IDBangunan  and a.MS21_NoStaf=@nostaf";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@app_Id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myidbangunan =  0;
                    namabangunan =  rdr["Lokasi"].ToString();
                    mylat =  Double.Parse(rdr["Latitud"].ToString());
                    mylong =  Double.Parse(rdr["Longitud"].ToString());
                    myrange =  Double.Parse(rdr["Range"].ToString());
                   // mynamastaf = rdr["MS01_Nama"].ToString(); // "khalid";
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
            return Tuple.Create(myidbangunan.ToString(), namabangunan, mylat.ToString(), mylong.ToString(), myrange.ToString(), mynamastaf);
        }

        public static Tuple<string, string> LoopBangunan(string idbangunan, string lat, string longtitud)
        {

            double myidbangunan = 99;
            string namabangunan = "";
            double mylat = 0;
            double mylong = 0;
            double myrange = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT  Latitud, Longitud, Range,  NamaBangunan, IDBangunan FROM  PW_Bangunan  where IDBangunan  <> @idbangunan";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@idbangunan", idbangunan);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    mylat = Double.Parse(rdr["Latitud"].ToString());
                    mylong = Double.Parse(rdr["Longitud"].ToString());
                    myrange = Double.Parse(rdr["Range"].ToString());
                    double mydist = (GPS_Distance(lat, longtitud, mylat, mylong) * 1000);
                    // double mydist = (GPS_Distance(lat, longtitud, mylat, mylong) );
                    if (mydist <= myrange)
                    {
                        myidbangunan = Double.Parse(rdr["IDBangunan"].ToString());
                        namabangunan = rdr["NamaBangunan"].ToString();
                        break;
                    }
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
            return Tuple.Create(myidbangunan.ToString(), namabangunan);
        }
        public static string GetBangunanNamaBaru(string idbangunan)
        {
            string mybol = "TIADA DALAM SISTEM";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT Lokasi  FROM  att01_attd_system  where att01_id  = @idbangunan";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@idbangunan", idbangunan);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["Lokasi"].ToString();

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

            return mybol;
        }
        public static string GetBangunanNama(string idbangunan)
        {
            string mybol = "TIADA DALAM SISTEM";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT  Latitud, Longitud, Range,  NamaBangunan, IDBangunan FROM  PW_Bangunan  where IDBangunan  = @idbangunan";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@idbangunan", idbangunan);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["NamaBangunan"].ToString();

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

            return mybol;
        }
        public static string GetWeghang(string nostaf)
        {
            string mybol = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT        CAST(FLOOR(CAST(MS01_CardSN AS bigint) / 65536) AS varchar) + ':' + CAST(MS01_CardSN - FLOOR(CAST(MS01_CardSN AS bigint) / 65536) * 65536 AS varchar) AS Wiegand FROM MS01_Peribadi WHERE(MS01_NoStaf = @nostaf)";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nostaf", nostaf);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["Wiegand"].ToString();

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

            return mybol;
        }
        public static string WriteDatatoDBStaf(string userid, DateTime mydate, string idbangunan, string mynamastaf, string Wiegand, string mycon)
        {
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(mycon))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"INSERT INTO  PW14_TranMind (PW14_IdBaru, PW14_IdAsal, PW14_KodTraksaksi,  PW14_SiteCode, PW14_CardCode, PW14_NoKad, PW14_TkhMasa, PW14_KodPengimbas, PW14_Nama, PW14_Wiegand, PW14_TkhSumber, PW14_Sumber, PW14_Pengimbas, PW14_Transaksi) values (@idbaru, @idasal, @kodtransaksi, @sitecode, @cardcode, @USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand, @MYDATE, @sumber, @pengimbas, @transaksi)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@MYDATE", mydate);
                        cmd.Parameters.AddWithValue("@BGNID", idbangunan);
                        cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                        cmd.Parameters.AddWithValue("@Wiegand", Wiegand);
                        cmd.Parameters.AddWithValue("@pengimbas", "-");
                        cmd.Parameters.AddWithValue("@transaksi", "Normal access by card only");
                        cmd.Parameters.AddWithValue("@sumber", "GL");
                        cmd.Parameters.AddWithValue("@idasal", "0");
                        cmd.Parameters.AddWithValue("@kodtransaksi", "0");
                        cmd.Parameters.AddWithValue("@sitecode", "52456");
                        cmd.Parameters.AddWithValue("@cardcode", "55167");
                        cmd.Parameters.AddWithValue("@idbaru", "0");


                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                        }


                        //sqlConn.Open();

                        //using (SqlDataReader reader = cmd.ExecuteReader())
                        //{
                        //    if (reader.Read())
                        //    {

                        //    }
                        //    else
                        //    {
                        //        myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                        //    }
                        //}
                    }
                }
            }
            catch (Exception ex)
            {
                myStr = "Capaian ke database bermasalah. Sila cuba lagi";
            }
            if (myStr == "") { } else { myStr = WriteDatatoDBStaf_2round(userid, mydate, idbangunan, mynamastaf, Wiegand, mycon); }
            return myStr;
        }

        public static string WriteDatatoDBStaf_2round(string userid, DateTime mydate, string idbangunan, string mynamastaf, string Wiegand, string mycon)
        {
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(mycon))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"INSERT INTO  PW14_TranMind (PW14_IdBaru, PW14_IdAsal, PW14_KodTraksaksi,  PW14_SiteCode, PW14_CardCode, PW14_NoKad, PW14_TkhMasa, PW14_KodPengimbas, PW14_Nama, PW14_Wiegand, PW14_TkhSumber, PW14_Sumber, PW14_Pengimbas, PW14_Transaksi) values (@idbaru, @idasal, @kodtransaksi, @sitecode, @cardcode, @USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand, @MYDATE, @sumber, @pengimbas, @transaksi)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@MYDATE", mydate);
                        cmd.Parameters.AddWithValue("@BGNID", idbangunan);
                        cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                        cmd.Parameters.AddWithValue("@Wiegand", Wiegand);
                        cmd.Parameters.AddWithValue("@pengimbas", "-");
                        cmd.Parameters.AddWithValue("@transaksi", "Normal access by card only");
                        cmd.Parameters.AddWithValue("@sumber", "GL");
                        cmd.Parameters.AddWithValue("@idasal", "0");
                        cmd.Parameters.AddWithValue("@kodtransaksi", "0");
                        cmd.Parameters.AddWithValue("@sitecode", "52456");
                        cmd.Parameters.AddWithValue("@cardcode", "55167");
                        cmd.Parameters.AddWithValue("@idbaru", "0");


                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                        }


                        //sqlConn.Open();

                        //using (SqlDataReader reader = cmd.ExecuteReader())
                        //{
                        //    if (reader.Read())
                        //    {

                        //    }
                        //    else
                        //    {
                        //        myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                        //    }
                        //}
                    }
                }
            }
            catch (Exception ex)
            {
                myStr = "Capaian ke database bermasalah. Sila cuba lagi";
            }
            return myStr;
        }
        public static string GetNamaStaf(string nostaf)
        {
            string mybol = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT   MS01_Nama FROM  MS01_Peribadi  where .MS01_NoStaf =@nostaf";

               // string CommandText = "SELECT        CAST(FLOOR(CAST(MS01_CardSN AS bigint) / 65536) AS varchar) + ':' + CAST(MS01_CardSN - FLOOR(CAST(MS01_CardSN AS bigint) / 65536) * 65536 AS varchar) AS Wiegand FROM MS01_Peribadi WHERE(MS01_NoStaf = @nostaf)";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nostaf", nostaf);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["MS01_Nama"].ToString();

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

            return mybol;
        }
    }
}