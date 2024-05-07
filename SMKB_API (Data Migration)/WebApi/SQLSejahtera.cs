using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Data.SqlClient;
using System.Data;

namespace WebApi
{
    public class SQLSejahtera
    {
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
                //    myList.Add(" ");
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
    }
}