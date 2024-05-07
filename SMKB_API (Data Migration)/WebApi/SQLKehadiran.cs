using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
namespace WebApi
{
    public class SQLKehadiran
    {
        private static bool QrCodeValid(string qrcode, string jenis)
        {
            bool mybol = false;
            string CommandText = "";
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            if (jenis == "masuk")
            {
                CommandText = "select top 1  att01_id, ap01_id, att01_name, att01_status, att01_start_checkin, att01_end_checkin, att01_start_checkout, att01_end_checkout, att01_audience, att01_qr_in, att01_qr_out from att01_attd_system  where ap01_id = 1 and att01_qr_in=@mydate";
            }
            else
            {
                CommandText = "select top 1  att01_id, ap01_id, att01_name, att01_status, att01_start_checkin, att01_end_checkin, att01_start_checkout, att01_end_checkout, att01_audience, att01_qr_in, att01_qr_out from att01_attd_system  where ap01_id = 1 and att01_qr_out=@mydate";
            }
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@mydate", qrcode);
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
        private static bool CheckAppidinuse(string userid, string jenis, string app_Id, string mob_Id)
        {
            bool mybol = false;
            string CommandText = "";
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            CommandText = "SELECT  att02_id, att01_id, att02_userid FROM att02_attd_list_user where (att02_appid_in=@mob_id or att02_appid_out=@mob_id) and  (att01_id=@app_id) and (att02_userid <> @mydate)";
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@mydate", userid);
                    cmd.Parameters.AddWithValue("@app_id", app_Id);
                    cmd.Parameters.AddWithValue("@mob_id", mob_Id);
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
        private static bool boleproceddkeluar(string userid, string Qr_code, string jenis, string app_Id, string mob_Id)
        {
            bool mybol = false; 
            string CommandText = "";
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            CommandText = "SELECT   att02_id, att01_id, att02_userid, att02_timein, att02_timeout, att02_datetime, att02_appid_in, att02_appid_out FROM att02_attd_list_user where (att02_appid_in = '0' or att02_appid_in =@mob_Id)  and  att01_id=@app_id and att02_userid=@mydate";
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@mydate", userid);
                    cmd.Parameters.AddWithValue("@app_id", app_Id);
                    cmd.Parameters.AddWithValue("@mob_Id", mob_Id);
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
        private static bool Userexist(string userid, string app_Id)
        {
            bool mybol = false;
            string CommandText = "";
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            CommandText = "SELECT  att02_id, att01_id, att02_userid, att02_timein, att02_timeout, att02_datetime, att02_appid_in, att02_appid_out FROM att02_attd_list_user where att01_id=@app_id and att02_userid=@mydate";
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@mydate", userid);
                    cmd.Parameters.AddWithValue("@app_id", app_Id);
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
        private static string myUpdateData(string userid, string jenis, string app_Id, string mob_Id)
        {
            string mybol = "";
            string CommandText = "";
            DateTime xx = DateTime.Now;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            var Timestamp = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds();
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            //  att01_id, att02_userid, att02_timein, att02_timeout, 
            con = new SqlConnection(ConnectionString);
            con.Open();
            if (jenis == "masuk")
            {
                CommandText = "update  att02_attd_list_user set att02_appid_in=@mob_id, att02_timein=@LOGINDATE where att02_userid=@USERID and att01_id=@app_id ";
            }
            else
            {
                CommandText = "update  att02_attd_list_user set att02_appid_out=@mob_id, att02_timeout=@LOGINDATE where att02_userid=@USERID and att01_id=@app_id ";
            }
            cmd = new SqlCommand(CommandText);
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@USERID", userid);
            cmd.Parameters.AddWithValue("@LOGINDATE", xx);
            cmd.Parameters.AddWithValue("@app_id", app_Id);
            cmd.Parameters.AddWithValue("@mob_id", mob_Id);
            //   cmd.Parameters.Add(new SqlParameter("@USERID", System.Data.SqlDbType.NVarChar, 256, "USERID"));  // The name of the source column
            //  cmd.Parameters["@USERID"].Value = userid;
            //  cmd.Parameters.Add(new SqlParameter("@LOGINDATE", System.Data.SqlDbType.DateTime));  // The name of the source column
            //  cmd.Parameters["@LOGINDATE"].Value = DateTime.Now;
            rdr = cmd.ExecuteReader();
            mybol = xx.ToString();
            return mybol;
        }
        private static string myInsertData(string userid, string jenis, string app_Id, string mob_Id)
        {
            string mybol = "";
            string CommandText = "";
            DateTime xx = DateTime.Now;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            var Timestamp = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds();
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            //  att01_id, att02_userid, att02_timein, att02_timeout, 
            con = new SqlConnection(ConnectionString);
            con.Open();
            if (jenis == "masuk")
            {
                CommandText = "INSERT INTO  att02_attd_list_user ( att01_id, att02_userid, att02_timein, att02_appid_in) values (@app_id,@USERID,@LOGINDATE, @mob_id)";
            }
            else
            {
                CommandText = "INSERT INTO  att02_attd_list_user ( att01_id, att02_userid, att02_timeout, att02_appid_out) values (@app_id,@USERID,@LOGINDATE, @mob_id)";
            }
            cmd = new SqlCommand(CommandText);
            cmd.Connection = con;
            cmd.Parameters.AddWithValue("@USERID", userid);
            cmd.Parameters.AddWithValue("@LOGINDATE", xx);
            cmd.Parameters.AddWithValue("@app_id", app_Id);
            cmd.Parameters.AddWithValue("@mob_id", mob_Id);
            //   cmd.Parameters.Add(new SqlParameter("@USERID", System.Data.SqlDbType.NVarChar, 256, "USERID"));  // The name of the source column
            //  cmd.Parameters["@USERID"].Value = userid;
            //  cmd.Parameters.Add(new SqlParameter("@LOGINDATE", System.Data.SqlDbType.DateTime));  // The name of the source column
            //  cmd.Parameters["@LOGINDATE"].Value = DateTime.Now;
            rdr = cmd.ExecuteReader();
            mybol = xx.ToString();

            return mybol;
        }
        public static IEnumerable<string> ProcessInsertUpdateRecord(string userid, string Qr_code, string jenis, string app_Id, string mob_Id)
        {
            string[] ret = new string[2];
            if (CheckAppidinuse(userid, jenis, app_Id, mob_Id) == true)
            {

                ret[0] = "inuse";
            }
            else
            {
                if (QrCodeValid(Qr_code, jenis) == true)
                {
                    ret[0] = "valid";
                    if (Userexist(userid, app_Id) == true)
                    {
                        // update
                        if (jenis == "masuk")
                        {
                            ret[1] = myUpdateData(userid, jenis, app_Id, mob_Id);
                        }
                        else
                        {
                            if (boleproceddkeluar(userid, Qr_code, jenis, app_Id,  mob_Id) == true)
                            {
                                
                                ret[1] = myUpdateData(userid, jenis, app_Id, mob_Id);
                            }
                            else
                            {
                                ret[0] = "phoneidnotsame";
                            }
                        }
                    }
                    else
                    {
                        if (jenis == "masuk")
                        {
                            // insert rec
                            ret[1] = myInsertData(userid, jenis, app_Id, mob_Id);
                        }
                        else
                        {
                            if (boleproceddkeluar(userid, Qr_code, jenis, app_Id, mob_Id) == true)
                            {
                                ret[1] = myUpdateData(userid, jenis, app_Id, mob_Id); 
                            }
                            else
                            {
                                ret[0] = "phoneidnotsame";
                            }
                        }
                    }
                }
                else
                {
                    //Qr_code not valid
                    ret[0] = "invalid";
                }

            }

            return ret;
        }
        public static IEnumerable<string> CheckAttdRecord(string userid, string app_Id)
        {
            string CommandText = "";
            DateTime mydate = DateTime.Now;
            string[] ret = new string[2];
            ret[0] = " Tiada ";
            ret[1] = " Tiada ";
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            CommandText = "SELECT    att02_id, att01_id, att02_userid, att02_timein, att02_timeout, att02_datetime, att02_appid_in, att02_appid_out FROM att02_attd_list_user where att01_id=@app_id and  att02_userid=@mydate";
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@mydate", userid);
                    cmd.Parameters.AddWithValue("@app_id", app_Id);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                ret[0] = reader["att02_timein"].ToString();
                                ret[1] = reader["att02_timeout"].ToString();
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

            return ret;
        }
        public static IEnumerable<string> CheckOpenGate(string jenis, string app_Id)
        {
            string CommandText = "";
            DateTime mydate = DateTime.Now;
            string[] ret = new string[4];
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
     
    }
}