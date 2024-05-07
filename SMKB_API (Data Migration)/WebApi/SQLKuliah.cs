using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Data;
namespace WebApi
{
    public class SQLKuliah
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
        public static IEnumerable<string> CheckOpenGate( string user, string app_Id, string myQR)
        {
            string CommandText = "";
            string myres = "";
            string mydatex = "";
            DateTime mydate = DateTime.Now;
            string[] ret = new string[7];
            ret[0] = "no";
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";

            CommandText = "SELECT      a.id_class, a.staff_no, a.kod_subject, a.start_time, a.end_time, a.qrcode, a.delay, a.nama_mp, a.sessi FROM std01_Class_Master as a  where  a.qrcode = @myQR";

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@mydate", mydate);
                    cmd.Parameters.AddWithValue("@app_id", app_Id);
                    cmd.Parameters.AddWithValue("@user", user);
                    cmd.Parameters.AddWithValue("@myQR", myQR);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                
                                if (CheckStudentList(user, reader["id_class"].ToString(), ConnectionString, ref mydatex) == true)
                                {
                                    ret[0] = "exist";
                                    ret[2] = mydatex.ToString();
                                }
                                else
                                {
                                    string codesubject = SQLKuliah.GetClassMaster(reader["id_class"].ToString());
                                    WriteDatatoStudentList(user, mydate, reader["id_class"].ToString(), GetName(user, "student"), "QR", ConnectionString, ref myres, reader["sessi"].ToString(), codesubject);

                                    //   WriteDatatoStudentList(user, mydate, reader["id_class"].ToString(), GetName(user, "student"), "QR", ConnectionString, ref myres);
                                    ret[0] = myres;
                                    ret[2] = mydate.ToString();
                                }
                                ret[1] = reader["id_class"].ToString();
                                
                                ret[3] = GetName(reader["staff_no"].ToString(),"staf");
                                ret[4] = reader["nama_mp"].ToString();
                                ret[5] = "OK";

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

        public static string GetClassMaster(string idclass)
        {
            string mybol = "-";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

                CommandText = "SELECT  id_class, staff_no, kod_subject, start_time, end_time, qrcode, delay, nama_mp, kursus, sessi, kategori, status_emel, start_date, start_hour, end_date, end_hour, total_hour FROM std01_Class_Master WHERE id_class = @nostaf";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nostaf", idclass);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["kod_subject"].ToString();

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

        public static bool CheckStudentList(string userid, string idclass, string mycon, ref string mdatex)
        {
            bool found = false;
            try
            {
                using (SqlConnection conn = new SqlConnection(mycon))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        string CommandText = "SELECT   id, id_class, Student_id, Time_in, Attd_Type, Student_Name  FROM std02_Student_List where Student_id = @userid and id_class=@idclass";
                        cmd.Connection = conn;
                        cmd.CommandText = CommandText;
                        cmd.Parameters.AddWithValue("@userid", userid);
                        cmd.Parameters.AddWithValue("@idclass", idclass);
                        try
                        {
                            conn.Open();
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    mdatex = reader["Time_in"].ToString();
                                    found = true;

                                }
                            }

                            conn.Close();
                        }
                        catch (SqlException e)
                        {
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }



            return found;
        }
        public static string WriteDatatoStudentList(string userid, DateTime mydate, string idclass, string studentname, string type, string mycon, ref string mresult, string sessi, string mkodsubject)
        {
            string myStr = "";
            mresult = "failedinsert";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(mycon))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"INSERT INTO  std02_Student_List (id_class, Student_id, Time_in, Attd_Type, Student_Name, kursus) values (@idclass, @USERID, @MYDATE, @type, @studentname, @kodkursus)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid.ToUpper());
                        cmd.Parameters.AddWithValue("@MYDATE", mydate);
                        cmd.Parameters.AddWithValue("@idclass", idclass);
                        cmd.Parameters.AddWithValue("@studentname", studentname);
                        cmd.Parameters.AddWithValue("@type", type);
                        cmd.Parameters.AddWithValue("@kodkursus", GetKursusPelajar(userid.ToUpper(), mkodsubject, sessi));

                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            mresult = "ok";
                        }
                        catch (SqlException e)
                        {
                            myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                            mresult = "failedinsert";
                        }



                    }
                }
            }
            catch (Exception ex)
            {
                myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                mresult = "failedinsert";
            }
            //  if (myStr == "") { } else { myStr = WriteDatatoDBStaf_2round(userid, mydate, idbangunan, mynamastaf, Wiegand, mycon); }
            return myStr;
        }
        public static string GetKursusPelajar(string studentid, string kodsubject, string sesi)
        {
            string mybol = "-";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "select distinct SMP11_KursusTawaR from SMP11_MPPelajar where SMP01_NOMATRIK=@nostudent and kodsesi_sem=@sesi and smp07_kodmp=@kodsubject ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nostudent", studentid);
                cmd.Parameters.AddWithValue("@sesi", sesi);
                cmd.Parameters.AddWithValue("@kodsubject", kodsubject);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["SMP11_KursusTawaR"].ToString();
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
        public static string WriteDatatoStudentListxxxx(string userid, DateTime mydate, string idclass, string studentname, string type, string mycon, ref string mresult)
        {
            string myStr = "";
            mresult = "failedinsert";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(mycon))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"INSERT INTO  std02_Student_List (id_class, Student_id, Time_in, Attd_Type, Student_Name) values (@idclass, @USERID, @MYDATE, @type, @studentname)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid.ToUpper());
                        cmd.Parameters.AddWithValue("@MYDATE", mydate);
                        cmd.Parameters.AddWithValue("@idclass", idclass);
                        cmd.Parameters.AddWithValue("@studentname", studentname);
                        cmd.Parameters.AddWithValue("@type", type);
                       
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            mresult = "ok";
                        }
                        catch (SqlException e)
                        {
                            myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                            mresult = "failedinsert";
                        }



                    }
                }
            }
            catch (Exception ex)
            {
                myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                mresult = "failedinsert";
            }
          //  if (myStr == "") { } else { myStr = WriteDatatoDBStaf_2round(userid, mydate, idbangunan, mynamastaf, Wiegand, mycon); }
            return myStr;
        }

        public static string GetName(string nostaf, string jenis)
        {
            string mybol = "-";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbeqcas;
                con = new SqlConnection(ConnectionString);
                con.Open();
                if (jenis == "staf")
                {
                    CommandText = "SELECT  displayname  FROM  live_user_staf  WHERE   att15 = @nostaf";
                }
                else
                {
                    CommandText = "SELECT  displayname  FROM  live_user  WHERE   att15 = @nostaf";

                }
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nostaf", nostaf);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["displayname"].ToString();

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

        public static IEnumerable<string> GetListLogSatuKuliah(string userid, DateTime mydate)
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
                string CommandText = "SELECT   c.staff_no, c.nama_mp, a.id, a.id_class, a.Student_id, a.Time_in, a.Attd_Type, a.Student_Name FROM std02_Student_List as a,   std01_Class_Master as c  where c.id_class = a.id_class    and a.Student_id = @userid  and cast(a.Time_in as date) = @mdate  order by a.id asc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@mdate", mydate);

                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    vv = GetName(rdr["staff_no"].ToString(), "staf");
                    myList.Add(rdr["Time_in"].ToString());
                    myList.Add(vv);
                    //  myList.Add(rdr["ap04_nama"].ToString());
                    myList.Add(rdr["nama_mp"].ToString() + " ID:" + rdr["id_class"].ToString());
                    myList.Add(rdr["Attd_Type"].ToString());


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
        //     SELECT DISTINCT A.SMP07_KodMP, B.SMP07_NamaMP, SMP20_NOStaf, SMP21_kursus FROM SMP21_PensyarahMP A

        //INNER JOIN SMP07_Matapelajaran B ON A.SMP07_KodMP = B.SMP07_KodMP

        //WHERE SMP21_Sesi = '1-2018/2019'

        //AND SMP20_NoStaf = '00079'


        public static IEnumerable<string> GetListSubject(string userid)
        {
            //  string[,] twoDimensional;
            //  twoDimensional = new string[1, 4];
            string sessi = SessiAktif();
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
               // string CommandText = "SELECT DISTINCT A.SMP07_KodMP, B.SMP07_NamaMP, SMP20_NOStaf, SMP21_kursus FROM SMP21_PensyarahMP A INNER JOIN SMP07_Matapelajaran B ON A.SMP07_KodMP = B.SMP07_KodMP WHERE A.SMP21_Sesi = @sessi AND A.SMP20_NoStaf = @userid";
                string CommandText = "SELECT DISTINCT A.SMP07_KodMP, B.SMP07_NamaMP, SMP20_NOStaf, A.SMP21_Sesi,   (' | SESI:'+  A.SMP21_Sesi + ' | KOD:'+  A.SMP07_KodMP +' | NAMA:'+  B.SMP07_NamaMP) as CombinedTeam, ( A.SMP07_KodMP  +'|'+  A.SMP21_Sesi + '|'+  B.SMP07_NamaMP) as CombinedTeamIndex  FROM SMP21_PensyarahMP A INNER JOIN SMP07_Matapelajaran B ON A.SMP07_KodMP = B.SMP07_KodMP WHERE  " + sessi + " AND A.SMP20_NoStaf = @userid";



                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sessi", sessi);

                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["SMP07_KodMP"].ToString());
                  //  myList.Add(rdr["SMP07_NamaMP"].ToString());
                    myList.Add(rdr["CombinedTeam"].ToString());
                    myList.Add(rdr["SMP07_NamaMP"].ToString().Replace("&", " ").Replace("/", " "));
                    myList.Add(rdr["SMP21_Sesi"].ToString().Replace("/", "x"));



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


        public static IEnumerable<string> GetListSubjectyy(string userid)
        {
            //  string[,] twoDimensional;
            //  twoDimensional = new string[1, 4];
            string sessi = SessiAktif();
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT DISTINCT A.SMP07_KodMP, B.SMP07_NamaMP, SMP20_NOStaf, SMP21_kursus FROM SMP21_PensyarahMP A INNER JOIN SMP07_Matapelajaran B ON A.SMP07_KodMP = B.SMP07_KodMP WHERE A.SMP21_Sesi = @sessi AND A.SMP20_NoStaf = @userid";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sessi", sessi);

                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["SMP07_KodMP"].ToString());
                    myList.Add(rdr["SMP07_NamaMP"].ToString());
                    myList.Add(rdr["SMP21_kursus"].ToString());
                    myList.Add("-");



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
        public static IEnumerable<string> GetListSubjectxx(string userid)
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
                string CommandText = "SELECT     subject_id, subject_desc FROM std03_subject ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);

                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                     myList.Add(rdr["subject_id"].ToString());
                     myList.Add(rdr["subject_desc"].ToString());
                    myList.Add("-");
                    myList.Add("-");



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

        public static IEnumerable<string> CheckClassExist(string user, DateTime startuser, DateTime enduser, string idclas1, string idclas2, string kursus, string nama_mp, string Kategori)
        {
            DateTime mydate = DateTime.Now;
            string myres = "";
            string[] ret = new string[7];
            ret[0] = "no";

            if (CheckKuliahKonflik(user, startuser, enduser, idclas1, idclas2, kursus, nama_mp, Kategori))
            {
                ret[0] = "Kuliah sudah wujud";
            }
            else
            {
                WriteDatatoKuliah(user, startuser, enduser, idclas1, idclas2, ref myres, kursus, nama_mp, Kategori);
                ret[0] = myres;
            }







            return ret;
        }
        public static bool CheckKuliahKonflik(string user, DateTime startuser, DateTime enduser, string idclas1, string idclas2, string kursus, string nama_mp, string Kategori)
        {
            bool found = false;
            try
            {
                using (SqlConnection conn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        // string CommandText = "SELECT     id_class, staff_no, kod_subject, start_time, end_time, qrcode, delay FROM std01_Class_Master where staff_no=@user and ( (@startuser BETWEEN start_time AND end_time) or (@enduser BETWEEN start_time AND end_time))";
                        //   string CommandText = "SELECT     id_class, staff_no, kod_subject, start_time, end_time, qrcode, delay FROM std01_Class_Master where staff_no=@user and kursus=@kursus and ( (@startuser BETWEEN start_time AND end_time) or (@enduser BETWEEN start_time AND end_time))";
                        string CommandText = "SELECT     id_class, staff_no, kod_subject, start_time, end_time, qrcode, delay FROM std01_Class_Master where staff_no=@user and ( (@startuser BETWEEN start_time AND end_time) or (@enduser BETWEEN start_time AND end_time))";

                        cmd.Connection = conn;
                        cmd.CommandText = CommandText;
                        cmd.Parameters.AddWithValue("@user", user);
                        cmd.Parameters.AddWithValue("@startuser", startuser);
                        cmd.Parameters.AddWithValue("@enduser", enduser);
                        cmd.Parameters.AddWithValue("@idclas1", idclas1);
                        cmd.Parameters.AddWithValue("@idclas2", idclas2);
                        cmd.Parameters.AddWithValue("@kursus", kursus);
                        try
                        {
                            conn.Open();
                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    found = true;
                                }
                            }

                            conn.Close();
                        }
                        catch (SqlException e)
                        {
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }



            return found;
        }

        public static string WriteDatatoKuliah(string user, DateTime startuser, DateTime enduser, string idclas1, string idclas2, ref string mresult, string kursus, string nama_mp, string Kategori)
        {
            string startuser2 = "";
            string enduser2 = "";
            DateTime startuser3;
            DateTime enduser3;
            string start_date = "";
            string start_hour = "";
            start_date = startuser.ToString("yyyy-MM-dd");
            start_hour = startuser.ToString("HH") + "00";

            string end_date = "";
            string end_hour = "";
            end_date = enduser.ToString("yyyy-MM-dd");
            end_hour = enduser.ToString("HH") + "00";


            startuser2 = startuser.ToString("yyyy-MM-dd HH") + ":00:00";
            enduser2 = enduser.ToString("yyyy-MM-dd HH") + ":00:00";
            startuser3 = Convert.ToDateTime(startuser2);
            enduser3 = Convert.ToDateTime(enduser2);
            string myStr = "";
            string mystudent = "";
            string sessi = kursus; // SessiAktif();

            double diff = (enduser3 - startuser3).TotalHours;


            mresult = "Gagal menghubungi database";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        //cmd.CommandText = @"INSERT INTO  std01_Class_Master (staff_no, kod_subject, start_time, end_time, qrcode) values (@user, @idclas1, @startuser, @enduser, @qrcode)";

                        cmd.CommandText = @"INSERT INTO std01_Class_Master                         (staff_no, kod_subject, qrcode, start_time, end_time, nama_mp, kursus, sessi, kategori,start_date,start_hour,end_date,end_hour,total_hour) VALUES(@user, @idclas1, @qrcode, @startuser, @enduser, @nama_mp, @kursus, @sessi, @kategori, @start_date, @start_hour, @end_date, @end_hour, @total_hour)";


                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@user", user);
                        cmd.Parameters.AddWithValue("@startuser", startuser3);
                        cmd.Parameters.AddWithValue("@enduser", enduser3);
                        cmd.Parameters.AddWithValue("@idclas1", idclas1);
                        cmd.Parameters.AddWithValue("@idclas2", idclas1);
                        cmd.Parameters.AddWithValue("@qrcode", "x");
                        cmd.Parameters.AddWithValue("@nama_mp", nama_mp);
                        cmd.Parameters.AddWithValue("@kursus", "");
                        cmd.Parameters.AddWithValue("@sessi", sessi);
                        cmd.Parameters.AddWithValue("@kategori", Kategori);

                        cmd.Parameters.AddWithValue("@start_date", start_date);
                        cmd.Parameters.AddWithValue("@start_hour", start_hour);
                        cmd.Parameters.AddWithValue("@end_date", end_date);
                        cmd.Parameters.AddWithValue("@end_hour", end_hour);
                        cmd.Parameters.AddWithValue("@total_hour", diff);







                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            string myidNew = GetLastIDClass(user);
                            //  mystudent = WriteDatatoKuliah_dbstudent(user, startuser3, enduser3, idclas1, nama_mp, kursus, sessi, Kategori, start_date, start_hour, end_date, end_hour, diff);
                            mystudent = WriteDatatoKuliah_dbstudent(user, startuser3, enduser3, idclas1, nama_mp, "", sessi, Kategori, start_date, start_hour, end_date, end_hour, diff, myidNew);
                            UpdateClassSub(user, idclas1, sessi, myidNew);
                            mresult = "ok";
                        }
                        catch (SqlException e)
                        {
                            myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                            mresult = enduser.ToString(); //"failedinsert2";
                        }



                    }
                }
            }
            catch (Exception ex)
            {
                myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                mresult = "failedinsert3";
            }
            //  if (myStr == "") { } else { myStr = WriteDatatoDBStaf_2round(userid, mydate, idbangunan, mynamastaf, Wiegand, mycon); }
            //  mresult = startuser.ToString();
            return myStr;
        }
        public static void UpdateClassSub(string userid, string classid, string sesi, string myidNew)
        {
            string yy = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT DISTINCT SMP21_Kursus FROM SMP21_PensyarahMP​ WHERE(SMP20_NoStaf = @userid) AND(SMP21_Sesi = @sesi) AND(SMP07_KodMP = @classid)​ ORDER BY SMP21_Kursus";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@classid", classid);
                cmd.Parameters.AddWithValue("@sesi", sesi);

                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    yy = WriteDatatokursus_dbmobile(myidNew, rdr["SMP21_Kursus"].ToString(), SQLAuth.dbase_dbmobile);
                    yy = WriteDatatokursus_dbmobile(myidNew, rdr["SMP21_Kursus"].ToString(), SQLAuth.dbase_dbstudent);
                    //  yy = WriteDatatokursus_dbmobile(classid, rdr["SMP21_Kursus"].ToString(), SQLAuth.dbase_dbstudent);


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

            //  SELECT DISTINCT SMP21_Kursus FROM            SMP21_PensyarahMP​ WHERE(SMP20_NoStaf = N'01885') AND(SMP21_Sesi = N'2-2018/2019') AND(SMP07_KodMP = N'BKKP1741')​ ORDER BY SMP21_Kursus
            // WriteDatatokursus_dbmobile(string classid, string kursus, string mycon)
        }
        public static string WriteDatatoKuliah_dbstudent(string user, DateTime startuser3, DateTime enduser3, string idclas1, string nama_mp, string kursus, string sessi, string kategori, string start_date, string start_hour, string end_date, string end_hour, double diff, string myidNew)
        {
            string mresult = "";
            string myStr = "";
            mresult = "Gagal menghubungi database";
            try
            {
                using (SqlConnection sqlConn2 = new SqlConnection(SQLAuth.dbase_dbstudent))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"INSERT INTO SMP_Class_Master   ( id_class, staff_no, kod_subject, qrcode, start_time, end_time, nama_mp, kursus, sessi, kategori,start_date,start_hour,end_date,end_hour,total_hour) VALUES(@id_class, @user, @idclas1, @qrcode, @startuser, @enduser, @nama_mp, @kursus, @sessi, @kategori, @start_date, @start_hour, @end_date, @end_hour, @total_hour)";

                        cmd.Connection = sqlConn2;
                        //   string hh = GetLastIDClass(user);
                        cmd.Parameters.AddWithValue("@id_class", myidNew);
                        cmd.Parameters.AddWithValue("@user", user);
                        cmd.Parameters.AddWithValue("@startuser", startuser3);
                        cmd.Parameters.AddWithValue("@enduser", enduser3);
                        cmd.Parameters.AddWithValue("@idclas1", idclas1);
                        cmd.Parameters.AddWithValue("@idclas2", idclas1);
                        cmd.Parameters.AddWithValue("@qrcode", "x");
                        cmd.Parameters.AddWithValue("@nama_mp", nama_mp);
                        cmd.Parameters.AddWithValue("@kursus", kursus);
                        cmd.Parameters.AddWithValue("@sessi", sessi);
                        cmd.Parameters.AddWithValue("@kategori", kategori);

                        cmd.Parameters.AddWithValue("@start_date", start_date);
                        cmd.Parameters.AddWithValue("@start_hour", start_hour);
                        cmd.Parameters.AddWithValue("@end_date", end_date);
                        cmd.Parameters.AddWithValue("@end_hour", end_hour);
                        cmd.Parameters.AddWithValue("@total_hour", diff);


                        try
                        {
                            sqlConn2.Open();
                            cmd.ExecuteNonQuery();
                            mresult = "ok";
                        }
                        catch (SqlException e)
                        {
                            myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                            mresult = "Capaian ke database bermasalah. Sila cuba lagi";  //"failedinsert2";
                        }



                    }
                }
            }
            catch (Exception ex)
            {
                myStr = "Capaian ke database bermasalah. Sila cuba lagi";
                mresult = "failedinsert3";
            }

            return myStr;
        }

        public static string WriteDatatokursus_dbmobile(string classid, string kursus, string mycon)
        {
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn2 = new SqlConnection(mycon))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        //   std03_Class_Sub
                        cmd.CommandText = @"INSERT INTO std03_Class_Sub   ( id_class, kursus) VALUES (@id_class, @kursus)";

                        cmd.Connection = sqlConn2;
                        cmd.Parameters.AddWithValue("@id_class", classid);
                        cmd.Parameters.AddWithValue("@kursus", kursus);
                        try
                        {
                            sqlConn2.Open();
                            cmd.ExecuteNonQuery();
                            myStr = "ok";
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



        public static IEnumerable<string> GetListLecurerKuliah(string userid)
        {
            //  string[,] twoDimensional;
            //  twoDimensional = new string[1, 4];
          //  userid = "00971";
            DateTime mydate = DateTime.Now;
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
              //  string CommandText = "SELECT   c.staff_no, b.subject_desc, a.id, a.id_class, a.Student_id, a.Time_in, a.Attd_Type, a.Student_Name FROM std02_Student_List as a, std03_subject as b,  std01_Class_Master as c  where c.id_class = a.id_class  and    b.subject_id = c.kod_subject   and a.Student_id = @userid  and cast(a.Time_in as date) = cast(getdate() as date)  order by a.id asc";
              //  string CommandText = "SELECT       b.subject_desc, a.id_class, a.staff_no, a.kod_subject, a.start_time, a.end_time, a.qrcode, a.delay FROM std01_Class_Master as a,  std03_subject as b where a.kod_subject=b.subject_id and a.staff_no=@userid and (@mydate <= a.start_time or @mydate <= a.end_time) ";
                string CommandText = "SELECT       a.nama_mp, a.id_class, a.staff_no, a.kod_subject, a.start_time, a.end_time, a.qrcode, a.delay FROM std01_Class_Master as a   where  a.staff_no=@userid and (@mydate <= a.start_time or @mydate <= a.end_time) ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@mydate", mydate);

                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    vv = GetName(rdr["staff_no"].ToString(), "staf");
                    myList.Add(rdr["start_time"].ToString() + " " + rdr["end_time"].ToString());
                    myList.Add(vv);
                    //  myList.Add(rdr["ap04_nama"].ToString());
                    myList.Add(" ID:" + rdr["id_class"].ToString());
                    myList.Add(rdr["nama_mp"].ToString());


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

        //HapusLecurerKuliah
        public static IEnumerable<string> HapusLecurerKuliah(string user, string idclas1)
        {
            DateTime mydate = DateTime.Now;
            string myres = "";
            string[] ret = new string[7];
            ret[0] = "no";
            if (idclas1 == "") { }
            else
            {
              
                ret[0] = HapusKuliah(idclas1);
                string xx = HapusSubKuliah(idclas1);
                xx = HapusSubKuliah_dbstudent(idclas1);
                string xy = HapusListStudentClass(idclas1);
                xy = HapusListStudentClass_dbstudent(idclas1);// SMP93_KehadiranPl dbstudent

            }
            //if (CheckKuliahKonflik(user, startuser, enduser, idclas1, idclas2))
            //{
            //    ret[0] = "exist";
            //}
            //else
            //{
            //    WriteDatatoKuliah(user, startuser, enduser, idclas1, idclas2, ref myres);
            //    ret[0] = myres;
            //}







            return ret;
        }

        public static string HapusListStudentClass_dbstudent(string idclas1)
        {
            string myStr = "failetodelete";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbstudent))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        //cmd.CommandText = @"INSERT INTO  std01_Class_Master (staff_no, kod_subject, start_time, end_time, qrcode) values (@user, @idclas1, @startuser, @enduser, @qrcode)";

                        cmd.CommandText = @"delete from    SMP93_KehadiranPl where Classroom_Code =  @idclas1";


                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@idclas1", idclas1);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            //  string myhapus = HapusKuliah_dbstudent(idclas1);
                            myStr = "ok";
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

        public static string HapusSubKuliah_dbstudent(string idclas1)
        {
            string myStr = "failetodelete";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbstudent))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        //cmd.CommandText = @"INSERT INTO  std01_Class_Master (staff_no, kod_subject, start_time, end_time, qrcode) values (@user, @idclas1, @startuser, @enduser, @qrcode)";

                        cmd.CommandText = @"delete from   std03_Class_Sub    where id_class =  @idclas1";


                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@idclas1", idclas1);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            //  string myhapus = HapusKuliah_dbstudent(idclas1);
                            myStr = "ok";
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
        public static string HapusListStudentClass(string idclas1)
        {
            string myStr = "failetodelete";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        //cmd.CommandText = @"INSERT INTO  std01_Class_Master (staff_no, kod_subject, start_time, end_time, qrcode) values (@user, @idclas1, @startuser, @enduser, @qrcode)";

                        cmd.CommandText = @"delete from    std02_Student_List    where id_class =  @idclas1";


                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@idclas1", idclas1);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            //  string myhapus = HapusKuliah_dbstudent(idclas1);
                            myStr = "ok";
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
        public static string HapusSubKuliah(string idclas1)
        {
            string myStr = "failetodelete";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        //cmd.CommandText = @"INSERT INTO  std01_Class_Master (staff_no, kod_subject, start_time, end_time, qrcode) values (@user, @idclas1, @startuser, @enduser, @qrcode)";

                        cmd.CommandText = @"delete from   std03_Class_Sub    where id_class =  @idclas1";


                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@idclas1", idclas1);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                          //  string myhapus = HapusKuliah_dbstudent(idclas1);
                            myStr = "ok";
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

        public static string HapusKuliah(string idclas1)
        {
            string myStr = "failetodelete";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        //cmd.CommandText = @"INSERT INTO  std01_Class_Master (staff_no, kod_subject, start_time, end_time, qrcode) values (@user, @idclas1, @startuser, @enduser, @qrcode)";

                        cmd.CommandText = @"delete from  std01_Class_Master    where id_class =  @idclas1";


                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@idclas1", idclas1);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            string myhapus = HapusKuliah_dbstudent(idclas1);
                            myStr = "ok";
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

        public static string HapusKuliah_dbstudent(string idclas1)
        {
            string myStr = "failetodelete";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbstudent))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        //cmd.CommandText = @"INSERT INTO  std01_Class_Master (staff_no, kod_subject, start_time, end_time, qrcode) values (@user, @idclas1, @startuser, @enduser, @qrcode)";

                        cmd.CommandText = @"delete from  SMP_Class_Master    where id_class =  @idclas1";


                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@idclas1", idclas1);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            myStr = "ok";
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

        public static string SessiAktif()
        {
            string mybol = "-";
            int cnt = 0;
            string mystr = "";
            string mystrx = "";
            string mystry = "";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "select KodSesi_Sem from SMP_SesiPengajian where stat_skrg=1 ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
             //   cmd.Parameters.AddWithValue("@nostaf", "nostaf");
                rdr = cmd.ExecuteReader();
                mystrx = "(";
                mystry = ")";
                while (rdr.Read())
                {
                    // mybol = rdr["KodSesi_Sem"].ToString();
                    //if (cnt >= 1)
                    //{
                    //    mystr = mystr + " OR  (A.SMP21_Sesi = '" + rdr["KodSesi_Sem"].ToString() + "') ";
                    //}
                    //else
                    //{
                    //    mystr = mystr + "  (A.SMP21_Sesi = '" + rdr["KodSesi_Sem"].ToString() + "') ";
                    //}
                    //cnt = cnt + 1;
                    mystr = rdr["KodSesi_Sem"].ToString().Trim();
                    break;

                }
              //  mystr = mystrx + mystr + mystry;

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

            return mystr;
        }



        public static string SessiAktifxx()
        {
            string mybol = "-";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "select KodSesi_Sem from SMP_SesiPengajian where stat_skrg=1 ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nostaf", "nostaf");
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["KodSesi_Sem"].ToString();

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
        public static string GetLastIDClass(string user)
        {
            string mybol = "0";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "SELECT        TOP (1) id_class FROM std01_Class_Master where staff_no=@nostaf order by id_class desc";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nostaf", user);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["id_class"].ToString();

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

        public static void UpdateClassSubx(string userid, string classid, string sesi, string myidNew)
        {
            string yy = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT DISTINCT SMP21_Kursus FROM SMP21_PensyarahMP​ WHERE(SMP20_NoStaf = @userid) AND(SMP21_Sesi = @sesi) AND(SMP07_KodMP = @classid)​ ORDER BY SMP21_Kursus";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@classid", classid);
                cmd.Parameters.AddWithValue("@sesi", sesi);

                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    yy = WriteDatatokursus_dbmobile(myidNew, rdr["SMP21_Kursus"].ToString(), SQLAuth.dbase_dbmobile);
                    //  yy = WriteDatatokursus_dbmobile(classid, rdr["SMP21_Kursus"].ToString(), SQLAuth.dbase_dbstudent);


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

            //  SELECT DISTINCT SMP21_Kursus FROM            SMP21_PensyarahMP​ WHERE(SMP20_NoStaf = N'01885') AND(SMP21_Sesi = N'2-2018/2019') AND(SMP07_KodMP = N'BKKP1741')​ ORDER BY SMP21_Kursus
            // WriteDatatokursus_dbmobile(string classid, string kursus, string mycon)
        }
        public static string WriteDatatokursus_dbmobilex(string classid, string kursus, string mycon)
        {
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn2 = new SqlConnection(mycon))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"INSERT INTO std03_Class_Sub   ( id_class, kursus) VALUES (@id_class, @kursus)";

                        cmd.Connection = sqlConn2;
                        cmd.Parameters.AddWithValue("@id_class", classid);
                        cmd.Parameters.AddWithValue("@kursus", kursus);
                        try
                        {
                            sqlConn2.Open();
                            cmd.ExecuteNonQuery();
                            myStr = "ok";
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
        public static IEnumerable<string> GetmTAC(string user)
        {
            string[] ret = new string[7];
            ret[0] = "-";
            try
            {

                ret[0] = UpdatemTAC(user);
            }
            catch (Exception)
            {
                
            }
            return ret;
        }
        private static string UpdatemTAC(string userid)
        {
            string mybol = "-";
            string CommandText = "";
            String ConnectionString = "";  //SQLAuth.dbase_dbmobile;
            DateTime xx = DateTime.Now;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            int mnum = 99;
            mnum = GetRndNumber();
            var Timestamp = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds();
            ConnectionString =  SQLAuth.dbase_dbmobile;
            try
            {
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "update   AspNetUsers set Tac=@Tac, Tac_Date = GetDate() where Email =@USERID";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@Tac", mnum.ToString());
                //  cmd.Parameters.AddWithValue("@LOGINDATE", xx);

                rdr = cmd.ExecuteReader();
                mybol = mnum.ToString();
            }
            catch (Exception )
            {
                mybol = "-";
            }
            return mybol;
        }
        private static int GetRndNumber()
        {

            Random random = new Random();
            int randomNumber = random.Next(1000, 9999);
            return randomNumber;
        }
    }
}