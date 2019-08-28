module statiq.page;

import vibe.textfilter.markdown;

import std.file;
import std.stdio;
import std.string;

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