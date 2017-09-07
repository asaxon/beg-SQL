/*
FileName:	Performance-Ledger_Card_Report
Author	:	Adric Saxon
Date	:	9/6/2017
PBI 	:	
Purpose	:	Improve performance of view, adding indexes, using MSDN
			[https://docs.microsoft.com/en-us/sql/relational-databases/views/create-indexed-views]
			
History	:	9/6/2017 - Initially built for client, but view would have needed total rewrite
						so just keeping framework
		

*/	

--// Pre-Work: Taking stock of performance prior
/*
USE db_name;
GO
SET SHOWPLAN_XML ON;
GO
--Show me how SQL Server is analyizing/optimizing, give me idea of resources used, end goal improving view
--ESTIMATED execution plan
select * from rpt_saLedgerCard_vw;
GO
SET SHOWPLAN_XML OFF;
GO

USE db_name;
GO
SET STATISTICS XML ON;
GO
--ACTUAL execution plan
select * from rpt_saLedgerCard_vw;
GO
SET STATISTICS XML OFF;
*/

--// Pre-Work: Verify SET options correct for session
DECLARE @options INT
SELECT @options = @@OPTIONS

PRINT @options
IF ( (1 & @options) = 1 ) PRINT 'DISABLE_DEF_CNST_CHK' 
IF ( (2 & @options) = 2 ) PRINT 'IMPLICIT_TRANSACTIONS' 
IF ( (4 & @options) = 4 ) PRINT 'CURSOR_CLOSE_ON_COMMIT' 
IF ( (8 & @options) = 8 ) PRINT 'ANSI_WARNINGS' 
IF ( (16 & @options) = 16 ) PRINT 'ANSI_PADDING' 
IF ( (32 & @options) = 32 ) PRINT 'ANSI_NULLS' 
IF ( (64 & @options) = 64 ) PRINT 'ARITHABORT' 
IF ( (128 & @options) = 128 ) PRINT 'ARITHIGNORE'
IF ( (256 & @options) = 256 ) PRINT 'QUOTED_IDENTIFIER' 
IF ( (512 & @options) = 512 ) PRINT 'NOCOUNT' 
IF ( (1024 & @options) = 1024 ) PRINT 'ANSI_NULL_DFLT_ON' 
IF ( (2048 & @options) = 2048 ) PRINT 'ANSI_NULL_DFLT_OFF' 
IF ( (4096 & @options) = 4096 ) PRINT 'CONCAT_NULL_YIELDS_NULL' 
IF ( (8192 & @options) = 8192 ) PRINT 'NUMERIC_ROUNDABORT' 
IF ( (16384 & @options) = 16384 ) PRINT 'XACT_ABORT'

--// Pre-Work: Verify SET @ DB level
SELECT 
    name,
	database_id
    is_ansi_nulls_on,
    is_ansi_padding_on,
    is_ansi_warnings_on,
    is_arithabort_on,
    is_concat_null_yields_null_on,
    is_numeric_roundabort_on,
    is_quoted_identifier_on
FROM sys.databases
where database_id = (select db_id())

--// Pre-Work: Backuped original using SSMS [rpt_saLedgerCard_vw_bak]

--// Pre-Work: Drop view
DROP VIEW dbo.[ view_name ] ;
GO

--// Work: Recreate view with indexes
USE [live_03]
GO

/****** Object:  View [dbo].[ view_name ]    Script Date: 9/6/2017 11:52:14 PM ******/
--// This and ANSI_NULLS must be set to ON when view created,, both stored with view metadata
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
/* Uncomment if Pre-Work identifies SET options are missing, or anything needed
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET NUMERIC_ROUNDABORT ON
*/
GO





GO



--5 Create unique clustered index on view
--6 Create nonclustered index(s) as needed





--// Post-Work: