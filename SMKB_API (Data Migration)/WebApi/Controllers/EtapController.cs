using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebApi.Controllers
{
    public class EtapController : ApiController
    {
        public IEnumerable<string> Get()
        {
            return new string[] { "Connection OK" };
        }
        [Route("api/etap/{id}/{orderId}/{app_Id}/{mob_Id}/{logincode_Id}/{lat1}/{long1}")]
        public IEnumerable<string> Get(int id, string orderId, string app_Id, string mob_Id, string logincode_Id, string lat1, string long1)
        {

            if (id == 1)
            {
               // return new string[] { "khalid Connection OK" };
                return SQLEtap.finddataeTap(orderId.ToString());

            }
            if (id == 2)
            {
                return SQLEtap.GetetapResultNew(orderId.ToString());

                //return new string[] { "khalid 2222  " };
                //  return SQLSejahtera.GetStudentResultNew(user.UserName.ToString());

            }
            if (id == 3)
            {
                // return SQLSejahtera.GetStudentResultNew(orderId.ToString());
                return SQLEtap.CheckeTapQrcode(orderId.ToString(), app_Id);
               // return new string[] { "qrcode  " + app_Id };
                //  return SQLSejahtera.GetStudentResultNew(user.UserName.ToString());

            }
            return new string[] { "error" };
            //return SQLPerakam.GetPublicData(orderId);
            // return new string[] { "uuu" };
        }
    }
}
