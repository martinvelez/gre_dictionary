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
	
	#Assumes word does not already exist in dictionary
	def add(word)
		w = Element.new("word")
		w.add_element("name")
		w.elements["name"].text = word.name
		w.add_element("pos")
		w.elements["pos"].text = word.pos
		w.add_element("defn")
		w.elements["defn"].text = word.defn
		w.add_element("sentence")
		w.elements["sentence"].text = word.sentence
		@xmldoc.root.elements << w
		xmlfile = File.new(@dict_path, "w")
		xmlfile.puts @xmldoc
		true
	end
	
	def find(word)
		index = -1
		pos = 0
		for pos in 0..(size-1)
			if words[pos].name == word
				index = pos
				break
			end
		end
		index
	end
	
	def random_word
		words[rand(words.size)]
	end

	def size
		words.size
	end
	
	def get(index)
		words[index]
	end

end
