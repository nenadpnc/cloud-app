<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Korisnici.aspx.cs" Inherits="WebRole1.Korisnici" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Button.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Input.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Upload.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Menu.cloud.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {            width: 346px;
        }
        .style3
        {
            width: 474px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <telerik:RadScriptManager ID="ScriptManager1" runat="server" 
    EnableTheming="True">
    <Scripts>
        <asp:ScriptReference Assembly="Telerik.Web.UI" 
            Name="Telerik.Web.UI.Common.Core.js">
        </asp:ScriptReference>
        <asp:ScriptReference Assembly="Telerik.Web.UI" 
            Name="Telerik.Web.UI.Common.jQuery.js">
        </asp:ScriptReference>
        <asp:ScriptReference Assembly="Telerik.Web.UI" 
            Name="Telerik.Web.UI.Common.jQueryInclude.js">
        </asp:ScriptReference>
    </Scripts>
    </telerik:RadScriptManager>
    <br />
    <table style="width:97%;">
        <tr>
            <td class="style3"> 
             <telerik:RadUpload ID="RadUpload1" EnableEmbeddedSkins="false" Skin="cloud" 
                    Runat="server" InputSize="50" Width="475px">
             <Localization Add="Dodaj" Clear="Obrisi" Delete="Izbaci" Remove="Izbaci fajl" Select="Izaberi fajl" />
             </telerik:RadUpload>
                <br />
                <telerik:RadProgressArea ID="RadProgressArea1" Runat="server" 
                    EnableEmbeddedSkins="False" Skin="cloud" 
                    ProgressIndicators="TotalProgressBar, TotalProgress, TotalProgressPercent, RequestSize, FilesCount, FilesCountPercent, CurrentFileName, TimeElapsed, TimeEstimated, TransferSpeed">
<Localization Uploaded="Uploaded" Cancel="Ponisti" ElapsedTime="Proteklo vreme: " 
                        EstimatedTime="Preostalo vreme: " Total="Ukupno " TotalFiles="Ukupno fajlova: " 
                        TransferSpeed="Brzina: "></Localization>
                </telerik:RadProgressArea>
            </td>
            <td valign="top">
             <telerik:RadButton ID="btnUplad" OnClick="btnUpload_Click" EnableEmbeddedSkins="false" Skin="cloud" runat="server" Text="Upload">
             </telerik:RadButton>
                &nbsp;<asp:Label ID="lblGreska" runat="server" Text="Morate izabrati fajl..." 
                    Visible="False"></asp:Label>
                <telerik:RadProgressManager ID="RadProgressManager1" Runat="server" />
            </td>
        </tr>
    </table>
    <table style="border: thin solid #DBDBDB; width:92%;" frame="border">
        <tr>
            <td class="style1" valign="top">
                 Moji privatni fajlovi:</td>
            <td class="style1" align="left" valign="top">
                Moji objavljeni fajlovi:</td>
        </tr>
        <tr>
            <td class="style1" valign="top" style="border: thin solid #DBDBDB">
                 <asp:DataList ID="ListaFajlova" runat="server" 
        DataSourceID="AccessDataSource1" DataKeyField="FileID" Width="446px" 
        onitemcommand="ListaFajlova_ItemCommand">
        <ItemTemplate>
            <asp:Image ID="Image1" runat="server" 
    ImageUrl='<%# Eval("Ext", "~/Ikone/{0}") %>' />
            &nbsp;<asp:Label ID="lblBlobIme" runat="server" Text='<%# Eval("BlobName") %>'></asp:Label>
            &nbsp;|
            <asp:Label ID="Label3" runat="server" Text='<%# Eval("Velicina") %>'></asp:Label>
            &nbsp;|
            <asp:Label ID="Label4" runat="server" Text='<%# Eval("Datum", "{0:g}") %>'></asp:Label>
            <asp:Label ID="lblID" runat="server" Text='<%# Eval("FileID") %>' 
                Visible="False"></asp:Label>
            &nbsp;<p>
            <telerik:RadButton ID="btnDownload" runat="server" Text="Download" 
                EnableEmbeddedSkins="false" Skin="cloud" CommandName="download">
            </telerik:RadButton>
            &nbsp;<telerik:RadButton ID="btnObrisi" runat="server" CommandName="obrisi" 
                EnableEmbeddedSkins="False" Skin="cloud" Text="Obrisi">
            </telerik:RadButton>
            &nbsp;<telerik:RadButton ID="btnLink" runat="server" CommandName="link" 
                EnableEmbeddedSkins="False" Skin="cloud" Text="Link">
            </telerik:RadButton>
            &nbsp;<telerik:RadButton ID="RadButton4" runat="server" CommandName="objavi" 
                EnableEmbeddedSkins="False" Skin="cloud" Text="Objavi">
            </telerik:RadButton>
            </p>
        </ItemTemplate>
    </asp:DataList>
    <asp:AccessDataSource ID="AccessDataSource1" runat="server" 
        DataFile="~/App_Data/Baza.accdb" 
        
                     
                     SelectCommand="SELECT * FROM [FileInfo] WHERE (([KorisnikID] = ?) AND ([BlobContainer] = ?) AND ([Tag] &lt;&gt; ?) AND ([Tag] &lt;&gt; ?)) ORDER BY [Datum] DESC">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0" Name="KorisnikID" SessionField="ID" 
                Type="Int32" />
            <asp:Parameter DefaultValue="private" Name="BlobContainer" Type="String" />
            <asp:Parameter DefaultValue="Video" Name="Tag" Type="String" />
            <asp:Parameter DefaultValue="Muzika" Name="Tag2" Type="String" />
        </SelectParameters>
    </asp:AccessDataSource></td>
            <td class="style1" align="left" valign="top" style="border: thin solid #DBDBDB">
                <asp:DataList ID="ListaObjavljenihFajlova" runat="server" DataKeyField="FileID" 
                    DataSourceID="AccessDataSource2" Width="459px" 
                    onitemcommand="ListaObjavljenihFajlova_ItemCommand">
                    <ItemTemplate>
                        <asp:Image ID="Image2" runat="server" 
                            ImageUrl='<%# Eval("Ext", "~/Ikone/{0}") %>' />
                        &nbsp;<asp:Label ID="lblBlobImePublic" runat="server" 
                            Text='<%# Eval("BlobName") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("Velicina") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("Datum", "{0:g}") %>'></asp:Label>
                        <asp:Label ID="lblIDPublic" runat="server" Text='<%# Eval("FileID") %>' 
                            Visible="False"></asp:Label>
                       <p />

                        <telerik:RadButton ID="RadButton1" runat="server" CommandName="download" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Download">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton2" runat="server" CommandName="obrisi" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Obrisi">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton3" runat="server" EnableEmbeddedSkins="False" 
                            Skin="cloud" Text="Link" CommandName="link">
                        </telerik:RadButton>

                    </ItemTemplate>
                </asp:DataList>
                <asp:AccessDataSource ID="AccessDataSource2" runat="server" 
                    DataFile="~/App_Data/Baza.accdb" 
                    
                    SelectCommand="SELECT * FROM [FileInfo] WHERE (([KorisnikID] = ?) AND ([BlobContainer] = ?) AND ([Tag] &lt;&gt; ?) AND ([Tag] &lt;&gt; ?))">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="KorisnikID" SessionField="ID" 
                            Type="Int32" />
                        <asp:Parameter DefaultValue="public" Name="BlobContainer" Type="String" />
                        <asp:Parameter DefaultValue="Video" Name="Tag" Type="String" />
                        <asp:Parameter DefaultValue="Muzika" Name="Tag2" Type="String" />
                    </SelectParameters>
                </asp:AccessDataSource>
            </td>
        </tr>
        <tr>
            <td class="style1">
                Video:</td>
            <td colspan="1" class="style1">
                Objavljen video:</td>
        </tr>
        <tr>
            <td colspan="1" class="style1" style="border: thin solid #DBDBDB" valign="top">
                <asp:DataList ID="ListaVideo" runat="server" DataKeyField="FileID" 
                    DataSourceID="AccessDataSource3" Width="448px" 
                    onitemcommand="ListaVideo_ItemCommand">
                    <ItemTemplate>
                        <asp:Image ID="Image3" runat="server" 
                            ImageUrl='<%# Eval("Ext", "~/Ikone/{0}") %>' />
                        &nbsp;<asp:Label ID="lblVideo" runat="server" Text='<%# Eval("BlobName") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("Velicina") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label8" runat="server" Text='<%# Eval("Datum", "{0:g}") %>'></asp:Label>
                        <asp:Label ID="lblVideoID" runat="server" Text='<%# Eval("FileID") %>' 
                            Visible="False"></asp:Label>
                        <p />
                        <telerik:RadButton ID="RadButton6" runat="server" CommandName="download" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Download">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton7" runat="server" CommandName="obrisi" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Obrisi">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton8" runat="server" CommandName="play" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Play">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton9" runat="server" CommandName="objavi" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Objavi">
                        </telerik:RadButton>
                    </ItemTemplate>
                </asp:DataList>
                <asp:AccessDataSource ID="AccessDataSource3" runat="server" 
                    DataFile="~/App_Data/Baza.accdb" 
                    SelectCommand="SELECT * FROM [FileInfo] WHERE (([KorisnikID] = ?) AND ([BlobContainer] = ?) AND ([Tag] = ?))">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="KorisnikID" SessionField="ID" 
                            Type="Int32" />
                        <asp:Parameter DefaultValue="private" Name="BlobContainer" Type="String" />
                        <asp:Parameter DefaultValue="Video" Name="Tag" Type="String" />
                    </SelectParameters>
                </asp:AccessDataSource>
            </td>
            <td class="style1" style="border: thin solid #DBDBDB" valign="top">
                <asp:DataList ID="ListaVideoPublic" runat="server" DataKeyField="FileID" 
                    DataSourceID="AccessDataSource4" Width="456px" 
                    onitemcommand="ListaVideoPublic_ItemCommand">
                    <ItemTemplate>
                        <asp:Image ID="Image4" runat="server" 
                            ImageUrl='<%# Eval("Ext", "~/Ikone/{0}") %>' />
                        &nbsp;<asp:Label ID="lblVideoPublic" runat="server" Text='<%# Eval("BlobName") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label9" runat="server" Text='<%# Eval("Velicina") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label10" runat="server" Text='<%# Eval("Datum", "{0:g}") %>'></asp:Label>
                        <asp:Label ID="lblVideoIDPublic" runat="server" Text='<%# Eval("FileID") %>' 
                            Visible="False"></asp:Label>
                        <p />
                        <telerik:RadButton ID="RadButton10" runat="server" CommandName="download" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Download">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton11" runat="server" CommandName="obrisi" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Obrisi">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton12" runat="server" CommandName="play" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Play">
                        </telerik:RadButton>
                    </ItemTemplate>
                </asp:DataList>
                <asp:AccessDataSource ID="AccessDataSource4" runat="server" 
                    DataFile="~/App_Data/Baza.accdb" 
                    SelectCommand="SELECT * FROM [FileInfo] WHERE (([KorisnikID] = ?) AND ([BlobContainer] = ?) AND ([Tag] = ?)) ORDER BY [Datum] DESC">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="KorisnikID" SessionField="ID" 
                            Type="Int32" />
                        <asp:Parameter DefaultValue="public" Name="BlobContainer" Type="String" />
                        <asp:Parameter DefaultValue="Video" Name="Tag" Type="String" />
                    </SelectParameters>
                </asp:AccessDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="1" class="style1" style="border-style: none;">
                Muzika:</td>
            <td class="style1" style="border-style: none;">
                Objavljena muzika:</td>
        </tr>
        <tr>
            <td colspan="1" class="style1" style="border: thin solid #DBDBDB" valign="top">
                <asp:DataList ID="ListaMuzike" runat="server" DataKeyField="FileID" 
                    DataSourceID="AccessDataSource5" Width="445px" 
                    onitemcommand="ListaMuzike_ItemCommand">
                    <ItemTemplate>
                        <asp:Image ID="Image5" runat="server" 
                            ImageUrl='<%# Eval("Ext", "~/Ikone/{0}") %>' />
                        &nbsp;<asp:Label ID="lblMuzika" runat="server" Text='<%# Eval("BlobName") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label11" runat="server" Text='<%# Eval("Velicina") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label12" runat="server" Text='<%# Eval("Datum", "{0:g}") %>'></asp:Label>
                        <asp:Label ID="lblMuzikaID" runat="server" Text='<%# Eval("FileID") %>' 
                            Visible="False"></asp:Label>
                        <p />
                        <telerik:RadButton ID="RadButton13" runat="server" CommandName="download" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Download">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton14" runat="server" CommandName="obrisi" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Obrisi">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton15" runat="server" CommandName="play" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Play">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton16" runat="server" CommandName="objavi" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Objavi">
                        </telerik:RadButton>
                    </ItemTemplate>
                </asp:DataList>
                <asp:AccessDataSource ID="AccessDataSource5" runat="server" 
                    DataFile="~/App_Data/Baza.accdb" 
                    SelectCommand="SELECT * FROM [FileInfo] WHERE (([KorisnikID] = ?) AND ([BlobContainer] = ?) AND ([Tag] = ?)) ORDER BY [Datum] DESC">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="KorisnikID" SessionField="ID" 
                            Type="Int32" />
                        <asp:Parameter DefaultValue="private" Name="BlobContainer" Type="String" />
                        <asp:Parameter DefaultValue="Muzika" Name="Tag" Type="String" />
                    </SelectParameters>
                </asp:AccessDataSource>
            </td>
            <td class="style1" style="border: thin solid #DBDBDB" valign="top">
                <asp:DataList ID="ListaObjavljeneMuzike" runat="server" DataKeyField="FileID" 
                    DataSourceID="AccessDataSource6" 
                    onitemcommand="ListaObjavljeneMuzike_ItemCommand" Width="459px">
                    <ItemTemplate>
                        <asp:Image ID="Image6" runat="server" 
                            ImageUrl='<%# Eval("Ext", "~/Ikone/{0}") %>' />
                        &nbsp;<asp:Label ID="lblMuzikaPublic" runat="server" Text='<%# Eval("BlobName") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label13" runat="server" Text='<%# Eval("Velicina") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label14" runat="server" Text='<%# Eval("Datum", "{0:g}") %>'></asp:Label>
                        <asp:Label ID="lblMuzikaPublicID" runat="server" Text='<%# Eval("FileID") %>' 
                            Visible="False"></asp:Label>
                        <p />
                        <telerik:RadButton ID="RadButton17" runat="server" CommandName="download" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Download">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton18" runat="server" CommandName="obrisi" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Obrisi">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton19" runat="server" CommandName="play" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Play">
                        </telerik:RadButton>
                    </ItemTemplate>
                </asp:DataList>
                <asp:AccessDataSource ID="AccessDataSource6" runat="server" 
                    DataFile="~/App_Data/Baza.accdb" 
                    SelectCommand="SELECT * FROM [FileInfo] WHERE (([KorisnikID] = ?) AND ([BlobContainer] = ?) AND ([Tag] = ?))">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="KorisnikID" SessionField="ID" 
                            Type="Int32" />
                        <asp:Parameter DefaultValue="public" Name="BlobContainer" Type="String" />
                        <asp:Parameter DefaultValue="Muzika" Name="Tag" Type="String" />
                    </SelectParameters>
                </asp:AccessDataSource>
            </td>
        </tr>
        </table>
    </asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="login">
    <asp:Label ID="lblDobrodoslica" runat="server" Text="Label"></asp:Label>
    <telerik:RadButton ID="RadButton5" runat="server" EnableEmbeddedSkins="False" 
        onclick="RadButton5_Click" Skin="cloud" Text="Izloguj se">
    </telerik:RadButton>
</asp:Content>


<asp:Content ID="Content4" runat="server" contentplaceholderid="Meni">
    <table style="width: 100%; background-color: #3a4f63;">
        <tr>
            <td>
                <telerik:RadMenu ID="RadMenu1" Runat="server" EnableEmbeddedSkins="False" 
        Skin="cloud">
        <Items>
            <telerik:RadMenuItem runat="server" NavigateUrl="~/Korisnici.aspx" 
                Text="Moji fajlovi">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Text="pretraga" 
                NavigateUrl="~/Pretraga.aspx">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Text="video">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Text="muzika">
            </telerik:RadMenuItem>
        </Items>
    </telerik:RadMenu>
            </td>
        </tr>
        </table>
    
</asp:Content>



