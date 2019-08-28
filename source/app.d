import core.stdc.stdlib;

import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.stdio;

import sdlang;
/*
import vibe.d;
import vibe.http.fileserver;
import vibe.http.router;
import vibe.http.server;
*/

import utils;

import statiq.website;

const string VERSION = "0.1";

const string HEADER_STR = import("header.txt").replace("%VERSION%",VERSION);
const string HELP_STR = import("help.txt").replace("%HEADER%",HEADER_STR);
const string VERSION_STR = import("version.txt").replace("%VERSION%",VERSION);

void main(string[] args)
{
	args.popFront();
	if (args.count < 1) showError("Not enough arguments", true);

	switch (args[0]) {
		case "--help": writeln(HELP_STR); break;
		case "--version": writeln(VERSION_STR); break;

		case "new": 
			writeln(HEADER_STR);
			if (args.count < 2) showError("Not enough arguments for 'new' - missing project name", true);
			
			Website ws = new Website(args[1],true);
			ws.print();

			break;
		case "run":
			writeln(HEADER_STR);
			if (args.count < 2) showError("Not enough arguments for 'run' - missing project name", true);

			Website ws = new Website(args[1],false);
			ws.print();
			ws.build();
			/*
			foreach (f; getFiles(target,".md")) {
				auto tfile = target ~ "/" ~ f.replace(target,"build").replace("pages/","").replace(".md",".html");
				auto ocontent = readText(f);

				writeln("File: " ~ f);
				writeln("Target: " ~ tfile);
				
				std.file.write(tfile, filterMarkdown(ocontent));
				//writeln(f);
				//writeln(readText(f));
			}*/
			break;

		default:
			showError("Command not recognized", true);
			break;
	}

}
