def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty
  students = []
  # get the first names
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts 'The students of Villains Academy'
  puts '------------'
end

def print(students)
  if students.length >= 1
    print_header
    students.each do |student|
      puts "#{student[:name]} (#{student[:cohort]} cohort)"
    end
    print_footer(students)
  end
end
def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_students
print(students)
