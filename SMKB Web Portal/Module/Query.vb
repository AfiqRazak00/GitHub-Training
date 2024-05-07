

Imports System.Data.SqlClient
Imports System.Net.Http
Imports System.Web.Services
Imports Microsoft.Ajax.Utilities
''' 
''' This class handles database queries with functionality to rollback and log query
''' Exception will be logged but not handled in this class
''' query method will return false on error
''' 
Public Class Query

    'Default connection string 
    Public Shared connString As String = "Data Source=devmis12.utem.edu.my\sql_ins02;Initial Catalog=DbKewanganV4;Persist Security Info=True;User ID=Smkb;Password=Smkb@Dev2012"

    'for out of session use eg: API
    Public userId As String

    'sql connection object
    Private conn As SqlConnection

    'boolean flag which marks if the connection object initialized by this class or received from paramater
    Private isInnerCon As Boolean = True

    'object holding sqltransaction data to allow rollbacks
    Private transaction As SqlTransaction

    Private operation As String

    Private table As String

    Private ID As Dictionary(Of String, String)

    Private processDescription As String = Nothing



    ''' <summary>
    '''     This method execute queries based on the sqlcommand object in parameter
    ''' </summary>
    ''' <param name="id_rujukan"> Key-Value Pay of the ID ColumnName:Value of the record </param>
    ''' <param name="cmd"> Is the command object which at least must have Command Text attribute </param>
    ''' <param name="processDesc"> Descripion of the process to be appended into the audit log process information </param>
    ''' <returns>
    '''     Return integer which represents the number of rows affected by the query
    '''     -1 will be returned on error
    ''' </returns>
    Public Function execute(id_rujukan As Dictionary(Of String, String), cmd As SqlCommand, Optional processDesc As String = Nothing) As Integer
        Try
            If processDesc IsNot Nothing Then
                processDescription = processDesc
            End If
            initialize(cmd)
            ID = id_rujukan
            parseQuery(cmd.CommandText)

            Dim result As Integer = cmd.ExecuteNonQuery()

            If logTransaction() > 0 Then
                Return result
            Else
                Return -1
            End If

            'If result > 0 Then
            '    Return result
            'Else
            '    Return -1
            'End If

        Catch ex As Exception
            'error still not complete
            logError("Insert Data", ex)
            Return -1
        End Try
    End Function

    ''' <summary>
    '''     This method execute queries based on the sql string and SqlParameter list in the parameters
    ''' </summary>
    ''' <param name="id_rujukan"> Key-Value Pay of the ID ColumnName:Value of the record </param>
    ''' <param name="sqlString"> String containing the SQL syntax of the operation to be executed </param>
    ''' <param name="param"> List of SQLParameters required to execute the SQLstring </param>
    ''' <param name="processDesc"> Descripion of the process to be appended into the audit log process information </param>
    ''' <returns>
    '''     Return integer which represents the number of rows affected by the query
    '''     -1 will be returned on error
    ''' </returns>
    Public Function execute(id_rujukan As Dictionary(Of String, String), sqlString As String, param As List(Of SqlParameter), Optional processDesc As String = Nothing) As Integer
        Dim ncmd As SqlCommand = New SqlCommand()
        ncmd.CommandText = sqlString
        ncmd.Parameters.Add(param)
        Return execute(id_rujukan, ncmd, processDesc)
    End Function

    ''' <summary> 
    '''     This method execute queries based on the sql string and SqlParameter list in the parameters
    ''' </summary>
    ''' <param name="id_rujukan"> String of the value of the id for the record being processed </param>
    ''' <param name="id_col"> The column name of the ID column for the related table </param>
    ''' <param name="sqlString"> String containing the SQL syntax of the operation to be executed </param>
    ''' <param name="param"> List of SQLParameters required to execute the SQLstring </param>
    ''' <param name="processDesc"> Descripion of the process to be appended into the audit log process information </param>
    ''' <returns>
    '''     Return integer which represents the number of rows affected by the query
    '''     -1 will be returned on error
    ''' </returns>
    Public Function execute(id_rujukan As String, id_col As String, sqlString As String, param As List(Of SqlParameter), Optional processDesc As String = Nothing) As Integer
        Dim ncmd As SqlCommand = New SqlCommand()
        ncmd.CommandText = sqlString
        ncmd.Parameters.Add(param)
        Return execute(New Dictionary(Of String, String) From {{id_col, id_rujukan}}, ncmd, processDesc)
    End Function

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="No_Order"> String of the value of the id for the record being processed </param>
    ''' <param name="id_col"> The column name of the ID column for the related table </param>
    ''' <param name="cmd"> Is the command object which at least must have Command Text attribute </param>
    ''' <param name="processDesc"> Descripion of the process to be appended into the audit log process information </param>
    ''' <returns>
    '''     Return integer which represents the number of rows affected by the query
    '''     -1 will be returned on error
    ''' </returns>
    Public Function execute(No_Order As String, id_col As String, cmd As SqlCommand, Optional processDesc As String = Nothing) As Integer
        Return execute(New Dictionary(Of String, String) From {{id_col, No_Order}}, cmd, processDesc)
    End Function


    ''' <summary>
    ''' This method apply the changes made by sql queries through object of this class
    ''' Connection will be closed if it is not connection passed by caller 
    ''' if logging failed, changes will not be committed
    ''' </summary>
    Public Sub finish()
        'transaction.Commit()
        If isInnerCon Then
            conn.Close()
            conn.Dispose()
        End If
    End Sub

    ''' <summary>
    '''  This method to rollback/cancel any sql transaction done using the object of this class
    ''' </summary>    
    Public Sub rollback()
        'transaction.Rollback()
        If isInnerCon Then
            conn.Close()
            conn.Dispose()
        End If
    End Sub


    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="process"></param>
    ''' <param name="exc"></param>
    Public Sub logError(process As String, exc As Exception)
        Dim stacks As New StackTrace(True)
        Dim fname As String = stacks.GetFrame(0).GetFileName()
        Dim source As String = "" 'Err_Event
        Dim i As Integer = 0

        'trace the files related to the current method calls
        For Each st As StackFrame In stacks.GetFrames()

            'only consider file other than this files
            If Not String.IsNullOrEmpty(st.GetFileName()) AndAlso Not st.GetFileName().Equals(fname) Then
                source += " [" + i.ToString() + "] Method: " + st.GetMethod().Name + " in : " + st.GetFileName() + " at line " + st.GetFileLineNumber().ToString()
                i += 1
            End If
        Next

        Dim errCmd As New SqlCommand
        errCmd.Connection = conn
        'errCmd.Transaction = transaction

        errCmd.CommandText = "INSERT INTO SMKB_Err_Log (Err_Date,Err_Dec,Err_Form,Err_Event,Err_UID) VALUES 
            (getdate(),@Err_Dec,@Err_Form,@Err_Event,@Err_UID)"
        'errCmd.Parameters.Add(New SqlParameter("@Err_Dec", Left(source, 250))) 'temporarily take 250 char only, database limit
        'errCmd.Parameters.Add(New SqlParameter("@Err_Form", exc.GetType().ToString()))
        ' errCmd.Parameters.Add(New SqlParameter("@Err_Event", exc.Message))
        'errCmd.Parameters.Add(New SqlParameter("@Err_UID", HttpContext.Current.Session("ssusrID")))

        'errCmd.ExecuteNonQuery()
        'log error here to db later
    End Sub

    Public Shared Sub logError_RunningNo(No_Rujukan As String, Kod_Modul As String, Butiran As String)
        If String.IsNullOrEmpty(No_Rujukan) Then
            Return
        End If
        Dim errCmd As New SqlCommand
        errCmd.Connection = New SqlConnection(Query.connString)
        errCmd.Connection.Open()
        errCmd.CommandText = "INSERT INTO SMKB_Rollback_Noakhir (Butiran,No_Rujukan,Kod_Modul,Tahun)
            VALUES (@Butiran,@No_Rujukan,@Kod_Modul,@Tahun)"
        errCmd.Parameters.Add(New SqlParameter("@Butiran", Butiran))
        errCmd.Parameters.Add(New SqlParameter("@No_Rujukan", No_Rujukan))
        errCmd.Parameters.Add(New SqlParameter("@Kod_Modul", Kod_Modul))
        errCmd.Parameters.Add(New SqlParameter("@Tahun", "20" + Right(No_Rujukan, 2)))
        errCmd.ExecuteNonQuery()
        errCmd.Connection.Close()
    End Sub

    ' set the additional description of the process for logging purpose
    Public Sub setProcessDescription(desc As String)
        processDescription = desc
    End Sub

    ' set the transaction object to use external existing transaction to allow grouping multiple query
    Public Sub setTransaction(transact As SqlTransaction)
        transaction = transact
    End Sub

    '''  
    ''' This method intialize the sql command object passed
    ''' if connection already exist it will be used 
    '''    if existing connection is passed inside the object, this class will not handle its closure
    '''    
    ''' if no existing connection default connecton string will be used to create a new connection
    '''  
    '''  
    Private Sub initialize(cmd As SqlCommand)
        If cmd.Connection Is Nothing And conn Is Nothing Then
            conn = New SqlConnection(Query.connString)
            conn.Open()
            isInnerCon = True
        ElseIf cmd.Connection IsNot Nothing Then
            conn = cmd.Connection

            If conn.State <> ConnectionState.Open Then
                conn.Open()
            End If

            isInnerCon = False
        End If
        'If transaction Is Nothing Then
        '    transaction = conn.BeginTransaction()
        'End If
        cmd.Connection = conn
        'cmd.Transaction = transaction
    End Sub

    ''' <summary>
    ''' This method logs the information related to the query into the audit trail table
    ''' </summary> 
    Private Function logTransaction() As Integer
        Try

            'Read current value of the record being processed
            Dim snapshot As New SqlCommand
            snapshot.Connection = conn
            'snapshot.Transaction = transaction
            Dim whereClause As String = ""

            'construct where clause using the key value pairs in ID
            For Each kvp As KeyValuePair(Of String, String) In ID
                Dim colName As String = kvp.Key

                If whereClause <> "" Then
                    whereClause &= " AND "
                End If

                whereClause &= colName & " = @" & colName
                snapshot.Parameters.Add(New SqlParameter("@" & colName, kvp.Value))
            Next
            snapshot.CommandText = "SELECT * FROM " + table + " WHERE " + whereClause

            Dim dt As New DataTable
            dt.Load(snapshot.ExecuteReader())

            'Parse current value converted into a signel string with | as separator
            Dim snapshotValue As String = "No Previous Value"
            Dim colnames As String = ""
            If dt.Rows.Count > 0 Then
                snapshotValue = ""
                Dim row As DataRow = dt.Rows(0)

                For Each col As DataColumn In dt.Columns

                    'concat all value with | as separator
                    snapshotValue += row(col.ColumnName).ToString() + "|"
                    colnames += col.ColumnName + "|"
                Next
            End If

            If Not String.IsNullOrWhiteSpace(processDescription) Then
                operation = operation + "-" + processDescription
            End If

            'log the whole process related details
            Dim logcmd As New SqlCommand
            logcmd.Connection = conn
            'logcmd.Transaction = transaction

            logcmd.CommandText = "INSERT INTO SMKB_Audit_Trail (User_ID,Tarikh_Transaksi,Proses,Value,Nama_Table,Sub_Menu,Medan) VALUES 
                                    (@UID,getdate(),@Proses, @Value ,@Nama_Table,@Sub_Menu,@Medan)"
            Dim kodMenu As String
            If HttpContext.Current.Session IsNot Nothing Then

                kodMenu = HttpContext.Current.Session("kodsubmenu")
                userId = HttpContext.Current.Session("ssusrID")
            Else
                kodMenu = "API"
            End If

            logcmd.Parameters.Add(New SqlParameter("@UID", userId))
            logcmd.Parameters.Add(New SqlParameter("@Proses", operation))
            logcmd.Parameters.Add(New SqlParameter("@Value", snapshotValue))
            logcmd.Parameters.Add(New SqlParameter("@Nama_Table", table))
            logcmd.Parameters.Add(New SqlParameter("@Sub_Menu", kodMenu))
            logcmd.Parameters.Add(New SqlParameter("@Medan", colnames))

            Return logcmd.ExecuteNonQuery()

        Catch ex As Exception
            Throw New Exception("Failed to log transaction: " + ex.Message)
        End Try
    End Function

    Private Sub parseQuery(ByVal query As String)
        Dim parsed As List(Of String) = query.Split(" "c).ToList()
        operation = parsed.ElementAt(0).Trim().ToLower()

        If operation.Equals("insert") Or operation.Equals("delete") Then
            'insert into table   || delete from table
            ' 0       1    2          0      1    2
            table = parsed.ElementAt(2).Trim().ToLower()
        ElseIf operation.Equals("update") Then
            'update table set
            ' 0       1
            table = parsed.ElementAt(1).Trim().ToLower()
        End If
    End Sub

End Class
