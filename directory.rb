@students = [] # an array accessible to all methods

def print_menu
  puts "1. Input the students\n2. Show the students\n"\
  "3. Save the list to 'students.csv'\n4. Load the list from 'students.csv'\n"\
  "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
  when '1'
    input_students
  when '2'
    show_students
  when '3'
    save_students
  when '4'
    load_students
  when '9'
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def input_students
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

def show_students
  print_header
  print_students_list
  print_footer
end

def print_header
  puts 'The students of Villains Academy'
  puts '------------'
end

def add_students
  @students << {name: @name, cohort: :november}
end

def print_students_list
  if @students.length >= 1
    @students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = 'students.csv')
  file = File.open(filename, 'r')
  file.readlines.each do |line|
    @name, cohort = line.chomp.split(',')
      add_students
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil? # load default file if no filename given
    load_students
  else
    if File.exists?(filename) # if it exists
      load_students(filename)
      puts "Loaded #{@students.count} from #{filename}"
    else # if it doesn't exist
        puts "Sorry #{filename} doesn't exist"
        exit # quit the program
    end
  end
end

try_load_students
interactive_menu
