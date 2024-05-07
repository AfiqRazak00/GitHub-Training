using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

namespace WebApi
{
    public class SQLPilihanrayase
    {
        public static IEnumerable<string> GetCalonzon(string Kategori)
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
                String ConnectionString = SQLAuth.dbase_dbpilihansenat;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT a.SP01_IDCALON, a.Kategori, b.SMP01_Nama, b.Gelaran, b.SMP01_Nomatrik FROM SP01_CALON as a , SMP01_Peribadi as b WHERE a.SP01_IDCALON = b.SMP01_Nomatrik and a.Kategori = @Kategori order by sp01_bil asc";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@Kategori", Kategori);
                // cmd.Parameters.AddWithValue("@sessi", sessi);

                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["Gelaran"].ToString().Trim() + " " + rdr["SMP01_Nama"].ToString().Trim());
                    myList.Add(rdr["SP01_IDCALON"].ToString().Trim());

                    myList.Add(rdr["Kategori"].ToString().Trim());
                    myList.Add(rdr["Kategori"].ToString().Trim());
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
                ConnectionString = SQLAuth.dbase_dbpilihansenat; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   SELECT TOP(200) SP02_NOSIRI, SP02_IDPENGUNDI, SP02_TAHUN, SP02_PC, SP02_ROSAK, SP02_EKSPORT, SP02_WAKTU, SP02_FAKULTI, SP02_UMUM
                //FROM            SP02_UNDI
                string CommandText = "select SMP01_Nama, Gelaran, SMP01_KP, SMP01_Nomatrik FROM SMP01_Peribadi where   SMP01_Nomatrik=@id_class ";
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


            return msg;

        }
        public static string pilihanrayaopenclose(string studid)
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
                ConnectionString = SQLAuth.dbase_dbpilihansenat; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   SELECT TOP (200) KodSesi_Sem, Keterangan, Sesi_Sem_Lepas, Sesi_Sem_Depan, Stat_Skrg, Keaktifan, Bil, TrkMula_Sem, TrkTamat_Sem, SMP_Sesi_Flag, TrkMula_Exam, TrkTamat_Exam, StatusMula, Trk_MasaMula, StatusTamat, 
                string CommandText = "SELECT Trk_MasaMula, Trk_MasaTamat FROM SMP_SesiPengajian WHERE(CAST(GETDATE() AS DATETIME) BETWEEN CAST(Trk_MasaMula AS DATETIME) AND CAST(Trk_MasaTamat AS DATETIME))  ";
                cmd = new SqlCommand(CommandText);
               // cmd.Parameters.AddWithValue("@id_class", studid);
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


            return msg;

        }


        public static IEnumerable<string> GetStatusicon_pilihanraya(string user)
        {

            List<string> list = new List<string>();
           list.Add("0");
          //  list.Add(pilihanrayaicon(user));


            string[] arrayx = list.ToArray();
            return arrayx;

        }
        public static IEnumerable<string> GetStatusOpenClose_pilihanraya(string user)
        {

            List<string> list = new List<string>();
            list.Add("0");
          // list.Add(pilihanrayaopenclose(user));



            string[] arrayx = list.ToArray();
            return arrayx;

        }

        public static IEnumerable<string> StatusPilihanraya(string studid, string zon)
        {


            string CommandText = "";
            String ConnectionString = "";
            List<string> list = new List<string>();
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database

                ConnectionString = SQLAuth.dbase_dbpilihansenat; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                if (zon == "KAT1")
                {
                    CommandText = "SELECT        SP02_FAKULTI FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class and SP02_FAKULTI=1 ";

                }
                if (zon == "KAT2")
                {
                    CommandText = "SELECT        SP02_FAKULTI FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class and SP02_Fakulti2=1 ";

                }
                if (zon == "KAT3")
                {
                    CommandText = "SELECT        SP02_FAKULTI FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class and SP02_umum=1 ";

                }
                cmd = new SqlCommand(CommandText);
                cmd.Parameters.AddWithValue("@id_class", studid);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    a = a + 1;
                    break;

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

        public static string WriteUmumPilihanraya(string userid, string calon, string nosiri)
        {
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbpilihansenat))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"INSERT INTO  SP04_UNDIUMUM   (  SP02_NOSIRI, SP01_IDCALON, SP04_TAHUN, SP04_LOKASIUMUM) VALUES (@nosiri, @calon, '2020', @lokasi)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@calon", calon);
                        cmd.Parameters.AddWithValue("@nosiri", nosiri);
                        cmd.Parameters.AddWithValue("@lokasi", "APPS");



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
                        string mymsgp1 = Finduser_sp02_undi(userid);
                        if (mymsgp1 == "0")
                        {
                            if (jenis == "KAT1")
                            {
                        CommandText = "INSERT INTO  SP02_UNDI (SP02_IDPENGUNDI, SP02_TAHUN,  SP02_WAKTU, SP02_PC,  SP02_fakulti, SP02_LOKASIUMUM, SP02_TARIKHUNDIUMUM) values (@userid,'2020', @tarikh, 'APPS', 1, @lokasiumum, @tarikhumum)  ";
                        mFlag = "1";
                            }
                            if (jenis == "KAT2")
                            {
                        CommandText = "INSERT INTO  SP02_UNDI (SP02_IDPENGUNDI, SP02_TAHUN,  SP02_WAKTU, SP02_PC,  SP02_fakulti2, SP02_LOKASIUMUM, SP02_TARIKHUNDIUMUM) values (@userid,'2020', @tarikh, 'APPS', 1, @lokasiumum, @tarikhumum)  ";
                        mFlag = "1";
                            }
                            if (jenis == "KAT3")
                            {
                        CommandText = "INSERT INTO  SP02_UNDI (SP02_IDPENGUNDI, SP02_TAHUN,  SP02_WAKTU, SP02_PC,  SP02_UMUM, SP02_LOKASIUMUM, SP02_TARIKHUNDIUMUM) values (@userid,'2020', @tarikh, 'APPS', 1, @lokasiumum, @tarikhumum)  ";
                        mFlag = "1";
                            }
                  //  CommandText = "INSERT INTO  SP02_UNDI (SP02_IDPENGUNDI, SP02_TAHUN,  SP02_WAKTU, SP02_PC,  SP02_UMUM, SP02_LOKASIUMUM, SP02_TARIKHUNDIUMUM) values (@userid,'2020', @tarikh, 'APPS', 1, @lokasiumum, @tarikhumum)  ";
                          //  mFlag = "1";
                        }
                        else
                        {
                          //  string mymsg2y1 = Finduser_sp02_undi_det(userid, "umum");
                          //  if (mymsg2y1 == "0")
                           // {
                           if (jenis == "KAT1")
                            {
                                CommandText = "update      SP02_UNDI set SP02_fakulti=1, SP02_LOKASIUMUM=@lokasiumum, SP02_TARIKHUNDIUMUM=@tarikhumum  WHERE SP02_IDPENGUNDI = @userid  ";
                                mFlag = "1";
                            }
                            if (jenis == "KAT2")
                            {
                                CommandText = "update      SP02_UNDI set SP02_fakulti2=1, SP02_LOKASIUMUM=@lokasiumum, SP02_TARIKHUNDIUMUM=@tarikhumum  WHERE SP02_IDPENGUNDI = @userid  ";
                                mFlag = "1";
                            }
                            if (jenis == "KAT3")
                            {
                                CommandText = "update      SP02_UNDI set SP02_UMUM=1, SP02_LOKASIUMUM=@lokasiumum, SP02_TARIKHUNDIUMUM=@tarikhumum  WHERE SP02_IDPENGUNDI = @userid  ";
                                mFlag = "1";
                            }
                    //  }
                }
                    
                

                if (mFlag == "1")
                {
                    ConnectionString = SQLAuth.dbase_dbpilihansenat; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    cmd = new SqlCommand(CommandText);
                    cmd.Parameters.AddWithValue("@userid", userid);
                    cmd.Parameters.AddWithValue("@tarikh", DateTime.Now);
                    cmd.Parameters.AddWithValue("@lokasiumum", "APPS");
                    cmd.Parameters.AddWithValue("@tarikhumum", DateTime.Now);
                    cmd.Parameters.AddWithValue("@lokasifakulti", "APPS");
                    cmd.Parameters.AddWithValue("@tarikhfakulti", DateTime.Now);
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
                ConnectionString = SQLAuth.dbase_dbpilihansenat; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //   SELECT TOP(200) SP02_NOSIRI, SP02_IDPENGUNDI, SP02_TAHUN, SP02_PC, SP02_ROSAK, SP02_EKSPORT, SP02_WAKTU, SP02_FAKULTI, SP02_UMUM
                //FROM            SP02_UNDI

                    CommandText = "SELECT  SP02_UMUM FROM SP02_UNDI where  SP02_IDPENGUNDI=@id_class and SP02_UMUM = 1 ";
                

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
                ConnectionString = SQLAuth.dbase_dbpilihansenat; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
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
                ConnectionString = SQLAuth.dbase_dbpilihansenat; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
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
    }
}