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
  		    @current_view = ['1','1','1','1','1','1','1','1','1','1','1','1','0','0','0','0','0','0','0','0','0','0','0','0','2','2','2','2','2','2','2','2','2','2','2','2']
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
