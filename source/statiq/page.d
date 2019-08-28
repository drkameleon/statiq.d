/*************************************************
* Statiq.d - Static Website Generator in D
* Copyright (c) 2019 Dr.Kameleon
*
* @file: statiq/page.d
**************************************************/

module statiq.page;

import std.file;
import std.stdio;
import std.string;
import vibe.textfilter.markdown;

class Page {
	string base;
	string path;
	string content;
	string target;

	this(string p,string b) {
		base = b;
		path = p;
		content = readText(p);
		target = path.replace("pages/","build/").replace(".md",".html");
	}

	void render() {
		auto converted = filterMarkdown(content);
		std.file.write(target, converted);
	}

	void print() {
		writeln("\t[page] path: " ~ path);
		writeln("\t[page] content: " ~ content);
	}
}