Imports System.Data.OleDb

Public Class FormularioFuncionesADM
    Inherits System.Web.UI.Page
    'Asigna a Usuario el LoginName actual pasado a minúsculas (para las comparaciones)
    Dim usuario As String = StrConv(System.Web.HttpContext.Current.User.Identity.Name, VbStrConv.Lowercase)
    Dim cadenaConexion As String = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\TEMP\Videoclub.mdb"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Asegurarse de que ha iniciado sesión como administrador
        If usuario = "" Then
            MsgBox("Debes Iniciar Sesión como administrador para poder operar aqui")
            Response.Redirect("default.aspx")
        Else
            If usuario <> "administrador" Then
                MsgBox("No eres el administrador. Solo puedes realizar las funciones del Socio")
                Response.Redirect("default.aspx")
            End If
        End If
    End Sub

    Protected Sub VolverPrincipal_Click(ByVal sender As Object, ByVal e As EventArgs) Handles VolverPrincipal.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub cambiarEstadoSocio_Click(sender As Object, e As EventArgs) Handles cambiarEstadoSocio.Click
        'PASO 1. ABRIR LA CONEXION VERIFICANDO QUE SEA CORRECTA.
        'Declarar y crear una nueva conexión
        Dim conexion As OleDb.OleDbConnection
        conexion = New OleDb.OleDbConnection(cadenaConexion)
        'Intentar abrirla
        Try
            If conexion.State = ConnectionState.Closed Then
                conexion.Open()
            End If
        Catch ex As Exception
            'No se ha podido abrir la conexión: Se debe repasar la cadena de conexión
            MsgBox("Error al conectar con la base de datos")
            Response.Write(ex.Message)
            Response.Write(". Esta es tu cadena de conexion: " & cadenaConexion)
            Response.End()
        End Try

        'PASO 2. PREPARAR LA INSTRUCCION SQL A EJECUTAR
        Dim strSQL As String
        Dim dbComm As OleDbCommand
        Dim estado As Char

        strSQL = "SELECT estado FROM socio WHERE usuarioLogin = ?"
        dbComm = New OleDbCommand(strSQL, conexion)
        dbComm.Parameters.Add(New OleDbParameter("socio", OleDbType.VarChar)).Value = TBEstado.Text
        estado = dbComm.ExecuteScalar()

        If estado = "A" Then
            estado = "B"
        Else
            estado = "A"
        End If

        strSQL = "UPDATE socio SET estado = ? WHERE usuarioLogin = ?"
        dbComm = New OleDbCommand(strSQL, conexion)
        dbComm.Parameters.Add("estado", OleDbType.Char).Value = estado
        dbComm.Parameters.Add("socio", OleDbType.VarChar).Value = TBEstado.Text

        Try
            dbComm.ExecuteNonQuery()
        Catch exSql As Exception
            MsgBox("Socio no existente: " + TBEstado.Text)
        Finally
            'PASO 4. CERRAR conexion Y LIBERAR MEMORIA
            'Cerramos la conexión y liberamos la memoria que hayamos podido utilizar
            If conexion.State = ConnectionState.Open Then
                conexion.Close()
                conexion.Dispose()
            End If
        End Try
        DataList1.DataBind()
    End Sub

    Protected Sub DarDeAltaPeli_Click(sender As Object, e As EventArgs) Handles DarDeAltaPeli.Click

        If TBAlta.Text = "" Or TBPrecio.Text = "" Then
            MsgBox("Introduzca los datos de la película a dar de alta.")
        Else
            'PASO 1. ABRIR LA CONEXION VERIFICANDO QUE SEA CORRECTA.
            'Declarar y crear una nueva conexión
            Dim conexion As OleDb.OleDbConnection
            conexion = New OleDb.OleDbConnection(cadenaConexion)
            'Intentar abrirla
            Try
                If conexion.State = ConnectionState.Closed Then
                    conexion.Open()
                End If
            Catch ex As Exception
                'No se ha podido abrir la conexión: Se debe repasar la cadena de conexión
                MsgBox("Error al conectar con la base de datos")
                Response.Write(ex.Message)
                Response.Write(". Esta es tu cadena de conexion: " & cadenaConexion)
                Response.End()
            End Try

            'PASO 2. PREPARAR LA INSTRUCCION SQL A EJECUTAR
            Dim strSQL As String
            Dim dbComm As OleDbCommand
            strSQL = "SELECT count(codigo) FROM pelicula WHERE nombrepelicula=?"
            dbComm = New OleDbCommand(strSQL, conexion)
            dbComm.Parameters.Add(New OleDbParameter("titulo", OleDbType.VarChar)).Value = TBAlta.Text
            Try
                Dim numPelis As Integer
                numPelis = dbComm.ExecuteScalar()
                If (numPelis = 0) Then
                    strSQL = "SELECT max(codigo) FROM pelicula"
                    Dim cod As Integer
                    dbComm = New OleDbCommand(strSQL, conexion)
                    cod = dbComm.ExecuteScalar() + 1
                    strSQL = "INSERT INTO pelicula(codigo,nombrepelicula,precioalquiler,estado) VALUES(?,?,?,'disponible')"
                    dbComm = New OleDbCommand(strSQL, conexion)
                    dbComm.Parameters.Add(New OleDbParameter("codigo", OleDbType.Integer)).Value = cod
                    dbComm.Parameters.Add(New OleDbParameter("titulo", OleDbType.VarChar)).Value = TBAlta.Text
                    dbComm.Parameters.Add(New OleDbParameter("precio", OleDbType.Double)).Value = CDbl(TBPrecio.Text)
                    dbComm.ExecuteNonQuery()
                Else
                    MsgBox("La película " + TBAlta.Text + " ya está dada de alta.")
                End If
            Catch exSql As Exception
                MsgBox("Error al dar de alta la película.")
            Finally
                'PASO 4. CERRAR conexion Y LIBERAR MEMORIA
                'Cerramos la conexión y liberamos la memoria que hayamos podido utilizar
                If conexion.State = ConnectionState.Open Then
                    conexion.Close()
                    conexion.Dispose()
                End If
            End Try
            DDLBaja.DataBind()
        End If
    End Sub

    Protected Sub DarDeBajaPeli_Click(sender As Object, e As EventArgs) Handles DarDeBajaPeli.Click
        'Declarar y crear una nueva conexión
        Dim conexion As OleDb.OleDbConnection
        conexion = New OleDb.OleDbConnection(cadenaConexion)
        'Intentar abrirla
        Try
            If conexion.State = ConnectionState.Closed Then
                conexion.Open()
            End If
        Catch ex As Exception
            'No se ha podido abrir la conexión: Se debe repasar la cadena de conexión
            MsgBox("Error al conectar con la base de datos")
            Response.Write(ex.Message)
            Response.Write(". Esta es tu cadena de conexion: " & cadenaConexion)
            Response.End()
        End Try

        'PASO 2. PREPARAR LA INSTRUCCION SQL A EJECUTAR
        Dim strSQL As String
        Dim dbComm As OleDbCommand
        strSQL = "update pelicula set estado = 'SR-descatalog' where nombrepelicula=?"
        dbComm = New OleDbCommand(strSQL, conexion)
        dbComm.Parameters.Add(New OleDbParameter("titulo", OleDbType.VarChar)).Value = DDLBaja.Text
        Try
            dbComm.ExecuteNonQuery()
        Catch exSql As Exception
            MsgBox("Error al dar de baja la película.")
        Finally
            'PASO 4. CERRAR conexion Y LIBERAR MEMORIA
            'Cerramos la conexión y liberamos la memoria que hayamos podido utilizar
            If conexion.State = ConnectionState.Open Then
                conexion.Close()
                conexion.Dispose()
            End If
        End Try
        DDLBaja.DataBind()
    End Sub
End Class