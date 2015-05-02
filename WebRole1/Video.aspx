<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Video.aspx.cs" Inherits="WebRole1.Video" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
	<link href="Button.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Menu.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Input.cloud.css" rel="stylesheet" type="text/css" />
    <script src="javascript/silverlight/silverlight.js" type="text/javascript"></script>
	<style type="text/css">
        .style1
        {
            width: 628px;
        }
        .style2
        {
            width: 628px;
            height: 471px;
        }
        .style3
        {
            width: 628px;
            height: 49px;
        }
        .style4
        {
            width: 2212px;
            height: 49px;
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
        
                    <asp:Label ID="lblErrorReg" runat="server" ForeColor="Red" 
        Text="*Neuspela registracija" Visible="False"></asp:Label>
            
                    &nbsp;<asp:Label ID="Label3" runat="server" Text="Ime: "></asp:Label>
                    <asp:TextBox ID="txtIme" runat="server" Width="100px"></asp:TextBox>
                    <asp:Label ID="Label4" runat="server" Text="Prezime: "></asp:Label>
                    <asp:TextBox ID="txtPrezime" runat="server" Width="100px"></asp:TextBox>
                    <asp:Label ID="Label5" runat="server" Text="E-mail: "></asp:Label>
                    <asp:TextBox ID="txtEmail1" runat="server" Width="100px"></asp:TextBox>
                    <asp:Label ID="Label6" runat="server" Text="Sifra: "></asp:Label>
                    <asp:TextBox ID="txtSifra1" runat="server" Width="100px"></asp:TextBox>
&nbsp;
               
                <telerik:RadButton ID="lbReg" runat="server" EnableEmbeddedSkins="False" 
        Skin="cloud" Text="Registruj se" onclick="lbReg_Click1">
    </telerik:RadButton>
                
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

    <asp:Label ID="lblTitle" runat="server" Font-Size="Large" Text="Label"></asp:Label>
    <br />

	<table style="width: 100%">
		<tr>
			<td class="style2" colspan="3">
						
<div id="silverlightcontainer">
	<object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="640" height="480">
		<param name="source" value="silverlight/VideoPlayer.xap"/>
		<param name="background" value="white" />
		<param name="minRuntimeVersion" value="2.0.31005.0" />
		<param name="autoUpgrade" value="true" />
		<a href="http://go.microsoft.com/fwlink/?LinkID=124807" style="text-decoration: none;">
			<img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style: none;"/>
		</a>
	</object>
</div>						
						</td>
			<td rowspan="3" valign="top" style="border: thin solid #DBDBDB">
                Objavljeni videi korisnika:<br />
                <asp:DataList ID="DataList1" runat="server" DataKeyField="FileID" 
                    DataSourceID="AccessDataSource1" Width="288px" 
                    onitemcommand="DataList1_ItemCommand">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" 
                            ImageUrl='<%# Eval("Ext", "~/Ikone/{0}") %>' />
                        &nbsp;<asp:Label ID="lblVideo" runat="server" Text='<%# Eval("BlobName") %>'></asp:Label>
                        <asp:Label ID="lblID" runat="server" Text='<%# Eval("FileID") %>' 
                            Visible="False"></asp:Label>
                        <p /><telerik:RadButton ID="RadButton1" runat="server" CommandName="download" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Download">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton2" runat="server" CommandName="play" 
                            EnableEmbeddedSkins="False" Skin="cloud" Text="Play">
                        </telerik:RadButton>
                    </ItemTemplate>
                </asp:DataList>
                <asp:AccessDataSource ID="AccessDataSource1" runat="server" 
                    DataFile="~/App_Data/Baza.accdb" 
                    
                    SelectCommand="SELECT * FROM [FileInfo] WHERE (([KorisnikID] = ?) AND ([Tag] = ?) AND ([BlobContainer] = ?)) ORDER BY [Datum]">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="0" Name="KorisnikID" 
                            QueryStringField="korID" Type="Int32" />
                        <asp:Parameter DefaultValue="Video" Name="Tag" Type="String" />
                        <asp:Parameter DefaultValue="public" Name="BlobContainer" Type="String" />
                    </SelectParameters>
                </asp:AccessDataSource>
            </td>
		</tr>
		<tr>
			<td class="style4" 
                style="border-style: solid none solid solid; border-width: thin; border-color: #DBDBDB;">
						
						Uplodovao: <asp:Label ID="lblUploader" runat="server" Text="Label"></asp:Label>						
						</td>
			<td class="style3" 
                style="border-style: solid none solid none; border-width: thin; border-color: #DBDBDB">
						
						Rejting:
                        <asp:Label ID="lblPlus" runat="server" ForeColor="#006600" Text="Label"></asp:Label>
						</td>
			<td class="style3" 
                style="border-style: solid solid solid none; border-width: thin; border-color: #DBDBDB">
						
						<asp:ImageButton ID="btnPlus" runat="server" CausesValidation="False" 
                            ImageUrl="~/Styles/1329080652_hand_pro.png" onclick="btnPlus_Click" />
&nbsp;
                        <asp:ImageButton ID="btnMinus" runat="server" CausesValidation="False" 
                            ImageUrl="~/Styles/1329080745_hand_contra.png" onclick="btnMinus_Click" />
						</td>
		</tr>
		<tr>
			<td class="style1" colspan="3" style="border: thin solid #DBDBDB">Ubaci komentar:<br />
                <telerik:RadTextBox ID="txtKomentar" Runat="server" EmptyMessage="komentar" 
                    EnableEmbeddedSkins="False" LabelWidth="" Skin="cloud" TextMode="MultiLine" 
                    Width="300px">
                </telerik:RadTextBox>
            &nbsp;<telerik:RadButton ID="RadButton3" runat="server" EnableEmbeddedSkins="False" 
                    onclick="RadButton3_Click" Skin="cloud" Text="Ubaci">
                </telerik:RadButton>
                &nbsp;<asp:Label ID="lbl" runat="server" Text="Label" Visible="False"></asp:Label>
                <br />
                <br />
                Koemntari (<asp:Label ID="lblBrojKomentara" runat="server" Text="Label"></asp:Label>):
                <br />
                <br />
                <asp:DataList ID="listaKomentara" runat="server" DataKeyField="KomentarID" 
                    DataSourceID="AccessDataSource2" Width="630px">
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Ime") %>'></asp:Label>
                        &nbsp;<asp:Label ID="Label2" runat="server" Text='<%# Eval("Prezime") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("Datum", "{0:g}") %>'></asp:Label>
                        <br />
                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("Komentar") %>'></asp:Label>
                    </ItemTemplate>
                </asp:DataList>
                <asp:AccessDataSource ID="AccessDataSource2" runat="server" 
                    DataFile="~/App_Data/Baza.accdb" 
                    SelectCommand="SELECT * FROM [Komentari] WHERE ([FileID] = ?) ORDER BY [Datum] DESC">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="0" Name="FileID" 
                            QueryStringField="fileID" Type="Int32" />
                    </SelectParameters>
                </asp:AccessDataSource>
            </td>
		</tr>
	</table>

	</asp:Content>
