import core.stdc.stdlib;

import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.stdio;

import sdlang;

import vibe.d;
import vibe.http.fileserver;
import vibe.http.router;
import vibe.http.server;
import vibe.textfilter.markdown;

import utils;

const string LOGO = "=======================================\n" ~
					"= StatiQ.D\n" ~
					"= Static website generator in D\n" ~
					"= \n" ~
					"= By Dr.Kameleon\n" ~
					"=======================================";

const string HELP = "new <path>		\tcreate new Statiq website at path\n" ~
					"build <path>	\tbuild website at path\n" ~
					"run <path>		\tdevelopment-build and run website at path\n\n" ~
					"--help 		\tshow this help screen";

void main(string[] args)
{
	writeln(LOGO);

	args.popFront();

	if (args.count < 1) showError("Not enough arguments", true);

	auto command = args[0];

	switch (command) {
		default:
			 showError("Command not recognized", true);
			 break;
		case "--help":
			writeln(HELP);
			break;
		case "new": 
			if (args.count < 2) showError("Not enough arguments for 'new' - missing project name", true);
			
			auto target = args[1];
			mkdir(target);
			mkdir(target ~ "/build");
			mkdir(target ~ "/data");
			mkdir(target ~ "/pages");
			mkdir(target ~ "/template");
			break;
		case "build":
			if (args.count < 2) showError("Not enough arguments for 'build' - missing project name", true);

			auto target = args[1];
			break;
		case "run":
			if (args.count < 2) showError("Not enough arguments for 'run' - missing project name", true);

			auto target = args[1];
			foreach (f; getFiles(target,".md")) {
				writeln(f);
				writeln(readText(f));
			}
			break;
	}

	writeln("Command: " ~ command);
	writeln(filterMarkdown("## This is a heading"));
	
	writeln("ARG[1] = " ~ args[1]);
	foreach (f; getFiles("test",".md")) {
		writeln(f);
	}

}
