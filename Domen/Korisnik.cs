using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Domen
{
    public class Korisnik
    {
        int korisnikID;

        string ime;

        string prezime;

        string email;

        string sifra;

        public string Sifra
        {
            get { return sifra; }
            set { sifra = value; }
        }

        public string Email
        {
            get { return email; }
            set { email = value; }
        }

        public string Prezime
        {
            get { return prezime; }
            set { prezime = value; }
        }

        public string Ime
        {
            get { return ime; }
            set { ime = value; }
        }

        public int KorisnikID
        {
            get { return korisnikID; }
            set { korisnikID = value; }
        }
    }
}
