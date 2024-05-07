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

namespace WebApi
{
    public class SQLUnixphone
    {

        public static IEnumerable<string> Updatetoxphoneid(string userid, string phoneid)
        {
            string[] ret = new string[2];
            ret[0] = "ok";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"update AspNetUsers set Reg_phoneid='x', Reg_lockdate = NULL  where Reg_phoneid = @PHONEID ";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@PHONEID", phoneid);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            ret[0] = "no";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = "no";
            }
            return ret;
        }
       
        public static IEnumerable<string> Updatetophoneid(string userid, string phoneid)
        {
            string[] ret = new string[2];
            ret[0] = "ok";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"update AspNetUsers set Reg_phoneid=@PHONEID, Reg_lockdate = NULL  where email = @USERID ";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@PHONEID", phoneid);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            ret[0] = "no";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = "no";
            }
            return ret;
        }
        public static IEnumerable<string> Updatetophoneiddate(string userid, string phoneid)
        {
            string[] ret = new string[2];
            ret[0] = "ok";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"update AspNetUsers set Reg_phoneid=@PHONEID, Reg_lockdate = cast(getdate() as date)  where email = @USERID ";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);
                        cmd.Parameters.AddWithValue("@PHONEID", phoneid);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            ret[0] = "no";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = "no";
            }
            return ret;
        }
        public static IEnumerable<string> Updatetophoneiddatnull(string userid)
        {
            string[] ret = new string[2];
            ret[0] = "ok";
            try
            {
                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbmobile))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.CommandText = @"update AspNetUsers set  Reg_lockdate = NULL  where email = @USERID ";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@USERID", userid);

                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                        }
                        catch (SqlException e)
                        {
                            ret[0] = "no";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = "no";
            }
            return ret;
        }
    }
}