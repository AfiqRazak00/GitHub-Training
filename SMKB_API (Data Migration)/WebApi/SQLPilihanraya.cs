using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

namespace WebApi
{
    public class SQLPilihanraya
    {
        //
        public static IEnumerable<string> TryUpdate1(string userid, string jenis)
        {
            List<string> list = new List<string>();
            list.Add("0");
            list.Add("0");
            String ConnectionString = "";
            string CommandText = "";
            string num = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string mFlag = "0";
            try
            {
              
                if (jenis == "umum") {
                    
                    if (GetMTB(KodFakulti(userid)) == "1")
                    { // gg = "fakulti Selesai menang tanpa brtanding"; 
                        string mymsg = Finduser_sp02_undi(userid);
                        if (mymsg == "0")
                        {
                            CommandText = "INSERT INTO  SP02_UNDI (SP02_IDPENGUNDI, SP02_TAHUN,  SP02_WAKTU, SP02_PC,  SP02_UMUM, SP02_LOKASIUMUM, SP02_TARIKHUNDIUMUM,  SP02_FAKULTI, SP02_LOKASIFAKULTI, SP02_TARIKHUNDIFAKULTI) values (@userid,@myyear, @tarikh, 'APPS', 1, @lokasiumum, @tarikhumum, 1, @lokasifakulti, @tarikhfakulti)  ";
                            mFlag = "1";
                        }
                        else
                        {
                            string mymsg2y = Finduser_sp02_undi_det(userid, "umum");
                            if (mymsg2y == "0")
                            {
                                CommandText = "update      SP02_UNDI set SP02_FAKULTI=1, SP02_LOKASIFAKULTI=@lokasifakulti, SP02_TARIKHUNDIFAKULTI=@tarikhfakulti ,SP02_UMUM=1, SP02_LOKASIUMUM=@lokasiumum, SP02_TARIKHUNDIUMUM=@tarikhumum  WHERE SP02_IDPENGUNDI = @userid  ";
                                mFlag = "1";
                            }
                        }

                    }
                    else
                    {
                        string mymsgp1 = Finduser_sp02_undi(userid);
                        if (mymsgp1 == "0")
                        {
                            CommandText = "INSERT INTO  SP02_UNDI (SP02_IDPENGUNDI, SP02_TAHUN,  SP02_WAKTU, SP02_PC,  SP02_UMUM, SP02_LOKASIUMUM, SP02_TARIKHUNDIUMUM) values (@userid,@myyear, @tarikh, 'APPS', 1, @lokasiumum, @tarikhumum)  ";
                            mFlag = "1";
                        }
                        else
                        {
                            string mymsg2y1 = Finduser_sp02_undi_det(userid, "umum");
                            if (mymsg2y1 == "0")
                            {
                                CommandText = "update      SP02_UNDI set SP02_UMUM=1, SP02_LOKASIUMUM=@lokasiumum, SP02_TARIKHUNDIUMUM=@tarikhumum  WHERE SP02_IDPENGUNDI = @userid  ";
                                mFlag = "1";
                            }
                        }
                    }
                }  // umum
                else
                {
                    string mymsgp3 = Finduser_sp02_undi(userid);
                    if (mymsgp3 == "0")
                    {
                        CommandText = "INSERT INTO  SP02_UNDI (SP02_IDPENGUNDI, SP02_TAHUN,  SP02_WAKTU, SP02_PC,  SP02_FAKULTI, SP02_LOKASIFAKULTI, SP02_TARIKHUNDIFAKULTI) values (@userid,@myyear,@tarikh,  'APPS', 1, @lokasifakulti, @tarikhfakulti)  ";
                        mFlag = "1";
                    }
                    else
                    {
                        string mymsg2y1z = Finduser_sp02_undi_det(userid, "fakulti");
                        if (mymsg2y1z == "0")
                        {
                            CommandText = "update      SP02_UNDI set SP02_FAKULTI=1, SP02_LOKASIFAKULTI=@lokasifakulti, SP02_TARIKHUNDIFAKULTI=@tarikhfakulti  WHERE SP02_IDPENGUNDI = @userid  ";
                            mFlag = "1";
                        }
                    }
                } // fakulti

                if (mFlag == "1")
                {
                    ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    cmd = new SqlCommand(CommandText);
                    cmd.Parameters.AddWithValue("@userid", userid);
                    cmd.Parameters.AddWithValue("@tarikh", DateTime.Now);
                    cmd.Parameters.AddWithValue("@lokasiumum", "APPS");
                    cmd.Parameters.AddWithValue("@tarikhumum", DateTime.Now);
                    cmd.Parameters.AddWithValue("@lokasifakulti", "APPS");
                    cmd.Parameters.AddWithValue("@tarikhfakulti", DateTime.Now);
                    cmd.Parameters.AddWithValue("@myyear", DateTime.Now.Year.ToString());
                    cmd.Connection = con;
                    rdr = cmd.ExecuteReader();
                    list[0] = "1";
                    list[1] = Finduser_siri(userid);
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


            string[] arrayx = list.ToArray();
            return arrayx;
        }


        public static string GetMTB(string ptj)
        {
            String ConnectionString = "";
            string num = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT SP01_IDCALON FROM SP01_CALON WHERE  SP01_KAWFAKULTI = @ptj and SP01_MTB=1 ";
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@ptj", ptj.Trim().ToUpper());
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                       num = "1"; 
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


            return num;
        }



        public static string GetNumPilih(string ptj, string jenis)
        {
            String ConnectionString = "";
            string num = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT        CASE WHEN SP_HADFAKULTI = 'TIGA (3)' THEN '3' WHEN SP_HADFAKULTI = 'SATU (1)' THEN '1' WHEN SP_HADFAKULTI = 'LAPAN (8)' THEN '8' ELSE '0' END AS myundifakulti,                          CASE WHEN SP_HADUMUM = 'TIGA (3)' THEN '3' WHEN SP_HADUMUM = 'SATU (1)' THEN '1' WHEN SP_HADUMUM = 'LAPAN (8)' THEN '8' ELSE '0' END AS myundiumum FROM            SP_PROGRAM where SP_FAKULTI = @ptj";
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@ptj", ptj.Trim().ToUpper());
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                   if (jenis == "fakulti")
                    {
                        num = rdr["myundifakulti"].ToString().Trim();
                        break;
                    }
                    if (jenis == "umum")
                    {
                        num = rdr["myundiumum"].ToString().Trim();
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


            return num;
        }


            public static IEnumerable<string> GetGeneralSPR(string fakulti)
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

                string CommandText = "SELECT       id, Title, Sesi, Tarikh_Mula, Tarikh_Akhir, Status FROM spr01_general where id=1";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    list.Add(rdr["Title"].ToString().Trim());
                    list.Add(rdr["Sesi"].ToString().Trim());
                    list.Add(rdr["Tarikh_Mula"].ToString().Trim());
                    list.Add(rdr["Tarikh_Akhir"].ToString().Trim());
                    list.Add(rdr["Status"].ToString().Trim());
                  //  list.Add(GetJumlahPilihCalon(fakulti));
                    list.Add(GetNumPilih(fakulti, "fakulti"));
                    


                    a = a + 1;

                }


            }
            catch (Exception)
            {
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

        }
        public static IEnumerable<string> GetCalonUmum(string ptj)
        {
            String ConnectionString = "";
            List<string> list = new List<string>();
            int a = 0;
            // string[] ret;
            //  string[,] twoDimensional;
            //  ret = new string[1];
            // ret[0] = "notfound";
            // ret[0] = "error";
            list.Add(GetNumPilih(ptj, "umum"));
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();

              //  string CommandText = "SELECT   id, matrix_no, kawasan, status FROM spr02_Calon";
                string CommandText = "SELECT A.SP01_IDCALON, B.SMP01_NAMA, B.SMP01_GAMBAR,B.SMP01_NOMATRIK,     B.SMP01_KP, A.SP01_BIL, SP01_MTB, B.SMP01_Fakulti     FROM SP01_CALON A    INNER JOIN SMP01_PERIBADI B    ON A.SP01_IDCALON = B.SMP01_NOMATRIK    WHERE A.SP01_TAHUN = year(getdate())     AND A.SP01_KAWUMUM = 1 AND SP01_MTB = 0 ";
                //cmd.Parameters.AddWithValue("@id_class", ptj);
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    list.Add(rdr["SP01_IDCALON"].ToString().Trim().ToUpper() + ".jpg");
                    a = a + 1;

                }


            }
            catch (Exception)
            {
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

        }
        public static IEnumerable<string> GetCalonFakulti(string ptj)
        {
            String ConnectionString = "";
            List<string> list = new List<string>();
            int a = 0;
            // string[] ret;
            //  string[,] twoDimensional;
            //  ret = new string[1];
            // ret[0] = "notfound";
            // ret[0] = "error";
            list.Add(GetNumPilih(ptj, "fakulti"));
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();

                //  string CommandText = "SELECT   id, matrix_no, kawasan, status FROM spr02_Calon";
                //    string CommandText = "SELECT  SP01_IDCALON, SP01_TAHUN, SP01_KAWFAKULTI, SP01_KAWUMUM, SP01_BIL, SP01_MTB FROM SP01_CALON where SP01_KAWUMUM=1 and SP01_KAWFAKULTI= @id_class";
                string CommandText = "SELECT A.SP01_IDCALON, B.SMP01_NAMA, B.SMP01_GAMBAR,    B.SMP01_NOMATRIK,B.SMP01_KP, A.SP01_BIL, B.SMP01_Fakulti     FROM SP01_CALON A     INNER JOIN SMP01_PERIBADI B     ON A.SP01_IDCALON = B.SMP01_NOMATRIK     WHERE A.SP01_TAHUN = year(getdate()) AND A.SP01_KAWFAKULTI = @id_class      AND A.SP01_MTB = '0'      AND A.SP01_KAWUMUM = 0";

           
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@id_class", ptj.Trim().ToUpper());
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    list.Add(rdr["SP01_IDCALON"].ToString().Trim().ToUpper() + ".jpg");
                    a = a + 1;

                }


            }
            catch (Exception)
            {
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

        }



        public static string GetJumlahPilihCalon(string fakulti)
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
                CommandText = "SELECT   Fakulti, calon_dipilih FROM spr03_detail_kawasan where Fakulti=@fakulti ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@fakulti", fakulti);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["calon_dipilih"].ToString();

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



        public static Tuple<string[], string[]> GetCalonxxxx()
        {
            String ConnectionString = "";
            List<string> list = new List<string>();
            List<string> list2 = new List<string>();
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

                string CommandText = "SELECT         id, matrix_no, kawasan, status FROM spr02_Calon";
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
                    list.Add(rdr["matrix_no"].ToString());
                    list2.Add(rdr["id"].ToString());
                    a = a + 1;

                }


            }
            catch (Exception)
            {
                //return new string[] { "error" };
                list.Add("error");
                list2.Add("error");
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }

            string[] arrayx = list.ToArray();
            string[] arrayx2 = list2.ToArray();
            //  return arrayx;
            //   return new string[] { "error"};

            return Tuple.Create(arrayx, arrayx2);

        }
        public static IEnumerable<string> StatusPilihanraya_kawasan(string studid)
        {



            String ConnectionString = "";
            List<string> list = new List<string>();
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
              
                    ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    string CommandText = "SELECT        SP02_FAKULTI FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class and SP02_FAKULTI=1 ";
                    cmd = new SqlCommand(CommandText);
                    cmd.Parameters.AddWithValue("@id_class", studid);
                    cmd.Connection = con;
                    cmd.CommandText = CommandText;
                    rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        a = a + 1;

                    }
                    if (a == 0) { list.Add("Belum Selesai"); } else { list.Add("Selesai"); }
                

            }
            catch (Exception)
            {
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

        }
        public static string KodFakulti(string nomatrik)
        {
            string mybol = "";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbpilihanraya;
                con = new SqlConnection(ConnectionString);
                con.Open();
                
                CommandText = "SELECT SMP01_Nomatrik, SMP01_Fakulti FROM            SMP01_Peribadi where SMP01_Nomatrik=@nomatrik ";
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
        public static string StatusPilihanraya_kawasan2(string studid)
        {


            String ConnectionString = "";
            string gg = "Belum Selesai";
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            if (GetMTB(KodFakulti(studid)) == "1") { gg = "Selesai"; }
            else
            {
                try
                {
                    // Open connection to the database
                    //  string mtbstatus =  GetMTB(ptj);

                    ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    string CommandText = "SELECT        SP02_FAKULTI FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class and SP02_FAKULTI=1 ";
                    // string CommandText = "SELECT        SP02_FAKULTI FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class and SP02_FAKULTI=1 ";
                    cmd = new SqlCommand(CommandText);
                    cmd.Parameters.AddWithValue("@id_class", studid);
                    cmd.Connection = con;
                    cmd.CommandText = CommandText;
                    rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        a = a + 1;

                    }
                    if (a == 0) { gg = "Belum Selesai"; } else { gg = "Selesai"; }


                }
                catch (Exception)
                {
                    gg = "error";
                }
                finally
                {
                    if (rdr != null)
                        rdr.Close();

                    if (con.State == ConnectionState.Open)
                        con.Close();
                }

            }




            // Open connection to the database

            
          

           
            return gg;

        }

        public static IEnumerable<string> StatusPilihanraya_umum(string studid)
        {
            String ConnectionString = "";
            List<string> list = new List<string>();
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
             //   SELECT TOP(200) SP02_NOSIRI, SP02_IDPENGUNDI, SP02_TAHUN, SP02_PC, SP02_ROSAK, SP02_EKSPORT, SP02_WAKTU, SP02_FAKULTI, SP02_UMUM
//FROM            SP02_UNDI
                string CommandText = "SELECT        SP02_UMUM FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class and SP02_UMUM=1 ";
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@id_class", studid);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    a = a + 1;
                }
                if (a == 0) { list.Add("Belum Selesai"); } else { list.Add("Selesai"); }

            }
            catch (Exception)
            {
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

        }
        public static string Finduser_sp02_undi_det(string studid, string jenis)
        {
            String ConnectionString = "";
            string CommandText = "";
            string msg = "0";
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   SELECT TOP(200) SP02_NOSIRI, SP02_IDPENGUNDI, SP02_TAHUN, SP02_PC, SP02_ROSAK, SP02_EKSPORT, SP02_WAKTU, SP02_FAKULTI, SP02_UMUM
                //FROM            SP02_UNDI
                if (jenis == "umum")
                {
                    CommandText = "SELECT  SP02_UMUM FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class and SP02_UMUM = 1 ";
                }
                else
                {
                    CommandText = "SELECT  SP02_FAKULTI FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class  and SP02_FAKULTI = 1 ";
                }
                
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@id_class", studid);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    a = a + 1;
                }
                if (a == 0) { msg = "0"; } else { msg = "1"; }

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
        public static string Finduser_sp02_undi(string studid)
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
                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   SELECT TOP(200) SP02_NOSIRI, SP02_IDPENGUNDI, SP02_TAHUN, SP02_PC, SP02_ROSAK, SP02_EKSPORT, SP02_WAKTU, SP02_FAKULTI, SP02_UMUM
                //FROM            SP02_UNDI
                string CommandText = "SELECT  SP02_UMUM FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class ";
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@id_class", studid);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    a = a + 1;
                }
                if (a == 0) { msg = "0"; } else { msg = "1"; }

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

        public static string Finduser_siri(string studid)
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
                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   SELECT TOP(200) SP02_NOSIRI, SP02_IDPENGUNDI, SP02_TAHUN, SP02_PC, SP02_ROSAK, SP02_EKSPORT, SP02_WAKTU, SP02_FAKULTI, SP02_UMUM
                //FROM            SP02_UNDI
                string CommandText = "SELECT  SP02_NOSIRI FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class ";
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@id_class", studid);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    msg = rdr["SP02_NOSIRI"].ToString();
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

        public static IEnumerable<string> UpdateKawasan(string studid, string[] namesArray)
        {
            List<string> list = new List<string>();
            try
            {
                using (SqlConnection sqlConn2 = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        int tot = namesArray.Count();

                        for (int i = 0; i < tot; i++)
                        {
                            cmd.CommandText = @"INSERT INTO  spr03_kawasan   (  studentid, calonpilihan) VALUES(@id_class, @id_class2)";

                            cmd.Connection = sqlConn2;
                            //   string hh = GetLastIDClass(user);
                            cmd.Parameters.AddWithValue("@id_class", studid);
                            cmd.Parameters.AddWithValue("@id_class2", namesArray[i]);
                            try
                            {
                                sqlConn2.Open();
                                cmd.ExecuteNonQuery();
                                list.Add("ok");
                            }
                            catch (SqlException e)
                            {
                                list.Add("Capaian ke database bermasalah. Sila cuba lagi");
                            }
                        }


                    }
                }
            }
            catch (Exception ex)
            {
                list.Add("Capaian ke database bermasalah. Sila cuba lagi");
            }

            string[] arrayx = list.ToArray();
            return arrayx;

        }
        public static IEnumerable<string> UpdateUmum(string studid, string[] namesArray)
        {
            List<string> list = new List<string>();
            try
            {
                using (SqlConnection sqlConn2 = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        int tot = namesArray.Count();

                        for (int i= 0; i < tot; i++){ 
                            cmd.CommandText = @"INSERT INTO  spr03_umum   (  studentid, calonpilihan) VALUES(@id_class, @id_class2)";

                            cmd.Connection = sqlConn2;
                            //   string hh = GetLastIDClass(user);
                            cmd.Parameters.AddWithValue("@id_class", studid);
                            cmd.Parameters.AddWithValue("@id_class2", namesArray[i]);
                            try
                            {
                                sqlConn2.Open();
                                cmd.ExecuteNonQuery();
                                list.Add("ok");
                            }
                            catch (SqlException e)
                            {
                                list.Add("Capaian ke database bermasalah. Sila cuba lagi");
                            }
                        }


                    }
                }
            }
            catch (Exception ex)
            {
                list.Add("Capaian ke database bermasalah. Sila cuba lagi");
            }

            string[] arrayx = list.ToArray();
            return arrayx;

        }
        public static string WriteUmumPilihanraya(string userid, string calon, string nosiri)
        {
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbpilihanraya))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"INSERT INTO  SP04_UNDIUMUM   (  SP02_NOSIRI, SP01_IDCALON, SP04_TAHUN, SP04_LOKASIUMUM) VALUES (@nosiri, @calon, @myyear, @lokasi)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@calon", calon);
                        cmd.Parameters.AddWithValue("@nosiri", nosiri);
                        cmd.Parameters.AddWithValue("@lokasi", "APPS");
                        cmd.Parameters.AddWithValue("@myyear", DateTime.Now.Year.ToString());



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
        public static string WriteKawasanPilihanraya(string userid, string calon, string nosiri)
        {
            string myStr = "";
            try
            {
                 using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbpilihanraya))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"INSERT INTO  SP03_UNDIFAKULTI   (  SP02_NOSIRI, SP01_IDCALON, SP03_TAHUN, SP03_LOKASIFAKULTI) VALUES (@nosiri,  @calon, @myyear, @lokasi)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@calon", calon);
                        cmd.Parameters.AddWithValue("@nosiri", nosiri);
                        cmd.Parameters.AddWithValue("@lokasi", "APPS");
                        cmd.Parameters.AddWithValue("@myyear", DateTime.Now.Year.ToString());
                        
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

        public static string pilihanrayaicon(string studid)
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
                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   SELECT TOP(200) SP02_NOSIRI, SP02_IDPENGUNDI, SP02_TAHUN, SP02_PC, SP02_ROSAK, SP02_EKSPORT, SP02_WAKTU, SP02_FAKULTI, SP02_UMUM
                //FROM            SP02_UNDI
                string CommandText = "select SMP01_Nomatrik, SMP01_Fakulti FROM SMP01_Peribadi where   SMP01_Nomatrik=@id_class ";
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@id_class", studid);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                  //  if (rdr["SMP01_Fakulti"].ToString().Trim() == "PPS")
                 //  {
                 //      break;
                  // }
                 //  else
                 // {
                        msg = "1";
                    //   break;
                    //}

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
            //if (msg == "1")
            //{
            //    if (pilihanrayjumcalonumum() == 21)
            //    {

            //    }
            //    else
            //    {
            //         msg = "0";
            //    }
            //}

            return msg;

        }


        public static IEnumerable<string> GetStatusicon_pilihanraya(string user)
        {

            List<string> list = new List<string>();
           // if ((user.ToUpper().Trim() == "B031810230") || (user.ToUpper().Trim() == "B051720049") || (user.ToUpper().Trim() == "BS01181003") || (user.ToUpper().Trim() == "D031810326"))
          //  {
           //     list.Add("1");
           // }
            //else
            //{
             list.Add("0");
          //  }
          
            
            
            
            // list.Add(pilihanrayaicon(user));


            string[] arrayx = list.ToArray();
            return arrayx;

        }
        public static IEnumerable<string> GetStatusOpenClose_pilihanraya()
        {
  
            List<string> list = new List<string>();
            if ((SQLPilihanraya.pilihanrayamula() == true) && (SQLPilihanraya.pilihanraytamat() == false))
            {
                list.Add("1");
            }
            else
            {
                list.Add("0");
            }
           // pilihanrayaopenclose(string studid)



            string[] arrayx = list.ToArray();
            return arrayx;

        }
        public static bool pilihanrayamula()
        {
            String ConnectionString = "";
            bool msg = false;
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {

                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT KodSesi_Sem, StatusMula, StatusTamat, Trk_MasaMula, Trk_MasaTamat  FROM SMP_SesiPengajian WHERE Stat_Skrg = 1 AND Keaktifan = 1 ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    // if (rdr["StatusMula"].ToString() == "1")
                    // {
                    //    msg = true;
                    // }
                    msg = (bool)rdr["StatusMula"];


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


            return msg;

        }
        //SELECT A.SP01_IDCALON, B.SMP01_NAMA, B.SMP01_GAMBAR,B.SMP01_NOMATRIK,     B.SMP01_KP, A.SP01_BIL, SP01_MTB, B.SMP01_Fakulti     FROM SP01_CALON A    INNER JOIN SMP01_PERIBADI B    ON A.SP01_IDCALON = B.SMP01_NOMATRIK    WHERE A.SP01_TAHUN = year(getdate())     AND A.SP01_KAWUMUM = 1 AND SP01_MTB = 0 
        public static bool pilihanraytamat()
        {
            String ConnectionString = "";
            bool msg = false;
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {

                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT KodSesi_Sem, StatusMula, StatusTamat, Trk_MasaMula, Trk_MasaTamat  FROM SMP_SesiPengajian WHERE Stat_Skrg = 1 AND Keaktifan = 1 ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                   // if (rdr["StatusTamat"].ToString() == "1")
                  //  {
                   //     msg = true;
                   // }
                    msg = (bool)rdr["StatusTamat"];

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


            return msg;

        }
        public static int pilihanrayjumcalonumum()
        {
            String ConnectionString = "";
            int msg = 0;
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {

                ConnectionString = SQLAuth.dbase_dbpilihanraya; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT A.SP01_IDCALON, B.SMP01_NAMA, B.SMP01_GAMBAR,B.SMP01_NOMATRIK,     B.SMP01_KP, A.SP01_BIL, SP01_MTB, B.SMP01_Fakulti     FROM SP01_CALON A    INNER JOIN SMP01_PERIBADI B    ON A.SP01_IDCALON = B.SMP01_NOMATRIK    WHERE A.SP01_TAHUN = year(getdate())     AND A.SP01_KAWUMUM = 1 AND SP01_MTB = 0 ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    // if (rdr["StatusTamat"].ToString() == "1")
                    //  {
                    //     msg = true;
                    // }

                    msg++;

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


            return msg;

        }
    }
}