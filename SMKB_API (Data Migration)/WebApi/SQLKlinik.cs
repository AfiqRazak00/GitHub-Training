using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Net.NetworkInformation;
using System.Collections;
using System.Xml.Linq;

namespace WebAppKs.Services
{
    public class SQLKlinik
    {
        public static IEnumerable<string> GetKlinik(string staffno)
        {   //DATA STAF DAN STUDENT
            var rec = new List<string>();
            //  string[] rec = new string[7];
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "Select replace(replace(replace(replace(KS_NamaKlinik, 'UJONG PASIR', 'UP.'), 'SDN BHD',''),'BUKIT', 'BKT.'),'SDN. BHD.', '') FROM V_KLINIKMOBILE WHERE MS01_NoStaf = @MS01_NoStaf";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@MS01_NoStaf", staffno);
                //  cmd.Parameters.AddWithValue("@SMP01_Nomatrik", staff_no);
                // cmd.Parameters.AddWithValue("@NP13_Penilai", NP);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    //  rec[0] = rdr["KS_NamaKlinik"].ToString();
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
        public static IEnumerable<string> GetAlaKlinik(string staffno)
        {   //DATA STAF DAN STUDENT
            var rec = new List<string>();
            //  string[] rec = new string[7];
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "Select Alamat FROM V_KLINIKMOBILE WHERE MS01_NoStaf = @MS01_NoStaf";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@MS01_NoStaf", staffno);
                //  cmd.Parameters.AddWithValue("@SMP01_Nomatrik", staff_no);
                // cmd.Parameters.AddWithValue("@NP13_Penilai", NP);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    //  rec[0] = rdr["KS_NamaKlinik"].ToString();
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
//using System;
//using System.Collections.Generic;
//using System.Data.SqlClient;
//using System.Data;
//using System.Linq;
//using System.Web;
//using System;
//using System.Collections.Generic;
//using System.Data.SqlClient;
//using System.Data;
//using System.Linq;
//using System.Web;
//using System.Net.NetworkInformation;
//using System.Collections;
//using System.Xml.Linq;

//namespace WebAppKs.Services
//{
//    public class SQLKlinik
//    {
//        public static IEnumerable<string> GetKlinik(string staffno)
//        {   //DATA STAF DAN STUDENT
//             var rec = new List<string>();
//          //  string[] rec = new string[7];
//            string CommandText = "";
//            SqlDataReader rdr = null;
//            SqlConnection con = null;
//            SqlCommand cmd = null;
//            try
//            {
//                // Open connection to the database
//                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
//                con = new SqlConnection(ConnectionString);
//                con.Open();
//                CommandText = "Select replace(replace(KS_NamaKlinik, 'UJONG PASIR', 'UP'), 'PRIME MEDIC','PRIME MDC') FROM V_KLINIKMOBILE WHERE MS01_NoStaf = @MS01_NoStaf";

//                cmd = new SqlCommand(CommandText);
//                cmd.Connection = con;
//                cmd.CommandText = CommandText;
//                cmd.Parameters.AddWithValue("@MS01_NoStaf", staffno);
//                //  cmd.Parameters.AddWithValue("@SMP01_Nomatrik", staff_no);
//                // cmd.Parameters.AddWithValue("@NP13_Penilai", NP);
//                rdr = cmd.ExecuteReader();
//                while (rdr.Read())
//                {

//                    //  rec[0] = rdr["KS_NamaKlinik"].ToString();
//                    rec.Add(rdr.GetString(0));





//                }

//            }
//            catch (Exception)
//            {

//            }
//            finally
//            {
//                if (rdr != null)
//                    rdr.Close();

//                if (con.State == ConnectionState.Open)
//                    con.Close();
//            }

//            return rec;
//        }
//        public static IEnumerable<string> GetAlaKlinik(string staffno)
//        {   //DATA STAF DAN STUDENT
//            var rec = new List<string>();
//            //  string[] rec = new string[7];
//            string CommandText = "";
//            SqlDataReader rdr = null;
//            SqlConnection con = null;
//            SqlCommand cmd = null;
//            try
//            {
//                // Open connection to the database
//                String ConnectionString = @"Data Source='V-SQL11.utem.edu.my\SQL_INS01';Initial Catalog='Dbstaf';User ID='smsm';Password='#smsm@kutkm07'";
//                con = new SqlConnection(ConnectionString);
//                con.Open();
//                CommandText = "Select Alamat FROM V_KLINIKMOBILE WHERE MS01_NoStaf = @MS01_NoStaf";

//                cmd = new SqlCommand(CommandText);
//                cmd.Connection = con;
//                cmd.CommandText = CommandText;
//                cmd.Parameters.AddWithValue("@MS01_NoStaf", staffno);
//                //  cmd.Parameters.AddWithValue("@SMP01_Nomatrik", staff_no);
//                // cmd.Parameters.AddWithValue("@NP13_Penilai", NP);
//                rdr = cmd.ExecuteReader();
//                while (rdr.Read())
//                {

//                    //  rec[0] = rdr["KS_NamaKlinik"].ToString();
//                    rec.Add(rdr.GetString(0));





//                }

//            }
//            catch (Exception)
//            {

//            }
//            finally
//            {
//                if (rdr != null)
//                    rdr.Close();

//                if (con.State == ConnectionState.Open)
//                    con.Close();
//            }

//            return rec;
//        }
//    }
//}