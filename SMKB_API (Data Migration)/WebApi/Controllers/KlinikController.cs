using WebAppKs.Services;
using System.Net.Http;
using System.Net;
using System.Threading.Tasks;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;



using System.Web;
using Microsoft.Owin.Security.Provider;

public class KlinikController : ApiController
{

    // GET: Klinik
    [HttpGet]
    [Route("api/klinik/{staffno}")]
    public IEnumerable<string> Get(string staffno)
    {
        return SQLKlinik.GetKlinik(staffno);
    }
    [HttpGet]
    [Route("api/klinik/Alamat/{staffno}")]
    public IEnumerable<string> GetAlamat(string staffno)
    {
        return SQLKlinik.GetAlaKlinik(staffno);
    }

}




//using WebAppKs.Services;
//using System.Net.Http;
//using System.Net;
//using System.Threading.Tasks;
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Net;
//using System.Net.Http;
//using System.Web.Http;



//using System.Web;
//using Microsoft.Owin.Security.Provider;

//public class KlinikController : ApiController
//{
//    // GET: Klinik
//    [HttpGet]
//    [Route("api/klinik/{staffno}")]
//    public IEnumerable<string> Get(string staffno)
//    {
//        return SQLKlinik.GetKlinik(staffno);
//    }
//    [HttpGet]
//    [Route("api/klinik/Alamat/{staffno}")]
//    public IEnumerable<string> GetAlamat(string staffno)
//    {
//        return SQLKlinik.GetAlaKlinik(staffno);
//    }

//}


