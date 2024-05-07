using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.WebPages;

namespace WebAppKs.Services
{
    public class SQLPeribadi
    {
        public static IEnumerable<string> GetPeribadi(string NoStaf)
        {
            //    var rec = new List<string>();
            DateTime localDate = DateTime.Now;
            var shortDateValue = localDate.ToString("dd/MM/yyyy");
            string[] rec = new string[7];

            //  string ret = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = " SELECT MS01_KpB, MS01_NoPasport, NoTelBimbit, YEAR(CONVERT(DATE,MS01_TkhLahir,103)) AS TAHUN, MONTH(CONVERT(DATE,MS01_TkhLahir,103)) AS BULAN, REPLACE(JenisDarah,'TIADA DILAPORKAN','-') AS JDarah, Email FROM V_PERIBADIMOBILE where NoStaf =  @NoStaf";
                //        string CommandText = "SELECT AMS114_BangunanID,AMS114_Butiran FROM AMS114_Lokasi_Bangunan";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                // cmd.Parameters.AddWithValue("AMS114_BangunanID", Butir);
                cmd.Parameters.AddWithValue("@NoStaf", NoStaf);
                rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    //  rec.Add(rdr.GetInt32(0).ToString());
                    //    rec.Add(rdr.GetString(0));
                    //    rec.Add(rdr.GetString(1));

                    rec[0] = rdr["MS01_KpB"].ToString();
                    rec[1] = rdr["MS01_NoPasport"].ToString();
                    rec[2] = rdr["NoTelBimbit"].ToString();

                    rec[3] = rdr["TAHUN"].ToString();
                    rec[4] = rdr["BULAN"].ToString();
                    rec[5] = rdr["JDarah"].ToString();
                    rec[6] = rdr["Email"].ToString();




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

            return rec;



        }
        public static IEnumerable<string> GetSej(string NoStaf)
        {
            var rec = new List<string>();
            //   string[] rec = new string[3];
            //   string[] rec = new string[4];

            //  string ret = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                var dt = DateTime.Now;
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT replace(replace(replace(replace(Singkatan, 'LAMAN HIKMAH', 'LH'),'PEJ. PEMBANGUNAN', 'PEJ.PEMBGNAN.'),'PENERBIT UNIVERSITI','PENERBIT UNI.'),'PUSAT KOMPUTER','PUSAT KOM.') AS SINGKAT,tkhmula ,MS08_TkhTamat FROM V_SEJPENEMPATANMOBILE WHERE MS01_NoStaf= @MS01_NoStaf  ORDER BY YEAR(CONVERT(DATE, tkhmula,103)) DESC, MONTH(CONVERT(DATE, tkhmula,103)) DESC  ";

                //        string CommandText = "SELECT AMS114_BangunanID,AMS114_Butiran FROM AMS114_Lokasi_Bangunan";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                // cmd.Parameters.AddWithValue("AMS114_BangunanID", Butir);
                cmd.Parameters.AddWithValue("@MS01_NoStaf", NoStaf);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    // rec.Add(rdr.GetInt32(0).ToString());
                    //   rec[0] = rdr["Singkatan"].ToString();
                    //  rec[1] = rdr["MS08_TkhMula"].ToString().Substring(0,10);

                    //  rec[2] = rdr["MS08_TkhTamat"].ToString();

                    //  rec[1] = rdr["AMS114_BangunanID"].ToString();
                    //    rec[2] = rdr["AMS114_Butiran"].ToString();
                    //     ret[2] = rdr["PS_Jumlah"].ToString();
                    //    return ret;
                    rec.Add(rdr.GetString(0));
                    rec.Add(rdr.GetString(1));
                    rec.Add(rdr.GetString(2));

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

            return rec;



        }
        public static IEnumerable<string> GetPer(string NoStaf)
        {
            //   var rec = new List<string>();
            string[] rec = new string[9];
            //   string[] rec = new string[4];

            //  string ret = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT TarafKumpulan, CONVERT(NVARCHAR(10),MS01_TkhKhidmat,103) AS TARIKHLNTK, CONVERT(NVARCHAR(10),TkhLapor,103) AS TARIKHLPR, TkhLapor, MS02_TkhSah, MS01_TkhBersara, MS01_NoKWSP, MS01_NoPencen, MS01_NoCukai, MS01_NoSOCSO  FROM V_PERIBADIMOBILE where NoStaf = @NoStaf";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@NoStaf", NoStaf);
                rdr = cmd.ExecuteReader();
                if (rdr.Read())
                {
                    // rec.Add(rdr.GetInt32(0).ToString());
                    rec[0] = rdr["TarafKumpulan"].ToString();
                    rec[1] = rdr["TARIKHLNTK"].ToString();
                    rec[2] = rdr["TARIKHLPR"].ToString();
                    rec[3] = rdr["MS02_TkhSah"].ToString();
                    rec[4] = rdr["MS01_TkhBersara"].ToString();
                    rec[5] = rdr["MS01_NoKWSP"].ToString();
                    rec[6] = rdr["MS01_NoPencen"].ToString();
                    rec[7] = rdr["MS01_NoCukai"].ToString();
                    rec[8] = rdr["MS01_NoSOCSO"].ToString();

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

            return rec;



        }
        public static IEnumerable<string> GetCuti(string Butiran)
        {
            string[] rec = new string[3];
            //   var rec = new List<string>();
            string jum = "0";
            int tarikh = 0;
            DateTime localDate = DateTime.Now;

            var shortDateValue = localDate.ToString("yyyy");

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT TOP(1) JumCutiLayak, BakiCuti, GCRKumpul FROM V_BUTIRCUTIMOBILE WHERE  MS01_NoStaf = @MS01_NoStaf ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@MS01_NoStaf", Butiran);
                rdr = cmd.ExecuteReader();


                if (rdr.Read())
                {

                    //  tarikh = (int)rdr.GetInt64(0) ;
                    //   jum = tarikh.ToString();
                    rec[0] = rdr["JumCutiLayak"].ToString();
                    rec[1] = rdr["BakiCuti"].ToString();
                    rec[2] = rdr["GCRKumpul"].ToString();



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

            return rec;



        }
        public static IEnumerable<string> GetGaji1(string Butiran)
        {
            string[] rec = new string[3];
            //   var rec = new List<string>();
            string jum = "0";
            int tarikh = 0;
            DateTime localDate = DateTime.Now;

            var shortDateValue = localDate.ToString("yyyy");

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT TOP(1) JumCutiLayak, BakiCuti, GCRKumpul FROM V_BUTIRCUTIMOBILE WHERE CT01_Tahun = '" + shortDateValue + "' AND MS01_NoStaf = @MS01_NoStaf ORDER BY JumCutiLayak DESC ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@MS01_NoStaf", Butiran);
                rdr = cmd.ExecuteReader();


                if (rdr.Read())
                {

                    //  tarikh = (int)rdr.GetInt64(0) ;
                    //   jum = tarikh.ToString();
                    rec[0] = rdr["JumCutiLayak"].ToString();
                    rec[1] = rdr["BakiCuti"].ToString();
                    rec[2] = rdr["GCRKumpul"].ToString();



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

            return rec;



        }
        public static IEnumerable<string> GetGel(string Butiran)
        {
            string[] rec = new string[3];
            //  var rec = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT Nama,Singkatan,Nama_Gelaran FROM V_PERIBADIMOBILE WHERE NoStaf = @NoStaf";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@NoStaf", Butiran);
                rdr = cmd.ExecuteReader();


                if (rdr.Read())
                {

                    //  tarikh = (int)rdr.GetInt64(0) ;
                    //   jum = tarikh.ToString();
                    rec[0] = rdr["Nama"].ToString();
                    rec[1] = rdr["Singkatan"].ToString();
                    rec[2] = rdr["Nama_Gelaran"].ToString();




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

            return rec;



        }
        public static IEnumerable<string> GetGaji(string Butiran)
        {
            string[] rec = new string[4];
            //  var rec = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT  CONVERT(DECIMAL(10,2),MS02_JumlahGajiS) AS GAJI,replace(replace(replace(NamaBank,'BANK ISLAM MALAYSIA BERHAD','BANK ISLAM'),'BANK KERJASAMA RAKYAT MALYSIA BERHAD','BANK RAKYAT'),'BANK MUAMALAT MALAYSIA BERHAD','BANK MUAMALAT') AS Bank,MS01_NoAkaun,MS02_BulKenaikan  FROM V_PERIBADIMOBILE WHERE NoStaf =  @NoStaf";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@NoStaf", Butiran);
                rdr = cmd.ExecuteReader();


                if (rdr.Read())
                {

                    //  tarikh = (int)rdr.GetInt64(0) ;
                    //   jum = tarikh.ToString();
                    rec[0] = rdr["GAJI"].ToString();
                    rec[1] = rdr["Bank"].ToString();
                    rec[2] = rdr["MS01_NoAkaun"].ToString();
                    rec[3] = rdr["MS02_BulKenaikan"].ToString();




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

            return rec;



        }
        public static IEnumerable<string> GetCutiKon(string Butiran)
        {
            string[] rec = new string[3];
            //  var rec = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT JumCutiLayak,BakiCuti,GCRKumpul FROM V_CUTIKONTRAKMOBILE WHERE MS01_NoStaf = @MS01_NoStaf";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@MS01_NoStaf", Butiran);
                rdr = cmd.ExecuteReader();


                if (rdr.Read())
                {

                    //  tarikh = (int)rdr.GetInt64(0) ;
                    //   jum = tarikh.ToString();
                    rec[0] = rdr["JumCutiLayak"].ToString();
                    rec[1] = rdr["BakiCuti"].ToString();
                    rec[2] = rdr["GCRKumpul"].ToString();




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

            return rec;



        }
        public static IEnumerable<string> GetTempKhid(string Butiran)
        {
            string[] rec = new string[2];
            //  var rec = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT YEAR(CONVERT(DATE,TkhLapor,103)) AS TAHUN ,MONTH(CONVERT(DATE,TkhLapor,103)) AS BULAN FROM V_PERIBADIMOBILE WHERE NoStaf = @NoStaf";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@NoStaf", Butiran);
                rdr = cmd.ExecuteReader();


                if (rdr.Read())
                {

                    //  tarikh = (int)rdr.GetInt64(0) ;
                    //   jum = tarikh.ToString();
                    rec[0] = rdr["TAHUN"].ToString();
                    rec[1] = rdr["BULAN"].ToString();






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

            return rec;



        }
        public static IEnumerable<string> GetSejSem(string Butiran)
        {
            string[] rec = new string[2];
            //  var rec = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT replace(replace(replace(replace(Singkatan, 'LAMAN HIKMAH', 'LH'),'PEJ. PEMBANGUNAN', 'PEJ.PEMBGNAN.'),'PENERBIT UNIVERSITI','PENERBIT UNI.'),'PUSAT KOMPUTER','PUSAT KOM.') AS SINGKAT, CONVERT(NVARCHAR(10),MS08_TkhMula,103) AS TARIKH FROM V_PERIBADIMOBILE WHERE NoStaf = @NoStaf ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("NoStaf", Butiran);
                rdr = cmd.ExecuteReader();


                if (rdr.Read())
                {

                    //  tarikh = (int)rdr.GetInt64(0) ;
                    //   jum = tarikh.ToString();
                    //  rec[0] = rdr["SINGKAT"].ToString();
                    rec[0] = rdr["SINGKAT"].ToString();
                    rec[1] = rdr["TARIKH"].ToString();







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

            return rec;



        }
        public static IEnumerable<string> GetSejSem1(string Butiran)
        {
            string[] rec = new string[1];
            //  var rec = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT replace(replace(replace(replace(Singkatan, 'LAMAN HIKMAH', 'LH'),'PEJ. PEMBANGUNAN', 'PEJ.PEMBGNAN.'),'PENERBIT UNIVERSITI','PENERBIT UNI.'),'PUSAT KOMPUTER','PUSAT KOM.') AS SINGKAT FROM V_PERIBADIMOBILE WHERE NoStaf = @NoStaf ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("NoStaf", Butiran);
                rdr = cmd.ExecuteReader();


                if (rdr.Read())
                {

                    //  tarikh = (int)rdr.GetInt64(0) ;
                    //   jum = tarikh.ToString();
                    //  rec[0] = rdr["SINGKAT"].ToString();
                    rec[0] = rdr["SINGKAT"].ToString();

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

            return rec;



        }

        public static IEnumerable<string> GetElaun(string Butiran)
        {
            // string[] rec = new string[1];
            var rec = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='v-sql12.utem.edu.my';Initial Catalog='DbKewangan';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT  perihal,CONVERT(varchar(10),amaunt) AS GAJI from VGJ_SlipPndptnHis where gj09_nostaf = @gj09_nostaf and gj09_kodtrans <> 'GAJI' AND gj09_tahun = YEAR(GETDATE()) and gj09_bulan = (SELECT Max(gj09_bulan) FROM VGJ_SlipPndptnHis where gj09_tahun = YEAR(GETDATE()) ) ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@gj09_nostaf", Butiran);
                rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {

                    rec.Add(rdr.GetString(0));
                    rec.Add(rdr.GetString(1));

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

            return rec;



        }
        public static IEnumerable<string> GetPotongan(string Butiran)
        {
            // string[] rec = new string[1];
            var rec = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='v-sql12.utem.edu.my';Initial Catalog='DbKewangan';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT perihal,convert(varchar(10),sum(amaunt)) as jum from VGJ_SlipPtgnHis where gj09_nostaf = @gj09_nostaf AND gj09_tahun = YEAR(GETDATE()) AND gj09_bulan = (SELECT Max(gj09_bulan) FROM VGJ_SlipPndptnHis where gj09_tahun = YEAR(GETDATE()))  group by kod_trans,perihal,jenis_trans order by kod_trans,jenis_trans";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@gj09_nostaf", Butiran);
                rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {

                    rec.Add(rdr.GetString(0));
                    rec.Add(rdr.GetString(1));

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

            return rec;



        }
        public static IEnumerable<string> GetGajiKasar(string Butiran)
        {
            // string[] rec = new string[1];
            var rec = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='v-sql12.utem.edu.my';Initial Catalog='DbKewangan';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT CONVERT(varchar(10),sum(amaunt)) AS GAJI from  VGJ_SlipPndptnHis where gj09_nostaf = @gj09_nostaf  and gj09_kodtrans <> 'GAJI' AND gj09_tahun = YEAR(GETDATE()) and gj09_bulan = (SELECT Max(gj09_bulan) FROM VGJ_SlipPndptnHis where gj09_tahun = YEAR(GETDATE()) ) ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@gj09_nostaf", Butiran);
                rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {

                    rec.Add(rdr.GetString(0));
                    //     rec.Add(rdr.GetString(1));

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

            return rec;



        }
        public static IEnumerable<string> GetJumPotongan(string Butiran)
        {
            // string[] rec = new string[1];
            var rec = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='v-sql12.utem.edu.my';Initial Catalog='DbKewangan';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = " select convert(varchar(10),sum(amaunt)) as Jumlah from VGJ_SlipPtgnHis where gj09_nostaf = @gj09_nostaf   AND gj09_tahun = YEAR(GETDATE()) and gj09_bulan = (SELECT Max(gj09_bulan) FROM VGJ_SlipPndptnHis where gj09_tahun = YEAR(GETDATE()) ) ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@gj09_nostaf", Butiran);
                rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {

                    rec.Add(rdr.GetString(0));


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

            return rec;



        }
        public static IEnumerable<string> GetJumBersih(string Butiran)
        {
            IEnumerable<string> values = SQLPeribadi.GetElaun("");
            // string[] rec = new string[1];
            var rec = new List<string>();
            int tarikh = 0;
            int tarikh1 = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='v-sql12.utem.edu.my';Initial Catalog='DbKewangan';User ID='MobApp';Password='m0bile@pp2018'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT CONVERT(varchar(10),sum(amaunt)) AS GAJI from VGJ_SlipPndptnHis where gj09_nostaf = @gj09_nostaf and gj09_tahun = YEAR(GETDATE()) and gj09_bulan = (SELECT Max(gj09_bulan) FROM VGJ_SlipPndptnHis where gj09_tahun = YEAR(GETDATE()) ) ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@gj09_nostaf", Butiran);
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    rec.Add(rdr.GetString(0));



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

            return rec;



        }
    }

}