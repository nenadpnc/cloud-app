using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Domen;
using Microsoft.WindowsAzure.StorageClient;
using Microsoft.WindowsAzure;
using System.IO;

namespace WebRole1
{
    public partial class Korisnici : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Ime"] != null)
            {
                lblDobrodoslica.Text = "Dobrodosao, " + Session["Ime"] + " " + Session["Prezime"];
                Korisnik k = Broker.dajBrokera().vratiKorisnika(Session["Sifra"].ToString(), Session["E-mail"].ToString());
                Session["ID"] = k.KorisnikID;
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void RadButton5_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/Default.aspx");
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            Korisnik k = Broker.dajBrokera().vratiKorisnika(Session["Sifra"].ToString(), Session["E-mail"].ToString());
            
                foreach (string ime in Request.Files)
                {
                    var file = Request.Files[ime];
                    if (file.ContentLength != 0)
                    {
                        string blobIme = System.IO.Path.GetFileName(file.FileName);
                        string ext = System.IO.Path.GetExtension(file.FileName);
                        string ikona = vratiEkstenziju(ext);
                        DateTime datum = DateTime.Now;
                        string tag = vratiTag(ext);
                        string contentType = file.ContentType;
                        double x = file.ContentLength / 1048576;
                        string velicina = x.ToString() + " mb";

                        AzureStorageManager.Instanca.StoreFiles(Globals.PRIVATE_CONTAINER, blobIme, contentType, file.InputStream);
                        string url = AzureStorageManager.Instanca.vratiUri(blobIme, Globals.PRIVATE_CONTAINER);
                        Broker.dajBrokera().ubaciInformacijeOFajlu(k.KorisnikID, Globals.PRIVATE_CONTAINER, blobIme, url, contentType, ikona, datum, tag, velicina);
                        lblGreska.Visible = false;
                    }
                    else
                    {
                        lblGreska.Visible = true;
                        return;
                    }
                }
            ListaFajlova.DataBind();
            ListaVideo.DataBind();
            ListaMuzike.DataBind();
        }

        protected string vratiEkstenziju(string ext)
        {
            string s = ".exe .doc .wma .mp3 .pdf .jpg .jpeg .png .mpeg .mpg .zip .rar .txt .wmv";
            string[] a = s.Split(' ');
            for (int i = 0; i <= a.Length-1; i++)
            {
                if (ext==a[i])
                {
                    return ext+".png";
                }
            }
            return ".file.png";
        }

        protected string vratiTag(string ext)
        {
            if (ext == ".exe")
            {
                return "Aplikacija";
            }
            else if (ext == ".doc" || ext == ".txt")
            {
                return "Text";
            }
            else if (ext == ".mp3" || ext == ".wma")
            {
                return "Muzika";
            }
            else if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif" || ext == "bmp")
            {
                return "Slika";
            }
            else if (ext == ".wmv" || ext == ".mpeg" || ext == ".mpg" || ext==".avi" || ext==".mp4")
            {
                return "Video";
            }
            else if (ext == ".zip" || ext == ".rar" || ext == ".7zip")
            {
                return "Zip";
            }
            else
            {
                return "File";
            }
        }

        protected void ListaFajlova_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "download")
            {
               
                var blob = AzureStorageManager.Instanca.GetFilesContent(Globals.PRIVATE_CONTAINER, ((Label)e.Item.FindControl("lblBlobIme")).Text);

                MemoryStream mem = new MemoryStream();
                blob.DownloadToStream(mem);
                Response.ContentType = blob.Properties.ContentType;
                Response.AddHeader("Content-Disposition", "Attachment; filename=" + ((Label)e.Item.FindControl("lblBlobIme")).Text);
                Response.AddHeader("Content-Length", blob.Properties.Length.ToString());
                Response.BinaryWrite(mem.ToArray());

            }
            else if (e.CommandName == "obrisi")
            {
                AzureStorageManager.Instanca.izbrisiBlob(Globals.PRIVATE_CONTAINER, ((Label)e.Item.FindControl("lblBlobIme")).Text);
                Broker.dajBrokera().izbrisiFajl(Convert.ToInt32(((Label)e.Item.FindControl("lblID")).Text));
                ListaFajlova.DataBind();
            }
            else if (e.CommandName == "link")
            {
                string url = AzureStorageManager.Instanca.vratiUri(((Label)e.Item.FindControl("lblBlobIme")).Text, Globals.PRIVATE_CONTAINER);
                Response.Redirect(url);
            }
            else if (e.CommandName == "objavi")
            {
                AzureStorageManager.Instanca.Objavi(((Label)e.Item.FindControl("lblBlobIme")).Text);
                Broker.dajBrokera().objaviFajl(Convert.ToInt32(((Label)e.Item.FindControl("lblID")).Text));
                ListaFajlova.DataBind();
                ListaObjavljenihFajlova.DataBind();
            }
        }

        protected void ListaObjavljenihFajlova_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "download")
            {

                var blob = AzureStorageManager.Instanca.GetFilesContent(Globals.PUBLIC_CONTAINER, ((Label)e.Item.FindControl("lblBlobImePublic")).Text);

                MemoryStream mem = new MemoryStream();
                blob.DownloadToStream(mem);
                Response.ContentType = blob.Properties.ContentType;
                Response.AddHeader("Content-Disposition", "Attachment; filename=" + ((Label)e.Item.FindControl("lblBlobImePublic")).Text);
                Response.AddHeader("Content-Length", blob.Properties.Length.ToString());
                Response.BinaryWrite(mem.ToArray());

            }
            else if (e.CommandName == "obrisi")
            {
                AzureStorageManager.Instanca.izbrisiBlob(Globals.PUBLIC_CONTAINER, ((Label)e.Item.FindControl("lblBlobImePublic")).Text);
                Broker.dajBrokera().izbrisiFajl(Convert.ToInt32(((Label)e.Item.FindControl("lblIDPublic")).Text));
                ListaObjavljenihFajlova.DataBind();
            }
            else if (e.CommandName == "link")
            {
                
                string url = AzureStorageManager.Instanca.vratiUri(((Label)e.Item.FindControl("lblBlobImePublic")).Text, Globals.PUBLIC_CONTAINER);
                Response.Redirect(url);
            }
        }

        protected void ListaVideo_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "download")
            {
                var blob = AzureStorageManager.Instanca.GetFilesContent(Globals.PRIVATE_CONTAINER, ((Label)e.Item.FindControl("lblVideo")).Text);

                MemoryStream mem = new MemoryStream();
                blob.DownloadToStream(mem);
                Response.ContentType = blob.Properties.ContentType;
                Response.AddHeader("Content-Disposition", "Attachment; filename=" + ((Label)e.Item.FindControl("lblVideo")).Text);
                Response.AddHeader("Content-Length", blob.Properties.Length.ToString());
                Response.BinaryWrite(mem.ToArray());

            }
            else if (e.CommandName == "obrisi")
            {
                AzureStorageManager.Instanca.izbrisiBlob(Globals.PRIVATE_CONTAINER, ((Label)e.Item.FindControl("lblVideo")).Text);
                Broker.dajBrokera().izbrisiFajl(Convert.ToInt32(((Label)e.Item.FindControl("lblVideoID")).Text));
                ListaVideo.DataBind();
            }
            else if (e.CommandName == "play")
            {
                string url = AzureStorageManager.Instanca.vratiUri(((Label)e.Item.FindControl("lblVideo")).Text, Globals.PRIVATE_CONTAINER);
                Response.Redirect("~/Video.aspx?title=" + ((Label)e.Item.FindControl("lblVideo")).Text + "&url=" + url + "&korID=" + Session["ID"].ToString() + "&fileID=" + ((Label)e.Item.FindControl("lblVideoID")).Text);
            }
            else if (e.CommandName == "objavi")
            {
                AzureStorageManager.Instanca.Objavi(((Label)e.Item.FindControl("lblVideo")).Text);
                Broker.dajBrokera().objaviFajl(Convert.ToInt32(((Label)e.Item.FindControl("lblVideoID")).Text));
                ListaVideo.DataBind();
                ListaVideoPublic.DataBind();
            }
        }

        protected void ListaVideoPublic_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "download")
            {

                var blob = AzureStorageManager.Instanca.GetFilesContent(Globals.PUBLIC_CONTAINER, ((Label)e.Item.FindControl("lblVideoPublic")).Text);

                MemoryStream mem = new MemoryStream();
                blob.DownloadToStream(mem);
                Response.ContentType = blob.Properties.ContentType;
                Response.AddHeader("Content-Disposition", "Attachment; filename=" + ((Label)e.Item.FindControl("lblVideoPublic")).Text);
                Response.AddHeader("Content-Length", blob.Properties.Length.ToString());
                Response.BinaryWrite(mem.ToArray());

            }
            else if (e.CommandName == "obrisi")
            {
                AzureStorageManager.Instanca.izbrisiBlob(Globals.PUBLIC_CONTAINER, ((Label)e.Item.FindControl("lblVideoPublic")).Text);
                Broker.dajBrokera().izbrisiFajl(Convert.ToInt32(((Label)e.Item.FindControl("lblVideoIDPublic")).Text));
                ListaVideoPublic.DataBind();
            }
            else if (e.CommandName == "play")
            {
                string url = AzureStorageManager.Instanca.vratiUri(((Label)e.Item.FindControl("lblVideoPublic")).Text, Globals.PUBLIC_CONTAINER);
                Response.Redirect("~/Video.aspx?title=" + ((Label)e.Item.FindControl("lblVideoPublic")).Text + "&url=" + url + "&korID=" + Session["ID"].ToString() + "&fileID=" + ((Label)e.Item.FindControl("lblVideoIDPublic")).Text);
            }
        }

        protected void ListaMuzike_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "download")
            {
                var blob = AzureStorageManager.Instanca.GetFilesContent(Globals.PRIVATE_CONTAINER, ((Label)e.Item.FindControl("lblMuzika")).Text);

                MemoryStream mem = new MemoryStream();
                blob.DownloadToStream(mem);
                Response.ContentType = blob.Properties.ContentType;
                Response.AddHeader("Content-Disposition", "Attachment; filename=" + ((Label)e.Item.FindControl("lblMuzika")).Text);
                Response.AddHeader("Content-Length", blob.Properties.Length.ToString());
                Response.BinaryWrite(mem.ToArray());

            }
            else if (e.CommandName == "obrisi")
            {
                AzureStorageManager.Instanca.izbrisiBlob(Globals.PRIVATE_CONTAINER, ((Label)e.Item.FindControl("lblMuzika")).Text);
                Broker.dajBrokera().izbrisiFajl(Convert.ToInt32(((Label)e.Item.FindControl("lblMuzikaID")).Text));
                ListaMuzike.DataBind();
            }
            else if (e.CommandName == "play")
            {
                string url = AzureStorageManager.Instanca.vratiUri(((Label)e.Item.FindControl("lblMuzika")).Text, Globals.PRIVATE_CONTAINER);
                Response.Redirect("~/Muzika.aspx?title=" + ((Label)e.Item.FindControl("lblMuzika")).Text + "&url=" + url + "&korID=" + Session["ID"].ToString() + "&fileID=" + ((Label)e.Item.FindControl("lblMuzikaID")).Text);
            }
            else if (e.CommandName == "objavi")
            {
                AzureStorageManager.Instanca.Objavi(((Label)e.Item.FindControl("lblMuzika")).Text);
                Broker.dajBrokera().objaviFajl(Convert.ToInt32(((Label)e.Item.FindControl("lblMuzikaID")).Text));
                ListaMuzike.DataBind();
                ListaObjavljeneMuzike.DataBind();
            }
        }

        protected void ListaObjavljeneMuzike_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "download")
            {

                var blob = AzureStorageManager.Instanca.GetFilesContent(Globals.PUBLIC_CONTAINER, ((Label)e.Item.FindControl("lblMuzikaPublic")).Text);

                MemoryStream mem = new MemoryStream();
                blob.DownloadToStream(mem);
                Response.ContentType = blob.Properties.ContentType;
                Response.AddHeader("Content-Disposition", "Attachment; filename=" + ((Label)e.Item.FindControl("lblMuzikaPublic")).Text);
                Response.AddHeader("Content-Length", blob.Properties.Length.ToString());
                Response.BinaryWrite(mem.ToArray());

            }
            else if (e.CommandName == "obrisi")
            {
                AzureStorageManager.Instanca.izbrisiBlob(Globals.PUBLIC_CONTAINER, ((Label)e.Item.FindControl("lblMuzikaPublic")).Text);
                Broker.dajBrokera().izbrisiFajl(Convert.ToInt32(((Label)e.Item.FindControl("lblMuzikaPublicID")).Text));
                ListaObjavljeneMuzike.DataBind();
            }
            else if (e.CommandName == "play")
            {
                string url = AzureStorageManager.Instanca.vratiUri(((Label)e.Item.FindControl("lblMuzikaPublic")).Text, Globals.PUBLIC_CONTAINER);
                Response.Redirect("~/Muzika.aspx?title=" + ((Label)e.Item.FindControl("lblMuzikaPublic")).Text + "&url=" + url + "&korID=" + Session["ID"].ToString() + "&fileID=" + ((Label)e.Item.FindControl("lblMuzikaPublicID")).Text);
            }
        }

    }
}