/*************************************************
* Statiq.d - Static Website Generator in D
* Copyright (c) 2019 Dr.Kameleon
*
* @file: app.d
**************************************************/

import core.stdc.stdlib;
import sdlang;
import std.algorithm;
import std.array;
import std.file;
import std.path;
import std.stdio;

import statiq.website;
import utils;

const string VERSION = "0.1";

const string HEADER_STR = import("header.txt").replace("%VERSION%",VERSION);
const string HELP_STR = import("help.txt").replace("%HEADER%",HEADER_STR);
const string VERSION_STR = import("version.txt").replace("%VERSION%",VERSION);

const bool DEBUG = true;

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

			if (DEBUG) ws.print();

			break;
		case "run":
			writeln(HEADER_STR);
			if (args.count < 2) showError("Not enough arguments for 'run' - missing project name", true);

			Website ws = new Website(args[1],false);

			if (DEBUG) ws.print();

			ws.build();

			break;
		default:
			showError("Command not recognized", true);
			break;
	}

}
