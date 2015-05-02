using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Domen;
using System.IO;
using System.Drawing;

namespace WebRole1
{
    public partial class Video : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblTitle.Text = Request.QueryString["title"];
            if (Session["Ime"] != null)
            {
                lblDobrodoslica.Text = "Dobrodosao, " + Session["Ime"] + " " + Session["Prezime"];
                Korisnik k = Broker.dajBrokera().vratiKorisnika(Session["Sifra"].ToString(), Session["E-mail"].ToString());
                Session["ID"] = k.KorisnikID;
                lblDobrodoslica.Visible = true;
                RadButton1.Visible = true;
                radbtnLogIn.Visible = false;
                radbtnReg.Visible = false;
                RadMenu1.Items[0].Text = "Moji fajlovi";
                RadMenu1.Items[0].NavigateUrl = "~/Korisnici.aspx";
                lbl.Visible = false;
                RadButton3.Enabled = true;
                txtKomentar.Enabled = true;
            }
            else
            {
                lblDobrodoslica.Visible = false;
                RadButton1.Visible = false;
                radbtnLogIn.Visible = true;
                radbtnReg.Visible = true;
                RadMenu1.Items[0].Text = "pocetna";
                RadMenu1.Items[0].NavigateUrl = "~/Default.aspx";
                lbl.Text = "Morate se ulogovati da bi ste ostavili komentar...";
                lbl.Visible = true;
                RadButton3.Enabled = false;
                txtKomentar.Enabled = false;
            }
            lblBrojKomentara.Text = listaKomentara.Items.Count.ToString();
            Korisnik uploader = Broker.dajBrokera().vratiUploadera(Convert.ToInt32(Request.QueryString["korID"]));
            lblUploader.Text = uploader.Ime + " " + uploader.Prezime;
            Domen.FileInfo video = Broker.dajBrokera().vratiRejting(Convert.ToInt32(Request.QueryString["fileID"]));
            if (video.Rejting >= 0)
            {
                lblPlus.Text = "+" + video.Rejting.ToString();
                lblPlus.ForeColor = Color.Green;
            }
            else
            {
                lblPlus.Text = "-" + video.Rejting.ToString();
                lblPlus.ForeColor = Color.Red;
            }
        }

        protected void RadButton3_Click(object sender, EventArgs e)
        {
            Korisnik k = Broker.dajBrokera().vratiKorisnika(Session["Sifra"].ToString(), Session["E-mail"].ToString());
            Broker.dajBrokera().ubaciKomentar(Convert.ToInt32(Request.QueryString["fileID"]), k.Ime, k.Prezime, txtKomentar.Text, DateTime.Now);
            listaKomentara.DataBind();
        }

        protected void RadButton1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/Default.aspx");
        }

        protected void radbtnLogIn_Click(object sender, EventArgs e)
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

        protected void radbtnReg_Click(object sender, EventArgs e)
        {
            if (pnlLogin.Visible)
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
                    string title = Request.QueryString["title"];
                    string url = Request.QueryString["url"];
                    string korID = Request.QueryString["korID"];
                    string fileID=Request.QueryString["fileID"];
                    Response.Redirect("~/Video.aspx?title=" + title + "&url=" + url + "&korID=" + korID + "&fileID=" + fileID);
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
                    string title = Request.QueryString["title"];
                    string url = Request.QueryString["url"];
                    string korID = Request.QueryString["korID"];
                    string fileID = Request.QueryString["fileID"];
                    Response.Redirect("~/Video.aspx?title=" + title + "&url=" + url + "&korID=" + korID + "&fileID=" + fileID);
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

        protected void btnPlus_Click(object sender, ImageClickEventArgs e)
        {
            Broker.dajBrokera().dodajPlus(Convert.ToInt32(Request.QueryString["fileID"]));
            Domen.FileInfo video = Broker.dajBrokera().vratiRejting(Convert.ToInt32(Request.QueryString["fileID"]));
            if (video.Rejting >= 0)
            {
                lblPlus.Text = "+" + video.Rejting.ToString();
                lblPlus.ForeColor = Color.Green;
            }
            else
            {
                lblPlus.Text = "-" + video.Rejting.ToString();
                lblPlus.ForeColor = Color.Red;
            }
        }

        protected void btnMinus_Click(object sender, ImageClickEventArgs e)
        {
            Broker.dajBrokera().dodajMinus(Convert.ToInt32(Request.QueryString["fileID"]));
            Domen.FileInfo video = Broker.dajBrokera().vratiRejting(Convert.ToInt32(Request.QueryString["fileID"]));
            if (video.Rejting >= 0)
            {
                lblPlus.Text = "+" + video.Rejting.ToString();
                lblPlus.ForeColor = Color.Green;
            }
            else
            {
                lblPlus.Text = "-" + video.Rejting.ToString();
                lblPlus.ForeColor = Color.Red;
            }
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "download")
            {

                var blob = AzureStorageManager.Instanca.GetFilesContent(Globals.PUBLIC_CONTAINER, ((Label)e.Item.FindControl("lblVideo")).Text);

                MemoryStream mem = new MemoryStream();
                blob.DownloadToStream(mem);
                Response.ContentType = blob.Properties.ContentType;
                Response.AddHeader("Content-Disposition", "Attachment; filename=" + ((Label)e.Item.FindControl("lblVideo")).Text);
                Response.AddHeader("Content-Length", blob.Properties.Length.ToString());
                Response.BinaryWrite(mem.ToArray());

            }
            else if (e.CommandName == "play")
            {
                string url = AzureStorageManager.Instanca.vratiUri(((Label)e.Item.FindControl("lblVideo")).Text, Globals.PUBLIC_CONTAINER);
                Response.Redirect("~/Video.aspx?title=" + ((Label)e.Item.FindControl("lblVideo")).Text + "&url=" + url + "&korID=" + Request.QueryString["korID"] + "&fileID=" + ((Label)e.Item.FindControl("lblID")).Text);
            }
        }
    }
}