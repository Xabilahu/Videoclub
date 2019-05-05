Imports System.Data.OleDb 'Para las conexiones tipo OleDb -- ACCESS
Public Class FormularioFuncionesSOCIO
    Inherits System.Web.UI.Page
    'Asigna a Usuario el LoginName actual pasado a minúsculas (para las comparaciones)
    Dim usuario As String = StrConv(System.Web.HttpContext.Current.User.Identity.Name, VbStrConv.Lowercase)
    'Indicamos la cadena de conexion (tipo OLEDB)
    Dim cadenaConexion As String = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\TEMP\Videoclub.mdb"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Comprobamos que se haya iniciado sesión
        If usuario = "" Then
            MsgBox("Debes Iniciar Sesión para poder operar como Socio")
            Response.Redirect("default.aspx")
        End If
        If Page.IsPostBack = False Then 'Solamente se hace cuando vaya a esta página
            'DECLARAR LAS VARIABLES NECESARIAS para las instrucciones de BD
            Dim conexion As OleDb.OleDbConnection
            Dim strSQL As String
            Dim dbComm As OleDbCommand
            'PASO 1. CREAR UNA CONEXION Y ABRIRLA
            conexion = New OleDb.OleDbConnection(cadenaConexion)
            conexion.Open()
            '*******************************************************************************************
            ' SE RECUPERA EL ESTADO DEL SOCIO QUE HA INICIADO LA SESIÓN
            '*******************************************************************************************
            'PASOS 2 Y 3. PREPARAR LA INSTRUCCION SQL Y EJECUTARLA
            strSQL = "SELECT estado FROM SOCIO WHERE usuarioLogin=?"
            dbComm = New OleDbCommand(strSQL, conexion)
            dbComm.Parameters.Add(New OleDbParameter("usuario", OleDbType.VarChar)).Value = usuario
            Dim estado As String  'Para guardar el estado del socio en la aplicación
            estado = dbComm.ExecuteScalar()    ' Ejecuta una SELECT en la que solo se obtiene un dato

            '*******************************************************************************************
            ' SI ES UN SOCIO ACTIVO (su estado es A), SE MUESTRAN SUS DATOS PERSONALES
            '*******************************************************************************************
            If estado <> "A" Then
                'Si su estado no es activo visualizar un mensaje
                MsgBox("Has sido dado de baja por el administrador del video club. No puedes operar.")
                Response.Redirect("default.aspx")
            Else
                'Recuperar los demás datos del socio desde la BD y mostrarlos -- EJEMPLO DE SELECT
                'PASO 2. Preparar la instrucción SQL a ejecutar
                strSQL = "SELECT nombre_apellido,direccion,credito FROM SOCIO WHERE usuarioLogin='" & usuario & "'"
                dbComm = New OleDbCommand(strSQL, conexion)
                'PASO 3. Ejecutarla
                Dim datosSocioReader As OleDbDataReader
                datosSocioReader = dbComm.ExecuteReader()  'Ejecuta una SELECT que obtiene varios datos
                'Tratar el resultado, es decir, los datos obtenidos por la select
                While datosSocioReader.Read() 'Si hay varias filas las va leyendo una por una
                    'Se asignan los datos recuperados a los distintos TextBox de la página Web
                    Me.TBNombre.Text = datosSocioReader(0) 'Primer dato de la fila
                    Me.TBDireccion.Text = datosSocioReader(1) 'Segundo dato de la fila
                End While
            End If
            'PASO 4. CERRAR LA CONEXIÓN Y LIBERAR MEMORIA
            conexion.Close()
            conexion.Dispose()
        End If
    End Sub

    Protected Sub VolverPrincipal_Click(ByVal sender As Object, ByVal e As EventArgs) Handles VolverPrincipal.Click
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub Aumentar_Click(sender As Object, e As EventArgs) Handles Aumentar.Click
        'Creamos la conexion
        Dim conexion As OleDb.OleDbConnection
        conexion = New OleDb.OleDbConnection(cadenaConexion)
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
        'Preparamos la instruccion
        Dim strSQL As String
        Dim dbComm As OleDbCommand
        strSQL = "update socio set credito = credito + ? where usuarioLogin=?"
        dbComm = New OleDbCommand(strSQL, conexion)
        Dim aumentocredito As Double
        aumentocredito = CDbl(cantidadEuros.Text)
        dbComm.Parameters.Add(New OleDbParameter("credit", OleDbType.Double)).Value = aumentocredito
        dbComm.Parameters.Add(New OleDbParameter("user", OleDbType.VarChar)).Value = usuario
        'ejecutar
        Try
            dbComm.ExecuteNonQuery()
            MsgBox("Se ha aumentado el crédito correctamente")
        Catch exsql As Exception
            MsgBox("Error al aumentar el crédito")
        End Try
        'Apagamos conexion
        If conexion.State = ConnectionState.Open Then
            conexion.Close()
            conexion.Dispose()
        End If
    End Sub

    Protected Sub Devolver_Click(sender As Object, e As EventArgs) Handles Devolver.Click
        'Creamos la conexion
        Dim conexion As OleDb.OleDbConnection
        conexion = New OleDb.OleDbConnection(cadenaConexion)
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
        'Preparamos la instruccion
        Dim transaccion As OleDbTransaction
        Dim strSQL As String
        Dim dbComm As OleDbCommand
        Dim codigoPeli As Integer
        Dim fecha As DateTime
        transaccion = conexion.BeginTransaction()
        Try
            '1 ins
            strSQL = "update pelicula set estado='disponible' where nombrePelicula=?"
            dbComm = New OleDbCommand(strSQL, conexion, transaccion)
            dbComm.Parameters.Add(New OleDbParameter("titulo", OleDbType.VarChar)).Value = DDLDevolver.Text
            dbComm.ExecuteNonQuery()
            '2 ins
            strSQL = "select pelicula.codigo, prestamo.fechainicio from pelicula inner join prestamo on pelicula.codigo = prestamo.codigo where nombrePelicula=? and fechaFin is null"
            dbComm = New OleDbCommand(strSQL, conexion, transaccion)
            dbComm.Parameters.Add(New OleDbParameter("titulo", OleDbType.VarChar)).Value = DDLDevolver.Text
            Dim params As OleDbDataReader
            params = dbComm.ExecuteReader()
            While params.Read()
                codigoPeli = params(0)
                fecha = params(1)
            End While
            '3 ins
            strSQL = "update prestamo set FechaFin=now() where codigo=? and fechainicio=?"
            dbComm = New OleDbCommand(strSQL, conexion, transaccion)
            dbComm.Parameters.Add(New OleDbParameter("codigo", OleDbType.VarChar)).Value = codigoPeli
            dbComm.Parameters.Add(New OleDbParameter("fechain", OleDbType.DBTimeStamp)).Value = fecha
            dbComm.ExecuteNonQuery()
            'ejecutar
            transaccion.Commit()
            DDLDevolver.DataBind()
            DDLAlquilar.DataBind()
        Catch ex As Exception
            MsgBox("Error al devolver la película")
            transaccion.Rollback()
        End Try
        'Apagamos conexion
        If conexion.State = ConnectionState.Open Then
            conexion.Close()
            conexion.Dispose()
        End If
    End Sub

    Protected Sub Modificar_Click(sender As Object, e As EventArgs) Handles Modificar.Click
        'Creamos la conexion
        Dim conexion As OleDb.OleDbConnection
        conexion = New OleDb.OleDbConnection(cadenaConexion)
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
        'Preparamos la instruccion
        Dim strSQL As String
        Dim dbComm As OleDbCommand
        strSQL = "update socio set nombre_apellido = ?, direccion = ? where usuarioLogin= ? "
        dbComm = New OleDbCommand(strSQL, conexion)
        dbComm.Parameters.Add(New OleDbParameter("nombreAp", OleDbType.VarChar)).Value = TBNombre.Text
        dbComm.Parameters.Add(New OleDbParameter("direccion", OleDbType.VarChar)).Value = TBDireccion.Text
        dbComm.Parameters.Add(New OleDbParameter("user", OleDbType.VarChar)).Value = usuario
        'ejecutar
        Try
            dbComm.ExecuteNonQuery()
            MsgBox("Se han modificado los datos personales correctamente")
        Catch exsql As Exception
            MsgBox("Error al modificar los datos personales")
        End Try
        'Apagamos conexion
        If conexion.State = ConnectionState.Open Then
            conexion.Close()
            conexion.Dispose()
        End If
    End Sub

    Protected Sub Alquilar_Click(sender As Object, e As EventArgs) Handles Alquilar.Click
        'Creamos la conexion
        Dim conexion As OleDb.OleDbConnection
        conexion = New OleDb.OleDbConnection(cadenaConexion)
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
        'Preparamos la instruccion
        Dim transaccion As OleDbTransaction
        Dim strSQL As String
        Dim dbComm As OleDbCommand
        Dim codigoPeli As Integer
        Dim precioPeli As Double
        Dim creditoUser As Double
        transaccion = conexion.BeginTransaction()
        Try
            'cogemos el precio peli
            strSQL = "select PrecioAlquiler from pelicula where nombrePelicula=?"
            dbComm = New OleDbCommand(strSQL, conexion, transaccion)
            dbComm.Parameters.Add(New OleDbParameter("titulo", OleDbType.VarChar)).Value = DDLAlquilar.Text
            precioPeli = dbComm.ExecuteScalar()
            'cogemos el credito del usuario logeado
            strSQL = "select credito from socio where usuarioLogin=?"
            dbComm = New OleDbCommand(strSQL, conexion, transaccion)
            dbComm.Parameters.Add(New OleDbParameter("usuarioLogin", OleDbType.VarChar)).Value = usuario
            creditoUser = dbComm.ExecuteScalar()
            If creditoUser >= precioPeli Then
                '1 ins
                strSQL = "update pelicula set estado='alquilada' where nombrePelicula=?"
                dbComm = New OleDbCommand(strSQL, conexion, transaccion)
                dbComm.Parameters.Add(New OleDbParameter("titulo", OleDbType.VarChar)).Value = DDLAlquilar.Text
                dbComm.ExecuteNonQuery()
                '2 ins
                strSQL = "select codigo from pelicula where nombrePelicula=?"
                dbComm = New OleDbCommand(strSQL, conexion, transaccion)
                dbComm.Parameters.Add(New OleDbParameter("titulo", OleDbType.VarChar)).Value = DDLAlquilar.Text
                codigoPeli = dbComm.ExecuteScalar()
                '3 ins
                strSQL = "insert into prestamo values(?,?,now(),null)"
                dbComm = New OleDbCommand(strSQL, conexion, transaccion)
                dbComm.Parameters.Add(New OleDbParameter("userLogin", OleDbType.VarChar)).Value = usuario
                dbComm.Parameters.Add(New OleDbParameter("codigo", OleDbType.VarChar)).Value = codigoPeli
                dbComm.ExecuteNonQuery()
                '4 ins
                strSQL = "update socio set credito = credito - ? where usuarioLogin=?"
                dbComm = New OleDbCommand(strSQL, conexion, transaccion)
                dbComm.Parameters.Add(New OleDbParameter("credit", OleDbType.Double)).Value = precioPeli
                dbComm.Parameters.Add(New OleDbParameter("user", OleDbType.VarChar)).Value = usuario
                dbComm.ExecuteNonQuery()
                'ejecutar
                transaccion.Commit()
                DDLAlquilar.DataBind()
                DDLDevolver.DataBind()
            Else
                MsgBox("No dispone del dinero suficiente para alquilar esta pelicula." + vbCrLf + "Precio de la pelicula: " + CStr(precioPeli) + "€" +
                       vbCrLf + "El crédito del que dispone es: " + CStr(creditoUser) + "€")
                transaccion.Rollback()
            End If
        Catch ex As Exception
            MsgBox("Error al alquilar la película.")
            transaccion.Rollback()
        End Try
        'Apagamos conexion
        If conexion.State = ConnectionState.Open Then
            conexion.Close()
            conexion.Dispose()
        End If
    End Sub
End Class