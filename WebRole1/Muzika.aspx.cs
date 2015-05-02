using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Domen;
using System.Drawing;

namespace WebRole1
{
    public partial class Muzika : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblBrojKomentara.Text = ListaKomentara.Items.Count.ToString();
            Korisnik uploader = Broker.dajBrokera().vratiUploadera(Convert.ToInt32(Request.QueryString["korID"]));
            lblUploader.Text = uploader.Ime + " " + uploader.Prezime;
            Domen.FileInfo muzika = Broker.dajBrokera().vratiRejting(Convert.ToInt32(Request.QueryString["fileID"]));
            if (muzika.Rejting >= 0)
            {
                lblRejting.Text = "+" + muzika.Rejting.ToString();
                lblRejting.ForeColor = Color.Green;
            }
            else
            {
                lblRejting.Text = "-" + muzika.Rejting.ToString();
                lblRejting.ForeColor = Color.Red;
            }
        }
    }
}