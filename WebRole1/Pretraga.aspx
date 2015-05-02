<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pretraga.aspx.cs" Inherits="WebRole1.Pretraga" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Button.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Input.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Menu.cloud.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 652px;
        }
        .style2
        {
            width: 182px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="login" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
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
    <asp:Label ID="lblDobrodoslica" runat="server" Text="Label" Visible="False"></asp:Label>
    <telerik:RadButton ID="RadButton1" runat="server" EnableEmbeddedSkins="False" 
        Skin="cloud" Text="Izloguj se" onclick="RadButton1_Click" Visible="False">
    </telerik:RadButton>
     <telerik:RadButton ID="radbtnLogIn" runat="server" EnableEmbeddedSkins="False" 
        onclick="radbtnLogIn_Click" Skin="cloud" Text="Login">
    </telerik:RadButton>
    <telerik:RadButton ID="radbtnReg" runat="server" EnableEmbeddedSkins="False" 
        onclick="radbtnReg_Click" Skin="cloud" Text="Registracija">
    </telerik:RadButton>
    <br />
    <br />
    <asp:Panel ID="pnlLogin" runat="server" Visible="False">
        <table style="width: 100%;">
            <tr>
                <td class="style1">
                    <asp:Label ID="lblErrorLogin" runat="server" ForeColor="Red" 
        Text="*Pogresni podaci" Visible="False"></asp:Label>
                    &nbsp;<asp:Label ID="Label1" runat="server" Text="E-mail:"></asp:Label>
&nbsp;<asp:TextBox ID="txtEmail" runat="server" Width="125px"></asp:TextBox>
                </td>
                <td>
                    &nbsp;<asp:Label ID="Label2" runat="server" Text="Sifra: "></asp:Label>
                    <asp:TextBox ID="txtSifra" runat="server" TextMode="Password"></asp:TextBox>
                </td>
                <td>
                <telerik:RadButton ID="lbLogin" runat="server" EnableEmbeddedSkins="False" 
        Skin="cloud" Text="Uloguj se" onclick="lbLogin_Click1">
    </telerik:RadButton> 
                </td>
            </tr>
        </table>
          </asp:Panel> 
    <br />
    <asp:Panel ID="pnlReg" runat="server" Visible="False">
        <table style="width: 100%;">
            <tr>
                <td class="style2">
                    <asp:Label ID="lblErrorReg" runat="server" ForeColor="Red" 
        Text="*Neuspela registracija" Visible="False"></asp:Label>
            &nbsp;</td>
                <td class="style10">
                    <asp:Label ID="Label3" runat="server" Text="Ime: "></asp:Label>
                    <asp:TextBox ID="txtIme" runat="server" Width="100px"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="Prezime: "></asp:Label>
                    <asp:TextBox ID="txtPrezime" runat="server" Width="100px"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="Label5" runat="server" Text="E-mail: "></asp:Label>
                    <asp:TextBox ID="txtEmail1" runat="server" Width="100px"></asp:TextBox>
                </td>
                <td>
                    <asp:Label ID="Label6" runat="server" Text="Sifra: "></asp:Label>
                    <asp:TextBox ID="txtSifra1" runat="server" Width="100px"></asp:TextBox>
                </td>
                <td>
                <telerik:RadButton ID="lbReg" runat="server" EnableEmbeddedSkins="False" 
        Skin="cloud" Text="Registruj se" onclick="lbReg_Click1">
    </telerik:RadButton>
                </td>
            </tr>
        </table>
            </asp:Panel>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Meni" runat="server">
    <table style="width: 100%; background-color: #3a4f63;">
        <tr>
            <td>
                <telerik:RadMenu ID="RadMenu1" Runat="server" EnableEmbeddedSkins="False" 
        Skin="cloud">
        <Items>
            <telerik:RadMenuItem runat="server" NavigateUrl="~/Default.aspx" Text="pocetna">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Text="muzika">
            </telerik:RadMenuItem>
            <telerik:RadMenuItem runat="server" Text="video">
            </telerik:RadMenuItem>
        </Items>
    </telerik:RadMenu>
            </td>
        </tr>
        </table>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
 <table style="width:100%;">
        <tr>
            <td align="center" class="style12" style="border: thin solid #DBDBDB">
                <telerik:RadTextBox ID="txtUpit" Runat="server" EmptyMessage="trazi" 
                    EnableEmbeddedSkins="False" LabelWidth="" Skin="cloud" Width="250px">
                </telerik:RadTextBox>
                <br />
                <br />
&nbsp;<telerik:RadButton ID="btnVideo" runat="server" EnableEmbeddedSkins="False" 
                    Skin="cloud" Text="Video" onclick="btnVideo_Click">
                </telerik:RadButton>
&nbsp;<telerik:RadButton ID="btnMuzika" runat="server" EnableEmbeddedSkins="False" 
                    Skin="cloud" Text="Muzika" onclick="btnMuzika_Click">
                </telerik:RadButton>
&nbsp;<telerik:RadButton ID="btnFajl" runat="server" EnableEmbeddedSkins="False" 
                    Skin="cloud" Text="Ostali fajlovi" onclick="btnFajl_Click">
                </telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td align="left" class="style12" style="border: thin solid #DBDBDB">
                <asp:Label ID="lblNemaRezultata" runat="server" Text="Label" Visible="False"></asp:Label>
                <br />
                <asp:DataList ID="ListaVideo" runat="server" DataKeyField="FileID" 
                    DataSourceID="AccessDataSource1" Width="924px" 
                    onitemcommand="ListaVideo_ItemCommand">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" 
                            ImageUrl='<%# Eval("Ext", "~/Ikone/{0}") %>' />
                        &nbsp;<asp:Label ID="lblVideo" runat="server" Text='<%# Eval("BlobName") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label7" runat="server" Text='<%# Eval("Velicina") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label8" runat="server" Text='<%# Eval("Datum", "{0:g}") %>'></asp:Label>
                        <asp:Label ID="lblID" runat="server" Text='<%# Eval("FileID") %>' 
                            Visible="False"></asp:Label>
                        
                        &nbsp;<telerik:RadButton ID="RadButton7" runat="server" CommandName="download" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Download">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton8" runat="server" CommandName="play" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Play">
                        </telerik:RadButton>
                    </ItemTemplate>
                </asp:DataList>
                <asp:AccessDataSource ID="AccessDataSource1" runat="server" 
                    DataFile="~/App_Data/Baza.accdb">
                </asp:AccessDataSource>
                <br />
                <asp:DataList ID="ListaMuzika" runat="server" DataKeyField="FileID" 
                    DataSourceID="AccessDataSource2" Width="918px" 
                    onitemcommand="ListaMuzika_ItemCommand">
                    <ItemTemplate>
                        <asp:Image ID="Image2" runat="server" 
                            ImageUrl='<%# Eval("Ext", "~/Ikone/{0}") %>' />
                        &nbsp;<asp:Label ID="lblMuzika" runat="server" Text='<%# Eval("BlobName") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label9" runat="server" Text='<%# Eval("Velicina") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label10" runat="server" Text='<%# Eval("Datum", "{0:g}") %>'></asp:Label>
                        <asp:Label ID="lblMuzikaID" runat="server" Text='<%# Eval("FileID") %>' 
                            Visible="False"></asp:Label>
                        &nbsp;<telerik:RadButton ID="RadButton9" runat="server" CommandName="download" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Download">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton10" runat="server" CommandName="play" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Play">
                        </telerik:RadButton>
                        <br />
                    </ItemTemplate>
                </asp:DataList>
                <asp:AccessDataSource ID="AccessDataSource2" runat="server" 
                    DataFile="~/App_Data/Baza.accdb">
                </asp:AccessDataSource>
                <br />
                <asp:DataList ID="ListaFajlova" runat="server" DataKeyField="FileID" 
                    DataSourceID="AccessDataSource3" Width="926px" 
                    onitemcommand="ListaFajlova_ItemCommand">
                    <ItemTemplate>
                        <asp:Image ID="Image3" runat="server" 
                            ImageUrl='<%# Eval("Ext", "~/Ikone/{0}") %>' />
                        &nbsp;<asp:Label ID="lblFajl" runat="server" Text='<%# Eval("BlobName") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label11" runat="server" Text='<%# Eval("Velicina") %>'></asp:Label>
                        &nbsp;|
                        <asp:Label ID="Label12" runat="server" Text='<%# Eval("Datum", "{0:g}") %>'></asp:Label>
                        <asp:Label ID="lblFileID" runat="server" Text='<%# Eval("FileID") %>' 
                            Visible="False"></asp:Label>
                        &nbsp;<telerik:RadButton ID="RadButton11" runat="server" CommandName="download" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Download">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton12" runat="server" CommandName="link" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Link">
                        </telerik:RadButton>
                    </ItemTemplate>
                </asp:DataList>
                <asp:AccessDataSource ID="AccessDataSource3" runat="server" 
                    DataFile="~/App_Data/Baza.accdb">
                </asp:AccessDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
