module statiq.website;

import std.file;
import std.stdio;
import std.string;

import statiq.page;
import statiq.theme;
import statiq.data;
import statiq.config;

import utils;

class Website {

	string path;

	Page[] pages;
	Theme[] themes;
	Data[] datas;
	Config config;

	this(string p, bool createIfNotExists=false) {
		path = p;

		if (path.exists && createIfNotExists) showError("Project already exists at path.\nIf you want to build it, use: statiq run <project>");

		if (!path.exists) {
			if (createIfNotExists) createNewProject(path);
			else showError("Project does not exist at path.\nIf you want to create it, use: statiq new <project>");
		}

		foreach (f; getFiles(path ~ "/pages", ".md")) {
			pages ~= new Page(f,path);
		}

		foreach (f; getFiles(path ~ "/theme", ".html")) {
			themes ~= new Theme(f);
		}

		foreach (f; getFiles(path ~ "/data", ".json")) {
			datas ~= new Data(f);
		}

		config = new Config(path ~ "/config.sdl");
	}

	void createNewProject(string p) {
		mkdir(p);
		mkdir(p ~ "/build");
		mkdir(p ~ "/data");
			std.file.write(p ~ "/data/main.json", import("templates/main.json"));
		mkdir(p ~ "/pages");
			std.file.write(p ~ "/pages/index.md", import("templates/index.md"));
		mkdir(p ~ "/theme");
			std.file.write(p ~ "/theme/index.html", import("templates/index.html"));

		std.file.write(p ~ "/config.sdl", import("templates/config.sdl").replace("%NAME%",p));
	}

	void build() {
		foreach (p; pages) {
			p.render();
		}
	}

	void print() {
		writeln("[website] path: " ~ path);
		writeln("> pages");
		foreach (p; pages) {
			p.print();
		}
		writeln("> theme");
		foreach (t; themes) {
			t.print();
		}
		writeln("> data");
		foreach (d; datas) {
			d.print();
		}
		writeln("> config");
		config.print();
	}
}