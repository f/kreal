coffee:
	coffee -c src/static/kreal.coffee
	uglifyjs src/static/kreal.js -o src/static/kreal.js
