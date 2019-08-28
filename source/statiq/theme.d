module statiq.theme;

import std.file;
import std.stdio;

class Theme {
	string path;
	string content;

	this(string p) {
		path = p;
		content = readText(p);
	}

	void print() {
		writeln("\t[theme] path: " ~ path);
	}
}