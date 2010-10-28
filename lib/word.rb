
#This class defines a word object as listed in Barron's Master Word List
class Word
	attr_reader :word, :part_of_speech, :definition, :sentence
	
	def initialize(word, part_of_speech, definition)
		@word = word
		@part_of_speech = part_of_speech
		@definition = definition
	end
	
	def set_sentence(sentence)
		#escape input
	end
	
	def display
		#display word, part_of_speech, definition, and sentence
	end
	
end
