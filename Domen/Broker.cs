using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.OleDb;
using System.Data;

namespace Domen
{
    public class Broker
    {
        OleDbConnection konekcija;
        OleDbCommand komanda;

        void konektujSe()
        {
            konekcija = new OleDbConnection(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|Baza.accdb;Persist Security Info=False;");
            komanda = konekcija.CreateCommand();
        }
        private static Broker broker;
        public static Broker dajBrokera()
        {
            if (broker == null)
            {
                broker = new Broker();
            }
            return broker;
        }
        private Broker()
        {
            konektujSe();
        }

        public Korisnik vratiKorisnika(string sifra, string email)
        {
            Korisnik k = new Korisnik();
            try
            {
                komanda.CommandText = "Select * from Korisnici where EMail='" + email + "' and Sifra='" + sifra + "'";
                komanda.CommandType = CommandType.Text;
                konekcija.Open();
                OleDbDataReader citac = komanda.ExecuteReader();
                if (citac.Read())
                {
                    k.KorisnikID = citac.GetInt32(0);
                    k.Ime = citac.GetString(1);
                    k.Prezime = citac.GetString(2);
                    k.Email = citac.GetString(3);
                    k.Sifra = citac.GetString(4);
                }
                return k;
            }
            catch (Exception e)
            {
                return null;
            }
            finally
            {
                if (konekcija != null)
                    konekcija.Close();
            }
        }
        public bool ubaciKorisnika(string ime, string prezime, string email, string sifra)
        {
            try
            {
                komanda.CommandText = "Insert into Korisnici (Ime, Prezime, EMail, Sifra) Values ('" + ime + "', '" + prezime + "', '" + email + "', '" + sifra + "')";
                komanda.CommandType = CommandType.Text;
                konekcija.Open();
                komanda.ExecuteNonQuery();
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
            finally
            {
                if (konekcija != null)
                    konekcija.Close();
            }
        }
        public bool ubaciInformacijeOFajlu(int korisnikID, string blobContainer, string blobName, string url, string contentType, string ext, DateTime datum, string tag, string velicina)
        {
            int rejting = 0;
            try
            {
                komanda.CommandText = "Insert into FileInfo (KorisnikID, BlobContainer, BlobName, Url, ContentType, [Ext], Datum, Tag, Velicina, Rejting) values (" + korisnikID + ", '" + blobContainer + "', '" + blobName + "', '" + url + "', '" + contentType + "', '" + ext + "', #" + datum + "#, '" + tag + "', '" + velicina + "', " + rejting + ")";
                komanda.CommandType = CommandType.Text;
                konekcija.Open();
                komanda.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
            finally
            {
                if (konekcija != null)
                    konekcija.Close();
            }
        }
        public bool izbrisiFajl(int fileID)
        {
            try
            {
                komanda.CommandText = "Delete * from FileInfo where FileID=" + fileID;
                komanda.CommandType = CommandType.Text;
                konekcija.Open();
                komanda.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
            finally
            {
                if (konekcija != null)
                    konekcija.Close();
            }
        }
        public bool objaviFajl(int fileID)
        {
            try
            {
                komanda.CommandText = "Update FileInfo set BlobContainer='public' where FileID=" + fileID;
                komanda.CommandType = CommandType.Text;
                konekcija.Open();
                komanda.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
            finally
            {
                if (konekcija != null)
                    konekcija.Close();
            }
        }
        public bool ubaciKomentar(int fileID, string ime, string prezime, string komentar, DateTime datum)
        {
            try
            {
                komanda.CommandText = "Insert into Komentari (FileID, Ime, Prezime, Komentar, Datum) values (" + fileID + ", '" + ime + "', '" + prezime + "', '" + komentar + "', #" + datum + "#)";
                komanda.CommandType = CommandType.Text;
                konekcija.Open();
                komanda.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
            finally
            {
                if (konekcija != null)
                    konekcija.Close();
            }
        }
        public Korisnik vratiUploadera(int korisnikID)
        {
            Korisnik k = new Korisnik();
            try
            {
                komanda.CommandText = "Select * from Korisnici where KorisnikID=" + korisnikID;
                komanda.CommandType = CommandType.Text;
                konekcija.Open();
                OleDbDataReader citac = komanda.ExecuteReader();
                if (citac.Read())
                {
                    k.KorisnikID = citac.GetInt32(0);
                    k.Ime = citac.GetString(1);
                    k.Prezime = citac.GetString(2);
                    k.Email = citac.GetString(3);
                    k.Sifra = citac.GetString(4);
                }
                return k;
            }
            catch (Exception e)
            {
                return null;
            }
            finally
            {
                if (konekcija != null)
                    konekcija.Close();
            }
        }
        public FileInfo vratiRejting(int fileID)
        {
            FileInfo video = new FileInfo();
            try
            {
                komanda.CommandText = "Select Rejting from FileInfo where FileID=" + fileID;
                komanda.CommandType = CommandType.Text;
                konekcija.Open();
                OleDbDataReader citac = komanda.ExecuteReader();
                if (citac.Read())
                {
                    video.Rejting = citac.GetInt32(0);
                }
                return video;
            }
            catch (Exception e)
            {
                return null;
            }
            finally
            {
                if (konekcija != null)
                    konekcija.Close();
            }
        }
        public bool dodajPlus(int fileID)
        {
            try
            {
                komanda.CommandText = "Update FileInfo set Rejting=Rejting+1 where FileID=" + fileID;
                komanda.CommandType = CommandType.Text;
                konekcija.Open();
                komanda.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
            finally
            {
                if (konekcija != null)
                    konekcija.Close();
            }
        }
        public bool dodajMinus(int fileID)
        {
            try
            {
                komanda.CommandText = "Update FileInfo set Rejting=Rejting+1 where FileID=" + fileID;
                komanda.CommandType = CommandType.Text;
                konekcija.Open();
                komanda.ExecuteNonQuery();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
            finally
            {
                if (konekcija != null)
                    konekcija.Close();
            }
        }
        public FileInfo vratiIDKorisnika(int fileID)
        {
            FileInfo fajl = new FileInfo();
            try
            {
                komanda.CommandText = "Select KorisnikID from FileInfo where FileID=" + fileID;
                komanda.CommandType = CommandType.Text;
                konekcija.Open();
                OleDbDataReader citac = komanda.ExecuteReader();
                if (citac.Read())
                {
                    fajl.KorisnikID = citac.GetInt32(0);
                }
                return fajl;
            }
            catch (Exception e)
            {
                return null;
            }
            finally
            {
                if (konekcija != null)
                    konekcija.Close();
            }
        }
    }
}
