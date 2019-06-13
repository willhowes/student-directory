@students = [] # an array accessible to all methods

def print_menu
  puts "1. Input the students\n2. Print the student list\n"\
  "3. Save the list to 'students.csv'\n4. Load the list from 'students.csv'\n"\
  "9. Exit"
end

def interactive_menu_loop
  loop do
    print_menu
    process_user_selection(STDIN.gets.chomp)
  end
end

def process_user_selection(selection)
  case selection
  when '1'
    input_students
  when '2'
    print_student_list
  when '3'
    save_students
  when '4'
    load_students
  when '9'
    puts "\nEXITING GAME..."
    sleep 1
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "\n ---INPUT STUDENTS SELECTED---"
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # get the first names
  @name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !@name.empty? do
    # add the student hash to the array
    add_students
    puts "Now we have #{@students.count} students"
    # get another name from the user
    @name = STDIN.gets.chomp
  end
end

def print_student_list
  puts "\n ---PRINT STUDENT LIST SELECTED---"
  puts "\nThe students of Villains Academy \n------------"
  if @students.length >= 1
    @students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
  puts "\nOverall, we have #{@students.count} great students\n------------\n\n"
  sleep 2.5
end

def add_students
  @students << {name: @name, cohort: :november}
end

def save_students
  puts "\n---SAVE STUDENTS SELECTED---"
  puts "Please confirm the file name to save to: "
  user_filename = gets.chomp
  user_filename = 'students.csv' if user_filename == ""
  file = File.open(user_filename, "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]].join(",")
    file.puts student_data
  end
  puts "\nList of students saved to #{user_filename}...\n\n"
  file.close
end

def load_students(filename = 'students.csv')
  puts "\n---LOAD STUDENTS SELECTED---"
  file = File.open(filename, 'r')
  file.readlines.each do |line|
    @name, cohort = line.chomp.split(',')
    add_students
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return load_students if filename.nil? # load default file if no filename given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry #{filename} doesn't exist"
    exit # quit the program
  end
end

try_load_students
interactive_menu_loop
