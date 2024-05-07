using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;


using System.Data;
namespace WebApi
{
    public class SQLPerakam
    {

        public static IEnumerable<string> GetInfo(string userid, string app_Id)
        {
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
                string CommandText = "SELECT  att03_id, att01_id, att03_userid, convert(varchar,att03_timein, 13)  as mydatein , convert(varchar,att03_timeout, 13)  as mydateout , att03_datetime,  convert(varchar,att03_date, 103)  as mydate FROM att03_attd_list_user where att03_userid = @userid and att01_id = @app_id and cast(att03_date as date) = cast(getdate() as date) ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "found";
                    ret[1] = rdr["mydatein"].ToString();
                    ret[2] = rdr["mydateout"].ToString();
                    ret[3] = rdr["mydate"].ToString();
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
        private static bool IsRecordexist(string userid, string app_Id)
        {
            bool mybol = false;
            DateTime mydate = DateTime.Now;
            string CommandText = "";
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            CommandText = "SELECT  att03_id, att01_id, att03_userid, att03_timein, att03_timeout, att03_datetime, att03_date FROM att03_attd_list_user where att03_userid = @userid and att01_id = @app_id and cast(att03_date as date) = cast(getdate() as date) ";
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@mydate", mydate);
                    cmd.Parameters.AddWithValue("@userid", userid);
                    cmd.Parameters.AddWithValue("@app_id", app_Id);
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
        public static IEnumerable<string> UpdateEmptyBiometric(string studid, string id_client)
        {

            string[] ret = new string[2];
            ret[0] = "ok";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"update AspNetUsers  set biometric_id=''  where biometric_id=@id_client and Email <> @studid";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@studid", studid);
                        cmd.Parameters.AddWithValue("@id_client", id_client);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            ret[0] = "no";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = "no";
            }
            return ret;

          

        }

        public static IEnumerable<string> UpdateBiometric(string studid, string id_client)
        {
            string[] ret = new string[2];
            ret[0] = "ok";

            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"update AspNetUsers  set biometric_id=''  where biometric_id=@id_client";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@studid", studid);
                        cmd.Parameters.AddWithValue("@id_client", id_client);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            ret[0] = "no";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = "no";
            }



            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"update AspNetUsers  set biometric_id=@id_client  where Email=@studid";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@studid", studid);
                        cmd.Parameters.AddWithValue("@id_client", id_client);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            ret[0] = "no";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = "no";
            }
            return ret;



        }

        //public static IEnumerable<string> UpdateBio(string id_user, string id_client)
        //{
        //    List<string> list = new List<string>();
        //    try
        //    {
        //        using (SqlConnection sqlConn2 = new SqlConnection(SQLAuth.dbase_dbmobile))
        //        {
        //            using (SqlCommand cmd = new SqlCommand())
        //            {
        //                    cmd.CommandText = @"INSERT INTO  spr03_kawasan   (  studentid, calonpilihan) VALUES(@id_class, @id_class2)";
        //                    cmd.Connection = sqlConn2;
        //                    cmd.Parameters.AddWithValue("@id_user", id_user);
        //                    cmd.Parameters.AddWithValue("@id_client", id_client);
        //                    try
        //                    {
        //                        sqlConn2.Open();
        //                        cmd.ExecuteNonQuery();
        //                        list.Add("ok");
        //                    }
        //                    catch (SqlException e)
        //                    {
        //                        list.Add("Capaian ke database bermasalah. Sila cuba lagi");
        //                    }
        //                }


        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        list.Add("Capaian ke database bermasalah. Sila cuba lagi");
        //    }

        //    string[] arrayx = list.ToArray();
        //    return arrayx;

        //}
        public static IEnumerable<string> GetBio(string userid, string clientid)
        {
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[7];
            ret[0] = "notfound";
            try
            {
                // Open connection to the database
                // String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                String ConnectionString = SQLAuth.dbase_dbmobile;

                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT  biometric_id, biometric_flag   FROM AspNetUsers WHERE  Email=@userid and biometric_id=@biometric";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@biometric", clientid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "found";
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

        public static IEnumerable<string> GetPublicData(string userid)
        {
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[7];
            ret[0] = "notfound";
            try
            {
                // Open connection to the database
               // String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                String ConnectionString = SQLAuth.dbase_dbeqcas;

                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT    rec_id, brg_id, pt_id, sn, qty, makmal_id, HT_no, Invoice_no, Remarks FROM f_brg_rec WHERE brg_id=@userid";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "found";
                    ret[1] = rdr["pt_id"].ToString();
                    ret[2] = rdr["sn"].ToString();
                    ret[3] = rdr["makmal_id"].ToString();
                    ret[4] = rdr["HT_no"].ToString();
                    ret[5] = rdr["Invoice_no"].ToString();
                    ret[6] = rdr["Remarks"].ToString();

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


        public static IEnumerable<string> CheckOpenGateMasuk(string userid, string app_Id)
        {
            string clientAddress = "empty";
            clientAddress = GetCustomerIP(); // HttpContext.Current.Request.UserHostAddress;
            string CommandText = "";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            DateTime mydate = DateTime.Now;
            string[] ret = new string[4];
            ret[0] = "no";
            if (clientAddress.Trim() == "10.1.2.10")
            {

                    //not exist insert new
                    String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                    CommandText = "INSERT INTO  att03_attd_list_user ( att01_id, att03_userid, att03_timein) values (@app_id,@USERID,@MYDATE)";
                    con = new SqlConnection(ConnectionString);
                    con.Open();

                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@USERID", userid);
                    cmd.Parameters.AddWithValue("@MYDATE", mydate);
                    cmd.Parameters.AddWithValue("@app_id", app_Id);


                    rdr = cmd.ExecuteReader();
                    ret[0] = "punchinok";
                    ret[1] = mydate.ToString();
              
            }
            else
            {
                ret[0] = "notwifiutem";
            }
            return ret;
        }
       
        public static string GetCustomerIP()
        {


            string CustomerIP = "";


            if (HttpContext.Current.Request.ServerVariables["HTTP_VIA"] != null)


            {


                CustomerIP = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"].ToString();


            }


            else


            {


                CustomerIP = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"].ToString();


            }


            return CustomerIP;


        }
    }
}