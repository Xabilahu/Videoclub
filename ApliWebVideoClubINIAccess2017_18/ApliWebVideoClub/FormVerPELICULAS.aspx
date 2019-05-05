<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="FormVerPELICULAS.aspx.vb" Inherits="ApliWebVideoClub.FormVerPELICULAS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
          .style32
        {
            width: 185px;
        }
        .style37
        {
            font-size: large;
        }
                .style100
        {
            height: 525px;
            color:Black;
            font-size:medium;
        margin-right: 0px;
    }
          .style102
          {
              text-decoration: underline;
              font-weight: bold;
              font-size: large;
        width: 477px;
    }
    .style103
    {
        font-size: large;
        width: 477px;
        color: black;
    }
    .auto-style1 {
        width: 403px;
        text-decoration: underline;
        text-align: center;
        height: 41px;
    }
    .auto-style2 {
        width: 403px;
    }
    .auto-style3 {
        text-decoration: underline;
        font-weight: bold;
        font-size: large;
        width: 477px;
        height: 41px;
        text-align: center;
    }
    .auto-style4 {
        width: 53px;
    }
    .auto-style5 {
        width: 328px;
    }
    .auto-style6 {
        width: 157px;
    }
    .auto-style7 {
        width: 106%;
    }
        .auto-style8 {
            margin-top: 8px;
        }
        .auto-style9 {
            width: 100%;
            height: 352px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="header"><h1 class="style37">Catálogo PELÍCULAS</h1></div>
 <div class="style100" dir="ltr">
            <table style="margin-right: 0px" >
             <tr>
                    <td class="auto-style1">
                        <table class="auto-style7">
                            <tr>
                                <td class="auto-style6"></td>
                                <td class="auto-style5"><strong dir="rtl">Catálogo Películas</strong></td>
                                <td></td>
                            </tr>
                        </table>
                    </td>
                    <td class="auto-style3" align="center">
                        Estrenos Semana</td>
                </tr>
             <tr>
                    <td class="auto-style2" align="center" valign="top">
                        <table style="margin-right: 46px;" class="auto-style9">
                            <tr>
                                <td class="auto-style4">&nbsp;</td>
                                <td>
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="AccessDataSource1" style="text-align: center" AllowPaging="True" Font-Size="Small" Width="324px">
                                        <Columns>
                                            <asp:BoundField DataField="Titulo" HeaderText="Titulo" SortExpression="Titulo" />
                                            <asp:BoundField DataField="Precio" HeaderText="Precio" SortExpression="Precio" />
                                            <asp:BoundField DataField="Estado" HeaderText="Estado" SortExpression="Estado" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="C:\TEMP\Videoclub.mdb" SelectCommand="SELECT * FROM [CatalogoPeliculas]"></asp:AccessDataSource>
                                </td>
                                <td>&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                    <td class="style103" align="center" valign="top">
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="AccessDataSource2" style="font-size: medium" AllowPaging="True" CssClass="auto-style8" Font-Size="Small" Height="287px">
                            <Columns>
                                <asp:BoundField DataField="Titulo" HeaderText="Titulo" SortExpression="Titulo" />
                                <asp:BoundField DataField="Precio" HeaderText="Precio" SortExpression="Precio" />
                                <asp:BoundField DataField="FechaDisponible" HeaderText="FechaDisponible" SortExpression="FechaDisponible" />
                            </Columns>
                        </asp:GridView>
                        <asp:AccessDataSource ID="AccessDataSource2" runat="server" DataFile="C:\TEMP\Videoclub.mdb" SelectCommand="SELECT * FROM [Estrenos]"></asp:AccessDataSource>
                    </td>
                </tr>
                </table>
 <br />
 </div>
</asp:Content>
