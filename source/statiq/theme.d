/*************************************************
* Statiq.d - Static Website Generator in D
* Copyright (c) 2019 Dr.Kameleon
*
* @file: statiq/theme.d
**************************************************/

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