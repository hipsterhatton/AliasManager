# AliasManager v0.2
Custom Terminal Alias Manager (Al.Ma.)

# Usage
- Simple way to add / delete / edit custom terminal alias in *~/.bash_profile*
- Can be used to sync terminal alias between various devices, projects, etc.
- Creates a backup of *~/.bash_profile* called *~/.backup_bash_profile* each time it runs

# Setup
## Format

Each custom alias is stored as a 2 column entry in *alias.csv* using the format:

	shortcut, command to run
E.g.:

	docs, cd ~/Documents/SomeImportantFolder
	dls, cd ~/Downloads

Would generate the aliases:

	alias docs=‘cd ~/Documents’
	alias dls=‘cd ~/Downloads’


## To Run
In Terminal, change to the folder where Al.Ma. is stored and run via Ruby:

	ruby alias_manager.rb

Al.Ma. then reads through *alias.csv*, and either:

- Adds each custom alias to *~/.bash_profile*
- Updates any changed custom alias
- Removes any custom alias from *~/.bash_profile* (**which no longer exists in alias.csv**)

# Requires:
Ruby

# v0.2 Changes
- Prints out list of aliases added / removed
- Refactoring of code

# License
Copyright (c) 2015, Stephen Hatton

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED “AS IS” AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.