@echo off
chcp 65001 >nul 2>&1 
setlocal enableDelayedExpansion
mode 45,23
title EasyFlash

:variaves
set g=[92m
set r=[91m
set red=[04m
set l=[1m
set w=[0m
set b=[94m
set m=[95m
set p=[35m
set c=[35m
set d=[96m
set u=[0m
set z=[91m
set n=[96m
set y=[40;33m
set g2=[102m
set r2=[101m
set t=[40m
set gg=[93m
set q=[90m
set gr=[32m
set o=[38;5;202m
set bb=[38;5;74m
set nn=[38;5;82m
set rr=[1;91m
set blb=[1;94m
set neon_vp=[1;38;5;129m
set ha=[38;5;203m

REM setlocal
	               
	REM call :animated_string "%~1" %~2 %~3 %~4
	call :animated_string "Initializing Easy Flash" 10 10 11

timeout /t 2 /NOBREAK >nul
goto warning

:animated_string
set "string=%~1"
set "frozen="
set "string.length=0"
if "%~4" neq "" ( set "hue=%~4" ) else ( set "hue=15" )
set "ascii_str= #$'*+,-./0123456789:;=?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]_`abcdefghijklmnopqrstuvwxyz{}~"

set "loop=FOR /L %%# in (1,1,2) do "
%loop%%loop% set "loop=!loop!!loop!!loop!"

for /l %%b in (8,-1,0) do (
	set /a "string.length|=1<<%%b"
	for %%c in (!string.length!) do if "!string:~%%c,1!" equ "" set /a "string.length&=~1<<%%b"
)
for /l %%i in (0,1,%string.length%) do set "chr[%%i].ch=!string:~%%i,1!"

%loop% (
	for /l %%i in (0,1,%string.length%) do (
	
		if "!chr[%%i].freeze!" neq "True" (
            set /a "rndchr=!random! %% 86"
            for %%r in (!rndchr!) do (
                set "scrn.string=!scrn.string!!ascii_str:~%%r,1!"
                if "!ascii_str:~%%r,1!" equ "!chr[%%i].ch!" (
                    set "chr[%%i].freeze=True"
                    set /a "frozen+=1"
                )
            )
        ) else (
            set "scrn.string=!scrn.string!!chr[%%i].ch!"
        )
	)
	
	echo [2J%HUD%[48;2;!fade!;!fade!;!fade!;38;5;16m[!map.y!;!map.x!H!lastscrn!%TOP%%cornice%[38;5;!hue!m[%~3;%~2H!scrn.string![0m
	set "scrn.string="
	
	if !frozen! gtr %string.length% (
		for /l %%i in (0,1,%string.length%) do (
			set "chr[%%i].ch="
			set "chr[%%i].freeze="
		)
		goto :eof
	)
)

:warning
mode 30,10
cls	
echo Recommended to use with
echo Motorola's stock roms.
timeout /t 3 /NOBREAK >nul
goto easyflash1

:easyflash1
mode 88,33

echo. ███████╗  █████╗  ███████╗ ██╗   ██╗ ███████╗ ██╗       █████╗  ███████╗ ██╗  ██╗    
echo. ██╔════╝ ██╔══██╗ ██╔════╝ ╚██╗ ██╔╝ ██╔════╝ ██║      ██╔══██╗ ██╔════╝ ██║  ██║    
echo. █████╗   ███████║ ███████╗  ╚████╔╝  █████╗   ██║      ███████║ ███████╗ ███████║    
echo. ██╔══╝   ██╔══██║ ╚════██║   ╚██╔╝   ██╔══╝   ██║      ██╔══██║ ╚════██║ ██╔══██║    
echo. ███████╗ ██║  ██║ ███████║    ██║    ██║      ███████╗ ██║  ██║ ███████║ ██║  ██║    
echo. ╚══════╝ ╚═╝  ╚═╝ ╚══════╝    ╚═╝    ╚═╝      ╚══════╝ ╚═╝  ╚═╝ ╚══════╝ ╚═╝  ╚═╝    
echo.                                                                                      
echo.                          by: InoCity                                                                                      
echo.                                                                                      
echo %gg%[%m% 1 %gg%] Flash StockRom
echo %gg%[%m% 2 %gg%] Flash only boot.img
echo %gg%[%m% 3 %gg%] Flash only dtbo.img
echo %gg%[%m% 4 %gg%] Flash only vendor_boot.img
echo %gg%[%m% 5 %gg%] Flash boot, dtbo, vendor_boot
echo %gg%[%m% 6 %gg%] Reboot device
echo %gg%[%m% 7 %gg%] Close program
echo.                              
echo.                                                                                  
set /p "izi=>%g% "%w%                                                                                                                                         
if %izi% equ 1 goto op1
if %izi% equ 2 goto op2
if %izi% equ 3 goto op3
if %izi% equ 4 goto op4
if %izi% equ 5 goto op5
if %izi% equ 6 goto op6
if %izi% equ 7 goto op7

:op6
mode 45,23
REM setlocal
	               
	REM call :animated_string "%~1" %~2 %~3 %~4
	call :animated_string "Rebooting device" 13 13 10
	timeout /t 2 /NOBREAK >nul
	mode 105,33
	fastboot reboot device
cls
mode 30,10
echo %q% Device Rebooted!
echo %q% 
echo %q% Press any key to continue.
pause >nul
goto easyflash1

:op7
mode 43,23
REM setlocal
	               
	REM call :animated_string "%~1" %~2 %~3 %~4
	call :animated_string "Closing Easy Flash" 13 13 11
	timeout /t 1 /NOBREAK >nul
exit

:op1
mode 45,23
REM setlocal
	               
	REM call :animated_string "%~1" %~2 %~3 %~4
	call :animated_string "Initializing Flash" 13 13 10
	timeout /t 2 /NOBREAK >nul
	mode 105,33
fastboot getvar max-sparse-size 
fastboot oem fb_mode_set 
fastboot flash partition gpt.bin 
fastboot flash bootloader bootloader.img 
fastboot flash vbmeta vbmeta.img 
fastboot flash vbmeta_system vbmeta_system.img 
fastboot flash radio radio.img 
fastboot flash bluetooth BTFM.bin 
fastboot flash dsp dspso.bin 
fastboot flash logo logo.bin 
fastboot flash boot boot.img 
fastboot flash vendor_boot vendor_boot.img 
fastboot flash dtbo dtbo.img 
fastboot flash super super.img_sparsechunk.0 
fastboot flash super super.img_sparsechunk.1 
fastboot flash super super.img_sparsechunk.2 
fastboot flash super super.img_sparsechunk.3 
fastboot flash super super.img_sparsechunk.4 
fastboot flash super super.img_sparsechunk.5 
fastboot flash super super.img_sparsechunk.6 
fastboot flash super super.img_sparsechunk.7 
fastboot flash super super.img_sparsechunk.8 
fastboot flash super super.img_sparsechunk.9 
fastboot erase debug_token 
fastboot erase carrier 
fastboot erase userdata 
fastboot erase metadata 
fastboot erase ddr 
fastboot flash bluetooth BTFM.bin 
fastboot oem fb_mode_clear 
cls
mode 30,10
echo %q% Stockrom flashed sucessfully!
echo %q% 
echo %q% Press any key to continue.
pause >nul
goto easyflash1

:op2
mode 45,23
REM setlocal
	               
	REM call :animated_string "%~1" %~2 %~3 %~4
	call :animated_string "Initializing Flash" 13 13 10
	timeout /t 2 /NOBREAK >nul
	mode 105,33
	fastboot flash boot boot.img 
cls
mode 30,10
echo %q% boot.img flashed sucessfully!
echo %q% 
echo %q% Press any key to continue.
pause >nul
goto easyflash1

:op3
mode 45,23
REM setlocal
	               
	REM call :animated_string "%~1" %~2 %~3 %~4
	call :animated_string "Initializing Flash" 13 13 10
	timeout /t 2 >nul
	mode 105,33
	fastboot flash dtbo dtbo.img 
cls
mode 30,10
echo %q% dtbo.img flashed sucessfully!
echo %q% 
echo %q% Press any key to continue.
pause >nul
goto easyflash1

:op4
mode 45,23
REM setlocal
	               
	REM call :animated_string "%~1" %~2 %~3 %~4
	call :animated_string "Initializing Flash" 13 13 10
	timeout /t 2 /NOBREAK >nul
	mode 105,33
	fastboot flash vendor_boot vendor_boot.img
cls
mode 30,10
echo %q% vendor_boot.img flashed sucessfully!
echo %q% 
echo %q% Press any key to continue.
pause >nul
goto easyflash1

:op5
mode 45,23
REM setlocal
	               
	REM call :animated_string "%~1" %~2 %~3 %~4
	call :animated_string "Initializing Flash" 13 13 10
	timeout /t 2 /NOBREAK >nul
	mode 105,33
	fastboot flash boot boot.img
	fastboot flash dtbo dtbo.img
	fastboot flash vendor_boot vendor_boot.img
cls
mode 30,10
echo %q% boot, dtbo and vendor_boot flashed sucessfully!
echo %q% 
echo %q% Press any key to continue.
pause >nul
goto easyflash1