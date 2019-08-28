module statiq.data;

import std.conv;
import std.file;
import std.json;
import std.stdio;

class Data {
	string path;
	string content;

	JSONValue db;

	this(string p) {
		path = p;
		content = readText(path);

		db = parseJSON(content);
	}

	void print() {
		writeln("\t[data] path: " ~ path);
		writeln("\t[data] db: " ~ to!string(db));
	}
}