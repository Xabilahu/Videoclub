<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="FormularioFuncionesADM.aspx.vb" Inherits="ApliWebVideoClub.FormularioFuncionesADM" %>
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
            
            color:Black;
            font-size:medium;
              height: 426px;
          }
          .style102
          {
              text-decoration: underline;
              font-weight: bold;
              font-size: large;
          }
          .style103
          {
              width: 320px;
              color: #FF0000;
          }
          .style104
          {
              width: 309px;
              color: #FF0000;
          }
          .auto-style1 {
              width: 357px;
          }
          .auto-style2 {
              width: 357px;
              color: #FF0000;
          }
          .auto-style3 {
              width: 340px;
          }
          .auto-style5 {
              width: 339px;
          }
          .auto-style6 {
              width: 339px;
              color: #FF0000;
          }
           .auto-style7 {
               width: 77px;
               height: 26px;
           }
           .auto-style8 {
               width: 10px;
               height: 26px;
           }
           .auto-style9 {
               width: 340px;
               height: 26px;
           }
           .auto-style10 {
               width: 158px;
               color: #FF0000;
               height: 26px;
           }
           .auto-style11 {
               width: 73px;
               height: 26px;
           }
           .auto-style12 {
               width: 60px;
               color: #FF0000;
           }
           .auto-style13 {
               margin-left: 0px;
           }
           .auto-style14 {
               width: 63px;
           }
           .auto-style15 {
               width: 87px;
           }
           .auto-style16 {
               width: 77px;
           }
           .auto-style18 {
               clear: both;
               width: 357px;
           }
    </style>
 </asp:Content>
   

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="header"><h1 class="style37">Funciones ADMINISTRADOR</h1></div>
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
                    <td class="auto-style14">
                        &nbsp;</td>
                    <td class="style102">
                        Cambiar estado de un socio</td>
                </tr>
        </table>
        <table >
            <tr>
                <td class="auto-style15">
                    </td>
                <td class="auto-style18" >
                    UsuarioLogin del socio a 
                    cambiar de estado</td>
                <td class="style28">
                    <asp:TextBox ID="TBEstado" runat="server"  
                        ToolTip="Introduzca el usuario con el que accede al sistema el socio a cambiar" SkinID="-1"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="cambiarEstadoSocio" runat="server" Text="Cambiar estado" />
                </td>
            </tr>
            <tr>
                <td class="auto-style15">
                    &nbsp;</td>
                <td class="auto-style2" >
                    <asp:DataList ID="DataList1" runat="server" DataKeyField="usuarioLogin" DataSourceID="AccessDataSource2" CellPadding="4" ForeColor="#333333">
                        <AlternatingItemStyle BackColor="White" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <ItemStyle BackColor="#EFF3FB" />
                        <ItemTemplate>
                            Nombre y apellido:
                            <asp:Label ID="nombre_apellidoLabel" runat="server" Text='<%# Eval("nombre_apellido") %>' />
                            <br />
                            Dirección:
                            <asp:Label ID="DireccionLabel" runat="server" Text='<%# Eval("Direccion") %>' />
                            <br />
                            Crédito:
                            <asp:Label ID="CreditoLabel" runat="server" Text='<%# Eval("Credito") %>' />
                            <br />
                            Fecha y hora del alta:
                            <asp:Label ID="Fecha_Hora_AltaLabel" runat="server" Text='<%# Eval("Fecha_Hora_Alta") %>' />
                            <br />
                            Estado:
                            <asp:Label ID="EstadoLabel" runat="server" Text='<%# Eval("Estado") %>' />
                            <br />
                            <br />
                        </ItemTemplate>
                        <SelectedItemStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    </asp:DataList>
                    <asp:AccessDataSource ID="AccessDataSource2" runat="server" DataFile="C:\TEMP\Videoclub.mdb" SelectCommand="SELECT * FROM socio WHERE usuarioLogin=?">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="TBEstado" Name="?" PropertyName="Text" />
                        </SelectParameters>
                    </asp:AccessDataSource>
                </td>
                <td class="style28">
                    &nbsp;</td>
                <td valign="top">
                    <asp:Button ID="mostrarDatosSocio" runat="server" Text="Mostrar datos socio" Width="174px" />
                </td>
            </tr>
        </table>
             
               <br />
        <table >
            <tr>
                <td class="auto-style14">
                    &nbsp;</td>
                <td class="style102">
                    Dar de alta una película</td>
            </tr>
        </table>
        <table >
            <tr>
                <td class="auto-style16">
                    &nbsp;</td>
                <td class="style12">
                    &nbsp;</td>
                <td class="auto-style3">
                    Título de la película a dar de alta</td>
                <td class="style31">
                    <asp:TextBox ID="TBAlta" runat="server"  
                        ToolTip="Introduzca el código de la película a dar de alta" SkinID="-1" Width="174px"></asp:TextBox>
                </td>
                <td class="style23">
                    <asp:Button ID="DarDeAltaPeli" runat="server" Text="Dar de alta película" />
                    </td>
            </tr>
            <tr>
                <td class="auto-style7">
                    </td>
                <td class="auto-style8">
                    </td>
                <td class="auto-style9">
                    Precio de alquiler de la película</td>
                <td class="auto-style10">
                    <asp:TextBox ID="TBPrecio" runat="server" Width="172px"></asp:TextBox>
                </td>
                <td class="auto-style11">
                    </td>
            </tr>
            </table>
                      <br />
        <table >
            <tr>
                <td class="auto-style14">
                    &nbsp;</td>
                <td class="style102">
                    Dar de baja una película</td>
            </tr>
        </table>
        <table >
            <tr>
                <td class="auto-style16">
                    &nbsp;</td>
                <td class="style12">
                    &nbsp;</td>
                <td class="auto-style5">
                    Título de la película a dar de baja</td>
                <td class="auto-style12">
                    <asp:DropDownList ID="DDLBaja" runat="server" CssClass="auto-style13" DataSourceID="AccessDataSource4" Height="16px" Width="278px" DataTextField="nombrepelicula" DataValueField="nombrepelicula">
                    </asp:DropDownList>
                    <asp:AccessDataSource ID="AccessDataSource4" runat="server" DataFile="C:\TEMP\Videoclub.mdb" SelectCommand="SELECT nombrepelicula FROM pelicula WHERE estado LIKE 'disponible'"></asp:AccessDataSource>
                </td>
                <td class="style23">
                    <asp:Button ID="DarDeBajaPeli" runat="server" Text="Dar de baja esta película" Width="213px" />
                    </td>
            </tr>
            <tr>
                <td class="auto-style16">
                    &nbsp;</td>
                <td class="style12">
                    &nbsp;</td>
                <td class="auto-style6">
                    <asp:DataList ID="DataList2" runat="server" DataKeyField="Codigo" DataSourceID="AccessDataSource1">
                        <ItemTemplate>
                            Código:
                            <asp:Label ID="CodigoLabel" runat="server" Text='<%# Eval("Codigo") %>' />
                            <br />
                            Título:
                            <asp:Label ID="NombrePeliculaLabel" runat="server" Text='<%# Eval("NombrePelicula") %>' />
                            <br />
                            Fecha adquisición:
                            <asp:Label ID="FechaCompraLabel" runat="server" Text='<%# Eval("FechaCompra") %>' />
                            <br />
                            Precio:
                            <asp:Label ID="PrecioAlquilerLabel" runat="server" Text='<%# Eval("PrecioAlquiler") %>' />
                            <br />
                            Estado:
                            <asp:Label ID="EstadoLabel" runat="server" Text='<%# Eval("Estado") %>' />
                            <br />
<br />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="C:\TEMP\Videoclub.mdb" SelectCommand="SELECT * FROM pelicula WHERE nombrepelicula LIKE ?">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="DDLBaja" Name="?" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:AccessDataSource>
                </td>
                <td class="auto-style12">
                    &nbsp;</td>
                <td class="style23" valign="top">
                    <asp:Button ID="mostrarDatosPeli" runat="server" 
                        Text="Mostrar datos película" Width="213px" />
                </td>
            </tr>
            </table>
    <table>
    <asp:Button ID="VolverPrincipal" runat="server" Text="Volver a la Página Principal" />
    </table>
    </div>
</asp:Content>
