using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Device.Location;
using System.IO;
using System.Data;
using System.Net.NetworkInformation;

namespace WebApi
{
    public class SQLResearcher
    {
        // papar daily log kehadiran ra
        //att04_attd_list_user as a, ap04_pejabat_latitud as b
        //att04_attd_list_usergra as a, ap04_pejabat_latitud as b
        public static IEnumerable<string> GetListLogSatunew_ra(string userid, string app_Id)
        {
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT   a.att04_jenis_transaksi, a.att04_status, a.att04_id, a.att01_id, a.att04_userid, convert(varchar,a.att04_timepunch, 108)  as mydatein ,  a.att04_datetime,  convert(varchar,a.att04_date, 103)  as mydate, a.att04_bangunan_id FROM att04_attd_list_usergra as a where  a.att04_userid = @userid and a.att01_id = @app_id and cast(a.att04_date as date) = cast(getdate() as date)  order by a.att04_id asc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["mydate"].ToString()); 
                    myList.Add(rdr["mydatein"].ToString());
                    myList.Add(rdr["att04_jenis_transaksi"].ToString());
                //    myList.Add(rdr["att04_bangunan_id"].ToString());
                    if (rdr["att04_bangunan_id"].ToString() == "35")
                    {
                        myList.Add("KAMPUS INDUK");
                    }
                    else
                    {
                        myList.Add("KAMPUS TEKNOLOGI");
                    }
                    if (rdr["att04_status"].ToString() == "OK")
                    {
                        myList.Add("Y");
                    }
                    else
                    {
                        myList.Add("N");
                    }


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
            }

        }




        // att04_attd_list_usergra
        public static IEnumerable<string> GetInfo_ra(string userid, string app_Id, string jenis)
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
                con = new SqlConnection(SQLAuth.dbase_dbmobile);
                con.Open();
                string CommandText = "SELECT  att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_usergra where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime asc";

             //   string CommandText = "SELECT  att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_usergra where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime asc";
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
                    ret[1] = rdr["mydatein"].ToString();
                    if (rdr["att04_bangunan_id"].ToString() == "35")
                    {
                        ret[2] = "KAMPUS INDUK";
                    }
                    else
                    {
                        ret[2] = "KAMPUS TEKNOLOGI";
                    }
                    // khalid
                    //   ret[2] = SQLPerakamgeo.GetBangunanNama(rdr["att04_bangunan_id"].ToString()); 
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

        //MS21_PerakamWaktu as a, PW_Bangunan as b , MS01_Peribadi as c,  PW_Kampus as d
        public static Tuple<string, string, string, string, string, string, string[]> GetInfoBgnStaff_ra(string nostaf)
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
            if (mynamastaf == "") { mynamastaf = SQLPerakamgeo.findNamaStaf(nostaf); }
            return Tuple.Create(myidbangunan.ToString(), namabangunan, mylat.ToString(), mylong.ToString(), myrange.ToString(), mynamastaf, new string[] { idkampus, kodpengimbas, pengimbas });
        }

        public static Tuple<string, string, string, string, string, string, string> GetGeoCustomer2_ra(string nostaf, string lat, string longtitud)
        {
            string Status = "";

            var result = GetInfoBgnStaff_ra(nostaf);
            string idbngnan = result.Item1;
            string namabangunan = result.Item2;
            double mylat = Convert.ToDouble(result.Item3);
            double mylong = Convert.ToDouble(result.Item4);
            double myrange = Convert.ToDouble(result.Item5);
            string mynamastaf = result.Item6;
            string idkampus = result.Item7[0];
            string kodpengimbas = result.Item7[1];
            string pengimbas = result.Item7[2];
            // khalid ok
            double mydist = (SQLPerakamgeo.GPS_Distance(lat, longtitud, mylat, mylong) * 1000);
            if (mydist <= myrange)
            {
                Status = "ok";
            }
            else
            {
                Status = "notok"; 
            }

            return Tuple.Create(Status, mydist.ToString(), idbngnan, namabangunan, mynamastaf, idkampus, kodpengimbas);
        }
        public static Tuple<string, string, string, string, string, string, string> New_GetGeoCustomer2_ra(string nostaf, string lat, string longtitud)
        {
            string Status = "";

         //   var result = GetInfoBgnStaff_ra(nostaf);
            string idbngnan = "0";
            string namabangunan = "0";
            double mylat = Convert.ToDouble("0");
            double mylong = Convert.ToDouble("0");
            double myrange = Convert.ToDouble("0");
            string mynamastaf = "TEST ALI";
            string idkampus = "0";
            string kodpengimbas = "0";
          //  string pengimbas = "6";
            // khalid ok
            double mydist = (SQLPerakamgeo.GPS_Distance(lat, longtitud, 2.311594, 102.320385) * 1000);
            if (mydist <= 878)
            {
                Status = "ok";
                idbngnan = "35";
                idkampus = "35";
                namabangunan = "KAMPUS INDUK";
                kodpengimbas = "KAMPUS INDUK";
            }
            else
            {
                //Status = "notok";
                double mydist2 = (SQLPerakamgeo.GPS_Distance(lat, longtitud, 2.277924, 102.273908) * 1000);
                if (mydist <= 250)
                {
                    Status = "ok";
                    idbngnan = "36";
                    idkampus = "36";
                    namabangunan = "KAMPUS TEKNOLOGI";
                    kodpengimbas = "KAMPUS TEKNOLOGI";
                }
                else
                {
                    Status = "notok";
                    idbngnan = "0";
                    idkampus = "0";
                    namabangunan = "LUAR KAWASAN";
                }
            }

            return Tuple.Create(Status, mydist.ToString(), idbngnan, namabangunan, mynamastaf, idkampus, kodpengimbas);
        }
        public static IEnumerable<string> New_CheckOpenGateMasuk_ra(string userid, string app_Id, string lat1, string long1, string jenisk)
        {
            string myStr_SMSM = "Capaian ke database bermasalah. Sila cuba lagi";
            string stat_smsm = "";
            string status2 = "";
            var result = New_GetGeoCustomer2_ra(userid, lat1, long1);

            string myresult = "";
            string status = result.Item1;
            string dist = result.Item2;
            string idbangunan = result.Item3;
            string namabangunan = result.Item4;
            string myname = NameRA_ra(userid);
            string mynamastaf = ""; // NameRA_ra(userid); // result.Item5;
            if (myname == "0") {
                mynamastaf = SQLAuth.finddataok(userid, "nama", "");
            }
            else
            {
                mynamastaf = myname;
            }
           
            string idkampus = result.Item6;
            string kodpengimbas = result.Item7;
            string jenistransaksi = jenisk;
            string Wiegand = GetWeghang_ra(userid);
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
            String ConnectionString = SQLAuth.dbase_dbmobile;
            String ConnectionString2 = SQLAuth.dbase_dbresearcher_qa;
            if (status.Trim() == "ok")
            {
                //insert new
                myresult = WriteDatatoDBStaf_ra(userid, mydate, idbangunan, mynamastaf, Wiegand, ConnectionString2, idkampus, kodpengimbas);
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

                try
                {
                    CommandText = "INSERT INTO  att04_attd_list_usergra ( att04_status, att01_id, att04_userid,  att04_bangunan_id, att04_jenis_transaksi, att04_status_detail) values (@status, @app_id,@USERID,@BGNID,@jenistransaksi, @status2)";
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@USERID", userid);
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

                    CommandText = "INSERT INTO  att_VTranMindgra (ID,  TrController, TrName, Wiegand,PW14_Pengimbas, PW14_KodPengimbas, Status_Tran) values (@USERID,  @BGNID, @mynamastaf, @Wiegand,@pengimbas,@kodpengimbas,@stst_smsm)";
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@USERID", userid);
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
                ret[0] = "outrange";
                ret[1] = "-";
                ret[3] = "ANDA BERADA DI LUAR KAWASAN";
                ret[4] = "ANDA BERADA DI LUAR KAWASAN"; //"LUAR KAWASAN";
            }






            return ret;
        }
            public static IEnumerable<string> CheckOpenGateMasuk_ra(string userid, string app_Id, string lat1, string long1, string jenisk)
        {
            string myStr_SMSM = "Capaian ke database bermasalah. Sila cuba lagi";
            string stat_smsm = "";
            string status2 = "";
            var result = GetGeoCustomer2_ra("00944", lat1, long1);

            string myresult = "";
            string status = result.Item1;
            string dist = result.Item2;
            string idbangunan = result.Item3;
            string namabangunan = result.Item4;
            string mynamastaf = "test nama"; // result.Item5;
            string idkampus = result.Item6;
            string kodpengimbas = result.Item7;
            string jenistransaksi = jenisk;
            string Wiegand = "5555"; // GetWeghang_ra(userid);
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
            String ConnectionString = SQLAuth.dbase_dbmobile; 
            String ConnectionString2 = SQLAuth.dbase_dbresearcher_qa; 

            if (status.Trim() == "ok")
            {
                //insert new
                myresult = WriteDatatoDBStaf_ra(userid, mydate, idbangunan, mynamastaf, Wiegand, ConnectionString2, idkampus, kodpengimbas);
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

                try
                {
                    CommandText = "INSERT INTO  att04_attd_list_usergra ( att04_status, att01_id, att04_userid,  att04_bangunan_id, att04_jenis_transaksi, att04_status_detail) values (@status, @app_id,@USERID,@BGNID,@jenistransaksi, @status2)";
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@USERID", userid);
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

                    CommandText = "INSERT INTO  att_VTranMindgra (ID,  TrController, TrName, Wiegand,PW14_Pengimbas, PW14_KodPengimbas, Status_Tran) values (@USERID,  @BGNID, @mynamastaf, @Wiegand,@pengimbas,@kodpengimbas,@stst_smsm)";
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@USERID", userid);
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
                var res = LoopBangunan_ra(idbangunan, lat1, long1);
                if (res.Item2.Trim() == "")
                {
                    ret[0] = "outrange";
                    ret[1] = "-";
                    ret[3] = "ANDA BERADA DI LUAR KAWASAN";
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
                    myresult = WriteDatatoDBStaf_ra(userid, mydate, idbangunan, mynamastaf, Wiegand, ConnectionString2, res.Item4, res.Item3);
                    if (myresult == "")
                    {
                        stat_smsm = "0";
                    }
                    else
                    {
                        ret[0] = myStr_SMSM; 
                        ret[4] = myStr_SMSM;
                        stat_smsm = "1";
                    }

                    try
                    {
                        CommandText = "INSERT INTO  att04_attd_list_usergra ( att04_status, att01_id, att04_userid,  att04_bangunan_id, att04_jenis_transaksi, att04_status_detail) values (@status, @app_id,@USERID,@BGNID,@jenistransaksi, @status2)";
                        con = new SqlConnection(ConnectionString);
                        con.Open();
                        cmd = new SqlCommand(CommandText);
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@USERID", userid);
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

                        CommandText = "INSERT INTO  att_VTranMindgra (ID,  TrController, TrName, Wiegand,PW14_Pengimbas, PW14_KodPengimbas, Status_Tran) values (@USERID,  @BGNID, @mynamastaf, @Wiegand,@pengimbas,@kodpengimbas,@stst_smsm)";
                        con = new SqlConnection(ConnectionString);
                        con.Open();
                        cmd = new SqlCommand(CommandText);
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@USERID", userid);
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
                }
            }
            if (ret[0] == "")
            {
                ret[0] = "Rekod kedatangan tidak dapat direkodkan. Sistem mendapati anda menggunkan versi lama myUTeM.Sila download myUTeM versi baru di AppStore";
            }


            return ret;
        }
        public static string WriteDatatoDBStaf_ra(string userid, DateTime mydate, string idbangunan, string mynamastaf, string Wiegand, string mycon, string idkampus, string kodpengimbas)
        {
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            string CommandText = "";
            String ConnectionString = mycon; // SQLAuth.dbase_dbresearcher_qa; 

            string myStr = "";
            try
            {
                CommandText = "INSERT INTO PW14_TranMind(PW14_IdBaru, PW14_IdAsal, PW14_KodTraksaksi, PW14_SiteCode, PW14_CardCode, PW14_NoKad, PW14_TkhMasa, PW14_KodPengimbas, PW14_Nama, PW14_Wiegand, PW14_TkhSumber, PW14_Sumber, PW14_Pengimbas, PW14_Transaksi) values(@idbaru, @idasal, @kodtransaksi, @sitecode, @cardcode, @USERID, @MYDATE, @BGNID, @mynamastaf, @Wiegand, @MYDATE, @sumber, @pengimbas, @transaksi)";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
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

            if (myStr == "") { } else { myStr = WriteDatatoDBStaf_2round_ra(userid, mydate, idbangunan, mynamastaf, Wiegand, mycon); }
            return myStr;


        }

        public static string WriteDatatoDBStaf_2round_ra(string userid, DateTime mydate, string idbangunan, string mynamastaf, string Wiegand, string mycon)
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
                            myStr = e.Message; 
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                myStr = ex.Message; // "Capaian ke database bermasalah. Sila cuba lagi";
            }
            return myStr;
        }


        public static Tuple<string, string, string, string> LoopBangunan_ra(string idbangunan, string lat, string longtitud)
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
                String ConnectionString = SQLAuth.dbase_dbstaf;
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
                    double mydist = (SQLPerakamgeo.GPS_Distance(lat, longtitud, mylat, mylong) * 1000);
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
        public static IEnumerable<string> GetInfoBaru_ra(string userid, string app_Id, string jenis, string masa)
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

                string CommandText = "SELECT  att04_status, att04_id, att01_id, att04_userid, convert(varchar,att04_timepunch, 120)  as mydatein ,  att04_datetime,  convert(varchar,att04_date, 103)  as mydate, att04_bangunan_id FROM att04_attd_list_usergra where att04_userid = @userid and att01_id = @app_id and cast(att04_date as date) = cast(getdate() as date) and att04_jenis_transaksi = @jenis order by att04_datetime asc";
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
                    // if (masa == rdr["mydatein"].ToString())att04_bangunan_id
                    // {
                    mfound = "1";
                        ret[1] = rdr["mydatein"].ToString();
                    //      ret[3] = rdr["att04_bangunan_id"].ToString();  // SQLPerakamgeo.GetBangunanNama(rdr["att04_bangunan_id"].ToString()); //  rdr["att04_bangunan_id"].ToString();
                    if (rdr["att04_bangunan_id"].ToString() == "35")
                    {
                        ret[3] = "KAMPUS INDUK";
                    }
                    else
                    {
                        ret[3] = "KAMPUS TEKNOLOGI";
                    }

                    ret[4] = rdr["att04_status"].ToString();
                  //  }
                   // else
                   // {

                   // }
                }
                if (mfound == "1")
                {
                    ret[0] = "punchinok";


                }
                else { ret[0] = "x1CAPAIAN KE PANGKALAN DATA TIDAK BERJAYA. SILA TEKAN BUTANG KEMBALI DAN CUBA MEREKOD KEHADIRAN ANDA SEMULA. SILA RUJUK KEPADA FAQ UNTUK MAKLUMAT LANJUT"; }
            }
            catch (Exception)
            {
                ret[0] = "x2CAPAIAN KE PANGKALAN DATA TIDAK BERJAYA. SILA TEKAN BUTANG KEMBALI DAN CUBA MEREKOD KEHADIRAN ANDA SEMULA. SILA RUJUK KEPADA FAQ UNTUK MAKLUMAT LANJUT";
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
        public static IEnumerable<string> GetSMSMPerakam_ra(string userid, string tar, string tar2)
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
                String ConnectionString = SQLAuth.dbase_dbresearcher_qa;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT     PW01_ICRA,  PW01_CardSN, PW01_IdMasuk, PW01_TkhHadir, PW01_MsMasuk, PW01_IdKeluar, PW01_TkhKeluar, PW01_MsKeluar, PW01_Nota, PW01_SbbMasuk, PW01_SbbKeluar, PW01_Lewat,  ";
                CommandText = CommandText + "PW01_TerimaLwt, PW01_PengesahLwt, PW01_TkhSahLwt, PW01_BlkAwal, PW01_TerimaBlk, PW01_PengesahBlk, PW01_TkhSahBlk, PW01_KodPejabat, PW01_Status, PW01_KaunterMsk, PW01_KaunterKlr,  ";
                CommandText = CommandText + "PW01_TkhWujud, PW01_HName, PW01_MskLocality, PW01_TerimaMskLocality, PW01_KlrLocality, PW01_TerimaKlrLocality, PW01_SbbMskLocality, PW01_SbbKlrLocality, PW01_IdBangunanMsk,  ";
                CommandText = CommandText + "PW01_IdBangunanKlr ";
                CommandText = CommandText + "FROM            PW01_Hadir ";
                CommandText = CommandText + "WHERE(PW01_ICRA = @userid) AND(PW01_TkhHadir = CONVERT(DATETIME,  @Tkh, 102)) ";

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
        public static string GetWeghang_ra(string nostaf)
        {
            string mybol = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbresearcher_qa;
                con = new SqlConnection(ConnectionString);
                con.Open();
            //    string CommandText = "SELECT        CAST(FLOOR(CAST(MS01_CardSN AS bigint) / 65536) AS varchar) + ':' + CAST(MS01_CardSN - FLOOR(CAST(MS01_CardSN AS bigint) / 65536) * 65536 AS varchar) AS Wiegand FROM   V_GRA_RA WHERE(ICRA = @nostaf)";
                string CommandText = "SELECT        Wiegand FROM   V_GRA_RA WHERE (ICRA = @nostaf)";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nostaf", nostaf);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = "" + rdr["Wiegand"].ToString();

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

        public static string NameRA_ra(string nostaf)
        {
            string mybol = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbresearcher_qa;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT   NameRA, KpL, ICRA      FROM    MP06_RA WHERE  ICRA = @nostaf";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nostaf", nostaf);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["NameRA"].ToString();

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
        public static int UpdateRA(string userid, string mystatus)
        {
            int mybol = 0;
            try
            {
                SqlDataReader rdr = null;
                SqlConnection con = null;
                SqlCommand cmd = null;
                String ConnectionString = SQLAuth.dbase_dbclm;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "update       CLM_Pengguna set CLM_KodGRA = @mystatus WHERE CLM_loginID = @userid  ";

                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@mystatus", mystatus);
                cmd.Connection = con;

                mybol = cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                return mybol;

            }
            return mybol;
        }

        public static bool Valid_RAorNot(string nostaf)
        {
           bool mybol = false;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbresearcher_qa;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT   NameRA, KpL, ICRA      FROM    MP06_RA WHERE  ICRA = @nostaf";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nostaf", nostaf);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    // mybol = rdr["NameRA"].ToString();
                    mybol = true;
                    int xx =  UpdateRA(nostaf, "1");
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

            return mybol;
        }


        public static IEnumerable<string> GetListLogSatu_ra(string userid, string app_Id)
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
                string CommandText = "SELECT  b.ap04_nama_lokasi, a.att04_jenis_transaksi, a.att04_status, a.att04_id, a.att01_id, a.att04_userid, convert(varchar,a.att04_timepunch, 13)  as mydatein ,  a.att04_datetime,  convert(varchar,a.att04_date, 103)  as mydate, a.att04_bangunan_id, b.ap04_nama FROM att04_attd_list_usergra as a, ap04_pejabat_latitud as b where a.att04_bangunan_id=b.ap04_id and a.att04_userid = @userid and a.att01_id = @app_id and cast(a.att04_date as date) = cast(getdate() as date)  order by a.att04_id asc";

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
    }
}