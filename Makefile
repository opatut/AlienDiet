default: build run

build:
	zip -r game.love data/
	cd src/ && zip ../game.love *

run:
	love game.love

