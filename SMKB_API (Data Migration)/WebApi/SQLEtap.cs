using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
namespace WebApi
{
    public class SQLEtap
    {
        public static IEnumerable<string> finddataeTap(string user)
        {
            String ConnectionString = "";
            string CommandText = "";
            DateTime mydate = DateTime.Now;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[19];
            ret[0] = "no"; 
            try
            {
                // Open connection to the database
                ConnectionString = SQLAuth.dbase_dbeqcas;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "SELECT emailaddress, firstname, password,  department, att7, att15 FROM            live_user_staf WHERE att15 = @user  ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@user", user);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = rdr["att15"].ToString();
                    ret[1] = rdr["firstname"].ToString();
                    ret[2] = StatusDeclareStaff(user);
                    ret[3] = "Hijau";
                  
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





            if (ret[0] == "no")
            {
                // start find studeny
                if (
                    (user.ToString().Contains("d")) ||
                    (user.ToString().Contains("b")) ||
                    (user.ToString().Contains("bs")) ||
                    (user.ToString().Contains("m")) ||
                    (user.ToString().Contains("p"))
                    )
                {
                    try
                    {
                        // Open connection to the database
                        ConnectionString = SQLAuth.dbase_dbeqcas;
                        con = new SqlConnection(ConnectionString);
                        con.Open();
                        CommandText = "SELECT emailaddress, firstname, password,  department, att7, att15 FROM            live_user WHERE att15 = @user  ";
                        cmd = new SqlCommand(CommandText);
                        cmd.Connection = con;
                        cmd.Parameters.AddWithValue("@user", user);
                        rdr = cmd.ExecuteReader();
                        while (rdr.Read())
                        {
                            ret[0] = rdr["att15"].ToString();
                            ret[1] = rdr["firstname"].ToString();
                            if (
                               (user.ToString().Contains("d")) ||
                               (user.ToString().Contains("b"))
                               )
                            {
                                ret[2] = "[TIDAK BERISIKO]";  // StatusDeclareStaff(user);
                                ret[3] = "Hijau";
                            }
                            if (
                                (user.ToString().Contains("m")) ||
                                (user.ToString().Contains("p"))
                                )
                            {
                                ret[2] = StatusDeclareStudentPost(user);
                                ret[3] = "Hijau";
                            }

                            if (
                                (user.ToString().Contains("bs"))
                               )
                            {
                                ret[2] = StatusDeclareStudentUnder(user);
                                ret[3] = "Hijau";
                            }
                          //  ret[3] = " ";

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
                    // end find student
                }
            if (ret[0] == "no")
            {
                // start find pkpluar ketua
                try
                {
                    // Open connection to the database
                    ConnectionString = SQLAuth.dbase_dbstaf;
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    CommandText = "SELECT TOP (1)  PW17_NamaPemohon, PW17_NoKP FROM     PW17_PLV  where PW17_NoKP=@user";
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@user", user);
                    rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        ret[0] = rdr["PW17_NoKP"].ToString();
                        ret[1] = rdr["PW17_NamaPemohon"].ToString();
                        ret[2] = StatusDeclareLuarKetua(user);
                        ret[3] = "Hijau";

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



                // end find pkp luar ketua
            }
            if (ret[0] == "no")
            {
                // start find pkpluar pekerja
                try
                {
                    // Open connection to the database
                    ConnectionString = SQLAuth.dbase_dbstaf;
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    CommandText = "SELECT TOP (1) PW17_ID, PW17_EmpId, PW17_NamaSyarikat, PW17_NamaPemohon, PW17_NoKP, PW17_NoPasport, PW17_Warganegara, PW17_StaSaring, PW17_PejLokasi, PW17_Tahun, TkhWujud, PW17_MyImage FROM PW17_PLV_Detail where PW17_NoKP=@user";
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.Parameters.AddWithValue("@user", user);
                    rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        ret[0] = rdr["PW17_NoKP"].ToString();
                        ret[1] = rdr["PW17_NamaPemohon"].ToString();
                        ret[2] = StatusDeclareLuarPekerja(user);
                        ret[3] = "Hijau";

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



                // end find pkp luar pekerja
            }
            return ret;

        }

        public static IEnumerable<string> CheckeTapQrcode(string userid,  string qrcode )
        {
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[6];
            ret[0] = "no";

            if (QrCodeValid(qrcode) == true)
            {
                string lokasix = QrCodeLokasi(qrcode);
                DateTime mydate = DateTime.Now;
                string mytime = DateTime.Now.ToShortTimeString();
                string mydateshort = DateTime.Now.ToString("dd/MM/yyyy");

                String ConnectionString = SQLAuth.dbase_dbmobile;
                CommandText = "INSERT INTO  pkp04_kehadiran_etap ( userid, qr_id, lokasi, tarikh ) values (@USERID, @qrcode,@lokasi,@MYDATE)";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", userid);
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
                cmd.Parameters.AddWithValue("@lokasi", lokasix);
                cmd.Parameters.AddWithValue("@qrcode", qrcode);
                rdr = cmd.ExecuteReader();
                ret[0] = "punchinok";
                ret[1] = lokasix; //mydate.ToString();
                ret[2] = mydate.ToString();

            }
            else
            {
                ret[0] = "QR Code tidak sah";
            }

            return ret;
        }
        private static bool QrCodeValid(string qrcode)
        {
            bool mybol = false;
            string CommandText = "";
            String ConnectionString = SQLAuth.dbase_dbmobile;
            CommandText = "SELECT  qr_id, lokasi, pejabat FROM pkp03_qr_etap where qr_id=@qrcode";  
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@qrcode", qrcode);
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

        private static string QrCodeLokasi(string qrcode)
        {
            string mybol = "";
            string CommandText = "";
            String ConnectionString = SQLAuth.dbase_dbmobile;
            CommandText = "SELECT  qr_id, lokasi, pejabat FROM pkp03_qr_etap where qr_id=@qrcode";
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@qrcode", qrcode);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                mybol = reader["lokasi"].ToString().Trim();
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
        public static IEnumerable<string> GetetapResultNew(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();


               
                string CommandText = "SELECT  id, userid, qr_id, lokasi, tarikh FROM     pkp04_kehadiran_etap where userid=@userid order by tarikh desc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                //   cmd.Parameters.AddWithValue("@app_id", app_Id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["lokasi"].ToString());
                    myList.Add(rdr["tarikh"].ToString());
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
        private static string StatusDeclareStaff(string myid)
        {
            string ret = "[TIDAK BERISIKO]";
            DateTime mydate = DateTime.Now;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT TOP (1) a.PKP02_NoStaf, a.PKP02_TkhHadir, CASE WHEN a.PKP02_StatusSaring = '1' THEN 'SIHAT' WHEN a.PKP02_StatusSaring = '2' THEN 'BERGEJALA' WHEN a.PKP02_StatusSaring = '3' THEN 'BERRISIKO' END AS KetSaring, ";
                CommandText = CommandText + " b.MS01_Nama, d.JawGiliran, f.Pejabat ";
                CommandText = CommandText + " FROM     PKP02_SARINGANCOV19 AS a INNER JOIN ";
                CommandText = CommandText + " MS01_Peribadi AS b ON a.PKP02_NoStaf = b.MS01_NoStaf AND b.MS01_Status = 1 INNER JOIN ";
                CommandText = CommandText + " MS02_Perjawatan AS c ON b.MS01_NoStaf = c.MS01_NoStaf INNER JOIN ";
                CommandText = CommandText + " MS_Jawatan AS d ON c.MS02_JawSandang = d.KodJawatan INNER JOIN ";
                CommandText = CommandText + " MS08_Penempatan AS e ON b.MS01_NoStaf = e.MS01_NoStaf AND e.MS08_StaTerkini = 1 INNER JOIN ";
                CommandText = CommandText + " MS_Pejabat AS f ON e.MS08_Pejabat = f.KodPejabat ";
                CommandText = CommandText + " WHERE(a.PKP02_NoStaf = @userid) and (a.PKP02_TkhHadir=@mydate)";
                CommandText = CommandText + " ORDER BY a.PKP02_TkhHadir DESC ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", myid);
                cmd.Parameters.AddWithValue("@mydate", mydate);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret = rdr["KetSaring"].ToString().Trim();
                }
              
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
            return ret;
        }

        private static string StatusDeclareStudentUnder(string myid)
        {
            string ret = "[TIDAK BERISIKO]";
            DateTime mydate = DateTime.Now;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT TBL.NOMATRIK, TBL.NAMA, TBL.TKH_TUJUAN, TBL.TUJUAN, TBL.TKH_MOHON, TBL.STATUS_MOHON, TBL.KATEGORI,  ";
                CommandText = CommandText + " CASE WHEN(TBL.NOBILIK IS NULL) THEN '-' ELSE TBL.NOBILIK END AS NOBILIK, ";
                CommandText = CommandText + " CASE WHEN(TBL.KOLEJ IS NULL) THEN 'Kediaman Luar' ELSE TBL.KOLEJ END AS KOLEJ ";
                CommandText = CommandText + " FROM ";
                CommandText = CommandText + " ( ";
                CommandText = CommandText + " SELECT A.SMP01_Nomatrik AS NOMATRIK, B.SMP01_Nama AS NAMA, A.HEP02_tkhaku AS TKH_TUJUAN, ";
                CommandText = CommandText + " '' AS TUJUAN, A.HEP02_tkhaku AS TKH_MOHON, ";
                CommandText = CommandText + " CASE A.HEP02_statussaring WHEN 1 THEN 'LULUS' ELSE 'TOLAK' END AS STATUS_MOHON, ";
                CommandText = CommandText + " '' AS KATEGORI, ";
                CommandText = CommandText + " NULL AS NOBILIK, ";
                CommandText = CommandText + " NULL AS KOLEJ ";
                CommandText = CommandText + " FROM dbstudentpsh.dbo.PPSH_SARINGANKESIHATANVCOV19 AS A ";
                CommandText = CommandText + " INNER JOIN dbstudentpsh.dbo.SMP01_Peribadi AS B ON A.SMP01_Nomatrik = B.SMP01_Nomatrik ";
                CommandText = CommandText + " ) AS TBL ";
                CommandText = CommandText + " WHERE TBL.NOMATRIK = @userid ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", myid);
                cmd.Parameters.AddWithValue("@mydate", mydate);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                     ret = rdr["STATUS_MOHON"].ToString().Trim();
                }

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
            return ret;
        }

        private static string StatusDeclareStudentPost(string myid)
        {
            string ret = "[TIDAK BERISIKO]";
            DateTime mydate = DateTime.Now;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT SMG55_PKPBMasukUTeM.idnum,SMG55_PKPBMasukUTeM.smg01_nomatrik, smg55_tarikhmula, smg55_tarikhakhir, smg55_tujuanmasuk as TUJUAN, ";
                CommandText = CommandText + " smg55_fakultiakses, E.NamaPEjPBU as FAKULTI, ";
                CommandText = CommandText + " case when smg55_kelulusan IS Null then 'PROSES' when smg55_kelulusan = 0 then 'TIDAK LULUS' when smg55_kelulusan = 1 THEN 'LULUS' END AS STAT, ";
                CommandText = CommandText + " case when smg54_statussaring = '1' then 'HIJAU' WHEN smg54_statussaring = '2' THEN 'KUNING' WHEN smg54_statussaring = '3' THEN 'MERAH' END AS STATSARING, ";
                CommandText = CommandText + " smg55_sbbtdklulus,b.smg02_nama as NAMA,c.smg01_kodkursus as KURSUS,d.smg54_statussaring, smg54_notelBimbit as TELEFON FROM SMG55_PKPBMasukUTeM ";
                CommandText = CommandText + " inner join smg02_peribadi as b on SMG55_PKPBMasukUTeM.smg01_nomatrik = b.smg01_nomatrik ";
                CommandText = CommandText + " inner join smg01_pengajian as c on c.smg01_nomatrik = SMG55_PKPBMasukUTeM.smg01_nomatrik ";
                CommandText = CommandText + "  inner join SMG54_SARINGANKESIHATANVCOV19 as d on d.smg01_nomatrik = SMG55_PKPBMasukUTeM.smg01_nomatrik ";
                CommandText = CommandText + "  and SMG55_PKPBMasukUTeM.smg54_idnum = d.idnum ";
                CommandText = CommandText + " INNER JOIN[V - SQL11].DBSTAF.DBO.VPERIBADI15 AS E ON E.KodPejPBU = SMG55_PKPBMasukUTeM.smg55_fakultiakses ";
                CommandText = CommandText + "  where SMG55_PKPBMasukUTeM.smg01_nomatrik = @userid ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", myid);
                cmd.Parameters.AddWithValue("@mydate", mydate);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                     ret = rdr["STATSARING"].ToString().Trim();
                }

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
            return ret;
        }

        private static string StatusDeclareLuarKetua(string myid)
        {
            string ret = "[TIDAK BERISIKO]";
            DateTime mydate = DateTime.Now;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT A.PW17_ID, A.PW17_Kategori as Kategori, A.PW17_NamaSyarikat as ";
                CommandText = CommandText + " NamaSya, A.PW17_NamaPemohon as NamaMohon, A.PW17_NoKP as NoKP,  ";
                CommandText = CommandText + " A.PW17_Email as Email, A.PW17_TkhMula, A.PW17_TkhTamat, A.PW17_Tujuan as Tujuan, A.PW17_Status as Status, ";
                CommandText = CommandText + " CASE WHEN A.PW17_StaSaring = 1 THEN 'HIJAU' WHEN A.PW17_StaSaring = 0 THEN 'KUNING' END as StaSaring, A.PW17_MyImage, B.NamaPEjPBU as Lokasi ";
                CommandText = CommandText + " FROM PW17_PLV A INNER JOIN VPERIBADI15 B ON B.KodPejPBU = A.PW17_PejLokasi ";
                CommandText = CommandText + " WHERE PW17_NoKP = @userid ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", myid);
                cmd.Parameters.AddWithValue("@mydate", mydate);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                   // ret = rdr["KetSaring"].ToString().Trim();
                }

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
            return ret;
        }
        private static string StatusDeclareLuarPekerja(string myid)
        {
            string ret = "[TIDAK BERISIKO]";
            DateTime mydate = DateTime.Now;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT A.PW17_EmpId as NoStaf, A.PW17_NamaPemohon as NamaStaf, A.PW17_NoKP as KPStaf, A.PW17_MyImage, ";
                CommandText = CommandText + " B.PW17_NamaSyarikat as NamaSya, B.PW17_Kategori as Kategori, B.PW17_TkhMula,  ";
                CommandText = CommandText + " B.PW17_TkhTamat, B.PW17_Status as Stat, B.PW17_Tujuan as Tujuan, C.NamaPEjPBU as Lokasi, B.PW17_Email, ";
                CommandText = CommandText + " CASE WHEN B.PW17_StaSaring = 1 THEN 'HIJAU' WHEN B.PW17_StaSaring = 0 THEN 'KUNING' END as StaSaring ";
                CommandText = CommandText + " FROM PW17_PLV_DETAIL A INNER JOIN PW17_PLV B ON A.PW17_ID = B.PW17_ID ";
                CommandText = CommandText + " INNER JOIN VPERIBADI15 AS C ON C.KodPejPBU = B.PW17_PejLokasi ";
                CommandText = CommandText + " WHERE A.PW17_NoKP = @userid ";
                

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", myid);
                cmd.Parameters.AddWithValue("@mydate", mydate);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret = rdr["StaSaring"].ToString().Trim();
                }

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
            return ret;
        }
    }
}