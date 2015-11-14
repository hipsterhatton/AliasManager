require "FileUtils"

def get_vars
	return {

		:WELCOME_MSG => 		"\n**** Alias Manger - v0.2 - by Stephen Hatton *****\n",
		:PROGRESS_MSG => 		"Importing Alias...",
		:ENDING_MSG_1 => 		"...Finished\n",
		:ENDING_MSG_2 => 		"A '~/.bash_profile' Backup File Was Created @: ~/.backup_bash_profile\n",
		:BLANK_MSG => 			"...Alias File Was Empty\n",

		:FILE_START_MESSAGE => "### Alias Imported by AliasManager: https://github.com/hipsterhatton/AliasManager",
		:FILE_END_MESSAGE => 	"### Alias Import End",

		:ALIAS_IMPORT_FILE => 	"Alias.csv",
		:ALIAS_WRITE_FILE => 	"~/.bash_profile",
		:ALIAS_BACKUP_FILE => 	"~/.backup_bash_profile",

		:RED => 	31,
		:GREEN => 	32,
		:YELLOW =>	33,
		:PINK =>	35,
	}
end

def _colorize(text, color_code)
	# Print out the text using colour
    "\e[#{color_code}m#{text}\e[0m"
end

def create_alias

	file_content = []

	begin
	    file = File.new(get_vars[:ALIAS_IMPORT_FILE], "r")

	    while (line = file.gets)
	        alias_parts = line.split(",")
	        file_content << "alias #{alias_parts.first.strip}=\'#{alias_parts.last.strip}\'"
	    end

	    file.close
	    return file_content
	rescue => err
		err_msg = "...Exception: #{err}\n"
	    puts _colorize(err_msg, get_vars[:RED])
	    return []
	end	
end

def get_existing_alias

	file_content = []
	old_alias = []
	write_file = File.expand_path(get_vars[:ALIAS_WRITE_FILE])

	# We use the comments inserted into ~/.bash_profile as indicators for when we should start/stop ignoring the lines of text in file
	start_message = get_vars[:FILE_START_MESSAGE]
	end_message = 	get_vars[:FILE_END_MESSAGE]

	begin
	    file = File.new(write_file, "r")
	    ignore = false

	    while (line = file.gets)
	    	ignore = true if line.include? start_message
	    	file_content << line if ignore == false
	    	old_alias << line if ignore == true
	    	ignore = false if line.include? end_message
	    end

	    file.close
	    return [ file_content, old_alias ]
	rescue => err
		err_msg = "...Exception: #{err}\n"
	    puts _colorize(err_msg, get_vars[:RED])
	    return []
	end	
end

def write_alias_to_file(alias_to_write, existing_file_content)

	write_file = 	File.expand_path(get_vars[:ALIAS_WRITE_FILE])
	backup_file = 	File.expand_path(get_vars[:ALIAS_BACKUP_FILE])

    # Make a copy of ~/.bash_profile, just in case!
	File.rename(write_file, backup_file)

	# Write all the new aliases to ~/.bash_profile
	begin
	    file = File.new(write_file, "w")

	    existing_file_content.first.each do |x| ; file.write(x) if x.ord != 10 ; end

		green_colour = 	get_vars[:GREEN]
		yellow_colour = get_vars[:YELLOW]

	    alias_to_write.unshift("\n#{ get_vars[:FILE_START_MESSAGE] }\n") if alias_to_write != []
	    alias_to_write << "\n#{ get_vars[:FILE_END_MESSAGE] }" if alias_to_write != []

	    alias_to_write.each_with_index do |x, i|
	    	file.write(x)
	    	file.write("\n")
	    	puts _colorize("  (+) #{x}", green_colour) if i > 0 && i < alias_to_write.count-1
	    end

	    existing_file_content.last.each_with_index do |x, i|
	    	puts _colorize("  (-) #{x.strip}", yellow_colour) if i > 1 && i < existing_file_content.last.count-2 && !alias_to_write.include?(x.strip)
	    end

	    file.close
	    return
	rescue => err
		err_msg = "...Exception: #{err}\n"
	    puts _colorize(err_msg, get_vars[:RED])
	    return
	end	
end

# Print Welcome Message
puts _colorize(get_vars[:WELCOME_MSG], get_vars[:GREEN])

# Print Message 
puts _colorize(get_vars[:PROGRESS_MSG], get_vars[:GREEN])

# Write Alias To File (Construct New Alias, Get Existing Alias)
write_alias_to_file(create_alias, get_existing_alias)

# Print End Message
puts _colorize(get_vars[:ENDING_MSG_1], get_vars[:GREEN])
puts _colorize(get_vars[:ENDING_MSG_2], get_vars[:PINK])