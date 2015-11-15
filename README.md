# AliasManager v0.2
Custom Terminal Alias Manager (Al.Ma.)

# Usage
- Simple way to add / delete / edit custom terminal aliases in *~/.bash_profile*
- Can be used to sync terminal aliases between various devices, projects, etc.
- Creates a backup of *~/.bash_profile* (*~/.backup_bash_profile*) each time it runs

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
- Removes any custom alias from *~/.bash_profile* (**which no longer exist in alias.csv**)

# Requires:
Ruby

# v0.2 Changes
- Prints out list of aliases added / removed
- Refactoring of code