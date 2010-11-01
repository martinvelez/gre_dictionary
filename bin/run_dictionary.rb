#!/usr/bin/ruby -w

# == Synopsis 
#   Start a dictionary program which loads a dictionary of GRE 
#		words and allows the user to display a given or a random word
# 	and its synonyms/antonyms.
#
# == Examples
#		This command runs the dictionary
#   	run_dictionary.rb
#
# == Usage 
#   run_dictionary.rb [options] dictionary_file
#
#   For help use: run_engine.rb -h
#
# == Options
#   -h, --help          Displays help information
#		-V, --verbose				Run verbosely
#		-q, --quiet					Run quietly


require 'optparse'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "lib", "dictionary.rb"))

# This class define a ruby application which runs a named obfuscation engine.
class RunDictionary
	attr_reader :dict_path
	
	# Initialization of this application requires the command line arguments.
	def initialize(arguments)
		@arguments = arguments		
		# Set defaults
		@opt_parser = nil
		@options = {:help=>false,:verbose=>false,:quiet=>false}
		@dict_path = nil
	end

	# Parse options, check arguments, then process the command
	def run
		if parsed_options? && arguments_valid?
			output_options if @options[:verbose]
			output_arguments if @options[:verbose]
			process_arguments
			process_command
		else
			output_usage
		end
	end

	# Parse the options
	def parsed_options?
		#configure an OptionParser
		@opt_parser = OptionParser.new do |opts|		
			opts.banner = "Usage: #{__FILE__} [options] dictionary_file"
			opts.separator ""
			opts.separator "Specific options:"
			
			opts.on('-h', '--help', 'displays help information') do
				@options[:help] = true
				output_help
			end
			opts.on('-V', '--verbose', 'Run verbosely') { @options[:verbose] = true }
			opts.on('-q', '--quiet', 'Run quietly') { @options[:quiet] = true }
		end
	
		@opt_parser.parse!(@arguments) rescue return false
	
		process_options
		true
	end

	# True if required arguments were provided
	def arguments_valid?
		# TO DO - implement your real logic here
		#does engine exist		
		#does in_file exist
		return false if @arguments.length != 1		
		process_arguments
	end

	# Performs post-parse processing on options
	# For instance, some options may cancel others or have higher importance
	def process_options
		@options[:verbose] = false if @options[:quiet]
	end

	# Setup the arguments
	def process_arguments
		# If user provides the name of an engine which has not been registered,
		# they will get a runtime error.  No need to raise error.
		@dict_path = @arguments[0]		
		raise("File does not exist or is not readable") unless File.exist?(@dict_path) and File.readable?(@dict_path)
		return true
	end

	# Application logic
	def process_command				
		puts "Running Command:" if @options[:verbose]
		d = Dictionary.new(@dict_path)		
		puts "Dictionary has been loaded."
		puts "Total Words = #{d.count}"
		menu = "Choose option:
1. Get word
2. Get random word
3. Add word
4. Get word count"
		begin
			puts menu
			option = STDIN.gets.chomp.to_i
			puts "option selected = #{option}"
			case option
			when 1
				print "Enter word: "
				word = STDIN.gets.chomp
				d.word(word)		
			when 2
				puts "Random word:"
				d.random_word
			when 3
			when 4: puts "Total words = #{d.count}"
			end
		end while option != 99
		exit 0
	end

	def output_help
		puts @opt_parser
		exit 1
	end
	
	def output_usage
		puts @opt_parser
		exit 1
	end

	def output_options
		puts "Options:"
		@options.each do |name, value|
			puts "\t#{name} = #{value}"
		end
	end
	
	def output_arguments
		puts "Arguments:"
		puts "\tdict_path = #{@dict_path}"
	end
end
		
		
#Create and run the application
if __FILE__ == $0
	app = RunDictionary.new(ARGV)
	exit app.run
end
