for %%G in (*.sql) do sqlcmd /S localhost\SQLEXPRESS /d AdventureWorksDWH -E -i"%%G"
pause