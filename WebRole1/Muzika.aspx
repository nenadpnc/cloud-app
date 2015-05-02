<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Muzika.aspx.cs" Inherits="WebRole1.Muzika" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Button.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Input.cloud.css" rel="stylesheet" type="text/css" />
    <link href="Menu.cloud.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #silverlightcontainer
        {
            width: 640px;
        }
        .style1
        {
            height: 3px;
            width: 624px;
        }
        .style2
        {
            width: 624px;
        }
        .style3
        {
            width: 1371px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="login" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Meni" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="server">
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
	<table style="width:98%;">
        <tr>
            <td valign="top" class="style1" colspan="3">
                 <div id="silverlightcontainer">
	<object data="data:application/x-silverlight-2," type="application/x-silverlight-2" width="640" height="70">
		<param name="source" value="silverlight/mp3Plejer.xap"/>
		<param name="background" value="white" />
		<param name="minRuntimeVersion" value="2.0.31005.0" />
		<param name="autoUpgrade" value="true" />
		<a href="http://go.microsoft.com/fwlink/?LinkID=124807" style="text-decoration: none;">
			<img src="http://go.microsoft.com/fwlink/?LinkId=108181" alt="Get Microsoft Silverlight" style="border-style: none;"/>
		</a>
	</object>
</div>        
             </td>
            <td rowspan="3" valign="top">
                <asp:DataList ID="DataList1" runat="server" DataKeyField="FileID" 
                    DataSourceID="AccessDataSource1" Width="265px">
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" 
                            ImageUrl='<%# Eval("Ext", "~/Ikone/{0}") %>' />
                        &nbsp;<asp:Label ID="lblMuzika" runat="server" Text='<%# Eval("BlobName") %>'></asp:Label>
                        <asp:Label ID="lblMuzikaID" runat="server" Text='<%# Eval("FileID") %>'></asp:Label>
                        <br />
                        <telerik:RadButton ID="RadButton1" runat="server" EnableEmbeddedSkins="False" 
                            Skin="cloud" Text="Download" CommandName="download">
                        </telerik:RadButton>
                        &nbsp;<telerik:RadButton ID="RadButton2" runat="server" Text="Play" 
                            CommandName="play" EnableEmbeddedSkins="False" Skin="cloud">
                        </telerik:RadButton>
                        <br />
                    </ItemTemplate>
                </asp:DataList>
                <asp:AccessDataSource ID="AccessDataSource1" runat="server" 
                    DataFile="~/App_Data/Baza.accdb" 
                    SelectCommand="SELECT * FROM [FileInfo] WHERE (([KorisnikID] = ?) AND ([BlobContainer] = ?) AND ([Tag] = ?)) ORDER BY [Datum] DESC">
                    <SelectParameters>
                        <asp:QueryStringParameter DefaultValue="0" Name="KorisnikID" 
                            QueryStringField="korID" Type="Int32" />
                        <asp:Parameter DefaultValue="public" Name="BlobContainer" Type="String" />
                        <asp:Parameter DefaultValue="Muzika" Name="Tag" Type="String" />
                    </SelectParameters>
                </asp:AccessDataSource>
            </td>
        </tr>
        <tr>
            <td valign="top" class="style3">
                 
                Uplodovao:
                <asp:Label ID="lblUploader" runat="server" Text="Label"></asp:Label>
                 
             </td>
            <td valign="top" class="style2">
                 
                Rejting:
                <asp:Label ID="lblRejting" runat="server" Text="Label"></asp:Label>
                 
             </td>
            <td valign="top" class="style2">
                 
                <asp:ImageButton ID="ImageButton1" runat="server" 
                    ImageUrl="~/Styles/1329080652_hand_pro.png" />
&nbsp;<asp:ImageButton ID="ImageButton2" runat="server" 
                    ImageUrl="~/Styles/1329080745_hand_contra.png" />
                 
             </td>
        </tr>
        <tr>
            <td valign="top" class="style2" colspan="3">
                 Komentari (<asp:Label ID="lblBrojKomentara" runat="server" Text="Label"></asp:Label>
                 )<br />
                 <br />
                 <asp:DataList ID="ListaKomentara" runat="server" DataKeyField="KomentarID" 
                     DataSourceID="AccessDataSource2" Width="632px">
                     <ItemTemplate>
                         <asp:Label ID="Label1" runat="server" Text='<%# Eval("Ime") %>'></asp:Label>
                         &nbsp;<asp:Label ID="Label2" runat="server" Text='<%# Eval("Prezime") %>'></asp:Label>
                         <br />
                         <asp:Label ID="Label3" runat="server" Text='<%# Eval("Datum") %>'></asp:Label>
                         <br />
                         <asp:Label ID="Label4" runat="server" Text='<%# Eval("Komentar") %>'></asp:Label>
                         <br />
                     </ItemTemplate>
                 </asp:DataList>
                 <asp:AccessDataSource ID="AccessDataSource2" runat="server" 
                     DataFile="~/App_Data/Baza.accdb" 
                     SelectCommand="SELECT * FROM [Komentari] WHERE ([FileID] = ?) ORDER BY [Datum] DESC">
                     <SelectParameters>
                         <asp:QueryStringParameter DefaultValue="0" Name="FileID" 
                             QueryStringField="fileID" Type="Int32" />
                     </SelectParameters>
                 </asp:AccessDataSource></td>
        </tr>
        </table>
</asp:Content>
