<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="ConsultaLahuerta.aspx.vb" Inherits="ApliWebVideoClub.ConsultaLahuerta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style1 {
            height: 25px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <table style="width:100%;">
            <tr>
                <td>&nbsp;</td>
                <td align="center" style="border-style: ridge; font-family: 'Comic Sans MS'; font-size: x-large; font-weight: bold; color: #66FFFF; background-color: #FFCCFF;">Consulta de Películas</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style1"></td>
                <td align="justify" class="auto-style1" style="background-color: #FF99FF; border-style: ridge; font-family: 'Courier New', Courier, 'espacio sencillo'; font-size: medium; font-weight: normal; font-style: italic; color: #9900CC">Títulos de las películas que hayan sido dadas de alta a partir del 2018, que hayan sido alquiladas más de una vez y que por lo menos tengan una valoración mayor que 3.5, ordenadas alfabéticamente.</td>
                <td class="auto-style1"></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td align="center" style="border-style: ridge; font-family: 'Microsoft JhengHei'; background-color: #FF99FF;">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" BackColor="#FF0066" BorderColor="#660066" BorderStyle="Ridge" BorderWidth="6px" DataSourceID="AccessDataSource1" Font-Bold="False" Font-Names="Verdana" ForeColor="#6600CC">
                        <Columns>
                            <asp:BoundField DataField="NombrePelicula" HeaderText="NombrePelicula" SortExpression="NombrePelicula" />
                        </Columns>
                    </asp:GridView>
                    <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="C:\TEMP\Videoclub.mdb" SelectCommand="SELECT * FROM [ConsultaXabi]"></asp:AccessDataSource>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
    </div>
</asp:Content>
