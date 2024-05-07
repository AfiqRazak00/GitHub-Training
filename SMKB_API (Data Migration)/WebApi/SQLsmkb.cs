using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Device.Location;
using System.IO;
using System.Data;
using System.Net.NetworkInformation;
using System.Management.Automation.Runspaces;
using System.Data.Entity.Infrastructure;
using System.Management.Automation;
using System.Web.UI.WebControls.WebParts;
using System.Collections;
using Newtonsoft.Json.Linq;
using Microsoft.Ajax.Utilities;

namespace WebApi
{
    public class SQLsmkb
    {
        public static IEnumerable<string> PostingLejar(string parMethod, string parRujukan, string parKW, string parPTj, string parVot, string parKO, string parKP, double parAmount, string parDrCr, string parBulan, string parThnxxx)
        {
            string[] ret = new string[1];
            ret[0] = "no";

            //DateTime parTkh = DateTime.Today;
            //string dateString = "2023-06-01";
            //DateTime vTkhTrans = DateTime.Parse(parTkh);

            double strDr1 = 0;
            double strDr2 = 0;
            double strDr3 = 0;
            double strDr4 = 0;
            double strDr5 = 0;
            double strDr6 = 0;
            double strDr7 = 0;
            double strDr8 = 0;
            double strDr9 = 0;
            double strDr10 = 0;
            double strDr11 = 0;
            double strDr12 = 0;
            double strDr13 = 0;

            double strCr1 = 0;
            double strCr2 = 0;
            double strCr3 = 0;
            double strCr4 = 0;
            double strCr5 = 0;
            double strCr6 = 0;
            double strCr7 = 0;
            double strCr8 = 0;
            double strCr9 = 0;
            double strCr10 = 0;
            double strCr11 = 0;
            double strCr12 = 0;
            double strCr13 = 0;

            string strStatus = "1";

            //int month = parBulan;

            int month = int.Parse(parBulan);
            int tahun = int.Parse(parThnxxx);

            switch (month)
            {
                case 1:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr1 = parAmount;
                            break;
                        case "CR":
                            strCr1 = parAmount;
                            break;
                    }
                    break;
                case 2:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr2 = parAmount;
                            break;
                        case "CR":
                            strCr2 = parAmount;
                            break;
                    }
                    break;
                case 3:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr3 = parAmount;
                            break;
                        case "CR":
                            strCr3 = parAmount;
                            break;
                    }
                    break;
                case 4:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr4 = parAmount;
                            break;
                        case "CR":
                            strCr4 = parAmount;
                            break;
                    }
                    break;
                case 5:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr5 = parAmount;
                            break;
                        case "CR":
                            strCr5 = parAmount;
                            break;
                    }
                    break;
                case 6:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr6 = parAmount;
                            break;
                        case "CR":
                            strCr6 = parAmount;
                            break;
                    }
                    break;
                case 7:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr7 = parAmount;
                            break;
                        case "CR":
                            strCr7 = parAmount;
                            break;
                    }
                    break;
                case 8:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr8 = parAmount;
                            break;
                        case "CR":
                            strCr8 = parAmount;
                            break;
                    }
                    break;
                case 9:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr9 = parAmount;
                            break;
                        case "CR":
                            strCr9 = parAmount;
                            break;
                    }
                    break;
                case 10:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr10 = parAmount;
                            break;
                        case "CR":
                            strCr10 = parAmount;
                            break;
                    }
                    break;
                case 11:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr11 = parAmount;
                            break;
                        case "CR":
                            strCr11 = parAmount;
                            break;
                    }
                    break;
                case 12:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr12 = parAmount;
                            break;
                        case "CR":
                            strCr12 = parAmount;
                            break;
                    }
                    break;
                default:
                    switch (parDrCr)
                    {
                        case "DR":
                            strDr13 = parAmount;
                            break;
                        case "CR":
                            strCr13 = parAmount;
                            break;
                    }
                    break;
            }



            try
            {

                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                {
                    switch (parMethod)
                    {
                        case "AR":
                            string queryAR = "SELECT COUNT(*) FROM SMKB_Lejar_Penghutang " +
                                "   WHERE Kod_Penghutang = @Kod_Penghutang" +
                                " AND Tahun = @Tahun" +
                                " AND Kod_Kump_Wang = @Kod_Kump_Wang" +
                                " AND Kod_Operasi = @Kod_Operasi" +
                                " AND Kod_Projek = @Kod_Projek" +
                                " AND Kod_PTJ = @Kod_PTJ" +
                                " AND Kod_Vot = @Kod_Vot";


                            if (sqlConn.State != System.Data.ConnectionState.Open)
                            {
                                sqlConn.Open(); // Open the connection only if it's not already open
                            }

                            using (SqlCommand command = new SqlCommand(queryAR, sqlConn))
                            {
                                // Add a parameter to the query for the value you want to check
                                command.Parameters.AddWithValue("@Kod_Penghutang", parRujukan);
                                command.Parameters.AddWithValue("@Tahun", tahun);
                                command.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                                command.Parameters.AddWithValue("@Kod_Operasi", parKO);
                                command.Parameters.AddWithValue("@Kod_Projek", parKP);
                                command.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                                command.Parameters.AddWithValue("@Kod_Vot", parVot);

                                int count = (int)command.ExecuteScalar();

                                if (count > 0)
                                {
                                    //Console.WriteLine("Data exists in the table.");
                                    //ret[0] = query.ToString();
                                    //ret[0] = "Data exists in the table.";
                                    using (SqlCommand cmd = new SqlCommand())
                                    {
                                        //Console.WriteLine("Data does not exist in the table.");
                                        cmd.CommandText = "UPDATE SMKB_Lejar_Penghutang " +
                                            " SET Dr_1 = Dr_1 + @Dr_1, Cr_1 = Cr_1 + @Cr_1, Dr_2 = Dr_2 + @Dr_2, Cr_2 = Cr_2 + @Cr_2," +
                                            " Dr_3 = Dr_3 + @Dr_3, Cr_3 = Cr_3 + @Cr_3, Dr_4 = Dr_4 + @Dr_4, Cr_4 = Cr_4 + @Cr_4," +
                                            " Dr_5 = Dr_5 + @Dr_5, Cr_5 = Cr_5 + @Cr_5, Dr_6 = Dr_6 + @Dr_6, Cr_6 = Cr_6 + @Cr_6," +
                                            " Dr_7 = Dr_7 + @Dr_7, Cr_7 = Cr_7 + @Cr_7, Dr_8 = Dr_8 + @Dr_8, Cr_8 = Cr_8 + @Cr_8," +
                                            " Dr_9 = Dr_9 + @Dr_9, Cr_9 = Cr_9 + @Cr_9, Dr_10 = Dr_10 + @Dr_10, Cr_10 = Cr_10 + @Cr_10," +
                                            " Dr_11 = Dr_11 + @Dr_11, Cr_11 = Cr_11 + @Cr_11, Dr_12 = Dr_12 + @Dr_12, Cr_12 = Cr_12 + @Cr_12" +
                                            " WHERE Kod_Penghutang = @Kod_Penghutang" +
                                            " AND Tahun = @Tahun" +
                                            " AND Kod_Kump_Wang = @Kod_Kump_Wang" +
                                            " AND Kod_Operasi = @Kod_Operasi" +
                                            " AND Kod_Projek = @Kod_Projek" +
                                            " AND Kod_PTJ = @Kod_PTJ" +
                                            " AND Kod_Vot = @Kod_Vot";

                                        cmd.Connection = sqlConn;
                                        cmd.Parameters.AddWithValue("@Kod_Penghutang", parRujukan);
                                        cmd.Parameters.AddWithValue("@Tahun", tahun);
                                        cmd.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                                        cmd.Parameters.AddWithValue("@Kod_Operasi", parKO);
                                        cmd.Parameters.AddWithValue("@Kod_Projek", parKP);
                                        cmd.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                                        cmd.Parameters.AddWithValue("@Kod_Vot", parVot);
                                        cmd.Parameters.AddWithValue("@Dr_1", strDr1);
                                        cmd.Parameters.AddWithValue("@Cr_1", strCr1);
                                        cmd.Parameters.AddWithValue("@Dr_2", strDr2);
                                        cmd.Parameters.AddWithValue("@Cr_2", strCr2);
                                        cmd.Parameters.AddWithValue("@Dr_3", strDr3);
                                        cmd.Parameters.AddWithValue("@Cr_3", strCr3);
                                        cmd.Parameters.AddWithValue("@Dr_4", strDr4);
                                        cmd.Parameters.AddWithValue("@Cr_4", strCr4);
                                        cmd.Parameters.AddWithValue("@Dr_5", strDr5);
                                        cmd.Parameters.AddWithValue("@Cr_5", strCr5);
                                        cmd.Parameters.AddWithValue("@Dr_6", strDr6);
                                        cmd.Parameters.AddWithValue("@Cr_6", strCr6);
                                        cmd.Parameters.AddWithValue("@Dr_7", strDr7);
                                        cmd.Parameters.AddWithValue("@Cr_7", strCr7);
                                        cmd.Parameters.AddWithValue("@Dr_8", strDr8);
                                        cmd.Parameters.AddWithValue("@Cr_8", strCr8);
                                        cmd.Parameters.AddWithValue("@Dr_9", strDr9);
                                        cmd.Parameters.AddWithValue("@Cr_9", strCr9);
                                        cmd.Parameters.AddWithValue("@Dr_10", strDr10);
                                        cmd.Parameters.AddWithValue("@Cr_10", strCr10);
                                        cmd.Parameters.AddWithValue("@Dr_11", strDr11);
                                        cmd.Parameters.AddWithValue("@Cr_11", strCr11);
                                        cmd.Parameters.AddWithValue("@Dr_12", strDr12);
                                        cmd.Parameters.AddWithValue("@Cr_12", strCr12);
                                        cmd.Parameters.AddWithValue("@Status", strStatus);

                                        try
                                        {

                                            if (sqlConn.State != System.Data.ConnectionState.Open)
                                            {
                                                sqlConn.Open(); // Open the connection only if it's not already open
                                            }
                                            cmd.ExecuteNonQuery();
                                            ret[0] = "ok";
                                        }
                                        catch (SqlException e)
                                        {
                                            //ret[0] = e.Message.ToString();
                                            ret[0] = parMethod.ToString() + count.ToString();
                                        }

                                    }

                                }
                                else
                                {
                                    //ret[0] = query.ToString();
                                    //ret[0] = "Data does not exist in the table.";

                                    using (SqlCommand cmd = new SqlCommand())
                                    {
                                        //Console.WriteLine("Data does not exist in the table.");
                                        cmd.CommandText = @"INSERT INTO SMKB_Lejar_Penghutang " +
                                            "(Kod_Penghutang, Tahun, Kod_Kump_Wang, Kod_Operasi, Kod_Projek, Kod_PTJ, Kod_Vot, " +
                                            "Dr_1, Cr_1, Dr_2, Cr_2, Dr_3, Cr_3, Dr_4, Cr_4, Dr_5, Cr_5, Dr_6, Cr_6, " +
                                            "Dr_7, Cr_7, Dr_8, Cr_8, Dr_9, Cr_9, Dr_10, Cr_10, Dr_11, Cr_11, Dr_12, " +
                                            "Cr_12, Dr_13, Cr_13, Status) " +
                                            "VALUES (@Kod_Penghutang, @Tahun, @Kod_Kump_Wang, @Kod_Operasi, @Kod_Projek, @Kod_PTJ, @Kod_Vot, " +
                                            "@Dr_1, @Cr_1, @Dr_2, @Cr_2, @Dr_3, @Cr_3, @Dr_4, @Cr_4, @Dr_5, @Cr_5, @Dr_6, @Cr_6, @Dr_7, @Cr_7, " +
                                            "@Dr_8, @Cr_8, @Dr_9, @Cr_9, @Dr_10, @Cr_10, @Dr_11, @Cr_11, @Dr_12, @Cr_12, @Dr_13, @Cr_13, @Status)";

                                        cmd.Connection = sqlConn;
                                        cmd.Parameters.AddWithValue("@Kod_Penghutang", parRujukan);
                                        cmd.Parameters.AddWithValue("@Tahun", tahun);
                                        cmd.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                                        cmd.Parameters.AddWithValue("@Kod_Operasi", parKO);
                                        cmd.Parameters.AddWithValue("@Kod_Projek", parKP);
                                        cmd.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                                        cmd.Parameters.AddWithValue("@Kod_Vot", parVot);
                                        cmd.Parameters.AddWithValue("@Dr_1", strDr1);
                                        cmd.Parameters.AddWithValue("@Cr_1", strCr1);
                                        cmd.Parameters.AddWithValue("@Dr_2", strDr2);
                                        cmd.Parameters.AddWithValue("@Cr_2", strCr2);
                                        cmd.Parameters.AddWithValue("@Dr_3", strDr3);
                                        cmd.Parameters.AddWithValue("@Cr_3", strCr3);
                                        cmd.Parameters.AddWithValue("@Dr_4", strDr4);
                                        cmd.Parameters.AddWithValue("@Cr_4", strCr4);
                                        cmd.Parameters.AddWithValue("@Dr_5", strDr5);
                                        cmd.Parameters.AddWithValue("@Cr_5", strCr5);
                                        cmd.Parameters.AddWithValue("@Dr_6", strDr6);
                                        cmd.Parameters.AddWithValue("@Cr_6", strCr6);
                                        cmd.Parameters.AddWithValue("@Dr_7", strDr7);
                                        cmd.Parameters.AddWithValue("@Cr_7", strCr7);
                                        cmd.Parameters.AddWithValue("@Dr_8", strDr8);
                                        cmd.Parameters.AddWithValue("@Cr_8", strCr8);
                                        cmd.Parameters.AddWithValue("@Dr_9", strDr9);
                                        cmd.Parameters.AddWithValue("@Cr_9", strCr9);
                                        cmd.Parameters.AddWithValue("@Dr_10", strDr10);
                                        cmd.Parameters.AddWithValue("@Cr_10", strCr10);
                                        cmd.Parameters.AddWithValue("@Dr_11", strDr11);
                                        cmd.Parameters.AddWithValue("@Cr_11", strCr11);
                                        cmd.Parameters.AddWithValue("@Dr_12", strDr12);
                                        cmd.Parameters.AddWithValue("@Cr_12", strCr12);
                                        cmd.Parameters.AddWithValue("@Dr_13", strDr13);
                                        cmd.Parameters.AddWithValue("@Cr_13", strCr13);
                                        cmd.Parameters.AddWithValue("@Status", strStatus);

                                        try
                                        {

                                            if (sqlConn.State != System.Data.ConnectionState.Open)
                                            {
                                                sqlConn.Open(); // Open the connection only if it's not already open
                                            }
                                            cmd.ExecuteNonQuery();
                                            ret[0] = "ok";
                                        }
                                        catch (SqlException e)
                                        {
                                            //ret[0] = e.Message.ToString();
                                            ret[0] = parMethod.ToString() + count.ToString();
                                        }

                                    }
                                }
                                break;
                            }
                            // Lajer Pemiutang --------------------------------------------------
                        case "AP":
                            string queryAP = "SELECT COUNT(*) FROM SMKB_Lejar_Pemiutang" +
                                "   WHERE Kod_Pemiutang = @Kod_Pemiutang" +
                                " AND Tahun = @Tahun" +
                                " AND Kod_Kump_Wang = @Kod_Kump_Wang" +
                                " AND Kod_Operasi = @Kod_Operasi" +
                                " AND Kod_Projek = @Kod_Projek" +
                                " AND Kod_PTJ = @Kod_PTJ" +
                                " AND Kod_Vot = @Kod_Vot";


                            if (sqlConn.State != System.Data.ConnectionState.Open)
                            {
                                sqlConn.Open(); // Open the connection only if it's not already open
                            }

                            using (SqlCommand command = new SqlCommand(queryAP, sqlConn))
                            {
                                // Add a parameter to the query for the value you want to check
                                command.Parameters.AddWithValue("@Kod_Pemiutang", parRujukan);
                                command.Parameters.AddWithValue("@Tahun", tahun);
                                command.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                                command.Parameters.AddWithValue("@Kod_Operasi", parKO);
                                command.Parameters.AddWithValue("@Kod_Projek", parKP);
                                command.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                                command.Parameters.AddWithValue("@Kod_Vot", parVot);

                                int count = (int)command.ExecuteScalar();

                                if (count > 0)
                                {
                                    //Console.WriteLine("Data exists in the table.");
                                    //ret[0] = query.ToString();
                                    //ret[0] = "Data exists in the table.";
                                    using (SqlCommand cmd = new SqlCommand())
                                    {
                                        //Console.WriteLine("Data does not exist in the table.");
                                        cmd.CommandText = "UPDATE SMKB_Lejar_Pemiutang" +
                                            " SET Dr_1 = Dr_1 + @Dr_1, Cr_1 = Cr_1 + @Cr_1, Dr_2 = Dr_2 + @Dr_2, Cr_2 = Cr_2 + @Cr_2," +
                                            " Dr_3 = Dr_3 + @Dr_3, Cr_3 = Cr_3 + @Cr_3, Dr_4 = Dr_4 + @Dr_4, Cr_4 = Cr_4 + @Cr_4," +
                                            " Dr_5 = Dr_5 + @Dr_5, Cr_5 = Cr_5 + @Cr_5, Dr_6 = Dr_6 + @Dr_6, Cr_6 = Cr_6 + @Cr_6," +
                                            " Dr_7 = Dr_7 + @Dr_7, Cr_7 = Cr_7 + @Cr_7, Dr_8 = Dr_8 + @Dr_8, Cr_8 = Cr_8 + @Cr_8," +
                                            " Dr_9 = Dr_9 + @Dr_9, Cr_9 = Cr_9 + @Cr_9, Dr_10 = Dr_10 + @Dr_10, Cr_10 = Cr_10 + @Cr_10," +
                                            " Dr_11 = Dr_11 + @Dr_11, Cr_11 = Cr_11 + @Cr_11, Dr_12 = Dr_12 + @Dr_12, Cr_12 = Cr_12 + @Cr_12" +
                                            " WHERE Kod_Pemiutang = @Kod_Pemiutang" +
                                            " AND Tahun = @Tahun" +
                                            " AND Kod_Kump_Wang = @Kod_Kump_Wang" +
                                            " AND Kod_Operasi = @Kod_Operasi" +
                                            " AND Kod_Projek = @Kod_Projek" +
                                            " AND Kod_PTJ = @Kod_PTJ" +
                                            " AND Kod_Vot = @Kod_Vot";

                                        cmd.Connection = sqlConn;
                                        cmd.Parameters.AddWithValue("@Kod_Pemiutang", parRujukan);
                                        cmd.Parameters.AddWithValue("@Tahun", tahun);
                                        cmd.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                                        cmd.Parameters.AddWithValue("@Kod_Operasi", parKO);
                                        cmd.Parameters.AddWithValue("@Kod_Projek", parKP);
                                        cmd.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                                        cmd.Parameters.AddWithValue("@Kod_Vot", parVot);
                                        cmd.Parameters.AddWithValue("@Dr_1", strDr1);
                                        cmd.Parameters.AddWithValue("@Cr_1", strCr1);
                                        cmd.Parameters.AddWithValue("@Dr_2", strDr2);
                                        cmd.Parameters.AddWithValue("@Cr_2", strCr2);
                                        cmd.Parameters.AddWithValue("@Dr_3", strDr3);
                                        cmd.Parameters.AddWithValue("@Cr_3", strCr3);
                                        cmd.Parameters.AddWithValue("@Dr_4", strDr4);
                                        cmd.Parameters.AddWithValue("@Cr_4", strCr4);
                                        cmd.Parameters.AddWithValue("@Dr_5", strDr5);
                                        cmd.Parameters.AddWithValue("@Cr_5", strCr5);
                                        cmd.Parameters.AddWithValue("@Dr_6", strDr6);
                                        cmd.Parameters.AddWithValue("@Cr_6", strCr6);
                                        cmd.Parameters.AddWithValue("@Dr_7", strDr7);
                                        cmd.Parameters.AddWithValue("@Cr_7", strCr7);
                                        cmd.Parameters.AddWithValue("@Dr_8", strDr8);
                                        cmd.Parameters.AddWithValue("@Cr_8", strCr8);
                                        cmd.Parameters.AddWithValue("@Dr_9", strDr9);
                                        cmd.Parameters.AddWithValue("@Cr_9", strCr9);
                                        cmd.Parameters.AddWithValue("@Dr_10", strDr10);
                                        cmd.Parameters.AddWithValue("@Cr_10", strCr10);
                                        cmd.Parameters.AddWithValue("@Dr_11", strDr11);
                                        cmd.Parameters.AddWithValue("@Cr_11", strCr11);
                                        cmd.Parameters.AddWithValue("@Dr_12", strDr12);
                                        cmd.Parameters.AddWithValue("@Cr_12", strCr12);
                                        cmd.Parameters.AddWithValue("@Status", strStatus);

                                        try
                                        {

                                            if (sqlConn.State != System.Data.ConnectionState.Open)
                                            {
                                                sqlConn.Open(); // Open the connection only if it's not already open
                                            }
                                            cmd.ExecuteNonQuery();
                                            ret[0] = "ok";
                                        }
                                        catch (SqlException e)
                                        {
                                            //ret[0] = e.Message.ToString();
                                            ret[0] = parMethod.ToString() + count.ToString();
                                        }

                                    }

                                }
                                else
                                {
                                    //ret[0] = query.ToString();
                                    //ret[0] = "Data does not exist in the table.";

                                    using (SqlCommand cmd = new SqlCommand())
                                    {
                                        //Console.WriteLine("Data does not exist in the table.");
                                        cmd.CommandText = @"INSERT INTO SMKB_Lejar_Pemiutang" +
                                            "(Kod_Pemiutang, Tahun, Kod_Kump_Wang, Kod_Operasi, Kod_Projek, Kod_PTJ, Kod_Vot, " +
                                            "Dr_1, Cr_1, Dr_2, Cr_2, Dr_3, Cr_3, Dr_4, Cr_4, Dr_5, Cr_5, Dr_6, Cr_6, " +
                                            "Dr_7, Cr_7, Dr_8, Cr_8, Dr_9, Cr_9, Dr_10, Cr_10, Dr_11, Cr_11, Dr_12, " +
                                            "Cr_12, Dr_13, Cr_13, Status) " +
                                            "VALUES (@Kod_Pemiutang, @Tahun, @Kod_Kump_Wang, @Kod_Operasi, @Kod_Projek, @Kod_PTJ, @Kod_Vot, " +
                                            "@Dr_1, @Cr_1, @Dr_2, @Cr_2, @Dr_3, @Cr_3, @Dr_4, @Cr_4, @Dr_5, @Cr_5, @Dr_6, @Cr_6, @Dr_7, @Cr_7, " +
                                            "@Dr_8, @Cr_8, @Dr_9, @Cr_9, @Dr_10, @Cr_10, @Dr_11, @Cr_11, @Dr_12, @Cr_12, @Dr_13, @Cr_13, @Status)";

                                        cmd.Connection = sqlConn;
                                        cmd.Parameters.AddWithValue("@Kod_Pemiutang", parRujukan);
                                        cmd.Parameters.AddWithValue("@Tahun", tahun);
                                        cmd.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                                        cmd.Parameters.AddWithValue("@Kod_Operasi", parKO);
                                        cmd.Parameters.AddWithValue("@Kod_Projek", parKP);
                                        cmd.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                                        cmd.Parameters.AddWithValue("@Kod_Vot", parVot);
                                        cmd.Parameters.AddWithValue("@Dr_1", strDr1);
                                        cmd.Parameters.AddWithValue("@Cr_1", strCr1);
                                        cmd.Parameters.AddWithValue("@Dr_2", strDr2);
                                        cmd.Parameters.AddWithValue("@Cr_2", strCr2);
                                        cmd.Parameters.AddWithValue("@Dr_3", strDr3);
                                        cmd.Parameters.AddWithValue("@Cr_3", strCr3);
                                        cmd.Parameters.AddWithValue("@Dr_4", strDr4);
                                        cmd.Parameters.AddWithValue("@Cr_4", strCr4);
                                        cmd.Parameters.AddWithValue("@Dr_5", strDr5);
                                        cmd.Parameters.AddWithValue("@Cr_5", strCr5);
                                        cmd.Parameters.AddWithValue("@Dr_6", strDr6);
                                        cmd.Parameters.AddWithValue("@Cr_6", strCr6);
                                        cmd.Parameters.AddWithValue("@Dr_7", strDr7);
                                        cmd.Parameters.AddWithValue("@Cr_7", strCr7);
                                        cmd.Parameters.AddWithValue("@Dr_8", strDr8);
                                        cmd.Parameters.AddWithValue("@Cr_8", strCr8);
                                        cmd.Parameters.AddWithValue("@Dr_9", strDr9);
                                        cmd.Parameters.AddWithValue("@Cr_9", strCr9);
                                        cmd.Parameters.AddWithValue("@Dr_10", strDr10);
                                        cmd.Parameters.AddWithValue("@Cr_10", strCr10);
                                        cmd.Parameters.AddWithValue("@Dr_11", strDr11);
                                        cmd.Parameters.AddWithValue("@Cr_11", strCr11);
                                        cmd.Parameters.AddWithValue("@Dr_12", strDr12);
                                        cmd.Parameters.AddWithValue("@Cr_12", strCr12);
                                        cmd.Parameters.AddWithValue("@Dr_13", strDr13);
                                        cmd.Parameters.AddWithValue("@Cr_13", strCr13);
                                        cmd.Parameters.AddWithValue("@Status", strStatus);

                                        try
                                        {

                                            if (sqlConn.State != System.Data.ConnectionState.Open)
                                            {
                                                sqlConn.Open(); // Open the connection only if it's not already open
                                            }
                                            cmd.ExecuteNonQuery();
                                            ret[0] = "ok";
                                        }
                                        catch (SqlException e)
                                        {
                                            //ret[0] = e.Message.ToString();
                                            ret[0] = parMethod.ToString() + count.ToString();
                                        }

                                    }
                                }
                                break;
                            }
                        // end Lajer Pemiutang

                        case "GL":
                            string queryGL = "SELECT COUNT(*) FROM SMKB_Lejar_Am" +
                                "   WHERE Kod_Syarikat = @Kod_Syarikat" +
                                " AND Tahun = @Tahun" +
                                " AND Kod_Kump_Wang = @Kod_Kump_Wang" +
                                " AND Kod_Operasi = @Kod_Operasi" +
                                " AND Kod_Projek = @Kod_Projek" +
                                " AND Kod_PTJ = @Kod_PTJ" +
                                " AND Kod_Vot = @Kod_Vot";


                            if (sqlConn.State != System.Data.ConnectionState.Open)
                            {
                                sqlConn.Open(); // Open the connection only if it's not already open
                            }

                            using (SqlCommand command = new SqlCommand(queryGL, sqlConn))
                            {
                                // Add a parameter to the query for the value you want to check
                                command.Parameters.AddWithValue("@Kod_Syarikat", parRujukan);
                                command.Parameters.AddWithValue("@Tahun", tahun);
                                command.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                                command.Parameters.AddWithValue("@Kod_Operasi", parKO);
                                command.Parameters.AddWithValue("@Kod_Projek", parKP);
                                command.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                                command.Parameters.AddWithValue("@Kod_Vot", parVot);

                                int count = (int)command.ExecuteScalar();

                                if (count > 0)
                                {
                                    //Console.WriteLine("Data exists in the table.");
                                    //ret[0] = query.ToString();
                                    //ret[0] = "Data exists in the table.";
                                    using (SqlCommand cmd = new SqlCommand())
                                    {
                                        //Console.WriteLine("Data does not exist in the table.");
                                        cmd.CommandText = "UPDATE SMKB_Lejar_Am" +
                                            " SET Dr_1 = Dr_1 + @Dr_1, Cr_1 = Cr_1 + @Cr_1, Dr_2 = Dr_2 + @Dr_2, Cr_2 = Cr_2 + @Cr_2," +
                                            " Dr_3 = Dr_3 + @Dr_3, Cr_3 = Cr_3 + @Cr_3, Dr_4 = Dr_4 + @Dr_4, Cr_4 = Cr_4 + @Cr_4," +
                                            " Dr_5 = Dr_5 + @Dr_5, Cr_5 = Cr_5 + @Cr_5, Dr_6 = Dr_6 + @Dr_6, Cr_6 = Cr_6 + @Cr_6," +
                                            " Dr_7 = Dr_7 + @Dr_7, Cr_7 = Cr_7 + @Cr_7, Dr_8 = Dr_8 + @Dr_8, Cr_8 = Cr_8 + @Cr_8," +
                                            " Dr_9 = Dr_9 + @Dr_9, Cr_9 = Cr_9 + @Cr_9, Dr_10 = Dr_10 + @Dr_10, Cr_10 = Cr_10 + @Cr_10," +
                                            " Dr_11 = Dr_11 + @Dr_11, Cr_11 = Cr_11 + @Cr_11, Dr_12 = Dr_12 + @Dr_12, Cr_12 = Cr_12 + @Cr_12" +
                                            " WHERE Kod_Syarikat = @Kod_Syarikat" +
                                            " AND Tahun = @Tahun" +
                                            " AND Kod_Kump_Wang = @Kod_Kump_Wang" +
                                            " AND Kod_Operasi = @Kod_Operasi" +
                                            " AND Kod_Projek = @Kod_Projek" +
                                            " AND Kod_PTJ = @Kod_PTJ" +
                                            " AND Kod_Vot = @Kod_Vot";

                                        cmd.Connection = sqlConn;
                                        cmd.Parameters.AddWithValue("@Kod_Syarikat", parRujukan);
                                        cmd.Parameters.AddWithValue("@Tahun", tahun);
                                        cmd.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                                        cmd.Parameters.AddWithValue("@Kod_Operasi", parKO);
                                        cmd.Parameters.AddWithValue("@Kod_Projek", parKP);
                                        cmd.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                                        cmd.Parameters.AddWithValue("@Kod_Vot", parVot);
                                        cmd.Parameters.AddWithValue("@Dr_1", strDr1);
                                        cmd.Parameters.AddWithValue("@Cr_1", strCr1);
                                        cmd.Parameters.AddWithValue("@Dr_2", strDr2);
                                        cmd.Parameters.AddWithValue("@Cr_2", strCr2);
                                        cmd.Parameters.AddWithValue("@Dr_3", strDr3);
                                        cmd.Parameters.AddWithValue("@Cr_3", strCr3);
                                        cmd.Parameters.AddWithValue("@Dr_4", strDr4);
                                        cmd.Parameters.AddWithValue("@Cr_4", strCr4);
                                        cmd.Parameters.AddWithValue("@Dr_5", strDr5);
                                        cmd.Parameters.AddWithValue("@Cr_5", strCr5);
                                        cmd.Parameters.AddWithValue("@Dr_6", strDr6);
                                        cmd.Parameters.AddWithValue("@Cr_6", strCr6);
                                        cmd.Parameters.AddWithValue("@Dr_7", strDr7);
                                        cmd.Parameters.AddWithValue("@Cr_7", strCr7);
                                        cmd.Parameters.AddWithValue("@Dr_8", strDr8);
                                        cmd.Parameters.AddWithValue("@Cr_8", strCr8);
                                        cmd.Parameters.AddWithValue("@Dr_9", strDr9);
                                        cmd.Parameters.AddWithValue("@Cr_9", strCr9);
                                        cmd.Parameters.AddWithValue("@Dr_10", strDr10);
                                        cmd.Parameters.AddWithValue("@Cr_10", strCr10);
                                        cmd.Parameters.AddWithValue("@Dr_11", strDr11);
                                        cmd.Parameters.AddWithValue("@Cr_11", strCr11);
                                        cmd.Parameters.AddWithValue("@Dr_12", strDr12);
                                        cmd.Parameters.AddWithValue("@Cr_12", strCr12);
                                        cmd.Parameters.AddWithValue("@Status", strStatus);

                                        try
                                        {

                                            if (sqlConn.State != System.Data.ConnectionState.Open)
                                            {
                                                sqlConn.Open(); // Open the connection only if it's not already open
                                            }
                                            cmd.ExecuteNonQuery();
                                            ret[0] = "ok";
                                        }
                                        catch (SqlException e)
                                        {
                                            //ret[0] = e.Message.ToString();
                                            ret[0] = parMethod.ToString() + count.ToString();
                                        }

                                    }

                                }
                                else
                                {
                                    //ret[0] = query.ToString();
                                    //ret[0] = "Data does not exist in the table.";

                                    using (SqlCommand cmd = new SqlCommand())
                                    {
                                        //Console.WriteLine("Data does not exist in the table.");
                                        cmd.CommandText = @"INSERT INTO SMKB_Lejar_Am" +
                                            "(Kod_Syarikat, Tahun, Kod_Kump_Wang, Kod_Operasi, Kod_Projek, Kod_PTJ, Kod_Vot, " +
                                            "Dr_1, Cr_1, Dr_2, Cr_2, Dr_3, Cr_3, Dr_4, Cr_4, Dr_5, Cr_5, Dr_6, Cr_6, " +
                                            "Dr_7, Cr_7, Dr_8, Cr_8, Dr_9, Cr_9, Dr_10, Cr_10, Dr_11, Cr_11, Dr_12, " +
                                            "Cr_12, Dr_13, Cr_13, Status) " +
                                            "VALUES (@Kod_Syarikat, @Tahun, @Kod_Kump_Wang, @Kod_Operasi, @Kod_Projek, @Kod_PTJ, @Kod_Vot, " +
                                            "@Dr_1, @Cr_1, @Dr_2, @Cr_2, @Dr_3, @Cr_3, @Dr_4, @Cr_4, @Dr_5, @Cr_5, @Dr_6, @Cr_6, @Dr_7, @Cr_7, " +
                                            "@Dr_8, @Cr_8, @Dr_9, @Cr_9, @Dr_10, @Cr_10, @Dr_11, @Cr_11, @Dr_12, @Cr_12, @Dr_13, @Cr_13, @Status)";

                                        cmd.Connection = sqlConn;
                                        cmd.Parameters.AddWithValue("@Kod_Syarikat", parRujukan);
                                        cmd.Parameters.AddWithValue("@Tahun", tahun);
                                        cmd.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                                        cmd.Parameters.AddWithValue("@Kod_Operasi", parKO);
                                        cmd.Parameters.AddWithValue("@Kod_Projek", parKP);
                                        cmd.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                                        cmd.Parameters.AddWithValue("@Kod_Vot", parVot);
                                        cmd.Parameters.AddWithValue("@Dr_1", strDr1);
                                        cmd.Parameters.AddWithValue("@Cr_1", strCr1);
                                        cmd.Parameters.AddWithValue("@Dr_2", strDr2);
                                        cmd.Parameters.AddWithValue("@Cr_2", strCr2);
                                        cmd.Parameters.AddWithValue("@Dr_3", strDr3);
                                        cmd.Parameters.AddWithValue("@Cr_3", strCr3);
                                        cmd.Parameters.AddWithValue("@Dr_4", strDr4);
                                        cmd.Parameters.AddWithValue("@Cr_4", strCr4);
                                        cmd.Parameters.AddWithValue("@Dr_5", strDr5);
                                        cmd.Parameters.AddWithValue("@Cr_5", strCr5);
                                        cmd.Parameters.AddWithValue("@Dr_6", strDr6);
                                        cmd.Parameters.AddWithValue("@Cr_6", strCr6);
                                        cmd.Parameters.AddWithValue("@Dr_7", strDr7);
                                        cmd.Parameters.AddWithValue("@Cr_7", strCr7);
                                        cmd.Parameters.AddWithValue("@Dr_8", strDr8);
                                        cmd.Parameters.AddWithValue("@Cr_8", strCr8);
                                        cmd.Parameters.AddWithValue("@Dr_9", strDr9);
                                        cmd.Parameters.AddWithValue("@Cr_9", strCr9);
                                        cmd.Parameters.AddWithValue("@Dr_10", strDr10);
                                        cmd.Parameters.AddWithValue("@Cr_10", strCr10);
                                        cmd.Parameters.AddWithValue("@Dr_11", strDr11);
                                        cmd.Parameters.AddWithValue("@Cr_11", strCr11);
                                        cmd.Parameters.AddWithValue("@Dr_12", strDr12);
                                        cmd.Parameters.AddWithValue("@Cr_12", strCr12);
                                        cmd.Parameters.AddWithValue("@Dr_13", strDr13);
                                        cmd.Parameters.AddWithValue("@Cr_13", strCr13);
                                        cmd.Parameters.AddWithValue("@Status", strStatus);

                                        try
                                        {

                                            if (sqlConn.State != System.Data.ConnectionState.Open)
                                            {
                                                sqlConn.Open(); // Open the connection only if it's not already open
                                            }
                                            cmd.ExecuteNonQuery();
                                            ret[0] = "ok";
                                        }
                                        catch (SqlException e)
                                        {
                                            //ret[0] = e.Message.ToString();
                                            ret[0] = parMethod.ToString() + count.ToString();
                                        }

                                    }
                                }
                                break;
                            }
                        // Lajer AM
                        //case "BANK":
                        //    string queryBANK = "SELECT COUNT(*) FROM SMKB_Lejar_Bank" +
                        //        "   WHERE Kod_Bank = @Kod_Bank" +
                        //        " AND Tahun = @Tahun" +
                        //        " AND Kod_Kump_Wang = @Kod_Kump_Wang" +
                        //        " AND Kod_Operasi = @Kod_Operasi" +
                        //        " AND Kod_Projek = @Kod_Projek" +
                        //        " AND Kod_PTJ = @Kod_PTJ" +
                        //        " AND Kod_Vot = @Kod_Vot";


                        //    if (sqlConn.State != System.Data.ConnectionState.Open)
                        //    {
                        //        sqlConn.Open(); // Open the connection only if it's not already open
                        //    }

                        //    using (SqlCommand command = new SqlCommand(queryBANK, sqlConn))
                        //    {
                        //        // Add a parameter to the query for the value you want to check
                        //        command.Parameters.AddWithValue("@Kod_Bank", parRujukan);
                        //        command.Parameters.AddWithValue("@Tahun", tahun);
                        //        command.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                        //        command.Parameters.AddWithValue("@Kod_Operasi", parKO);
                        //        command.Parameters.AddWithValue("@Kod_Projek", parKP);
                        //        command.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                        //        command.Parameters.AddWithValue("@Kod_Vot", parVot);

                        //        int count = (int)command.ExecuteScalar();

                        //        if (count > 0)
                        //        {
                        //            //Console.WriteLine("Data exists in the table.");
                        //            //ret[0] = query.ToString();
                        //            //ret[0] = "Data exists in the table.";
                        //            using (SqlCommand cmd = new SqlCommand())
                        //            {
                        //                //Console.WriteLine("Data does not exist in the table.");
                        //                cmd.CommandText = "UPDATE SMKB_Lejar_Bank" +
                        //                    " SET Dr_1 = Dr_1 + @Dr_1, Cr_1 = Cr_1 + @Cr_1, Dr_2 = Dr_2 + @Dr_2, Cr_2 = Cr_2 + @Cr_2," +
                        //                    " Dr_3 = Dr_3 + @Dr_3, Cr_3 = Cr_3 + @Cr_3, Dr_4 = Dr_4 + @Dr_4, Cr_4 = Cr_4 + @Cr_4," +
                        //                    " Dr_5 = Dr_5 + @Dr_5, Cr_5 = Cr_5 + @Cr_5, Dr_6 = Dr_6 + @Dr_6, Cr_6 = Cr_6 + @Cr_6," +
                        //                    " Dr_7 = Dr_7 + @Dr_7, Cr_7 = Cr_7 + @Cr_7, Dr_8 = Dr_8 + @Dr_8, Cr_8 = Cr_8 + @Cr_8," +
                        //                    " Dr_9 = Dr_9 + @Dr_9, Cr_9 = Cr_9 + @Cr_9, Dr_10 = Dr_10 + @Dr_10, Cr_10 = Cr_10 + @Cr_10," +
                        //                    " Dr_11 = Dr_11 + @Dr_11, Cr_11 = Cr_11 + @Cr_11, Dr_12 = Dr_12 + @Dr_12, Cr_12 = Cr_12 + @Cr_12" +
                        //                    " WHERE Kod_Bank = @Kod_Bank" +
                        //                    " AND Tahun = @Tahun" +
                        //                    " AND Kod_Kump_Wang = @Kod_Kump_Wang" +
                        //                    " AND Kod_Operasi = @Kod_Operasi" +
                        //                    " AND Kod_Projek = @Kod_Projek" +
                        //                    " AND Kod_PTJ = @Kod_PTJ" +
                        //                    " AND Kod_Vot = @Kod_Vot";

                        //                cmd.Connection = sqlConn;
                        //                cmd.Parameters.AddWithValue("@Kod_Bank", parRujukan);
                        //                cmd.Parameters.AddWithValue("@Tahun", tahun);
                        //                cmd.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                        //                cmd.Parameters.AddWithValue("@Kod_Operasi", parKO);
                        //                cmd.Parameters.AddWithValue("@Kod_Projek", parKP);
                        //                cmd.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                        //                cmd.Parameters.AddWithValue("@Kod_Vot", parVot);
                        //                cmd.Parameters.AddWithValue("@Dr_1", strDr1);
                        //                cmd.Parameters.AddWithValue("@Cr_1", strCr1);
                        //                cmd.Parameters.AddWithValue("@Dr_2", strDr2);
                        //                cmd.Parameters.AddWithValue("@Cr_2", strCr2);
                        //                cmd.Parameters.AddWithValue("@Dr_3", strDr3);
                        //                cmd.Parameters.AddWithValue("@Cr_3", strCr3);
                        //                cmd.Parameters.AddWithValue("@Dr_4", strDr4);
                        //                cmd.Parameters.AddWithValue("@Cr_4", strCr4);
                        //                cmd.Parameters.AddWithValue("@Dr_5", strDr5);
                        //                cmd.Parameters.AddWithValue("@Cr_5", strCr5);
                        //                cmd.Parameters.AddWithValue("@Dr_6", strDr6);
                        //                cmd.Parameters.AddWithValue("@Cr_6", strCr6);
                        //                cmd.Parameters.AddWithValue("@Dr_7", strDr7);
                        //                cmd.Parameters.AddWithValue("@Cr_7", strCr7);
                        //                cmd.Parameters.AddWithValue("@Dr_8", strDr8);
                        //                cmd.Parameters.AddWithValue("@Cr_8", strCr8);
                        //                cmd.Parameters.AddWithValue("@Dr_9", strDr9);
                        //                cmd.Parameters.AddWithValue("@Cr_9", strCr9);
                        //                cmd.Parameters.AddWithValue("@Dr_10", strDr10);
                        //                cmd.Parameters.AddWithValue("@Cr_10", strCr10);
                        //                cmd.Parameters.AddWithValue("@Dr_11", strDr11);
                        //                cmd.Parameters.AddWithValue("@Cr_11", strCr11);
                        //                cmd.Parameters.AddWithValue("@Dr_12", strDr12);
                        //                cmd.Parameters.AddWithValue("@Cr_12", strCr12);
                        //                cmd.Parameters.AddWithValue("@Status", strStatus);

                        //                try
                        //                {

                        //                    if (sqlConn.State != System.Data.ConnectionState.Open)
                        //                    {
                        //                        sqlConn.Open(); // Open the connection only if it's not already open
                        //                    }
                        //                    cmd.ExecuteNonQuery();
                        //                    ret[0] = "ok";
                        //                }
                        //                catch (SqlException e)
                        //                {
                        //                    //ret[0] = e.Message.ToString();
                        //                    ret[0] = parMethod.ToString() + count.ToString();
                        //                }

                        //            }

                        //        }
                        //        else
                        //        {
                        //            //ret[0] = query.ToString();
                        //            //ret[0] = "Data does not exist in the table.";

                        //            using (SqlCommand cmd = new SqlCommand())
                        //            {
                        //                //Console.WriteLine("Data does not exist in the table.");
                        //                cmd.CommandText = @"INSERT INTO SMKB_Lejar_Bank" +
                        //                    "(Kod_Bank, Tahun, Kod_Kump_Wang, Kod_Operasi, Kod_Projek, Kod_PTJ, Kod_Vot, " +
                        //                    "Dr_1, Cr_1, Dr_2, Cr_2, Dr_3, Cr_3, Dr_4, Cr_4, Dr_5, Cr_5, Dr_6, Cr_6, " +
                        //                    "Dr_7, Cr_7, Dr_8, Cr_8, Dr_9, Cr_9, Dr_10, Cr_10, Dr_11, Cr_11, Dr_12, " +
                        //                    "Cr_12, Dr_13, Cr_13, Status) " +
                        //                    "VALUES (@Kod_Bank, @Tahun, @Kod_Kump_Wang, @Kod_Operasi, @Kod_Projek, @Kod_PTJ, @Kod_Vot, " +
                        //                    "@Dr_1, @Cr_1, @Dr_2, @Cr_2, @Dr_3, @Cr_3, @Dr_4, @Cr_4, @Dr_5, @Cr_5, @Dr_6, @Cr_6, @Dr_7, @Cr_7, " +
                        //                    "@Dr_8, @Cr_8, @Dr_9, @Cr_9, @Dr_10, @Cr_10, @Dr_11, @Cr_11, @Dr_12, @Cr_12, @Dr_13, @Cr_13, @Status)";

                        //                cmd.Connection = sqlConn;
                        //                cmd.Parameters.AddWithValue("@Kod_Bank", parRujukan);
                        //                cmd.Parameters.AddWithValue("@Tahun", tahun);
                        //                cmd.Parameters.AddWithValue("@Kod_Kump_Wang", parKW);
                        //                cmd.Parameters.AddWithValue("@Kod_Operasi", parKO);
                        //                cmd.Parameters.AddWithValue("@Kod_Projek", parKP);
                        //                cmd.Parameters.AddWithValue("@Kod_PTJ", parPTj);
                        //                cmd.Parameters.AddWithValue("@Kod_Vot", parVot);
                        //                cmd.Parameters.AddWithValue("@Dr_1", strDr1);
                        //                cmd.Parameters.AddWithValue("@Cr_1", strCr1);
                        //                cmd.Parameters.AddWithValue("@Dr_2", strDr2);
                        //                cmd.Parameters.AddWithValue("@Cr_2", strCr2);
                        //                cmd.Parameters.AddWithValue("@Dr_3", strDr3);
                        //                cmd.Parameters.AddWithValue("@Cr_3", strCr3);
                        //                cmd.Parameters.AddWithValue("@Dr_4", strDr4);
                        //                cmd.Parameters.AddWithValue("@Cr_4", strCr4);
                        //                cmd.Parameters.AddWithValue("@Dr_5", strDr5);
                        //                cmd.Parameters.AddWithValue("@Cr_5", strCr5);
                        //                cmd.Parameters.AddWithValue("@Dr_6", strDr6);
                        //                cmd.Parameters.AddWithValue("@Cr_6", strCr6);
                        //                cmd.Parameters.AddWithValue("@Dr_7", strDr7);
                        //                cmd.Parameters.AddWithValue("@Cr_7", strCr7);
                        //                cmd.Parameters.AddWithValue("@Dr_8", strDr8);
                        //                cmd.Parameters.AddWithValue("@Cr_8", strCr8);
                        //                cmd.Parameters.AddWithValue("@Dr_9", strDr9);
                        //                cmd.Parameters.AddWithValue("@Cr_9", strCr9);
                        //                cmd.Parameters.AddWithValue("@Dr_10", strDr10);
                        //                cmd.Parameters.AddWithValue("@Cr_10", strCr10);
                        //                cmd.Parameters.AddWithValue("@Dr_11", strDr11);
                        //                cmd.Parameters.AddWithValue("@Cr_11", strCr11);
                        //                cmd.Parameters.AddWithValue("@Dr_12", strDr12);
                        //                cmd.Parameters.AddWithValue("@Cr_12", strCr12);
                        //                cmd.Parameters.AddWithValue("@Dr_13", strDr13);
                        //                cmd.Parameters.AddWithValue("@Cr_13", strCr13);
                        //                cmd.Parameters.AddWithValue("@Status", strStatus);

                        //                try
                        //                {

                        //                    if (sqlConn.State != System.Data.ConnectionState.Open)
                        //                    {
                        //                        sqlConn.Open(); // Open the connection only if it's not already open
                        //                    }
                        //                    cmd.ExecuteNonQuery();
                        //                    ret[0] = "ok";
                        //                }
                        //                catch (SqlException e)
                        //                {
                        //                    //ret[0] = e.Message.ToString();
                        //                    ret[0] = parMethod.ToString() + count.ToString();
                        //                }

                        //            }
                        //        }
                        //        break;
                        //    }
                            // Lajer AM
                    }


                }
            }
            catch (Exception ex)
            {
                ret[0] = ex.Message.ToString();
            }

            return ret;
        }


        public static IEnumerable<string> PostTransBank(string parKodBank, DateTime parTkhTrans, string parRujukan, string parRujukanLain, 
                Double parAmaun, string parDrCr)
        {
            string[] ret = new string[1];
            ret[0] = "no";
            try
            {
                Double strDr = 0;
                Double strCr = 0;

                switch (parDrCr)
                {
                    case "DR":
                        strDr = parAmaun;
                        break;
                    case "CR":
                        strCr = parAmaun;
                        break;
                }

                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {

                        cmd.CommandText = @"INSERT INTO SMKB_Transaksi_Bank ( Kod_Bank, Tarikh_Transaksi, Amaun_Dr, Amaun_Dr, No_Rujukan, No_Rujukan_Lain) values ( @data1,@data2,@data3,@data4,@data5,@data6)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@data1", parKodBank);
                        cmd.Parameters.AddWithValue("@data2", parTkhTrans);
                        cmd.Parameters.AddWithValue("@data3", strDr);
                        cmd.Parameters.AddWithValue("@data4", strCr);
                        cmd.Parameters.AddWithValue("@data5", parRujukan);
                        cmd.Parameters.AddWithValue("@data6", parRujukanLain);

                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            ret[0] = "ok";
                        }
                        catch (SqlException e)
                        {
                            ret[0] = e.Message.ToString();
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = ex.Message.ToString();
            }

            return ret;
        }




            public static IEnumerable<string> SimpanData(string data1, string data2)
        {
            string[] ret = new string[1];
            ret[0] = "no";
            try
            {

                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_developer))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {

                        cmd.CommandText = @"INSERT INTO smkb01_data ( [data1], [data2] ) values ( @data1,@data2)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@data1", data1);
                        cmd.Parameters.AddWithValue("@data2", data2);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            ret[0] = "ok";
                        }
                        catch (SqlException e)
                        {
                            ret[0] = e.Message.ToString();
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = ex.Message.ToString();
            }

            return ret;
        }



        public static IEnumerable<string> SimpanDataAdaGambar(string data1, string data2)
        {
            string[] ret = new string[1];
            ret[0] = "no";
            try
            {

                using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_developer))
                {
                    using (SqlCommand cmd = new SqlCommand())
                    {

                        cmd.CommandText = @"INSERT INTO    smkb01_data ( data1, data2 ) values ( @data1,@data2)";
                        cmd.Connection = sqlConn;
                        cmd.Parameters.AddWithValue("@data1", data1);
                        cmd.Parameters.AddWithValue("@data2", data2);
                        try
                        {
                            sqlConn.Open();
                            cmd.ExecuteNonQuery();
                            ret[0] = "ok";
                        }
                        catch (SqlException e)
                        {
                            ret[0] = e.Message.ToString();
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                ret[0] = ex.Message.ToString();
            }

            return ret;
        }

        public static IEnumerable<string> getLejarResit()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"
                select tblA.IDPenerima, tblA.kodPembayar, tblA.tahun, tblA.KodKw, 
                CASE 
                       WHEN tblA.KodPTJ LIKE 'k%' THEN (select PTJProjek from MK_PTJ where KodPTJ = tblA.KodPTJ) 
                       ELSE tblA.KodPTJ 
                   END AS KodPTJ,
                tblA.KodVot, tblA.KP, tblA.KO, TBLA.MK06_Debit, tblA.MK06_Kredit, month(tbla.MK06_TkhTran) as bulan
                from 
                (
                    select 
                        (select x.RC03_KodPembayar from RC03_MaklPembayar as x
                        where x.RC01_NoResit = SUBSTRING(a.MK06_Rujukan,1,12)) as IDPenerima,
                        (select x.KodPembayar from RC03_MaklPembayar as x
                        where x.RC01_NoResit = SUBSTRING(a.MK06_Rujukan,1,12)) as kodPembayar,
                        year(a.MK06_TkhTran) as tahun, a.KodKw,a.KodPTJ, a.KodVot, 
                        CASE 
                               WHEN a.KodPTJ LIKE 'k%' THEN a.KodPTJ
                               ELSE '0000000'
                           END AS KP,    
                        '00' as KO, a.MK06_Debit, a.MK06_Kredit, a.MK06_TkhTran
                        from MK06_Transaksi as a
                        where a.KodDok = 'RESIT'
                        AND year(a.MK06_TkhTran) in(YEAR(GETDATE()), YEAR(GETDATE())-1, YEAR(GETDATE())-2, YEAR(GETDATE())-3, YEAR(GETDATE())-4, YEAR(GETDATE())-5)
						AND a.KodVot LIKE '71%'
                ) as tblA 
                where tblA.IDPenerima is not null
                and tblA.IDPenerima <> ''
				and tblA.kodPembayar <> 'OA'
                order by tbla.MK06_TkhTran DESC";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;
                int rekodXBerjaya = 0;

                while (rdr.Read())
                {
                    //string kodPenghutang = getKodPenghutang("01662");
                    string kodPenghutang = getKodPenghutang(rdr["IDPenerima"].ToString()).ToString();

                    IEnumerable<string> task =  PostingLejar("AR", kodPenghutang, rdr["KodKw"].ToString(), rdr["KodPTJ"].ToString(), rdr["KodVot"].ToString(), rdr["KO"].ToString(),
                      rdr["KP"].ToString(), double.Parse(rdr["MK06_Kredit"].ToString()), "CR", rdr["bulan"].ToString(), rdr["tahun"].ToString());

                    //IEnumerable<string> task = PostingLejar("AR", kodPenghutang, "01", "430000", "29104", "00", "000000", 290.50, "CR", "5", "2023");

                    var myListx = task.ToList();
                    //listOfResults += kodPenghutang.ToString() + " - " + rdr["KP"].ToString();

                    if (myListx[0] == "no")
                    {
                        rekodXBerjaya++;
                        //listOfResults += "no posting <br/> ";
                    }
                    else
                    {
                        rekodBerjaya++;
                        //listOfResults += "ok posting <br/> ";
                    }

                }

                ret[0] = "Rekod Berjaya : (" + rekodBerjaya + ") Rekod Tidak Berjaya : (" + rekodXBerjaya + ")";
                return ret;
              
            }
            catch (Exception ex)
            {
                ret[0] = ex.Message.ToString();
                
             
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


        // -------- start get lejar pemiutang
        public static IEnumerable<string> getLejarPemiutang()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"
                select tblA.kodPembayar, tblA.IDPenerima, tblA.namaPembayar, tblA.MK06_Rujukan, tblA.tahun, tblA.KodKw, 
                CASE 
                        WHEN tblA.KodPTJ LIKE 'k%' THEN (select PTJProjek from MK_PTJ where KodPTJ = tblA.KodPTJ) 
                        ELSE tblA.KodPTJ 
                    END AS KodPTJ,
                tblA.KodVot, tblA.KP, tblA.KO, TBLA.MK06_Debit, tblA.MK06_Kredit, month(tbla.MK06_TkhTran) as bulan
                from 
                (
                    select 
                        (select x.AR01_IDPenerima from AR01_Bil as x
                        where x.AR01_NoBil = SUBSTRING(a.MK06_Rujukan,1,11)) as IDPenerima,
                        (select x.AR01_Kategori from AR01_Bil as x
                        where x.AR01_NoBil = SUBSTRING(a.MK06_Rujukan,1,11)) as kodPembayar,
		                (select x.AR01_NamaPenerima from AR01_Bil as x
                        where x.AR01_NoBil = SUBSTRING(a.MK06_Rujukan,1,11)) as namaPembayar,
                        year(a.MK06_TkhTran) as tahun, a.KodKw,a.KodPTJ, a.KodVot, 
                        CASE 
                                WHEN a.KodPTJ LIKE 'k%' THEN a.KodPTJ
                                ELSE '0000000'
                            END AS KP,    
                        '00' as KO, a.MK06_Debit, a.MK06_Kredit, a.MK06_TkhTran, a.MK06_Rujukan
                        from MK06_Transaksi as a
                        where a.KodDok IN ('BIL')
                        AND year(a.MK06_TkhTran) in(YEAR(GETDATE()), YEAR(GETDATE())-1, YEAR(GETDATE())-2, YEAR(GETDATE())-3, YEAR(GETDATE())-4, YEAR(GETDATE())-5)
                        and a.KodJen in ('A','C')
                ) as tblA 
                WHERE tblA.IDPenerima <> '' AND tblA.IDPenerima <>'-'
                AND tblA.kodPembayar <> 'OA'
                order by tbla.MK06_TkhTran DESC";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;
                int rekodXBerjaya = 0;

                while (rdr.Read())
                {
                    //string kodPenghutang = getKodPenghutang("01662");

                    string strKodPemiutang = getKodPemiutangByNama(rdr["IDPenerima"].ToString()).ToString();

                    IEnumerable<string> task = PostingLejar("AP", strKodPemiutang, rdr["KodKw"].ToString(), rdr["KodPTJ"].ToString(), rdr["KodVot"].ToString(), rdr["KO"].ToString(),
                      rdr["KP"].ToString(), double.Parse(rdr["MK06_Debit"].ToString()), "DR", rdr["bulan"].ToString(), rdr["tahun"].ToString());

                    //IEnumerable<string> task = PostingLejar("AR", kodPenghutang, "01", "430000", "29104", "00", "000000", 290.50, "CR", "5", "2023");

                    var myListx = task.ToList();
                    //listOfResults += kodPenghutang.ToString();

                    if (myListx[0] == "no")
                    {
                        rekodXBerjaya++;
                        //listOfResults += "no posting <br/> ";
                    }
                    else
                    {
                        rekodBerjaya++;
                        //listOfResults += "ok posting <br/> ";
                    }

                }

                ret[0] = "Rekod Berjaya : (" + rekodBerjaya + ") Rekod Tidak Berjaya : (" + rekodXBerjaya + ")";
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ex.Message.ToString();


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
        // -------- end get lejar pemiutang


        public static IEnumerable<string> getLejarBil()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"
                select tblA.kodPembayar, tblA.IDPenerima, tblA.namaPembayar, tblA.MK06_Rujukan, tblA.tahun, tblA.KodKw, 
                CASE 
                        WHEN tblA.KodPTJ LIKE 'k%' THEN (select PTJProjek from MK_PTJ where KodPTJ = tblA.KodPTJ) 
                        ELSE tblA.KodPTJ 
                    END AS KodPTJ,
                tblA.KodVot, tblA.KP, tblA.KO, TBLA.MK06_Debit, tblA.MK06_Kredit, month(tbla.MK06_TkhTran) as bulan
                from 
                (
                    select 
                        (select x.AR01_IDPenerima from AR01_Bil as x
                        where x.AR01_NoBil = SUBSTRING(a.MK06_Rujukan,1,11)) as IDPenerima,
                        (select x.AR01_Kategori from AR01_Bil as x
                        where x.AR01_NoBil = SUBSTRING(a.MK06_Rujukan,1,11)) as kodPembayar,
		                (select x.AR01_NamaPenerima from AR01_Bil as x
                        where x.AR01_NoBil = SUBSTRING(a.MK06_Rujukan,1,11)) as namaPembayar,
                        year(a.MK06_TkhTran) as tahun, a.KodKw,a.KodPTJ, a.KodVot, 
                        CASE 
                                WHEN a.KodPTJ LIKE 'k%' THEN a.KodPTJ
                                ELSE '0000000'
                            END AS KP,    
                        '00' as KO, a.MK06_Debit, a.MK06_Kredit, a.MK06_TkhTran, a.MK06_Rujukan
                        from MK06_Transaksi as a
                        where a.KodDok IN ('BIL')
                        AND year(a.MK06_TkhTran) in(YEAR(GETDATE()), YEAR(GETDATE())-1, YEAR(GETDATE())-2, YEAR(GETDATE())-3, YEAR(GETDATE())-4, YEAR(GETDATE())-5)
                        and a.KodJen in ('A','C')
                ) as tblA 
                WHERE tblA.IDPenerima <> '' AND tblA.IDPenerima <>'-'
                AND tblA.kodPembayar <> 'OA'
                order by tbla.MK06_TkhTran DESC";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;
                int rekodXBerjaya = 0;

                while (rdr.Read())
                {
                    //string kodPenghutang = getKodPenghutang("01662");
                    string kodPenghutang = getKodPenghutang(rdr["IDPenerima"].ToString()).ToString();

                    IEnumerable<string> task = PostingLejar("AR", kodPenghutang, rdr["KodKw"].ToString(), rdr["KodPTJ"].ToString(), rdr["KodVot"].ToString(), rdr["KO"].ToString(),
                      rdr["KP"].ToString(), double.Parse(rdr["MK06_Debit"].ToString()), "DR", rdr["bulan"].ToString(), rdr["tahun"].ToString());

                    //IEnumerable<string> task = PostingLejar("AR", kodPenghutang, "01", "430000", "29104", "00", "000000", 290.50, "CR", "5", "2023");

                    var myListx = task.ToList();
                    //listOfResults += kodPenghutang.ToString();

                    if (myListx[0] == "no")
                    {
                        rekodXBerjaya++;
                        //listOfResults += "no posting <br/> ";
                    }
                    else
                    {
                        rekodBerjaya++;
                        //listOfResults += "ok posting <br/> ";
                    }

                }

                ret[0] = "Rekod Berjaya : (" + rekodBerjaya + ") Rekod Tidak Berjaya : (" + rekodXBerjaya + ")";
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ex.Message.ToString();


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

        //----- start insert Bil Hdr ----
        public static IEnumerable<string> insertBil_Hdr()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"
                select a.AR01_NoBil, a.ar01_nobilsem, '20' + substring(a.AR01_NoBil,10,2) as tahun,  
                (select x.AR06_Tarikh from AR06_StatusDok as x where x.AR06_StatusDok = '01' and x.AR06_NoBil = a.ar01_nobilsem) as Tkh_Mohon,
                (select x.AR06_NoStaf from AR06_StatusDok as x where x.AR06_StatusDok = '01' and x.AR06_NoBil = a.ar01_nobilsem) as noStafPenyedia,
                a.AR01_Jenis, a.AR01_KodPTJMohon, a.AR01_NoStaf, a.AR01_UtkPerhatian, a.AR01_NoRujukan, a.AR01_Jumlah, a.AR01_StatusDok, 
                a.AR01_StatusCetakBilSbnr, a.AR01_StatusCetakBilSmtr, a.AR01_FlagAdj,
                a.AR01_Kategori, a.AR01_Tujuan, a.AR01_NamaPenerima, 
                a.AR01_Peringatan1, a.AR01_Peringatan2, a.AR01_Peringatan3, a.AR01_TkhPeringatan1, a.AR01_TkhPeringatan2, a.AR01_TkhPeringatan3, 
				(select x.AR06_NoStaf from AR06_StatusDok as x where x.AR06_StatusDok = '03' and x.AR06_NoBil = a.ar01_nobil) as noStafLulus,
				(select x.AR06_Tarikh from AR06_StatusDok as x where x.AR06_StatusDok = '03' and x.AR06_NoBil = a.ar01_nobil) as AR01_TkhLulus,
				ISNULL((select x.AR06_NoStaf from AR06_StatusDok as x where x.AR06_StatusDok = '03' and x.AR06_NoBil = a.ar01_nobil),'0') as FlagLulus,
                CASE
                    WHEN (select x.AR06_NoStaf from AR06_StatusDok as x where x.AR06_StatusDok = '03' and x.AR06_NoBil = a.ar01_nobil) IS NOT NULL THEN 1
                    ELSE 0
                END AS flagLulus
                from AR01_Bil as a
				where a.AR01_NoBil like '%23'";


                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                int rekodBerjaya = 0;
                string strKodPenghutang = "";
                string strNamaPenghutang = "";

                //string strTkhMula = "";

                while (rdr.Read())
                {
                    ret[0] += "masuk bacadata main";
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {
                            ret[0] += "masuk sqlcommand";

                            strNamaPenghutang = rdr["AR01_NamaPenerima"].ToString();

                            //semak nama di penghutang master
                            if (semakNamaPenghutangMaster(strNamaPenghutang))
                            {
                                //dapatkan kod penghutang    
                                strKodPenghutang = getKodPenghutangByNama(strNamaPenghutang);
                            }
                            else
                            {
                                ret[0] += "insert master";
                                insertPenghutangMaster(strNamaPenghutang);
                                strKodPenghutang = getKodPenghutangByNama(strNamaPenghutang);
                            }

                            //dapatkan tarikh mula / tarikh bil
                            //strTkhMula = getTkhMulaBil(rdr["ar01_nobilsem"].ToString());



                            //dapatkan tarikh lulus / no staf penyelia 

                            cmdV4.CommandText = @"insert SMKB_Bil_Hdr (No_Bil, Tahun, Tkh_Mohon, Jenis, Kod_PTJ_Mohon, No_Staf, Utk_Perhatian, No_Rujukan, Jumlah, 
                                Kod_Status_Dok, Status_Cetak_Bil_Sbnr, Status_Cetak_Bil_Smtr, Flag_Adj,Kategori, Kod_Penghutang, Tujuan, 
                                Peringatan_1, Peringatan_2, Peringatan_3, Tkh_Peringatan_1, Tkh_Peringatan_2, Tkh_Peringatan_3, 
                                Tkh_Lulus, No_Staf_Lulus, Status, No_Staf_Penyedia, Tkh_Bil, Flag_Lulus)
                                values (@No_Bil, @Tahun, @Tkh_Mohon, @Jenis, @Kod_PTJ_Mohon, @No_Staf, @Utk_Perhatian, @No_Rujukan, @Jumlah, @Kod_Status_Dok, 
                                @Status_Cetak_Bil_Sbnr, @Status_Cetak_Bil_Smtr, @Flag_Adj, @Kategori, @Kod_Penghutang, @Tujuan, 
                                @Peringatan_1, @Peringatan_2, @Peringatan_3, @Tkh_Peringatan_1, @Tkh_Peringatan_2, @Tkh_Peringatan_3, 
                                @Tkh_Lulus, @No_Staf_Lulus, @Status, @No_Staf_Penyedia, @Tkh_Bil, @Flag_Lulus)";

                            cmdV4.Connection = sqlConn;
                            cmdV4.Parameters.AddWithValue("@No_Bil", rdr["AR01_NoBil"].ToString());
                            cmdV4.Parameters.AddWithValue("@Tahun", rdr["Tahun"].ToString());

                            cmdV4.Parameters.AddWithValue("@Tkh_Mohon", rdr["Tkh_Mohon"].ToString());
                            cmdV4.Parameters.AddWithValue("@No_Staf_Penyedia", rdr["noStafPenyedia"].ToString());
                            cmdV4.Parameters.AddWithValue("@Tkh_Bil", rdr["Tkh_Mohon"].ToString());


                            cmdV4.Parameters.AddWithValue("@Jenis", rdr["AR01_Jenis"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_PTJ_Mohon", rdr["AR01_KodPTJMohon"].ToString());
                            cmdV4.Parameters.AddWithValue("@No_Staf", rdr["AR01_NoStaf"].ToString());
                            cmdV4.Parameters.AddWithValue("@Utk_Perhatian", rdr["AR01_UtkPerhatian"].ToString());
                            cmdV4.Parameters.AddWithValue("@No_Rujukan", rdr["AR01_NoRujukan"].ToString());
                            cmdV4.Parameters.AddWithValue("@Jumlah", rdr["AR01_Jumlah"]);
                            cmdV4.Parameters.AddWithValue("@Kod_Status_Dok", rdr["AR01_StatusDok"].ToString());
                            cmdV4.Parameters.AddWithValue("@Status_Cetak_Bil_Sbnr", rdr["AR01_StatusCetakBilSbnr"].ToString());
                            cmdV4.Parameters.AddWithValue("@Status_Cetak_Bil_Smtr", rdr["AR01_StatusCetakBilSmtr"].ToString());
                            cmdV4.Parameters.AddWithValue("@Flag_Adj", rdr["AR01_FlagAdj"].ToString());

                            cmdV4.Parameters.AddWithValue("@Kategori", rdr["AR01_Kategori"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Penghutang", strKodPenghutang);
                            cmdV4.Parameters.AddWithValue("@Tujuan", rdr["AR01_Tujuan"].ToString());
                            cmdV4.Parameters.AddWithValue("@Peringatan_1", rdr["AR01_Peringatan1"].ToString());
                            cmdV4.Parameters.AddWithValue("@Peringatan_2", rdr["AR01_Peringatan2"].ToString());
                            cmdV4.Parameters.AddWithValue("@Peringatan_3", rdr["AR01_Peringatan3"].ToString());
                            cmdV4.Parameters.AddWithValue("@Tkh_Peringatan_1", rdr["AR01_TkhPeringatan1"].ToString());
                            cmdV4.Parameters.AddWithValue("@Tkh_Peringatan_2", rdr["AR01_TkhPeringatan2"].ToString());
                            cmdV4.Parameters.AddWithValue("@Tkh_Peringatan_3", rdr["AR01_TkhPeringatan3"].ToString());
                            cmdV4.Parameters.AddWithValue("@Tkh_Lulus", rdr["AR01_TkhLulus"].ToString());
                            cmdV4.Parameters.AddWithValue("@No_Staf_Lulus", rdr["noStafLulus"].ToString());
                            cmdV4.Parameters.AddWithValue("@Flag_Lulus", rdr["flagLulus"].ToString());
                            cmdV4.Parameters.AddWithValue("@Status", "1");



                            try
                            {
                                sqlConn.Open();
                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                            }



                        }
                    }
                    rekodBerjaya++;

                }

                ret[0] = "Rekod Berjaya : (" + rekodBerjaya + ")."; // + " <br/>  " + strKodPenghutang + " <br/>  "  + strNamaPenghutang;
                //ret[0] = "Rekod Berjaya : (" + rekodBerjaya + ") Rekod Tidak Berjaya : (" + rekodXBerjaya + ")";
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
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
        //----- end insert Bil Hdr ----

        public static IEnumerable<string> insertTerima_Hdr()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"
                select RC01_NoResit, NoMesin, RC01_TkhDaftar, KodTerimaan, KodUrusniaga, KodMod, RC01_BankKUTKM, RC01_NoAkaun, RC01_Tujuan, RC01_StafTerima,
                RC01_MasaTerima, RC01_Jumlah, RC01_Status, RC01_TkhBatal, RC01_StafBatal, RC01_StatusCetak, KodPenyesuaian, RC01_PenyID, RC01_TarikhPeny,
                RC01_JenisByr, RC01_FlagGST, RC01_Zon
                from RC01_Terimaan
                where year(RC01_TkhDaftar) in (YEAR(GETDATE()), YEAR(GETDATE())-1, YEAR(GETDATE())-2, YEAR(GETDATE())-3)
                order by RC01_TkhDaftar desc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;
                //int rekodXBerjaya = 0;
                string strKodPenghutang = "";
                string strNamaPenghutang = "";

                while (rdr.Read())
                {
                    ret[0] += "masuk bacadata main";
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {
                            ret[0] += "masuk sqlcommand";

                            strNamaPenghutang = getNamaPenghutang(rdr["RC01_NoResit"].ToString());

                            //semak nama di penghutang master
                            if (semakNamaPenghutangMaster(strNamaPenghutang))
                            {
                                //dapatkan kod penghutang    
                                strKodPenghutang = getKodPenghutangByNama(strNamaPenghutang);
                            }
                            else
                            {
                                ret[0] += "insert master";
                                insertPenghutangMaster(strNamaPenghutang);
                                strKodPenghutang = getKodPenghutangByNama(strNamaPenghutang);
                            }

                            cmdV4.CommandText = @"INSERT SMKB_Terima_Hdr (No_Dok, Kod_Penghutang, Tujuan, Kod_Urusniaga, Mod_Terima, Tkh_Daftar, Staf_Terima, Jumlah_Sebenar, Jumlah_Bayar, 
                            Kategori_Bayar, Zon, Status_Cetak, Kod_Bank, Status, Kod_Terima)
                            VALUES (@NoResit, @kodPenghutang, @tujuan, @KodUrusniaga, @KodTerima, @TkhDaftar, @stafTerima, @jumlah, @jumlah, 
                            '-', @zon, @statusCetak, @kodBank, @statTerima, @KodTerimaan)";

                            cmdV4.Connection = sqlConn;
                            cmdV4.Parameters.AddWithValue("@NoResit", rdr["RC01_NoResit"].ToString());
                            cmdV4.Parameters.AddWithValue("@kodPenghutang", strKodPenghutang);
                            cmdV4.Parameters.AddWithValue("@tujuan", rdr["RC01_Tujuan"].ToString());
                            cmdV4.Parameters.AddWithValue("@KodUrusniaga", rdr["KodUrusniaga"].ToString());
                            cmdV4.Parameters.AddWithValue("@KodTerima", rdr["KodMod"].ToString());
                            cmdV4.Parameters.AddWithValue("@TkhDaftar", rdr["RC01_TkhDaftar"].ToString());
                            cmdV4.Parameters.AddWithValue("@stafTerima", rdr["RC01_StafTerima"].ToString());
                            cmdV4.Parameters.AddWithValue("@jumlah", rdr["RC01_Jumlah"].ToString());
                            cmdV4.Parameters.AddWithValue("@zon", rdr["RC01_Zon"].ToString());
                            cmdV4.Parameters.AddWithValue("@statusCetak", rdr["RC01_StatusCetak"].ToString());
                            cmdV4.Parameters.AddWithValue("@kodBank", rdr["RC01_BankKUTKM"].ToString());
                            cmdV4.Parameters.AddWithValue("@statTerima", rdr["RC01_BankKUTKM"].ToString());
                            cmdV4.Parameters.AddWithValue("@KodTerimaan", rdr["KodTerimaan"].ToString());

                            try
                            {
                                sqlConn.Open();
                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                            }



                        }
                    }
                    rekodBerjaya++;

                }

                ret[0] = "Rekod Berjaya : (" + rekodBerjaya + ")."; // + " <br/>  " + strKodPenghutang + " <br/>  "  + strNamaPenghutang;
                //ret[0] = "Rekod Berjaya : (" + rekodBerjaya + ") Rekod Tidak Berjaya : (" + rekodXBerjaya + ")";
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
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


        // update ID Rujukan di SMKB_Pembayaran_Baucar_Hdr
        public static IEnumerable<string> updateIDRujukan_Baucar()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select No_Baucar from SMKB_Pembayaran_Baucar_Hdr where No_Baucar like '%19'";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;

                while (rdr.Read())
                {
                    updateIDRujukanBaucar(rdr["No_Baucar"].ToString());
                    rekodBerjaya++;
                }

                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ").";
                return ret;

            }
            catch (SqlException ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                return ret;
            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
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
        //----- end ---


        // update email staf di Penghutang Master
        public static IEnumerable<string> updateEmail_Staf()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select No_Rujukan from SMKB_Penghutang_Master
                            where Kategori_Penghutang = 'ST'";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;

                while (rdr.Read())
                {
                    updateEmailStaf(rdr["No_Rujukan"].ToString());
                    rekodBerjaya++;
                }

                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ").";
                return ret;

            }
            catch (SqlException ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                return ret;
            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
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
        //----- end ---


        // insert ap01_invoisdt to smkb_pembayaran_invois_dtl
        public static IEnumerable<string> insertInvois_Dtl()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select SUBSTRING(LTRIM(no_rujukan),22,19) as invID
                            from SMKB_Pembayaran_Invois_Hdr where SUBSTRING(LTRIM(no_rujukan),39,2) = '22'";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;

                while (rdr.Read())
                {
                    insertInvoisDetail(rdr["invID"].ToString());
                    rekodBerjaya++;
                }

                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ").";
                return ret;

            }
            catch (SqlException ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                return ret;
            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
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
        //----- end ---

        // insert mk06_transaksi to smkb_transaksi_bank
        public static IEnumerable<string> insertTransaksi_Bank(string parKodBank, string parBulan, string parTahun)
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
           
            try
            {
                //Open connection to the database
                //String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                //con = new SqlConnection(ConnectionString);
                //con.Open();

                //string CommandText = @"select KodVot, KodKw, KodDok, MK06_TkhTran, MK06_Debit, MK06_Kredit, MK06_Rujukan,  MK06_NoDok, '' as rujukanLain
                //                from MK06_Transaksi
                //                where year(MK06_TkhTran) = '2023'
                //                and KodVot = '76106'";

                //cmd = new SqlCommand(CommandText);
                //cmd.Connection = con;
                //cmd.CommandText = CommandText;
                //rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                //int rekodBerjaya = 0;

                //while (rdr.Read())
                //{
                //    getTransaksi_Bank("76106");
                //    rekodBerjaya++;
                //}

                
                ret =  getTransaksi_Bank(parKodBank, parBulan, parTahun);

                //ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ").";
                return ret;

            }
            catch (SqlException ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                return ret;
            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                return ret;
            }
            //finally
            //{
            //    if (rdr != null)
            //        rdr.Close();
            //    if (con.State == ConnectionState.Open)
            //        con.Close();
            //}
        }
        //----- end ---



        // insert ap04_baucar to smkb_pembayaran_baucar_hdr
        public static IEnumerable<string> insertBaucar_Hdr()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select AP04_NoBaucar from AP04_Baucar where AP04_NoBaucar like '%23' and AP04_NoBaucar like 'bk%'";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;

                while (rdr.Read())
                {
                    insertBaucarHdr(rdr["AP04_NoBaucar"].ToString());
                    rekodBerjaya++;
                }

                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ").";
                return ret;

            }
            catch (SqlException ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                return ret;
            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
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
        //----- end ---


        // insert ap04_baucardt, nominees to smkb_pembayaran_baucar_dtl
        public static IEnumerable<string> insertBaucar_Dtl()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select No_Baucar from SMKB_Pembayaran_Baucar_Hdr where No_Baucar like '%23'";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;

                while (rdr.Read())
                {
                    updateKodCukaiBaucarDetail(rdr["No_Baucar"].ToString());
                    rekodBerjaya++;
                }

                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ").";
                return ret;

            }
            catch (SqlException ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                return ret;
            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
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
        //----- end ---


        // insert rc02 to smkb_terima_dtl
        public static IEnumerable<string> insertTerima_Dtl()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select No_Dok FROM SMKB_Terima_Hdr";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;

                while (rdr.Read())
                {
                    insertTerimaDetail(rdr["No_Dok"].ToString());
                    rekodBerjaya++;
                }

                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ").";
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
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
        //----- end ---

        // insert ar01_bildt to smkb_bil_dtl
        public static IEnumerable<string> insertBil_Dtl()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select No_Dok FROM SMKB_Bil_Hdr";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;

                while (rdr.Read())
                {
                    insertBilDetail(rdr["No_Dok"].ToString());
                    rekodBerjaya++;
                }

                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ").";
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
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
        //----- end ---


        // insert rc02 to smkb_terima_dtl
        public static IEnumerable<string> insertTerima_Trans()
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select No_Dok FROM SMKB_Terima_Hdr where no_dok like '%21'";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                rdr = cmd.ExecuteReader();
                //string listOfResults = "";
                int rekodBerjaya = 0;

                while (rdr.Read())
                {
                    insertTerimaTrans(rdr["No_Dok"].ToString());
                    rekodBerjaya++;
                }

                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ").";
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
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
        //----- end ---


        public static IEnumerable<string> insertTerimaTrans(string noResit)
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select RC01_NoResit, RC02_Bil, RC02_BankByr, RC02_Cawangan, RC02_TkhDok, RC02_NoDok, KodJenisCek, RC02_TkhTerima, RC02_Amaun
                        from RC02_MaklBayaran
                        WHERE RC01_NoResit = @noResit";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noResit", noResit);
                rdr = cmd.ExecuteReader();

                int rekodBerjaya = 0;


                while (rdr.Read())
                {
                    //INSERT DATA TO TABLE MASTER
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        sqlConn.Open();
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {
                            ret[0] += "masuk sqlcommand";

                            cmdV4.CommandText = @"                            
                        insert SMKB_Terima_Transaksi (No_Resit, No_Dok, No_Item, Tkh_Terima, Amaun_Terima, Bank_Bayar, Cawangan_Bank, Tkh_Dok, Kod_Jenis_Cek, Status)
                        values (@No_Resit, @No_Dok, @No_Item, @Tkh_Terima, @Amaun_Terima, @Bank_Bayar, @Cawangan_Bank, @Tkh_Dok, @Kod_Jenis_Cek, @Status)";

                            cmdV4.Connection = sqlConn;
                            cmdV4.Parameters.AddWithValue("@No_Resit", noResit);
                            cmdV4.Parameters.AddWithValue("@No_Dok", rdr["RC02_NoDok"].ToString());
                            cmdV4.Parameters.AddWithValue("@No_Item", rdr["RC02_Bil"].ToString());
                            cmdV4.Parameters.AddWithValue("@Tkh_Terima", rdr["RC02_TkhTerima"].ToString());
                            cmdV4.Parameters.AddWithValue("@Amaun_Terima", rdr["RC02_Amaun"]);
                            cmdV4.Parameters.AddWithValue("@Bank_Bayar", rdr["RC02_BankByr"].ToString());
                            cmdV4.Parameters.AddWithValue("@Cawangan_Bank", rdr["RC02_Cawangan"].ToString());
                            cmdV4.Parameters.AddWithValue("@Tkh_Dok", rdr["RC02_TkhDok"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Jenis_Cek", rdr["KodJenisCek"].ToString());

                            cmdV4.Parameters.AddWithValue("@Status", "1");

                            try
                            {
                                
                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }

                        }
                    }
                    rekodBerjaya++;
                }


                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ")." + ret[0];
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                throw;
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

        public static IEnumerable<string> insertBilDetail(string noBil)
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select AR01_NoBil, AR01_Bil, KodKw, '00', KodPTJ, '000000', KodVot, AR01_Perkara, AR01_Kuantiti, AR01_kadarHarga, AR01_Jumlah, substring(AR01_NoBil,10,2) as tahun, AR01_JumGST, '1'
                        from AR01_BilDT
                        where AR01_NoBil = @noBil";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noBil", noBil);
                rdr = cmd.ExecuteReader();

                int rekodBerjaya = 0;


                while (rdr.Read())
                {
                    //INSERT DATA TO TABLE MASTER
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        sqlConn.Open();
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {
                            ret[0] += "masuk sqlcommand";

                            cmdV4.CommandText = @"                            
                    insert SMKB_Bil_Dtl (No_Bil, No_Item, Kod_Kump_Wang, Kod_Operasi, Kod_PTJ, Kod_Projek, Kod_Vot, Perkara, Kuantiti, Kadar_Harga, Jumlah, Tahun, Cukai, Status)
                    values (@No_Bil, @No_Item, @Kod_Kump_Wang, @Kod_Operasi, @Kod_PTJ, @Kod_Projek, @Kod_Vot, @Perkara, @Kuantiti, @Kadar_Harga, @Jumlah, @Tahun, @Cukai, @Status)";


                            cmdV4.Connection = sqlConn;
                            cmdV4.Parameters.AddWithValue("@No_Bil", rdr["AR01_NoBil"].ToString());
                            cmdV4.Parameters.AddWithValue("@No_Item", rdr["AR01_Bil"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Kump_Wang", rdr["KodKw"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Operasi", "00");
                            cmdV4.Parameters.AddWithValue("@Kod_PTJ", rdr["KodPTJ"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Projek", "000000");
                            cmdV4.Parameters.AddWithValue("@Kod_Vot", rdr["KodVot"].ToString());
                            cmdV4.Parameters.AddWithValue("@Perkara", rdr["AR01_Perkara"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kuantiti", rdr["AR01_Kuantiti"]);
                            cmdV4.Parameters.AddWithValue("@Kadar_Harga", rdr["AR01_kadarHarga"]);
                            cmdV4.Parameters.AddWithValue("@Jumlah", rdr["AR01_Jumlah"]);
                            cmdV4.Parameters.AddWithValue("@Tahun", rdr["tahun"].ToString());
                            cmdV4.Parameters.AddWithValue("@Cukai", rdr["AR01_JumGST"]);

                            cmdV4.Parameters.AddWithValue("@Status", "1");

                            try
                            {

                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }

                        }
                    }
                    rekodBerjaya++;
                }


                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ")." + ret[0];
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                throw;
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



        public static IEnumerable<string> insertTerimaDetail(string noResit)
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select RC01_NoResit, RC01_Bil, KodKw, KodPTJ, KodVot, KodAkt, RC01_Butiran, RC01_Debit, RC01_Kredit, ID, JenTax, 
                        KodTax, RC01_JumTanpaGST, IDGST,RC01_JenTran
                        from RC01_TerimaanDT
                        WHERE RC01_NoResit = @noResit";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noResit", noResit);
                rdr = cmd.ExecuteReader();

                int rekodBerjaya = 0;


                while (rdr.Read())
                {
                    //INSERT DATA TO TABLE MASTER
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        sqlConn.Open();
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {
                            ret[0] += "masuk sqlcommand";

                            cmdV4.CommandText = @"                            
                    insert SMKB_Terima_Dtl (No_Dok, No_Item, Kod_Kump_Wang, Kod_Operasi, Kod_PTJ, Kod_Projek, Kod_Vot, Butiran, Debit, Kredit, Amaun_Cukai, Status)
                    values (@No_Dok, @No_Item, @Kod_Kump_Wang, @Kod_Operasi, @Kod_PTJ, @Kod_Projek, @Kod_Vot, @Butiran, @Debit, @Kredit, @Amaun_Cukai, @Status)";

                            cmdV4.Connection = sqlConn;
                            cmdV4.Parameters.AddWithValue("@No_Dok", noResit);
                            cmdV4.Parameters.AddWithValue("@No_Item", rdr["RC01_Bil"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Kump_Wang", rdr["KodKw"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Operasi", "01");
                            cmdV4.Parameters.AddWithValue("@Kod_PTJ", rdr["KodPTJ"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Projek", "000000");
                            cmdV4.Parameters.AddWithValue("@Kod_Vot", rdr["KodVot"].ToString());
                            cmdV4.Parameters.AddWithValue("@Butiran", rdr["RC01_Butiran"].ToString());
                            cmdV4.Parameters.AddWithValue("@Debit", rdr["RC01_Debit"]);
                            cmdV4.Parameters.AddWithValue("@Kredit", rdr["RC01_Kredit"]);
                            cmdV4.Parameters.AddWithValue("@Amaun_Cukai", rdr["RC01_JumTanpaGST"]);

                            cmdV4.Parameters.AddWithValue("@Status", "1");

                            try
                            {

                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }

                        }
                    }
                    rekodBerjaya++;
                }


                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ")." + ret[0];
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                throw;
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

        public static IEnumerable<string> updateIDRujukanBaucar(string noBaucar)
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select AP02_NoPP from AP04_BaucarDt where AP04_NoBaucar = @noBaucar";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noBaucar", noBaucar);
                rdr = cmd.ExecuteReader();

                int rekodBerjaya = 0;
                string strNoINV = null;

                while (rdr.Read())
                {
                    //dapatkan no inv di table invois hdr filter by no pp    
                    strNoINV = getNoINV(rdr["AP02_NoPP"].ToString());

                    //INSERT DATA TO TABLE MASTER
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        sqlConn.Open();
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {
                            ret[0] += "masuk sqlcommand";

                            cmdV4.CommandText = @"update SMKB_Pembayaran_Baucar_Hdr set ID_Rujukan = @noINV where No_Baucar = @noBaucar";

                            cmdV4.Connection = sqlConn;
                            cmdV4.Parameters.AddWithValue("@noINV", strNoINV);
                            cmdV4.Parameters.AddWithValue("@noBaucar", noBaucar);

                            try
                            {

                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }

                        }
                    }
                    rekodBerjaya++;
                }


                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ")." + ret[0];
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                throw;
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


        public static IEnumerable<string> updateEmailStaf(string noStaf)
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbstaf;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select MS01_Email from MS01_Peribadi
                        where MS01_NoStaf = @noStaf";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noStaf", noStaf);
                rdr = cmd.ExecuteReader();

                int rekodBerjaya = 0;

                while (rdr.Read())
                {
                    //INSERT DATA TO TABLE MASTER
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        sqlConn.Open();
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {
                            ret[0] += "masuk sqlcommand";

                            cmdV4.CommandText = @"                            
                    update SMKB_Penghutang_Master set Emel = @email where Kategori_Penghutang = 'ST' and No_Rujukan = @noStaf";

                            cmdV4.Connection = sqlConn;
                            cmdV4.Parameters.AddWithValue("@noStaf", noStaf);
                            cmdV4.Parameters.AddWithValue("@email", rdr["MS01_Email"].ToString());

                            try
                            {

                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }

                        }
                    }
                    rekodBerjaya++;
                }


                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ")." + ret[0];
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                throw;
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

        public static IEnumerable<string> updateKodCukaiBaucarDetail(string noBaucar)
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select AP05_Bil, AP05_KodCukai, AP05_CaraByr from AP05_BaucarNominees
                    where AP04_NoBaucar = @noBaucar";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noBaucar", noBaucar);
                rdr = cmd.ExecuteReader();

                int rekodBerjaya = 0;

                while (rdr.Read())
                {
                    //INSERT DATA TO TABLE MASTER
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        sqlConn.Open();
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {
                            ret[0] += "masuk sqlcommand";


                            //update data di baucar detail
                            cmdV4.CommandText = @"                            
                    update SMKB_Pembayaran_Baucar_Dtl set Cara_Bayar = @caraByr, Kod_Cukai = @kodCukai
                    where No_Baucar = @noBaucar and no_item = @bilItem";

                            cmdV4.Connection = sqlConn;
                            cmdV4.Parameters.AddWithValue("@caraByr", rdr["AP05_CaraByr"].ToString());
                            cmdV4.Parameters.AddWithValue("@kodCukai", rdr["AP05_KodCukai"].ToString());
                            cmdV4.Parameters.AddWithValue("@bilItem", rdr["AP05_Bil"].ToString());
                            cmdV4.Parameters.AddWithValue("@noBaucar", noBaucar);

                            try
                            {

                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }

                        }
                    }
                    rekodBerjaya++;
                }


                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ")." + ret[0];
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                throw;
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



        public static IEnumerable<string> insertInvoisDetail(string noInvID)
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select AP01_NoId, AP01_NoInv, AP01_Bil, KodKw, KodPtj, KodVot, KodAkt, AP01_Butiran, PO02_Lampiran, AP01_KuantitiAkanByr, AP01_KadarHarga, AP01_AmaunAkanByr, 
                AP01_JenItem, AP01_StatusInv, AP01_NoAkaun, AP01_NoBil, AP01_NoIdDt, JenTax, KodTax, PtjGST, KwGST, AktGST, AP01_JumGST, AP01_JumTanpaGST, 
                VotGST, AP01_flagInclusiveGST
                from AP01_InvoisDt
                where AP01_NoId = @noInvID";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noInvID", noInvID);
                rdr = cmd.ExecuteReader();

                int rekodBerjaya = 0;
                string strNoInvHdr = "";
                string strNamaPemiutang = "";
                string strKodPemiutang = "";

                while (rdr.Read())
                {
                    //INSERT DATA TO TABLE MASTER
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        sqlConn.Open();
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {
                            ret[0] += "masuk sqlcommand";

                            strNoInvHdr = getNoInvHdr(noInvID);
                            strNamaPemiutang = getNamaPemiutang(noInvID, rdr["AP01_Bil"].ToString());

                            strKodPemiutang = getKodPemiutangByNama(strNamaPemiutang);

                            cmdV4.CommandText = @"                            
                    insert SMKB_Pembayaran_Invois_Dtl (ID_Rujukan, No_Item, Kod_Pemiutang, Kod_Kump_Wang, Kod_Operasi, Kod_PTJ, Kod_Projek, Kod_Vot, Butiran, Kuantiti_Akan_Byr, 
Kadar_Harga, Amaun_Sebenar, Status, Amaun_Akan_Bayar, Kuantiti_Sebenar, Cukai)
values (@ID_Rujukan, @No_Item, @Kod_Pemiutang, @Kod_Kump_Wang, @Kod_Operasi, @Kod_PTJ, @Kod_Projek, @Kod_Vot, @Butiran, @Kuantiti_Akan_Byr, 
@Kadar_Harga, @Amaun_Sebenar, @Status, @Amaun_Akan_Bayar, @Kuantiti_Sebenar, @Cukai)";

                            cmdV4.Connection = sqlConn;
                            cmdV4.Parameters.AddWithValue("@ID_Rujukan", strNoInvHdr);
                            cmdV4.Parameters.AddWithValue("@No_Item", rdr["AP01_Bil"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Pemiutang", strKodPemiutang);
                            cmdV4.Parameters.AddWithValue("@Kod_Kump_Wang", rdr["KodKw"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Operasi", "00");
                            cmdV4.Parameters.AddWithValue("@Kod_PTJ", rdr["KodPtj"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Projek", "000000");
                            cmdV4.Parameters.AddWithValue("@Kod_Vot", rdr["KodVot"].ToString());
                            cmdV4.Parameters.AddWithValue("@Butiran", rdr["AP01_Butiran"].ToString());

                            cmdV4.Parameters.AddWithValue("@Kuantiti_Akan_Byr", rdr["AP01_KuantitiAkanByr"]);
                            cmdV4.Parameters.AddWithValue("@Kadar_Harga", rdr["AP01_KadarHarga"]);
                            cmdV4.Parameters.AddWithValue("@Amaun_Sebenar", rdr["AP01_AmaunAkanByr"].ToString());

                            cmdV4.Parameters.AddWithValue("@Status", rdr["AP01_StatusInv"].ToString());

                            cmdV4.Parameters.AddWithValue("@Amaun_Akan_Bayar", rdr["AP01_AmaunAkanByr"]);
                            cmdV4.Parameters.AddWithValue("@Kuantiti_Sebenar", rdr["AP01_KuantitiAkanByr"]);

                            cmdV4.Parameters.AddWithValue("@Cukai", rdr["AP01_JumGST"]);

                            try
                            {

                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }

                        }
                    }
                    rekodBerjaya++;
                }


                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ")." + ret[0];
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                throw;
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

        //insert AP04_Baucar to SMKB_Pembayaran_Baucar_Hdr 
        public static IEnumerable<string> insertBaucarHdr(string noBaucar)
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select AP04_NoBaucar, AP04_TkhBaucar, AP02_Jenis, AP04_JenisBaucar, AP04_Bank, AP04_Butiran, AP04_Jumlah, AP04_StatusDok, AP04_CetakDraf, '1' as status, '0' as statusPosting
                    from AP04_Baucar
                    where AP04_NoBaucar  = @noBaucar";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noBaucar", noBaucar);
                rdr = cmd.ExecuteReader();

                int rekodBerjaya = 0;
                string strNoINV = "";
                string strNoPP = "";

                while (rdr.Read())
                {
                    //INSERT DATA TO TABLE MASTER
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        sqlConn.Open();
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {
                            ret[0] += "masuk sqlcommand";

                            strNoPP = getNoPP(rdr["AP04_NoBaucar"].ToString());

                            strNoINV = getNoINV(strNoPP);

                           // ret[0] += strNoINV;


                            cmdV4.CommandText = @"insert SMKB_Pembayaran_Baucar_Hdr
                    (No_Baucar, ID_Rujukan, Tarikh, Jenis_Invois, Jenis_Baucar, Kod_Bank, Butiran, Jumlah, Status_Dok, Cetak, Status, Status_Posting)
                    values (@No_Baucar, @ID_Rujukan, @Tarikh, @Jenis_Invois, @Jenis_Baucar, @Kod_Bank, @Butiran, @Jumlah, @Status_Dok, @Cetak, @Status, @Status_Posting)";

                            cmdV4.Connection = sqlConn;
                            cmdV4.Parameters.AddWithValue("@No_Baucar", rdr["AP04_NoBaucar"].ToString());
                            cmdV4.Parameters.AddWithValue("@ID_Rujukan", strNoINV);
                            cmdV4.Parameters.AddWithValue("@Tarikh", rdr["AP04_TkhBaucar"].ToString());
                            cmdV4.Parameters.AddWithValue("@Jenis_Invois", rdr["AP02_Jenis"].ToString());
                            cmdV4.Parameters.AddWithValue("@Jenis_Baucar", rdr["AP04_JenisBaucar"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Bank", rdr["AP04_Bank"].ToString());
                            cmdV4.Parameters.AddWithValue("@Butiran", rdr["AP04_Butiran"].ToString());
                            cmdV4.Parameters.AddWithValue("@Jumlah", rdr["AP04_Jumlah"]);
                            cmdV4.Parameters.AddWithValue("@Status_Dok", rdr["AP04_StatusDok"].ToString());

                            cmdV4.Parameters.AddWithValue("@Cetak", rdr["AP04_CetakDraf"].ToString());
                            cmdV4.Parameters.AddWithValue("@Status", rdr["status"]);
                            cmdV4.Parameters.AddWithValue("@Status_Posting", rdr["statusPosting"]);

                            try
                            {

                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }

                        }
                    }
                    rekodBerjaya++;
                }


                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ")." + ret[0];
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                throw;
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
        //--- end----


        //insert AP04_Baucar to SMKB_Pembayaran_Baucar_Hdr 
        public static string[] getTransaksi_Bank(string kodBank,string parBulan, string parThn)
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;
         

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select KodVot, KodKw, KodDok, MK06_TkhTran, MK06_Debit, MK06_Kredit, MK06_Rujukan,  MK06_NoDok, '-' as rujukanLain
                from MK06_Transaksi
                where year(MK06_TkhTran) = @parThn
                and month(MK06_TkhTran) = @parBulan
                and KodVot = @kodBank";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@kodBank", kodBank);
                cmd.Parameters.AddWithValue("@parBulan", parBulan);
                cmd.Parameters.AddWithValue("@parThn", parThn);
                rdr = cmd.ExecuteReader();

                int rekodBerjaya = 0;
                //string strRujLain = "";

                while (rdr.Read())
                {
                    //INSERT DATA TO SMKB_Transaksi_Bank
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        sqlConn.Open();
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {

                            System.Threading.Thread.Sleep(500);

                            DateTime currentDateTime = DateTime.Now;
                           
                            // Format the date and time
                            string formattedDateTime = currentDateTime.ToString("yyyy-MM-dd HH:mm:ss.ffffff");

                            //2023 - 09 - 14 15:42:59.1644546
                            ret[0] += formattedDateTime;

                            cmdV4.CommandText = @"insert SMKB_Transaksi_Bank
                    (ID_Trans_Bank, Kod_Bank, Kod_Kump_Wang, Kod_Dok, Tarikh_Transaksi, Amaun_Dr, Amaun_Cr, No_Rujukan, No_Dok, No_Rujukan_Lain)
                    values (@IDTrans, @Kod_Bank, @Kod_Kump_Wang, @Kod_Dok, @Tarikh_Transaksi, @Amaun_Dr, @Amaun_Cr, @No_Rujukan, @No_Dok, @No_Rujukan_Lain)";

                             cmdV4.Connection = sqlConn;

                            cmdV4.Parameters.AddWithValue("@IDTrans", formattedDateTime);
                            cmdV4.Parameters.AddWithValue("@Kod_Bank", rdr["KodVot"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Kump_Wang", rdr["KodKw"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Dok", rdr["KodDok"].ToString());
                            cmdV4.Parameters.AddWithValue("@Tarikh_Transaksi", rdr["MK06_TkhTran"]);
                            cmdV4.Parameters.AddWithValue("@Amaun_Dr", rdr["MK06_Debit"]);
                            cmdV4.Parameters.AddWithValue("@Amaun_Cr", rdr["MK06_Kredit"]);
                            cmdV4.Parameters.AddWithValue("@No_Rujukan", rdr["MK06_Rujukan"].ToString());
                            cmdV4.Parameters.AddWithValue("@No_Dok", rdr["MK06_NoDok"].ToString());
                            cmdV4.Parameters.AddWithValue("@No_Rujukan_Lain", rdr["rujukanLain"].ToString()); 
                            try
                            {

                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                                throw;
                            }

                        }
                    }
                    rekodBerjaya++;
                }


                ret[0] += "Rekod Berjaya : (" + rekodBerjaya + ")." + ret[0];
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
                throw;
               
            }
            finally
            {
                if (rdr != null)
                    rdr.Close();
                if (con.State == ConnectionState.Open)
                    con.Close();
            }
        }
        //--- end----


        public static IEnumerable<string> insertPenghutangMaster(string namaPenerima)
        {
            string[] ret = new string[2];
            ret[0] = "no";

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                //Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"
                select top 1 right(RC01_NoResit,2) tahun, KodPembayar, RC03_KodPembayar, RC03_NamaPembayar, RC03_NoKPBaru, RC03_NoKPLama, 
                RC03_Almt1, RC03_Almt2, RC03_Bandar, RC03_Poskod, KodNegeri, KodNegara, RC03_NoTel1
                from RC03_MaklPembayar
                where RC03_NamaPembayar = @namaPenerima
                and RC03_KodPembayar is not null
                order by tahun desc";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@namaPenerima", namaPenerima);
                rdr = cmd.ExecuteReader();

                int rekodBerjaya = 0;


                if (rdr.Read())
                {
                    //INSERT DATA TO TABLE MASTER
                    using (SqlConnection sqlConn = new SqlConnection(SQLAuth.dbase_dbsmkbbaru))
                    {
                        ret[0] += "masuk sqlconnection";
                        using (SqlCommand cmdV4 = new SqlCommand())
                        {
                            ret[0] += "masuk sqlcommand";


                            //insert data penghutang master
                            string strKodPenghutang = genKodPenghutang("PH");

                            cmdV4.CommandText = @"
                            insert SMKB_Penghutang_Master (Kod_Penghutang, No_Rujukan, Nama_Penghutang, Kategori_Penghutang, Alamat_1, Alamat_2, Poskod, Bandar, Kod_Negeri, Kod_Negara, 
                            Tel_Bimbit, Status)
                            values (@Kod_Penghutang, @No_Rujukan, @Nama_Penghutang, @Kategori_Penghutang, @Alamat_1, @Alamat_2, @Poskod, @Bandar, @Kod_Negeri, @Kod_Negara, 
                            @Tel_Bimbit, @Status)";

                            cmdV4.Connection = sqlConn;
                            cmdV4.Parameters.AddWithValue("@Kod_Penghutang", strKodPenghutang);
                            cmdV4.Parameters.AddWithValue("@No_Rujukan", rdr["RC03_KodPembayar"].ToString());
                            cmdV4.Parameters.AddWithValue("@Nama_Penghutang", rdr["RC03_NamaPembayar"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kategori_Penghutang", rdr["KodPembayar"].ToString());
                            cmdV4.Parameters.AddWithValue("@Alamat_1", rdr["RC03_Almt1"].ToString());
                            cmdV4.Parameters.AddWithValue("@Alamat_2", rdr["RC03_Almt2"].ToString());
                            cmdV4.Parameters.AddWithValue("@Poskod", rdr["RC03_Poskod"].ToString());
                            cmdV4.Parameters.AddWithValue("@Bandar", rdr["RC03_Bandar"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Negeri", rdr["KodNegeri"].ToString());
                            cmdV4.Parameters.AddWithValue("@Kod_Negara", rdr["KodNegara"].ToString());
                            cmdV4.Parameters.AddWithValue("@Tel_Bimbit", rdr["RC03_NoTel1"].ToString());

                            cmdV4.Parameters.AddWithValue("@Status", "1");

                            try
                            {
                                sqlConn.Open();
                                cmdV4.ExecuteNonQuery();
                                ret[0] = "ok";
                            }
                            catch (SqlException e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                            }
                            catch (Exception e)
                            {
                                ret[0] += e.Message.ToString() + " <br/> ";
                            }

                        }
                    }
                    rekodBerjaya++;
                }
                

                ret[0] = "Rekod Berjaya : (" + rekodBerjaya + ")." + ret[0];
                return ret;

            }
            catch (Exception ex)
            {
                ret[0] = ret[0] + " <br/> " + ex.Message.ToString();
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

        
        public static string genKodPenghutang(string parPrefix)
        {
            string test = "ok";
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();


            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"update SMKB_No_Akhir
                        set No_Akhir = No_Akhir + 1
                        where Prefix = @prefix
                        and Tahun = year(getdate())";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@prefix", parPrefix);
                cmd.ExecuteNonQuery();


                string CommandText2 = @"select Prefix + right('000000' + CONVERT(VARCHAR, No_Akhir),6) + right(Tahun,2) AS kod_penghutang from SMKB_No_Akhir
                    where Prefix = @prefix
                    and Tahun = year(getdate())";

                cmd = new SqlCommand(CommandText2);
                cmd.Connection = con;
                cmd.CommandText = CommandText2;
                cmd.Parameters.AddWithValue("@prefix", parPrefix);
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    test = rdr["Kod_Penghutang"].ToString();

                }
                
            }
            catch (Exception e)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return test;
        }
        //-----------------------


        //return KodPemiutang by Nama
        public static string getKodPemiutangByNama(string namaPemiutang)
        {
            string test = "-";
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();


            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "SELECT Kod_Pemiutang FROM SMKB_Pemiutang_Master where Nama_Pemiutang = @namaPemiutang";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@namaPemiutang", namaPemiutang);
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    test = rdr["Kod_Pemiutang"].ToString();

                }
            }
            catch (Exception e)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return test;
        }
        //-----------------------

        //return no PP parameter pass no baucar
        public static string getNoPP(string noBaucar)
        {
            string test = "ok";
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();


            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "select distinct AP02_NoPP from AP04_BaucarDt where AP04_NoBaucar = @noBaucar";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noBaucar", noBaucar);
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    test = rdr["AP02_NoPP"].ToString();

                }
                else
                {
                    test = "TIADA";
                    //break;
                }

            }
            catch (Exception e)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return test;
        }
        //-----------------------



        //return no INV parameter NoPP
        public static string getNoINV(string noPP)
        {
            string test = "ok";
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();


            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "select ID_Rujukan from SMKB_Pembayaran_Invois_Hdr where SUBSTRING(No_Rujukan, 1, 19) = @noPP";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noPP", noPP);
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    test = rdr["ID_Rujukan"].ToString();

                }
                else
                {
                    test = "TIADA";
                    //break;
                }

            }
            catch (Exception e)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return test;
        }
        //-----------------------


        //return KodPenghutang
        public static string getKodPenghutang(string idPenerima)
    {
        string test = "ok";
        string[] ret = new string[2];
        ret[0] = "no";
        List<string> myList = new List<string>();
                        

        SqlDataReader rdr = null;
        SqlConnection con = null;
        SqlCommand cmd = null;

        try
        {

        // Open connection to the database
            String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
            con = new SqlConnection(ConnectionString);
            con.Open();

            string CommandText = "select Kod_Penghutang from SMKB_Penghutang_Master where no_rujukan = @idPenerima";

            cmd = new SqlCommand(CommandText);
            cmd.Connection = con;
            cmd.CommandText = CommandText;
            cmd.Parameters.AddWithValue("@idPenerima", idPenerima);
            rdr = cmd.ExecuteReader();

            if (rdr.Read())
            {
                test = rdr["Kod_Penghutang"].ToString();
                    
            }
            else
            {
                test = "TIADA";
                //break;
            }            

        }
        catch (Exception e)
        {

        }
        finally
        {
            if (rdr != null)
                rdr.Close();

            if (con.State == ConnectionState.Open)
                con.Close();
        }

      
        return test;
    }
        //-----------------------



        //return No Invois  dari SMKB_Pembayaran_Invois_Hdr (dbKewangan4)
        public static string getNoInvHdr(string noInvID)
        {
            string test = "ok";
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();


            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "select ID_Rujukan from SMKB_Pembayaran_Invois_Hdr WHERE SUBSTRING(LTRIM(no_rujukan),22,19) = @noInvID";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noInvID", noInvID);                
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    test = rdr["ID_Rujukan"].ToString();

                }
                else
                {
                    test = "TIADA";
                    //break;
                }

            }
            catch (Exception e)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return test;
        }
        //-----------------------


        //return Nama Pemiutang dari RC03_MaklPembayar (dbKewangan v-sql12)
        public static string getNamaPemiutang(string noInvID, string bilangan )
        {
            string test = "ok";
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();


            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "select AP01_Penerima from AP01_InvoisNominees where AP01_NoId = @noInvID and AP01_Bil = @bilangan";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noInvID", noInvID);
                cmd.Parameters.AddWithValue("@bilangan", bilangan);
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    test = rdr["AP01_Penerima"].ToString();

                }
                else
                {
                    test = "TIADA";
                    //break;
                }

            }
            catch (Exception e)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return test;
        }
        //-----------------------


        //return Nama Penghutang dari RC03_MaklPembayar (dbKewangan v-sql12)
        public static string getNamaPenghutang(string noResit)
        {
            string test = "ok";
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();


            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "select DISTINCT RC03_NamaPembayar from RC03_MaklPembayar where RC01_NoResit = @noResit";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noResit", noResit);
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    test = rdr["RC03_NamaPembayar"].ToString();

                }
                else
                {
                    test = "TIADA";
                    //break;
                }

            }
            catch (Exception e)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return test;
        }
        //-----------------------


        //return KodPenghutang
        public static string getKodPenghutangByNama(string namaPenerima)
        {
            string test = "-";
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "select Kod_Penghutang from SMKB_Penghutang_Master where nama_penghutang = @namaPenerima";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@namaPenerima", namaPenerima);
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    test = rdr["Kod_Penghutang"].ToString();

                }

            }
            catch (Exception e)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return test;
        }
        //-----------------------



        //return Tarikh Mula
        public static string getTkhMulaBil(string parNoBil)
        {
            string test = "-";
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = "select AR06_Tarikh from AR06_StatusDok where AR06_StatusDok = '01' and AR06_NoBil = @noBil";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@noBil", parNoBil);
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    test = rdr["AR06_Tarikh"].ToString();

                }

            }
            catch (Exception e)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return test;
        }
        //-----------------------

        //return Total Record transaksi bank
        public static string getTotalTransBank(string parKodBank, string parBulan,  string parTahun)
        {
            string test = "-";
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbV12;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"select count(*) as total
                from MK06_Transaksi
                where year(MK06_TkhTran) = @parTahun
                and month(MK06_TkhTran) = @parBulan
                and KodVot = @parKodBank";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@parKodBank", parKodBank);
                cmd.Parameters.AddWithValue("@parBulan", parBulan);
                cmd.Parameters.AddWithValue("@parTahun", parTahun);
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    test = rdr["total"].ToString();

                }

            }
            catch (Exception e)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return test;
        }
        //-----------------------



        //return Count Record transaksi bank yang telah ditransfer
        public static string getCountTransBank(string parKodBank, string parBulan, string parTahun)
        {
            string test = "-";
            string[] ret = new string[2];
            ret[0] = "no";
            List<string> myList = new List<string>();

            SqlDataReader rdr = null;
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {

                // Open connection to the database
                String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
                con = new SqlConnection(ConnectionString);
                con.Open();

                string CommandText = @"SELECT count(*) as kira FROM SMKB_TRANSAKSI_BANK 
                        WHERE YEAR(tarikh_transaksi) = @parTahun
                        AND MONTH(tarikh_transaksi) = @parBulan
                        AND Kod_Bank = @parKodBank ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@parKodBank", parKodBank);
                cmd.Parameters.AddWithValue("@parBulan", parBulan);
                cmd.Parameters.AddWithValue("@parTahun", parTahun);
                rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    test = rdr["kira"].ToString();
                }

                return test;

            }
            catch (Exception e)
            {

            }
            finally
            {
                if (rdr != null)
                    rdr.Close();

                if (con.State == ConnectionState.Open)
                    con.Close();
            }


            return test;
        }
        //-----------------------






        //return jika ada data penghutang filter by ID Penerima
        public bool semakIDPenghutangMaster(string idPenerima) //
        {
        //string test = "ok";
        string[] ret = new string[2];
        ret[0] = "no";
        List<string> myList = new List<string>();

       

        SqlDataReader rdr = null;
        SqlConnection con = null;
        SqlCommand cmd = null;

        try
        {

            // Open connection to the database
            String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
            con = new SqlConnection(ConnectionString);
            con.Open();

            string CommandText = "select Kod_Penghutang from SMKB_Penghutang_Master where no_rujukan = @idPenerima";

            cmd = new SqlCommand(CommandText);
            cmd.Connection = con;
            cmd.CommandText = CommandText;
            cmd.Parameters.AddWithValue("@idPenerima", idPenerima);
            rdr = cmd.ExecuteReader();

                if (rdr.Read())
                {
                    return true;
                }
                else
                {
                    return false;
                }

        }
        catch (Exception e)
        {

        }
        finally
        {
            if (rdr != null)
                rdr.Close();

            if (con.State == ConnectionState.Open)
                con.Close();
        }
            return false;

    }
    //-----------------------

    //return jika ada data penghutang filter by Nama Penerima
    public static bool semakNamaPenghutangMaster(string namaPenerima)
    {
            bool myBool = false;
        //string test = "ok";
        string[] ret = new string[2];
        ret[0] = "no";
        List<string> myList = new List<string>();


        SqlDataReader rdr = null;
        SqlConnection con = null;
        SqlCommand cmd = null;

        try
        {

            // Open connection to the database
            String ConnectionString = SQLAuth.dbase_dbsmkbbaru;
            con = new SqlConnection(ConnectionString);
            con.Open();

            string CommandText = "select Kod_Penghutang from SMKB_Penghutang_Master where Nama_Penghutang = @namaPenerima";

            cmd = new SqlCommand(CommandText);
            cmd.Connection = con;
            cmd.CommandText = CommandText;
            cmd.Parameters.AddWithValue("@namaPenerima", namaPenerima);
            rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    myBool = true;
                    break;

                }



            

        }
        catch (Exception e)
        {

        }
        finally
        {
            if (rdr != null)
                rdr.Close();

            if (con.State == ConnectionState.Open)
                con.Close();
        }
            return myBool;
    }
//-----------------------



public static IEnumerable<string> GetListData()
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

                string CommandText = " SELECT data1,data2 ";
                CommandText = CommandText + " FROM    smkb01_data  ";

                cmd = new SqlCommand(CommandText);
                cmd.Connection = con;
                cmd.CommandText = CommandText;
                cmd.Parameters.AddWithValue("@Emerg_id", "ff");
                rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    myList.Add(rdr["data1"].ToString());
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








    }
}