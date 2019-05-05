Public Class Register
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        RegisterUser.ContinueDestinationPageUrl = Request.QueryString("ReturnUrl")
    End Sub

    Protected Sub RegisterUser_CreatedUser(ByVal sender As Object, ByVal e As EventArgs) Handles RegisterUser.CreatedUser
        FormsAuthentication.SetAuthCookie(RegisterUser.UserName, False)
        Dim continueUrl As String = RegisterUser.ContinueDestinationPageUrl
        If String.IsNullOrEmpty(continueUrl) Then
            continueUrl = "~/"
        End If
        Dim cadenaConexion As String = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\TEMP\Videoclub.mdb"
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
        Dim strSQL As String
        Dim dbCom As OleDb.OleDbCommand
        strSQL = "INSERT INTO socio(usuarioLogin) VALUES(?)"
        dbCom = New OleDb.OleDbCommand(strSQL, conexion)
        dbCom.Parameters.Add(New OleDb.OleDbParameter("username", OleDb.OleDbType.VarChar)).Value = RegisterUser.UserName
        Try
            dbCom.ExecuteNonQuery()
        Catch exSql As Exception
            MsgBox("No se pudo añadir el socio " + RegisterUser.UserName + " a la base de datos.")
        Finally
            'PASO 4. CERRAR conexion Y LIBERAR MEMORIA
            'Cerramos la conexión y liberamos la memoria que hayamos podido utilizar
            If conexion.State = ConnectionState.Open Then
                conexion.Close()
                conexion.Dispose()
            End If
        End Try
        Response.Redirect(continueUrl)
    End Sub
End Class