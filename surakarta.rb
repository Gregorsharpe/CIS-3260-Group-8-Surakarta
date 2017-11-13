#/usr/bin/ruby
class Space

	# constructor
   	def initialize(x,y, player_id)
      @x_pos = x
      @y_pos = y
      @owner = player_id
   	end

   	# changes its player_id to the enumerated value specified.
   	def change_ownership(new_id)
    	@owner = new_id
   	end

   	# returns an array containing its X and Y values.
   	def get_coordinates()
   		@position = [@x_pos,@y_pos]
   	return @position
   	end

   	# returns the Player_id specified by the owner variable.
	def occupied_by()
		return @player_id
	end
end

class Player

	# constructor
	def initialize(id, player_name)
		    @player_id = id
        @name = player_name
        @score =  0
    end

    # the player ends the game.
    def quit()

    end

    # a player request for a surrender.
    def forfeit(sarakarta_board)
    	print "Does the opposing player wish to accept the current player's forfeit? 1. Yes 2. No"
    	@answer = gets

    	if @answer == true
    		sarakarta.end_round(true)
    	else
    		print "The opposing player refuses to forfeit."
    	end
    end

    # the player performs a move.
    def select_move(sarakarta_board)

    	loop do
	    	print "What piece do you want to move, #{@name}? (x pos)"
	    	x = gets

	    	print "What piece do you want to move, #{@name}? (y pos)"
	    	y = gets

	    	src = Space.new(x, y, @player_id)


	    	print "Where do you want to move the piece to, #{@name}? (x pos)"
	    	x = gets

	    	print "What do you want to move the piece to, #{@name}? (y pos)"
	    	y = gets

	    	dest = Space.new(x, y, @player_id)

	    	valid = sarakarta_board.check_move(src, dest)

	    	break if valid != nil

    		sarakarta_board.perform_move(src, dest)
    		return true

    	end

    	return false

    end

    # the player performs a capture.
 	def select_capture()
 		loop do
	    	print "What piece do you want to use to make a capture, #{@name}? (x pos)"
	    	x = gets

	    	print "What piece do you want to make a capture, #{@name}? (y pos)"
	    	y = gets

	    	src = Space.new(x, y, @player_id)


	    	print "Where is the loop you wish to enter, #{@name}? (x pos)"
	    	x = gets

	    	print "Where is the loop you wish to enter, #{@name}? (y pos)"
	    	y = gets


	    	loop_pos = Space.new(x, y, :neither)


	    	valid = check_capture(src, loop_pos)

	    	break if valid != nil
    	end

    	return true

 	end

end

class View
    def initialize()
  		    @current_view = Array.new(36)
    end

    # Uses Board's get_spaces() to update @Current_view
    def update_spaces()

    end

    # Display state of the board.
    def display_board()
        print "+-----------+  +-----------+\n"
        print "|  +-----+  |  |  +-----+  |\n"
        print "|  |     |  |  |  |     |  |\n"
        print "|  |  #{@current_view[0]}--#{@current_view[1]}--#{@current_view[2]}--#{@current_view[3]}--#{@current_view[4]}--#{@current_view[5]}  |  |\n"
        print "|  |  |  |  |  |  |  |  |  |\n"
        print "|  +--#{@current_view[6]}--#{@current_view[7]}--#{@current_view[8]}--#{@current_view[9]}--#{@current_view[10]}--#{@current_view[11]}--+  |\n"
        print "|     |  |  |  |  |  |     |\n"
        print "+-----#{@current_view[12]}--#{@current_view[13]}--#{@current_view[14]}--#{@current_view[15]}--#{@current_view[16]}--#{@current_view[17]}-----+\n"
        print "      |  |  |  |  |  |\n"
        print "+-----#{@current_view[18]}--#{@current_view[19]}--#{@current_view[20]}--#{@current_view[21]}--#{@current_view[22]}--#{@current_view[23]}-----+\n"
        print "|     |  |  |  |  |  |     |\n"
        print "|  +--#{@current_view[24]}--#{@current_view[25]}--#{@current_view[26]}--#{@current_view[27]}--#{@current_view[28]}--#{@current_view[29]}--+  |\n"
        print "|  |  |  |  |  |  |  |  |  |\n"
        print "|  |  #{@current_view[30]}--#{@current_view[31]}--#{@current_view[32]}--#{@current_view[33]}--#{@current_view[34]}--#{@current_view[35]}  |  |\n"
        print "|  |     |  |  |  |     |  |\n"
        print "|  +-----+  |  |  +-----+  |\n"
        print "+-----------+  +-----------+\n"
    end
end

#testview = View.new()
#testview.display_board()

class Board

	#constructor
	def initialize()
		@spaces = Array.new(28)
		@loop_entrances = Array.new(8)

	end

	def check_Capture(src, entr)
		#Description: The board evaluates validity of a capture based on the Space src, and the Loop space entrance. Returns the captured space upon success and nil on failure.
		#check_Capture() checks the spaces in between the start Space and the loop entrance Loop_Space.
		#If there are pieces in between, returns nil.
		#check_Capture() then jumps to the Loop_Space connected to the entrance Loop_Space and gets the direction to continue checking all of the spaces belonging to that particular loop, changing the direction of the check, if it needs to check through another Loop_Space.
		#If no piece is encountered and check returns to its start Space, it is not a valid capture, check_Capture() returns nil.
		#If player's own piece in encountered, not a valid capture, check_Capture() returns nil.
		#If an opposing piece is encountered, capture was successful, check_Capture() returns coordinates of space being captured.


		#return Space
	end

	def check_Move(src, dest)
		valid = false

		#ensure destination space is empty
		if dest.occupied_by() == 0

			#check that the difference between the X and Y coordinates is 1 or -1,
			x_diff = src.get_coordinates[0] - dest.get_coordinates[0]
			y_diff = src.get_coordinates[1] - dest.get_coordinates[1]
			if x_diff == 1 || x_diff == -1
				if y_diff == 1 || y_diff == -1

					#success!
					valid = true
				else
					valid = false
				end
			else
				valid = false
			end
		else
			valid = false
		end

		if valid == true
			return dest
		else
			return nil
		end
	end

	def find_space(x, y)
		#Description: The Board will search through its list of Spaces and Loop_Spaces looking for a space with the coordinates given by the parameters. If it finds a space in this process, returns that space, otherwise returns nil.

		#return Space
	end

	def get_Spaces()
		#Returns information regarding every space on the board. Loop entrances inside the board, will become their space equivalents.
		all_spaces = new.Array.new(36)
		all_spaces = @spaces + @loop_entrances
		return  all_spaces
	end

	def perform_move(src,dest)

		dest.change_ownership(src.occupied_by())
		src.change_ownership(0)

	end
end

class Loop_Space < Space
	@next_space
	@direction

	# constructor
   	def initialize(x,y, player_id)
      @x_pos = x
      @y_pos = y
      @owner = player_id
   	end

	def get_Direction()
		return @direction
	end

	def get_next_Loop_Space()
		return @next_space
	end

	def set_next_Loop_Space(next_space)
		@next_space = next_space
	end
end
