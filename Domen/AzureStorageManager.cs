using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.WindowsAzure.StorageClient;
using Microsoft.WindowsAzure;
using System.Web.UI.WebControls;
using System.IO;

namespace Domen
{
    public class AzureStorageManager
    {
        private static AzureStorageManager instanca;
        private CloudBlobClient blobClient;

        private AzureStorageManager()
        {
        }

        public static AzureStorageManager Instanca
        {
            get
            {
                if (instanca == null)
                {
                    instanca = new AzureStorageManager();
                    instanca.Initialize();
                }
                return instanca;
            }
        }

        private void Initialize()
        {
            CloudStorageAccount storageAccount = CloudStorageAccount.DevelopmentStorageAccount;

            blobClient = storageAccount.CreateCloudBlobClient();

            blobClient.Timeout = new System.TimeSpan(1,0,0);
            blobClient.ParallelOperationThreadCount = 2;

            CloudBlobContainer publicContainer = blobClient.GetContainerReference(Globals.PUBLIC_CONTAINER);
            if (publicContainer.CreateIfNotExist())
            {
                publicContainer.SetPermissions(new BlobContainerPermissions()
                {
                    PublicAccess = BlobContainerPublicAccessType.Container
                });
            }

            CloudBlobContainer privateContainer = blobClient.GetContainerReference(Globals.PRIVATE_CONTAINER);
            privateContainer.CreateIfNotExist();
            privateContainer.SetPermissions(new BlobContainerPermissions()
            {
                PublicAccess=BlobContainerPublicAccessType.Container
            });
        }
        private void StoreBlob(string blobContainer, string blobName, string contentType, System.IO.Stream data)
        {
            try
            {
                CloudBlob blob = blobClient.GetContainerReference(blobContainer).GetBlobReference(blobName);
                blob.Properties.ContentType = contentType;
               
                blob.UploadFromStream(data);
            }
            catch (Exception e)
            {
                string greska = string.Format("Greska pri smestaju blob-a: {0}", e.Message);
                System.Diagnostics.Trace.WriteLine(greska, "Greska");
            }
        }

        public void StoreFiles(string blobContainer, string blobName, string contentType, System.IO.Stream data)
        {
            StoreBlob(blobContainer, blobName, contentType, data);
        }

        public CloudBlob GetFilesContent(string blobContainer, string blobName)
        {
            var blob = blobClient.GetContainerReference(blobContainer).GetBlobReference(blobName);
            return blob;
            
        }

        public void Objavi(string blobName)
        {
            CloudBlob src = blobClient.GetContainerReference(Globals.PRIVATE_CONTAINER)
                .GetBlobReference(blobName);

            blobClient.GetContainerReference(Globals.PUBLIC_CONTAINER)
                .GetBlobReference(blobName).CopyFromBlob(src);

            src.DeleteIfExists();
        }
        public void izbrisiBlob(string containerName, string blobName)
        {
            var blob = blobClient.GetContainerReference(containerName).GetBlobReference(blobName);
            blob.DeleteIfExists();

        }
        public string vratiUri(string blobName, string container)
        {
            try
            {
                return blobClient.GetContainerReference(container).GetBlobReference(blobName).Uri.ToString();
            }
            catch (Exception e)
            {
                return "";
            }
        }
        public double vratiVelicinuFajla(string containerName, string blobName)
        {
            var blob = blobClient.GetContainerReference(containerName).GetBlobReference(blobName);
            return blob.Properties.Length / 1024;
        }
    }
}
