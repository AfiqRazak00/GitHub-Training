

using System;

using System.Data.SqlClient;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Device.Location;

using System.Data;

namespace WebApi
{
    public class SQLKuliahStudent
    {

        public static int updatedatabaru_notmyutem_attd(string userid, string clientid, string sessid, string clientip)
        {
            int mybol = 0;
            try
            {

                SqlDataReader rdr = null;
                SqlConnection con = null;
                SqlCommand cmd = null;
                var Timestamp = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds();
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";

                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "update      std04_session set sesion_id= @SESSID,   client_ip  = @CLIENTIP  WHERE staff_no = @USERID  ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@SESSID", System.Data.SqlDbType.NVarChar, 500, "SESSID"));  // The name of the source column
                cmd.Parameters["@SESSID"].Value = sessid;
                cmd.Parameters.Add(new SqlParameter("@CLIENTIP", System.Data.SqlDbType.NVarChar, 20, "CLIENTIP"));  // The name of the source column
                cmd.Parameters["@CLIENTIP"].Value = clientip;
                cmd.Parameters.Add(new SqlParameter("@USERID", System.Data.SqlDbType.NVarChar, 256, "USERID"));  // The name of the source column
                cmd.Parameters["@USERID"].Value = userid;

                mybol = cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                return mybol;

            }
            return mybol;
        }


        public static int insertdatabaru_notmyutem_attd(string userid, string clientid, string sessid, string clientip)
        {
            int mybol = 0;
            try
            {

                SqlDataReader rdr = null;
                SqlConnection con = null;
                SqlCommand cmd = null;
                var Timestamp = new DateTimeOffset(DateTime.UtcNow).ToUnixTimeSeconds();
                String ConnectionString = @"Data Source='V-SQL14.utem.edu.my\SQL_INS04';Initial Catalog='DbMobile';User ID='MobApp';Password='m0bile@pp2018'";

                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "insert into  std04_session (staff_no, sesion_id,client_ip) values (@USERID, @SESSID, @CLIENTIP)";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.Add(new SqlParameter("@SESSID", System.Data.SqlDbType.NVarChar, 500, "SESSID"));  // The name of the source column
                cmd.Parameters["@SESSID"].Value = sessid;
                cmd.Parameters.Add(new SqlParameter("@CLIENTIP", System.Data.SqlDbType.NVarChar, 20, "CLIENTIP"));  // The name of the source column
                cmd.Parameters["@CLIENTIP"].Value = clientip;
                cmd.Parameters.Add(new SqlParameter("@USERID", System.Data.SqlDbType.NVarChar, 256, "USERID"));  // The name of the source column
                cmd.Parameters["@USERID"].Value = userid;

                mybol = cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                return mybol;

            }
            return mybol;
        }
        //GetSessiList  GetSessiSum

        public static IEnumerable<string> GetHutang(string userid)
        {
            string[] ret = new string[2];
            ret[0] = "no";
            double HutYuran = 0;
            double HutDenda = 0;
            double HutPjp = 0;
            double HutKonvo = 0;
            double HutTotal = 0;

            List<string> myList = new List<string>();
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string stahutang = "0";
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
              //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
                string CommandText = "select a.SMP01_NOMATRIK,smp01_nama, smp01_status,SMP01_Fakulti,smp01_kursus, smp51_jenisDC,sum(SMP51_JumDC)-sum(SMP51_JumBayar)as Hutang from SMP51_APDebitCaj a inner join SMP01_Peribadi b on a.SMP01_NOMATRIK = b.SMP01_NOMATRIK where a.SMP01_NOMATRIK = @userid and SMP51_Status<>1 group by a.SMP01_NOMATRIK,smp01_nama, smp01_status,SMP01_Fakulti,smp01_kursus, smp51_jenisDC";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    stahutang = "1";
                    if (rdr["smp51_jenisDC"].ToString().Contains("YURAN"))
                    {
                        HutYuran = HutYuran + double.Parse(rdr["Hutang"].ToString());
                    } else if (rdr["smp51_jenisDC"].ToString().Contains("PJP")) { 
                    
                        HutPjp = HutPjp + double.Parse(rdr["Hutang"].ToString());

                    } else if (rdr["smp51_jenisDC"].ToString().Contains("DENDA")) {
                        HutDenda = HutDenda + double.Parse(rdr["Hutang"].ToString());
                    }
                    else if (rdr["smp51_jenisDC"].ToString().Contains("KONVO"))
                    {
                        HutKonvo = HutKonvo + double.Parse(rdr["Hutang"].ToString());
                    }
                    else 
                    {
                       // 
                    }

                }
                HutTotal = HutYuran + HutPjp + HutDenda + HutKonvo;
                if (stahutang == "1")
                {
                    myList.Add("hutang");
                    myList.Add(HutTotal.ToString());  // jum hutanh
                    myList.Add(HutYuran.ToString());  // jum yuran
                    myList.Add(HutDenda.ToString());  // jum denda
                    myList.Add(HutPjp.ToString());  // jum pip
                    myList.Add(HutKonvo.ToString());  // jum pip
                }
                else
                {
                    myList.Add("tiada");
                }
             //   myList.Add("tiada hutang");
             //   myList.Add("0.00");  // jum hutanh
             //   myList.Add("0.00");  // jum yuran
             //   myList.Add("0.00");  // jum denda
             //   myList.Add("0.00");  // jum pip
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
        public static string DetailGetHutangPasca(string userid, string jenis, string denda)
        {
            //  string[,] twoDimensional;
            String ConnectionString = "";
            string CommandText = "";
            double jum = 0;
            string mjum = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                if (jenis == "bs") { 
                    ConnectionString = SQLAuth.dbase_dbstudentpsh;
                    CommandText = "SELECT SMP01_Nama,SMP01_Peribadi.SMP01_NOMATRIK , SUM(SMP51_JUMDC) - SUM(SMP51_jumBayar) - SUM(SMP51_jumKC) as Hutang FROM SMP51_APDebitCaj INNER JOIN SMP01_Peribadi ON SMP01_Peribadi.SMP01_NOMATRIK = SMP51_APDebitCaj.SMP01_Nomatrik WHERE SMP51_APDebitCaj.SMP01_Nomatrik = @userid AND SMP51_STATUS<> 1 AND SMP51_JENISDC LIKE @denda GROUP BY SMP01_Nama,SMP01_Peribadi.SMP01_NOMATRIK";

                }
                else { 
                    ConnectionString = SQLAuth.dbase_dbstudent;
                    CommandText = "SELECT SMG02_Nama,SMG02_Peribadi.SMG01_NOMATRIK , SUM(smg27_JUMDC) - SUM(smg27_jumBayar) - SUM(smg27_jumKC) as Hutang FROM SMG27_APDEBITCAJ INNER JOIN SMG02_Peribadi ON SMG02_Peribadi.SMG01_NOMATRIK = SMG27_APDEBITCAJ.SMG01_Nomatrik WHERE SMG27_APDEBITCAJ.SMG01_Nomatrik = @userid AND smg27_STATUS<> 1 AND SMG27_JenisDC LIKE @denda GROUP BY SMG02_Nama,SMG02_Peribadi.SMG01_NOMATRIK"; 

                }

                con = new SqlConnection(ConnectionString);
                con.Open();
  
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@denda", "%" + denda + "%");
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    jum = jum + double.Parse(rdr["Hutang"].ToString());
                }
                return jum.ToString();
            }
            catch (Exception)
            {
                return "no";
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        public static IEnumerable<string> GetHutang_pasca(string userid, string jenis)
        {
            string[] ret = new string[2];
            ret[0] = "no";


            List<string> myList = new List<string>();


            try
            {
                string myyuran = DetailGetHutangPasca(userid, jenis, "Yuran");  // jum yuran
                string mydenda = DetailGetHutangPasca(userid, jenis, "Denda");  // jum denda
                string mypjp = DetailGetHutangPasca(userid, jenis, "Pjp");  // jum pip
                string mykonvo = DetailGetHutangPasca(userid, jenis, "Konvo");  // jum pip
                double totHutang = double.Parse(myyuran)  + double.Parse(mydenda) + double.Parse(mypjp) + double.Parse(mykonvo); 

                totHutang = 0;
                if (totHutang == 0) {
                    myList.Add("tiada");
                }
                else
                {
                    myList.Add("hutang");
                    myList.Add(totHutang.ToString());  // jum hutanh
                    myList.Add(myyuran);  // jum yuran
                    myList.Add(mydenda);  // jum denda
                    myList.Add(mypjp);  // jum pip
                    myList.Add(mykonvo);  // jum pip
                }
  
                
                return myList;
            }
            catch (Exception)
            {
                return ret;
            }
            finally
            {
  
            }
        }

        public static IEnumerable<string> GetSessiSum(string userid, string sesi)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
              //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
               // string CommandText = "";
                string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) AND (b.KodSesi_Sem=@sesi) ORDER BY c.Bil DESC";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sesi", sesi);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                   // myList.Add(rdr["KodSesi_Sem"].ToString());
                     myList.Add(rdr["SMP18_GPA"].ToString());
                    myList.Add(rdr["SMP18_CGPA"].ToString());
                    myList.Add(GetJamKreditDapat(userid, sesi));
                    //  myList.Add(rdr["ap04_nama"].ToString());

                    // myList.Add("vff");


                }
              //  myList.Add("3.44");
               // myList.Add("1.44");
              //  myList.Add(sesi);
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
        }
        public static IEnumerable<string> GetSessiSum_pm(string userid, string sesi)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
                // string CommandText = "";
                string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) AND (b.KodSesi_Sem=@sesi) ORDER BY c.Bil DESC";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sesi", sesi);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    // myList.Add(rdr["KodSesi_Sem"].ToString());
                    myList.Add(rdr["SMP18_GPA"].ToString());
                    myList.Add(rdr["SMP18_CGPA"].ToString());
                    myList.Add(GetJamKreditDapat(userid, sesi));
                    //  myList.Add(rdr["ap04_nama"].ToString());

                    // myList.Add("vff");


                }
                //  myList.Add("3.44");
                // myList.Add("1.44");
                //  myList.Add(sesi);
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
        }
        public static IEnumerable<string> GetSessiSum_bs(string userid, string sesi)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
                // string CommandText = "";
                string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) AND (b.KodSesi_Sem=@sesi) ORDER BY c.Bil DESC";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sesi", sesi);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    // myList.Add(rdr["KodSesi_Sem"].ToString());
                    myList.Add(rdr["SMP18_GPA"].ToString());
                    myList.Add(rdr["SMP18_CGPA"].ToString());
                    myList.Add(GetJamKreditDapat(userid, sesi));
                    //  myList.Add(rdr["ap04_nama"].ToString());

                    // myList.Add("vff");


                }
                //  myList.Add("3.44");
                // myList.Add("1.44");
                //  myList.Add(sesi);
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
        }
        public static IEnumerable<string> GetSessiList(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["KodSesi_Sem"].ToString());
                   // myList.Add(rdr["SMP18_GPA"].ToString());
                   // myList.Add(rdr["SMP18_CGPA"].ToString());
                    //  myList.Add(rdr["ap04_nama"].ToString());

                   // myList.Add("vff");


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
        }
        public static IEnumerable<string> GetBankList(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbclm;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT   KodBank, Bank FROM FPX_Bank";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["Bank"].ToString());
                    // myList.Add(rdr["SMP18_GPA"].ToString());
                    // myList.Add(rdr["SMP18_CGPA"].ToString());
                    //  myList.Add(rdr["ap04_nama"].ToString());

                    // myList.Add("vff");


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
        }
        public static IEnumerable<string> GetSumbList(string userid)
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
               
               //     myList.Add(rdr["KodBank"].ToString());
                // myList.Add(rdr["SMP18_GPA"].ToString());
                // myList.Add(rdr["SMP18_CGPA"].ToString());


                myList.Add("Sumbangan");
                myList.Add("Endowmen");
                myList.Add("Waqaf");
                myList.Add("Bantuan Bencana");
                myList.Add("Masjid UTeM");
                myList.Add("Program Pensijilan Tahfiz UTeM");
                myList.Add("Rumah Alumni UTeM");
                myList.Add("Ihya' Ramadan 1444H UTeM");



                return myList;
            }
            catch (Exception)
            {
                return ret;
            }
            finally
            {
              
            }
        }

        public static string GetJamKreditDapat(string userid, string sesi)
        {
            //  string[,] twoDimensional;
            //  twoDimensional = new string[1, 4];
            int jum = 0;
            string mjum = "";
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
                //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
                string CommandText = "SELECT SMP11_MPPelajar.SMP07_KodMP, b.SMP07_NamaMP, a.SMP17_Markah + a.SMP17_Mrk_Ubah AS markah, b.SMP07_Kredit, a.SMP17_Gred, a.SMP17_MNilaian, a.SMP17_Status, SMP11_MPPelajar.KodSesi_Sem,                   SMP11_MPPelajar.SMP11_Status, SMP18_KreditDT.SMP18_Pgsh FROM     SMP_SesiPengajian AS c INNER JOIN                   SMP17_MarkahKH AS a ON c.KodSesi_Sem = a.KodSesi_Sem INNER JOIN                   SMP18_KreditDT ON c.KodSesi_Sem = SMP18_KreditDT.KodSesi_Sem RIGHT OUTER JOIN                   SMP07_Matapelajaran AS b INNER JOIN                   SMP11_MPPelajar ON b.SMP07_KodMP = SMP11_MPPelajar.SMP07_KodMP ON SMP18_KreditDT.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.SMP07_KodMP = b.SMP07_KodMP AND                   a.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.KodSesi_Sem = SMP11_MPPelajar.KodSesi_Sem WHERE(SMP11_MPPelajar.SMP01_NOMATRIK = @userid) AND(SMP18_KreditDT.SMP18_Pgsh = 1) AND(a.KodSesi_Sem = @sesi) ORDER BY c.Bil, SMP11_MPPelajar.KodSesi_Sem";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sesi", sesi);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    jum = jum + Int32.Parse(rdr["SMP07_Kredit"].ToString());

                  //  myList.Add(rdr["SMP07_Kredit"].ToString());



                }
                return jum.ToString();
            }
            catch (Exception)
            {
                return "no";
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
                // return twoDimensionalx;
            }
        }
        public static IEnumerable<string> GetStudentResultDetNew_pm(string userid, string sesi)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
                string CommandText = "SELECT SMP11_MPPelajar.SMP07_KodMP, b.SMP07_NamaMP, a.SMP17_Markah + a.SMP17_Mrk_Ubah AS markah, b.SMP07_Kredit, a.SMP17_Gred, a.SMP17_MNilaian, a.SMP17_Status, SMP11_MPPelajar.KodSesi_Sem,                   SMP11_MPPelajar.SMP11_Status, SMP18_KreditDT.SMP18_Pgsh FROM     SMP_SesiPengajian AS c INNER JOIN                   SMP17_MarkahKH AS a ON c.KodSesi_Sem = a.KodSesi_Sem INNER JOIN                   SMP18_KreditDT ON c.KodSesi_Sem = SMP18_KreditDT.KodSesi_Sem RIGHT OUTER JOIN                   SMP07_Matapelajaran AS b INNER JOIN                   SMP11_MPPelajar ON b.SMP07_KodMP = SMP11_MPPelajar.SMP07_KodMP ON SMP18_KreditDT.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.SMP07_KodMP = b.SMP07_KodMP AND                   a.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.KodSesi_Sem = SMP11_MPPelajar.KodSesi_Sem WHERE(SMP11_MPPelajar.SMP01_NOMATRIK = @userid) AND(SMP18_KreditDT.SMP18_Pgsh = 1) AND(a.KodSesi_Sem = @sesi) ORDER BY c.Bil, SMP11_MPPelajar.KodSesi_Sem";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sesi", sesi);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["SMP07_NamaMP"].ToString());

                    myList.Add(rdr["SMP17_Gred"].ToString());
                    myList.Add(rdr["SMP07_Kredit"].ToString());
                    myList.Add(rdr["SMP17_MNilaian"].ToString());
                    //  myList.Add(rdr["ap04_nama"].ToString());

                    //   myList.Add(sesi);


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
        }
        public static IEnumerable<string> GetStudentResultDetNew_bs(string userid, string sesi)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
                string CommandText = "SELECT SMP11_MPPelajar.SMP07_KodMP, b.SMP07_NamaMP, a.SMP17_Markah + a.SMP17_Mrk_Ubah AS markah, b.SMP07_Kredit, a.SMP17_Gred, a.SMP17_MNilaian, a.SMP17_Status, SMP11_MPPelajar.KodSesi_Sem,                   SMP11_MPPelajar.SMP11_Status, SMP18_KreditDT.SMP18_Pgsh FROM     SMP_SesiPengajian AS c INNER JOIN                   SMP17_MarkahKH AS a ON c.KodSesi_Sem = a.KodSesi_Sem INNER JOIN                   SMP18_KreditDT ON c.KodSesi_Sem = SMP18_KreditDT.KodSesi_Sem RIGHT OUTER JOIN                   SMP07_Matapelajaran AS b INNER JOIN                   SMP11_MPPelajar ON b.SMP07_KodMP = SMP11_MPPelajar.SMP07_KodMP ON SMP18_KreditDT.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.SMP07_KodMP = b.SMP07_KodMP AND                   a.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.KodSesi_Sem = SMP11_MPPelajar.KodSesi_Sem WHERE(SMP11_MPPelajar.SMP01_NOMATRIK = @userid) AND(SMP18_KreditDT.SMP18_Pgsh = 1) AND(a.KodSesi_Sem = @sesi) ORDER BY c.Bil, SMP11_MPPelajar.KodSesi_Sem";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sesi", sesi);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["SMP07_NamaMP"].ToString());

                    myList.Add(rdr["SMP17_Gred"].ToString());
                    myList.Add(rdr["SMP07_Kredit"].ToString());
                    myList.Add(rdr["SMP17_MNilaian"].ToString());
                    //  myList.Add(rdr["ap04_nama"].ToString());

                    //   myList.Add(sesi);


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
        }

        public static string GetSamanPaid(string samanid)
        {
            String ConnectionString = "";
            string msg = "0";
            int a = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {

                ConnectionString = SQLAuth.dbase_dbmobile; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
             //   SELECT TOP(200) Tran_id, Ref_id, userid, mydate_req, status_tran, status_migs, mydate_migs, amt_pay, vpc_MerchTxnRef, note, jenis_modul, vpc_TxnResponseCode

                string CommandText = "SELECT vpc_TxnResponseCode FROM migs_payment WHERE Ref_id = @userid ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", samanid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if (rdr["vpc_TxnResponseCode"].ToString().Trim() == "0")
                      {
                        msg = "1";
                    }
                    else
                    {
                        msg = "0";
                    }
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


            return msg;

        }
        public static IEnumerable<string> GetStudentSaman(string userid, string sesi, string jenis)
        {
            //  string[,] twoDimensional;GetStudentSamanDetail
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
                String ConnectionString = SQLAuth.dbase_dbspku;
                con = new SqlConnection(ConnectionString);
                con.Open();
                //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
               // string CommandText = "SELECT SMP11_MPPelajar.SMP07_KodMP, b.SMP07_NamaMP, a.SMP17_Markah + a.SMP17_Mrk_Ubah AS markah, b.SMP07_Kredit, a.SMP17_Gred, a.SMP17_MNilaian, a.SMP17_Status, SMP11_MPPelajar.KodSesi_Sem,                   SMP11_MPPelajar.SMP11_Status, SMP18_KreditDT.SMP18_Pgsh FROM     SMP_SesiPengajian AS c INNER JOIN                   SMP17_MarkahKH AS a ON c.KodSesi_Sem = a.KodSesi_Sem INNER JOIN                   SMP18_KreditDT ON c.KodSesi_Sem = SMP18_KreditDT.KodSesi_Sem RIGHT OUTER JOIN                   SMP07_Matapelajaran AS b INNER JOIN                   SMP11_MPPelajar ON b.SMP07_KodMP = SMP11_MPPelajar.SMP07_KodMP ON SMP18_KreditDT.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.SMP07_KodMP = b.SMP07_KodMP AND                   a.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.KodSesi_Sem = SMP11_MPPelajar.KodSesi_Sem WHERE(SMP11_MPPelajar.SMP01_NOMATRIK = @userid) AND(SMP18_KreditDT.SMP18_Pgsh = 1)  ORDER BY c.Bil, SMP11_MPPelajar.KodSesi_Sem";
                string CommandText = " SELECT  PS01_IDSaman, PK_IDKenderaan, PK_NoDaftarK, MS01_NoStaf, SMP01_NoMatrik, PK_NoPekerja, PS01_Nama, PS01_Status, PS01_JenSaman, PS01_TkhSaman,  ";
                CommandText = CommandText + " PS01_MasaSaman, PS01_NoStafSaman, PS01_JumSaman, PS01_StaSlip, PS01_StaKunci, PS01_Model, AMS114_BangunanID, PS01_Lokasi, PS01_NamaGambar, PS01_FolderGambar,  ";
                CommandText = CommandText + " PS01_TerimaOKS, PS01_NoResitSaman, PS01_Pemilikan, PS01_JumRayuan, PS01_FolderRayuan, PS01_FailRayuan, PS01_TkhRayuan, PS01_TkhLulusRayuan, PS01_TkhRayuanDiterima,  ";
                CommandText = CommandText + " PS01_TarikhRayuanDitolak, PS01_JumDiBayar, PS03_TkhHantarEmail, PS01_UlasanPeg, PS01_TkhBayaran, PS01_NoResit, PS01_IDStaf, PS01_TraceCode, PS01_TkhWujud,  ";
                CommandText = CommandText + "  PS01_NoAkhir ";
                CommandText = CommandText + " FROM         PS01_Saman where SMP01_NoMatrik=@userid";

                CommandText = " SELECT a.PS01_status, b.PS_Butiran as dd,  a.PS01_IDSaman, CONVERT(VARCHAR(10), a.PS01_TkhSaman, 105) as df, c.PS_JenSaman, c.PS_Butiran, c.PS_StaJenSaman, c.PS_Jumlah ";
                if (jenis == "student")
                {
                    CommandText = CommandText + " FROM     PS_Status as b,     PS01_Saman as a,  PS_JenSaman as c  where b.PS_Status = a.PS01_Status  and c.PS_JenSaman = a.PS01_JenSaman  and a.SMP01_NoMatrik=@userid";
                }
                else
                {
                    CommandText = CommandText + " FROM     PS_Status as b,     PS01_Saman as a,  PS_JenSaman as c  where b.PS_Status = a.PS01_Status  and c.PS_JenSaman = a.PS01_JenSaman  and a.MS01_NoStaf=@userid";

                }

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    string jumsaman = "0";
                    jumsaman = GetJumlahSaman(rdr["PS01_IDSaman"].ToString(), rdr["PS_JenSaman"].ToString().Trim());
                    if (jumsaman == "0") { }
                    else
                    {
                        myList.Add(rdr["PS01_IDSaman"].ToString());
                        myList.Add(rdr["df"].ToString());
                        myList.Add(jumsaman);
                        if (rdr["PS01_status"].ToString() == "02") {
                            // dah bayar 
                            myList.Add("1");
                        } else {
                            // belum bayar
                            myList.Add("0");
                               
                        }
                     
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
        public static IEnumerable<string> BayarSaman(string userid, string samanid, string jumlah)
        {
            bool mfound = false;
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                string hg = Writebayarmigs(userid, samanid, jumlah);
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = " SELECT  Tran_id, Ref_id, userid, mydate_req, status_tran, status_migs, mydate_migs, amt_pay, vpc_MerchTxnRef, note, jenis_modul, vpc_TxnResponseCode  ";
                CommandText = CommandText + " FROM migs_payment where Ref_id=@samanid";


                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@samanid", samanid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                      myList.Add(rdr["Tran_id"].ToString());
                      myList.Add(rdr["Ref_id"].ToString());
                      mfound = true;
                      break;

                }
                return myList;
            }
            catch (Exception)
            {
                ret[1] = "ID Saman tidak wujud";
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


        public static string Writebayarmigs(string userid, string samanid, string jumlah)
        {
            DateTime mydate = DateTime.Now;
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"INSERT INTO  migs_payment   (Ref_id, userid, mydate_req, status_tran, status_migs,amt_pay, note,  jenis_modul) VALUES (@samanid, @USERID,  @mydate, '0', '0',@jumlah, 'Saman', 'Saman')";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@samanid", samanid);
                        cmd.Parameters.AddWithValue("@jumlah", jumlah);
                        cmd.Parameters.AddWithValue("@mydate",mydate);




                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            myStr = e.Message; // "Capaian ke database bermasalah. Sila cuba lagi";
                            string gg1 = updatebayarmigs(userid, samanid, jumlah);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                myStr = ex.Message; //"Capaian ke database bermasalah. Sila cuba lagi";
                string gg2 = updatebayarmigs(userid, samanid, jumlah);
            }
            return myStr;
        }

        public static string updatebayarmigs(string userid, string samanid, string jumlah)
        {
            DateTime mydate = DateTime.Now;
            string myStr = "";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"update  migs_payment  set   amt_pay=@jumlah, mydate_req=@mydate, status_tran='0', status_migs='0'  where Ref_id=@samanid";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@samanid", samanid);
                        cmd.Parameters.AddWithValue("@jumlah", jumlah);
                        cmd.Parameters.AddWithValue("@mydate", mydate);




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

        public static IEnumerable<string> GetDetailResetPassword(string bahasa, string userid, string samanid)
        {
            string idbayar = "";
            string tkhbayar = "";
            string jumbayar = "";
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
                string CommandText = "SELECT   id, user_id, email, mypassword, convert(varchar,mydate, 13)  as mydatein, mymodul, mytype, status, note      FROM            AspNetResetEmail where id=@samanid order by id desc";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@samanid", samanid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if (bahasa == "malay")
                    {
                        myList.Add("ID# : " + rdr["id"].ToString().Trim());
                        myList.Add("Tarikh : " + rdr["mydatein"].ToString().Trim());
                        myList.Add("Modul : " + rdr["mymodul"].ToString().Trim());
                        if (rdr["mymodul"].ToString().Trim() == "email") { myList.Add("ID Email : " + rdr["email"].ToString().Trim()); } else { myList.Add("ID Akaun : " + rdr["user_id"].ToString().Trim()); }
                        
                        if (rdr["status"].ToString().Trim() == "0")
                        {
                            myList.Add("Nota : " + "Sedang Proses");
                            myList.Add("Status : " + "Proses");
                        }
                        else if (rdr["status"].ToString().Trim() == "Y")
                        {
                            myList.Add("Nota : " + rdr["note"].ToString().Trim());
                            myList.Add("Status : " + "Berjaya Tukar Katalaluan");
                        }
                        else
                        {
                            myList.Add("Nota : " + rdr["note"].ToString().Trim());
                            myList.Add("Status : " + "Gagal Tukar Katalaluan");
                        }
                    }
                    else
                    {
                        myList.Add("ID# : " + rdr["id"].ToString().Trim());
                        myList.Add("Date : " + rdr["mydatein"].ToString().Trim());
                        myList.Add("Modul : " + rdr["mymodul"].ToString().Trim());
                        if (rdr["mymodul"].ToString().Trim() == "email") { myList.Add("Email ID : " + rdr["email"].ToString().Trim()); } else { myList.Add("Account ID : " + rdr["user_id"].ToString().Trim()); }

                        if (rdr["status"].ToString().Trim() == "0")
                        {
                            myList.Add("Note : " + "Still process");
                            myList.Add("Status : " + "Process");
                        }
                        else if (rdr["status"].ToString().Trim() == "Y")
                        {
                            myList.Add("Note : " + rdr["note"].ToString().Trim());
                            myList.Add("Status : " + "Sucsessfully changed password");
                        }
                        else
                        {
                            myList.Add("Note : " + rdr["note"].ToString().Trim());
                            myList.Add("Status : " + "Change password failed");
                        }

                    }
                   
                       
                    //myList.Add(idbayar); // id bayat
                    //myList.Add(rdr["PS_Butiran"].ToString());
                    //myList.Add(rdr["df"].ToString());
                    //myList.Add(tkhbayar); // tkh bayar
                    //myList.Add(jumbayar);  // jum bayar

                    break;
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
        public static IEnumerable<string> GetDetailCuti(string bahasa, string userid, string samanid)
        {
            string idbayar = "";
            string tkhbayar = "";
            string jumbayar = "";
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
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "  SELECT TOP(100) PERCENT MS26_CutiStaf.MS26_KodMohonCuti, MS26_CutiStaf.MS01_NoStaf, MS26_CutiStaf.CT_KodKategoriCuti, MS26_CutiStaf.CT_KodCuti, MS26_CutiStaf.MS26_Tahun, convert(varchar,MS26_CutiStaf.MS26_TkhMula, 103)   as mydatein ,    ";
                CommandText = CommandText + "      convert(varchar,MS26_CutiStaf.MS26_TkhTamat, 103)   as mydateout ,  MS26_CutiStaf.MS26_BilHari, MS26_CutiStaf.MS01_AlamatT1, MS26_CutiStaf.MS01_AlamatT2, MS26_CutiStaf.MS01_PoskodTetap, MS26_CutiStaf.MS01_BandarTetap,  ";
                CommandText = CommandText + "   MS26_CutiStaf.MS01_NegeriTetap, MS26_CutiStaf.MS01_NegaraTetap, MS26_CutiStaf.MS01_NoTelR1, MS26_CutiStaf.MS26_TkhMohon, MS26_CutiStaf.MS26_Penyokong, MS26_CutiStaf.MS26_Pelulus,  ";
                CommandText = CommandText + "  MS26_CutiStaf.MS26_TkhSokong, MS26_CutiStaf.MS26_TkhLulus, MS26_CutiStaf.MS26_IDBatal, MS26_CutiStaf.MS26_TkhBatal, MS26_CutiStaf.MS26_StatusCuti, MS26_CutiStaf.MS26_SebabTakLulus,  ";
                CommandText = CommandText + "    MS26_CutiStaf.MS26_SebabCuti, MS26_CutiStaf.MS26_SebabBatal, MS26_CutiStaf.MS26_NoPT, MS26_CutiStaf.MS26_TkhPT, MS26_CutiStaf.CT_BilHariMohon, MS26_CutiStaf.MS26_IDKemaskini,  ";
                CommandText = CommandText + "    MS26_CutiStaf.MS26_TkhKemaskini, MS26_CutiStaf.MS26_KlinikPanel, MS26_CutiStaf.MS26_KlinikLain, MS26_CutiStaf.MS26_NoResitKlinik, MS26_CutiStaf.MS26_TkhResit, MS26_CutiStaf.Tkh_Wujud,  ";
                CommandText = CommandText + "      MS26_CutiStaf.MS26_StaEL, MS26_CutiStaf.MS26_KateKlinik, MS26_CutiStaf.MS08_Pejabat, CT_KodCuti.CT_KodKategoriCuti AS Expr5, CT_KodCuti.CT_KodCuti AS Expr6, CT_KodCuti.CT_PeneranganKod,  ";
                CommandText = CommandText + "      CT_KodCuti.CT_BilHari, CT_KodCuti.CT_BilSetahun, CT_KodCuti.CT_Status, CT_KodCuti.CT_StSabtuAhad, CT_KodCuti.CT_PeneranganKod AS Expr1, CT_KodCuti.CT_KodKategoriCuti AS Expr2,  ";
                CommandText = CommandText + "     MS26_CutiStaf.MS01_NoStaf AS Expr3, MS26_CutiStaf.CT_KodCuti AS Expr4 ";
                CommandText = CommandText + " FROM            MS26_CutiStaf INNER JOIN ";
                CommandText = CommandText + "       CT_KodCuti ON MS26_CutiStaf.CT_KodCuti = CT_KodCuti.CT_KodCuti ";
                CommandText = CommandText + " WHERE(MS26_CutiStaf.MS26_KodMohonCuti = @samanid) AND(MS26_CutiStaf.MS26_Tahun = @myYear) AND(MS26_CutiStaf.MS26_StatusCuti <> 'KECEMASAN') ";
                CommandText = CommandText + " ORDER BY MS26_CutiStaf.MS26_TkhMula, MS26_CutiStaf.MS26_TkhMohon, MS26_CutiStaf.MS26_KodMohonCuti ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@samanid", samanid);
                cmd.Parameters.AddWithValue("@myYear", DateTime.Now.ToString("yyyy"));
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    if (bahasa == "malay")
                    {
                        myList.Add("Cuti ID# : " + rdr["MS26_KodMohonCuti"].ToString().Trim());
                        myList.Add("Dari : " + rdr["mydatein"].ToString().Trim());
                        myList.Add("Hingga : " + rdr["mydateout"].ToString().Trim());
                        myList.Add("Jumlah Cuti : " + rdr["MS26_BilHari"].ToString().Trim() + " hari");
                        myList.Add("Sebab Cuti : " + rdr["MS26_SebabCuti"].ToString().Trim());
                        myList.Add("Status : " + rdr["MS26_StatusCuti"].ToString().Trim());
                        if ((bool)rdr["MS26_StaEL"] == true) {
                            myList.Add("Nota : Cuti Kecemasan" );
                        } else {
                            myList.Add("");
                        }
                        myList.Add("Rekod Cuti");
                    }
                    else
                    {
                        myList.Add("Leave ID# : " + rdr["MS26_KodMohonCuti"].ToString().Trim());
                        myList.Add("From : " + rdr["mydatein"].ToString().Trim());
                        myList.Add("To : " + rdr["mydateout"].ToString().Trim());
                        if (rdr["MS26_BilHari"].ToString().Trim() == "1") {
                            myList.Add("Leave Total : " + rdr["MS26_BilHari"].ToString().Trim() + " day");
                        } else {
                            myList.Add("Leave Total : " + rdr["MS26_BilHari"].ToString().Trim() + " days");
                        }
                        myList.Add("Reason : " + rdr["MS26_SebabCuti"].ToString().Trim());
                        myList.Add("Status : " + rdr["MS26_StatusCuti"].ToString().Trim());
                        if ((bool)rdr["MS26_StaEL"] == true)
                        {
                            myList.Add("Note : Emergency Leave");
                        }
                        else
                        {
                            myList.Add("");
                        }
                        myList.Add("Leave Details");
                    }

                   break;
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

        public static IEnumerable<string> GetDetailBatalCuti(string bahasa, string userid, string samanid)
        {
            string idbayar = "";
            string tkhbayar = "";
            string jumbayar = "";
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
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "  SELECT TOP(100) PERCENT MS26_CutiStaf.MS26_KodMohonCuti, MS26_CutiStaf.MS01_NoStaf, MS26_CutiStaf.CT_KodKategoriCuti, MS26_CutiStaf.CT_KodCuti, MS26_CutiStaf.MS26_Tahun, convert(varchar,MS26_CutiStaf.MS26_TkhMula, 103)   as mydatein ,    ";
                CommandText = CommandText + "      convert(varchar,MS26_CutiStaf.MS26_TkhTamat, 103)   as mydateout ,  MS26_CutiStaf.MS26_BilHari, MS26_CutiStaf.MS01_AlamatT1, MS26_CutiStaf.MS01_AlamatT2, MS26_CutiStaf.MS01_PoskodTetap, MS26_CutiStaf.MS01_BandarTetap,  ";
                CommandText = CommandText + "   MS26_CutiStaf.MS01_NegeriTetap, MS26_CutiStaf.MS01_NegaraTetap, MS26_CutiStaf.MS01_NoTelR1, MS26_CutiStaf.MS26_TkhMohon, MS26_CutiStaf.MS26_Penyokong, MS26_CutiStaf.MS26_Pelulus,  ";
                CommandText = CommandText + "  MS26_CutiStaf.MS26_TkhSokong, MS26_CutiStaf.MS26_TkhLulus, MS26_CutiStaf.MS26_IDBatal, MS26_CutiStaf.MS26_TkhBatal, MS26_CutiStaf.MS26_StatusCuti, MS26_CutiStaf.MS26_SebabTakLulus,  ";
                CommandText = CommandText + "    MS26_CutiStaf.MS26_SebabCuti, MS26_CutiStaf.MS26_SebabBatal, MS26_CutiStaf.MS26_NoPT, MS26_CutiStaf.MS26_TkhPT, MS26_CutiStaf.CT_BilHariMohon, MS26_CutiStaf.MS26_IDKemaskini,  ";
                CommandText = CommandText + "    MS26_CutiStaf.MS26_TkhKemaskini, MS26_CutiStaf.MS26_KlinikPanel, MS26_CutiStaf.MS26_KlinikLain, MS26_CutiStaf.MS26_NoResitKlinik, MS26_CutiStaf.MS26_TkhResit, MS26_CutiStaf.Tkh_Wujud,  ";
                CommandText = CommandText + "      MS26_CutiStaf.MS26_StaEL, MS26_CutiStaf.MS26_KateKlinik, MS26_CutiStaf.MS08_Pejabat, CT_KodCuti.CT_KodKategoriCuti AS Expr5, CT_KodCuti.CT_KodCuti AS Expr6, CT_KodCuti.CT_PeneranganKod,  ";
                CommandText = CommandText + "      CT_KodCuti.CT_BilHari, CT_KodCuti.CT_BilSetahun, CT_KodCuti.CT_Status, CT_KodCuti.CT_StSabtuAhad, CT_KodCuti.CT_PeneranganKod AS Expr1, CT_KodCuti.CT_KodKategoriCuti AS Expr2,  ";
                CommandText = CommandText + "     MS26_CutiStaf.MS01_NoStaf AS Expr3, MS26_CutiStaf.CT_KodCuti AS Expr4 ";
                CommandText = CommandText + " FROM            MS26_CutiStaf INNER JOIN ";
                CommandText = CommandText + "       CT_KodCuti ON MS26_CutiStaf.CT_KodCuti = CT_KodCuti.CT_KodCuti ";
                CommandText = CommandText + " WHERE(MS26_CutiStaf.MS26_KodMohonCuti = @samanid) and MS26_StatusCuti = 'Proses' AND (MS26_CutiStaf.MS26_Tahun = @myYear) AND(MS26_CutiStaf.MS26_StatusCuti <> 'KECEMASAN') ";
                CommandText = CommandText + " ORDER BY MS26_CutiStaf.MS26_TkhMula, MS26_CutiStaf.MS26_TkhMohon, MS26_CutiStaf.MS26_KodMohonCuti ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@samanid", samanid);
                cmd.Parameters.AddWithValue("@myYear", DateTime.Now.ToString("yyyy"));
                rdr = cmd.ExecuteReader();
                string mfound = "0";
                while (rdr.Read())
                {

                    if (bahasa == "malay")
                    {
                        myList.Add("Cuti ID# : " + rdr["MS26_KodMohonCuti"].ToString().Trim());
                        myList.Add("Dari : " + rdr["mydatein"].ToString().Trim());
                        myList.Add("Hingga : " + rdr["mydateout"].ToString().Trim());
                        myList.Add("Jumlah Cuti : " + rdr["MS26_BilHari"].ToString().Trim() + " hari");
                        myList.Add("Sebab Cuti : " + rdr["MS26_SebabCuti"].ToString().Trim());
                        myList.Add("Status : " + rdr["MS26_StatusCuti"].ToString().Trim());
                        if ((bool)rdr["MS26_StaEL"] == true)
                        {
                            myList.Add("Nota : Cuti Kecemasan");
                        }
                        else
                        {
                            myList.Add("");
                        }
                        myList.Add("Pembatalan Permohonan Cuti");
                        myList.Add("Batal Cuti");
                    }
                    else
                    {
                        myList.Add("Leave ID# : " + rdr["MS26_KodMohonCuti"].ToString().Trim());
                        myList.Add("From : " + rdr["mydatein"].ToString().Trim());
                        myList.Add("To : " + rdr["mydateout"].ToString().Trim());
                        if (rdr["MS26_BilHari"].ToString().Trim() == "1")
                        {
                            myList.Add("Leave Total : " + rdr["MS26_BilHari"].ToString().Trim() + " day");
                        }
                        else
                        {
                            myList.Add("Leave Total : " + rdr["MS26_BilHari"].ToString().Trim() + " days");
                        }
                        myList.Add("Reason : " + rdr["MS26_SebabCuti"].ToString().Trim());
                        myList.Add("Status : " + rdr["MS26_StatusCuti"].ToString().Trim());
                        if ((bool)rdr["MS26_StaEL"] == true)
                        {
                            myList.Add("Note : Emergency Leave");
                        }
                        else
                        {
                            myList.Add("");
                        }
                        myList.Add("Cancellation Leave Request");
                        myList.Add("Confirm Cancel");
                    }
                    mfound = "1";
                    break;
                }
                if (mfound == "1") { 
                return myList;
                }
                else { myList.Add("no");
                    if (bahasa == "malay")
                    {
                        myList.Add("Rekod tidak sah");
                    }
                    else
                    {
                        myList.Add("Invalid data");
                    }
                    return myList; }
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
        public static IEnumerable<string> ConfirmBatalCuti(string bahasa, string userid, string cutid)
        {

            string[] ret = new string[2];
            ret[0] = "no";
            string mm = "0";
            mm = GetJumlahcuti(userid, cutid);
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbstaf))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"delete from   MS26_CutiStaf  where MS01_NoStaf=@USERID and MS26_KodMohonCuti=@cutid and MS26_StatusCuti='Proses'";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@cutid", cutid);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            ret[0] = "ok";
                            string mysett = UpdateCutiSettingb(userid, mm);
                        }
                        catch (SqlException e)
                        {
                            if (bahasa == "malay")
                            {
                                ret[1] = "Capaian ke database bermasalah. Sila cuba lagi";
                            }
                            else
                            {

                                ret[1] = "Error, Database offline";
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                if (bahasa == "malay")
                {
                    ret[1] = "Capaian ke database bermasalah. Sila cuba lagi";
                }
                else
                {

                    ret[1] = "Error, Database offline";
                }
            }


            return ret;
        }
        public static string UpdateCutiSettingb(string userid, string MynumberOfDays)
        {
            DateTime mydate = DateTime.Now;
            string myStr = "no";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbstaf))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"update CT01_SettingCuti set CT01_JumHariB = @jumB where  MS01_NoStaf = @user_id AND CT01_Tahun = @myYear";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@user_id", userid);
                        cmd.Parameters.AddWithValue("@jumB", DataBakiCuti_settb(userid, MynumberOfDays));
                        cmd.Parameters.AddWithValue("@myYear", DateTime.Now.ToString("yyyy"));
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            myStr = "ok";
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


            return myStr;
        }
        public static string GetJumlahcuti(string userid, string cutiid)
        {

            String ConnectionString = "";
            string CommandText = "";
            string mjum = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                ConnectionString = SQLAuth.dbase_dbstaf;
                CommandText = "SELECT   MS26_BilHari  FROM            MS26_CutiStaf WHERE  MS26_KodMohonCuti = @kodcuti and MS26_StatusCuti = 'Proses' AND MS01_NoStaf = @user_id";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@user_id", userid);
                cmd.Parameters.AddWithValue("@kodcuti", cutiid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mjum = rdr["MS26_BilHari"].ToString();
                    break;
                }
                return mjum;
            }
            catch (Exception)
            {
                return "0";
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        public static string DataBakiCuti_settb(string userid, string MynumberOfDays)
        {

            String ConnectionString = "";
            string CommandText = "";
            string mjum = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                ConnectionString = SQLAuth.dbase_dbstaf;
                CommandText = "SELECT     CT01_JumHariB from CT01_SettingCuti where  MS01_NoStaf = @user_id AND CT01_Tahun = @myYear";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@user_id", userid);
                cmd.Parameters.AddWithValue("@myYear", DateTime.Now.ToString("yyyy"));
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mjum = rdr["CT01_JumHariB"].ToString();
                    break;
                }
                int mynewb = Int32.Parse(mjum) + Int32.Parse(MynumberOfDays);
                return mynewb.ToString();
            }
            catch (Exception)
            {
                return "0";
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }

        public static IEnumerable<string> GetStudentSamanDetailPaid(string userid, string samanid)
        {
            string idbayar = "";
            string tkhbayar = "";
            string jumbayar = "";
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
                String ConnectionString = SQLAuth.dbase_dbspku;
                con = new SqlConnection(ConnectionString);
                con.Open();
                //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
                // string CommandText = "SELECT SMP11_MPPelajar.SMP07_KodMP, b.SMP07_NamaMP, a.SMP17_Markah + a.SMP17_Mrk_Ubah AS markah, b.SMP07_Kredit, a.SMP17_Gred, a.SMP17_MNilaian, a.SMP17_Status, SMP11_MPPelajar.KodSesi_Sem,                   SMP11_MPPelajar.SMP11_Status, SMP18_KreditDT.SMP18_Pgsh FROM     SMP_SesiPengajian AS c INNER JOIN                   SMP17_MarkahKH AS a ON c.KodSesi_Sem = a.KodSesi_Sem INNER JOIN                   SMP18_KreditDT ON c.KodSesi_Sem = SMP18_KreditDT.KodSesi_Sem RIGHT OUTER JOIN                   SMP07_Matapelajaran AS b INNER JOIN                   SMP11_MPPelajar ON b.SMP07_KodMP = SMP11_MPPelajar.SMP07_KodMP ON SMP18_KreditDT.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.SMP07_KodMP = b.SMP07_KodMP AND                   a.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.KodSesi_Sem = SMP11_MPPelajar.KodSesi_Sem WHERE(SMP11_MPPelajar.SMP01_NOMATRIK = @userid) AND(SMP18_KreditDT.SMP18_Pgsh = 1)  ORDER BY c.Bil, SMP11_MPPelajar.KodSesi_Sem";
                string CommandText = " SELECT  PS01_IDSaman, PK_IDKenderaan, PK_NoDaftarK, MS01_NoStaf, SMP01_NoMatrik, PK_NoPekerja, PS01_Nama, PS01_Status, PS01_JenSaman, PS01_TkhSaman,  ";
                CommandText = CommandText + " PS01_MasaSaman, PS01_NoStafSaman, PS01_JumSaman, PS01_StaSlip, PS01_StaKunci, PS01_Model, AMS114_BangunanID, PS01_Lokasi, PS01_NamaGambar, PS01_FolderGambar,  ";
                CommandText = CommandText + " PS01_TerimaOKS, PS01_NoResitSaman, PS01_Pemilikan, PS01_JumRayuan, PS01_FolderRayuan, PS01_FailRayuan, PS01_TkhRayuan, PS01_TkhLulusRayuan, PS01_TkhRayuanDiterima,  ";
                CommandText = CommandText + " PS01_TarikhRayuanDitolak, PS01_JumDiBayar, PS03_TkhHantarEmail, PS01_UlasanPeg, PS01_TkhBayaran, PS01_NoResit, PS01_IDStaf, PS01_TraceCode, PS01_TkhWujud,  ";
                CommandText = CommandText + "  PS01_NoAkhir ";
                CommandText = CommandText + " FROM         PS01_Saman where PS01_IDSaman=@samanid";

                CommandText = " SELECT  a.PK_NoDaftarK, b.PS_Butiran as dd,  a.PS01_Lokasi, a.PS01_MasaSaman, a.PK_IDKenderaan, a.PS01_IDSaman, CONVERT(VARCHAR(10), a.PS01_TkhSaman, 105) as df, c.PS_JenSaman, c.PS_Butiran, c.PS_StaJenSaman, c.PS_Jumlah ";

                CommandText = CommandText + " FROM    PS_Status as b,       PS01_Saman as a,  PS_JenSaman as c  where  b.PS_Status = a.PS01_Status  and c.PS_JenSaman = a.PS01_JenSaman  and a.PS01_IDSaman=@samanid";


                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                //  cmd.Parameters.AddWithValue("@userid", "B011510258");
                cmd.Parameters.AddWithValue("@samanid", samanid);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    string mystatus = GetResitOnline(samanid, ref idbayar, ref tkhbayar, ref jumbayar);
                    if (mystatus == "ok") { 
                            myList.Add(idbayar); // id bayat
                            myList.Add(rdr["PS_Butiran"].ToString());
                            myList.Add(rdr["df"].ToString());
                            myList.Add(tkhbayar); // tkh bayar
                            myList.Add(jumbayar);  // jum bayar
                    }else{
                        myList.Add("Bayaran secara offline"); // id bayat
                        myList.Add("-"); // id bayat
                        myList.Add("-"); // id bayat
                        myList.Add("-"); // id bayat
                        myList.Add("-"); // id bayat
                    }
                    break;
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
        }
        public static string GetResitOnline(string samanid, ref  string idbayar, ref string tkhbayar, ref string jumbayar)
        {
            string mstatus = "no";

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

                string CommandText = " SELECT  Tran_id, Ref_id, userid, mydate_req, status_tran, status_migs,  CONVERT(VARCHAR(10), mydate_migs, 105) as df, amt_pay, vpc_MerchTxnRef, note, jenis_modul, vpc_TxnResponseCode  ";
                CommandText = CommandText + " FROM migs_payment where Ref_id=@samanid and vpc_TxnResponseCode='0'";


                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@samanid", samanid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    idbayar = rdr["Tran_id"].ToString();
                    tkhbayar = rdr["df"].ToString();
                    jumbayar = rdr["amt_pay"].ToString().Trim();
                    mstatus = "ok";
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


            return mstatus;
        }
        public static IEnumerable<string> GetStudentSamanDetail(string userid, string samanid)
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
                String ConnectionString = SQLAuth.dbase_dbspku;
                con = new SqlConnection(ConnectionString);
                con.Open();
                //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
                // string CommandText = "SELECT SMP11_MPPelajar.SMP07_KodMP, b.SMP07_NamaMP, a.SMP17_Markah + a.SMP17_Mrk_Ubah AS markah, b.SMP07_Kredit, a.SMP17_Gred, a.SMP17_MNilaian, a.SMP17_Status, SMP11_MPPelajar.KodSesi_Sem,                   SMP11_MPPelajar.SMP11_Status, SMP18_KreditDT.SMP18_Pgsh FROM     SMP_SesiPengajian AS c INNER JOIN                   SMP17_MarkahKH AS a ON c.KodSesi_Sem = a.KodSesi_Sem INNER JOIN                   SMP18_KreditDT ON c.KodSesi_Sem = SMP18_KreditDT.KodSesi_Sem RIGHT OUTER JOIN                   SMP07_Matapelajaran AS b INNER JOIN                   SMP11_MPPelajar ON b.SMP07_KodMP = SMP11_MPPelajar.SMP07_KodMP ON SMP18_KreditDT.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.SMP07_KodMP = b.SMP07_KodMP AND                   a.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.KodSesi_Sem = SMP11_MPPelajar.KodSesi_Sem WHERE(SMP11_MPPelajar.SMP01_NOMATRIK = @userid) AND(SMP18_KreditDT.SMP18_Pgsh = 1)  ORDER BY c.Bil, SMP11_MPPelajar.KodSesi_Sem";
                string CommandText = " SELECT  PS01_IDSaman, PK_IDKenderaan, PK_NoDaftarK, MS01_NoStaf, SMP01_NoMatrik, PK_NoPekerja, PS01_Nama, PS01_Status, PS01_JenSaman, PS01_TkhSaman,  ";
                CommandText = CommandText + " PS01_MasaSaman, PS01_NoStafSaman, PS01_JumSaman, PS01_StaSlip, PS01_StaKunci, PS01_Model, AMS114_BangunanID, PS01_Lokasi, PS01_NamaGambar, PS01_FolderGambar,  ";
                CommandText = CommandText + " PS01_TerimaOKS, PS01_NoResitSaman, PS01_Pemilikan, PS01_JumRayuan, PS01_FolderRayuan, PS01_FailRayuan, PS01_TkhRayuan, PS01_TkhLulusRayuan, PS01_TkhRayuanDiterima,  ";
                CommandText = CommandText + " PS01_TarikhRayuanDitolak, PS01_JumDiBayar, PS03_TkhHantarEmail, PS01_UlasanPeg, PS01_TkhBayaran, PS01_NoResit, PS01_IDStaf, PS01_TraceCode, PS01_TkhWujud,  ";
                CommandText = CommandText + "  PS01_NoAkhir ";
                CommandText = CommandText + " FROM         PS01_Saman where PS01_IDSaman=@samanid";

                CommandText = " SELECT  a.PK_NoDaftarK, b.PS_Butiran as dd,  a.PS01_Lokasi, a.PS01_MasaSaman, a.PK_IDKenderaan, a.PS01_IDSaman, CONVERT(VARCHAR(10), a.PS01_TkhSaman, 105) as df, c.PS_JenSaman, c.PS_Butiran, c.PS_StaJenSaman, c.PS_Jumlah ";

                CommandText = CommandText + " FROM    PS_Status as b,       PS01_Saman as a,  PS_JenSaman as c  where  b.PS_Status = a.PS01_Status  and c.PS_JenSaman = a.PS01_JenSaman  and a.PS01_IDSaman=@samanid";


                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@samanid", samanid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                        string myJum = GetJumlahSaman(samanid, rdr["PS_JenSaman"].ToString().Trim());

                        myList.Add(rdr["PS_Butiran"].ToString());
                        myList.Add(rdr["PK_NoDaftarK"].ToString());
                        myList.Add(rdr["df"].ToString());

                        myList.Add(rdr["PS01_MasaSaman"].ToString());
                    //myList.Add(rdr["PS_Jumlah"].ToString()); PS_JenSaman
                    myList.Add(myJum);
                        myList.Add(GetSamanPaid(rdr["PS01_IDSaman"].ToString()));
                  
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

        public static string GetJumlahSaman(string idsaman, string jenissaman)
        {
            string mybol = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbspku; // @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='oas';Password='oas*pwd'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                //string CommandText = "SELECT a.PS01_IDSaman, a.PK_IDKenderaan, a.PK_NoDaftarK, a.MS01_NoStaf, a.SMP01_NoMatrik, a.PK_NoPekerja, a.PS01_Nama, a.PS01_Status, a.PS01_Model, b.PS_Butiran, a.PS01_JenSaman, c.PS_Butiran AS ButirJenSaman, ";
                //CommandText = CommandText + " a.PS01_TkhSaman, CONVERT(varchar(15), CAST(a.PS01_MasaSaman AS TIME), 100) AS PS01_MasaSaman, a.PS01_NamaGambar, a.PS01_FolderGambar, a.PS01_StaKunci, c.PS_JenSaman, a.AMS114_BangunanID, d.AMS114_Butiran,  ";
                //CommandText = CommandText + " a.PS01_Lokasi, a.PS01_NoResitSaman, a.PS01_StaSlip, e.SMK_KodJenis, f.SMK_ButiranJenis, DATEDIFF(Day, a.PS01_TkhSaman, GETDATE()) + 1 AS jumHari, CASE WHEN(DATEDIFF(Day, A.PS01_TkhSaman, GETDATE()) + 1 >= 0 AND ";
                //CommandText = CommandText + " DATEDIFF(Day, A.PS01_TkhSaman, GETDATE()) + 1 < 8 AND A.PS01_StaKunci = 0) THEN '10.00' WHEN(DATEDIFF(Day, A.PS01_TkhSaman, GETDATE()) + 1 >= 8 AND DATEDIFF(Day, A.PS01_TkhSaman, GETDATE()) + 1 < 15 AND ";
                //CommandText = CommandText + " A.PS01_StaKunci = 0) THEN '30.00' WHEN(DATEDIFF(Day, A.PS01_TkhSaman, GETDATE()) + 1 >= 15 AND A.PS01_StaKunci = 0) THEN '50.00' WHEN A.PS01_StaKunci = 1 THEN '30.00' END AS jumSaman, a.PS01_Pemilikan ";
                //CommandText = CommandText + " FROM     PS01_Saman AS a INNER JOIN ";
                //CommandText = CommandText + " PS_Status AS b ON a.PS01_Status = b.PS_Status INNER JOIN ";
                //CommandText = CommandText + " PS_JenSaman AS c ON a.PS01_JenSaman = c.PS_JenSaman INNER JOIN ";
                //CommandText = CommandText + " [V - SQL12].DbAms.dbo.AMS114_Lokasi_Bangunan AS d ON a.AMS114_BangunanID = d.AMS114_BangunanID INNER JOIN ";
                //CommandText = CommandText + " PK_Kenderaan AS e ON a.PK_IDKenderaan = e.PK_IDKenderaan INNER JOIN ";
                //CommandText = CommandText + " [V - SQL11].dbkenderaan.dbo.SMK_JenisKenderaan AS f ON e.SMK_KodJenis = f.SMK_KodJenis ";
                //CommandText = CommandText + " WHERE(a.PS01_IDSaman = @idsaman) ";


                //CommandText = "SELECT a.PS01_IDSaman, a.PK_IDKenderaan, a.PK_NoDaftarK, a.MS01_NoStaf, a.SMP01_NoMatrik, a.PK_NoPekerja, a.PS01_Nama, a.PS01_Status, a.PS01_Model, b.PS_Butiran, a.PS01_JenSaman, c.PS_Butiran AS ButirJenSaman,  ";
                //CommandText = CommandText + "   a.PS01_TkhSaman, CONVERT(varchar(15), CAST(a.PS01_MasaSaman AS TIME), 100) AS PS01_MasaSaman, a.PS01_NamaGambar, a.PS01_FolderGambar, a.PS01_StaKunci, c.PS_JenSaman, a.AMS114_BangunanID, d.AMS114_Butiran,   ";
                //CommandText = CommandText + "   a.PS01_Lokasi, a.PS01_NoResitSaman, a.PS01_StaSlip, e.SMK_KodJenis, f.SMK_ButiranJenis, DATEDIFF(Day, a.PS01_TkhSaman, GETDATE()) + 1 AS jumHari, CASE WHEN(DATEDIFF(Day, A.PS01_TkhSaman, GETDATE()) + 1 >= 0 AND  ";
                //CommandText = CommandText + "   DATEDIFF(Day, A.PS01_TkhSaman, GETDATE()) + 1 < 8 AND A.PS01_StaKunci = 0) THEN '10.00' WHEN(DATEDIFF(Day, A.PS01_TkhSaman, GETDATE()) + 1 >= 8 AND DATEDIFF(Day, A.PS01_TkhSaman, GETDATE()) + 1 < 15 AND  ";
                //CommandText = CommandText + "   A.PS01_StaKunci = 0) THEN '30.00' WHEN(DATEDIFF(Day, A.PS01_TkhSaman, GETDATE()) + 1 >= 15 AND A.PS01_StaKunci = 0) THEN '50.00' WHEN A.PS01_StaKunci = 1 THEN '30.00' END AS jumSaman, a.PS01_Pemilikan  ";
                //CommandText = CommandText + "   FROM     PS01_Saman AS a INNER JOIN  ";
                //CommandText = CommandText + "   PS_Status AS b ON a.PS01_Status = b.PS_Status INNER JOIN  ";
                //CommandText = CommandText + "   PS_JenSaman AS c ON a.PS01_JenSaman = c.PS_JenSaman INNER JOIN  ";
                //CommandText = CommandText + "   [V-SQL12].DbAms.dbo.AMS114_Lokasi_Bangunan AS d ON a.AMS114_BangunanID = d.AMS114_BangunanID INNER JOIN  ";
                //CommandText = CommandText + "   PK_Kenderaan AS e ON a.PK_IDKenderaan = e.PK_IDKenderaan INNER JOIN  ";
                //CommandText = CommandText + "   [V-SQL11].dbkenderaan.dbo.SMK_JenisKenderaan AS f ON e.SMK_KodJenis = f.SMK_KodJenis  ";
                //CommandText = CommandText + "   WHERE (a.PS01_IDSaman =  @idsaman) ";

               // string CommandText = " SELECT  a.PK_NoDaftarK, b.PS_Butiran as dd,  a.PS01_Lokasi, a.PS01_MasaSaman, a.PK_IDKenderaan, a.PS01_IDSaman, CONVERT(VARCHAR(10), a.PS01_TkhSaman, 105) as df, c.PS_JenSaman, c.PS_Butiran, c.PS_StaJenSaman, c.PS_Jumlah ";

               // CommandText = CommandText + " FROM    PS_Status as b,       PS01_Saman as a,  PS_JenSaman as c  where  b.PS_Status = a.PS01_Status  and c.PS_JenSaman = a.PS01_JenSaman  and a.PS01_IDSaman= @idsaman";


                string CommandText = "  SELECT DATEDIFF(Day, a.PS01_TkhSaman, GETDATE()) + 1 AS jumHari FROM PS01_Saman as a where a.PS01_IDSaman = @idsaman";


                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@idsaman", idsaman);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol =  rdr["jumHari"].ToString();

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
            if ((jenissaman == "26") || (jenissaman == "27")) {
                mybol = "30";
            }
            else
            {
                if ((int.Parse(mybol) >= 0) && (int.Parse(mybol) <= 7))
                {
                    mybol = "10";
                }
                else if ((int.Parse(mybol) >= 8) && (int.Parse(mybol) <= 14))
                {
                    mybol = "30";
                }
                else
                {
                    mybol = "50";
                }
            }

                return mybol;
        }


        public static IEnumerable<string> GetPenyataAkaun(string userid, string sesi)
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
            double jumkredit = 0;
            double jumdebit = 0;
            try
            {
                myList.Add(" ");
                myList.Add("totd");
                myList.Add("totc");
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
                //  string CommandText = "SELECT SMP11_MPPelajar.SMP07_KodMP, b.SMP07_NamaMP, a.SMP17_Markah + a.SMP17_Mrk_Ubah AS markah, b.SMP07_Kredit, a.SMP17_Gred, a.SMP17_MNilaian, a.SMP17_Status, SMP11_MPPelajar.KodSesi_Sem,                   SMP11_MPPelajar.SMP11_Status, SMP18_KreditDT.SMP18_Pgsh FROM     SMP_SesiPengajian AS c INNER JOIN                   SMP17_MarkahKH AS a ON c.KodSesi_Sem = a.KodSesi_Sem INNER JOIN                   SMP18_KreditDT ON c.KodSesi_Sem = SMP18_KreditDT.KodSesi_Sem RIGHT OUTER JOIN                   SMP07_Matapelajaran AS b INNER JOIN                   SMP11_MPPelajar ON b.SMP07_KodMP = SMP11_MPPelajar.SMP07_KodMP ON SMP18_KreditDT.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.SMP07_KodMP = b.SMP07_KodMP AND                   a.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.KodSesi_Sem = SMP11_MPPelajar.KodSesi_Sem WHERE(SMP11_MPPelajar.SMP01_NOMATRIK = @userid) AND(SMP18_KreditDT.SMP18_Pgsh = 1) AND(a.KodSesi_Sem = @sesi) ORDER BY c.Bil, SMP11_MPPelajar.KodSesi_Sem";
                string CommandText = " SELECT        NOMATRIK, NAMA, FAKULTI, PROGRAM, SESI_SEMASA, HUTANG_ALL, DCID, SESI_TRANSAKSI, JENIS_DC, JUM_DC, JUM_BAYAR, JUM_KC, KODVOT, BUTIRAN, DEBIT, KREDIT ";
                CommandText = CommandText + "  FROM            dbo.TVF_MOB_APP_KEW_PENYATA_PL(@userid) AS TVF_MOB_APP_KEW_PENYATA_PL_1 ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sesi", sesi);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if (rdr["SESI_TRANSAKSI"].ToString().Trim() == sesi.Trim())
                    {
                        myList.Add(rdr["BUTIRAN"].ToString().Trim());
                        if (double.Parse(rdr["DEBIT"].ToString()) == 0) {
                            myList.Add("0.00");
                        }
                        else
                        {
                            myList.Add(double.Parse(rdr["DEBIT"].ToString()).ToString("0.00"));
                            jumdebit = jumdebit + double.Parse(rdr["DEBIT"].ToString());
                        }
                        if (double.Parse(rdr["KREDIT"].ToString()) == 0)
                        {
                            myList.Add("0.00");
                        }
                        else
                        {
                            myList.Add(double.Parse(rdr["KREDIT"].ToString()).ToString("0.00"));
                            jumkredit = jumkredit + double.Parse(rdr["KREDIT"].ToString());
                        }
                       
                    }
                  //  myList.Add(rdr["SMP17_MNilaian"].ToString());
                    //  myList.Add(rdr["ap04_nama"].ToString());

                    //   myList.Add(sesi);


                }
                myList[1] = jumdebit.ToString("0.00");
                myList[2] = jumkredit.ToString("0.00");
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
        }

        public static IEnumerable<string> GetStudentResultDetNew(string userid, string sesi)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
              //  string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";
                string CommandText = "SELECT SMP11_MPPelajar.SMP07_KodMP, b.SMP07_NamaMP, a.SMP17_Markah + a.SMP17_Mrk_Ubah AS markah, b.SMP07_Kredit, a.SMP17_Gred, a.SMP17_MNilaian, a.SMP17_Status, SMP11_MPPelajar.KodSesi_Sem,                   SMP11_MPPelajar.SMP11_Status, SMP18_KreditDT.SMP18_Pgsh FROM     SMP_SesiPengajian AS c INNER JOIN                   SMP17_MarkahKH AS a ON c.KodSesi_Sem = a.KodSesi_Sem INNER JOIN                   SMP18_KreditDT ON c.KodSesi_Sem = SMP18_KreditDT.KodSesi_Sem RIGHT OUTER JOIN                   SMP07_Matapelajaran AS b INNER JOIN                   SMP11_MPPelajar ON b.SMP07_KodMP = SMP11_MPPelajar.SMP07_KodMP ON SMP18_KreditDT.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.SMP07_KodMP = b.SMP07_KodMP AND                   a.SMP01_NOMATRIK = SMP11_MPPelajar.SMP01_NOMATRIK AND a.KodSesi_Sem = SMP11_MPPelajar.KodSesi_Sem WHERE(SMP11_MPPelajar.SMP01_NOMATRIK = @userid) AND(SMP18_KreditDT.SMP18_Pgsh = 1) AND(a.KodSesi_Sem = @sesi) ORDER BY c.Bil, SMP11_MPPelajar.KodSesi_Sem";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sesi", sesi);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["SMP07_NamaMP"].ToString());
                  
                    myList.Add(rdr["SMP17_Gred"].ToString());
                    myList.Add(rdr["SMP07_Kredit"].ToString());
                    myList.Add(rdr["SMP17_MNilaian"].ToString());
                    //  myList.Add(rdr["ap04_nama"].ToString());

                 //   myList.Add(sesi);


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
        }
            public static IEnumerable<string> GetStudentResultNew(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["KodSesi_Sem"].ToString());
                    myList.Add(rdr["SMP18_GPA"].ToString());
                    myList.Add(rdr["SMP18_CGPA"].ToString());
                    //  myList.Add(rdr["ap04_nama"].ToString());

                  //  myList.Add(" ");


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
        public static IEnumerable<string> GetStudentResult(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT a.SMP01_Nomatrik, a.SMP01_Nama, a.SMP01_Fakulti, a.SMP01_Kursus, b.KodSesi_Sem, b.SMP18_GPA, b.SMP18_CGPA, b.SMP18_TarafAkhir, c.Bil FROM SMP01_Peribadi AS a INNER JOIN                   SMP18_KreditDT AS b ON a.SMP01_Nomatrik = b.SMP01_NOMATRIK INNER JOIN                   SMP_SesiPengajian AS c ON b.KodSesi_Sem = c.KodSesi_Sem WHERE (a.SMP01_Nomatrik = @userid) AND (b.SMP18_Pgsh = 1) ORDER BY c.Bil DESC";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
             //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["KodSesi_Sem"].ToString());
                    myList.Add(rdr["SMP18_GPA"].ToString());
                    myList.Add(rdr["SMP18_CGPA"].ToString());
                    //  myList.Add(rdr["ap04_nama"].ToString());
             
                    myList.Add(" ");


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
        public static Tuple<string[,]> GetStudentResult12(string userid)
        {

            string[,] arrayx = new string[,]
               {
                    {"vvcat", "vvcar"},
                    {"vvdog", "vvplane"},
               };
            return Tuple.Create(arrayx);

        }
    }
}