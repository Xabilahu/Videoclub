<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="FormularioFuncionesSOCIO.aspx.vb" Inherits="ApliWebVideoClub.FormularioFuncionesSOCIO" %>
   <asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
       <style type="text/css">
        .style2
        {
            width: 66px;
        }
        .style3
        {
            text-align: justify;
            
        }
        .style12
        {
            width: 10px;
        }
        .style20
        {
            width: 202px;
        }
        .style23
        {
            width: 73px;
        }
        .style24
        {
            width: 309px;
           
        }
        .style27
        {
            width: 320px;
        }
        .style28
        {
            width: 174px;
        }
        .style30
        {
            width: 160px;
        }
        .style31
        {
            width: 158px;
              color: #FF0000;
          }
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
        }
          .style102
          {
              text-decoration: underline;
              font-weight: bold;
              font-size: large;
          }
          .auto-style1 {
              width: 111px;
              color: #FF0000;
              height: 67px;
          }
          .auto-style2 {
              width: 95px;
              height: 67px;
          }
          .auto-style3 {
              width: 10px;
              height: 67px;
          }
          .auto-style4 {
              width: 321px;
              height: 67px;
          }
          .auto-style5 {
              width: 73px;
              height: 67px;
          }
          .auto-style6 {
              margin-left: 0px;
          }
          .auto-style7 {
              width: 273px;
              color: #FF0000;
              height: 83px;
          }
          .auto-style8 {
              width: 67px;
          }
          .auto-style9 {
              width: 110px;
          }
          .auto-style10 {
              width: 97px;
          }
          .auto-style11 {
              width: 317px;
          }
          .auto-style12 {
              width: 47px;
          }
          .auto-style13 {
              width: 68px;
          }
          .auto-style14 {
              width: 318px;
              height: 83px;
          }
          .auto-style15 {
              width: 97px;
              height: 83px;
          }
          .auto-style16 {
              width: 10px;
              height: 83px;
          }
          .auto-style17 {
              width: 73px;
              height: 83px;
          }
          .auto-style18 {
              width: 68px;
              height: 49px;
          }
          .auto-style19 {
              text-decoration: underline;
              font-weight: bold;
              font-size: large;
              height: 49px;
          }
    </style>
 </asp:Content>
   

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="header"><h1 class="style37">Funciones SOCIO</h1></div>
    <div class="style100">
    
        <br />

        <table >
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td class="style3">
                    Realice todas las funciones que quiera . Rellene los datos oportunos y pulse el 
                    botón.<br />
                    </td>
            </tr>
        </table>
            <br />
            <table >
                <tr>
                    <td class="auto-style8">
                        &nbsp;</td>
                    <td class="style102">
                        Modificar mis datos personales</td>
                </tr>
        </table>
        <table >
            <tr>
                <td class="auto-style9">
                    &nbsp;</td>
                <td class="style27" >
                    Nombre 
                    y apellidos</td>
                <td class="style28">
                    <asp:TextBox ID="TBNombre" runat="server"  
                        ToolTip="Introduzca su nombre y apellidos" SkinID="-1" Width="274px"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="Modificar" runat="server" Text="Modificar datos" />
                </td>
            </tr>
            <tr>
                <td class="auto-style9">
                    &nbsp;</td>
                <td class="style27" >
                    Dirección</td>
                <td class="style28">
                    <asp:TextBox ID="TBDireccion" runat="server" Width="271px"></asp:TextBox>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
             
            <table >
                <tr>
                    <td class="style2">
                        &nbsp;</td>
                    <td class="style102">
                        Aumentar mi crédito</td>
                </tr>
        </table>
        <table >
            <tr>
                <td class="auto-style10">
                    &nbsp;</td>
                <td class="style12">
                    &nbsp;</td>
                <td class="auto-style11">
                    Introduzca aquí la cantidad en euros</td>
                <td class="style30">
                    <asp:TextBox ID="cantidadEuros" runat="server" Width="279px" ToolTip="Introduzca la cantidad en euros a aumentar el crédito" 
                        SkinID="-1"></asp:TextBox>
                </td>
                <td class="auto-style12">
                    <asp:Button ID="Aumentar" runat="server" Text="Aumentar crédito" Width="170px" />
                    </td>
                <td>
                    &nbsp;</td>
            </tr>
            </table>
             <br />
        <table >
            <tr>
                <td class="auto-style13">
                    &nbsp;</td>
                <td class="style102">
                    Alquilar película</td>
            </tr>
        </table>
        <table >
            <tr>
                <td class="auto-style2">
                    </td>
                <td class="auto-style3">
                    </td>
                <td class="auto-style4">
                    Seleccione de la lista la película a alquilar</td>
                <td class="auto-style1" valign="top">
                    <asp:DropDownList ID="DDLAlquilar" runat="server" Height="16px" Width="280px" DataSourceID="AccessDataSource1" DataTextField="NombrePelicula" DataValueField="NombrePelicula">
                    </asp:DropDownList>
                    <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="C:\TEMP\Videoclub.mdb" SelectCommand="SELECT * FROM [PeliculasAlquilables]"></asp:AccessDataSource>
                </td>
                <td class="auto-style5" valign="top">
                    <asp:Button ID="Alquilar" runat="server" Text="Alquilar" CssClass="auto-style6" Width="163px" />
                    </td>
            </tr>
            </table>
                      <br />
        <table >
            <tr>
                <td class="auto-style18">
                    </td>
                <td class="auto-style19">
                    Devolver película</td>
            </tr>
        </table>
        <table >
            <tr>
                <td class="auto-style15">
                    </td>
                <td class="auto-style16">
                    </td>
                <td class="auto-style14" valign="top">
                    Seleccione de la lista la película a devolver</td>
                <td class="auto-style7" valign="top">
                    <asp:DropDownList ID="DDLDevolver" runat="server" DataSourceID="AccessDataSource2" DataTextField="NombrePelicula" DataValueField="NombrePelicula" Width="282px" CssClass="auto-style6">
                    </asp:DropDownList>
                    <asp:AccessDataSource ID="AccessDataSource2" runat="server" DataFile="C:\TEMP\Videoclub.mdb" SelectCommand="SELECT nombrepelicula FROM pelicula INNER JOIN prestamo ON pelicula.codigo = prestamo.codigo WHERE usuarioLogin = ? AND estado like 'alquilada' AND fechafin IS NULL">
                        <SelectParameters>
                            <asp:SessionParameter Name="?" SessionField="usuarioLogin" />
                        </SelectParameters>
                    </asp:AccessDataSource>
                </td>
                <td class="auto-style17" valign="top">
                    <asp:Button ID="Devolver" runat="server" Text="Devolver" Width="161px" />
                    </td>
            </tr>
            </table>
    <table>
    <asp:Button ID="VolverPrincipal" runat="server" Text="Volver a la Página Principal" />
    </table>
    </div>
</asp:Content>
