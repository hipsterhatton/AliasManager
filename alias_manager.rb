#!/usr/bin/env ruby

kVERSION = 				"1.0"
kAUTHOR = 				"Stephen Hatton"

kWELCOME_MSG = 			"\n**** Alias Manger - #{kVERSION} - #{kAUTHOR} *****\n"
kPROGRESS_MSG = 		"Importing Alias..."
kENDING_MSG = 			"...Import Finished\n"
kBLANK_MSG = 			"...Alias File Was Empty\n"

kFILE_START_MESSAGE = 	"### Alias Imported by AliasManager: https://github.com/hipsterhatton/AliasManager"
kFILE_END_MESSAGE = 	"### Alias Import End"

kALIAS_IMPORT_FILE = 	"Alias.csv"
kALIAS_WRITE_FILE = 	"~/.bash_profile"


def _colorize(text, color_code)

    "\e[#{color_code}m#{text}\e[0m"
end

def create_alias(import_file)

	file_content = []

	begin
	    file = File.new(import_file, "r")

	    while (line = file.gets)
	        alias_parts = line.split(",")
	        file_content << "alias #{alias_parts.first.strip}=\'#{alias_parts.last.strip}\'"
	    end

	    file.close
	    return file_content
	rescue => err
		err_msg = "...Exception: #{err}\n"
	    puts _colorize(err_msg, 31)
	    return []
	end	
end

def read_existing_alias(write_file, start_message, end_message)

	file_content = []
	write_file = File.expand_path(write_file)

	begin
	    file = File.new(write_file, "r")
	    ignore = false

	    while (line = file.gets)
	    	ignore = true if line.include? start_message
	    	file_content << line if ignore == false
	    	ignore = false if line.include? end_message
	    end

	    file.close
	    return file_content
	rescue => err
		err_msg = "...Exception: #{err}\n"
	    puts _colorize(err_msg, 31)
	    return []
	end	
end

def write_alias_to_file(write_file, start_message, end_message, existing_file_content, alias_to_write)

	write_file = File.expand_path(write_file)

	# Delete the old file
	File.delete(write_file)

	# Create the new one :: write all this now!
	begin
	    file = File.new(write_file, "w")

	    existing_file_content.each do |x| ; file.write(x) if x.ord != 10 ; end

	    alias_to_write.unshift("\n#{start_message}\n") if alias_to_write != []
	    alias_to_write << "\n#{end_message}" if alias_to_write != []

	    alias_to_write.each do |x| ; file.write(x) ; file.write("\n") ; end
	    file.close
	    return
	rescue => err
		err_msg = "...Exception: #{err}\n"
	    puts _colorize(err_msg, 31)
	    return
	end	
end


# Print Welcome Message
puts _colorize(kWELCOME_MSG, 32)

# Print Message + Read Alias File
puts _colorize(kPROGRESS_MSG, 32)
alias_to_write = create_alias(kALIAS_IMPORT_FILE)

# Read Existing File
file_content = read_existing_alias(kALIAS_WRITE_FILE, kFILE_START_MESSAGE, kFILE_END_MESSAGE)

# Write Alias To File
write_alias_to_file(kALIAS_WRITE_FILE, kFILE_START_MESSAGE, kFILE_END_MESSAGE, file_content, alias_to_write)

# Print End Message
puts _colorize(alias_to_write.count > 0 ? kENDING_MSG : kBLANK_MSG, 32)