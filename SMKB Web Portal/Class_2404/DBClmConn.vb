﻿Imports System.Data.Odbc
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class DBClmConn

#Region "Declares"
    Private dbConn 'As OdbcConnection
    Private dbComm 'As OdbcCommand
    Private dbAdapter 'As OdbcDataAdapter
    Private dbSQLTxn As SqlTransaction
    Private dbODBCTxn As OdbcTransaction
    Private dbDataset As DataSet
    Private strSQL As String
    Public ConnectionString As String

    'Public strDbServer As String
    'Public strDbName As String
    'Public strDBConnType As String
    'Public strDBUser As String
    'Public strDBPassword As String
    'Dim MyRegistryObject


    Private dbcmd As SqlCommand
    Private status_ As String
    Public dt As DataTable
    Private dr As SqlDataReader
#End Region

    Public Sub New()
        sReadConfig()
        sInitializeConnStr()
        sCreateConnection()
    End Sub

    Public Function sReadConfig()

        strDbCLMServer = WebConfigurationManager.AppSettings("DBClmServerName")
        strDbCLMName = WebConfigurationManager.AppSettings("DBClmName")
        strDBCLMPassword = WebConfigurationManager.AppSettings("DBClmPassword")
        strDBCLMUser = WebConfigurationManager.AppSettings("DBClmUserID")

    End Function

    Public Function sSelectCommand(ByVal strSQL As String) As String
        Dim ResultCnt As String
        Dim SQLReader As SqlDataReader
        Dim OdbcReader As OdbcDataReader
        Try
            If dbConn.State = ConnectionState.Closed Then
                sCreateConnection()
            End If
            dbComm = New SqlCommand(strSQL, dbConn, dbSQLTxn)
            SQLReader = dbComm.ExecuteReader
            While SQLReader.Read()
                ResultCnt = SQLReader.GetString(0)
            End While

            Return ResultCnt
        Catch ex As Exception
            Console.Write(ex.Message)

            Return -1
        Finally
            If SQLReader Is Nothing = False Then
                SQLReader.Close()
                SQLReader = Nothing
            End If
            If OdbcReader Is Nothing = False Then
                OdbcReader.Close()
                OdbcReader = Nothing
            End If
            sCloseConnection()
        End Try
    End Function

    Public Function fSelectCommand2(ByVal strSQL As String) As DataSet
        Dim dbDataset As DataSet
        Dim SQLReader As SqlDataReader
        Try
            If dbConn.State = ConnectionState.Closed Then
                sCreateConnection()
            End If

            dbComm = New SqlCommand(strSQL, dbConn, dbSQLTxn)
            dbAdapter.SelectCommand = dbComm
            dbDataset = New DataSet
            'dbAdapter.FillSchema(dbDataset, SchemaType.Source)
            dbAdapter.MissingSchemaAction = MissingSchemaAction.AddWithKey
            dbAdapter.Fill(dbDataset)
            'dbDataset.DataSetName = DatasetName

            Return dbDataset
        Catch ex As Exception
            Console.Write(ex.Message)

        Finally
            'sCloseConnection()
        End Try
    End Function

    'for executing select statements
    Public Function fSelectCommand(ByVal strSQL As String, ByVal DatasetName As String) As DataSet
        Dim dbDataset As DataSet
        Dim SQLReader As SqlDataReader
        Try
            If dbConn.State = ConnectionState.Closed Then
                sCreateConnection()
            End If
            dbComm = New SqlCommand(strSQL, dbConn, dbSQLTxn)
            dbAdapter.SelectCommand = dbComm
            dbDataset = New DataSet
            'dbAdapter.FillSchema(dbDataset, SchemaType.Source)

            dbAdapter.Fill(dbDataset, DatasetName)
            dbDataset.DataSetName = DatasetName

            Return dbDataset
        Catch ex As Exception
            Console.Write(ex.Message)

        Finally
            'sCloseConnection()
        End Try
    End Function

    'Return 1 column value based on the query
    'Public Function fSelectCommand(ByVal strSQL As String) As Int32
    '    Dim ResultCnt As Int32
    '    Dim SQLReader As SqlDataReader
    '    Dim OdbcReader As OdbcDataReader
    '    Try
    '        If dbConn.State = ConnectionState.Closed Then
    '            sCreateConnection()
    '        End If
    '        dbComm = New SqlCommand(strSQL, dbConn, dbSQLTxn)
    '        SQLReader = dbComm.ExecuteReader
    '        While SQLReader.Read()
    '            ResultCnt = SQLReader.GetInt32(0)
    '        End While
    '        If SQLReader Is Nothing = False Then
    '            SQLReader.Close()
    '            SQLReader = Nothing
    '        End If
    '        If OdbcReader Is Nothing = False Then
    '            OdbcReader.Close()
    '            OdbcReader = Nothing
    '        End If
    '        Return ResultCnt
    '    Catch ex As Exception
    '        Console.Write(ex.Message)

    '        Return -1
    '    Finally
    '        'sCloseConnection()
    '    End Try
    'End Function


    ''' <summary>
    ''' execute select command
    ''' </summary>
    ''' <param name="strSql">sql string</param>
    ''' <returns></returns>
    Public Function fselectCommand(ByVal strSql As String) As DataSet
        Dim strType As String

        Try
            If dbConn.State = ConnectionState.Closed Then
                sCreateConnection()
            End If

            dbComm = New SqlCommand(strSql, dbConn)
            dbComm.CommandTimeout = 600000
            dbAdapter.SelectCommand = dbComm

            dbDataset = New DataSet
            dbAdapter.Fill(dbDataset)

            If Not dbDataset Is Nothing Then
                Return dbDataset
            Else
                Return Nothing
            End If

        Catch ex As Exception
            Console.Write(ex.Message)
            Return Nothing
        Finally
            sCloseConnection()
        End Try
    End Function



    'for executing update statement by passing in a SQL statement
    Public Function fUpdateCommand(ByVal strSQL As String) As Long
        Dim intRec As Long
        Try
            'If dbConn.State = ConnectionState.Closed Then
            '    sCreateConnection()
            'End If
            'sConnBeginTrans()
            dbComm = New SqlCommand(strSQL, dbConn, dbSQLTxn)

            intRec = dbComm.ExecuteNonQuery
            Return intRec
        Catch ex As Exception
            Console.Write(ex.Message)
            Return 0
        Finally
            'sCloseConnection()
        End Try
    End Function


    'Execute Non Query without Transaction
    Public Function fUpdateCommand2(ByVal strSQL As String) As Long
        Dim intRec As Long
        Try
            'If dbConn.State = ConnectionState.Closed Then
            '    sCreateConnection()
            'End If
            'sConnBeginTrans()
            dbComm = New SqlCommand(strSQL, dbConn, dbSQLTxn)

            intRec = dbComm.ExecuteNonQuery
            Return intRec

        Catch ex As Exception
            Console.Write(ex.Message)
            Return 0
        Finally
            'sCloseConnection()
        End Try
    End Function

    'for executing update statement by passing in a dataset
    Public Sub sUpdateCommand(ByVal ds As DataSet)
        Dim s As String

        Try
            If dbConn.State = ConnectionState.Closed Then
                sCreateConnection()
            End If

            If ds.HasChanges Then
                s = ds.DataSetName
                dbAdapter.SelectCommand = New OdbcCommand(s, dbConn)

                Dim cmb As New OdbcCommandBuilder(dbAdapter)
                dbAdapter.MissingSchemaAction = MissingSchemaAction.AddWithKey

                dbAdapter.Update(ds)
            End If
        Catch ex As Exception
            Console.Write(ex.Message)

        Finally
            'sCloseConnection()
        End Try
    End Sub

    'for executing insert statements by passing in a SQL statement
    Public Function fInsertCommand(ByVal strSQL As String, ByRef NewID As Long) As Integer
        Dim intRec As Integer
        Dim dbDataset As DataSet
        'Dim sqlReader As SqlDataReader
        'Dim odbcReader As OdbcDataReader
        Try
            'If dbConn.State = ConnectionState.Closed Then
            '    sCreateConnection()
            'End If
            'sConnBeginTrans()
            dbComm = New SqlCommand(strSQL, dbConn, dbSQLTxn)
            intRec = dbComm.ExecuteNonQuery
            strSQL = "SELECT @@IDENTITY AS 'Identity'"
            'dbComm.CommandText = strSQL
            'If strDBConnType = "SQL" Then
            '    dbComm.CommandText = strSQL
            '    dbComm = New SqlCommand(strSQL, dbConn, dbSQLTxn)
            '    sqlReader = dbComm.ExecuteReader()
            '    sqlReader.Read()
            '    NewID = CLng(sqlReader("Identity"))
            'ElseIf strDBConnType = "ODBC" Then
            '    dbComm = New OdbcCommand(strSQL, dbConn, dbODBCTxn)
            '    odbcReader = dbComm.ExecuteReader()
            '    odbcReader.Read()
            '    NewID = CLng(odbcReader("Identity"))
            'End If
            dbComm = New SqlCommand(strSQL, dbConn, dbSQLTxn)
            dbAdapter.SelectCommand = dbComm
            dbDataset = New DataSet
            dbAdapter.Fill(dbDataset, "Tbl")
            dbDataset.DataSetName = "Tbl"
            NewID = dbDataset.Tables("Tbl").Rows(0)("Identity")
            Return intRec
        Catch ex As Exception
            Console.Write(ex.Message)
            Return 0
        Finally
            'sCloseConnection()
        End Try
    End Function

    Public Function fInsertCommand(ByVal strSQL As String) As Integer
        Dim intRec As Integer
        Dim dbDataset As DataSet
        Try
            'If dbConn.State = ConnectionState.Closed Then
            '    sCreateConnection()
            'End If
            'sConnBeginTrans()
            dbComm = New SqlCommand(strSQL, dbConn, dbSQLTxn)
            intRec = dbComm.ExecuteNonQuery
            Return intRec
        Catch ex As Exception
            Console.Write(ex.Message)
            Return 0
        Finally
            'sCloseConnection()
        End Try
    End Function

    'for executing insert statements by passing in a dataset
    Public Sub sInsertCommand(ByVal ds As DataSet)
        Dim s As String

        Try
            If dbConn.State = ConnectionState.Closed Then
                sCreateConnection()
            End If

            If ds.HasChanges Then
                s = ds.DataSetName
                dbAdapter.SelectCommand = New OdbcCommand(s, dbConn)

                Dim cmb As New OdbcCommandBuilder(dbAdapter)
                dbAdapter.MissingSchemaAction = MissingSchemaAction.AddWithKey

                dbAdapter.Update(ds)
            End If
        Catch ex As Exception
            Console.Write(ex.Message)
        Finally
            'sCloseConnection()
        End Try
    End Sub

    'for executing insert statements by passing in a dataset and return a dataset
    Public Function fInsertCommand(ByVal ds As DataSet) As DataSet
        Dim s As String
        Dim rds As DataSet

        Try
            If dbConn.State = ConnectionState.Closed Then
                sCreateConnection()
            End If

            If ds.HasChanges Then
                s = ds.DataSetName
                dbAdapter.SelectCommand = New OdbcCommand(s, dbConn)

                Dim cmb As New OdbcCommandBuilder(dbAdapter)
                dbAdapter.MissingSchemaAction = MissingSchemaAction.AddWithKey

                dbAdapter.Update(ds)
            End If
        Catch ex As Exception
            Console.Write(ex.Message)
        Finally
            'sCloseConnection()
        End Try
    End Function

    Public Function fExecuteSP(ByVal StoredProcedure As String, ByRef NewID As Long) As Integer
        Dim intRec As Long
        Dim ExeSP As SqlCommand
        Dim sparam(2) As SqlClient.SqlParameter
        Try
            ExeSP = New SqlCommand
            ExeSP.CommandType = CommandType.StoredProcedure
            ExeSP.CommandText = StoredProcedure
            ExeSP.Connection = dbConn
            With sparam(0)
                sparam(0) = New SqlParameter
                sparam(0).ParameterName = "@DocProfile"
                sparam(0).Direction = ParameterDirection.Input
                sparam(0).SqlDbType = SqlDbType.VarChar
                sparam(0).Value = "Profile6"
            End With
            With sparam(1)
                sparam(1) = New SqlParameter
                sparam(1).ParameterName = "@CreatedBy"
                sparam(1).Direction = ParameterDirection.Input
                sparam(1).SqlDbType = SqlDbType.Int
                sparam(1).Value = 1
            End With
            With sparam(2)
                sparam(2) = New SqlParameter
                sparam(2).ParameterName = "@NEWPROFILEID"
                sparam(2).Direction = ParameterDirection.Output
                sparam(2).SqlDbType = SqlDbType.Int
            End With
            ExeSP.Parameters.Add(sparam(0))
            ExeSP.Parameters.Add(sparam(1))
            ExeSP.Parameters.Add(sparam(2))
            intRec = ExeSP.ExecuteNonQuery()
            NewID = ExeSP.Parameters("@NEWPROFILEID").Value

            'Select Case strDBConnType
            '    Case "SQL"
            '        dbComm = New SqlCommand(StoredProcedure, dbConn, dbSQLTxn)
            '    Case "ODBC"
            '        dbComm = New OdbcCommand(StoredProcedure, dbConn, dbODBCTxn)
            '    Case Else
            '        dbComm = New SqlCommand(StoredProcedure, dbConn, dbSQLTxn)
            'End Select
            'intRec = dbComm.ExecuteNonQuery

            Return intRec
        Catch ex As Exception
            Console.Write(ex.Message)
            Return 0
        Finally
            'sCloseConnection()
        End Try
    End Function


    'to create the database connection
    Private Sub sCreateConnection()
        Try
            dbConn = New SqlConnection
            dbAdapter = New SqlDataAdapter

            'dbSQLTxn = New SqlTransaction

            dbConn.ConnectionString = ConnectionString '"DSN=KJTEST; UID=sa; PWD=1293; persist security info=False;"
            dbConn.Open()

        Catch ex As Exception
            Console.Write(ex.Message)
        End Try
    End Sub

    'to test the connection if is open or not
    Public Function fChkDBConn() As Boolean
        Try
            If dbConn.State = ConnectionState.Open Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Console.Write(ex.Message)
        End Try
    End Function

    'to close the database connection
    Public Sub sCloseConnection()
        Try
            If Not dbDataset Is Nothing Then
                dbDataset.Dispose()
            End If
            If Not dbAdapter Is Nothing Then
                dbAdapter.Dispose()
            End If
            If Not dbComm Is Nothing Then
                dbComm.Dispose()
            End If
            'If Not dbConn Is Nothing Then
            '    dbConn.Close()
            'End If
            If dbConn.State = ConnectionState.Open Then
                dbConn.Close()
            End If
        Catch ex As Exception
            Console.Write(ex.Message)
        End Try
    End Sub

    'Initialize the Connection String based on the DB Type
    Private Sub sInitializeConnStr()
        Dim strDeDBCLMPassword
        Dim clsCrypto As New clsCrypto
        strDeDBCLMPassword = clsCrypto.fDecrypt(strDBCLMPassword)

        ConnectionString = "Server=" & strDbCLMServer & ";Database=" & strDbCLMName & ";Uid=" & strDBCLMUser & ";Pwd=" & strDeDBCLMPassword & ";"

    End Sub


    'Begin the database transaction
    Public Sub sConnBeginTrans()
        Try
            dbSQLTxn = dbConn.BeginTransaction()

        Catch ex As Exception
            Console.Write(ex.Message)

        End Try
    End Sub

    'Commit the database transaction
    Public Sub sConnCommitTrans()
        Try
            If Not dbSQLTxn Is Nothing Then
                dbSQLTxn.Commit()
            End If

        Catch ex As Exception
            Console.Write(ex.Message)

        End Try
    End Sub

    'Commit the database transaction
    Public Sub sConnRollbackTrans()
        Try
            dbSQLTxn.Rollback()

        Catch ex As Exception
            Console.Write(ex.Message)
        End Try
    End Sub

    Private Sub RunQuery(query As Object, param As List(Of SqlParameter), type As CommandType)
        Try
            Using mycon As New SqlConnection()
                mycon.ConnectionString = strConClm
                mycon.Open()
                dbcmd = New SqlCommand(query, mycon)
                dbcmd.CommandType = CommandType.Text
                If param IsNot Nothing Then
                    param.ForEach(Function(x)
                                      dbcmd.Parameters.Add(x)
                                  End Function)
                End If

                If type = 1 Then
                    If dbcmd.ExecuteNonQuery().Equals(1) Then
                        'dbcmd = New SqlCommand("SELECT SCOPE_IDENTITY();", mycon)
                        'current_id = dbcmd.ExecuteScalar()
                        ProcStatus = "OK"
                    Else
                        ProcStatus = "X"
                    End If
                ElseIf type = 0 Then
                    dt = New DataTable
                    dr = dbcmd.ExecuteReader
                    dt.Load(dr)
                    dr.Close()
                End If
                mycon.Close()
            End Using
        Catch ex As SqlException
            ProcStatus = ex.Message.ToString
        End Try
    End Sub

    Public Function Process(query As String, ByVal param As List(Of SqlParameter)) As String
        RunQuery(query, param, 1)
        Return Status()
    End Function

    Public Function Read(query As Object, Optional ByVal param As List(Of SqlParameter) = Nothing) As DataTable
        RunQuery(query, param, 0)
        Return dt
    End Function

    Public Function Status() As String
        Return ProcStatus
    End Function

    Public Property ProcStatus As String
        Get
            Return status_
        End Get
        Set(value As String)
            status_ = value
        End Set
    End Property

End Class



