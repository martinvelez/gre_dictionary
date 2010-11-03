
#This class defines a word object as listed in Barron's Master Word List
class Word
	attr_accessor :name, :pos, :defn, :sentence

	def display
		puts "-" * 80
		puts "# " + @name
		puts "# " + @pos
		puts "# " + @defn
		puts "# " + @sentence
		puts "-" * 80
	end
	
end
