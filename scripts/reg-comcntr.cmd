set version=8.3.16.1148
set x64=C:\Program Files\1cv8\%version%\bin\comcntr.dll
set x32=C:\Program Files (x86)\1cv8\%version%\bin\comcntr.dll
set reg64=%systemroot%\System32\regsvr32.exe
set reg32=%systemroot%\SysWoW64\regsvr32.exe

%reg64% /i /s "%x64%"
%reg64% /u /s "%x32%"
%reg64% /i /s "%x64%"
%reg32% /u /s "%x64%"
%reg64% /i /s "%x64%"
%reg32% /u /s "%x32%"
%reg64% /i "%x64%"