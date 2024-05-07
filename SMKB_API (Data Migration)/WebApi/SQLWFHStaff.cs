using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


using System.Data.SqlClient;
using System.Device.Location;

using System.Data;
using System.Net;
using System.IO;








namespace WebApi
{
    public class SQLWFHStaff
    {

        public static IEnumerable<string> GetInfoStud(string userid, string app_Id, string jenis)
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

                string CommandText = "SELECT  att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_stud_localiti where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime asc";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", '3');
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

                string CommandText = "SELECT  att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_wfhstaff where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime asc";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", '3');
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
        public static IEnumerable<string> StaffGateMasuk(string userid, string app_Id, string jenisk, string lokasi, string lat1, string long1, string mynegara, string myposkod)
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
            if (cc == "out")
            {
            }
            else
            {
                lokasi_semak = cc;
            }
            // }

            myresult = WriteDatatoDBStaf_dbmob(userid, mydate, lokasi_semak, nama, Wiegand, SQLAuth.dbase_dbmobile, lat1, long1);
            if (myresult == "")
            {

                //  if (cc == "out")
                // {
                status2 = "punchinok";
                ret[0] = status2;
                ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                ret[2] = lokasi_semak;
                ret[3] = "OK";
                //}
                //else
                //{
                //   // status2 = "notok";
                //    ret[0] = "notok";  //status2;
                //    ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                //    ret[2] = lokasi_semak;
                //    ret[3] = "Sistem eTAP anda berstatus 'Kuning'. Tidak perlu berada di Kawasan Kampus UTeM";
                //    status2 = "Sistem eTAP anda berstatus 'Kuning'. Tidak perlu berada di Kawasan Kampus UTeM";

                //}
            }
            else
            {
                status2 = myresult;
                ret[0] = status2;
                ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                ret[2] = lokasi_semak;
                ret[3] = "GAGAL";
            }

            try
            {
                CommandText = "INSERT INTO  att04_attd_list_wfhstaff ( att04_status, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_jenis_transaksi, att04_poskod, att04_negara, Latitud,Longitud) values (@status, @app_id,@USERID,@MYDATE,@BGNID,@jenistransaksi,@myposkod,@mynegara,@lat1,@long1)";
                con = new SqlConnection(SQLAuth.dbase_dbmobile);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
                cmd.Parameters.AddWithValue("@app_id", '3');
                cmd.Parameters.AddWithValue("@BGNID", lokasi_semak);
                cmd.Parameters.AddWithValue("@jenistransaksi", jenistransaksi);
                cmd.Parameters.AddWithValue("@status", status2);
                cmd.Parameters.AddWithValue("@mynegara", mynegara);
                cmd.Parameters.AddWithValue("@myposkod", myposkod);
                cmd.Parameters.AddWithValue("@lat1", lat1);
                cmd.Parameters.AddWithValue("@long1", long1);
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

        public static IEnumerable<string> StudGateMasukipone(string userid, string app_Id, string jenisk, string lokasi, string lat1, string long1, string mynegara, string myposkod)
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
            if (cc == "out")
            {
            }
            else
            {
                lokasi_semak = cc;
            }
            // }

            myresult = WriteStudLocal_dbmob(userid, mydate, lokasi_semak, nama, Wiegand, SQLAuth.dbase_dbmobile, lat1, long1);
            if (myresult == "")
            {

                //  if (cc == "out")
                // {
                status2 = "punchinok";
                ret[0] = status2;
                ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                ret[2] = lokasi_semak;
                ret[3] = "OK";
                //}
                //else
                //{
                //   // status2 = "notok";
                //    ret[0] = "notok";  //status2;
                //    ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                //    ret[2] = lokasi_semak;
                //    ret[3] = "Sistem eTAP anda berstatus 'Kuning'. Tidak perlu berada di Kawasan Kampus UTeM";
                //    status2 = "Sistem eTAP anda berstatus 'Kuning'. Tidak perlu berada di Kawasan Kampus UTeM";

                //}
            }
            else
            {
                status2 = myresult;
                ret[0] = status2;
                ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                ret[2] = lokasi_semak;
                ret[3] = "GAGAL";
            }

            try
            {
                CommandText = "INSERT INTO  att04_stud_localiti ( att04_status, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_jenis_transaksi, att04_poskod, att04_negara, Latitud,Longitud) values (@status, @app_id,@USERID,@MYDATE,@BGNID,@jenistransaksi,@myposkod,@mynegara,@lat1,@long1)";
                con = new SqlConnection(SQLAuth.dbase_dbmobile);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
                cmd.Parameters.AddWithValue("@app_id", '3');
                cmd.Parameters.AddWithValue("@BGNID", lokasi_semak);
                cmd.Parameters.AddWithValue("@jenistransaksi", jenistransaksi);
                cmd.Parameters.AddWithValue("@status", status2);
                cmd.Parameters.AddWithValue("@mynegara", mynegara);
                cmd.Parameters.AddWithValue("@myposkod", myposkod);
                cmd.Parameters.AddWithValue("@lat1", lat1);
                cmd.Parameters.AddWithValue("@long1", long1);
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
        public static IEnumerable<string> StudGateMasuk(string userid, string app_Id, string jenisk, string lokasi, string lat1, string long1, string mynegara, string myposkod)
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
            if (cc == "out")
            {
            }
            else
            {
                lokasi_semak = cc;
            }
            // }

            myresult = WriteStudLocal_dbmob(userid, mydate, lokasi_semak, nama, Wiegand, SQLAuth.dbase_dbmobile, lat1, long1);
            if (myresult == "")
            {

                //  if (cc == "out")
                // {
                status2 = "punchinok";
                ret[0] = status2;
                ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                ret[2] = lokasi_semak;
                ret[3] = "OK";
                //}
                //else
                //{
                //   // status2 = "notok";
                //    ret[0] = "notok";  //status2;
                //    ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                //    ret[2] = lokasi_semak;
                //    ret[3] = "Sistem eTAP anda berstatus 'Kuning'. Tidak perlu berada di Kawasan Kampus UTeM";
                //    status2 = "Sistem eTAP anda berstatus 'Kuning'. Tidak perlu berada di Kawasan Kampus UTeM";

                //}
            }
            else
            {
                status2 = myresult;
                ret[0] = status2;
                ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                ret[2] = lokasi_semak;
                ret[3] = "GAGAL";
            }

            try
            {
                CommandText = "INSERT INTO  att04_stud_localiti ( att04_status, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_jenis_transaksi, att04_poskod, att04_negara, Latitud,Longitud) values (@status, @app_id,@USERID,@MYDATE,@BGNID,@jenistransaksi,@myposkod,@mynegara,@lat1,@long1)";
                con = new SqlConnection(SQLAuth.dbase_dbmobile);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
                cmd.Parameters.AddWithValue("@app_id", '3');
                cmd.Parameters.AddWithValue("@BGNID", lokasi_semak);
                cmd.Parameters.AddWithValue("@jenistransaksi", jenistransaksi);
                cmd.Parameters.AddWithValue("@status", status2);
                cmd.Parameters.AddWithValue("@mynegara", mynegara);
                cmd.Parameters.AddWithValue("@myposkod", myposkod);
                cmd.Parameters.AddWithValue("@lat1", lat1);
                cmd.Parameters.AddWithValue("@long1", long1);
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
        public static string WriteStudLocal_dbmob(string userid, DateTime mydate, string idbangunan, string mynamastaf, string Wiegand, string mycon, string Latitud, string Longitud)
        {
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(mycon))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {



                        cmd.CommandText = @"INSERT INTO  att_PerakamStudLocal (ID, TkhMasa, TrController, TrName, Wiegand, Latitud, Longitud) values (@USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand, @Latitud, @Longitud)";
                        cmd.Connection = sqlConn;

                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@MYDATE", mydate);
                        cmd.Parameters.AddWithValue("@BGNID", idbangunan);
                        cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                        cmd.Parameters.AddWithValue("@Wiegand", Wiegand);
                        cmd.Parameters.AddWithValue("@Latitud", Latitud);
                        cmd.Parameters.AddWithValue("@Longitud", Longitud);





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
            if (cc == "out")
            {
            }
            else
            {
                lokasi_semak = cc;
            }
            // }

            myresult = WriteDatatoDBStaf_dbmob(userid, mydate, lokasi_semak, nama, Wiegand, SQLAuth.dbase_dbmobile, lat1, long1);
            if (myresult == "")
            {
               
              //  if (cc == "out")
               // {
                    status2 = "punchinok";
                    ret[0] = status2;
                    ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                    ret[2] = lokasi_semak;
                    ret[3] = "OK";
                //}
                //else
                //{
                //   // status2 = "notok";
                //    ret[0] = "notok";  //status2;
                //    ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                //    ret[2] = lokasi_semak;
                //    ret[3] = "Sistem eTAP anda berstatus 'Kuning'. Tidak perlu berada di Kawasan Kampus UTeM";
                //    status2 = "Sistem eTAP anda berstatus 'Kuning'. Tidak perlu berada di Kawasan Kampus UTeM";

                //}
            }
            else
            {
                status2 = myresult;
                ret[0] = status2;
                ret[1] = mydate.ToString("yyyy-MM-dd HH:mm:ss");
                ret[2] = lokasi_semak;
                ret[3] = "GAGAL";
            }

            try
            {
                CommandText = "INSERT INTO  att04_attd_list_wfhstaff ( att04_status, att01_id, att04_userid, att04_timepunch, att04_bangunan_id, att04_jenis_transaksi) values (@status, @app_id,@USERID,@MYDATE,@BGNID,@jenistransaksi)";
                con = new SqlConnection(SQLAuth.dbase_dbmobile);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
                cmd.Parameters.AddWithValue("@app_id", '3');
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
        public static string WriteDatatoDBStaf_dbmob(string userid, DateTime mydate, string idbangunan, string mynamastaf, string Wiegand, string mycon, string Latitud, string Longitud)
        {
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(mycon))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {



                        cmd.CommandText = @"INSERT INTO  att_PerakamWFH (ID, TkhMasa, TrController, TrName, Wiegand, Latitud, Longitud) values (@USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand, @Latitud, @Longitud)";
                        cmd.Connection = sqlConn;

                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@MYDATE", mydate);
                        cmd.Parameters.AddWithValue("@BGNID", idbangunan);
                        cmd.Parameters.AddWithValue("@mynamastaf", mynamastaf);
                        cmd.Parameters.AddWithValue("@Wiegand", Wiegand);
                        cmd.Parameters.AddWithValue("@Latitud", Latitud);
                        cmd.Parameters.AddWithValue("@Longitud", Longitud);





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
        public static double DegreesToRadians(double angle)
        {
            return Math.PI * angle / 180.0;
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
                string CommandText = "SELECT  a.att04_bangunan_id,a.att04_jenis_transaksi, a.att04_status, a.att04_id, a.att01_id, a.att04_userid, convert(varchar,a.att04_timepunch, 13)  as mydatein ,  a.att04_datetime,  convert(varchar,a.att04_date, 103)  as mydate, a.att04_bangunan_id FROM att04_attd_list_wfhstaff as a where  a.att04_userid = @userid and a.att01_id = @app_id and cast(a.att04_date as date) = cast(getdate() as date)  order by a.att04_id asc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", '3');
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

        public static IEnumerable<string> GetListLogSatuStud(string userid, string app_Id)
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
                //  string CommandText = "SELECT  a.att04_bangunan_id,a.att04_jenis_transaksi, a.att04_status, a.att04_id, a.att01_id, a.att04_userid, convert(varchar,a.att04_timepunch, 13)  as mydatein ,  a.att04_datetime,  convert(varchar,a.att04_date, 103)  as mydate, a.att04_bangunan_id FROM att04_stud_localiti as a where  a.att04_userid = @userid and a.att01_id = @app_id and cast(a.att04_date as date) = cast(getdate() as date)  order by a.att04_id asc";
                string CommandText = "SELECT  a.att04_bangunan_id,a.att04_jenis_transaksi, a.att04_status, a.att04_id, a.att01_id, a.att04_userid, convert(varchar,a.att04_timepunch, 13)  as mydatein ,  a.att04_datetime,  convert(varchar,a.att04_date, 103)  as mydate, a.att04_bangunan_id FROM att04_stud_localiti as a ";
                CommandText = CommandText  + " where  a.att04_userid = @userid and a.att01_id = @app_id  and ";
                CommandText = CommandText + " ((cast(a.att04_date as date) = dateadd(day,datediff(day,0,GETDATE()),0)) or  ";
                CommandText = CommandText + "  (cast(a.att04_date as date) = dateadd(day,datediff(day,1,GETDATE()),0)) or  ";
                CommandText = CommandText + "  (cast(a.att04_date as date) = dateadd(day,datediff(day,2,GETDATE()),0)))  ";
                CommandText = CommandText + " order by a.att04_id asc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", '3');
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

        public static string StatusSihatStaff_html(string studid)
        {
            string msg = "1";
            String url = "https://pkp.utem.edu.my/papar.php?v=" + studid;
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            StreamReader sr = new StreamReader(response.GetResponseStream());
            string mm = sr.ReadToEnd();
            sr.Close();
            if (mm.ToString().Contains("STAF TIDAK DIBENARKAN HADIR KE UTeM"))
            {
                msg = "1"; // bole wfh
            }
            else{
                msg = "0"; // kena g opis
            }
            return msg;
        }
            public static string StatusSihatStaff(string studid)
        {
            String ConnectionString = "";
            string msg = "0";
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbstaf; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   SELECT TOP(200) SP02_NOSIRI, SP02_IDPENGUNDI, SP02_TAHUN, SP02_PC, SP02_ROSAK, SP02_EKSPORT, SP02_WAKTU, SP02_FAKULTI, SP02_UMUM
                //FROM            SP02_UNDI
                string CommandText = "SELECT     TOP (1) a.PKP02_NoStaf, a.PKP02_TkhHadir, CASE WHEN a.PKP02_StatusSaring = '1' THEN 'SIHAT' WHEN a.PKP02_StatusSaring = '2' THEN 'BERGEJALA' WHEN a.PKP02_StatusSaring = '3' THEN 'BERRISIKO' END AS KetSaring, b.MS01_Nama, d.JawGiliran, f.Pejabat ";
                            CommandText = CommandText + "FROM PKP02_SARINGANCOV19 AS a INNER JOIN ";
                            CommandText = CommandText + "MS01_Peribadi AS b ON a.PKP02_NoStaf = b.MS01_NoStaf AND b.MS01_Status = 1 INNER JOIN ";
                            CommandText = CommandText + "MS02_Perjawatan AS c ON b.MS01_NoStaf = c.MS01_NoStaf INNER JOIN ";
                            CommandText = CommandText + "MS_Jawatan AS d ON c.MS02_JawSandang = d.KodJawatan INNER JOIN ";
                            CommandText = CommandText + "MS08_Penempatan AS e ON b.MS01_NoStaf = e.MS01_NoStaf AND e.MS08_StaTerkini = 1 INNER JOIN ";
                            CommandText = CommandText + "MS_Pejabat AS f ON e.MS08_Pejabat = f.KodPejabat ";
                            CommandText = CommandText + "WHERE(a.PKP02_NoStaf = @id_class) AND(CAST(a.PKP02_TkhHadir AS date) = CAST(GETDATE() AS date)) ";
                            CommandText = CommandText + "ORDER BY a.PKP02_TkhHadir DESC ";
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@id_class", studid);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    msg = "1";
                }


            }
            catch (Exception)
            {
                msg = "0";
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return msg;

        }


        public static string StatusSihatStaff_m1(string studid)
        {
            String ConnectionString = "";
            string mystatus = "no";
            string msg = "0";
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbstaf; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   SELECT TOP(200) SP02_NOSIRI, SP02_IDPENGUNDI, SP02_TAHUN, SP02_PC, SP02_ROSAK, SP02_EKSPORT, SP02_WAKTU, SP02_FAKULTI, SP02_UMUM
                //FROM            SP02_UNDI
                string CommandText = "SELECT a.MS01_NoStaf, a.MS01_Nama,C.MS08_Pejabat ";
                CommandText = CommandText + "FROM MS01_Peribadi AS a INNER JOIN MS02_Perjawatan AS b ON a.MS01_NoStaf = b.MS01_NoStaf ";
                CommandText = CommandText + "INNER JOIN MS08_Penempatan AS c ON a.MS01_NoStaf = c.MS01_NoStaf INNER JOIN MS_Pejabat AS d ON c.MS08_Pejabat = d.KodPejabat ";
                CommandText = CommandText + "WHERE b.MS02_KumpJawatan = '1' AND c.MS08_StaTerkini = 1 and a.MS01_NoStaf = @id_class ";

                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@id_class", studid);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    msg = "1";
                }


            }
            catch (Exception)
            {
                msg = "0";
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }

            if (msg == "1")
            {
                try
                {
                    // Open connection to the database
                    ConnectionString = SQLAuth.dbase_dbstaf; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                    con = new SqlConnection(ConnectionString);
                    con.Open();

                    string CommandText = "select a.pkp02_nostaf, a.PKP02_TkhHadir, ";
                    CommandText = CommandText + "case when a.PKP02_StatusSaring = '1' then 'SIHAT' ";
                    CommandText = CommandText + "when a.PKP02_StatusSaring = '2' then 'BERGEJALA' ";
                    CommandText = CommandText + "when a.PKP02_StatusSaring = '3' then 'BERRISIKO' end as KetSaring, ";
                    CommandText = CommandText + "b.MS01_Nama, d.JawGiliran,f.Pejabat from PKP02_SARINGANCOV19 a inner join MS01_Peribadi b ";
                    CommandText = CommandText + "on a.PKP02_NoStaf = b.MS01_NoStaf  and b.ms01_status = 1 inner join MS02_Perjawatan c ";
                    CommandText = CommandText + "on b.MS01_NoStaf = c.MS01_NoStaf  inner join MS_Jawatan d ";
                    CommandText = CommandText + "on c.MS02_JawSandang = d.KodJawatan inner join MS08_Penempatan e ";
                    CommandText = CommandText + "on b.MS01_NoStaf = e.MS01_NoStaf and e.MS08_StaTerkini = 1 ";
                    CommandText = CommandText + "inner join MS_Pejabat f on e.MS08_Pejabat = f.KodPejabat where a.PKP02_NoStaf = @id_class ";
                    CommandText = CommandText + "and CAST(LEFT(a.PKP02_TkhHadir,11) AS DATETIME) = CAST(LEFT(GETDATE(), 11) AS DATETIME) ";

                    cmd = new SqlCommand(CommandText);
                    cmd.Parameters.AddWithValue("@id_class", studid);
                    cmd.Connection = con;
                    cmd.CommandText = CommandText;
                    rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        mystatus = rdr["KetSaring"].ToString().Trim(); //$row["KetSaring"];
                    }


                }
                catch (Exception)
                {
                    msg = "0";
                }
                finally
                {
                    if (rdr != null)
                        rdr.Close();

                    if (con.State == ConnectionState.Open)
                        con.Close();
                }


            }

            return mystatus;

        }

        public static string StatusSihatStaff_m2(string studid)
        {
            String ConnectionString = "";
            string mystatus = "no";
            string msg = "0";
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbstaf; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   SELECT TOP(200) SP02_NOSIRI, SP02_IDPENGUNDI, SP02_TAHUN, SP02_PC, SP02_ROSAK, SP02_EKSPORT, SP02_WAKTU, SP02_FAKULTI, SP02_UMUM
                //FROM            SP02_UNDI
                string CommandText = "SELECT MS01_NoStaf, PW17_TkhMula, PW17_Status FROM PW17_PKP WHERE MS01_NoStaf = @id_class AND CAST(LEFT(PW17_TkhMula,11) AS DATETIME) =  CAST(LEFT(GETDATE(),11) AS DATETIME) ";
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@id_class", studid);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    msg = "1";
                }


            }
            catch (Exception)
            {
                msg = "0";
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }

            if (msg == "1")
            {
                try
                {
                    // Open connection to the database
                    ConnectionString = SQLAuth.dbase_dbstaf; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                    con = new SqlConnection(ConnectionString);
                    con.Open();

                    string CommandText = "select a.pkp02_nostaf, a.PKP02_TkhHadir, ";
                    CommandText = CommandText + "case when a.PKP02_StatusSaring = '1' then 'SIHAT' ";
                    CommandText = CommandText + "when a.PKP02_StatusSaring = '2' then 'BERGEJALA' ";
                    CommandText = CommandText + "when a.PKP02_StatusSaring = '3' then 'BERRISIKO' end as KetSaring, ";
                    CommandText = CommandText + "b.MS01_Nama, d.JawGiliran,f.Pejabat, g.PW17_Status from PKP02_SARINGANCOV19 a inner join MS01_Peribadi b ";
                    CommandText = CommandText + "on a.PKP02_NoStaf = b.MS01_NoStaf  and b.ms01_status = 1 inner join pw17_pkp g on a.PKP02_NoStaf = g.MS01_NoStaf ";
                    CommandText = CommandText + "and CAST(LEFT(a.PKP02_TkhHadir,11) AS DATETIME) = CAST(LEFT(g.PW17_TkhMula, 11) AS DATETIME) ";
                    CommandText = CommandText + "inner join MS02_Perjawatan c ";
                    CommandText = CommandText + "on b.MS01_NoStaf = c.MS01_NoStaf  inner join MS_Jawatan d ";
                    CommandText = CommandText + "on c.MS02_JawSandang = d.KodJawatan inner join MS08_Penempatan e ";
                    CommandText = CommandText + "on b.MS01_NoStaf = e.MS01_NoStaf and e.MS08_StaTerkini = 1 ";
                    CommandText = CommandText + "inner join MS_Pejabat f on e.MS08_Pejabat = f.KodPejabat where a.PKP02_NoStaf = @id_class ";
                    CommandText = CommandText + "and CAST(LEFT(a.PKP02_TkhHadir,11) AS DATETIME) = CAST(LEFT(GETDATE(), 11) AS DATETIME) ";
                  
                 
                    cmd = new SqlCommand(CommandText);
                    cmd.Parameters.AddWithValue("@id_class", studid);
                    cmd.Connection = con;
                    cmd.CommandText = CommandText;
                    rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        mystatus = rdr["KetSaring"].ToString().Trim(); //$row["KetSaring"];
                    }


                }
                catch (Exception)
                {
                    msg = "0";
                }
                finally
                {
                    if (rdr != null)
                        rdr.Close();

                    if (con.State == ConnectionState.Open)
                        con.Close();
                }


            }

            return mystatus;

        }
        public static IEnumerable<string> GetStatusWFH(string user)
        {

            List<string> list = new List<string>();
           // if ((StatusSihatStaff_m1(user) == "SIHAT") && (StatusSihatStaff_m2(user) == "SIHAT"))
         //       if ( (StatusSihatStaff_m2(user) == "SIHAT"))
          //   {
                  //  list.Add("0");
          // }
           //  else
          //  {
                list.Add("1");
                //list.Add(StatusSihatStaff_html(user));
           // }
            //  list.Add("1");
           // if (user == "00578") {
           //     list.Add("0");

           // }
            //else
           // {
            //    list.Add(StatusSihatStaff(user));
            //}


            string[] arrayx = list.ToArray();
            return arrayx;

        }
        public static IEnumerable<string> GetStatusWFH_icon(string user)
        {

            List<string> list = new List<string>();

            list.Add("0");

            // list.Add(pilihanrayaicon(user));


            string[] arrayx = list.ToArray();
            return arrayx;

        }
    }
}