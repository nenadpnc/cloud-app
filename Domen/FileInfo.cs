using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Domen
{
    public class FileInfo
    {
        
        int korisnikID;
        int rejting;

        public int Rejting
        {
            get { return rejting; }
            set { rejting = value; }
        }

        public int KorisnikID
        {
            get { return korisnikID; }
            set { korisnikID = value; }
        }
    }
}
