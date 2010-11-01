require File.expand_path(File.join(File.dirname(__FILE__), "word.rb"))
require 'rexml/document'
include REXML

class Dictionary
	attr_reader :dict_path, :xmldoc, :words
	
	def initialize(dict_path)
		@dict_path = dict_path
		@xmldoc = Document.new(File.new(@dict_path))
		@words = Array.new
		@xmldoc.each_element('//word') do |w|
			word = Word.new
			word.name = w.elements["name"].text
			word.pos = w.elements["pos"].text
			word.defn = w.elements["defn"].text
			word.sentence = w.elements["sentence"].text
			words << word
		end
	end
	
	def add_word(word)
		#word must be a word object
		#check if word is already defined
	end
	
	def word(word)
		words.each do |w|
			if w.name == word
				w.display
				break
			end	
		end
	end
	
	def random_word
		words[rand(words.size)].display
	end

	def count
		words.size
	end

end
