/*************************************************
* Statiq.d - Static Website Generator in D
* Copyright (c) 2019 Dr.Kameleon
*
* @file: statiq/config.d
**************************************************/

module statiq.config;

import sdlang;
import std.algorithm;
import std.conv;
import std.file;
import std.stdio;

import utils;

class Config {
	string path;
	string content;

	string[string] info;

	this(string p) {
		path = p;
		content = readText(p);

		try {	
			Tag root = parseSource(content);

			root.all.tags.each!( (Tag t) => 
				info[to!string(t.getFullName)] = to!string(t.values[0])
			);
		}
		catch(ParseException e) {
			showError("Error parsing config.sdl file", false);
		}
	}

	void print() {
		writeln("\t[config] path: " ~ path);
		writeln("\t[config] info: " ~ to!string(info));
	}
}