using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Domen;
using System.IO;

namespace WebRole1
{
    public partial class Pretraga : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
            }
            else
            {
                lblDobrodoslica.Visible = false;
                RadButton1.Visible = false;
                radbtnLogIn.Visible = true;
                radbtnReg.Visible = true;
                RadMenu1.Items[0].Text = "pocetna";
                RadMenu1.Items[0].NavigateUrl = "~/Default.aspx";
            }
            if (Request.QueryString["tr"] == "video")
            {
                AccessDataSource1.SelectCommand = "Select * from FileInfo where Tag='Video' and BlobContainer='public' and BlobName Like '%" + Request.QueryString["upit"] + "%'";
                ListaVideo.DataBind();
            }
            else if (Request.QueryString["tr"] == "muzika")
            {
                AccessDataSource2.SelectCommand = "Select * from FileInfo where Tag='Muzika' and BlobContainer='public' and BlobName Like '%" + Request.QueryString["upit"] + "%'";
                ListaMuzika.DataBind();
            }
            else if (Request.QueryString["tr"] == "fajlovi")
            {
                AccessDataSource3.SelectCommand = "Select * from FileInfo where Tag<>'Video' and Tag<>'Muzika' and BlobContainer='public' and BlobName Like '%" + Request.QueryString["upit"] + "%'";
                ListaFajlova.DataBind();
            }
        }

        protected void RadButton1_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/Default.aspx");
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
                    Response.Redirect("~/Pretraga.aspx");
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
                    Response.Redirect("~/Pretraga.aspx");
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

        protected void btnVideo_Click(object sender, EventArgs e)
        {
            AccessDataSource1.SelectCommand = "Select * from FileInfo where Tag='Video' and BlobContainer='public' and BlobName Like '%" + txtUpit.Text + "%'";
            ListaVideo.DataBind();
            AccessDataSource2.SelectCommand = "";
            ListaFajlova.DataBind();
            AccessDataSource3.SelectCommand = "";
            ListaMuzika.DataBind();
            if (ListaVideo.Items.Count == 0)
            {
                lblNemaRezultata.Text = "Nema rezultata pretrage...";
                lblNemaRezultata.Visible = true;
            }
            else
            {
                lblNemaRezultata.Visible = false;
            }
        }

        protected void btnMuzika_Click(object sender, EventArgs e)
        {
            AccessDataSource2.SelectCommand = "Select * from FileInfo where Tag='Muzika' and BlobContainer='public' and BlobName Like '%" + txtUpit.Text + "%'";
            ListaMuzika.DataBind();
            AccessDataSource1.SelectCommand = "";
            ListaVideo.DataBind();
            AccessDataSource3.SelectCommand = "";
            ListaFajlova.DataBind();
            if (ListaMuzika.Items.Count == 0)
            {
                lblNemaRezultata.Text = "Nema rezultata pretrage...";
                lblNemaRezultata.Visible = true;
            }
            else
            {
                lblNemaRezultata.Visible = false;
            }
        }

        protected void btnFajl_Click(object sender, EventArgs e)
        {
            AccessDataSource3.SelectCommand = "Select * from FileInfo where Tag<>'Video' and Tag<>'Muzika' and BlobContainer='public' and BlobName Like '%" + txtUpit.Text + "%'";
            ListaFajlova.DataBind();
            AccessDataSource1.SelectCommand = "";
            AccessDataSource2.SelectCommand = "";
            ListaMuzika.DataBind();
            ListaVideo.DataBind();
            if (ListaFajlova.Items.Count == 0)
            {
                lblNemaRezultata.Text = "Nema rezultata pretrage...";
                lblNemaRezultata.Visible = true;
            }
            else
            {
                lblNemaRezultata.Visible = false;
            }
        }

        protected void ListaVideo_ItemCommand(object source, DataListCommandEventArgs e)
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
                Domen.FileInfo video = Broker.dajBrokera().vratiIDKorisnika(Convert.ToInt32(((Label)e.Item.FindControl("lblVideo")).Text));
                Response.Redirect("~/Video.aspx?title=" + ((Label)e.Item.FindControl("lblVideo")).Text + "&url=" + url + "&korID=" + video.KorisnikID + "&fileID=" + ((Label)e.Item.FindControl("lblID")).Text);
            }
        }

        protected void ListaMuzika_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "download")
            {

                var blob = AzureStorageManager.Instanca.GetFilesContent(Globals.PUBLIC_CONTAINER, ((Label)e.Item.FindControl("lblMuzika")).Text);

                MemoryStream mem = new MemoryStream();
                blob.DownloadToStream(mem);
                Response.ContentType = blob.Properties.ContentType;
                Response.AddHeader("Content-Disposition", "Attachment; filename=" + ((Label)e.Item.FindControl("lblMuzika")).Text);
                Response.AddHeader("Content-Length", blob.Properties.Length.ToString());
                Response.BinaryWrite(mem.ToArray());

            }
            else if (e.CommandName == "play")
            {
                string url = AzureStorageManager.Instanca.vratiUri(((Label)e.Item.FindControl("lblMuzika")).Text, Globals.PUBLIC_CONTAINER);
                Response.Redirect("~/Video.aspx?title=" + ((Label)e.Item.FindControl("lblMuzika")).Text + "&url=" + url);
            }
        }

        protected void ListaFajlova_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "download")
            {

                var blob = AzureStorageManager.Instanca.GetFilesContent(Globals.PUBLIC_CONTAINER, ((Label)e.Item.FindControl("lblFajl")).Text);

                MemoryStream mem = new MemoryStream();
                blob.DownloadToStream(mem);
                Response.ContentType = blob.Properties.ContentType;
                Response.AddHeader("Content-Disposition", "Attachment; filename=" + ((Label)e.Item.FindControl("lblFajl")).Text);
                Response.AddHeader("Content-Length", blob.Properties.Length.ToString());
                Response.BinaryWrite(mem.ToArray());

            }
        }
    }
}