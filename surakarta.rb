#/usr/bin/ruby




class Space

	# constructor
   	def initialize(x,y, player_id)
      @x_pos = x
      @y_pos = y
      @owner = player_id
   	end

    def owner
      @owner
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
    def update_spaces(source_board)
        current_view
    end

    # Display state of the board.
    def display_board()
        print "+-----------+  +-----------+\n"
        print "|  +-----+  |  |  +-----+  |\n"
        print "|  |     |  |  |  |     |  |\n"
        print "|  |  #{@current_view[0].owner}--#{@current_view[1].owner}--#{@current_view[2].owner}--#{@current_view[3].owner}--#{@current_view[4].owner}--#{@current_view[5].owner}  |  |\n"
        print "|  |  |  |  |  |  |  |  |  |\n"
        print "|  +--#{@current_view[6].owner}--#{@current_view[7].owner}--#{@current_view[8].owner}--#{@current_view[9].owner}--#{@current_view[10].owner}--#{@current_view[11].owner}--+  |\n"
        print "|     |  |  |  |  |  |     |\n"
        print "+-----#{@current_view[12].owner}--#{@current_view[13].owner}--#{@current_view[14].owner}--#{@current_view[15].owner}--#{@current_view[16].owner}--#{@current_view[17].owner}-----+\n"
        print "      |  |  |  |  |  |\n"
        print "+-----#{@current_view[18].owner}--#{@current_view[19].owner}--#{@current_view[20].owner}--#{@current_view[21].owner}--#{@current_view[22].owner}--#{@current_view[23].owner}-----+\n"
        print "|     |  |  |  |  |  |     |\n"
        print "|  +--#{@current_view[24].owner}--#{@current_view[25].owner}--#{@current_view[26].owner}--#{@current_view[27].owner}--#{@current_view[28].owner}--#{@current_view[29].owner}--+  |\n"
        print "|  |  |  |  |  |  |  |  |  |\n"
        print "|  |  #{@current_view[30].owner}--#{@current_view[31].owner}--#{@current_view[32].owner}--#{@current_view[33].owner}--#{@current_view[34].owner}--#{@current_view[35].owner}  |  |\n"
        print "|  |     |  |  |  |     |  |\n"
        print "|  +-----+  |  |  +-----+  |\n"
        print "+-----------+  +-----------+\n"
    end
end



testview = View.new()
testview.display_board()

class Board

	#constructor
	def initialize()
		@spaces = Array.new(20)
		@loop_entrances = Array.new(16)

		for i in 0..5
			for j in 0..5
				if i < 2
					id = :player1
				else
					if i < 4
						id = :neither
					else
						id = :player2
					end
				end


				if i = 0 && j > 0 && j < 5
					s = Loop_Space.new(i,j,id)
					@loop_entrances << s
				else
					if j = 0 && i > 0 && i < 5
						s = Loop_Space.new(i,j,id)
						@loop_entrances << s
					else
						if i = 5 && j > 0 && j < 5
							s = Loop_Space.new(i,j,id)
							@loop_entrances << s
						else
							if j = 5 && i > 0 && i < 5
								s = Loop_Space.new(i,j,id)
								@loop_entrances << s
							else
								s = Space.new(i,j,id)
								@spaces << s
							end
						end
					end
				end
			end
		end

		@loop_entrances[0].set_next_Loop_Space(@loop_entrances[4])
		@loop_entrances[1].set_next_Loop_Space(@loop_entrances[6])
		@loop_entrances[2].set_next_Loop_Space(@loop_entrances[7])
		@loop_entrances[3].set_next_Loop_Space(@loop_entrances[5])
		@loop_entrances[4].set_next_Loop_Space(@loop_entrances[0])
		@loop_entrances[5].set_next_Loop_Space(@loop_entrances[3])
		@loop_entrances[6].set_next_Loop_Space(@loop_entrances[1])
		@loop_entrances[7].set_next_Loop_Space(@loop_entrances[2])
		@loop_entrances[8].set_next_Loop_Space(@loop_entrances[13])
		@loop_entrances[9].set_next_Loop_Space(@loop_entrances[14])
		@loop_entrances[10].set_next_Loop_Space(@loop_entrances[12])
		@loop_entrances[11].set_next_Loop_Space(@loop_entrances[15])
		@loop_entrances[12].set_next_Loop_Space(@loop_entrances[10])
		@loop_entrances[13].set_next_Loop_Space(@loop_entrances[8])
		@loop_entrances[14].set_next_Loop_Space(@loop_entrances[9])
		@loop_entrances[15].set_next_Loop_Space(@loop_entrances[11])

		for i in 0..3
			@loop_entrances[i].set_exit_direction(:down)
		end
		@loop_entrances[4].set_exit_direction(:right)
		@loop_entrances[5].set_exit_direction(:left)
		@loop_entrances[6].set_exit_direction(:right)
		@loop_entrances[7].set_exit_direction(:left)
		@loop_entrances[8].set_exit_direction(:right)
		@loop_entrances[9].set_exit_direction(:left)
		@loop_entrances[10].set_exit_direction(:right)
		@loop_entrances[11].set_exit_direction(:left)
		for i in 12..15
			@loop_entrances[i].set_exit_direction(:up)
		end

	end

	def check_Capture(src, entr)

		if src.get_coordinates[0] == entr.get_coordinates[0]
			x_eq = true
		else
			x_eq = false
		end
		if src.get_coordinates[1] == entr.get_coordinates[1]
			y_eq = true
		else
			y_eq = false
		end

		if x_eq == false && y_eq == false
			return nil
		else
			if x_eq == true
				#check along x axis
				for i in src.get_coordinates[1]..entr.get_coordinates[1]
					if find_space(src.get_coordinates[0], i).occupied_by != :neither
						return nil
					end
				end
			else
				#check along y axis
				for i in src.get_coordinates[0]..entr.get_coordinates[0]
					if find_space(i, src.get_coordinates[1]).occupied_by != :neither
						return nil
					end
				end
			end
		end


		dir = entr.get_next_Loop_Space().get_Direction()

		lo_op =  true

		while lo_op == true
			if dir == :down
				for i in 1 .. 5
					if find_space(i,entr.get_next_Loop_Space().get_coordinates[1]).occupied_by == src.occupied_by
						return nil
					else
						if find_space(i,entr.get_next_Loop_Space().get_coordinates[1]).occupied_by != :neither
							return find_space(i,entr.get_next_Loop_Space().get_coordinates[1])
						end
					end
				end
				dir = find_space(5,entr.get_next_Loop_Space().get_coordinates[1]).get_next_Loop_Space().get_Direction()
			else
				if dir == :up
					i = 5
					while i >= 0
						if find_space(i,entr.get_next_Loop_Space().get_coordinates[1]).occupied_by == src.occupied_by
							return nil
						else
							if find_space(i,entr.get_next_Loop_Space().get_coordinates[1]).occupied_by != :neither
								return find_space(i,entr.get_next_Loop_Space().get_coordinates[1])
							end
						end

						i = i - 1
					end
					dir = find_space(0,entr.get_next_Loop_Space().get_coordinates[1]).get_next_Loop_Space().get_Direction()
				else
					if dir == :left
					i = 5
					while i >= 0
						if find_space(entr.get_next_Loop_Space().get_coordinates[0], i).occupied_by == src.occupied_by
							return nil
						else
							if find_space(entr.get_next_Loop_Space().get_coordinates[0], i).occupied_by != :neither
								return find_space(entr.get_next_Loop_Space().get_coordinates[0], i)
							end
						end
						i = i - 1
					end
					dir = find_space(entr.get_next_Loop_Space().get_coordinates[0],0).get_next_Loop_Space().get_Direction()
					else
						if dir == :right
							for i in 1 .. 5
								if find_space(entr.get_next_Loop_Space().get_coordinates[0], i).occupied_by == src.occupied_by
									return nil
								else
									if find_space(entr.get_next_Loop_Space().get_coordinates[0], i).occupied_by != :neither
										return find_space(entr.get_next_Loop_Space().get_coordinates[0], i)
									end
								end
							end
							dir = find_space(entr.get_next_Loop_Space().get_coordinates[0],5).get_next_Loop_Space().get_Direction()
						end
					end
				end
			end
		end
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
		all_spaces = Array.new(36)
		all_spaces = @spaces + @loop_entrances

		for i in 0..35
			x1 = all_spaces[i].get_coordinates[0]
			y1 = all_spaces[i].get_coordinates[1]

			if x1 == x && y1 == y
				return all_spaces[i]
			end
		end

		return nil
	end

	def get_spaces()
		#Returns information regarding every space on the board. Loop entrances inside the board, will become their space equivalents.
		all_spaces = new.Array.new(36)
		all_spaces = @spaces + @loop_entrances
		return all_spaces
	end

	def perform_move(src,dest)

		dest.change_ownership(src.occupied_by())
		src.change_ownership(:neither)

	end
end

class Loop_Space < Space
	@next_space
	@direction

	#constructor
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

	def set_exit_direction(dir)
		@direction = dir
	end
end
