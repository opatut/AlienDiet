default: run

package_win32: build
	mkdir -p package/tmp/
	mkdir -p package/win32/
	cat /home/paul/tray/love_win/love.exe > package/tmp/game.exe
	cat game.love >> package/tmp/game.exe
	cp /home/paul/tray/love_win/*.dll package/tmp/
	cd package/tmp/ && zip ../win32/game.zip *.dll game.exe

build:
	zip -r game.love src/

run:
	love src/

