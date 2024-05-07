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


using System.Net;
using System.DirectoryServices.ActiveDirectory;
using static WebApi.Controllers.PublicwController;




//using System.DirectoryServices.AccountManagement;
namespace WebApi
{

    class SQLAuth
    {
        public static string dbase_dbclm = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='dbclm';User ID='oas';Password='oas*pwd'";
        public static string dbase_dbstaf = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
        public static string dbase_dbeqcas = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='eqcas';User ID='oas';Password='oas*pwd'";
        public static string dbase_dbmobile = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
        public static string dbase_dbstudent = @"Data Source='V-SQL13.utem.edu.my\SQL_INS03';Initial Catalog='DBstudent';User ID='oas';Password='oas*pwd'";
        public static string dbase_dbresearcher = @"Data Source='V-SQL12.utem.edu.my\SQL_INS02';Initial Catalog='DbUnicRnd';User ID='smkb';Password='smkb*pwd'";
        public static string dbase_dbpilihanraya = @"Data Source='V-SQL13.utem.edu.my\SQL_INS03';Initial Catalog='DBPilihanraya';User ID='smp';Password='#utem07pksmp'";
        public static string dbase_dbstudentpsh = @"Data Source='V-SQL13.utem.edu.my\SQL_INS03';Initial Catalog='DbStudentPSH';User ID='smp';Password='#utem07pksmp'";
        public static string dbase_dbpilihansenat = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbSenat';User ID='smp';Password='#utem07pksmp'";
        public static string dbase_dbspku = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='dbspku';User ID='MobApp';Password='m0bile@pp2018'";
        public static string dbase_devclm= @"Data Source='qa14.utem.edu.my';Initial Catalog='DBclm';User ID='smp';Password='#utem07pksmp'";
        public static string dbase_developer = @"Data Source='devstudent.utem.edu.my';Initial Catalog='DbDeveloper';User ID='mobdev';Password='MobDev@Student22'";
        public static string dbase_dbresearcher_qa = @"Data Source='V-SQL12.utem.edu.my\SQL_INS02';Initial Catalog='DbUnicRnd';User ID='smkb';Password='smkb*pwd'";
        // azmi
        public static string dbase_dbsmkbbaru = @"Data Source='devmis12.utem.edu.my';Initial Catalog='dbKewanganV4';User ID='Smkb';Password='Smkb@Dev2012'";
        public static string dbase_dbsmkbV12 = @"Data Source='v-sql12.utem.edu.my\SQL_INS02';Initial Catalog='dbKewangan';User ID='Smkb';Password='smkb*pwd'";

        public static int rnd_seed = 327680;



        //   SQLsmkb.DisposeTicket(myticket, "smkb");
        //          if (SQLsmkb.Check_ValidTicket(myticket, "smkb") == "yes")
        public static string Check_ValidTicketTest(string myid, string mymodule, ref string userid)
        {
            string CommandText = "";
            string mstatus = "no";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

                CommandText = "SELECT   id, TicketId, module, userid  FROM            AspNetInstantTicket  ";
                CommandText = CommandText + " where  TicketId = @myid  and module=@mymodule";


                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@myid", myid);
                cmd.Parameters.AddWithValue("@mymodule", mymodule);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mstatus = "yes";
                    userid = rdr["userid"].ToString();
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
            if (mstatus == "yes")
            {
                DisposeTicket(myid, mymodule);
            }
            return mstatus;
        }

        public static string Check_ValidTicket(string myid, string mymodule, ref string userid)
        {
            string CommandText = "";
            string mstatus = "no";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();
               
                    CommandText = "SELECT   id, TicketId, module, userid FROM            AspNetInstantTicket  ";
                     CommandText = CommandText + " where  TicketId = @myid  and module=@mymodule";

               
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@myid", myid);
                cmd.Parameters.AddWithValue("@mymodule", mymodule);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mstatus = "yes";
                    userid = rdr["userid"].ToString();
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
            if (mstatus == "yes")
            {
                DisposeTicket(myid, mymodule);
            }
            return mstatus;
        }

        public static string DisposeTicket(string myid2, string mymodule)
        {
            string myStr = "";
            DateTime mydate = DateTime.Now;
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        Random rnd = new Random();
                        int myrnd = rnd.Next(100000, 10000000);
                        cmd.CommandText = @"delete from    AspNetInstantTicket      where   TicketId = @myid2  and module=@mymodule";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@myid2", myid2);
                        cmd.Parameters.AddWithValue("@mymodule", mymodule);

                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();


                        }
                        catch (SqlException e)
                        {
                            myStr = e.Message; // "Capaian ke database bermasalah. Sila cuba lagi";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                myStr = ex.Message; //"Capaian ke database bermasalah. Sila cuba lagi";
            }
            return myStr;
        }


        public static bool sqlvalidateUser(string user, string password)
        {
            bool mybol = false;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbclm; // @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='dbclm';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT CLM_loginID FROM dbo.CLM_Pengguna WHERE CLM_loginID = @CLM_loginID ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 20, "CLM_loginID"));  // The name of the source column
                cmd.Parameters["@CLM_loginID"].Value = user;
                cmd.Parameters.Add(new SqlParameter("@CLM_StatusPG", System.Data.SqlDbType.NVarChar, 20, "CLM_StatusPG"));  // The name of the source column
                cmd.Parameters["@CLM_StatusPG"].Value = user;
                // Execute the query
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = true;
                    //   lbFound.Items.Add(rdr["FirstName"].ToString() +
                    //    " " + rdr["LastName"].ToString());
                }
            }
            catch (Exception )
            {
                // Print error message
            }
            finally
            {
                // Close data reader object and database connection
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }
            return mybol;
        }

        //    PrincipalContext thisPrincipalContext =
        //new PrincipalContext(ContextType.Domain, "ESTAGIOIT");
        //    or

        //    PrincipalContext thisPrincipalContext = 
        //new PrincipalContext(ContextType.Domain, null);  // default domain
        //    or

        //    PrincipalContext thisPrincipalContext = 
        //new PrincipalContext(ContextType.Domain, "ESTAGIOIT", "DC=estagioit,DC=local");
        //    or

        //    PrincipalContext thisPrincipalContext = 
        //new PrincipalContext(ContextType.Domain, null, "CN=Users,DC=estagioit,DC=local");
        public static bool sqlvalidateUser2_caralama(string user, string password)
        {
            bool valid = false;
            try
            {
                using (PrincipalContext context = new PrincipalContext(ContextType.Domain))
                {
                    valid = context.ValidateCredentials(user, password);
                }
                if (valid == true) { }
                else
                {
                    if (sqlvalidateUserCLM(user, password) == true)
                    {
                        valid = true;
                    }
                }

            }
            catch (Exception e)
            {
                if (valid == true) { }
                else
                {
                    if (sqlvalidateUserCLM(user, password) == true)
                    {
                        valid = true;
                    }
                }

            }


          //  if (valid == false) { valid = sqlvalidateUser2_caralama(user, password); }
   
            return valid;

        }

        public static bool sqlvalidateUser2(string user, string passwordx)
        {
            bool valid = false;
            string passwordss = "";
            string passwordss24 = passwordx.Substring(3, passwordx.Length - 8) + "==";
           string passwordss44 = passwordx.Substring(3, passwordx.Length - 8) + "=";
            string passwordss64 = passwordx.Substring(3, passwordx.Length - 8);
            if (passwordss24.Length == 24)
            {
                passwordss = passwordss24;
            }
            else if (passwordss44.Length == 44)
            {
                passwordss = passwordss44;
            }
            else
            {
                passwordss = passwordss64;
            }
            string password = AESEncrytDecry.DecryptStringAES_notuser(passwordss,user);
            if ((password == "error"))
            {

            }
            else
            {
                if (user.ToString().Contains("pd"))
                {
                    try
                    {
                        if (sqlvalidateUserCLM(user, password) == true)
                        {
                            valid = true;
                        }

                        if (valid == true) { }
                        else
                        {
                            using (PrincipalContext context = new PrincipalContext(ContextType.Domain))
                            {
                                valid = context.ValidateCredentials(user, password);
                            }
                        }

                    }
                    catch (Exception e)
                    {

                    }
                }
                else   if (
                    (user.ToString().Contains("d")) ||
                    (user.ToString().Contains("b")) ||
                    (user.ToString().Contains("bs")) ||
                    (user.ToString().Contains("m")) ||
                    (user.ToString().Contains("p"))
                    )
                {
                    // student only
                    try
                    {
                        if (sqlvalidateUserCLM(user, password) == true)
                        {
                            valid = true;
                           // string mystr = SQLPerakamgeo.reset24Hrs(user);
                        }
                      //  valid = true;
                    }
                    catch (Exception)
                    {
                    }
                }
                else
                {
                    try
                    {
                        if (sqlvalidateUserCLM(user, password) == true)
                        {
                            valid = true;
                        }

                        if (valid == true) { }
                        else
                        {
                            using (PrincipalContext context = new PrincipalContext(ContextType.Domain))
                            {
                                valid = context.ValidateCredentials(user, password);
                            }
                        }

                    }
                    catch (Exception e)
                    {
                        
                    }
                }
            }

            //////// test pi;ihanraya
            //if (valid == false)
            //{

            //    if ((user.ToUpper().Trim() == "B031810230") || (user.ToUpper().Trim() == "B051720049") || (user.ToUpper().Trim() == "BS01181003") || (user.ToUpper().Trim() == "D031810326"))
            //    {

            //        if (getPwD(password) == "dPdPlP") //52Syue90!
            //        {
            //            updatephonenumber_notmyutem(user, "1");
            //            valid = true;
            //        }
            //    }

            //}
            //else
            //{
            //    if ((user.ToUpper().Trim() == "B031810230") || (user.ToUpper().Trim() == "B051720049") || (user.ToUpper().Trim() == "BS01181003") || (user.ToUpper().Trim() == "D031810326"))
            //    {
            //        updatephonenumber_notmyutem(user, "0");
            //    }
            //}
            //////// end test pi;ihanraya





            if (valid == false) { valid = sqlvalidateUser2_caralama(user, passwordx); }
            ////////
           
            ////////
            ///

           // if (user == "00035"){ string vv = SQLAuth.UpdateAttributeStafNew(user); }
            // string mystr = SQLPerakamgeo.reset24Hrs("all");
          // if (valid == true) { string mystr = SQLPerakamgeo.reset24Hrs(user); }
            return valid;
        }

        //public static bool sqlvalidateUser2_backup(string user, string password)
        //{
        //    bool valid = false;

        //    return valid;
        //}


        //public static bool sqlvalidateUser2xxy(string user, string password)
        //{
        //    try
        //    {

        //        using (DirectoryEntry de = new DirectoryEntry("LDAP://utem.edu/CN=Users,DC=utem,DC=edu",
        //                              "staff" + "\\" + AESEncrytDecry.DecryptStringAES(user), password,
        //                               AuthenticationTypes.Secure))
        //        {
        //            return de.NativeObject != null;
        //        }
        //    }
        //    catch (Exception e)
        //    {
        //        Console.WriteLine(e);
        //        return false;
        //    }
        //}
        public static bool sqlvalidateUserCLM_dev(string user, string password)
        {

            bool mybol = false;
            string mypass = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_devclm;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT CLM_loginID,CLM_loginPWD FROM dbo.CLM_Pengguna WHERE CLM_loginPWD = @CLM_loginPass and  CLM_loginID = @CLM_loginID and (clm_tahap = 'STAF' or clm_tahap = 'PELAJAR' or clm_tahap = 'PELAJAR SISWAZAH' or clm_tahap = 'AHLI PENYELIDIK' or   clm_tahap = 'PENGURUS PORTAL'  or clm_tahap = 'PENTADBIR PORTAL'  or clm_tahap = 'AHLI PORTAL') ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@CLM_loginID", user);
                // if (user == "00578")
                //  {
                //    
                //   cmd.Parameters.AddWithValue("@CLM_loginPass", getPwD("Firebird##170674"));
                //  }
                //  else
                //  {
                cmd.Parameters.AddWithValue("@CLM_loginPass", getPwD(password));
                //  }
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mypass = rdr["CLM_loginID"].ToString().Trim();

                }
                if (mypass == "")
                {

                }
                else
                {
                    // if (mypass == getPwD(password))
                    //{
                    mybol = true;
                    //}
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
        public static bool sqlvalidateUserCLM(string user, string password)
        {

            bool mybol = false;
            string mypass = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbclm; 
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT CLM_loginID,CLM_loginPWD FROM dbo.CLM_Pengguna WHERE CLM_loginPWD = @CLM_loginPass and  CLM_loginID = @CLM_loginID and (clm_tahap = 'STAF' or clm_tahap = 'PELAJAR' or clm_tahap = 'PELAJAR SISWAZAH' or clm_tahap = 'AHLI PENYELIDIK' or   clm_tahap = 'PENGURUS PORTAL'  or clm_tahap = 'PENTADBIR PORTAL'  or clm_tahap = 'AHLI PORTAL') ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@CLM_loginID", user);
               // if (user == "00578")
              //  {
               //    
                 //   cmd.Parameters.AddWithValue("@CLM_loginPass", getPwD("Firebird##170674"));
              //  }
              //  else
              //  {
                    cmd.Parameters.AddWithValue("@CLM_loginPass", getPwD(password));
              //  }
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mypass = rdr["CLM_loginID"].ToString().Trim();

                }
                if ( mypass == "")
                {

                }
                else
                {
                   // if (mypass == getPwD(password))
                    //{
                        mybol = true;
                    //}
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

        public static string sqlCheckGRA_Nama(string user)
        {

            string nama = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbclm;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT CLM_loginID,CLM_unama,CLM_tahap FROM dbo.CLM_Pengguna WHERE CLM_loginID = @CLM_loginID ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@CLM_loginID", user);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    nama = rdr["CLM_unama"].ToString();

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

            return nama;



        }

        public static IEnumerable<string> sqlCheckGRA(string user)
        {
            //  if ((myListx[2] == "AHLI PORTAL") || (myListx[2] == "AHLI PENYELIDIK") )
            string[] ret = new string[3];
            ret[0] = "no";
            if (SQLResearcher.Valid_RAorNot(user) == true)
            {

                SqlDataReader rdr = null;
                SqlConnection con = null;
                SqlCommand cmd = null;
                try
                {
                    // Open connection to the database
                    String ConnectionString = SQLAuth.dbase_dbclm;
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    string CommandText = "SELECT CLM_loginID,CLM_unama,CLM_tahap FROM dbo.CLM_Pengguna WHERE CLM_loginID = @CLM_loginID and CLM_KodGRA = 1 ";
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@CLM_loginID", user);
                    rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        ret[0] = rdr["CLM_loginID"].ToString();
                        ret[1] = rdr["CLM_unama"].ToString();
                        ret[2] = rdr["CLM_tahap"].ToString();

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
            }
            else
            {

            }
            return ret;



        }



        public static string finddataok(string user, string jenis, string pass)
        {
            string mybol ="yyxx";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
          //  string myEmail;
           // string myNama;
           // string myDepartment;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbclm; // @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='dbclm';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT CLM_loginID,CLM_unama  FROM dbo.CLM_Pengguna WHERE CLM_loginID = @CLM_loginID  ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 20, "CLM_loginID"));  // The name of the source column
                cmd.Parameters["@CLM_loginID"].Value = user;
               // cmd.Parameters.Add(new SqlParameter("@CLM_StatusPG", System.Data.SqlDbType.NVarChar, 20, "CLM_StatusPG"));  // The name of the source column
               // cmd.Parameters["@CLM_StatusPG"].Value = password;
                // Execute the query
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    // myEmail = rdr["emailaddress"].ToString();
                      if (jenis == "nama") { mybol = rdr["CLM_unama"].ToString(); }
                      if (jenis == "dept") { mybol = rdr["CLM_loginID"].ToString(); }
                    //  mybol = pass.ToString(); // Codec.DecryptStringAES(pass); //  rdr["CLM_unama"].ToString();
                    //   mybol = Codec.DecryptStringAES(pass); //  rdr["CLM_unama"].ToString();
                  ///////  mybol = rdr["CLM_unama"].ToString();
                                                          //   lbFound.Items.Add(rdr["FirstName"].ToString() +
                                                          //    " " + rdr["LastName"].ToString());
                                                          //  mybol = "oo";
                }
            }
            catch (Exception)
            {

                // Print error message
            }
            finally
            {
                //   return new string[] { myEmail.ToString(), user.UserName.ToString() };
                // Close data reader object and database connection
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
                //   return new string[] { myEmail.ToString(), user.UserName.ToString() };
            }

            return mybol;
        }

        public static IEnumerable<string> finddataNew(string user)
        {
            string myinitial = "";
            DateTime mydate = DateTime.Now;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[30];
            ret[0] = "nobody"; //"Staf"; // asal "Pelajar"; 
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='eqcas';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT emailaddress, firstname, password,  department, att7, initial FROM            live_user_staf WHERE att15 = @CLM_loginID  ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 20, "CLM_loginID"));  // The name of the source column
                cmd.Parameters["@CLM_loginID"].Value = user;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "Staf";
                    myinitial = rdr["initial"].ToString().Trim() + " " + rdr["firstname"].ToString().Trim();
                    ret[1] = myinitial.Trim(); // rdr["firstname"].ToString();
                    ret[2] = rdr["department"].ToString().Replace("@", "/@").Replace("'", "''").Replace("(", "").Replace(")", "").Replace("&", "");
                    ret[21] = rdr["department"].ToString().Replace("@", "/@").Replace("'", "''").Replace("(", "").Replace(")", "").Replace("&", "");
                    ret[3] = rdr["emailaddress"].ToString();
                    if (rdr["att7"].ToString().Trim() == "0")
                    {
                        ret[14] = "Pentadbiran";
                    }
                    else
                    {
                        ret[14] = "Akademik";
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


            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT    b.ap01_name, a.att01_id, a.att01_name, a.att01_status, a.att01_start_checkin, a.att01_end_checkin, a.att01_start_checkout, a.att01_end_checkout, a.att01_audience, a.att01_qr_in, a.att01_qr_out  FROM att01_attd_system as a,  ap01_system_name as b where a.ap01_id = b.ap01_id and (a.att01_status = '4' or a.att01_status = '1' or a.att01_status = '11'  or a.att01_status = '44') and ( @mydate BETWEEN a.att01_start_checkin AND a.att01_end_checkout)  order by a.att01_id desc";
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@mydate", mydate);
                cmd.Connection = con;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[4] = rdr["ap01_name"].ToString();
                    ret[5] = rdr["att01_name"].ToString();
                    ret[6] = rdr["att01_status"].ToString();
                    ret[10] = rdr["att01_id"].ToString();
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

            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT    ap03_id, ap03_name, ap03_version, ap03_url_update, ap03_status_staf, ap03_status_student  FROM ap03_profile where ap03_id = 1";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[7] = rdr["ap03_name"].ToString();
                    ret[8] = rdr["ap03_version"].ToString();
                    ret[9] = rdr["ap03_url_update"].ToString();
                    ret[15] = rdr["ap03_status_staf"].ToString();
                    ret[16] = rdr["ap03_status_student"].ToString();
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


            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile;  //@"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT Reg_phoneid,Reg_lockdate,clientid FROM  AspNetUsers WHERE (Email = @CLM_loginID)";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@CLM_loginID", user);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[11] = rdr["Reg_phoneid"].ToString();
                    ret[12] = rdr["Reg_lockdate"].ToString();
                    ret[13] = rdr["clientid"].ToString();
                }
                if (ret[12] == "")
                {

                }
                else
                {
                    //  DateTime oDate = DateTime.Parse(ret[12]);
                    DateTime oDate = Convert.ToDateTime(ret[12]);
                    DateTime oDatekomp = DateTime.Now;
                    if ((oDate.Day == oDatekomp.Day) && (oDate.Month == oDatekomp.Month) && (oDate.Year == oDatekomp.Year))
                    {
                        ret[11] = "today";
                    }
                    else
                    {
                        ret[12] = "";
                        IEnumerable<string> myValidLoginxx = SQLUnixphone.Updatetophoneiddatnull(user);
                        // update date to null
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





            //  pilihanraya
            // ret[17] = "0";
            //  ret[18] = "0";
           // if (ret[14] == "Akademik") { 
                IEnumerable<string> valuesx = SQLPilihanrayase.GetStatusicon_pilihanraya(user);
                var myListx = valuesx.ToList();
                ret[17] = myListx[0];  // icon
                IEnumerable<string> values = SQLPilihanrayase.GetStatusOpenClose_pilihanraya(user);
                var myList = values.ToList();
                ret[18] = myList[0];  // bole undi
                                      // }
                                      // end pilihanraya
            IEnumerable<string> valueszz = SQLWFHStaff.GetStatusWFH_icon(user);
            var myListzz = valueszz.ToList();
            ret[19] = myListzz[0];  // bole undi
            ret[20] = "0";  // 0 tidak layak student menu malaysia, 1 layak
            ret[22] = MenuUTem_OpenorNot();   //  menu malaysia, 1 open 0 close
            ret[23] = Report_MenuUTem(user);  //  Report menu malaysia, 1 open 0 close
                                              // return SQLWFHStaff.GetStatusWFH(user.UserName.ToString());

            ret[24] = "0";  //PROGRAM STUDENT
            ret[25] = "1";  //reset pass portal
            ret[26] = "1";  //reset pass domain
            ret[27] = "1";   //reset pass email
            ret[28] = "1";   //fpx payment 0 diable 1 enable
            ret[29] = StatusStaf_tetap(user);   // cuti staf tetap 1 enable 0 disable
            //  ret[19] = "1";  // wfh staff 0  min hidden 1 appear




            return ret;

        }


        public static IEnumerable<string> finddataNew_pelajar(string user, string pelajar_type)
        {
            DateTime mydate = DateTime.Now;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[30];
            ret[0] = "nobody"; //pelajar_type; // asal "Pelajar"
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbeqcas; // @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='eqcas';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT emailaddress, firstname, password,  department FROM  live_user  WHERE att15 = @CLM_loginID  ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 20, "CLM_loginID"));  // The name of the source column
                cmd.Parameters["@CLM_loginID"].Value = user;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                        ret[0] = pelajar_type;  // asal "Pelajar"
                        ret[1] = rdr["firstname"].ToString();
                        ret[2] = KodFakulti(user, rdr["department"].ToString()); // rdr["department"].ToString();
                        ret[21] = rdr["department"].ToString().Replace("@", "/@").Replace("'", "''").Replace("(", "").Replace(")", "").Replace("&", "");
                        ret[3] = rdr["emailaddress"].ToString();
                        ret[14] = pelajar_type;  // asal "Pelajar"
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


            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile; // @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT    b.ap01_name, a.att01_id, a.att01_name, a.att01_status, a.att01_start_checkin, a.att01_end_checkin, a.att01_start_checkout, a.att01_end_checkout, a.att01_audience, a.att01_qr_in, a.att01_qr_out  FROM att01_attd_system as a,  ap01_system_name as b where a.ap01_id = b.ap01_id and (a.att01_status = '3' or a.att01_status = '4' or a.att01_status = '33' or a.att01_status = '44')  and ( @mydate BETWEEN a.att01_start_checkin AND a.att01_end_checkout) order by a.att01_id desc";
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@mydate", mydate);
                cmd.Connection = con;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[4] = rdr["ap01_name"].ToString();
                    ret[5] = rdr["att01_name"].ToString();
                    ret[6] = rdr["att01_status"].ToString();
                    ret[10] = rdr["att01_id"].ToString();
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

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile; // @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT    ap03_id, ap03_name, ap03_version, ap03_url_update, ap03_status_staf, ap03_status_student  FROM ap03_profile where ap03_id = 1";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[7] = rdr["ap03_name"].ToString();
                    ret[8] = rdr["ap03_version"].ToString();
                    ret[9] = rdr["ap03_url_update"].ToString();
                    ret[15] = rdr["ap03_status_staf"].ToString();
                    ret[16] = rdr["ap03_status_student"].ToString();
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



            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile;  //@"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT Reg_phoneid, Reg_lockdate,clientid FROM  AspNetUsers WHERE (Email = @CLM_loginID)";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@CLM_loginID", user);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[11] = rdr["Reg_phoneid"].ToString();
                    ret[12] = rdr["Reg_lockdate"].ToString();
                    ret[13] = rdr["clientid"].ToString();
                }
                if (ret[12] == "")
                {

                }
                else
                {
                    DateTime oDate = Convert.ToDateTime(ret[12]);
                    DateTime oDatekomp = DateTime.Now;
                    if ((oDate.Day == oDatekomp.Day) && (oDate.Month == oDatekomp.Month) && (oDate.Year == oDatekomp.Year))
                    {
                        ret[11] = "today";
                    }
                    else
                    {
                        ret[12] = "";
                        IEnumerable<string> myValidLoginxx = SQLUnixphone.Updatetophoneiddatnull(user);
                        // update date to null
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





            //  pilihanraya
            IEnumerable<string> valuesx = SQLPilihanraya.GetStatusicon_pilihanraya(user);
            var myListx = valuesx.ToList();
            ret[17] = myListx[0];  // icon
            IEnumerable<string> values = SQLPilihanraya.GetStatusOpenClose_pilihanraya();
            var myList = values.ToList();
            ret[18] = myList[0];  // bole undi
            // end pilihanraya



            ret[19] = "0";  // wfh staff 0  min hidden 1 appear
            ret[20] = find_B40(user);   // 0 tidak layak student menu malaysia, 1 layak
            ret[22] = MenuUTem_OpenorNot();  //  menu malaysia, 1 open 0 close
            ret[23] = "0";  //  Report menu malaysia, 1 open 0 close
            ret[24] = "program student";  //PROGRAM STUDENT
            ret[25] = "1";  //reset pass portal
            ret[26] = "1";  //reset pass domain
            ret[27] = "1";   //reset pass email
            ret[28] = "1";   //fpx payment 0 diable 1 enable
            ret[29] = "0";   // cuti staf tetap 1 enable 0 disable
            return ret;

        }


        public static IEnumerable<string> finddataNew_GRA(string user)
        {

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[30];
            ret[0] = "nobody"; //"GRA";
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbclm;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT CLM_loginID, CLM_UNama,  CLM_UEmail FROM dbo.CLM_Pengguna WHERE CLM_loginID = @CLM_loginID and CLM_KodGRA = 1 ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 20, "CLM_loginID"));  // The name of the source column
                cmd.Parameters["@CLM_loginID"].Value = user;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "RA";
                    ret[1] = rdr["CLM_UNama"].ToString();
                    ret[2] = "RESEARCH ASSISTANT-RA";
                    ret[21] = "RESEARCH ASSISTANT-RA";

                    ret[3] = rdr["CLM_UEmail"].ToString();
                    ret[14] = "RA";
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


            // GRA skip event checking
            //        ret[4] = rdr["ap01_name"].ToString();
            //        ret[5] = rdr["att01_name"].ToString();
            //        ret[6] = rdr["att01_status"].ToString();
            //        ret[10] = rdr["att01_id"].ToString();
            ret[4] = "";
            ret[5] = "";
            ret[6] = "";
            ret[10] = "";
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT    ap03_id, ap03_name, ap03_version, ap03_url_update, ap03_status_staf, ap03_status_student FROM ap03_profile where ap03_id = 1";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[7] = rdr["ap03_name"].ToString();
                    ret[8] = rdr["ap03_version"].ToString();
                    ret[9] = rdr["ap03_url_update"].ToString();
                    ret[15] = rdr["ap03_status_staf"].ToString();
                    ret[16] = rdr["ap03_status_student"].ToString();
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



            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile;  //@"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT Reg_phoneid, Reg_lockdate,clientid FROM  AspNetUsers WHERE (Email = @CLM_loginID)";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@CLM_loginID", user);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[11] = rdr["Reg_phoneid"].ToString();
                    ret[12] = rdr["Reg_lockdate"].ToString();
                    ret[13] = rdr["clientid"].ToString();
                }
                if (ret[12] == "")
                {

                }
                else
                {
                    DateTime oDate = Convert.ToDateTime(ret[12]);
                    DateTime oDatekomp = DateTime.Now;
                    if ((oDate.Day == oDatekomp.Day) && (oDate.Month == oDatekomp.Month) && (oDate.Year == oDatekomp.Year))
                    {
                        ret[11] = "today";
                    }
                    else
                    {
                        ret[12] = "";
                        IEnumerable<string> myValidLoginxx = SQLUnixphone.Updatetophoneiddatnull(user);
                        // update date to null
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







            //  pilihanraya
            ret[17] = "0";
            ret[18] = "0";
            // end pilihanraya

            ret[19] = "0";  // wfh staff 0  min hidden 1 appear
            ret[20] = find_B40(user);  // 0 tidak layak student menu malaysia, 1 layak
            ret[22] = MenuUTem_OpenorNot();  //  menu malaysia, 1 open 0 close
            ret[23] = "0";  //  Report menu malaysia, 1 open 0 close
            ret[24] = "program student";  //PROGRAM STUDENT
            ret[25] = "1";  //reset pass portal
            ret[26] = "0";  //reset pass domain
            ret[27] = "0";   //reset pass email
            ret[28] = "1";   //fpx payment 0 diable 1 enable
            ret[29] = "0";   // cuti staf tetap 1 enable 0 disable
            return ret;

        }





        public static IEnumerable<string> finddataMenu(string user)
        {

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[4];
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='eqcas';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT emailaddress, firstname, password,  department FROM            live_user_staf WHERE att15 = @CLM_loginID  ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 20, "CLM_loginID"));  // The name of the source column
                cmd.Parameters["@CLM_loginID"].Value = user;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "Staf";
                    ret[1] = rdr["firstname"].ToString();
                    ret[2] = rdr["department"].ToString();
                    ret[3] = rdr["emailaddress"].ToString();
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
        public static string finddata(string user, string jenis, string pass)
        {
            string mybol = "yyxx";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            //  string myEmail;
            // string myNama;
            // string myDepartment;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='eqcas';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT emailaddress, firstname, password,  department FROM            live_user_staf WHERE att15 = @CLM_loginID  ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 20, "CLM_loginID"));  // The name of the source column
                cmd.Parameters["@CLM_loginID"].Value = user;
                //  cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 20, "CLM_loginID"));  // The name of the source column
                //  cmd.Parameters["@CLM_loginID"].Value = user;
                // cmd.Parameters.Add(new SqlParameter("@CLM_StatusPG", System.Data.SqlDbType.NVarChar, 20, "CLM_StatusPG"));  // The name of the source column
                // cmd.Parameters["@CLM_StatusPG"].Value = password;
                // Execute the query
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    // myEmail = rdr["emailaddress"].ToString();
                    //  if (jenis == "nama") { mybol = rdr["firstname"].ToString(); }
                    //   if (jenis == "dept") { mybol = rdr["department"].ToString(); }
                    if (jenis == "nama") { mybol = rdr["firstname"].ToString(); }
                    if (jenis == "dept") { mybol = rdr["department"].ToString(); } // rdr["department"].ToString(); }
                    if (jenis == "email") { mybol = rdr["emailaddress"].ToString(); }
                    //   lbFound.Items.Add(rdr["FirstName"].ToString() +
                    //    " " + rdr["LastName"].ToString());
                    //  mybol = "oo";
                }
            }
            catch (Exception)
            {

                // Print error message
            }
            finally
            {
                //   return new string[] { myEmail.ToString(), user.UserName.ToString() };
                // Close data reader object and database connection
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
                //   return new string[] { myEmail.ToString(), user.UserName.ToString() };
            }

            return mybol;
        }

        public static void updatedata(string userid, string clientid, string sessid, string clientip)
        {
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            var Timestamp = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds();
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";

                 con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "update      AspNetUsers set session_time=@SESSTIME, last_login=@LASTLOGIN, login_date=@LOGINDATE, clientid = @CLIENTID , sessionid = @SESSID ,  clientip  = @CLIENTIP  WHERE UserName = @USERID  ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@CLIENTID", System.Data.SqlDbType.NVarChar, 500, "CLIENTID"));  // The name of the source column
                cmd.Parameters["@CLIENTID"].Value = clientid;
                cmd.Parameters.Add(new SqlParameter("@SESSID", System.Data.SqlDbType.NVarChar, 500, "SESSID"));  // The name of the source column
                cmd.Parameters["@SESSID"].Value = sessid;
                cmd.Parameters.Add(new SqlParameter("@CLIENTIP", System.Data.SqlDbType.NVarChar, 20, "CLIENTIP"));  // The name of the source column
                cmd.Parameters["@CLIENTIP"].Value = clientip;
                cmd.Parameters.Add(new SqlParameter("@USERID", System.Data.SqlDbType.NVarChar, 256, "USERID"));  // The name of the source column
                cmd.Parameters["@USERID"].Value = userid;

            cmd.Parameters.Add(new SqlParameter("@SESSTIME", System.Data.SqlDbType.BigInt));  // The name of the source column
            cmd.Parameters["@SESSTIME"].Value = Timestamp;
            cmd.Parameters.Add(new SqlParameter("@LASTLOGIN", System.Data.SqlDbType.BigInt));  // The name of the source column
            cmd.Parameters["@LASTLOGIN"].Value = Timestamp;
            cmd.Parameters.Add(new SqlParameter("@LOGINDATE", System.Data.SqlDbType.DateTime));  // The name of the source column
            cmd.Parameters["@LOGINDATE"].Value = DateTime.Now;


            rdr = cmd.ExecuteReader();
            int pilihanraya = updatedatabaru_sessionpilihanraya(userid, sessid);
            }
        public static int updatedatabaru (string userid, string clientid, string sessid, string clientip)
        {
            int mybol = 0;
            try { 
            
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            var Timestamp = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds();
                String ConnectionString = dbase_developer; // @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";

            con = new SqlConnection(ConnectionString);
            con.Open();
            string CommandText = "update      AspNetUsers set session_time=@SESSTIME, last_login=@LASTLOGIN, login_date=@LOGINDATE, clientid = @CLIENTID , sessionid = @SESSID ,  clientip  = @CLIENTIP  WHERE UserName = @USERID  ";
            cmd = new SqlCommand(CommandText);
            cmd.Connection = con;
            cmd.Parameters.Add(new SqlParameter("@CLIENTID", System.Data.SqlDbType.NVarChar, 500, "CLIENTID"));  // The name of the source column
            cmd.Parameters["@CLIENTID"].Value = clientid;
            cmd.Parameters.Add(new SqlParameter("@SESSID", System.Data.SqlDbType.NVarChar, 500, "SESSID"));  // The name of the source column
            cmd.Parameters["@SESSID"].Value = sessid;
            cmd.Parameters.Add(new SqlParameter("@CLIENTIP", System.Data.SqlDbType.NVarChar, 20, "CLIENTIP"));  // The name of the source column
            cmd.Parameters["@CLIENTIP"].Value = clientip;
            cmd.Parameters.Add(new SqlParameter("@USERID", System.Data.SqlDbType.NVarChar, 256, "USERID"));  // The name of the source column
            cmd.Parameters["@USERID"].Value = userid;

            cmd.Parameters.Add(new SqlParameter("@SESSTIME", System.Data.SqlDbType.BigInt));  // The name of the source column
            cmd.Parameters["@SESSTIME"].Value = Timestamp;
            cmd.Parameters.Add(new SqlParameter("@LASTLOGIN", System.Data.SqlDbType.BigInt));  // The name of the source column
            cmd.Parameters["@LASTLOGIN"].Value = Timestamp;
            cmd.Parameters.Add(new SqlParameter("@LOGINDATE", System.Data.SqlDbType.DateTime));  // The name of the source column
            cmd.Parameters["@LOGINDATE"].Value = DateTime.Now;

            mybol = cmd.ExecuteNonQuery();
            int pilihanraya = updatedatabaru_sessionpilihanraya(userid, sessid);
                // rdr = cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                return mybol;

            }
            return mybol;
        }
        //updatedatabaru_myPanic
        public static int updatedatabaru_myPanic(string userid, string clientid, string sessid, string clientip)
        {
            int mybol = 1;
            try
            {

                //SqlDataReader rdr = null;
                //SqlConnection con = null;
                //SqlCommand cmd = null;
                //var Timestamp = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds();
                //String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";

                //con = new SqlConnection(ConnectionString);
                //con.Open();
                //string CommandText = "update      AspNetUsers set session_time=@SESSTIME, last_login=@LASTLOGIN, login_date=@LOGINDATE,   clientip  = @CLIENTIP  WHERE UserName = @USERID  ";
                //cmd = new SqlCommand(CommandText);
                //cmd.Connection = con;
                //cmd.Parameters.Add(new SqlParameter("@CLIENTID", System.Data.SqlDbType.NVarChar, 500, "CLIENTID"));  // The name of the source column
                //cmd.Parameters["@CLIENTID"].Value = clientid;
                //cmd.Parameters.Add(new SqlParameter("@SESSID", System.Data.SqlDbType.NVarChar, 500, "SESSID"));  // The name of the source column
                //cmd.Parameters["@SESSID"].Value = sessid;
                //cmd.Parameters.Add(new SqlParameter("@CLIENTIP", System.Data.SqlDbType.NVarChar, 20, "CLIENTIP"));  // The name of the source column
                //cmd.Parameters["@CLIENTIP"].Value = clientip;
                //cmd.Parameters.Add(new SqlParameter("@USERID", System.Data.SqlDbType.NVarChar, 256, "USERID"));  // The name of the source column
                //cmd.Parameters["@USERID"].Value = userid;

                //cmd.Parameters.Add(new SqlParameter("@SESSTIME", System.Data.SqlDbType.BigInt));  // The name of the source column
                //cmd.Parameters["@SESSTIME"].Value = Timestamp;
                //cmd.Parameters.Add(new SqlParameter("@LASTLOGIN", System.Data.SqlDbType.BigInt));  // The name of the source column
                //cmd.Parameters["@LASTLOGIN"].Value = Timestamp;
                //cmd.Parameters.Add(new SqlParameter("@LOGINDATE", System.Data.SqlDbType.DateTime));  // The name of the source column
                //cmd.Parameters["@LOGINDATE"].Value = DateTime.Now;

                //mybol = cmd.ExecuteNonQuery();
                //// rdr = cmd.ExecuteNonQuery();
                //mybol2 = SQLKuliahStudent.updatedatabaru_notmyutem_attd(userid, clientid, sessid, clientip);
                //if (mybol2 == 0)
                //{
                //    mybol2 = SQLKuliahStudent.insertdatabaru_notmyutem_attd(userid, clientid, sessid, clientip);
                //}
            }
            catch (Exception e)
            {
                return mybol;

            }
            return mybol;
        }
        public static int updatedatabaru_notmyutem(string userid, string clientid, string sessid, string clientip)
        {
            int mybol = 0;
            int mybol2 = 0;
            try
            {

                SqlDataReader rdr = null;
                SqlConnection con = null;
                SqlCommand cmd = null;
                var Timestamp = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds();
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";

                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "update      AspNetUsers set session_time=@SESSTIME, last_login=@LASTLOGIN, login_date=@LOGINDATE,   clientip  = @CLIENTIP  WHERE UserName = @USERID  ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@CLIENTID", System.Data.SqlDbType.NVarChar, 500, "CLIENTID"));  // The name of the source column
                cmd.Parameters["@CLIENTID"].Value = clientid;
                cmd.Parameters.Add(new SqlParameter("@SESSID", System.Data.SqlDbType.NVarChar, 500, "SESSID"));  // The name of the source column
                cmd.Parameters["@SESSID"].Value = sessid;
                cmd.Parameters.Add(new SqlParameter("@CLIENTIP", System.Data.SqlDbType.NVarChar, 20, "CLIENTIP"));  // The name of the source column
                cmd.Parameters["@CLIENTIP"].Value = clientip;
                cmd.Parameters.Add(new SqlParameter("@USERID", System.Data.SqlDbType.NVarChar, 256, "USERID"));  // The name of the source column
                cmd.Parameters["@USERID"].Value = userid;

                cmd.Parameters.Add(new SqlParameter("@SESSTIME", System.Data.SqlDbType.BigInt));  // The name of the source column
                cmd.Parameters["@SESSTIME"].Value = Timestamp;
                cmd.Parameters.Add(new SqlParameter("@LASTLOGIN", System.Data.SqlDbType.BigInt));  // The name of the source column
                cmd.Parameters["@LASTLOGIN"].Value = Timestamp;
                cmd.Parameters.Add(new SqlParameter("@LOGINDATE", System.Data.SqlDbType.DateTime));  // The name of the source column
                cmd.Parameters["@LOGINDATE"].Value = DateTime.Now;

                mybol = cmd.ExecuteNonQuery();
                // rdr = cmd.ExecuteNonQuery();
                mybol2 = SQLKuliahStudent.updatedatabaru_notmyutem_attd(userid, clientid, sessid, clientip);
                if (mybol2 == 0)
                {
                    mybol2 = SQLKuliahStudent.insertdatabaru_notmyutem_attd(userid, clientid, sessid, clientip);
                }
            }
            catch (Exception e)
            {
                return mybol;

            }
            return mybol;
        }
        public static bool IsAspUserExist(string userid)
        {
            bool mybol = false;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            con = new SqlConnection(ConnectionString);
            con.Open();
            string CommandText = "select UserName from AspNetUsers  WHERE UserName = @CLM_loginID  ";
            cmd = new SqlCommand(CommandText);
            cmd.Connection = con;
            cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 256, "CLM_loginID"));  // The name of the source column
            cmd.Parameters["@CLM_loginID"].Value = userid;
            rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                      mybol = true;
                }
            return mybol;
        }
        public static string StatusStaf_tetap(string user)
        {
            string mybol = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();

               // string CommandText = " SELECT        dbo.UFN_MOB_APP_HEP_B40(@userid) AS STA_B40  ";
                //  CommandText = CommandText + " FROM  live_user_staf  where att15=@userid and att10='139' ";
                string CommandText = "SELECT        MS02_Perjawatan.MS01_NoStaf, MS02_Perjawatan.MS02_Taraf, MS_TarafKhidmat.TarafKhidmat ";
                CommandText = CommandText + " FROM            MS02_Perjawatan INNER JOIN ";
                CommandText = CommandText + "                          MS_TarafKhidmat ON MS02_Perjawatan.MS02_Taraf = MS_TarafKhidmat.KodTarafKhidmat INNER JOIN ";
                CommandText = CommandText + "                          MS01_Peribadi ON MS02_Perjawatan.MS01_NoStaf = MS01_Peribadi.MS01_NoStaf ";
                CommandText = CommandText + " WHERE   MS01_Peribadi.MS01_NoStaf=@userid  and MS02_Perjawatan.MS02_Taraf='02' and   (MS01_Peribadi.MS01_Status = 1) ";
                CommandText = CommandText + " ORDER BY MS02_Perjawatan.MS01_NoStaf ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", user);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                   // bool gg = (bool)rdr["STA_B40"];
                   // if (gg == true)
                   // {
                        mybol = "1";
                    
                    break;
                }




            }
            catch (Exception)
            {
                return mybol;
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
        public static string find_B40(string user)
        {
            string mybol = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = " SELECT        dbo.UFN_MOB_APP_HEP_B40(@userid) AS STA_B40  ";
              //  CommandText = CommandText + " FROM  live_user_staf  where att15=@userid and att10='139' ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", user);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    bool gg = (bool)rdr["STA_B40"];
                    if ( gg == true)
                    {
                        mybol = "1";
                    }
                    else
                    {
                        mybol = "0";
                    }
                    break;
                }

             
    

            }
            catch (Exception)
            {
                return mybol;
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
        //Report_MenuUTem()00206
        public static string Report_MenuUTem(string myuser)
        {
            string mybol = "0";


            try
            {

                if ((myuser == "00206") || (myuser == "00913") || (myuser == "00954") || 
                    (myuser == "0x0578") || (myuser == "00578") || (myuser == "00085")  )
                {
                    mybol = "1";
                }



            }
            catch (Exception)
            {
                return mybol;
            }
            finally
            {

            }

            return mybol;
        }
        public static string MenuUTem_OpenorNot()
        {
            string mybol = "1";


            try
            {
              




            }
            catch (Exception)
            {
                return mybol;
            }
            finally
            {
                
            }

            return mybol;
        }

        public static string finddatasmkb(string user, string jenis, string pass)
        {
            string mybol = "yyxx";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            //  string myEmail;
            // string myNama;
            // string myDepartment;server=V-SQL11.utem.edu.my\SQL_INS01;database=Dbstaf;UID=smsm;PWD=#smsm@kutkm07;"
            // SELECT        a.ms01_noakaun, b.NamaBank FROM ms01_peribadi as a, MS_Bank as b where a.ms01_kodbank = b.kodbank and a.ms01_nostaf = @CLM_loginID  ";
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT        a.ms01_noakaun, b.NamaBank FROM ms01_peribadi as a, MS_Bank as b where a.ms01_kodbank = b.kodbank and a.ms01_nostaf = @CLM_loginID  ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 20, "CLM_loginID"));  // The name of the source column
                cmd.Parameters["@CLM_loginID"].Value = AESEncrytDecry.DecryptStringAES(user);
                //  cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 20, "CLM_loginID"));  // The name of the source column
                //  cmd.Parameters["@CLM_loginID"].Value = user;
                // cmd.Parameters.Add(new SqlParameter("@CLM_StatusPG", System.Data.SqlDbType.NVarChar, 20, "CLM_StatusPG"));  // The name of the source column
                // cmd.Parameters["@CLM_StatusPG"].Value = password;
                // Execute the query
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    // myEmail = rdr["emailaddress"].ToString();
                    //  if (jenis == "nama") { mybol = rdr["firstname"].ToString(); }
                    //   if (jenis == "dept") { mybol = rdr["department"].ToString(); }
                    if (jenis == "nama") { mybol = rdr["NamaBank"].ToString() + " Acc No (" + rdr["ms01_noakaun"].ToString() +")"; }
                  //  if (jenis == "dept") { mybol = rdr["department"].ToString(); }
                  //  if (jenis == "email") { mybol = rdr["emailaddress"].ToString(); }
                    //   lbFound.Items.Add(rdr["FirstName"].ToString() +
                    //    " " + rdr["LastName"].ToString());
                    //  mybol = "oo";
                }
            }
            catch (Exception)
            {

                // Print error message
            }
            finally
            {
                //   return new string[] { myEmail.ToString(), user.UserName.ToString() };
                // Close data reader object and database connection
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
                //   return new string[] { myEmail.ToString(), user.UserName.ToString() };
            }

            return mybol;
        }

        public static IEnumerable<string> CheckValid_loginonly(string userid, string logincode_Id)
        {
            string CommandText = "";
            string[] ret = new string[2];
            ret[0] = "loginchanged";
            String ConnectionString = SQLAuth.dbase_dbmobile; //  @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            CommandText = "SELECT   clientip, session_time, last_login, login_date, Id, Email, EmailConfirmed, PasswordHash, SecurityStamp, PhoneNumber, PhoneNumberConfirmed, TwoFactorEnabled, LockoutEndDateUtc, LockoutEnabled, AccessFailedCount, UserName, clientid, sessionid FROM AspNetUsers where sessionid=@sess_id and  UserName=@userid";
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@userid", userid);
                    cmd.Parameters.AddWithValue("@sess_id", logincode_Id);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                ret[0] = "validlogin";
                            }
                        }

                        conn.Close();
                    }
                    catch (SqlException e)
                    {

                    }
                }
            }

            return ret;
        }
        public static IEnumerable<string> CheckValid_loginonly_pilihanraya(string userid, string logincode_Id)
        {
            string CommandText = "";
            string[] ret = new string[2];
            ret[0] = "loginchanged";
            String ConnectionString = SQLAuth.dbase_dbpilihanraya; //  @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            CommandText = "SELECT SMP01_Nomatrik, UniqueKey FROM SMP01_Peribadi where UniqueKey=@sess_id and  SMP01_Nomatrik=@userid";
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@userid", userid);
                    cmd.Parameters.AddWithValue("@sess_id", logincode_Id);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                ret[0] = "validlogin";
                            }
                        }

                        conn.Close();
                    }
                    catch (SqlException e)
                    {

                    }
                }
            }

            return ret;
        }
        //////
        public  static string getPwD(string e)
        {
            //x is the variable to store pass after encryption
            string x = "";
            int a = 1;
            var b = "";
            var b2 = 0;
            var c = 0;
            var d = 0;

            Randomize(12345);

            for (a = 1; a <= e.Length; a++)
            {

                b = (e[a - 1]).ToString();//e.charCodeAt(a-1);


                b2 = Asc(Convert.ToChar(b));
                //Console.WriteLine("first " + b2 + "\n");
                decimal test = a / (decimal)2;
                int test2 = a / 2;
                //Console.WriteLine("CheckCalculation " + a + " - " + test + test2 );

                if (test == test2)
                    d = 5;
                else
                    d = -7;

                //Console.WriteLine("second " + d + "\n");


                //Console.WriteLine("rand " + Rnd(0) * 255);

                c = b2 ^ ((int)(Rnd(0) * 255) + a + d);
                //Console.WriteLine("third " + c + "\n");

                x = x + (char)c;
                //Console.WriteLine("fourth " + x + "\n\n");
            }

            return x;
        }

        public static int Asc(char String)
        {
            int num = Convert.ToInt32(String);
            if (num < 128)
            {
                return num;
            }
            try
            {
                Encoding fileIOEncoding = Encoding.Default;
                char[] chars = new char[1]
                {
      String
                };
                byte[] array;
                int bytes;
                if (fileIOEncoding.IsSingleByte)
                {
                    array = new byte[1];
                    bytes = fileIOEncoding.GetBytes(chars, 0, 1, array, 0);
                    return array[0];
                }
                array = new byte[2];
                bytes = fileIOEncoding.GetBytes(chars, 0, 1, array, 0);
                if (bytes == 1)
                {
                    return array[0];
                }
                if (BitConverter.IsLittleEndian)
                {
                    byte b = array[0];
                    array[0] = array[1];
                    array[1] = b;
                }
                return BitConverter.ToInt16(array, 0);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public static float Rnd(float Number)
        {

            int num = rnd_seed;
            checked
            {
                if ((double)Number != 0.0)
                {
                    if ((double)Number < 0.0)
                    {
                        num = BitConverter.ToInt32(BitConverter.GetBytes(Number), 0);
                        long num2 = num;
                        num2 &= uint.MaxValue;
                        num = (int)(num2 + (num2 >> 24) & 0xFFFFFF);
                    }
                    num = (int)(unchecked((long)num) * 1140671485L + 12820163 & 0xFFFFFF);
                }
                rnd_seed = num;
            }
            return (float)num / 16777216f;
        }

        static void  Randomize(double Number)
        {
            int rndSeed2 = rnd_seed;
            int num = (!BitConverter.IsLittleEndian) ? BitConverter.ToInt32(BitConverter.GetBytes(Number), 0) : BitConverter.ToInt32(BitConverter.GetBytes(Number), 4);
            num = ((num & 0xFFFF) ^ num >> 16) << 8;
            rndSeed2 = (rnd_seed = ((rndSeed2 & -16776961) | num));
        }
        public static void updatephonenumber_notmyutem(string userid, string mflag)
        {
            string mydat = "NULL";
            int mybol = 0;
            try
            {

                SqlDataReader rdr = null;
                SqlConnection con = null;
                SqlCommand cmd = null;
                var Timestamp = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds();
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
                if (mflag == "1") { mydat = "1"; } else { mydat = ""; }
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "update      AspNetUsers set PhoneNumber=@CLIENTIP  WHERE UserName = @USERID  ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@CLIENTIP", mydat);
              //  cmd.Parameters.Add(new SqlParameter("@CLIENTIP", System.Data.SqlDbType.NVarChar, 20, "CLIENTIP"));  // The name of the source column
              //  cmd.Parameters["@CLIENTIP"].Value = "0";
              //  cmd.Parameters.Add(new SqlParameter("@USERID", System.Data.SqlDbType.NVarChar, 256, "USERID"));  // The name of the source column
             //   cmd.Parameters["@USERID"].Value = userid;


                mybol = cmd.ExecuteNonQuery();
          
            }
            catch (Exception e)
            {
               // return mybol;

            }
          //  return mybol;
        }

        public static bool IsAspPhoneUserExist(string userid)
        {
            bool mybol = false;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";
            con = new SqlConnection(ConnectionString);
            con.Open();
            string CommandText = "select PhoneNumber from AspNetUsers  WHERE UserName = @CLM_loginID and PhoneNumber='1' ";
            cmd = new SqlCommand(CommandText);
            cmd.Connection = con;
            cmd.Parameters.Add(new SqlParameter("@CLM_loginID", System.Data.SqlDbType.NVarChar, 256, "CLM_loginID"));  // The name of the source column
            cmd.Parameters["@CLM_loginID"].Value = userid;
            rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                mybol = true;
            }
            return mybol;
        }
      
        public static string KodFakulti(string nomatrik, string eqcas)
        {
            string mybol = eqcas;
            string jumpa = "0";
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
                CommandText = "select SMP01_Fakulti FROM  SMP01_Peribadi  where SMP01_Nomatrik=@nomatrik ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nomatrik", nomatrik);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["SMP01_Fakulti"].ToString().Trim();
                    jumpa = "1";

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
            if (jumpa == "0")
            {
               
                if   ((nomatrik.ToString().Contains("bs")) || (nomatrik.ToString().Contains("BS")))
               { 
                    return mybol = KodFakultiPSH(nomatrik, eqcas);
               }
               else
               {
                   return mybol = KodFakultiSMG(nomatrik, eqcas);
                }

                
            }
            else
            {
                return mybol;
            }


        }

        public static string KodFakultiPSH(string nomatrik, string eqcas)
        {
            string mybol = eqcas;
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudentpsh;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "SELECT  SMP01_Fakulti  FROM     SMP01_Peribadi  where  SMP01_Nomatrik = @nomatrik";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nomatrik", nomatrik);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["SMP01_Fakulti"].ToString().Trim();

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

        public static string KodFakultiSMG(string nomatrik, string eqcas)
        {
            string mybol = eqcas;
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
                CommandText = "SELECT  SMG01_KODFAKULTI  FROM     SMG01_PENGAJIAN  where  SMG01_NOMATRIK = @nomatrik";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@nomatrik", nomatrik);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["SMG01_KODFAKULTI"].ToString().Trim();

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
        public static int updatedatabaru_sessionpilihanraya(string userid, string sessid)
        {
            int mybol = 0;
            try
            {
                if (
                      (userid.ToString().Contains("d")) ||
                      (userid.ToString().Contains("b")) ||
                      (userid.ToString().Contains("bs")) ||
                      (userid.ToString().Contains("m")) ||
                      (userid.ToString().Contains("p"))
                     )
                {

                    SqlDataReader rdr = null;
                    SqlConnection con = null;
                    SqlCommand cmd = null;
                    var Timestamp = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds();
                    String ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";

                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    string CommandText = "update     SMP01_Peribadi set UniqueKey=@SESSID WHERE SMP01_Nomatrik = @USERID  ";
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;

                    cmd.Parameters.Add(new SqlParameter("@SESSID", System.Data.SqlDbType.NVarChar, 500, "SESSID"));  // The name of the source column
                    cmd.Parameters["@SESSID"].Value = sessid;
                    cmd.Parameters.Add(new SqlParameter("@USERID", System.Data.SqlDbType.NVarChar, 256, "USERID"));  // The name of the source column
                    cmd.Parameters["@USERID"].Value = userid;
                    mybol = cmd.ExecuteNonQuery();
                }
              }
            catch (Exception e)
            {
                return mybol;

            }
            return mybol;
        }


        public void ChangeMyPassword(string domainName, string userName, string currentPassword, string newPassword)
        {
            try
            {
                System.DirectoryServices.DirectoryEntry directionEntry = new System.DirectoryServices.DirectoryEntry("LDAP://10.1.3.102:389/OU=Users,OU=UTeM-Staff,DC=staff,DC=utem,DC=edu", "SPAD", "!@#$%^");

                directionEntry.Path = "LDAP://10.1.3.102:389/OU=Users,OU=UTeM-Staff,DC=staff,DC=utem,DC=edu";
                directionEntry.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Secure;

             //   string ldapPath = "LDAP://192.168.1.xx";
          //      DirectoryEntry directionEntry = new DirectoryEntry(ldapPath, domainName + "\\" + userName, currentPassword);
                if (directionEntry != null)

                {
                    DirectorySearcher search = new DirectorySearcher(directionEntry);
                    search.Filter = "(SAMAccountName=" + userName + ")";
                    SearchResult result = search.FindOne();
                    if (result != null)
                    {
                        DirectoryEntry userEntry = result.GetDirectoryEntry();
                        if (userEntry != null)
                        {
                            userEntry.Invoke("ChangePassword", new object[] { currentPassword, newPassword });
                            userEntry.CommitChanges();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        

public static void ResetPassword1(string userName, string newPassword)
        {
            PrincipalContext context = new PrincipalContext(ContextType.Domain);
            UserPrincipal user = UserPrincipal.FindByIdentity(context, IdentityType.SamAccountName, userName);
            //Enable Account if it is disabled
            user.Enabled = true;
            //Reset User Password
            user.SetPassword(newPassword);
            //Force user to change password at next logon
            user.ExpirePasswordNow();
            user.Save();
        }
      
        public static void ResetPassword(string userName, string password)
        {

           // DirectoryEntry domainEntry = Domain.GetCurrentDomain().GetDirectoryEntry();

            System.DirectoryServices.DirectoryEntry domainEntry = new System.DirectoryServices.DirectoryEntry("LDAP://10.1.3.102:389/OU=Users,OU=UTeM-Staff,DC=staff,DC=utem,DC=edu", "SPAD", "!@#$%^");

            domainEntry.Path = "LDAP://10.1.3.102:389/OU=Users,OU=UTeM-Staff,DC=staff,DC=utem,DC=edu";
            domainEntry.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Secure;


            domainEntry.Children.Add("CN=" + userName, "User");
            domainEntry.Invoke("SetPassword", new object[] { password });

            //DirectorySearcher dirSearcher = new DirectorySearcher(domainEntry);
            //string filter = string.Format("(SAMAccountName={0})", userName);
            //dirSearcher.Filter = filter;
            //SearchResult result = dirSearcher.FindOne();
            //if (result != null)
            //{
            //    DirectoryEntry userEntry = result.GetDirectoryEntry();

            //    //Enable Account if it is disabled
            //    userEntry.Properties["userAccountControl"].Value = 0x200;
            ////    userEntry.Properties["SetPassword"].Value = password;
            //    //Reset User Password
            //    // object[] passwordx = new object[] { password };
            //    //   object ret = userEntry.Invoke("SetPassword", passwordx);
            //    //  userEntry.Options.PasswordEncoding = PasswordEncodingMethod.PasswordEncodingClear;
            //  //  userEntry.Password = password;
            // //  userEntry.Invoke("SetPassword", new object[] { password });
            //  //  userEntry.Invoke("SetPassword", password );
            //    //  userEntry.Invoke("SetPassword", password);
            //    //Force user to change password at next logon
            //    ////   userEntry.Properties["pwdlastset"][0] = 0;
            //    userEntry.CommitChanges();
            //    userEntry.Close();
            //}
            //else
            //{
            //    // User not found
            //}
        }

        public static void myModulNewTest()
        {
            string myflag = "";
            string[] myaccountName = new string[10];
            string newnamee;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlConnection con2 = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='eqcas';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT a.telbimbit, a.att8, b.singkatan, a.tel, a.department, a.emailaddress, a.att6, a.initial,a.displayname,a.att15, a.title FROM dbo.live_user_staf as a, dbo.live_group as b  WHERE b.mkod = a.att1 and a.att15 = '00035'  ";
                //  string CommandText = "SELECT a.att8, b.singkatan, a.tel, a.department, a.emailaddress, a.att6, a.initial,a.displayname,a.att15, a.title FROM dbo.live_user_staf as a, dbo.live_group as b  WHERE b.mkod = a.att1 and a.att6 = 'u' and a.att8 = '1' ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                // Execute the query
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if (rdr["initial"].ToString().Trim() == "")
                    {
                        newnamee = rdr["displayname"].ToString().Trim();
                    }
                    else
                    {
                        newnamee = rdr["initial"].ToString().Trim() + " " + rdr["displayname"].ToString().Trim();
                    }
                    myaccountName[0] = rdr["att15"].ToString().Trim();  // staff no
                    myaccountName[1] = "testz n"; // newnamee; // displayname
                    myaccountName[2] = rdr["title"].ToString().Trim();  // title
                    myaccountName[3] = rdr["emailaddress"].ToString().Trim();  // email
                    myaccountName[4] = rdr["singkatan"].ToString().Trim();  // department
                    myaccountName[5] = "UTeM";  // company
                    myaccountName[6] = rdr["tel"].ToString().Trim();  // tel
                    myaccountName[7] = "test n"; // rdr["displayname"].ToString().Trim();  // givename
                    if (rdr["att8"].ToString().Trim() == "1")
                    {
                        myaccountName[8] = "SEDANG BERKHIDMAT";   //description
                    }
                    else
                    {
                        myaccountName[8] = "TIDAK AKTIF";   //description
                    }
                    myaccountName[9] = rdr["telbimbit"].ToString().Trim();  // tel
                    myflag = UpdateAttributeStaf(myaccountName);
                    //if (myflag == "ok") { MessageBox.Show("okkk"); }
                    //con2 = new SqlConnection(ConnectionString);
                    //con2.Open();
                    //string CommandText2 = "update dbo.live_user_staf  set att6='y' WHERE att15 = '" + rdr["att15"].ToString().Trim() + "' ";
                    //SqlCommand sqlCmd3 = new SqlCommand(CommandText2, con2);
                    //SqlDataReader read3 = sqlCmd3.ExecuteReader();
                    //read3.Close();
                    //con2.Close();


                }
            }
            catch (Exception es)
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



        public static DirectoryEntry GetDirectoryEntry()
        {
            System.DirectoryServices.DirectoryEntry ldapConnection = new System.DirectoryServices.DirectoryEntry("LDAP://10.1.3.102:389/OU=Users,OU=UTeM-Staff,DC=staff,DC=utem,DC=edu", "SPAD", "!@#$%^");
            ldapConnection.Path = "LDAP://10.1.3.102:389/OU=Users,OU=UTeM-Staff,DC=staff,DC=utem,DC=edu";
            ldapConnection.AuthenticationType = System.DirectoryServices.AuthenticationTypes.Secure;


            return ldapConnection;
        }

        public static string UpdateAttributeStaf(string[] accountName)
        {
            //  string propertyName = "givenName";
            string msg;
            msg = "error";
            try
            {
                System.DirectoryServices.DirectoryEntry sgscAd = GetDirectoryEntry();
                DirectorySearcher search = new DirectorySearcher(sgscAd);
                search.Filter = "(SAMAccountName=" + accountName[0] + ")";
                search.SearchScope = SearchScope.Subtree;
                SearchResult results = search.FindOne();
                if (results != null)
                {
                    sgscAd.Path = results.Path;
                    sgscAd.Properties["department"].Value = accountName[4];
                    sgscAd.Properties["company"].Value = accountName[5];
                    sgscAd.Properties["ipPhone"].Value = accountName[6];
                    sgscAd.Properties["mail"].Value = accountName[3];
                    sgscAd.Properties["title"].Value = accountName[2];
                    sgscAd.Properties["DisplayName"].Value = accountName[1];
                    sgscAd.Properties["givenName"].Value = accountName[7];
                    sgscAd.Properties["description"].Value = accountName[8];
                    sgscAd.Properties["telephoneNumber"].Value = accountName[9];
                    sgscAd.Properties["mobile"].Value = accountName[9];

                    sgscAd.Properties["userAccountControl"].Value = 0x200;
                    ////  //Reset User Password

                    sgscAd.Invoke("SetPassword", new object[] { "Jau85189!" });
                    sgscAd.CommitChanges();
                    sgscAd.Close();
                    msg = "ok";

                }
                else
                {
                    msg = "error";
                }
            }
            catch (Exception es)
            {

            }
            return msg;
        }

        public static string UpdateAttributeStafNew(string accountName)
        {
            //  string propertyName = "givenName";
            string msg;
            msg = "error";
            try
            {
                PrincipalContext context = new PrincipalContext(ContextType.Domain);
                UserPrincipal user = UserPrincipal.FindByIdentity(context, IdentityType.SamAccountName, accountName);
                //Enable Account if it is disabled
              //  user.Enabled = true;
                //Reset User Password
                user.SetPassword("Jck87655!");
                //Force user to change password at next logon
                user.ExpirePasswordNow();
                user.Save();
                msg = "ok";
            }
            catch (Exception es)
            {

            }
            return msg;
        }


        /////
    }
}
