using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Domen;

namespace WebRole1
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RadButton1_Click(object sender, EventArgs e)
        {
            if (pnlReg.Visible)
            {
                pnlReg.Visible = false;
            }

            if (pnlLogin.Visible)
            {
                pnlLogin.Visible = false;
            }
            else
            {
                pnlLogin.Visible = true;
            }
        }

        protected void RadButton2_Click(object sender, EventArgs e)
        {
            if(pnlLogin.Visible)
            {
                pnlLogin.Visible = false;
            }

            if (pnlReg.Visible)
            {
                pnlReg.Visible = false;
            }
            else
            {
                pnlReg.Visible = true;
            }
        }

        protected void lbLogin_Click1(object sender, EventArgs e)
        {
            Korisnik korisnik = Broker.dajBrokera().vratiKorisnika(txtSifra.Text, txtEmail.Text);

            if (korisnik != null)
            {
                if (korisnik.Ime != null)
                {
                    Session["Ime"] = korisnik.Ime;
                    Session["Prezime"] = korisnik.Prezime;
                    Session["E-mail"] = korisnik.Email;
                    Session["Sifra"] = korisnik.Sifra;
                    Response.Redirect("~/Korisnici.aspx");
                }
                else
                {
                    lblErrorLogin.Visible = true;
                }
            }
            else
            {
                lblErrorLogin.Visible = true;
            }
        }

        protected void lbReg_Click1(object sender, EventArgs e)
        {
            if (txtIme.Text != "" || txtPrezime.Text != "" || txtEmail1.Text != "" || txtSifra1.Text != "")
            {
                if (Broker.dajBrokera().ubaciKorisnika(txtIme.Text, txtPrezime.Text, txtEmail1.Text, txtSifra1.Text))
                {
                    Session["Ime"] = txtIme.Text;
                    Session["Prezime"] = txtPrezime.Text;
                    Session["E-mail"] = txtEmail1.Text;
                    Session["Sifra"] = txtSifra1.Text;
                    Response.Redirect("~/Korisnici.aspx");
                }
                else
                {
                    lblErrorReg.Visible = true;
                }
            }
            else
            {
                lblErrorReg.Visible = true;
            }
        }

        protected void btnVideo_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pretraga.aspx?upit=" + txtPretraga.Text + "&tr=video");
        }

        protected void btnMuzika_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pretraga.aspx?upit=" + txtPretraga.Text + "&tr=muzika");
        }

        protected void btnFajlovi_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Pretraga.aspx?upit=" + txtPretraga.Text + "&tr=fajlovi");
        }
    }
}
