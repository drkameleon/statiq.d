import core.stdc.stdlib;

import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.stdio;

void showError(string msg, bool terminal = false) {
	writeln("\x1B[31mError \x1B[37m: " ~ msg);
	if (terminal) {
		writeln("For command line options, use --help");
	}	
	exit(0);
}

string[] getFiles(string path,string ext) {
	return dirEntries("test", SpanMode.depth)
		   .filter!(a => a.isFile && extension(a)==ext)
		   .map!(a => a.name)
		   .array;
}