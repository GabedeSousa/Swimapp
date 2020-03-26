class Swim 

def self.run
    puts "WELCOME TO iSwim"
    

    while true

        puts "\nType 'help' to see the list of commands. Type 'quit' to exit."
        print "Enter command: "
        input = gets.chomp

        break if input == "quit" || input == "exit"
        case input
        when "help"
          Swim.help
        when "list practices"
          Swim.list_practices
        when "list viewers"
          Swim.list_viewers
        when "list countries"
          Swim.list_countries
        when "list coaches"
            Swim.list_coaches 
        when "practice"
          Swim.practice
        when "viewer"
          binding.pry
          Swim.viewer
        when "self help"
            puts "Thank you for choosing iSwim <3" 
            puts "\n"
            10.times do
              puts "^o^" * 10
            end
        else
            puts "\n  invalid command, type 'help' to see the list of available commands"
        end
    end

end
    def self.greet
        puts "WELCOME TO iSwim"
    end

    def self.help
        puts "Help"
        puts "  help\t\t\t:show this help menu"
        puts "List"
        puts "  list practices\t:list all practice titles"
        puts "  list viewers\t\t:list names of all viewers"
        puts "  list countries\t:list names of all countries practices"
        puts "  list coaches\t\t:list names of all coaches"  
        puts "All Data"
        puts "  practice\t\t:go to menu for practice data"
        puts "  viewer\t\t:go to menu for viewer data"
        puts "Quit"
        puts "  quit\t\t\t:quit the app"
        puts "  exit\t\t\t:alias for quit"
    end


    def self.list_practices #debug
        Practice.all.each_with_index do |view,a|
            puts (a+1).to_s + ".\t#{view.practice}"
        end
    end

    def self.list_viewers
        Viewer.all.each_with_index do |view,a| 
            puts (a+1).to_s + ".\t#{view.name}" 
        end
    end

    def self.list_coaches
        Practice.all.each_with_index do |view,a|
            puts (a+1).to_s + ".\t#{view.coach}"
        end
    end

    def self.submenu_help(menu)
        puts "Help"
        puts "  help\t\t\t:practice this help menu"
        puts "List"
        puts "  list\t\t\t:list all #{menu}s"
        puts "Navigation"
        puts "  exit\t\t\t:exit to main menu"
        puts "  main\t\t\t:alias for exit"
    end

    def self.list_countries
        Practice.countries.each do |country| 
            puts country 
        end
    end

    def self.show_data(practice) #can't find top 3 why???
        puts "  title:\t\t#{practice.title}"
        puts "  practice: \t\t#{practice.practice}"
        puts "  country:\t\t#{practice.country}"
        puts "  total viewers:\t#{practice.num_ratings}"
        puts "  average rating:\t#{practice.average_rating}"
    end

    def self.coach_list(practice) ### not working
        
        loop do
          print "List the Coach for this practice? (y/n): "
          yn = gets.chomp
    
          case yn
          when 'y'
            puts practice.coach
            break
          when 'n'
            break
          end
        end
      end

    def self.list_practice_viewers(practice)
        loop do
          print "List viewers of this practice? (y/n): "
          yn = gets.chomp
    
          case yn
          when 'y'
            loop do
              print "List all viewers? (all): "

              all_viewers = gets.chomp
              case all_viewers
              when "all"
                practice.viewers.each do |a| 
                    puts a.name + ",  " + a.country 
                end
                break
            end
        end
        puts "\n"
     when 'n'
        break
    end
  end
 end

    def self.viewer_data(viewer)
     puts "  name:\t\t#{viewer.name}"
     puts "  country:\t#{viewer.country}"
     puts "  top practices:"
    if viewer.top_three.empty?
     puts "\tno practices rated".upcase
    else
     puts "\trating\tpractices".upcase
     viewer.top_three.each do |r| 
        puts "\t#{r.rating}\t#{r.practice.title}" ### bug bug bug
      end
    end
 end

 def self.list_viewed_practices?(viewer)
    loop do
      print "List all viewed practices? (y/n): "
      yn = gets.chomp

      case yn
      when 'y'
        viewer.practices.each do |s| 
            puts s.title 
        end
        break
      when 'n'
        break
      end
    end
  end

  def self.list_favorite_practices?(viewer)
    loop do
      print "List favorite practices? (y/n): "
      yn = gets.chomp

      case yn
      when 'y'
        loop do
          print "Which practice? (1,2,3): " ###HUGE BUG
          practice_number = gets.chomp.to_i

          if practice_number <=3 && practice_number > 0
            practice = viewer.top_three[practice_number].practice #o problema esta aqui do top 3
            Swim.show_data(practice) 
            Swim.coach_list(practice)
            puts "\n"
            break
          end
        end
      when 'n'
        break
      end
    end
  end

  def self.practice
    loop do
      puts "\nType 'list' to list all practices, or 'exit' to return to main menu"
      print "Enter list: "

      input = gets.chomp

      break if input == "exit" || input == "main"

      if input == "list" #needs debug
        Swim.list_practices
      elsif input == "help"
        Swim.submenu_help("practice")
      else
        begin
          id = input.to_i

          
        #   raise CLIError if id > Practice.count || id < 1
          id = Practice.all[id-1]
          Swim.show_data(practice)
          puts "\n"
          Swim.coach_list?(practice)
          Swim.list_practice_viewers(practice)
        #vai concertar algum erro
        # rescue CLIError => error
        #   puts error.message
        # end
      end
    end
  end

  def self.viewer
    loop do
      puts "\nType 'list' to list all viewers, type 'help' for help or 'exit' to return to main menu"
      print "Enter viewer ID: "

      input = gets.chomp

      break if input == "exit" || input == "main"

      if input == "list" ######### BUG BUG BUG BUG
        Swim.list_viewers
      elsif input == "help"
        Swim.submenu_help("viewer")
      else
        begin
          id = input.to_i
          # estranho mas acho que funciona
        #   raise CLIError if id > Viewer.count || id < 1
          viewer = Viewer.all[id-1] #i had viewer here!!!
          Swim.viewer_data(viewer)
          puts "\n"
          Swim.list_viewed_practices?(viewer)
          Swim.list_favorite_practices?(viewer)
        #pra arrumar erro
    #     rescue CLIError => error#
    #       puts error.message#
    #     end#
    #   end#
    end
  end
# end#
#   class CLIError #
#     def message#
#       "\n  invalid input, type 'help' to see a list of commands"#
#     end#
#   end#
end
end
end
end


