<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="WebRole1._Default" %>

<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <link href="Button.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Input.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Upload.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Menu.cloud.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style5
        {
            width: 649px;
        }
        .style8
    {
        width: 148px;
    }
    .style10
    {
        width: 141px;
    }
        .style12
        {}
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    
    <table style="width:100%;">
        <tr>
            <td align="center" class="style12" style="border: thin solid #DBDBDB">
                <telerik:RadTextBox ID="txtPretraga" Runat="server" EmptyMessage="trazi" 
                    EnableEmbeddedSkins="False" LabelWidth="" Skin="cloud" Width="250px">
                </telerik:RadTextBox>
                <br />
                <br />
&nbsp;<telerik:RadButton ID="btnVideo" runat="server" EnableEmbeddedSkins="False" 
                    onclick="btnVideo_Click" Skin="cloud" Text="Video">
                </telerik:RadButton>
&nbsp;<telerik:RadButton ID="btnMuzika" runat="server" EnableEmbeddedSkins="False" 
                    onclick="btnMuzika_Click" Skin="cloud" Text="Muzika">
                </telerik:RadButton>
&nbsp;<telerik:RadButton ID="btnFajlovi" runat="server" EnableEmbeddedSkins="False" 
                    onclick="btnFajlovi_Click" Skin="cloud" Text="Svi fajlovi">
                </telerik:RadButton>
            </td>
        </tr>
    </table>
    
</asp:Content>
<asp:Content ID="Content1" runat="server" contentplaceholderid="login">
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
    
    <telerik:RadButton ID="RadButton1" runat="server" EnableEmbeddedSkins="False" 
        onclick="RadButton1_Click" Skin="cloud" Text="Login">
    </telerik:RadButton>
    <telerik:RadButton ID="RadButton2" runat="server" EnableEmbeddedSkins="False" 
        Skin="cloud" Text="Registracija" onclick="RadButton2_Click">
    </telerik:RadButton>
    <br />
    <br />
    <asp:Panel ID="pnlLogin" runat="server" Visible="False">
        <table style="width: 100%;">
            <tr>
                <td class="style5">
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
                <td class="style8">
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
<asp:Content ID="Content2" runat="server" contentplaceholderid="Meni">
    <table style="width: 100%; background-color: #3a4f63;">
        <tr>
            <td>
                 <telerik:RadMenu ID="RadMenu1" Runat="server" EnableEmbeddedSkins="False" 
                    Skin="cloud">
                    <Items>
                        <telerik:RadMenuItem runat="server" NavigateUrl="~/Default.aspx" Text="Pocetna">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Text="Pretraga" 
                            NavigateUrl="~/Pretraga.aspx">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Text="Video" NavigateUrl="~/Video.aspx">
                        </telerik:RadMenuItem>
                        <telerik:RadMenuItem runat="server" Text="Muzika">
                        </telerik:RadMenuItem>
                    </Items>
                </telerik:RadMenu>
            </td>
        </tr>
        </table>
               
                </asp:Content>


