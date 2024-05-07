

using System;

using System.Data.SqlClient;

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Device.Location;
using System.Globalization;
using System.Data;
using System.IO;

namespace WebApi
{
    public class SQLMigs
    {
        //  //https://mobileapp.utem.edu.my/api/Publicw/2/VCC/721219015523/23.98/VCC2022/0/0
        //      string data = SQLMigs.Writetrybayarmigs_guest("2", orderId, app_Id, mob_Id, logincode_Id, lat1,  long1);

        public static string Writetrybayarmigs_guest(string shortmodul, string userid, string jumlah, string nota, string param1, string param2)
        {
            DateTime mydate = DateTime.Now;
            string myStr = "no";
            string orderid = shortmodul + "" + mydate.ToString("yyyy") + JumRec();
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        // Tran_id, Ref_id, userid, mydate_req, status_tran, status_migs, mydate_migs, amt_pay, vpc_MerchTxnRef, note, jenis_modul, vpc_TxnResponseCode, nama, email, param1, param2, 
                        //  param3

                        cmd.CommandText = @"INSERT INTO  migs_payment   (Ref_id, userid, mydate_req, status_tran, status_migs,amt_pay, note, param1, param2, param3, jenis_modul) VALUES (@refid, @USERID,  @mydate, '0', '0', @jumlah, @nota, @param1, @param2, @param3, @shortmodul)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@refid", orderid);
                        cmd.Parameters.AddWithValue("@jumlah", jumlah);
                        cmd.Parameters.AddWithValue("@mydate", mydate);
                        cmd.Parameters.AddWithValue("@param1", "" + param1);
                        cmd.Parameters.AddWithValue("@param2", "" + param2);
                        cmd.Parameters.AddWithValue("@param3", "");
                        cmd.Parameters.AddWithValue("@shortmodul", "" + shortmodul);
                        cmd.Parameters.AddWithValue("@nota", nota);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            myStr = orderid;
                        }
                        catch (SqlException e)
                        {
                            // myStr = ""e.Message.ToString() + "no22";

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // myStr = "no33";
            }
            return myStr;
        }
        public static string Writetrybayarmigs(string shortmodul, string userid, string jumlah, string nota, string param1, string param2, string param3)
        {
            DateTime mydate = DateTime.Now;
            string myStr = "no";
            string orderid = shortmodul + "" + mydate.ToString("yyyy") + JumRec();
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                       // Tran_id, Ref_id, userid, mydate_req, status_tran, status_migs, mydate_migs, amt_pay, vpc_MerchTxnRef, note, jenis_modul, vpc_TxnResponseCode, nama, email, param1, param2, 
                       //  param3

                        cmd.CommandText = @"INSERT INTO  migs_payment   (Ref_id, userid, mydate_req, status_tran, status_migs,amt_pay, note, param1, param2, param3, jenis_modul) VALUES (@refid, @USERID,  @mydate, '0', '0', @jumlah, @nota, @param1, @param2, @param3, @shortmodul)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@refid", orderid);
                        cmd.Parameters.AddWithValue("@jumlah", jumlah);
                        cmd.Parameters.AddWithValue("@mydate", mydate);
                        cmd.Parameters.AddWithValue("@param1", "" + param1);
                        cmd.Parameters.AddWithValue("@param2", "" + param2);
                        cmd.Parameters.AddWithValue("@param3", "" + param3);
                        cmd.Parameters.AddWithValue("@shortmodul", "" + shortmodul);
                        cmd.Parameters.AddWithValue("@nota", nota);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            myStr = orderid;
                        }
                        catch (SqlException e)
                        {
                           // myStr = ""e.Message.ToString() + "no22";

                        }
                    }
                }
            }
            catch (Exception ex)
            {
               // myStr = "no33";
            }
            return myStr;
        }

        public static IEnumerable<string> WritetrybayarfpxNew(string shortmodul, string userid, string amount, string nota, string kategori, string param2, string bankname)
        {
            DateTime mydate = DateTime.Now;
            DateTime foo = DateTime.Now;
            long unixTime = ((DateTimeOffset)foo).ToUnixTimeSeconds();
            string orderid = shortmodul + "fpx" + unixTime.ToString() + JumRecFPX();
            string[] ret = new string[2];
            ret[0] = "no";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {

                        cmd.CommandText = @"insert into  fpx01_sumbangan (orderID, name, noIC, email, amount, kategori,  status, banklist, bankname)  VALUES (@orderid, @Nama,  @NoKP, @email, @amount, @kategori, @status, @bank, @bankname)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@orderid", orderid);
                        cmd.Parameters.AddWithValue("@Nama", userid);
                        cmd.Parameters.AddWithValue("@NoKP", userid);
                        cmd.Parameters.AddWithValue("@email", "test@yahoo.com");
                        cmd.Parameters.AddWithValue("@amount", amount);
                        cmd.Parameters.AddWithValue("@kategori", kategori);
                        cmd.Parameters.AddWithValue("@status", "9");
                        cmd.Parameters.AddWithValue("@bank", getcodebank(bankname));
                        cmd.Parameters.AddWithValue("@bankname", bankname);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            ret[0] = orderid;
                            ret[1] = bankname;
                        }
                        catch (SqlException e)
                        {
                            ret[1] = e.Message.ToString();

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[1] = ex.Message.ToString();
            }

            return ret;
        }

            public static string Writetrybayarfpx(string shortmodul, string userid, string amount, string nota, string kategori, string param2, string bankname)
        {
            DateTime mydate = DateTime.Now;
            string myStr = "no";
            DateTime foo = DateTime.Now;
           long unixTime = ((DateTimeOffset)foo).ToUnixTimeSeconds();
           string orderid = shortmodul + "fpx" + unixTime.ToString() +  JumRecFPX();
          //  string orderid = shortmodul + "fpx" + mydate.ToString("yyyy") + JumRecFPX();
            //  cmd.Parameters.AddWithValue("@Tarikh", mydate.ToString("yyyy-MM-dd"));
            //  cmd.Parameters.AddWithValue("@Masa", mydate.ToString("HH:mm"));



            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {

                        cmd.CommandText = @"insert into  fpx01_sumbangan (orderID, name, noIC, email, amount, kategori,  status, banklist, bankname)  VALUES (@orderid, @Nama,  @NoKP, @email, @amount, @kategori, @status, @bank, @bankname)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@orderid", orderid);
                        cmd.Parameters.AddWithValue("@Nama", userid);
                        cmd.Parameters.AddWithValue("@NoKP", userid);
                        cmd.Parameters.AddWithValue("@email", "test@yahoo.com");
                        cmd.Parameters.AddWithValue("@amount",  amount);
                        cmd.Parameters.AddWithValue("@kategori", kategori);
                        cmd.Parameters.AddWithValue("@status", "9");
                        cmd.Parameters.AddWithValue("@bank", getcodebank(bankname));
                        cmd.Parameters.AddWithValue("@bankname", bankname);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            myStr = orderid;
                        }
                        catch (SqlException e)
                        {
                             myStr = e.Message.ToString();

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                myStr = ex.Message.ToString();
            }
            return myStr;
        }

        public static string  getcodebank(string bank)
        {
            string ret = "no";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbclm;
                con = new SqlConnection(ConnectionString);
                con.Open();
                string CommandText = "SELECT   KodBank, Bank FROM FPX_Bank where Bank=@bank";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@bank", bank);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret = rdr["KodBank"].ToString().Trim();
                    break;
                  
                }
                return ret;
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

        public static string StatusResetPassword(string userid, string mymodul)
        {

            String ConnectionString = "";
            string CommandText = "";
            string mjum = "no";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                ConnectionString = SQLAuth.dbase_dbmobile;
                CommandText = "SELECT mymodul FROM  AspNetResetEmail where mymodul=@mymodul and status=@status and  user_id=@userid";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@mymodul", mymodul);
                cmd.Parameters.AddWithValue("@status", "0");
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    string ook = rdr["mymodul"].ToString();
                    mjum = "ok";
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
            return mjum;
        }
        public static string ResetPassword(string userid, string mymodul, string mypass, string mytype, string myemail, string mylang)
        {
            DateTime mydate = DateTime.Now;
            string myStr = "no";
            if (userid.Length >= 2)
            {
                string passwordss = "";
                string passwordss24 = mypass.Substring(3, mypass.Length - 8) + "==";
                string passwordss44 = mypass.Substring(3, mypass.Length - 8) + "=";
                string passwordss64 = mypass.Substring(3, mypass.Length - 8);
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
                string password = AESEncrytDecry.DecryptStringAES_notuser(passwordss, userid);
                //   string orderid = shortmodul + "" + mydate.ToString("yyyy") + JumRec();
                try
                {
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            // Tran_id, Ref_id, userid, mydate_req, status_tran, status_migs, mydate_migs, amt_pay, vpc_MerchTxnRef, note, jenis_modul, vpc_TxnResponseCode, nama, email, param1, param2, 
                            //  param3

                            cmd.CommandText = @"INSERT INTO  AspNetResetEmail   ( user_id, email, mypassword,  mymodul, mytype, status, note) VALUES (@user_id, @email, @mypassword, @mymodul, @mytype, @status, @note)";
                            cmd.Connection = sqlConn;
                            cmd.Parameters.AddWithValue("@user_id", userid);
                            if (mymodul == "Domain")
                            {
                                if (mytype == "Staf")
                                {
                                    cmd.Parameters.AddWithValue("@email", "Staff.utem.edu");
                                }
                                else
                                {
                                    cmd.Parameters.AddWithValue("@email", "Student.utem.edu");
                                }
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue("@email", myemail);
                            }
                            cmd.Parameters.AddWithValue("@mypassword", password);
                            // cmd.Parameters.AddWithValue("@mydate", mydate);
                            cmd.Parameters.AddWithValue("@mymodul", mymodul);
                            cmd.Parameters.AddWithValue("@mytype", mytype);
                            cmd.Parameters.AddWithValue("@status", "0");
                            cmd.Parameters.AddWithValue("@note", "");
                            try
                            {
                                sqlConn.Open();
                                cmd.ExecuteNonQuery();
                                myStr = "ok";
                                try
                                {
                                    if (mymodul == "Domain")
                                    {
                                        if (mytype == "Staf")
                                        {
                                           // cmd.Parameters.AddWithValue("@email", "Staff.utem.edu");
                                          File.WriteAllText(@"C:\log_iis\WriteText.txt", "test " + mydate.ToString());
                                           // File.WriteAllText(@"C:C:\inetpub\wwwroot\WriteText.txt", "test " + mydate.ToString());

                                        }
                                        else
                                        {
                                           // cmd.Parameters.AddWithValue("@email", "Student.utem.edu");
                                            File.WriteAllText(@"C:\log_iis\WriteText_st.txt", "test " + mydate.ToString());

                                        }
                                    }
                                    else
                                    {
                                        //cmd.Parameters.AddWithValue("@email", myemail);
                                        if (mymodul == "Email")
                                        {
                                            File.WriteAllText(@"C:\log_iis\WriteTextEmail.txt", "test " + mydate.ToString());
                                        }
                                    }


                                    //if (mymodul == "Domain") {
                                    //    if (myemail == "Staff.utem.edu")
                                    //    {
                                    //        File.WriteAllText(@"C:\log_iis\WriteText.txt", "test " + mydate.ToString());
                                    //    }
                                    //    else
                                    //    {
                                    //        File.WriteAllText(@"C:\log_iis\WriteText_st.txt", "test " + mydate.ToString());

                                    //    }
                                    //}
                                    //if (mymodul == "Email")
                                    //{
                                    //    File.WriteAllText(@"C:\log_iis\WriteTextEmail.txt", "test " + mydate.ToString());
                                    //}
                                }
                                catch (Exception e)
                                {
                                    // mm = e.Message.ToString();
                                    //  myStr = e.Message.ToString();
                                    // Console.WriteLine(e);

                                }
                                //   myStr = "ok";
                            }
                            catch (SqlException e)
                            {
                                // myStr = ""e.Message.ToString() + "no22";

                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    // myStr = "no33";
                }
            }
            return myStr;
        }
        public static string InsertClmLogResetPassword(string userid)
        {
            DateTime mydate = DateTime.Now;
            string myStr = "no";

                try
                {
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbclm))
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                            cmd.CommandText = @"INSERT INTO   CLM_AudSekuriti   ( UserID, UNama, ULevel, Keterangan, InfoLama, InfoBaru, Tarikh, Masa, KodSesi_sem, ModId, PwdStatus, IPAddress) VALUES (@user_id, @UNama, @ULevel, @Keterangan, @InfoLama, @InfoBaru, @Tarikh, @Masa, @KodSesi_sem, @ModId, @PwdStatus, @IPAddress)";
                            cmd.Connection = sqlConn;
                            cmd.Parameters.AddWithValue("@user_id", userid);
                            cmd.Parameters.AddWithValue("@UNama", userid);
                            cmd.Parameters.AddWithValue("@ULevel", userid);
                            cmd.Parameters.AddWithValue("@Keterangan", "Reset Password from myUTeM");
                            cmd.Parameters.AddWithValue("@InfoLama", "");
                            cmd.Parameters.AddWithValue("@InfoBaru", "");
                            cmd.Parameters.AddWithValue("@Tarikh", mydate.ToString("yyyy-MM-dd"));
                            cmd.Parameters.AddWithValue("@Masa", mydate.ToString("HH:mm"));
                            cmd.Parameters.AddWithValue("@KodSesi_sem", "");
                            cmd.Parameters.AddWithValue("@ModId", "2");
                            cmd.Parameters.AddWithValue("@PwdStatus", "1");
                            cmd.Parameters.AddWithValue("@IPAddress", "10.1.2.125");

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

        public static string InsertCutiSetting(string userid,
                                                                                string MystartDate,
                                                                                string MyendDate,
                                                                                string MynumberOfDays,
                                                                                string Myalamat,
                                                                                string Myposkod,
                                                                                string Mybandar,
                                                                                string Mytelefon,
                                                                                string Mysebab,
                                                                                string Mynegeri,
                                                                                string Mynegara,
                                                                                string Myemail,
                                                                                string Mylang)
        {
            DateTime mydate = DateTime.Now;
            string myStr = "no";
            string newstat = "";
                try
                {
                if  ( GetIDPelulus(userid)== GetIDSokong(userid)) {
                    newstat = "Sokong";
                } else {
                    newstat = "Proses";
                }
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbstaf))
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {
                        DateTime myday;
                        Random rnd = new Random();
                        int myrnd = rnd.Next(100000, 10000000);
                        DateTime startDate = Convert.ToDateTime(DateTime.ParseExact(MystartDate, "dd/MM/yyyy", CultureInfo.InvariantCulture));
                        DateTime endDate = Convert.ToDateTime(DateTime.ParseExact(MyendDate, "dd/MM/yyyy", CultureInfo.InvariantCulture));
                        IEnumerable<string> valuesxx = Cuti_getemail(userid);
                        var myListxx = valuesxx.ToList();

                        string mykod = userid + "" + DateTime.Now.ToString("dd/MM/yyyy") + "" + DateTime.Now.ToString("HH:mm:ss");
                            if (newstat == "Sokong") {
                                cmd.CommandText = @"insert into MS26_CutiStaf  (MS26_Penyokong, MS26_TkhSokong, MS26_KodMohonCuti, MS01_NoStaf, CT_KodKategoriCuti, CT_KodCuti, MS26_Tahun, MS26_TkhMula, MS26_TkhTamat, MS26_BilHari, MS01_AlamatT1, MS01_PoskodTetap, MS01_BandarTetap, MS01_NegeriTetap, MS01_NegaraTetap, MS01_NoTelR1, MS26_StatusCuti,MS26_SebabCuti,MS26_TkhMohon,MS08_Pejabat,MS26_StaEL,MS_Sumber, MS_SecCode)  values (@Penyokong, @TkhSokong, @MyCutiKod,@user_id,@CT_KodKategoriCuti,@CT_KodCuti,@MS26_Tahun,@MystartDate,@MyendDate,@MynumberOfDays,@Myalamat,@Myposkod,@Mybandar,@Mynegeri,@Mynegara,@Mytelefon,@Mystatus,@Mysebab, @MS26_TkhMohon,@MS08_Pejabat,@MS26_StaEL,@MS_Sumber, @MS_SecCode)";

                            }
                            else {
                                cmd.CommandText = @"insert into MS26_CutiStaf  (MS26_KodMohonCuti, MS01_NoStaf, CT_KodKategoriCuti, CT_KodCuti, MS26_Tahun, MS26_TkhMula, MS26_TkhTamat, MS26_BilHari, MS01_AlamatT1, MS01_PoskodTetap, MS01_BandarTetap, MS01_NegeriTetap, MS01_NegaraTetap, MS01_NoTelR1, MS26_StatusCuti,MS26_SebabCuti,MS26_TkhMohon,MS08_Pejabat,MS26_StaEL,MS_Sumber, MS_SecCode)  values (@MyCutiKod,@user_id,@CT_KodKategoriCuti,@CT_KodCuti,@MS26_Tahun,@MystartDate,@MyendDate,@MynumberOfDays,@Myalamat,@Myposkod,@Mybandar,@Mynegeri,@Mynegara,@Mytelefon,@Mystatus,@Mysebab, @MS26_TkhMohon,@MS08_Pejabat,@MS26_StaEL,@MS_Sumber, @MS_SecCode)";

                            }
                            cmd.Connection = sqlConn;
                            cmd.Parameters.AddWithValue("@MyCutiKod", mykod);
                            cmd.Parameters.AddWithValue("@user_id", userid);
                            cmd.Parameters.AddWithValue("@CT_KodKategoriCuti", "02");
                            cmd.Parameters.AddWithValue("@CT_KodCuti", "0201");
                            cmd.Parameters.AddWithValue("@MS26_Tahun", "2023");
                            cmd.Parameters.AddWithValue("@MystartDate", startDate);
                            cmd.Parameters.AddWithValue("@MyendDate", endDate);
                            cmd.Parameters.AddWithValue("@MynumberOfDays", MynumberOfDays);
                            cmd.Parameters.AddWithValue("@Myalamat", Myalamat);
                            cmd.Parameters.AddWithValue("@Myposkod", Myposkod);
                            cmd.Parameters.AddWithValue("@Mybandar", Mybandar);
                            cmd.Parameters.AddWithValue("@Mytelefon", Mytelefon);
                            cmd.Parameters.AddWithValue("@Mysebab", Mysebab);
                            cmd.Parameters.AddWithValue("@Mynegeri", Mynegeri);
                            cmd.Parameters.AddWithValue("@Mynegara", Mynegara);
                            cmd.Parameters.AddWithValue("@Mystatus", newstat);
                            cmd.Parameters.AddWithValue("@MS26_TkhMohon", DateTime.Now);
                            cmd.Parameters.AddWithValue("@MS08_Pejabat", myListxx[3]);
                            cmd.Parameters.AddWithValue("@MS26_StaEL", "0");
                            cmd.Parameters.AddWithValue("@MS_Sumber", "myUTeM");
                            cmd.Parameters.AddWithValue("@MS_SecCode", myrnd.ToString());

                            cmd.Parameters.AddWithValue("@TkhSokong", DateTime.Now);
                        cmd.Parameters.AddWithValue("@Penyokong", GetIDSokong(userid));
                        //MS26_TkhSokong=@mydate
                     //   MS26_Penyokong = @Penyokong,

                        try
                        {
                                sqlConn.Open();
                                cmd.ExecuteNonQuery();
                                myStr = "ok";
                                string mysett = UpdateCutiSetting(userid, MynumberOfDays);
                            if (newstat == "Sokong")
                            {
                                string hh3 = myEmailBody(userid, MystartDate, MyendDate, MynumberOfDays, Mysebab, Mytelefon, myListxx[2], mykod);
                                string cc3 = SQLPerakamgeo.SendEmailSMSM(myListxx[1], "PERMOHONAN CUTI REHAT SEDANG DIPROSES", hh3);
                                IEnumerable<string> valuesxx1 = Cuti_getemail(GetIDPelulus(userid));
                                var myListxx1 = valuesxx1.ToList();
                                string hh215 = myEmailBodyPemohon_notifypelulus(userid, MystartDate, MyendDate, MynumberOfDays, Mysebab, Mytelefon, myListxx[2], mykod);
                                string cc215 = SQLPerakamgeo.SendEmailSMSM(myListxx1[1], "KELULUSAN PERMOHONAN CUTI REHAT", hh215);

                            }
                            else
                            {
                                string hh = myEmailBody(userid, MystartDate, MyendDate, MynumberOfDays, Mysebab, Mytelefon, myListxx[2], mykod);
                                string cc = SQLPerakamgeo.SendEmailSMSM(myListxx[1], "PERMOHONAN CUTI REHAT SEDANG DIPROSES", hh);
                                string hh2 = myEmailBody_sokong(userid, MystartDate, MyendDate, MynumberOfDays, Mysebab, Mytelefon, myListxx[2], mykod);
                                string cc2 = SQLPerakamgeo.SendEmailSMSM(GetEmailSokong(userid), "PERMOHONAN CUTI UNTUK TINDAKAN SOKONGAN", hh2);
                            }
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
            private static string myEmailBody(string userid, string MystartDate, string MyendDate, string MynumberOfDays, string Mysebab, string Mytelefon, string name, string mykod)
        {
            string data;
            IEnumerable<string> valuesxx2z = Cuti_getdetailcuti(mykod);
            var myListxx2z = valuesxx2z.ToList();
            data = "Assalamualaikum wrt. wbt dan Salam Sejahtera, <br> \n";
            data = data + "YBhg. Datuk/Prof./Prof. Madya/Dr./Tuan/Puan, <br>\n";
            data = data + "<br>\n";
            data = data + "Permohonan cuti telah direkodkan dan sedang di proses <br>\n";
            data = data + "<br>\n";
            data = data + "No Staf: <strong>" + userid + "-" + name + "</strong>  <br>\n";
            data = data + "Alamat Semasa Bercuti : <strong>" + myListxx2z[2] + " </strong>  <br>\n";
            data = data + "Tarikh Bercuti : <strong>" + MystartDate + " hingga " + MyendDate + " </strong> <br>\n";
            data = data + "Bil. Hari Bercuti : <strong>" + MynumberOfDays + " hari  </strong><br>\n";
            data = data + "Sebab Bercuti :  <strong>" + Mysebab + " </strong> <br>\n";
            data = data + "Telefon : <strong>" + Mytelefon + "</strong>  <br>\n";
            data = data + "Status Permohonan : <strong>Sedang diproses</strong> <br>\n";
            data = data + "<br>\n";
            data = data + "Terima kasih <br>\n";
            data = data + "Makluman ini adalah secara automatik daripada Sistem Maklumat Sumber Manusia.<br>\n";
            data = data + "<br>\n";
            data = data + "Anda Tidak Perlu membalas email ini.<br>\n";
            
            return data;
        }

          public static string HantarEmali_SokongStatus(string idcuti)
        {

            string status = "no";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                con = new SqlConnection(SQLAuth.dbase_dbstaf);
                con.Open();
                string CommandText = "SELECT MS26_KodMohonCuti, MS01_NoStaf, CT_KodKategoriCuti, CT_KodCuti, MS26_Tahun, FORMAT(MS26_TkhMula, 'dd/MM/yyyy') AS mula , FORMAT(MS26_TkhTamat, 'dd/MM/yyyy') AS tamat , MS26_BilHari, MS01_AlamatT1, MS01_AlamatT2, MS01_PoskodTetap, MS01_BandarTetap, ";
                CommandText = CommandText + " MS01_NegeriTetap, MS01_NegaraTetap, MS01_NoTelR1, MS26_TkhMohon, MS26_Penyokong, MS26_Pelulus, MS26_TkhSokong, MS26_TkhLulus, MS26_IDBatal, MS26_TkhBatal, MS26_StatusCuti, MS26_SebabTakLulus,  ";
                CommandText = CommandText + "  MS26_SebabCuti, MS26_SebabBatal, MS26_NoPT, MS26_TkhPT, CT_BilHariMohon, MS26_IDKemaskini, MS26_TkhKemaskini, MS26_KlinikPanel, MS26_KlinikLain, MS26_NoResitKlinik, MS26_TkhResit, Tkh_Wujud,  ";
                CommandText = CommandText + "  MS26_StaEL, MS26_KateKlinik, MS08_Pejabat, MS_Sumber, MS_SecCode  ";
                CommandText = CommandText + " FROM MS26_CutiStaf where MS26_KodMohonCuti=@idcuti";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@idcuti", idcuti);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    IEnumerable<string> valuesxx = Cuti_getemail(rdr["MS01_NoStaf"].ToString().Trim());
                    var myListxx = valuesxx.ToList();
                    if (rdr["MS26_StatusCuti"].ToString().Trim() == "Sokong")
                    {
                        string hh2 = myEmailBodyPemohon_disokong(rdr["MS01_NoStaf"].ToString().Trim(), rdr["mula"].ToString().Trim(), rdr["tamat"].ToString().Trim(), rdr["MS26_BilHari"].ToString().Trim(), rdr["MS26_SebabCuti"].ToString().Trim(), rdr["MS01_NoTelR1"].ToString().Trim(), myListxx[2], idcuti);
                        string cc2 = SQLPerakamgeo.SendEmailSMSM(myListxx[1], "STATUS PERMOHONAN CUTI REHAT TELAH DISOKONG", hh2);
                        string myidpelulus = GetIDPelulus(rdr["MS01_NoStaf"].ToString().Trim());
                        IEnumerable<string> valuesxx1 = Cuti_getemail(myidpelulus);
                        var myListxx1 = valuesxx1.ToList();
                        string hh21 = myEmailBodyPemohon_notifypelulus(rdr["MS01_NoStaf"].ToString().Trim(), rdr["mula"].ToString().Trim(), rdr["tamat"].ToString().Trim(), rdr["MS26_BilHari"].ToString().Trim(), rdr["MS26_SebabCuti"].ToString().Trim(), rdr["MS01_NoTelR1"].ToString().Trim(), myListxx[2], idcuti);
                        string cc21 = SQLPerakamgeo.SendEmailSMSM(myListxx1[1], "KELULUSAN PERMOHONAN CUTI REHAT", hh21);

                    }
                    if (rdr["MS26_StatusCuti"].ToString().Trim() == "Tidak Sokong")
                    {
                        string hh23 = myEmailBodyPemohon_tidakdisokong(rdr["MS01_NoStaf"].ToString().Trim(), rdr["mula"].ToString().Trim(), rdr["tamat"].ToString().Trim(), rdr["MS26_BilHari"].ToString().Trim(), rdr["MS26_SebabCuti"].ToString().Trim(), rdr["MS01_NoTelR1"].ToString().Trim(), myListxx[2], rdr["MS26_SebabTakLulus"].ToString().Trim(), idcuti);
                        string cc23 = SQLPerakamgeo.SendEmailSMSM(myListxx[1], "STATUS PERMOHONAN CUTI REHAT TIDAK DISOKONG", hh23);
                        IEnumerable<string> valuesry = SQLKuliahStudent.ConfirmBatalCuti("malay", rdr["MS01_NoStaf"].ToString().Trim(), idcuti);

                    }
                    status = "ok";
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
            return status;
        }
        private static string myEmailBodyPemohon_notifypelulus(string userid, string MystartDate, string MyendDate, string MynumberOfDays, string Mysebab, string Mytelefon, string name, string mykod)
        {

            string data;
            string myidpelulus = GetIDPelulus(userid);
            string myidsokong = GetIDSokong(userid);

            IEnumerable<string> valuesxx1 = Cuti_getemail(myidpelulus);
            var myListxx1 = valuesxx1.ToList();
            IEnumerable<string> valuesxx2 = Cuti_getemail(myidsokong);
            var myListxx2 = valuesxx2.ToList();
            IEnumerable<string> valuesxx2z = Cuti_getdetailcuti(mykod);
            var myListxx2z = valuesxx2z.ToList();
            data = "<strong>PERMOHONAN CUTI UNTUK KELULUSAN</strong><br> \n";
            data = data + "<br>\n";
            data = data + "Assalamualaikum wrt. wbt dan Salam Sejahtera, <br>\n";
            data = data + "YBhg. Datuk/Prof./Prof. Madya/Dr./Tuan/Puan, <br>\n";
            data = data + "<br>\n";
            data = data + "Permohonan Cuti Staf : <strong>" + userid + "-" + name + "</strong>  <br>\n";
            data = data + "<br>\n";
            data = data + "Pegawai Penyokong : <strong>" + myidsokong + "-" + myListxx2[2] + "</strong>  <br>\n";
            data = data + "Pegawai Pelulus 1 : <strong>" + myidpelulus + "-" + myListxx1[2] + " </strong> <br>\n";
            data = data + "<br>\n";
            data = data + "Alamat Semasa Bercuti : <strong>" + myListxx2z[2] + " </strong>  <br>\n";
            data = data + "Tarikh Bercuti : <strong>" + MystartDate + " hingga " + MyendDate + " </strong> <br>\n";
            data = data + "Bil. Hari Bercuti : <strong>" + MynumberOfDays + " hari  </strong><br>\n";
            data = data + "Sebab Bercuti :  <strong>" + Mysebab + " </strong> <br>\n";
            data = data + "<br>\n";
            data = data + "<strong>KELULUSAN BOLEH DILAKUKAN DI <a href='https://portal.utem.edu.my/iutem'>PORTAL SMSM</a> </strong><br>\n";
            data = data + "<br>\n";
            data = data + "Terima kasih <br>\n";
            data = data + "Makluman ini adalah secara automatik daripada Sistem Maklumat Sumber Manusia.<br>\n";
            data = data + "<br>\n";
            data = data + "Anda Tidak Perlu membalas email ini.<br>\n";

            return data;
        }
        private static string myEmailBodyPemohon_disokong(string userid, string MystartDate, string MyendDate, string MynumberOfDays, string Mysebab, string Mytelefon, string name, string mykod)
        {

            string data;
            string myidpelulus = GetIDPelulus(userid);
            string myidsokong = GetIDSokong(userid);

            IEnumerable<string> valuesxx1 = Cuti_getemail(myidpelulus);
            var myListxx1 = valuesxx1.ToList();
            IEnumerable<string> valuesxx2 = Cuti_getemail(myidsokong);
            var myListxx2 = valuesxx2.ToList();
            IEnumerable<string> valuesxx2z = Cuti_getdetailcuti(mykod);
            var myListxx2z = valuesxx2z.ToList();
            data = "<strong>PERMOHONAN CUTI REHAT TELAH DISOKONG </strong><br> \n";
            data = data + "<br>\n";
            data = data + "Assalamualaikum wrt. wbt dan Salam Sejahtera, <br>\n";
            data = data + "YBhg. Datuk/Prof./Prof. Madya/Dr./Tuan/Puan, <br>\n";
            data = data + "<br>\n";
            data = data + "Permohonan Cuti Staf : <strong>" + userid + "-" + name + "</strong>  <br>\n";
            data = data + "<br>\n";
            data = data + "Pegawai Penyokong : <strong>" + myidsokong + "-" + myListxx2[2] + "</strong>  <br>\n";
            data = data + "Pegawai Pelulus 1 : <strong>" + myidpelulus + "-" + myListxx1[2] + " </strong> <br>\n";
            data = data + "<br>\n";
            data = data + "Alamat Semasa Bercuti : <strong>" + myListxx2z[2] + " </strong>  <br>\n";
            data = data + "Tarikh Bercuti : <strong>" + MystartDate + " hingga " + MyendDate + " </strong> <br>\n";
            data = data + "Bil. Hari Bercuti : <strong>" + MynumberOfDays + " hari  </strong><br>\n";
            data = data + "Sebab Bercuti :  <strong>" + Mysebab + " </strong> <br>\n";
            data = data + "<br>\n";
            data = data + "Terima kasih <br>\n";
            data = data + "Makluman ini adalah secara automatik daripada Sistem Maklumat Sumber Manusia.<br>\n";
            data = data + "<br>\n";
            data = data + "Anda Tidak Perlu membalas email ini.<br>\n";

            return data;
        }

        private static string myEmailBodyPemohon_tidakdisokong(string userid, string MystartDate, string MyendDate, string MynumberOfDays, string Mysebab, string Mytelefon, string name, string Mysebabtak, string mykod)
        {
            string data;
            string myidpelulus = GetIDPelulus(userid);
            string myidsokong = GetIDSokong(userid);

            IEnumerable<string> valuesxx1 = Cuti_getemail(myidpelulus);
            var myListxx1 = valuesxx1.ToList();
            IEnumerable<string> valuesxx2 = Cuti_getemail(myidsokong);
            var myListxx2 = valuesxx2.ToList();
            IEnumerable<string> valuesxx2z = Cuti_getdetailcuti(mykod);
            var myListxx2z = valuesxx2z.ToList();
            data = "<strong>PERMOHONAN CUTI REHAT TIDAK DISOKONG </strong><br> \n";
            data = data + "<br>\n";
            data = data + "Assalamualaikum wrt. wbt dan Salam Sejahtera, <br>\n";
            data = data + "YBhg. Datuk/Prof./Prof. Madya/Dr./Tuan/Puan, <br>\n";
            data = data + "<br>\n";
            data = data + "Permohonan Cuti Staf : <strong>" + userid + "-" + name + " </strong> <br>\n";
            data = data + "<br>\n";
            data = data + "Pegawai Penyokong : <strong>" + myidsokong + "-" + myListxx2[2] + "</strong>  <br>\n";
            data = data + "Pegawai Pelulus 1 : <strong>" + myidpelulus + "-" + myListxx1[2] + " </strong> <br>\n";
            data = data + "<br>\n";
            data = data + "Alamat Semasa Bercuti : <strong>" + myListxx2z[2] + " </strong>  <br>\n";
            data = data + "Tarikh Bercuti : <strong>" + MystartDate + " hingga " + MyendDate + " </strong> <br>\n";
            data = data + "Bil. Hari Bercuti : <strong>" + MynumberOfDays + " hari  </strong><br>\n";
            data = data + "Sebab Bercuti :  <strong>" + Mysebab + " </strong> <br>\n";
            data = data + "Sebab Tidak Disokong : <strong> " + Mysebabtak + " </strong> <br>\n";
            data = data + "<br>\n";
            data = data + "Terima kasih <br>\n";
            data = data + "Makluman ini adalah secara automatik daripada Sistem Maklumat Sumber Manusia.<br>\n";
            data = data + "<br>\n";
            data = data + "Anda Tidak Perlu membalas email ini.<br>\n";

            return data;
        }

        private static string myEmailBody_sokong(string userid, string MystartDate, string MyendDate, string MynumberOfDays, string Mysebab, string Mytelefon, string name, string mykod)
        {
            string data;
            string myidpelulus = GetIDPelulus(userid);
            string myidsokong = GetIDSokong(userid);
            IEnumerable<string> valuesxx1 = Cuti_getemail(myidpelulus);
            var myListxx1 = valuesxx1.ToList();
            IEnumerable<string> valuesxx2 = Cuti_getemail(myidsokong);
            var myListxx2 = valuesxx2.ToList();
            IEnumerable<string> valuesxx2z = Cuti_getdetailcuti(mykod);
            var myListxx2z = valuesxx2z.ToList();
            data = "YBhg. Datuk/Prof./Prof. Madya/Dr./Tuan/Puan, <br>\n";
            data = data + "<br>\n";
            data = data + "Permohonan Cuti Staf: <strong>" + userid + "-" + name + "</strong>  <br>\n";
            data = data + "<br>\n";
            data = data + "Pegawai Penyokong : <strong>" + myidsokong + "-" + myListxx2[2] + "</strong>  <br>\n";
            data = data + "Pegawai Pelulus 1 : <strong>" + myidpelulus + "-" + myListxx1[2] + " </strong> <br>\n";
            data = data + "<br>\n";
            data = data + "Alamat Semasa Bercuti : <strong>" + myListxx2z[2] + " </strong>  <br>\n";
            data = data + "Tarikh Bercuti : <strong>" + MystartDate + " hingga " + MyendDate + " </strong> <br>\n";
            data = data + "Bil. Hari Bercuti : <strong>" + MynumberOfDays + " hari  </strong><br>\n";
            data = data + "Sebab Bercuti :  <strong>" + Mysebab + " </strong> <br>\n";
            data = data + "<br>\n";
            data = data + "<strong>BAKI CUTI SELEPAS PERMOHONAN : " + BakiCutiSelepasPermohonan(userid) + " hari </strong><br>\n";
            data = data + "<br>\n";
            data = data + "SILA BUAT SOKONGAN TERUS DISINI  <br>\n";
            data = data + " <a href='https://mobileapp.utem.edu.my/SMSM/Create?id=" + userid + "& jenis=Sokong&authorId=" + mykod + "'><strong>SOKONG</strong></a> <br>\n";
            data = data + "UNTUK MENYOKONG PERMOHONAN INI <br>\n";
            data = data + "ATAU <br>\n";
            data = data + "KLIK <a href='https://mobileapp.utem.edu.my/SMSM/Create?id=" + userid  + "& jenis=TidakSokong&authorId=" + mykod + "'><strong>TIDAK SOKONG</strong></a> <br>\n";
            data = data + "UNTUK TIDAK MENYOKONG PERMOHONAN INI <br>\n";
            data = data + "<br>\n";
            data = data + "<strong>SOKONGAN ATAU KELULUSAN MASIH JUGA BOLEH DILAKUKAN DI <a href='https://portal.utem.edu.my/iutem'>PORTAL SMSM</a> SEPERTI BIASA </strong> <br>\n";
            data = data + "<br>\n";
            data = data + "Makluman ini adalah secara automatik daripada Sistem Maklumat Sumber Manusia.<br>\n";
            data = data + "<br>\n";
            data = data + "Anda Tidak Perlu membalas email ini.<br>\n";
            data = data + "<br>\n";
            data = data + "Terima kasih <br>\n";
            return data;
        }

        public static string UpdateCutiSetting(string userid, string MynumberOfDays)
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
                        cmd.Parameters.AddWithValue("@jumB", DataBakiCuti_sett(userid, MynumberOfDays));
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

        public static string UpdateCutiDariPenyokong(string userid, string secCode, string kodcuti, string statuscuti, string Penyokong, string nota)
        {
            DateTime mydate = DateTime.Now;
            string myStr = "no";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbstaf))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        Random rnd = new Random();
                        int myrnd = rnd.Next(100000, 10000000);
                        cmd.CommandText = @"update MS26_CutiStaf set MS26_TkhSokong=@mydate, MS26_SebabTakLulus=@nota, MS_SecCode=@secCodenew, MS26_Penyokong=@Penyokong, MS26_StatusCuti=@statuscuti where  MS26_KodMohonCuti=@kodcuti and MS_Sumber=@sumber and  MS_SecCode=@secCode";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@user_id", userid);
                        cmd.Parameters.AddWithValue("@secCode", secCode);
                        cmd.Parameters.AddWithValue("@kodcuti", kodcuti);
                        cmd.Parameters.AddWithValue("@sumber", "myUTeM");
                        cmd.Parameters.AddWithValue("@statuscuti", statuscuti);
                        cmd.Parameters.AddWithValue("@Penyokong", Penyokong);
                        cmd.Parameters.AddWithValue("@secCodenew", myrnd.ToString());
                        cmd.Parameters.AddWithValue("@nota", nota);
                        cmd.Parameters.AddWithValue("@mydate", mydate);
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



        public static string DataBakiCuti_sett(string userid, string MynumberOfDays)
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
                int mynewb = Int32.Parse(mjum) - Int32.Parse(MynumberOfDays);
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

        public static IEnumerable<string> Cuti_getemail(string userid)
        {
            string[] ret = new string[5];
            ret[0] = "0";
            ret[1] = "";
            ret[2] = "";
            ret[3] = "";
            String ConnectionString = "";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                ConnectionString = SQLAuth.dbase_dbeqcas;
                CommandText = "SELECT  emailaddress,firstname,att1   FROM            live_user_staf where  att15 = @user_id ";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@user_id", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "1";
                    ret[1] = rdr["emailaddress"].ToString().Trim();
                    ret[2] = rdr["firstname"].ToString().Trim();
                    ret[3] = rdr["att1"].ToString().Trim();
                    break;
                }

       
            }
            catch (Exception)
            {
               // return "0";
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
        public static IEnumerable<string> Cuti_getdetailcuti(string cutiid)
        {
            string[] ret = new string[5];
            ret[0] = "0";
            ret[1] = "";
            ret[2] = "";
            ret[3] = "";
            String ConnectionString = "";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                ConnectionString = SQLAuth.dbase_dbstaf;
                CommandText = "SELECT  MS26_KodMohonCuti, MS01_NoStaf, CT_KodKategoriCuti, CT_KodCuti, MS26_Tahun, MS26_TkhMula, MS26_TkhTamat, MS26_BilHari, MS01_AlamatT1, MS01_AlamatT2, MS01_PoskodTetap, MS01_BandarTetap,  ";
                CommandText = CommandText + " MS01_NegeriTetap, MS01_NegaraTetap, MS01_NoTelR1, MS26_TkhMohon, MS26_Penyokong, MS26_Pelulus, MS26_TkhSokong, MS26_TkhLulus, MS26_IDBatal, MS26_TkhBatal, MS26_StatusCuti, MS26_SebabTakLulus,  ";
                CommandText = CommandText + "  MS26_SebabCuti, MS26_SebabBatal, MS26_NoPT, MS26_TkhPT, CT_BilHariMohon, MS26_IDKemaskini, MS26_TkhKemaskini, MS26_KlinikPanel, MS26_KlinikLain, MS26_NoResitKlinik, MS26_TkhResit, Tkh_Wujud,  ";
                CommandText = CommandText + "  MS26_StaEL, MS26_KateKlinik, MS08_Pejabat, MS_Sumber, MS_SecCode ";
                CommandText = CommandText + "  FROM             MS26_CutiStaf where  MS26_KodMohonCuti = @cutiid ";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@cutiid", cutiid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ret[0] = "1";
                    ret[1] = rdr["MS01_NoStaf"].ToString().Trim();
                    ret[2] = rdr["MS01_AlamatT1"].ToString().Trim() + " " + rdr["MS01_PoskodTetap"].ToString().Trim() + " " + rdr["MS01_BandarTetap"].ToString().Trim() + " " + rdr["MS01_NegeriTetap"].ToString().Trim();
                    ret[3] = rdr["att1"].ToString().Trim();
                    break;
                }


            }
            catch (Exception)
            {
                // return "0";
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
        //public static string Cuti_kodpejabat(string userid)
        //{

        //    String ConnectionString = "";
        //    string CommandText = "";
        //    string mjum = "0";
        //    SqlDataReader rdr = null;
        //    SqlConnection con = null;
        //    SqlCommand cmd = null;

        //    try
        //    {
        //        ConnectionString = SQLAuth.dbase_dbeqcas;
        //        CommandText = "SELECT  att1   FROM            live_user_staf where  att15 = @user_id ";
        //        con = new SqlConnection(ConnectionString);
        //        con.Open();
        //        cmd = new SqlCommand(CommandText);
        //        cmd.Connection = con;
        //        cmd.CommandText = CommandText;
        //        cmd.Parameters.AddWithValue("@user_id", userid);
        //        rdr = cmd.ExecuteReader();
        //        while (rdr.Read())
        //        {
        //            mjum = rdr["att1"].ToString();
        //            break;
        //        }

        //        return mjum;
        //    }
        //    catch (Exception)
        //    {
        //        return "0";
        //    }
        //    finally
        //    {
        //        if (rdr != null)
        //            rdr.Close();

        //        if (con.State == ConnectionState.Open)
        //            con.Close();
        //    }
        //}

        public static string ResetPasswordPortal(string userid, string mymodul, string mypass, string mytype, string myemail, string mylang)
        {
            DateTime mydate = DateTime.Now;
            string myStr = "no";
            if (userid.Length >= 2)
            {
                string passwordss = "";
                string passwordss24 = mypass.Substring(3, mypass.Length - 8) + "==";
                string passwordss44 = mypass.Substring(3, mypass.Length - 8) + "=";
                string passwordss64 = mypass.Substring(3, mypass.Length - 8);
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
                  string password = AESEncrytDecry.DecryptStringAES_notuser(passwordss, userid);
        

                try
                {
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbclm))
                    {
                        using (SqlCommand cmd = new SqlCommand())
                        {

                            cmd.CommandText = @"update dbo.CLM_Pengguna set  CLM_loginPWD=@mypassword where CLM_loginID=@user_id";
                            cmd.Connection = sqlConn;
                            cmd.Parameters.AddWithValue("@user_id", userid);
                            cmd.Parameters.Add("@mypassword", SqlDbType.NVarChar, 20);
                            cmd.Parameters["@mypassword"].Value = SQLAuth.getPwD(password); 

                            try
                            {
                                sqlConn.Open();
                                cmd.ExecuteNonQuery();
                                myStr = "ok";
                                string pp = InsertClmLogResetPassword(userid);

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


                if (myStr == "ok")
                {
                    try
                    {
                        using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                        {
                            using (SqlCommand cmd = new SqlCommand())
                            {
                                cmd.CommandText = @"INSERT INTO  AspNetResetEmail   ( user_id, email, mypassword,  mymodul, mytype, status, note) VALUES (@user_id, @email, @mypassword, @mymodul, @mytype, @status, @note)";
                                cmd.Connection = sqlConn;
                                cmd.Parameters.AddWithValue("@user_id", userid);
                                if (mymodul == "Domain")
                                {
                                    if (mytype == "Staf")
                                    {
                                        cmd.Parameters.AddWithValue("@email", "Staff.utem.edu");
                                    }
                                    else
                                    {
                                        cmd.Parameters.AddWithValue("@email", "Student.utem.edu");
                                    }
                                }
                                else
                                {
                                    cmd.Parameters.AddWithValue("@email", myemail);
                                }
                                cmd.Parameters.AddWithValue("@mypassword", "xxxxx");
                                cmd.Parameters.AddWithValue("@mymodul", mymodul);
                                cmd.Parameters.AddWithValue("@mytype", mytype);
                                cmd.Parameters.AddWithValue("@status", "Y");
                                cmd.Parameters.AddWithValue("@note", "ok");
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
                }
            }
            return myStr;
        }

        public static string updatealammakanan()
        {
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string[] ret = new string[6];
            ret[0] = "no";
            string myStr = "no";
            try
            {
                DateTime mydate = DateTime.Now;
                string mytime = DateTime.Now.ToShortTimeString();
                string mydateshort = DateTime.Now.ToString("dd/MM/yyyy");

                String ConnectionString = SQLAuth.dbase_dbmobile;
                CommandText = "INSERT INTO   MK01_Daftar ( MK_NoMatrik, MK_Status, MK_TkhMasa, MK_IdKafe, MK_alarm ) values (@USERID, '1', @MYDATE, @mycode, @myalarm)";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.Parameters.AddWithValue("@USERID", "Menteri");
                cmd.Parameters.AddWithValue("@MYDATE", mydate);
                cmd.Parameters.AddWithValue("@mycode", "006kaat");
                cmd.Parameters.AddWithValue("@Tarikh", mydate.ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@Time2", mydate.ToString("HH:mm:ss"));
                cmd.Parameters.AddWithValue("@myalarm", "baru");
                rdr = cmd.ExecuteReader();
                myStr = "ok";

            }
            catch (Exception ex)
            {
                // myStr = "no33";
            }


            return myStr;
        }
        public static string updatealammakananbak()
        {
            DateTime mydate = DateTime.Now;
            string myStr = "no";

            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        // Tran_id, Ref_id, userid, mydate_req, status_tran, status_migs, mydate_migs, amt_pay, vpc_MerchTxnRef, note, jenis_modul, vpc_TxnResponseCode, nama, email, param1, param2, 
                        //  param3

                        cmd.CommandText = @"delete from  MK01_Daftar";
                        cmd.Connection = sqlConn;

                        cmd.Parameters.AddWithValue("@alarm", "baru");

                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            myStr = "ok";
                        }
                        catch (SqlException e)
                        {
                            // myStr = ""e.Message.ToString() + "no22";

                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // myStr = "no33";
            }
            return myStr;
        }
        public static string StatusEmergency(string myid, string mlanguage)
        {

            String ConnectionString = "";
            string CommandText = "";
            string mjum = "Belum Diambil Tindakan";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
             //   string CommandText = " SELECT b.cms04_status_bm, b.cms04_status_bi, a.cms01_id, a.cms01_userid, a.cms01_aduan, a.cms01_Tarikhterima, a.cms01_Tarikhkemaskini, a.cms01_lokasi, a.cms01_telefon, a.cms01_kodpejabat_terima, a.cms01_gambar, a.cms01_status ";
             //   CommandText = CommandText + " FROM     cms01_Kecemasan as a,  cms04_status_kecemasan as b  where a.cms01_status=b.cms01_status and a.cms01_userid=@userid  order by a.cms01_id desc ";

                ConnectionString = SQLAuth.dbase_dbmobile;
                CommandText = "SELECT b.cms04_status_bm, b.cms04_status_bi  FROM     cms01_Kecemasan as a,  cms04_status_kecemasan as b  where a.cms01_status=b.cms04_id and a.cms01_id=@myid  order by a.cms01_id desc  ";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@myid", myid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if (mlanguage == "0")
                    {
                        mjum = rdr["cms04_status_bm"].ToString();
                    }
                    else
                    {
                        mjum = rdr["cms04_status_bi"].ToString();
                    }
                    break;
                }
                return mjum;
            }
            catch (Exception)
            {
                return "Belum Diambil Tindakan";
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        public static string JumRecFPX()
        {

            String ConnectionString = "";
            string CommandText = "";
            string mjum = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                ConnectionString = SQLAuth.dbase_dbmobile;
                CommandText = "SELECT count(*) as mcount from   fpx01_sumbangan";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mjum = rdr["mcount"].ToString();
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
        public static string JumRec()
        {

            String ConnectionString = "";
            string CommandText = "";
            string mjum = "0";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                ConnectionString = SQLAuth.dbase_dbmobile;
                CommandText = "SELECT count(*) as mcount from migs_payment";
                con = new SqlConnection(ConnectionString);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mjum = rdr["mcount"].ToString();
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
        //SELECT        TOP (200) cms01_id, cms01_userid, cms01_aduan, cms01_Tarikhterima, cms01_Tarikhkemaskini, cms01_lokasi, cms01_telefon, cms01_kodpejabat_terima, cms01_gambar, cms01_status
        // FROM cms01_Kecemasan
        public static IEnumerable<string> GetDetailEmergencyButton(string userid, string cms01_id, string mlanguage)
        {
            string[] ret = new string[2];
            ret[0] = "no";
            string mystatus = "";
            //   List<string> myList = new List<string>();
            List<string> myList2 = new List<string>();
            int cnt = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

            //    string CommandText = " SELECT    Top(1)    cms02_id, cms01_id, cms02_tarikh, cms02_staffno_pegawai, cms02_ulasan, cms02_kodpejabat_ulasan, cms02_jenis_gambar ";
             //   CommandText = CommandText + " FROM     cms02_Log_kecemasan  where cms01_id = @cms01_idx order by cms02_id desc";
                string CommandText = " SELECT    Top(1)    cms02_id, cms01_id, cms02_tarikh, cms02_staffno_pegawai, cms02_ulasan, cms02_kodpejabat_ulasan, cms02_jenis_gambar ";
                CommandText = CommandText + " FROM     cms02_Log_kecemasan  where cms01_id = @cms01_idx order by cms02_id desc";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@cms01_idx", cms01_id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mystatus = StatusEmergency(cms01_id, mlanguage);
                    if (mlanguage == "0")
                    {
                        myList2.Add("Tarikh Kemaskini : " + rdr["cms02_tarikh"].ToString());
                        myList2.Add("Pegawai Bertugas : " + rdr["cms02_staffno_pegawai"].ToString() + " - " + GetNama(rdr["cms02_staffno_pegawai"].ToString()));
                        myList2.Add("Ulasan : " +  rdr["cms02_ulasan"].ToString());
                        myList2.Add("Status : " + mystatus );
                        //  myList2.Add("Lampiran : File." + rdr["cms02_jenis_gambar"].ToString());
                    }
                    else
                    {
                        myList2.Add("Date of Update : " + rdr["cms02_tarikh"].ToString());
                        myList2.Add("Officer on Duty : " + rdr["cms02_staffno_pegawai"].ToString() + " - " + GetNama(rdr["cms02_staffno_pegawai"].ToString()));
                        myList2.Add("Reviews : " +  rdr["cms02_ulasan"].ToString());
                        myList2.Add("Status : " + mystatus);
                        //  myList2.Add("Attachment : File." + rdr["cms02_jenis_gambar"].ToString());


                    }
                    if ((rdr["cms02_jenis_gambar"].ToString() == "mp4") ||
                        (rdr["cms02_jenis_gambar"].ToString() == "jpg"))
                    {
                       
                        if (mlanguage == "0")
                        {
                            myList2.Add("Lampiran : File." + rdr["cms02_jenis_gambar"].ToString());
                        }
                        else
                        {
                            myList2.Add("Attachment : File." + rdr["cms02_jenis_gambar"].ToString());
                        }
                        myList2.Add(rdr["cms02_id"].ToString());
                    }
                    else
                    {
                       
                        if (mlanguage == "0")
                        {
                            myList2.Add("Lampiran : -");
                        }
                        else
                        {
                            myList2.Add("Attachment : -");
                        }
                        myList2.Add("tiada");
                    }
                 //   myList.Add(rdr["cms02_tarikh"].ToString() + " : " + rdr["cms02_ulasan"].ToString());
                    cnt++;



                }

               // if (cnt == 1)
               // {
               //     return myList2;
               // }
              //  else
              //  {
                    if (cnt == 0)
                    {
                        mystatus = StatusEmergency(cms01_id, mlanguage);
                        if (mlanguage == "0")
                        {
                        myList2.Add("");
                        myList2.Add("Ulasan : - ");
                        myList2.Add("");
                        myList2.Add("Status : " + mystatus);
                        myList2.Add("");
                        myList2.Add("tiada");
                    }
                        else
                        {
                        myList2.Add("");
                        myList2.Add("Reviews : - ");
                        myList2.Add("");
                        myList2.Add("Status : " + mystatus);
                        myList2.Add("");
                        myList2.Add("tiada");

                    }
                        return myList2;
                    }
                    else
                    {
                        return myList2;
                    }
               // }


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

        public static IEnumerable<string> GetDetailEmergencyButton_cam(string userid, string cms01_id, string mlanguage)
        {
            string[] ret = new string[2];
            ret[0] = "no";
            string mystatus = "";
            //   List<string> myList = new List<string>();
            List<string> myList2 = new List<string>();
            int cnt = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null; 

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_developer;
                con = new SqlConnection(ConnectionString);
                con.Open();

                //    string CommandText = " SELECT    Top(1)    cms02_id, cms01_id, cms02_tarikh, cms02_staffno_pegawai, cms02_ulasan, cms02_kodpejabat_ulasan, cms02_jenis_gambar ";
                //   CommandText = CommandText + " FROM     cms02_Log_kecemasan  where cms01_id = @cms01_idx order by cms02_id desc";
                string CommandText = " SELECT        TOP (1) ivts02_id, ivts02_platid, ivts02_lokasi, ivts02_jenis, ivts02_Tarikh, ivts02_gambar, ivts02_jenis_gambar, ivts02_nostaf FROM ivts02_Aktiviti_Kenderaan";
                CommandText = CommandText + " where ivts02_id=@cms01_idx";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@cms01_idx", cms01_id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mystatus = "Selesai";
                    if (mlanguage == "0")
                    {
                        myList2.Add("Tarikh  : " + rdr["ivts02_Tarikh"].ToString());
                        myList2.Add("Lokasi : " + rdr["ivts02_lokasi"].ToString()) ;
                        myList2.Add("Kategori : " + rdr["ivts02_jenis"].ToString());
                        myList2.Add("No Kenderaan : " + rdr["ivts02_platid"].ToString());
                        //  myList2.Add("Lampiran : File." + rdr["cms02_jenis_gambar"].ToString());
                    }
                    else
                    {
                        myList2.Add("Date : " + rdr["ivts02_Tarikh"].ToString());
                        myList2.Add("Location : " + rdr["ivts02_lokasi"].ToString());
                        myList2.Add("Category : " + rdr["ivts02_jenis"].ToString());
                        myList2.Add("Vehicle No : " + rdr["ivts02_platid"].ToString());
                        //  myList2.Add("Attachment : File." + rdr["cms02_jenis_gambar"].ToString());


                    }
                    if ((rdr["ivts02_jenis_gambar"].ToString() == "mp4") ||
                        (rdr["ivts02_jenis_gambar"].ToString() == "jpg"))
                    {

                        if (mlanguage == "0")
                        {
                            myList2.Add("Lampiran : File." + rdr["ivts02_jenis_gambar"].ToString());
                        }
                        else
                        {
                            myList2.Add("Attachment : File." + rdr["ivts02_jenis_gambar"].ToString());
                        }
                        myList2.Add(rdr["ivts02_id"].ToString());
                    }
                    else
                    {

                        if (mlanguage == "0")
                        {
                            myList2.Add("Lampiran : -");
                        }
                        else
                        {
                            myList2.Add("Attachment : -");
                        }
                        myList2.Add("tiada");
                    }
                    //   myList.Add(rdr["cms02_tarikh"].ToString() + " : " + rdr["cms02_ulasan"].ToString());
                    cnt++;



                }

                // if (cnt == 1)
                // {
                //     return myList2;
                // }
                //  else
                //  {
               
                    return myList2;
               
                // }


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



        //

        public static bool GetTimeDiffBig(string userid)
        {
            bool mybol = true;
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
                CommandText = "SELECT    TOP (1)  DATEDIFF(MINUTE, cms01_Tarikhterima, GETDATE()) AS Expr1 FROM cms01_Kecemasan where cms01_userid=@userid order by cms01_id desc ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if (Int16.Parse(rdr["Expr1"].ToString().Trim()) < 5)
                    {
                        mybol = false;
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

           

            return mybol;



        }




        //
        public static IEnumerable<string> InstantEmergencyButton(string userid, string lokasi, string lat1, string long1, string telefon)
        {
            string[] ret = new string[1];
            ret[0] = "no";
            string mstat = "0";
            try
            {
                if ((telefon == "-") || (telefon == "")) { telefon = GetTelefon(userid); }
              //  if ((telefon == "") && (lat1=="0")) { mstat = "5"; }
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        if (GetTimeDiffBig(userid) == true)
                        {
                            if (userid == "00578") { ret[0] = "ok"; }
                            else
                            {
                                cmd.CommandText = @"INSERT INTO  cms01_Kecemasan ( cms01_userid, cms01_nama, cms01_aduan, cms01_lokasi, cms01_kodpejabat_terima,  cms01_status, cms01_telefon,   cms01_kategori, cms01_lat, cms01_long) values ( @USERID, @nama, @aduan,@lokasi,@kodpejabat, @status, @telefon,@kategori,@mylat,@mylong)";
                                cmd.Connection = sqlConn;
                                cmd.Parameters.AddWithValue("@USERID", userid);
                                cmd.Parameters.AddWithValue("@nama", SQLMigs.GetNama(userid));
                                cmd.Parameters.AddWithValue("@aduan", "panic");
                                cmd.Parameters.AddWithValue("@lokasi", lokasi);
                                cmd.Parameters.AddWithValue("@telefon", telefon);

                                cmd.Parameters.AddWithValue("@kategori", "panic");
                                cmd.Parameters.AddWithValue("@mylat", lat1);
                                cmd.Parameters.AddWithValue("@mylong", long1);
                                cmd.Parameters.AddWithValue("@kodpejabat", "22");
                                cmd.Parameters.AddWithValue("@status", mstat);


                                try
                                {
                                    sqlConn.Open();
                                    cmd.ExecuteNonQuery();
                                    ret[0] = "ok";
                                }
                                catch (SqlException e)
                                {
                                    ret[0] = "A " + e.Message.ToString();
                                }
                            }
                        }
                        else
                        {
                            ret[0] = "ok";
                        }
                        }
                    
                }
            }
            catch (Exception ex)
            {
                ret[0] = "B " + ex.Message.ToString();
            }

            return ret;
        }
        public static string GetTelefon(string noid)
        {
            string mytel="";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "select MS01_NoTelBimbit FROM            MS01_Peribadi  where MS01_NoStaf=@noid ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noid", noid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mytel =  rdr["MS01_NoTelBimbit"].ToString().Trim();

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
           if (mytel == "") { mytel = GetTelefonStud(noid); }
            if (mytel == "") { mytel = GetTelefonStudsmg(noid); }
            //GetTelefonStudsmg
            return mytel;
        


        }
        public static string GetTelefonStud(string noid)
        {
            string mytel = "";
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
                CommandText = "SELECT       SMP01_NoTelBimBit  FROM            SMP01_Peribadi  where SMP01_Nomatrik=@noid ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noid", noid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mytel = rdr["SMP01_NoTelBimBit"].ToString().Trim();

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

            return mytel;



        }

        public static string BakiCutiSelepasPermohonan(string userid)
        {
            string baki = "0";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                //CT01_SettingCuti set CT01_JumHariB = @jumB where  MS01_NoStaf = @user_id AND CT01_Tahun = @myYear"
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "SELECT       CT01_JumHariB  FROM  CT01_SettingCuti  where MS01_NoStaf = @userid AND CT01_Tahun = @myYear ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@myYear", DateTime.Now.ToString("yyyy"));
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    baki = rdr["CT01_JumHariB"].ToString().Trim();
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

            return baki;



        }


        public static string GetTelefonStudsmg(string noid)
        {
            string mytel = "";
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
                CommandText = "SELECT       SMG02_NOTELBIMBIT FROM              SMG02_Peribadi  where  SMG01_NOMATRIK=@noid ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noid", noid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mytel = rdr["SMG02_NOTELBIMBIT"].ToString().Trim();

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

            return mytel;



        }
        public static IEnumerable<string> GetJenisEmergency(string mlanguage)
        {
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList2 = new List<string>();
            int cnt = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = " SELECT    cms03_id, note_bm, note_bi ";
                CommandText = CommandText + " FROM cms03_Jenis_Kecemasan ORDER BY cms03_id ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
               // cmd.Parameters.AddWithValue("@userid", userid);
              //  cmd.Parameters.AddWithValue("@cms01_idx", cms01_id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if (mlanguage == "0")
                    {
                        myList2.Add(rdr["note_bm"].ToString());

                    }
                    else
                    {
                        myList2.Add(rdr["note_bi"].ToString());
             
                    }
                    cnt++;



                }
                return myList2; 

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
        //GetEmergencyPermission
        public static IEnumerable<string> GetEmergencyPermission(string userid)
        {
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList2 = new List<string>();
            int cnt = 0;
            string jumpa = "no";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbeqcas;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = " SELECT       emailid, emailaddress  ";
                CommandText = CommandText + " FROM  live_user_staf  where att15=@userid and att10='139' ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                 cmd.Parameters.AddWithValue("@userid", userid);
                //  cmd.Parameters.AddWithValue("@cms01_idx", cms01_id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                { 
                    jumpa = "ya";
                }

                if (jumpa == "ya")
                {
                    myList2.Add("ok");
                }
                else
                {
                    if (userid == "00954") {
                        myList2.Add("ok");
                    }
                    else
                    {
                        myList2.Add("no");
                    }
                }
                
                return myList2;

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
                // return twoDimensionalx;   00954
            }
        }

        public static IEnumerable<string> GetMarkahKursusStatus(string userid)
        {
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList2 = new List<string>();
            int cnt = 0;
            string jumpa = "no";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = " SELECT        DATEDIFF(day, GETDATE(), PDTrkTamat) AS ValueTD, CASE WHEN DATEDIFF(day, getdate(), PDTrkTamat) >= 0 THEN '1' ELSE '0' END AS StatTD   ";
                CommandText = CommandText + " FROM SMP_UProsesDT  "; 
                CommandText = CommandText + " WHERE(ULevel = 'PELAJAR') AND(CId = '03') AND(PKod IN('08'))  ";


                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                //  cmd.Parameters.AddWithValue("@cms01_idx", cms01_id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    jumpa = rdr["StatTD"].ToString();
                    break;
                }

                if (jumpa == "1")
                {
                    myList2.Add("ok");
                }
                else
                {
                    myList2.Add("no");
                }
                return myList2;

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


        public static IEnumerable<string> GetStatusEmergency(string mlanguage)
        {
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList2 = new List<string>();
            int cnt = 0;
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = " SELECT        cms04_id, cms04_status_bm, cms04_status_bi   ";
                CommandText = CommandText + " FROM cms04_status_kecemasan where cms04_id > 0";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                // cmd.Parameters.AddWithValue("@userid", userid);
                //  cmd.Parameters.AddWithValue("@cms01_idx", cms01_id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    if (mlanguage == "0")
                    {
                        myList2.Add(rdr["cms04_status_bm"].ToString());

                    }
                    else
                    {
                        myList2.Add(rdr["cms04_status_bi"].ToString());

                    }
                    cnt++;



                }
                return myList2;

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
        public static string GetIDSokong(string userid)
        {
            string mybol = "";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "SELECT   MS01_NoStaf, CT_Penyokong, CT_Pelulus, CT_Pelulus2, CT_TkhKemaskini FROM CT_DaftarPYPL where MS01_NoStaf=@userid";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    mybol = rdr["CT_Penyokong"].ToString().Trim();
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
        public static string GetIDPelulus(string userid)
        {
            string mybol = "";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "SELECT   MS01_NoStaf, CT_Penyokong, CT_Pelulus, CT_Pelulus2, CT_TkhKemaskini FROM CT_DaftarPYPL where MS01_NoStaf=@userid";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    mybol = rdr["CT_Pelulus"].ToString().Trim();
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
        public static string GetCutiID(string secureid)
        {
            string mybol = "0";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "SELECT MS26_KodMohonCuti  FROM  MS26_CutiStaf where MS_SecCode=@secureid";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@secureid", secureid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    mybol = rdr["MS26_KodMohonCuti"].ToString().Trim();
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
        public static string GetEmailSokong(string userid)
        {
            string mybol = "";
            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            try
            {
                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();
                CommandText = "SELECT   MS01_NoStaf, CT_Penyokong, CT_Pelulus, CT_Pelulus2, CT_TkhKemaskini FROM CT_DaftarPYPL where MS01_NoStaf=@userid";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    IEnumerable<string> valuesxx = Cuti_getemail(rdr["CT_Penyokong"].ToString().Trim());
                    var myListxx = valuesxx.ToList();
                    mybol = myListxx[1];
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
            public static string GetNama(string userid)
        {
            string mybol = "";
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
                CommandText = "select firstname FROM   live_user_staf  where att15=@userid ";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    mybol = rdr["firstname"].ToString().Trim();
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
          
            if (mybol == "")
            {

                try
                {
                    // Open connection to the database
                    String ConnectionString = SQLAuth.dbase_dbeqcas;
                    con = new SqlConnection(ConnectionString);
                    con.Open();
                    CommandText = "select firstname FROM   live_user  where att15=@userid ";
                    cmd = new SqlCommand(CommandText);
                    cmd.Connection = con;
                    cmd.CommandText = CommandText;
                    cmd.Parameters.AddWithValue("@userid", userid);
                    rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        mybol = rdr["firstname"].ToString().Trim();
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

           return mybol;
       


        }








        public static IEnumerable<string> GetEmergencyButton(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = " SELECT b.cms04_status_bm, b.cms04_status_bi, a.cms01_id, a.cms01_userid, a.cms01_aduan, a.cms01_Tarikhterima, a.cms01_Tarikhkemaskini, a.cms01_lokasi, a.cms01_telefon, a.cms01_kodpejabat_terima, a.cms01_gambar, a.cms01_status ";
                CommandText = CommandText + " FROM     cms01_Kecemasan as a,  cms04_status_kecemasan as b  where a.cms01_status=b.cms04_id and a.cms01_userid=@userid  order by a.cms01_id desc ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    myList.Add(rdr["cms01_id"].ToString());
                    myList.Add(rdr["cms01_Tarikhterima"].ToString());
                    myList.Add(rdr["cms01_aduan"].ToString());
                    myList.Add(rdr["cms04_status_bm"].ToString().Trim());
                  //  if (rdr["cms01_status"].ToString() == "1") {
                   //     myList.Add("selesai");
                   // } else {
                   //     myList.Add("belumselesai");
                   // }
                    

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
        public static IEnumerable<string> GetEmergencyButton_cam(string userid)
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
                String ConnectionString = SQLAuth.dbase_developer;
                con = new SqlConnection(ConnectionString);
                con.Open();

                // string CommandText = " SELECT b.cms04_status_bm, b.cms04_status_bi, a.cms01_id, a.cms01_userid, a.cms01_aduan, a.cms01_Tarikhterima, a.cms01_Tarikhkemaskini, a.cms01_lokasi, a.cms01_telefon, a.cms01_kodpejabat_terima, a.cms01_gambar, a.cms01_status ";
                //   CommandText = CommandText + " FROM     cms01_Kecemasan as a,  cms04_status_kecemasan as b  where a.cms01_status=b.cms04_id and a.cms01_userid=@userid  order by a.cms01_id desc ";
                string CommandText = " SELECT    ivts02_id, ivts02_platid, ivts02_lokasi, ivts02_jenis, ivts02_Tarikh, ivts02_gambar, ivts02_jenis_gambar, ivts02_nostaf";
                CommandText = CommandText + " FROM ivts02_Aktiviti_Kenderaan where ivts02_nostaf=@userid order by ivts02_id desc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                  //  myList.Add(rdr["cms01_id"].ToString());
                  //  myList.Add(rdr["cms01_Tarikhterima"].ToString());
                 //   myList.Add(rdr["cms01_aduan"].ToString());
                  //  myList.Add(rdr["cms04_status_bm"].ToString().Trim());

                    myList.Add(rdr["ivts02_id"].ToString());
                    myList.Add(rdr["ivts02_Tarikh"].ToString());
                    myList.Add(rdr["ivts02_lokasi"].ToString());
                    myList.Add("Selesai");

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


        public static IEnumerable<string> GetAkaunPelajar(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = " SELECT        NOMATRIK, NAMA, FAKULTI, PROGRAM, SESI_SEMASA, HUTANG_ALL, DCID, SESI_TRANSAKSI, JENIS_DC, JUM_DC, JUM_BAYAR, JUM_KC, KODVOT, BUTIRAN, DEBIT, KREDIT ";
                CommandText = CommandText + "  FROM            dbo.TVF_MOB_APP_KEW_PENYATA_PL(@userid) AS TVF_MOB_APP_KEW_PENYATA_PL_1 ";

                //    CommandText = CommandText + " FROM     cms01_Kecemasan as a,  cms04_status_kecemasan as b  where a.cms01_status=b.cms04_id and a.cms01_userid=@userid  order by a.cms01_id desc ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                //cmd.Parameters.AddWithValue("@sessi", SQLKuliah.SessiAktif());  B042110010
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    myList.Add(rdr["SESI_TRANSAKSI"].ToString());
                    myList.Add(rdr["JUM_DC"].ToString());
                    myList.Add(rdr["KODVOT"].ToString());
                    myList.Add(rdr["BUTIRAN"].ToString().Trim());
                    myList.Add(rdr["DEBIT"].ToString() + "/" + rdr["KREDIT"].ToString());
                    //  if (rdr["cms01_status"].ToString() == "1") {
                    //     myList.Add("selesai");
                    // } else {
                    //     myList.Add("belumselesai");
                    // }


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

        //GetpaparKursuspelajar
        public static IEnumerable<string> GetpaparKursuspelajar(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = " SELECT        FAKULTI, TAHUN_PROGRAM, NAMA, SESI, KP, NOMATRIK, KURSUS, NAMA_KURSUS, SEKSYEN, KUMPULAN, KREDIT, STATUS_UM_UG, NAMA_PENSYARAH, NO_TEL_PEJABAT, EMEL, PENSYARAH ";
                CommandText = CommandText + "   FROM            dbo.TVF_MOB_APP_KRS_SLIP_KURSUS(@sessi, @userid) AS TVF_MOB_APP_KRS_SLIP_KURSUS_1 ";

                //    CommandText = CommandText + " FROM     cms01_Kecemasan as a,  cms04_status_kecemasan as b  where a.cms01_status=b.cms04_id and a.cms01_userid=@userid  order by a.cms01_id desc ";
                //SessiAktif()"b042110010"
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid );
                cmd.Parameters.AddWithValue("@sessi", SQLKuliah.SessiAktif());
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    myList.Add(rdr["KURSUS"].ToString());
                    myList.Add(rdr["NAMA_KURSUS"].ToString());
                    myList.Add(rdr["SEKSYEN"].ToString() + "-" + rdr["KUMPULAN"].ToString());
                    myList.Add(rdr["KREDIT"].ToString().Trim());
                    myList.Add(rdr["STATUS_UM_UG"].ToString());
                    //  if (rdr["cms01_status"].ToString() == "1") {
                    //     myList.Add("selesai");
                    // } else {
                    //     myList.Add("belumselesai");
                    // }


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
        public static IEnumerable<string> GetpaparLogTukarPassword(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT  top(6) id, user_id, email, mypassword, convert(varchar,mydate, 13)  as mydatein, mymodul, mytype, status, note      FROM            AspNetResetEmail WHERE user_id=@userid order by id desc ";
              //  CommandText = CommandText + "   FROM            FROM AspNetResetEmail "; //where user_id=@userid";

                //    CommandText = CommandText + " FROM     cms01_Kecemasan as a,  cms04_status_kecemasan as b  where a.cms01_status=b.cms04_id and a.cms01_userid=@userid  order by a.cms01_id desc ";
                //SessiAktif()"b042110010"
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
              //  cmd.Parameters.AddWithValue("@sessi", SQLKuliah.SessiAktif());
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    //myList.Add("xxx");
                    //myList.Add("xxx");
                    //myList.Add("xxx");
                    //myList.Add("xxx");
                    //myList.Add("xxx");
                    myList.Add(rdr["id"].ToString());
                    myList.Add(rdr["mydatein"].ToString().Trim());
                    myList.Add(rdr["mymodul"].ToString());
                    if (rdr["mymodul"].ToString() == "email") {
                        myList.Add(rdr["email"].ToString().Trim());
                    } else {
                        myList.Add(rdr["user_id"].ToString().Trim());
                    }
                   
                    myList.Add(rdr["status"].ToString());
                
                   



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
        public static IEnumerable<string> GetMarkahKerjaKursus(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbstudent;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = " SELECT DISTINCT B.SMP07_KodMP, B.SMP16_Kategori, A.SMP15_KodMrk, A.SMP15_Peratus, B.SMP16_Markah ";
                CommandText = CommandText + "   FROM SMP15_AgihMrk AS A LEFT OUTER JOIN ";
                CommandText = CommandText + "                            SMP16_MarkahDT AS B ON A.SMP07_KodMP = B.SMP07_KodMP AND A.SMP15_Sesi = B.KodSesi_Sem AND A.SMP15_KodMrk = B.SMP15_KodMrk INNER JOIN ";
                CommandText = CommandText + "                                     SMP11_MPPelajar AS C ON C.SMP07_KodMP = B.SMP07_KodMP AND C.SMP01_NOMATRIK = B.SMP01_NOMATRIK AND C.KodSesi_Sem = B.KodSesi_Sem INNER JOIN ";
                CommandText = CommandText + "                                      SMP07_Matapelajaran AS D ON C.SMP07_KodMP = D.SMP07_KodMP ";
                CommandText = CommandText + "            WHERE(B.SMP01_NOMATRIK = 'B051710206') AND(A.SMP15_Sesi = '2-2021/2022') AND(B.SMP16_Kategori <> 'PEPERIKSAAN AKHIR') AND(C.SMP08_StatusMP <> 'LI' OR ";

                CommandText = CommandText + "                           C.SMP08_StatusMP IS NULL) AND(D.SMP07_NamaMP NOT LIKE '%PROJEK SARJANA MUDA%') AND(D.SMP07_StatusOBE IS NULL OR ";

                CommandText = CommandText + "                         D.SMP07_StatusOBE = '' OR ";

                CommandText = CommandText + "                           D.SMP07_StatusOBE = 0) ";
                CommandText = CommandText + "            UNION ALL ";
                CommandText = CommandText + "           SELECT DISTINCT ";
                CommandText = CommandText + "                                     B.SMP07_KodMP, 'KERJA KURSUS' AS smp16_kategori, 'KK' AS smp15_kodmrk, SUM(ISNULL(A.SMP15_Peratus, 0)) AS smp15_peratus, CONVERT(decimal(12, 1), SUM(ISNULL(B.SMP16_Markah, 0))) AS smp16_markah ";
                CommandText = CommandText + "            FROM SMP15_AgihMrk AS A LEFT OUTER JOIN ";
                CommandText = CommandText + "                         SMP16_MarkahDT AS B ON A.SMP07_KodMP = B.SMP07_KodMP AND A.SMP15_Sesi = B.KodSesi_Sem AND A.SMP15_KodMrk = B.SMP15_KodMrk INNER JOIN ";
                CommandText = CommandText + "                                    SMP11_MPPelajar AS C ON C.SMP07_KodMP = B.SMP07_KodMP AND C.SMP01_NOMATRIK = B.SMP01_NOMATRIK AND C.KodSesi_Sem = B.KodSesi_Sem INNER JOIN ";
                CommandText = CommandText + "                                   SMP07_Matapelajaran AS D ON C.SMP07_KodMP = D.SMP07_KodMP ";
                CommandText = CommandText + "          WHERE(B.SMP01_NOMATRIK = @userid) AND(A.SMP15_Sesi = @sessi) AND(B.SMP16_Kategori <> 'PEPERIKSAAN AKHIR') AND(C.SMP08_StatusMP <> 'LI' OR ";

                CommandText = CommandText + "                         C.SMP08_StatusMP IS NULL) AND(D.SMP07_NamaMP NOT LIKE '%PROJEK SARJANA MUDA%') AND(D.SMP07_StatusOBE = 1) ";
                CommandText = CommandText + "         GROUP BY B.SMP07_KodMP ";
            //    CommandText = CommandText + " FROM     cms01_Kecemasan as a,  cms04_status_kecemasan as b  where a.cms01_status=b.cms04_id and a.cms01_userid=@userid  order by a.cms01_id desc ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);  //SessiAktif()
                cmd.Parameters.AddWithValue("@sessi", SQLKuliah.SessiAktif());  //SessiAktif()
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    myList.Add(rdr["SMP07_KodMP"].ToString());
                    myList.Add(rdr["SMP16_Kategori"].ToString());
                    myList.Add(rdr["SMP15_KodMrk"].ToString());
                    myList.Add(rdr["SMP15_Peratus"].ToString().Trim());
                    myList.Add(rdr["SMP16_Markah"].ToString());
                    //  if (rdr["cms01_status"].ToString() == "1") {
                    //     myList.Add("selesai");
                    // } else {
                    //     myList.Add("belumselesai");
                    // }


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
        public static IEnumerable<string> GetMenuMalaysiaReport(string datefrom, string dateto)
 
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
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT   id, MK_IdKafe, MK_Nama, MK_Lokasi, MK_Pengusaha FROM MK_Kafe ";
              //  CommandText = CommandText + "   MK_Kafe as b where a.MK_IdKafe=b.MK_IdKafe    and a.MK_NoMatrik=@userid  order by a.MK_TkhMasa desc ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
               // cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    int mjum = GetJumlahStudentMenu(datefrom, dateto, rdr["MK_IdKafe"].ToString().Trim());
                    double jumlah = (mjum * 3.50);
                    myList.Add(rdr["MK_Nama"].ToString().Trim());
                    //  myList.Add(GetJumlahStudentMenu(datefrom, dateto, rdr["MK_IdKafe"].ToString().Trim()).ToString());
                     
                    //   myList.Add(dateto);
                    myList.Add(rdr["MK_Lokasi"].ToString().Trim());
                    myList.Add(mjum.ToString("0.##"));
                    myList.Add(jumlah.ToString());
                    //  if (rdr["cms01_status"].ToString() == "1") {
                    //     myList.Add("selesai");
                    // } else {
                    //     myList.Add("belumselesai");
                    // }

                    //int mjum = GetJumlahStudentMenu(datefrom, dateto, rdr["MK_IdKafe"].ToString().Trim());
                    //int jumlah = (mjum * 5);
                    //myList.Add(rdr["MK_Nama"].ToString().Trim());
                    ////   myList.Add(datefrom);
                    ////   myList.Add(dateto);
                    //myList.Add(rdr["MK_Lokasi"].ToString().Trim());
                    //myList.Add(mjum.ToString());

                    //myList.Add(jumlah.ToString());
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
        public static IEnumerable<string> LastCutiStaf(string userid)

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
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT    MS26_KodMohonCuti, MS01_NoStaf, CT_KodKategoriCuti, CT_KodCuti, MS26_Tahun, MS26_TkhMula, MS26_TkhTamat, MS26_BilHari, MS01_AlamatT1, MS01_AlamatT2, MS01_PoskodTetap, MS01_BandarTetap, ";
                CommandText = CommandText  + " MS01_NegeriTetap, MS01_NegaraTetap, MS01_NoTelR1, MS26_TkhMohon, MS26_Penyokong, MS26_Pelulus, MS26_TkhSokong, MS26_TkhLulus, MS26_IDBatal, MS26_TkhBatal, MS26_StatusCuti, MS26_SebabTakLulus,  ";
                CommandText = CommandText + " MS26_SebabCuti, MS26_SebabBatal, MS26_NoPT, MS26_TkhPT, CT_BilHariMohon, MS26_IDKemaskini, MS26_TkhKemaskini, MS26_KlinikPanel, MS26_KlinikLain, MS26_NoResitKlinik, MS26_TkhResit, Tkh_Wujud,   ";
                CommandText = CommandText + " MS26_StaEL, MS26_KateKlinik, MS08_Pejabat  FROM            MS26_CutiStaf ";
                CommandText = CommandText + " WHERE (MS01_NoStaf = @userid)  ORDER BY MS26_TkhMohon DESC";
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    //  myList.Add(rdr["MS01_BandarTetap"].ToString().Trim());
                    myList.Add(rdr["MS01_AlamatT1"].ToString().Trim() + " " + rdr["MS01_AlamatT2"].ToString().Trim());
                    myList.Add(rdr["MS01_BandarTetap"].ToString().Trim());
                    myList.Add(rdr["MS01_PoskodTetap"].ToString().Trim());
                    myList.Add(rdr["MS01_NoTelR1"].ToString().Trim());
                    myList.Add("");
                    myList.Add(negeri(rdr["MS01_NegeriTetap"].ToString().Trim()));
                    myList.Add(negara(rdr["MS01_NegaraTetap"].ToString().Trim()));

                    //alamat.Text = items[0];
                    //bandar.Text = items[1];
                    //poskod.Text = items[2];
                    //telefon.Text = items[3];
                    //sebab.Text = items[4];
                    //picker2.SelectedIndex = Int32.Parse(items[5]);
                    //picker3.SelectedIndex = Int32.Parse(items[6]);

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
        public static  string negara(string kodid)
        {

            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string mdata = "0";
            try
            {
                CommandText = "SELECT        Kod, Negara FROM VNegara where Kod <> '999'";
                con = new SqlConnection(SQLAuth.dbase_dbstaf);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                int i = 0;
                while (rdr.Read())
                {
                    if (rdr["kod"].ToString().Trim() == kodid) { mdata = i.ToString();  break; }
                    i++;
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
            return mdata;
        }
        public static  string negeri(string kodid)
        {

            string CommandText = "";
            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
            string mdata = "0";
            try
            {
                CommandText = "SELECT        Kod, Negeri FROM VNegeri where Kod <> '-'";
                con = new SqlConnection(SQLAuth.dbase_dbstaf);
                con.Open();
                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                int i = 0;
                while (rdr.Read())
                {
                    if (rdr["kod"].ToString().Trim() == kodid) { mdata = i.ToString(); break; }
                    i++;
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
            return mdata;
        }
        public static int GetJumlahStudentMenu(string datefrom, string dateto, string idkafe)
        {
            string mybolx = "1";
            int count = 0;
            int row = 0;
            SqlDataReader rdr2 = null;
            SqlConnection con2 = null;
            SqlCommand cmd2 = null;
            try
            {
                // Open connection to the database
                String ConnectionString2 = SQLAuth.dbase_dbmobile;
                con2 = new SqlConnection(ConnectionString2);
                con2.Open();
               // string CommandText2 = "SELECT count(*)  FROM    MK01_Daftar where  a.att04_userid = @nostaf and a.att01_id = 3 and cast(a.att04_date as date) = cast(getdate() as date)  ";

             //   string CommandText2 = "SELECT count(*)  FROM    MK01_Daftar where  (MK_IdKafe = @idkafe)  and ( cast(MK_TkhMasa as date) >= cast(@datefrom as date) and cast(MK_TkhMasa as date) <= cast(@dateto as date)) ";
                string CommandText2 = "SELECT count(*)  FROM    MK01_Daftar where  MK_IdKafe = @idkafe and  cast(MK_TkhMasa as date)  BETWEEN @datefrom and @dateto";

                cmd2 = new SqlCommand(CommandText2);
                cmd2.Connection = con2;
                cmd2.CommandText = CommandText2;
                cmd2.Parameters.AddWithValue("@idkafe", idkafe);
                cmd2.Parameters.AddWithValue("@datefrom", datefrom);
                cmd2.Parameters.AddWithValue("@dateto", dateto);
                count = (Int32)cmd2.ExecuteScalar();
               

            }
            catch (Exception)
            {

            }
            finally
            {
                if (rdr2 != null)
                    rdr2.Close();

                if (con2.State == ConnectionState.Open)
                    con2.Close();
            }
            //   mybol = count; // Int32.Parse(mybolx);
            return count;
        }



        public static IEnumerable<string> GetMenuMalaysiaHistory(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT        a.id, a.MK_NoMatrik, a.MK_Status, a.MK_TkhMasa, a.MK_IdKafe, b.MK_Nama, b.MK_Lokasi, b.MK_Pengusaha ";
                CommandText = CommandText + "   FROM            MK01_Daftar AS a INNER JOIN MK_Kafe AS b ON a.MK_IdKafe = b.MK_IdKafe WHERE        (a.MK_NoMatrik = @userid) ORDER BY a.MK_TkhMasa DESC ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
               cmd.Parameters.AddWithValue("@userid", userid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    myList.Add(rdr["id"].ToString());
                    myList.Add(rdr["MK_TkhMasa"].ToString());
                    myList.Add(rdr["MK_Nama"].ToString());
                    myList.Add(rdr["MK_Lokasi"].ToString().Trim() + "-" + rdr["MK_Pengusaha"].ToString().Trim());
                    //  if (rdr["cms01_status"].ToString() == "1") {
                    //     myList.Add("selesai");
                    // } else {
                    //     myList.Add("belumselesai");
                    // }


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




        public static IEnumerable<string> GetEmergencyButtonAdmin(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();
        //        0   Belum Diambil Tindakan No Action Taken
//1   Selesai Close Report
//2   Dalam Siasatan  Under Investigation
//3   Aduan Tidak Sah Invalid Report

                string CommandText = " SELECT cms01_id, cms01_userid, cms01_aduan, cms01_Tarikhterima, cms01_Tarikhkemaskini, cms01_lokasi, cms01_telefon, cms01_kodpejabat_terima, cms01_gambar, cms01_status ";
                CommandText = CommandText + " FROM     cms01_Kecemasan  where cms01_status='0' or cms01_status='2' order by cms01_id desc ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
               // cmd.Parameters.AddWithValue("@cmsstatus", "0");
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {

                    myList.Add(rdr["cms01_id"].ToString());
                    myList.Add(rdr["cms01_Tarikhterima"].ToString());
                    myList.Add(rdr["cms01_aduan"].ToString());
                    myList.Add("belumselesai");

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


        public static IEnumerable<string> GetEmergencyDetailFill(string Emerg_id)
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
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = " SELECT cms01_id, cms01_userid, cms01_nama, cms01_aduan, cms01_Tarikhterima, cms01_Tarikhkemaskini, cms01_lokasi, cms01_telefon, cms01_kodpejabat_terima, cms01_gambar, cms01_jenis_gambar, cms01_status,  cms01_FolderR, cms01_FailR, cms01_NoLap, cms01_kategori, cms_alarm, cms01_long, cms01_lat  ";
                CommandText = CommandText + " FROM     cms01_Kecemasan  where cms01_id=@Emerg_id";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@Emerg_id", Emerg_id);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    string ff = SQLMigs.GetNama(rdr["cms01_userid"].ToString());
                    string mlat = "" + rdr["cms01_lat"].ToString();
                    string mlon = "" + rdr["cms01_long"].ToString();
                    myList.Add(rdr["cms01_userid"].ToString() + " - " + ff);
                    myList.Add(rdr["cms01_aduan"].ToString());
                    myList.Add(rdr["cms01_lokasi"].ToString());
                    myList.Add(rdr["cms01_telefon"].ToString());
                    if ((rdr["cms01_jenis_gambar"].ToString() == "mp4") ||
                       (rdr["cms01_jenis_gambar"].ToString() == "jpg")) {
                        myList.Add(rdr["cms01_jenis_gambar"].ToString());
                    }
                    else
                    {
                        myList.Add("tiada");
                    }
                    if (mlat == "0") {
                        myList.Add("");
                        myList.Add("");
                    } else
                    {
                        myList.Add(mlat);
                        myList.Add(mlon);
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
                // return twoDimensionalx;
            }
        }






        public static IEnumerable<string> GetMIGSSumbangan(string userid)
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
                String ConnectionString = SQLAuth.dbase_dbmobile;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string  CommandText = " SELECT Tran_id, Ref_id, userid, mydate_req, status_tran, status_migs, CONVERT(VARCHAR(10), mydate_migs, 105) as df,  amt_pay, vpc_MerchTxnRef, note, jenis_modul, vpc_TxnResponseCode, nama, email, param1, param2, param3 ";
                        CommandText = CommandText + " FROM     migs_payment  where userid=@userid and note='Sumbangan' and vpc_TxnResponseCode='0'";

                        cmd = new SqlCommand(CommandText);
                        cmd.Connection = con;
                        cmd.CommandText = CommandText;
                        cmd.Parameters.AddWithValue("@userid", userid);
                        rdr = cmd.ExecuteReader();
                        while (rdr.Read())
                        {
                  
                                myList.Add(rdr["Ref_id"].ToString());
                                myList.Add(rdr["df"].ToString());
                                myList.Add(rdr["amt_pay"].ToString());
                                myList.Add(rdr["Ref_id"].ToString());

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
        public static IEnumerable<string> GetSumbanganDetailPaid(string userid, string sid)
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
                string CommandText = " SELECT Tran_id, Ref_id, userid, mydate_req, status_tran, status_migs, CONVERT(VARCHAR(10), mydate_migs, 105) as df,  amt_pay, vpc_MerchTxnRef, note, jenis_modul, vpc_TxnResponseCode, nama, email, param1, param2, param3 ";
                CommandText = CommandText + " FROM     migs_payment  where userid=@userid and Ref_id=@sid and note='Sumbangan' and vpc_TxnResponseCode='0'";


                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sid", sid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                        myList.Add(rdr["Ref_id"].ToString()); // id bayat
                        myList.Add(rdr["userid"].ToString());
                        myList.Add(rdr["df"].ToString());
                        myList.Add(rdr["param1"].ToString()); // tkh bayar
                        myList.Add(rdr["param2"].ToString());  // jum bayar
                        myList.Add(rdr["amt_pay"].ToString());  // jum bayar
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
        public static IEnumerable<string> GetMenuMalaysiaDetailHistory(string userid, string sid)
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
               // string CommandText = " SELECT Tran_id, Ref_id, userid, mydate_req, status_tran, status_migs, CONVERT(VARCHAR(10), mydate_migs, 105) as df,  amt_pay, vpc_MerchTxnRef, note, jenis_modul, vpc_TxnResponseCode, nama, email, param1, param2, param3 ";
               // CommandText = CommandText + " FROM     migs_payment  where userid=@userid and Ref_id=@sid and note='Sumbangan' and vpc_TxnResponseCode='0'";
                string CommandText = "SELECT   a.id, a.MK_NoMatrik, a.MK_Status, a.MK_TkhMasa, a.MK_IdKafe,  b.MK_Nama, b.MK_Lokasi, b.MK_Pengusaha FROM MK01_Daftar as a, ";
                CommandText = CommandText + "   MK_Kafe as b where a.MK_IdKafe=b.MK_IdKafe and a.id=@sid    and a.MK_NoMatrik=@userid  order by a.MK_TkhMasa desc ";


                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@userid", userid);
                cmd.Parameters.AddWithValue("@sid", sid);
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["id"].ToString()); // id bayat
                    myList.Add(Convert.ToDateTime(rdr["MK_TkhMasa"]).ToString("dd/MM/yyyy"));
                    myList.Add(rdr["MK_Nama"].ToString());
                    myList.Add(rdr["MK_Lokasi"].ToString()); // tkh bayar
                    myList.Add(rdr["MK_Pengusaha"].ToString());  // jum bayar
                    myList.Add(Convert.ToDateTime(rdr["MK_TkhMasa"]).ToString("hh:mm tt"));  // jum bayar

                   // ret[1] = Convert.ToDateTime(rdr["MK_TkhMasa"]).ToString("dd/MM/yyyy");
                  //  ret[2] = Convert.ToDateTime(rdr["MK_TkhMasa"]).ToString("hh:mm tt");

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
    }
}