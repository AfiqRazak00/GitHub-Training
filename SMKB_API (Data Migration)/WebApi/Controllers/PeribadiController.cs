using System;
using System.Linq;
using System.Web.Http;
using System.Security.Claims;
using System.Collections.Generic;
using System.Web;
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

namespace WebAppKs.Controllers
{
    public class PeribadiController : ApiController
    {
       
        // GET: Peribadi
        [HttpGet]
        [Route("api/peribadi/{nostaf}")]
        public IEnumerable<string> Get(string nostaf)
        {
            return SQLPeribadi.GetPeribadi(nostaf);

        }
        [HttpGet]
        [Route("api/peribadi/sej/{nostaf}")]
        public IEnumerable<string> GetSejPen(string nostaf)
        {
            return SQLPeribadi.GetSej(nostaf);

        }
        [HttpGet]
        [Route("api/peribadi/pej/{nostaf}")]
        public IEnumerable<string> GetPej(string nostaf)
        {
            return SQLPeribadi.GetPer(nostaf);

        }
        [HttpGet]
        [Route("api/peribadi/cuti/{nostaf}")]
        public IEnumerable<string> Getcuti(string nostaf)
        {
            return SQLPeribadi.GetCuti(nostaf);

        }
        [HttpGet]
        [Route("api/peribadi/gelaran/{nostaf}")]
        public IEnumerable<string> GetGelaran(string nostaf)
        {
            return SQLPeribadi.GetGel(nostaf);

        }
        [HttpGet]
        [Route("api/peribadi/gaji/{nostaf}")]
        public IEnumerable<string> GetGaj(string nostaf)
        {
            return SQLPeribadi.GetGaji(nostaf);

        }
        [HttpGet]
        [Route("api/peribadi/cutikon/{nostaf}")]
        public IEnumerable<string> GetCutKon(string nostaf)
        {
            return SQLPeribadi.GetCutiKon(nostaf);

        }
        [HttpGet]
        [Route("api/peribadi/tempoh/{nostaf}")]
        public IEnumerable<string> GetTemp(string nostaf)
        {
            return SQLPeribadi.GetTempKhid(nostaf);

        }
        [HttpGet]
        [Route("api/peribadi/sejsemasa/{nostaf}")]
        public IEnumerable<string> GetSejSMS(string nostaf)
        {
            return SQLPeribadi.GetSejSem(nostaf);

        }
        [Route("api/peribadi/sejsemasa1/{nostaf}")]
        public IEnumerable<string> GetSejSMS1(string nostaf)
        {
            return SQLPeribadi.GetSejSem1(nostaf);

        }
        [Route("api/peribadi/elaun/{nostaf}")]
        public IEnumerable<string> GetEln(string nostaf)
        {
            return SQLPeribadi.GetElaun(nostaf);

        }
        [Route("api/peribadi/potongan/{nostaf}")]
        public IEnumerable<string> GetPtg(string nostaf)
        {
            return SQLPeribadi.GetPotongan(nostaf);

        }
        [Route("api/peribadi/jumelaun/{nostaf}")]
        public IEnumerable<string> GetGK(string nostaf)
        {
            return SQLPeribadi.GetGajiKasar(nostaf);

        }
        [Route("api/peribadi/jumpotongan/{nostaf}")]
        public IEnumerable<string> GetJP(string nostaf)
        {
            return SQLPeribadi.GetJumPotongan(nostaf);

        }
        [Route("api/peribadi/gajibersih/{nostaf}")]
        public IEnumerable<string> GetGB(string nostaf)
        {
            return SQLPeribadi.GetJumBersih(nostaf);

        }
    }

}