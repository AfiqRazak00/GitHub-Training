using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Device.Location;
using System.IO;
using System.Data;

namespace WebApi
{
    public class SQLPerakamgeo
    {
        public static IEnumerable<string> GetInfo(string userid, string app_Id, string jenis)
        {
            DateTime myDateNew;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[5];
            ret[0] = "notfound";
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
             //   att04_id, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_datetime, att04_date

                string CommandText = "SELECT  att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_user where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime asc";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                cmd.Parameters.AddWithValue("@jenis", jenis);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "found";
                  //  myDateNew = Convert.ToDateTime(rdr["mydatein"].ToString());

                   ret[1] = rdr["mydatein"].ToString();
                 //   ret[1] = myDateNew.ToString("MM/dd/yyyy HH:mm:ss");
                    ret[2] = GetBangunanNama(rdr["att04_bangunan_id"].ToString()); //  rdr["att04_bangunan_id"].ToString();
                    ret[3] = rdr["att04_status"].ToString();
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
       
        public static IEnumerable<string> GetInfoCam(string userid, string app_Id, string jenis)
        {
            DateTime myDateNew;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[5];
            ret[0] = "notfound";
            try
            {
                // Open connection to the database
                String ConnectionString =  SQLAuth.dbase_developer;
                con = new SqlConnection(ConnectionString);
                con.Open();
            
               // string CommandText = "SELECT  att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_user where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime asc";
                string CommandText = "SELECT    ivts02_id, ivts02_platid, ivts02_lokasi, ivts02_jenis, convert(varchar,ivts02_Tarikh, 120)  as mydatein , ivts02_gambar, ivts02_jenis_gambar FROM ivts02_Aktiviti_Kenderaan   where ivts02_nostaf = @userid  and cast(ivts02_Tarikh as date) = cast(getdate() as date) and ivts02_jenis = @jenis order by ivts02_Tarikh asc";



                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                cmd.Parameters.AddWithValue("@jenis", jenis.ToLower());
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "found";
                    //  myDateNew = Convert.ToDateTime(rdr["mydatein"].ToString());

                    ret[1] = rdr["mydatein"].ToString();
                    //   ret[1] = myDateNew.ToString("MM/dd/yyyy HH:mm:ss");
                    ret[2] = "iVTS " + rdr["ivts02_lokasi"].ToString(); // rdr["att04_bangunan_id"].ToString();
                    ret[3] = "OK";
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

        public static IEnumerable<string> GetInfoBaru(string userid, string app_Id, string jenis, string masa)
        {
            DateTime myDateNew;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[6];
            ret[0] = "punchinok";
            ret[2] = "";
            ret[5] = "";
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   att04_id, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_datetime, att04_date

                string CommandText = "SELECT  att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_user where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime asc";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                cmd.Parameters.AddWithValue("@jenis", jenis);
                rdr = cmd.ExecuteReader();
                string mfound = "0";
                while (rdr.Read())
                {
                    
                    //  myDateNew = Convert.ToDateTime(rdr["mydatein"].ToString());
                    if (masa == rdr["mydatein"].ToString())
                    {
                        mfound = "1";
                        ret[1] = rdr["mydatein"].ToString();
                        ret[3] = GetBangunanNama(rdr["att04_bangunan_id"].ToString()); //  rdr["att04_bangunan_id"].ToString();
                        ret[4] = rdr["att04_status"].ToString();
                    }
                    else
                    {

                    }
                }
                if  (mfound == "1") { ret[0] = "punchinok";

                
                } else { ret[0] = "CAPAIAN KE PANGKALAN DATA TIDAK BERJAYA. SILA TEKAN BUTANG KEMBALI DAN CUBA MEREKOD KEHADIRAN ANDA SEMULA. SILA RUJUK KEPADA FAQ UNTUK MAKLUMAT LANJUT"; }
            }
            catch (Exception)
            {
                ret[0] = "CAPAIAN KE PANGKALAN DATA TIDAK BERJAYA. SILA TEKAN BUTANG KEMBALI DAN CUBA MEREKOD KEHADIRAN ANDA SEMULA. SILA RUJUK KEPADA FAQ UNTUK MAKLUMAT LANJUT";
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
                    CommandText = "INSERT INTO  att04_attd_list_user ( att01_id, att04_userid, att04_timepunch, att04_bangunan_id) values (@app_id,@USERID,@MYDATE,@BGNID)";
                    con = new SqlConnection(ConnectionString);
                    con.Open();

                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@USERID", userid);
                    cmd.Parameters.AddWithValue("@MYDATE", mydate);
                    cmd.Parameters.AddWithValue("@app_id", app_Id);
                    cmd.Parameters.AddWithValue("@BGNID", bgnid);

                    rdr = cmd.ExecuteReader();
                    ret[0] = "punchinok";
                    ret[1] = mydate.ToString();
                    ret[2] = result.Item2;
                    ret[3] = result.Item3;
                    ret[4] = "OK";
            }
            else
            {
                ret[0] =  "outrange";
                ret[1] = "";
                ret[2] = result.Item2;
                ret[3] = result.Item3;
                ret[4] = "LUAR KAWASAN";
            }
            return ret;
        }
       



        public static Tuple<string, string, string  > GetGeoCustomer(int idbangunan, string lat, string longtitud)
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
        public static IEnumerable<string> CheckOpenGateMasuk_d(string userid, string app_Id, string lat1, string long1, string jenisk)
        {
            string status2 = "";
            //var result = GetGeoCustomer2(userid, lat1, long1);
            //// var result = GetGeoCustomer2test(userid, lat1, long1);
            //string myresult = "";
            //string status = result.Item1;
            //string dist = result.Item2;
            //string idbangunan = result.Item3;
            //string namabangunan = result.Item4;
            //string mynamastaf = result.Item5;
            //string jenistransaksi = jenisk;
            //string Wiegand = GetWeghang(userid);
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            string CommandText2 = "";
            SqlDataReader rdr2 = null;
            SqlConnection con2 = null;
            SqlCommand cmd2 = null;


            DateTime mydate = DateTime.Now;
            string mytime = DateTime.Now.ToShortTimeString();
            string mydateshort = DateTime.Now.ToString("dd/MM/yyyy");
            string[] ret = new string[6];
            ret[0] = "no";
            ret[0] = "punchinok";
            ret[1] = mydate.ToString();
            ret[2] = "200";
            ret[3] = "PUSAT KOMPUTER";
            ret[4] = "OK";
            return ret;
        }
        public static IEnumerable<string> CheckOpenGateMasuk(string userid, string app_Id, string lat1, string long1, string jenisk)
        {
            string myStr_SMSM = "Capaian ke database bermasalah. Sila cuba lagi";
            string stat_smsm = "";
            string status2 = "";
            var result = GetGeoCustomer2(userid, lat1, long1);
            // var result = GetGeoCustomer2test(userid, lat1, long1);
            string myresult = "";
            string status = result.Item1;
            string dist = result.Item2;
            string idbangunan = result.Item3;
            string namabangunan = result.Item4;
            string mynamastaf = result.Item5;
            string idkampus = result.Item6;
            string kodpengimbas = result.Item7;
            string jenistransaksi = jenisk;
            string Wiegand = GetWeghang(userid);
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            string CommandText2 = "";
            SqlDataReader rdr2 = null;
            SqlConnection con2 = null;
            SqlCommand cmd2 = null;


            DateTime mydate = DateTime.Now;
            string mytime = DateTime.Now.ToShortTimeString();
            string mydateshort = DateTime.Now.ToString("dd/MM/yyyy");
            string[] ret = new string[6];
            ret[0] = "Rekod kedatangan tidak dapat direkodkan. Sistem mendapati anda menggunkan versi lama myUTeM.Sila download myUTeM versi baru di AppStore";
            //"no";
            // if (idbangunan == "999") { ret[0] = "Lokasi perakam waktu anda tidak sah."; return ret; } 
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            String ConnectionString2 = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";

            if (status.Trim() == "ok")
            {
                //insert new
                myresult = WriteDatatoDBStaf(userid, mydate, idbangunan, mynamastaf, Wiegand, ConnectionString2, idkampus, kodpengimbas);
                if (myresult == "")
                {
                    status2 = "OK";
                    stat_smsm = "0";
                }
                else
                {
                    status2 = myStr_SMSM; // myresult;
                    stat_smsm = "1";
                }
                // if (myresult == "")
                // {
                try
                {
                    //  CommandText = "INSERT INTO  att04_attd_list_user ( att04_status, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_jenis_transaksi, att04_status_detail) values (@status, @app_id,@USERID,@MYDATE,@BGNID,@jenistransaksi, @status2)";

                    CommandText = "INSERT INTO  att04_attd_list_user ( att04_status, att01_id, att04_userid,  att04_bangunan_id, att04_jenis_transaksi, att04_status_detail) values (@status, @app_id,@USERID,@BGNID,@jenistransaksi, @status2)";
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@USERID", userid);
                    //  cmd.Parameters.AddWithValue("@MYDATE", mydate);
                    cmd.Parameters.AddWithValue("@app_id", app_Id);
                    cmd.Parameters.AddWithValue("@BGNID", idbangunan);
                    cmd.Parameters.AddWithValue("@jenistransaksi", jenistransaksi);
                    cmd.Parameters.AddWithValue("@status", status2);
                    cmd.Parameters.AddWithValue("@status2", myresult);
                    rdr = cmd.ExecuteReader();
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
                try
                {
                    //   CommandText = "INSERT INTO  att_VTranMind (ID, TkhMasa, TrController, TrName, Wiegand,PW14_Pengimbas, PW14_KodPengimbas, Status_Tran) values (@USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand,@pengimbas,@kodpengimbas,@stst_smsm)";

                    CommandText = "INSERT INTO  att_VTranMind (ID,  TrController, TrName, Wiegand,PW14_Pengimbas, PW14_KodPengimbas, Status_Tran) values (@USERID,  @BGNID, @mynamastaf, @Wiegand,@pengimbas,@kodpengimbas,@stst_smsm)";

                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@USERID", userid);
                    //  cmd.Parameters.AddWithValue("@MYDATE", mydate);
                    cmd.Parameters.AddWithValue("@BGNID", namabangunan);
                    cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                    cmd.Parameters.AddWithValue("@Wiegand", Wiegand);
                    cmd.Parameters.AddWithValue("@pengimbas", idkampus);
                    cmd.Parameters.AddWithValue("@kodpengimbas", kodpengimbas);
                    cmd.Parameters.AddWithValue("@stst_smsm", stat_smsm);
                    rdr = cmd.ExecuteReader();
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
                //  }
                if (myresult == "")
                {
                    ret[0] = "punchinok";
                    ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                    ret[2] = dist;
                    ret[3] = idkampus; // namabangunan;
                    ret[4] = "OK";

                }
                else
                {
                    ret[0] = myresult;
                }
            }
            else
            {
                //  ret[0] = "outrange";
                ret[2] = dist;
                var res = LoopBangunan(idbangunan, lat1, long1);
                //     ret[4] = "LUAR KAWASAN";
                if (res.Item2.Trim() == "")
                {
                    ret[0] = "outrange";
                    ret[1] = "-";
                    ret[3] = "ANDA BERADA DI LUAR KAWASAN";
                    //    ret[3] = "TIADA DALAM SISTEM";  ver 3.07 cnamge back
                    ret[4] = "ANDA BERADA DI LUAR KAWASAN"; //"LUAR KAWASAN";
                }
                else
                {
                    ret[3] = res.Item2;
                    ret[1] = mydate.ToString();
                    if (idbangunan == "99")
                    {
                        ret[0] = "punchinok";
                        ret[4] = "OK";
                    }
                    else
                    {
                        ret[0] = "outrange";
                        ret[4] = "LUAR KAWASAN";
                    }
                    myresult = WriteDatatoDBStaf(userid, mydate, idbangunan, mynamastaf, Wiegand, ConnectionString2, res.Item4, res.Item3);
                    if (myresult == "")
                    {
                        stat_smsm = "0";
                    }
                    else
                    {
                        ret[0] = myStr_SMSM; // myresult;
                        ret[4] = myStr_SMSM; // myresult;
                        stat_smsm = "1";
                    }
                    //  if (myresult == "")
                    //  {
                    try
                    {
                        //  CommandText = "INSERT INTO  att04_attd_list_user ( att04_status, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_jenis_transaksi, att04_status_detail) values (@status, @app_id,@USERID,@MYDATE,@BGNID,@jenistransaksi, @status2)";

                        CommandText = "INSERT INTO  att04_attd_list_user ( att04_status, att01_id, att04_userid,  att04_bangunan_id, att04_jenis_transaksi, att04_status_detail) values (@status, @app_id,@USERID,@BGNID,@jenistransaksi, @status2)";
                        con = new SqlConnection(ConnectionString);
                        con.Open();
                        cmd = new SqlCommand(CommandText);
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        //  cmd.Parameters.AddWithValue("@MYDATE", mydate);
                        cmd.Parameters.AddWithValue("@app_id", app_Id);
                        cmd.Parameters.AddWithValue("@BGNID", res.Item1);
                        cmd.Parameters.AddWithValue("@jenistransaksi", jenistransaksi);
                        cmd.Parameters.AddWithValue("@status", ret[4]);
                        cmd.Parameters.AddWithValue("@status2", myresult);
                        rdr = cmd.ExecuteReader();
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
                    try
                    {
                        //   CommandText = "INSERT INTO  att_VTranMind (ID, TkhMasa, TrController, TrName, Wiegand,PW14_Pengimbas, PW14_KodPengimbas, Status_Tran) values (@USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand,@pengimbas,@kodpengimbas,@stst_smsm)";

                        CommandText = "INSERT INTO  att_VTranMind (ID,  TrController, TrName, Wiegand,PW14_Pengimbas, PW14_KodPengimbas, Status_Tran) values (@USERID,  @BGNID, @mynamastaf, @Wiegand,@pengimbas,@kodpengimbas,@stst_smsm)";
                        con = new SqlConnection(ConnectionString);
                        con.Open();
                        cmd = new SqlCommand(CommandText);
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        //   cmd.Parameters.AddWithValue("@MYDATE", mydate);
                        cmd.Parameters.AddWithValue("@BGNID", namabangunan);
                        cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                        cmd.Parameters.AddWithValue("@Wiegand", Wiegand);
                        cmd.Parameters.AddWithValue("@pengimbas", res.Item4);
                        cmd.Parameters.AddWithValue("@kodpengimbas", res.Item3);
                        cmd.Parameters.AddWithValue("@stst_smsm", stat_smsm);
                        rdr = cmd.ExecuteReader();
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
                    //  }
                }



            }
            if (ret[0] == "")
            {
                ret[0] = "Rekod kedatangan tidak dapat direkodkan. Sistem mendapati anda menggunkan versi lama myUTeM.Sila download myUTeM versi baru di AppStore";
            }



            return ret;
        }
      

        public static Tuple<string, string, string, string, string> GetGeoCustomer2test(string nostaf, string lat, string longtitud)
        {
            string Status = "";

          //  var result = GetInfoBgnStaff(nostaf);
            string idbngnan = "6";
            string namabangunan = "Pusat Komputer";
            double mylat = 233;
            double mylong = 455;
            double myrange = 344;
            string mynamastaf = "khalid";
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

       

        public static Tuple<string, string, string, string, string, string, string> GetGeoCustomer2(string nostaf, string lat, string longtitud)
        {
            string Status = "";

            var result = GetInfoBgnStaff(nostaf);
            string idbngnan = result.Item1;
            string namabangunan = result.Item2;
            double mylat = Convert.ToDouble(result.Item3);
            double mylong = Convert.ToDouble(result.Item4);
            double myrange = Convert.ToDouble(result.Item5);
            string mynamastaf = result.Item6;
            string idkampus = result.Item7[0];
            string kodpengimbas = result.Item7[1];
            string pengimbas = result.Item7[2];
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
           



            return Tuple.Create( Status, mydist.ToString(), idbngnan, namabangunan, mynamastaf, idkampus, kodpengimbas);
        }
        public static Tuple<string, string, string, string, string, string, string[]> GetInfoBgnStaff(string nostaf)
        {
            string kodpengimbas = "0"; // "khalid";
            string pengimbas = "-"; // "khalid";
            string mynamastaf = "";
            double mylat = 0;
            double mylong = 0;
            double myrange = 0;
            double myidbangunan = 99;
            string namabangunan = "";
            string idkampus = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT  d.idkampus, d.Kampus, c.MS01_Nama, b.Latitud, b.Longitud, b.Range, b.NamaBangunan, a.MS21_NoStaf, a.MS21_JenHdr, a.MS21_StaHdr, a.MS21_IDBangunan, a.MS21_TkhKemaskini FROM MS21_PerakamWaktu as a, PW_Bangunan as b , MS01_Peribadi as c,  PW_Kampus as d where d.IDKampus = b.IDKampus and a.MS21_NoStaf = c.MS01_NoStaf  and b.IDBangunan = a.MS21_IDBangunan  and a.MS21_NoStaf=@nostaf";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nostaf", nostaf);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myidbangunan = Double.Parse(rdr["MS21_IDBangunan"].ToString());
                    namabangunan = rdr["NamaBangunan"].ToString();
                    mylat = Double.Parse(rdr["Latitud"].ToString());
                    mylong = Double.Parse(rdr["Longitud"].ToString());
                    myrange = Double.Parse(rdr["Range"].ToString());
                    mynamastaf = rdr["MS01_Nama"].ToString(); // "khalid";
                    

                    if (rdr["idkampus"].ToString() == "1")
                    {
                        kodpengimbas = "35"; // "khalid";
                        pengimbas = rdr["Kampus"].ToString(); // "khalid";
                        idkampus = rdr["Kampus"].ToString(); // "khalid";
                    }
                    else if (rdr["idkampus"].ToString() == "2")
                    {
                        kodpengimbas = "36"; // "khalid";
                        pengimbas = rdr["Kampus"].ToString(); // "khalid";
                        idkampus = rdr["Kampus"].ToString(); // "khalid";
                    }
                    else
                    {
                        kodpengimbas = "0"; // "khalid";
                        pengimbas = "-"; // "khalid";
                        idkampus = "-"; // "khalid";
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
            if (mynamastaf=="") { mynamastaf=findNamaStaf(nostaf); }
            return Tuple.Create(myidbangunan.ToString(), namabangunan, mylat.ToString(), mylong.ToString(), myrange.ToString(), mynamastaf, new string[] { idkampus, kodpengimbas, pengimbas } );
        }
     
        public static Tuple<string, string, string, string> LoopBangunan(string idbangunan, string lat, string longtitud)
        {
            string kodpengimbas = "0"; // "khalid";
            string pengimbas = "-"; // "khalid";
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
                string CommandText = "SELECT  b.idkampus, b.Kampus, a.Latitud, a.Longitud, a.Range,  a.NamaBangunan, a.IDBangunan FROM  PW_Bangunan as a,  PW_Kampus as b where a.IDKampus = b.IDKampus and a.IDBangunan  <> @idbangunan";
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
                        namabangunan = rdr["Kampus"].ToString(); //rdr["NamaBangunan"].ToString();
                        if (rdr["idkampus"].ToString() == "1")
                        {
                            kodpengimbas = "35"; // "khalid";
                            pengimbas = rdr["Kampus"].ToString(); // "khalid";
   
                        }
                        else if (rdr["idkampus"].ToString() == "2")
                        {
                            kodpengimbas = "36"; // "khalid";
                            pengimbas = rdr["Kampus"].ToString(); // "khalid";

                        }
                        else
                        {
                            kodpengimbas = "0"; // "khalid";
                            pengimbas = "-"; // "khalid";

                        }


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
            return Tuple.Create(myidbangunan.ToString(), namabangunan, kodpengimbas, pengimbas);
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
                string CommandText = "SELECT  b.Kampus, a.Latitud, a.Longitud, a.Range,  a.NamaBangunan, a.IDBangunan FROM  PW_Bangunan as a, PW_Kampus as b  where a.IDKampus=b.IDKampus and a.IDBangunan  = @idbangunan";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@idbangunan", idbangunan);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                  //  mybol = rdr["NamaBangunan"].ToString();
                    mybol = rdr["Kampus"].ToString();

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
      
        public static string WriteDatatoDBStaf_bbb(string userid, DateTime mydate, string idbangunan, string mynamastaf, string Wiegand, string mycon, string idkampus, string kodpengimbas)
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
                        //  cmd.Parameters.AddWithValue("@BGNID", idbangunan);
                        cmd.Parameters.AddWithValue("@BGNID", kodpengimbas);
                        cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                        cmd.Parameters.AddWithValue("@Wiegand", Wiegand);
                        cmd.Parameters.AddWithValue("@pengimbas", idkampus);
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
                            // cmd.CommandTimeout = 300;
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            myStr = e.Message; // "Capaian ke database bermasalah. Sila cuba lagi";
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
                myStr = ex.Message; //"Capaian ke database bermasalah. Sila cuba lagi";
            }
            if (myStr == "") { } else { myStr = WriteDatatoDBStaf_2round(userid, mydate, idbangunan, mynamastaf, Wiegand, mycon); }
            return myStr;
        }


        public static string WriteDatatoDBStaf(string userid, DateTime mydate, string idbangunan, string mynamastaf, string Wiegand, string mycon, string idkampus, string kodpengimbas)
        {
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            string CommandText = "";
            String ConnectionString = SQLAuth.dbase_dbstaf; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";

            string myStr="";
            try
            {
                CommandText = "INSERT INTO PW14_TranMind(PW14_IdBaru, PW14_IdAsal, PW14_KodTraksaksi, PW14_SiteCode, PW14_CardCode, PW14_NoKad, PW14_TkhMasa, PW14_KodPengimbas, PW14_Nama, PW14_Wiegand, PW14_TkhSumber, PW14_Sumber, PW14_Pengimbas, PW14_Transaksi) values(@idbaru, @idasal, @kodtransaksi, @sitecode, @cardcode, @USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand, @MYDATE, @sumber, @pengimbas, @transaksi)";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
                //  cmd.Parameters.AddWithValue("@BGNID", idbangunan);
                cmd.Parameters.AddWithValue("@BGNID", kodpengimbas);
                cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                cmd.Parameters.AddWithValue("@Wiegand", Wiegand);
                cmd.Parameters.AddWithValue("@pengimbas", idkampus);
                cmd.Parameters.AddWithValue("@transaksi", "Normal access by card only");
                cmd.Parameters.AddWithValue("@sumber", "GL");
                cmd.Parameters.AddWithValue("@idasal", "0");
                cmd.Parameters.AddWithValue("@kodtransaksi", "0");
                cmd.Parameters.AddWithValue("@sitecode", "52456");
                cmd.Parameters.AddWithValue("@cardcode", "55167");
                cmd.Parameters.AddWithValue("@idbaru", "0");
              //  cmd.CommandTimeout = 300;
                rdr = cmd.ExecuteReader();
            }
            catch (Exception ex)
            {
                myStr = ex.Message;
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
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
                            // cmd.CommandTimeout = 300;
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            myStr = e.Message; //"Capaian ke database bermasalah. Sila cuba lagi";
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
                myStr = ex.Message; // "Capaian ke database bermasalah. Sila cuba lagi";
            }
            return myStr;
        }

      
        //  public static IEnumerable<string> GetListLog(string userid, string app_Id, string lat1, string long1, string jenisk)
        public static string[,] GetListLog(string userid, string app_Id)
        {
            string[,] twoDimensional;
            twoDimensional = new string[1, 4];
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT  a.att04_jenis_transaksi, a.att04_status, a.att04_id, a.att01_id, a.att04_userid, convert(varchar,a.att04_timepunch, 13)  as mydatein ,  a.att04_datetime,  convert(varchar,a.att04_date, 103)  as mydate, a.att04_bangunan_id, b.ap04_nama FROM att04_attd_list_user as a, ap04_pejabat_latitud as b where a.att04_bangunan_id=b.ap04_id and a.att04_userid = @userid and a.att01_id = @app_id and cast(a.att04_date as date) = cast(getdate() as date)  order by a.att04_datetime asc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                int row = 0;
                DataTable dt = new DataTable();
                dt.Load(rdr);
                twoDimensional = new string[dt.Rows.Count, 4];
                while (rdr.Read())
                {

                    twoDimensional[row, 0] = rdr["mydatein"].ToString();
                    twoDimensional[row, 1] = rdr["att04_jenis_transaksi"].ToString();
                    twoDimensional[row, 2] = rdr["ap04_nama"].ToString();
                    twoDimensional[row, 3] = rdr["att04_status"].ToString();
                    row++;

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


            return twoDimensional;
        }
        public static IEnumerable<string> GetListLogSatuBaru(string userid, string app_Id, DateTime tarikh)
        {
            //  string[,] twoDimensional;
            //  twoDimensional = new string[1, 4];
            string[] ret = new string[2];
            ret[0] = "no";
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
              //  string CommandText = "SELECT  b.ap04_nama_lokasi, a.att04_jenis_transaksi, a.att04_status, a.att04_id, a.att01_id, a.att04_userid, convert(varchar,a.att04_timepunch, 13)  as mydatein ,  a.att04_datetime,  convert(varchar,a.att04_date, 103)  as mydate, a.att04_bangunan_id, b.ap04_nama FROM att04_attd_list_user as a, ap04_pejabat_latitud as b where a.att04_bangunan_id=b.ap04_id and a.att04_userid = @userid and a.att01_id = @app_id and cast(a.att04_date as date) = cast(getdate() as date)  order by a.att04_id asc";
                  string CommandText = "SELECT  b.ap04_nama_lokasi, a.att04_jenis_transaksi, a.att04_status, a.att04_id, a.att01_id, a.att04_userid, convert(varchar,a.att04_timepunch, 13)  as mydatein ,  a.att04_datetime,  convert(varchar,a.att04_date, 103)  as mydate, a.att04_bangunan_id, b.ap04_nama FROM att04_attd_list_user as a, ap04_pejabat_latitud as b where a.att04_bangunan_id=b.ap04_id and a.att04_userid = @userid and a.att01_id = @app_id and cast(a.att04_date as date) = cast(@tarikh as date)  order by a.att04_id asc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                cmd.Parameters.AddWithValue("@tarikh", tarikh);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["mydatein"].ToString());
                    myList.Add(rdr["att04_jenis_transaksi"].ToString());
                    //  myList.Add(rdr["ap04_nama"].ToString());
                    myList.Add(rdr["ap04_nama_lokasi"].ToString());
                    myList.Add(rdr["att04_status"].ToString());


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

        public static IEnumerable<string> GetListLogSatuKursus(string userid, string app_Id)
        {
            //  string[,] twoDimensional;
            //  twoDimensional = new string[1, 4];
            string[] ret = new string[2];
            ret[0] = "no";
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
                //    TOP (200) krs01_id_kursus, krs01_nama_kursus, krs01_tkh_mula, krs01_tkh_tamat, krs01_tempat, krs01_kod_qr, krs01_owner_kod
                //   string CommandText = "SELECT  b.ap04_nama_lokasi, a.att04_jenis_transaksi, a.att04_status, a.att04_id, a.att01_id, a.att04_userid, convert(varchar,a.att04_timepunch, 13)  as mydatein ,  a.att04_datetime,  convert(varchar,a.att04_date, 103)  as mydate, a.att04_bangunan_id, b.ap04_nama FROM att04_attd_list_user as a, ap04_pejabat_latitud as b where a.att04_bangunan_id=b.ap04_id and a.att04_userid = @userid and a.att01_id = @app_id and cast(a.att04_date as date) = cast(getdate() as date)  order by a.att04_id asc";
                string CommandText = "SELECT   b.krs01_nama_kursus,b.krs01_tempat,  a.krs02_id, a.krs02_id_kursus, a.krs02_id_peserta, a.krs02_tkh_wujud, a.krs02_jenis_transaksi, a.krs02_nama  FROM krs02_kehadiran_peserta as a,   krs01_kursus as b where b.krs01_id_kursus = a.krs02_id_kursus and a.krs02_id_peserta = @userid and cast(a.krs02_tkh_wujud as date) = cast(getdate() as date)  order by a.krs02_id desc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {




                    // "dd/MM/yyyy hh:mm tt"



                    myList.Add(rdr["krs02_tkh_wujud"].ToString());
                    myList.Add(rdr["krs01_tempat"].ToString());
                    myList.Add(rdr["krs01_nama_kursus"].ToString());
                    myList.Add("OK");


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


        public static IEnumerable<string> GetListLogSatu(string userid, string app_Id)
        {
          //  string[,] twoDimensional;
          //  twoDimensional = new string[1, 4];
            string[] ret = new string[2];
            ret[0] = "no";
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
                string CommandText = "SELECT  b.ap04_nama_lokasi, a.att04_jenis_transaksi, a.att04_status, a.att04_id, a.att01_id, a.att04_userid, convert(varchar,a.att04_timepunch, 13)  as mydatein ,  a.att04_datetime,  convert(varchar,a.att04_date, 103)  as mydate, a.att04_bangunan_id, b.ap04_nama FROM att04_attd_list_user as a, ap04_pejabat_latitud as b where a.att04_bangunan_id=b.ap04_id and a.att04_userid = @userid and a.att01_id = @app_id and cast(a.att04_date as date) = cast(getdate() as date)  order by a.att04_id asc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["mydatein"].ToString());
                    myList.Add(rdr["att04_jenis_transaksi"].ToString());
                  //  myList.Add(rdr["ap04_nama"].ToString());
                    myList.Add(rdr["ap04_nama_lokasi"].ToString());
                    myList.Add(rdr["att04_status"].ToString());


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
       
        public static int GetCountLog(string userid)
        {
            string mybolx = "1";
            int count = 0;
            int row = 0;
            SqlDataReader rdr2 = null;
            SqlConnection con2 = null;
            SqlCommand cmd2 = null;
            try
            {
                // Open connection to the database
                String ConnectionString2 = SQLAuth.dbase_dbmobile;
                con2 = new SqlConnection(ConnectionString2);
                con2.Open();
                string CommandText2 = "SELECT count(*)  FROM att04_attd_list_user as a where  a.att04_userid = @nostaf and a.att01_id = 3 and cast(a.att04_date as date) = cast(getdate() as date)  ";
                cmd2 = new SqlCommand(CommandText2);
                cmd2.Connection = con2;
                cmd2.CommandText = CommandText2;
                cmd2.Parameters.AddWithValue("@nostaf", userid);
                count = (Int32)cmd2.ExecuteScalar();
                //rdr2 = cmd2.ExecuteReader();
                ////  Int32 count = (Int32)cmd2.ExecuteScalar();
                //// mybol =count;
                //row = 0;
                //while (rdr2.Read())
                //{
                //  //  mybolx = "16"; // rdr2[0].ToString();
                //   // mybol = rdr2.GetInt32(0);
                //    row= row +1;

                //}

            }
            catch (Exception)
            {

            }
            finally
            {
                if (rdr2 != null)
                    rdr2.Close();

                if (con2.State == ConnectionState.Open)
                    con2.Close();
            }
         //   mybol = count; // Int32.Parse(mybolx);
            return count;
        }
       
              public static IEnumerable<string> GetWhitelist(string userid, string app_Id, string lat1, string long1, string jenisk)
        {
            String ConnectionString = "";
            List<string> list = new List<string>();
            int a = 0;
           // string[] ret;
          //  string[,] twoDimensional;
          //  ret = new string[1];
            // ret[0] = "notfound";
           // ret[0] = "error";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbmobile; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT  app_id, app_desc FROM ap05_Whitelist";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                //   cmd.Parameters.AddWithValue("@idbangunan", idbangunan);
                rdr = cmd.ExecuteReader();
               // int row = 0;
               // DataTable dt = new DataTable();
               // dt.Load(rdr);
              //  ret = new string[dt.Rows.Count];

             //   ret[0] = "found";
                while (rdr.Read())
                {
                  //  ret[a] = rdr["app_id"].ToString();
                    list.Add(rdr["app_id"].ToString());
                    a = a + 1;

                }
                

            }
            catch (Exception)
            {
                //return new string[] { "error" };
                list.Add("error");
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }
            string[] arrayx = list.ToArray();
            return arrayx;
            //   return new string[] { "error"};



        }
        public static IEnumerable<string> GetWhitelistxx(string userid, string app_Id, string lat1, string long1, string jenisk)
        {
            String ConnectionString = "";
            int a = 0;
            string[] ret = new string[50];
            // ret[0] = "notfound";
            ret[0] = "error";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbmobile; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT  app_id, app_desc FROM ap05_Whitelist";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                //   cmd.Parameters.AddWithValue("@idbangunan", idbangunan);
                rdr = cmd.ExecuteReader();
                ret[0] = "found";
                while (rdr.Read())
                {
                    ret[a] = rdr["app_id"].ToString();
                    a = a + 1;

                }

            }
            catch (Exception)
            {
                ret[0] = "error";
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
        public static IEnumerable<string> HantarAduan(string userid, string mydata)
        {
            string mystr = "";
            string[] ret = new string[1];
            ret[0] = "no";

           // string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"INSERT INTO  app_aduan (appad_userid, appad_aduan) values ( @USERID, @MYDATA)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@MYDATA", mydata);
                       
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            if (userid == "00578") {
                                mystr = reset24Hrs("all");
                              //  mystr = SQLMigs.updatealammakananbak();
                               // mystr = resettestpilihamraya("all");
                            }                            else                            {
                                string cc = SendEmailAduan("pppk@utem.edu.my", "Aduan Oleh Pengguna myUTeM, Pengguna ID:" + userid, mydata);
                            }
                                ret[0] = "ok";
                        }
                        catch (SqlException e)
                        {
                           // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
               // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
            }

            return ret;
        }
        public static string reset24Hrs(string users)
        {

            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        if (users == "all")
                        {
                            cmd.CommandText = @"update AspNetUsers set Reg_phoneid='0', Reg_lockdate=NULL";
                        }
                        else
                        {
                            cmd.CommandText = @"update AspNetUsers set Reg_phoneid='0', Reg_lockdate=NULL where Email = @USERID";
                        }
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", users);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
            }

            return "";
        }

        public static string resettestpilihamraya (string users)
        {

            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbpilihanraya))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {

                        cmd.CommandText = @"delete FROM     SP02_UNDI WHERE  (SP02_IDPENGUNDI = 'B031810230') OR (SP02_IDPENGUNDI = 'B051720049') OR  (SP02_IDPENGUNDI = 'BS01181003')";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", users);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
            }

            return "";
        }

        // $myString = "EXEC msdb.dbo.sp_send_dbmail @profile_name= 'MBOT', @recipients= '".$email."', @subject = 'MBOT Registration', @body= '".$msg."' , @body_format='HTML';";
        public static string SendEmailAduan(string myemail, string mysubject, string mybody)
        {
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"EXEC msdb.dbo.sp_send_dbmail @profile_name= 'myUTeM', @recipients= @MYEMAIL, @subject = @MYSUBJECT, @body= @MYBODY , @body_format='HTML';";
                      //  cmd.CommandText = @"EXEC msdb.dbo.sp_send_dbmail @profile_name= 'myUTeM', @recipients= 'khalid@utem.edu.my', @subject = 'test', @body= 'testx' , @body_format='HTML';";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@MYEMAIL", myemail);
                        cmd.Parameters.AddWithValue("@MYSUBJECT", mysubject);
                        cmd.Parameters.AddWithValue("@MYBODY", mybody);
                      

                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                myStr = "Capaian ke database bermasalah. Sila cuba lagi";
            }
            return myStr;
        }
        public static string SendEmailSMSM(string myemail, string mysubject, string mybody)
        {
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbstaf))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"EXEC msdb.dbo.sp_send_dbmail @profile_name= 'emailsmsm', @recipients= @MYEMAIL, @subject = @MYSUBJECT, @body= @MYBODY , @body_format='HTML';";
                        //  cmd.CommandText = @"EXEC msdb.dbo.sp_send_dbmail @profile_name= 'myUTeM', @recipients= 'khalid@utem.edu.my', @subject = 'test', @body= 'testx' , @body_format='HTML';";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@MYEMAIL", myemail);
                        cmd.Parameters.AddWithValue("@MYSUBJECT", mysubject);
                        cmd.Parameters.AddWithValue("@MYBODY", mybody);


                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                myStr = "Capaian ke database bermasalah. Sila cuba lagi";
            }
            return myStr;
        }
     
        public static IEnumerable<string> GetSMSMPerakam(string userid, string tar, string tar2)
        {
            string PW01_Lewat = "";
            string PW01_TerimaLwt = "";
            string PW01_BlkAwal = "";
            string PW01_TerimaBlk = "";
            string[] ret = new string[4];
            ret[0] = "no";
            ret[3] = "Black";
            string mydate = DateTime.Now.ToString("yyyy-MM-dd");
            string mydate2 = DateTime.Now.ToString("dd-MM-yyyy");
         //   ret[7] = tar;
            mydate = tar2 + " 00:00:00";
            // List<string> myList = new List<string>();
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT     MS21_NoStaf, MS01_CardSN, PW01_IdMasuk, PW01_TkhHadir, PW01_MsMasuk, PW01_IdKeluar, PW01_TkhKeluar, PW01_MsKeluar, PW01_Nota, PW01_SbbMasuk, PW01_SbbKeluar, PW01_Lewat,  ";
                CommandText = CommandText + "PW01_TerimaLwt, PW01_PengesahLwt, PW01_TkhSahLwt, PW01_BlkAwal, PW01_TerimaBlk, PW01_PengesahBlk, PW01_TkhSahBlk, PW01_KodPejabat, PW01_Status, PW01_KaunterMsk, PW01_KaunterKlr,  ";
                CommandText = CommandText + "PW01_TkhWujud, PW01_HName, PW01_MskLocality, PW01_TerimaMskLocality, PW01_KlrLocality, PW01_TerimaKlrLocality, PW01_SbbMskLocality, PW01_SbbKlrLocality, PW01_IdBangunanMsk,  ";
                CommandText = CommandText + "PW01_IdBangunanKlr ";
                CommandText = CommandText + "FROM            PW01_Hadir ";
                CommandText = CommandText + "WHERE(MS21_NoStaf = @userid) AND(PW01_TkhHadir = CONVERT(DATETIME,  @Tkh, 102)) ";

                //  CommandText = CommandText + "WHERE(MS21_NoStaf = @userid) AND(PW01_TkhHadir = CONVERT(DATETIME,  '2018-09-03 00:00:00', 102)) ";

          //      SELECT MS21_NoStaf, MS01_CardSN, PW01_IdMasuk, PW01_TkhHadir, PW01_MsMasuk, PW01_IdKeluar, PW01_TkhKeluar, PW01_MsKeluar, PW01_Nota, PW01_SbbMasuk, PW01_SbbKeluar, PW01_Lewat,
            //    PW01_TerimaLwt, PW01_PengesahLwt, PW01_TkhSahLwt, PW01_BlkAwal, PW01_TerimaBlk, PW01_PengesahBlk, PW01_TkhSahBlk, PW01_KodPejabat, PW01_Status, PW01_KaunterMsk, PW01_KaunterKlr,
           //     PW01_TkhWujud, PW01_HName, PW01_MskLocality, PW01_TerimaMskLocality, PW01_KlrLocality, PW01_TerimaKlrLocality, PW01_SbbMskLocality, PW01_SbbKlrLocality, PW01_IdBangunanMsk,
          //     PW01_IdBangunanKlr
           //     FROM PW01_Hadir


           //   CommandText = CommandText + "WHERE(MS21_NoStaf = '00578') AND(PW01_TkhHadir = CONVERT(DATETIME,  '2018-09-03 00:00:00', 102)) 



                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@Tkh", mydate);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    // myList.Add(rdr["mydatein"].ToString());
                    ret[0] = "ok";



                    ret[1] = rdr["PW01_MsMasuk"].ToString();
                    ret[2] = rdr["PW01_MsKeluar"].ToString();


                    //ret[3] = rdr["PW01_Lewat"].ToString();
                    //ret[4] = rdr["PW01_TerimaLwt"].ToString();
                    //ret[5] = rdr["PW01_BlkAwal"].ToString();
                    //ret[6] = rdr["PW01_TerimaBlk"].ToString();
                    //ret[7] = tar;

                    PW01_Lewat= rdr["PW01_Lewat"].ToString();
                    PW01_TerimaLwt = rdr["PW01_TerimaLwt"].ToString();
                    PW01_BlkAwal = rdr["PW01_BlkAwal"].ToString();
                    PW01_TerimaBlk = rdr["PW01_TerimaBlk"].ToString();

                }
                //if (
                //((PW01_Lewat == "False") && (PW01_BlkAwal == "False")) ||
                //(((PW01_Lewat == "True") && (PW01_TerimaLwt == "False")) && ((PW01_BlkAwal == "True") && (PW01_TerimaBlk == "False"))) ||
                //(((PW01_Lewat == "False")) && ((PW01_BlkAwal == "True") && (PW01_TerimaBlk == "True"))) ||
                // (((PW01_Lewat == "True") && (PW01_TerimaLwt == "True")) && ((PW01_BlkAwal == "False")))
                // )
                //{
                //    ret[3] = "Black";
                //}
                //else
                //{
                //    ret[3] = "Black";
                //}

            }
            catch (Exception)
            {
                ret[0] = "er";
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


        public static string findNamaStaf(string user)
        {
            string mybol = "yyxx";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT        MS01_Nama    FROM            MS01_Peribadi where  MS01_NoStaf= @CLM_loginID  ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 20, "CLM_loginID"));  // The name of the source column
                cmd.Parameters["@CLM_loginID"].Value = user;

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

        private byte[] ReadFile(HttpPostedFile file)
        {
            byte[] data = new Byte[file.ContentLength];
            file.InputStream.Read(data, 0, file.ContentLength);
            return data;
        }

        public static IEnumerable<string> HantarIsuuTicket(string user,  string aduan, HttpPostedFile myStream, string lokasi, string telefon, string jenis, string kategori, string mylat, string mylong)
        {
            string[] ret = new string[1];
            ret[0] = "no";
            try
            {
                if ((telefon == "-") || (telefon == "")) { telefon = SQLMigs.GetTelefon(user); }
                HttpPostedFile postedFile = myStream;
                string fileExtension = Path.GetExtension(postedFile.FileName);
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".png")
                        {
                            Stream stream = postedFile.InputStream;
                            BinaryReader reader = new BinaryReader(stream);
                            byte[] imgByte = reader.ReadBytes((int)stream.Length);
                            cmd.CommandText = @"INSERT INTO  cms01_Kecemasan ( cms01_userid, cms01_nama, cms01_aduan, cms01_lokasi, cms01_kodpejabat_terima, cms01_gambar, cms01_status, cms01_telefon, cms01_jenis_gambar,  cms01_kategori, cms01_lat, cms01_long) values ( @USERID, @nama, @aduan,@lokasi,@kodpejabat, @img, @status, @telefon, @jenis,@kategori,@mylat,@mylong)";
                            cmd.Connection = sqlConn;
                            cmd.Parameters.AddWithValue("@USERID", user);
                            cmd.Parameters.AddWithValue("@nama", SQLMigs.GetNama(user));
                            cmd.Parameters.AddWithValue("@aduan", aduan);
                            cmd.Parameters.AddWithValue("@lokasi", lokasi);
                            cmd.Parameters.AddWithValue("@telefon", telefon);
                            cmd.Parameters.AddWithValue("@jenis", jenis);
                            cmd.Parameters.AddWithValue("@kategori", kategori);
                            cmd.Parameters.AddWithValue("@mylat", mylat);
                            cmd.Parameters.AddWithValue("@mylong", mylong);
                            cmd.Parameters.AddWithValue("@kodpejabat", "22");
                            cmd.Parameters.AddWithValue("@status", "0");
                            cmd.Parameters.Add("@img", SqlDbType.VarBinary).Value = imgByte;

                            try
                            {
                                sqlConn.Open();
                                cmd.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] = "A " + e.Message.ToString();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = "B " + ex.Message.ToString();
            }

            return ret;
        }


        public static IEnumerable<string> HantarIsuuTicket2(string user, string aduan,  string lokasi, string telefon, string jenis, string kategori, string mylat, string mylong)
        {
            string[] ret = new string[1];
            ret[0] = "no";
            try
            {
                if ((telefon == "-") || (telefon == "")) { telefon = SQLMigs.GetTelefon(user); }
               // HttpPostedFile postedFile = myStream;
              //  string fileExtension = Path.GetExtension(postedFile.FileName);
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                       // if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".png")
                      //  {
                         //   Stream stream = postedFile.InputStream;
                          //  BinaryReader reader = new BinaryReader(stream);
                          //  byte[] imgByte = reader.ReadBytes((int)stream.Length);
                            cmd.CommandText = @"INSERT INTO  cms01_Kecemasan ( cms01_userid, cms01_nama, cms01_aduan, cms01_lokasi, cms01_kodpejabat_terima,  cms01_status, cms01_telefon, cms01_jenis_gambar,  cms01_kategori, cms01_lat, cms01_long) values ( @USERID, @nama, @aduan,@lokasi,@kodpejabat,  @status, @telefon, @jenis,@kategori,@mylat,@mylong)";
                            cmd.Connection = sqlConn;
                            cmd.Parameters.AddWithValue("@USERID", user);
                            cmd.Parameters.AddWithValue("@nama", SQLMigs.GetNama(user));
                            cmd.Parameters.AddWithValue("@aduan", aduan);
                            cmd.Parameters.AddWithValue("@lokasi", lokasi);
                            cmd.Parameters.AddWithValue("@telefon", telefon);
                            cmd.Parameters.AddWithValue("@jenis", "");
                            cmd.Parameters.AddWithValue("@kategori", kategori);
                            cmd.Parameters.AddWithValue("@mylat", mylat);
                            cmd.Parameters.AddWithValue("@mylong", mylong);
                            cmd.Parameters.AddWithValue("@kodpejabat", "22");
                            cmd.Parameters.AddWithValue("@status", "0");
                        //    cmd.Parameters.Add("@img", SqlDbType.VarBinary).Value = imgByte;

                            try
                            {
                                sqlConn.Open();
                                cmd.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] = "A " + e.Message.ToString();
                            }
                      //  }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = "B " + ex.Message.ToString();
            }

            return ret;
        }



        public static IEnumerable<string> HantarIsuuTicket_fill(string user, string aduan, HttpPostedFile myStream, string lokasi, string telefon, string jenis, string kategori, string mylat, string mylong)
        {
            string[] ret = new string[1];
            ret[0] = "no";
            string aduanid = telefon;
            string ulasan = aduan;
            string jenisgambar = jenis;
            try
            {
                if (find_EmegencyLogexist(aduanid) == true)
                {

                }
                else
                {
                    HttpPostedFile postedFile = myStream;
                    string fileExtension = Path.GetExtension(postedFile.FileName);
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".png")
                            {
                                Stream stream = postedFile.InputStream;
                                BinaryReader reader = new BinaryReader(stream);
                                byte[] imgByte = reader.ReadBytes((int)stream.Length);
                                //SELECT        TOP (200) cms02_id, cms01_id, cms02_tarikh, cms02_staffno_pegawai, cms02_ulasan, cms02_kodpejabat_ulasan, cms02_gambar, cms02_jenis_gambar
                                // FROM cms02_Log_kecemasan
                                cmd.CommandText = @"INSERT INTO  cms02_Log_kecemasan ( cms01_id, cms02_staffno_pegawai, cms02_ulasan, cms02_kodpejabat_ulasan, cms02_jenis_gambar, cms02_gambar) values ( @cms01_id, @staffno_pegawai,@cms02_ulasan,@cms02_kodpejabat,@jenisgambar, @img)";
                                cmd.Connection = sqlConn;
                                cmd.Parameters.AddWithValue("@cms01_id", aduanid);
                                cmd.Parameters.AddWithValue("@staffno_pegawai", user);
                                cmd.Parameters.AddWithValue("@cms02_ulasan", ulasan);
                                cmd.Parameters.AddWithValue("@cms02_kodpejabat", "22");
                                cmd.Parameters.AddWithValue("@jenisgambar", jenisgambar);
                                cmd.Parameters.Add("@img", SqlDbType.VarBinary).Value = imgByte;

                                try
                                {
                                    sqlConn.Open();
                                    cmd.ExecuteNonQuery();
                                    ret[0] = "ok";
                                    // update status
                                    string ff = update_emergency_status(aduanid, lokasi);
                                }
                                catch (SqlException e)
                                {
                                    ret[0] = "A " + e.Message.ToString();
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = "B " + ex.Message.ToString();
            }

            return ret;
        }

        public static IEnumerable<string> HantarDataDanFile(string user, HttpPostedFile myStream, string data1, string data2)
        {
            string[] ret = new string[1];
            ret[0] = "no";
            try
            {
                    HttpPostedFile postedFile = myStream;
                    string fileExtension = Path.GetExtension(postedFile.FileName);
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".png")
                            {
                                Stream stream = postedFile.InputStream;
                                BinaryReader reader = new BinaryReader(stream);
                                byte[] imgByte = reader.ReadBytes((int)stream.Length);
                                cmd.CommandText = @"INSERT INTO  cms02_Log_kecemasan ( cms01_id, cms02_staffno_pegawai, cms02_ulasan, cms02_kodpejabat_ulasan, cms02_jenis_gambar, cms02_gambar) values ( @cms01_id, @staffno_pegawai,@cms02_ulasan,@cms02_kodpejabat,@jenisgambar, @img)";
                                cmd.Connection = sqlConn;
                                cmd.Parameters.AddWithValue("@data1", data1);
                                cmd.Parameters.AddWithValue("@data1", data2);
                                cmd.Parameters.Add("@img", SqlDbType.VarBinary).Value = imgByte;

                                try
                                {
                                    sqlConn.Open();
                                    cmd.ExecuteNonQuery();
                                    ret[0] = "ok";
                                }
                                catch (SqlException e)
                                {
                                    ret[0] = "A " + e.Message.ToString();
                                }
                            }
                        }
                    }
            }
            catch (Exception ex)
            {
                ret[0] = "B " + ex.Message.ToString();
            }

            return ret;
        }
        public static IEnumerable<string> HantarDataSahaja(string user,  string data1, string data2)
        {
            string[] ret = new string[1];
            ret[0] = "no";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                            cmd.CommandText = @"INSERT INTO  cms02_Log_kecemasan ( cms01_id, cms02_staffno_pegawai, cms02_ulasan, cms02_kodpejabat_ulasan, cms02_jenis_gambar, cms02_gambar) values ( @cms01_id, @staffno_pegawai,@cms02_ulasan,@cms02_kodpejabat,@jenisgambar, @img)";
                            cmd.Connection = sqlConn;
                            cmd.Parameters.AddWithValue("@data1", data1);
                            cmd.Parameters.AddWithValue("@data1", data2);


                            try
                            {
                                sqlConn.Open();
                                cmd.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] = "A " + e.Message.ToString();
                            }
                        }
             
                }
            }
            catch (Exception ex)
            {
                ret[0] = "B " + ex.Message.ToString();
            }

            return ret;
        }


        public static IEnumerable<string> HantarIsuuTicket2_fill(string user, string aduan, string lokasi, string telefon, string jenis, string kategori, string mylat, string mylong)
        {
            string[] ret = new string[1];
            ret[0] = "no";
            string aduanid = telefon;
            string ulasan = aduan;
            string jenisgambar = jenis;
            try
            {
                if (find_EmegencyLogexist(aduanid) ==true) { 
                
                }
                else
                {
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {

                            cmd.CommandText = @"INSERT INTO  cms02_Log_kecemasan ( cms01_id, cms02_staffno_pegawai, cms02_ulasan, cms02_kodpejabat_ulasan) values ( @cms01_id, @staffno_pegawai,@cms02_ulasan,@cms02_kodpejabat)";
                            cmd.Connection = sqlConn;
                            cmd.Parameters.AddWithValue("@cms01_id", aduanid);
                            cmd.Parameters.AddWithValue("@staffno_pegawai", user);
                            cmd.Parameters.AddWithValue("@cms02_ulasan", ulasan);
                            cmd.Parameters.AddWithValue("@cms02_kodpejabat", "22");
                            try
                            {
                                sqlConn.Open();
                                cmd.ExecuteNonQuery();
                                ret[0] = "ok";
                                // update status
                                string ff = update_emergency_status(aduanid, lokasi);
                            }
                            catch (SqlException e)
                            {
                                ret[0] = "A " + e.Message.ToString();
                            }
                            //  }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = "B " + ex.Message.ToString();
            }

            return ret;
        }
        public static string update_emergency_status(string myid, string statusx)
        {
            string mydat = "0";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        // combo index 0 hidden
                        if (statusx == "0") { mydat = "1"; }
                        if (statusx == "1") { mydat = "2"; }
                        if (statusx == "2") { mydat = "3"; }
                        cmd.CommandText = @"update cms01_Kecemasan set  cms01_status=@statusx where cms01_id=@myid";

                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@myid", myid);
                        cmd.Parameters.AddWithValue("@statusx", mydat);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
            }

            return "";
        }
        public static bool find_EmegencyLogexist(string myid)
        {
            bool mybol = false;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT        cms01_id, cms02_staffno_pegawai    FROM     cms02_Log_kecemasan where  cms01_id=@myid";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@myid", myid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = true;
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
            if (mybol == true)
            {
                string hh = onetone_DeleteEmegencyLogexist(myid);
                mybol = false;
            }
            return mybol;
        }
        public static string onetone_DeleteEmegencyLogexist(string myid)
        {

            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {

                        cmd.CommandText = @"delete FROM     cms02_Log_kecemasan where  cms01_id=@myid";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@myid", myid);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
            }

            return "";
        }


        //public static bool onetone_DeleteEmegencyLogexist(string myid)
        //{
        //    SqlDataReader rdr = null;
        //    SqlConnection con = null;
        //    SqlCommand cmd = null;
        //    try
        //    {
        //        using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
        //        {
        //            using (SqlCommand cmd = new SqlCommand())
        //            {

        //                cmd.CommandText = @"delete FROM     SP02_UNDI WHERE  (SP02_IDPENGUNDI = 'B031810230') OR (SP02_IDPENGUNDI = 'B051720049') OR  (SP02_IDPENGUNDI = 'BS01181003')";
        //                cmd.Connection = sqlConn;
        //                cmd.Parameters.AddWithValue("@USERID", myid);
        //                try
        //                {
        //                    sqlConn.Open();
        //                    cmd.ExecuteNonQuery();
        //                }
        //                catch (SqlException e)
        //                {
        //                    // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
        //                }
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // myStr = "Capaian ke database bermasalah. Sila cuba lagi";
        //    }

















        //    //bool mybol = false;
        //    //SqlDataReader rdr = null;
        //    //SqlConnection con = null;
        //    //SqlCommand cmd = null;

        //    //try
        //    //{

        //    //    String ConnectionString = SQLAuth.dbase_dbmobile;
        //    //    con = new SqlConnection(ConnectionString);
        //    //    con.Open();
        //    //    string CommandText = "delete    FROM     cms02_Log_kecemasan where  cms01_id=@myid";
        //    //    cmd = new SqlCommand(CommandText);
        //    //    cmd.Connection = con;
        //    //    cmd.Parameters.AddWithValue("@myid", myid);
        //    //    rdr = cmd.ExecuteReader();
        //    //    while (rdr.Read())
        //    //    {
        //    //        mybol = true;
        //    //    }
        //    //}
        //    //catch (Exception)
        //    //{


        //    //}
        //    //finally
        //    //{
        //    //    if (rdr != null)
        //    //        rdr.Close();

        //    //    if (con.State == ConnectionState.Open)
        //    //        con.Close();
        //    //}

        //    //return mybol;
        //}
    }
}