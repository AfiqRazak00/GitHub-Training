using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


using System.Data.SqlClient;
using System.Device.Location;

using System.Data;



namespace WebApi
{
    public class SQLPerakamResGeo
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

                string CommandText = "SELECT  att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_usergra where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime asc";
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
                    ret[2] = rdr["att04_bangunan_id"].ToString(); //  rdr["att04_bangunan_id"].ToString();
                    if (rdr["att04_status"].ToString() == "punchinok")
                    {
                        ret[3] = "OK";
                    }
                    else
                    {
                        ret[3] = rdr["att04_status"].ToString();
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
        //public static IEnumerable<string> CheckOpenGateMasuk_d(string userid, string app_Id, string lat1, string long1, string jenisk)
        //{
        //    string status2 = "";
        //    //var result = GetGeoCustomer2(userid, lat1, long1);
        //    //// var result = GetGeoCustomer2test(userid, lat1, long1);
        //    //string myresult = "";
        //    //string status = result.Item1;
        //    //string dist = result.Item2;
        //    //string idbangunan = result.Item3;
        //    //string namabangunan = result.Item4;
        //    //string mynamastaf = result.Item5;
        //    //string jenistransaksi = jenisk;
        //    //string Wiegand = GetWeghang(userid);
        //    string CommandText = "";
        //    SqlDataReader rdr = null;
        //    SqlConnection con = null;
        //    SqlCommand cmd = null;

        //    string CommandText2 = "";
        //    SqlDataReader rdr2 = null;
        //    SqlConnection con2 = null;
        //    SqlCommand cmd2 = null;


        //    DateTime mydate = DateTime.Now;
        //    string mytime = DateTime.Now.ToShortTimeString();
        //    string mydateshort = DateTime.Now.ToString("dd/MM/yyyy");
        //    string[] ret = new string[6];
        //    ret[0] = "no";
        //    ret[0] = "punchinok";
        //    ret[1] = mydate.ToString();
        //    ret[2] = "200";
        //    ret[3] = "PUSAT KOMPUTER";
        //    ret[4] = "OK";
        //    return ret;
        //}
        public static IEnumerable<string> CheckOpenGateMasuk(string userid, string app_Id, string lat1, string long1, string jenisk, string lokasi)
        {
            string lokasi_semak = lokasi;
            string jenistransaksi = jenisk;
           // string Wiegand = GetWeghang(userid);
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            

            string status2 = "";
            string myresult = "";
            string Wiegand = "23333"; // GetWeghang(userid);
            DateTime mydate = DateTime.Now;
            string mytime = DateTime.Now.ToShortTimeString();
            string mydateshort = DateTime.Now.ToString("dd/MM/yyyy");
            string[] ret = new string[6];
            ret[0] = "Rekod kedatangan tidak dapat direkodkan. Sistem mendapati anda menggunkan versi lama myUTeM.Sila download myUTeM versi baru di AppStore";
            //insert new
            // myresult = WriteDatatoDBStaf(userid, mydate, lokasi, "Ali", Wiegand, SQLAuth.dbase_dbresearcher);
            string nama = SQLAuth.sqlCheckGRA_Nama(userid);

          //  if (lokasi.Contains("Unnamed Road"))
          //  {
                string cc = NamaLokasi(lat1, long1);
                if ( cc == "out")
                {
                }
                else
                {
                    lokasi_semak = cc;
                }
           // }




            myresult = WriteDatatoDBStaf(userid, mydate, lokasi_semak, nama, Wiegand, SQLAuth.dbase_dbresearcher);
            if (myresult == "")
            {
                status2 = "punchinok";
                ret[0] = status2;
                ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                ret[2] = lokasi_semak;
                ret[3] = "OK";
            }
            else
            {
                status2 = myresult;
                ret[0] = status2;
                ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                ret[2] = lokasi_semak;
                ret[3] = "GAGAL";
            }

            
            myresult = WriteDatatoDBStaf_dbmob(userid, mydate, lokasi_semak, nama, Wiegand, SQLAuth.dbase_dbmobile);
            try
            {
            CommandText = "INSERT INTO  att04_attd_list_usergra ( att04_status, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_jenis_transaksi) values (@status, @app_id,@USERID,@MYDATE,@BGNID,@jenistransaksi)";
            con = new SqlConnection(SQLAuth.dbase_dbmobile);
            con.Open();
            cmd = new SqlCommand(CommandText);
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@USERID", userid);
            cmd.Parameters.AddWithValue("@MYDATE", mydate);
            cmd.Parameters.AddWithValue("@app_id", app_Id);
            cmd.Parameters.AddWithValue("@BGNID", lokasi_semak);
            cmd.Parameters.AddWithValue("@jenistransaksi", jenistransaksi);
            cmd.Parameters.AddWithValue("@status", status2);
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
            return ret;
        }


        public static string NamaLokasi(string lat1, string long1)
        {// Unnamed Road
            string hantar = "out";
            string Lokasi = "Kampus Induk UTeM";
            double mylat = 2.311594;
            double mylong = 102.320385;
            double mydistdef = 873;
            double mydist = (GPS_DistanceRes(lat1, long1, mylat, mylong) * 1000);
            if (mydist <= mydistdef)
            {
                hantar = Lokasi;
            }
            if (hantar == "out")
            {
                Lokasi = "Kampus Teknologi UTeM";
                mylat = 2.277924;
                mylong = 102.273908;
                mydistdef = 250;
                mydist = (GPS_DistanceRes(lat1, long1, mylat, mylong) * 1000);
                if (mydist <= mydistdef)
                {
                    hantar = Lokasi;
                }
            }
            if (hantar == "out")
            {
                Lokasi = "Kampus Teknologi-fasa B UTeM";
                mylat = 2.274371;
                mylong = 102.281433;
                mydistdef = 84;
                mydist = (GPS_DistanceRes(lat1, long1, mylat, mylong) * 1000);
                if (mydist <= mydistdef)
                {
                    hantar = Lokasi;
                }
            }
            return hantar;
        }
        public static double GPS_DistanceRes(string latitude, string longitude, double Lat2, double Long2)
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
        public static Tuple<string, string, string, string, string, string, string> GetInfoBgnStaff(string nostaf)
        {
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
                string CommandText = "SELECT   d.Kampus, c.MS01_Nama, b.Latitud, b.Longitud, b.Range, b.NamaBangunan, a.MS21_NoStaf, a.MS21_JenHdr, a.MS21_StaHdr, a.MS21_IDBangunan, a.MS21_TkhKemaskini FROM MS21_PerakamWaktu as a, PW_Bangunan as b , MS01_Peribadi as c,  PW_Kampus as d where d.IDKampus = b.IDKampus and a.MS21_NoStaf = c.MS01_NoStaf  and b.IDBangunan = a.MS21_IDBangunan  and a.MS21_NoStaf=@nostaf";
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
                    idkampus = rdr["Kampus"].ToString(); // "khalid";
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
            return Tuple.Create(myidbangunan.ToString(), namabangunan, mylat.ToString(), mylong.ToString(), myrange.ToString(), mynamastaf, idkampus);
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

        public static string WriteDatatoDBStaf_dbmob(string userid, DateTime mydate, string idbangunan, string mynamastaf, string Wiegand, string mycon)
        {
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(mycon))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {

                   

                        cmd.CommandText = @"INSERT INTO  att_VTranMindgra (ID, TkhMasa, TrController, TrName, Wiegand) values (@USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand)";
                        cmd.Connection = sqlConn;

                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@MYDATE", mydate);
                        cmd.Parameters.AddWithValue("@BGNID", idbangunan);
                        cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                        cmd.Parameters.AddWithValue("@Wiegand", Wiegand);


                     


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
          //  if (myStr == "") { } else { myStr = WriteDatatoDBStaf_2round(userid, mydate, idbangunan, mynamastaf, Wiegand, mycon); }
            return myStr;
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
                        cmd.CommandText = @"INSERT INTO  PW13_TranSoyal (PW13_IdBaru, PW13_IdAsal, PW13_KodTraksaksi,  PW13_SiteCode, PW13_CardCode, PW13_NoKad, PW13_TkhMasa, PW13_KodPengimbas, PW13_Nama, PW13_Wiegand, PW13_TkhSumber, PW13_Sumber, PW13_Pengimbas, PW13_Transaksi) values (@idbaru, @idasal, @kodtransaksi, @sitecode, @cardcode, @USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand, @MYDATE, @sumber, @pengimbas, @transaksi)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@MYDATE", mydate);
                        cmd.Parameters.AddWithValue("@BGNID", "");
                        cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                        cmd.Parameters.AddWithValue("@Wiegand", Wiegand);
                        cmd.Parameters.AddWithValue("@pengimbas", idbangunan);
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
                  
                        cmd.CommandText = @"INSERT INTO  PW13_TranSoyal (PW13_IdBaru, PW13_IdAsal, PW13_KodTraksaksi,  PW13_SiteCode, PW13_CardCode, PW13_NoKad, PW13_TkhMasa, PW13_KodPengimbas, PW13_Nama, PW13_Wiegand, PW13_TkhSumber, PW13_Sumber, PW13_Pengimbas, PW13_Transaksi) values (@idbaru, @idasal, @kodtransaksi, @sitecode, @cardcode, @USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand, @MYDATE, @sumber, @pengimbas, @transaksi)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@MYDATE", mydate);
                        cmd.Parameters.AddWithValue("@BGNID", "");
                        cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                        cmd.Parameters.AddWithValue("@Wiegand", Wiegand);
                        cmd.Parameters.AddWithValue("@pengimbas", idbangunan);
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

             //   att04_id, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_jenis_transaksi, att04_datetime, att04_date, att04_status
                string CommandText = "SELECT  a.att04_bangunan_id,a.att04_jenis_transaksi, a.att04_status, a.att04_id, a.att01_id, a.att04_userid, convert(varchar,a.att04_timepunch, 13)  as mydatein ,  a.att04_datetime,  convert(varchar,a.att04_date, 103)  as mydate, a.att04_bangunan_id FROM att04_attd_list_usergra as a where  a.att04_userid = @userid and a.att01_id = @app_id and cast(a.att04_date as date) = cast(getdate() as date)  order by a.att04_id asc";

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
                    myList.Add(rdr["att04_bangunan_id"].ToString());
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


        public static IEnumerable<string> HantarAduan(string userid, string mydata)
        {
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

                    PW01_Lewat = rdr["PW01_Lewat"].ToString();
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
    }
}