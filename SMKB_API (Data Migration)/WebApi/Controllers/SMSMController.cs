using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApi.Models;
//https://mobileapp.utem.edu.my/SMSM/Create?id=00578&jenis=Sokong&authorId=6565
//https://mobileapp.utem.edu.my/SMSM/Create?id=00578&jenis=TakSokong&authorId=6565
namespace WebApi.Controllers
{
    public class SMSMController : Controller
    {
        // GET: SMSM
        public ActionResult Index()
        {
            return View();
        }
     

        // GET: SMSM/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: SMSM/Create
        [HttpGet]
        public ActionResult Create(string id, string jenis, string authorId)
        {
            if (jenis == "Sokong")
            {

                ViewBag.Message = "Pengesahan Kelulusan Cuti";
                ViewData["SecureId"] = authorId.ToString();
                ViewData["Staffno"] = id;
                IEnumerable<string> valuesxx = SQLCutiTetap.SemakMohonCutiDetail(id, authorId.ToString());
                var myListxx = valuesxx.ToList();
                if (myListxx[0] == "no") {
                    ViewBag.Message = "Ralat : Permintaan tidak sah.";
                    return View("Error");
                }
                else
                {
                    ViewData["Nama"] = myListxx[0];
                    ViewData["TarikhDari"] = myListxx[1];
                    ViewData["JumlahHari"] = myListxx[2];
                    ViewData["SebabCuti"] = myListxx[3];
                    return View("Sokong");
                }
            }else if (jenis == "TidakSokong")
            {
                ViewBag.Message = "Pengesahan Kelulusan Cuti";
                ViewData["SecureId"] = authorId.ToString();
                ViewData["Staffno"] = id;
                IEnumerable<string> valuesxx = SQLCutiTetap.SemakMohonCutiDetail(id, authorId.ToString());
                var myListxx = valuesxx.ToList();
                if (myListxx[0] == "no")
                {
                    ViewBag.Message = "Ralat : Permintaan tidak sah.";
                    return View("Error");
                }
                else
                {
                    ViewData["Nama"] = myListxx[0];
                    ViewData["TarikhDari"] = myListxx[1];
                    ViewData["JumlahHari"] = myListxx[2];
                    ViewData["SebabCuti"] = myListxx[3];
                    return View("TakSokong");
                }
            }
            else
            {
                ViewBag.Message = "Ralat : Permintaan tidak sah.";
                return View("Error");
            }
        }

        // POST: SMSM/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                if (collection[8] == "Sokong")
                {
                    string stat = SQLMigs.UpdateCutiDariPenyokong(collection[2], collection[1], SQLMigs.GetCutiID(collection[1]), "Sokong", SQLMigs.GetIDSokong(collection[2]), "");
                    if (stat == "ok") {
                        ViewBag.Message = "Pengesahan Kelulusan Cuti";
                        ViewData["SecureId"] = collection[1];
                        ViewData["Staffno"] = collection[2];
                        ViewData["Nama"] = collection[3];
                        ViewData["TarikhDari"] = collection[4];
                        ViewData["JumlahHari"] = collection[6];
                        ViewData["SebabCuti"] = collection[7];
                        //hantar email
                        string hh = SQLMigs.HantarEmali_SokongStatus(SQLMigs.GetCutiID(collection[1]));
                        return View("IndexSokong");
                    }
                    else
                    {
                        ViewBag.Message = "Ralat : Permintaan tidak sah.";
                        return View("Error");
                    }
                }
                else if (collection[8] == "TakSokong")
                {
                    string stat2 = SQLMigs.UpdateCutiDariPenyokong(collection[2], collection[1], SQLMigs.GetCutiID(collection[1]), "Tidak Sokong", SQLMigs.GetIDSokong(collection[2]), collection[9]);
                    if (stat2 == "ok")
                    {
                        ViewBag.Message = "Pengesahan Kelulusan Cuti";
                        ViewData["SecureId"] = collection[1];
                        ViewData["Staffno"] = collection[2];
                        ViewData["Nama"] = collection[3];
                        ViewData["TarikhDari"] = collection[4];
                        ViewData["JumlahHari"] = collection[6];
                        ViewData["SebabCuti"] = collection[7];
                        ViewData["Nota"] = collection[9];
                        //hantar email
                        string hh = SQLMigs.HantarEmali_SokongStatus(SQLMigs.GetCutiID(collection[1]));
                        return View("IndexTakSokong");
                    }
                    else
                    {
                        ViewBag.Message = "Ralat : Permintaan tidak sah.";
                        return View("Error");
                    }
                }
                else
                {
                    ViewBag.Message = "Ralat : Permintaan tidak sah.";
                    return View("Error");
                }
            }
            catch
            {
                ViewBag.Message = "Ralat : Permintaan tidak sah.";
                return View("Error");
            }
        }

        // GET: SMSM/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: SMSM/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: SMSM/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: SMSM/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
