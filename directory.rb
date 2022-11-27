@students = []

def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end

def clear_students
  @students = []
end

def add_student(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def ask_for_student_info
  puts "What is the name of the student to be added?"
  name = STDIN.gets.chomp
  puts "And which cohort is this student in?"
  cohort = STDIN.gets.chomp
  return name, cohort
end

def input_students
  puts "Entering input mode. To exit, just press return twice."
  name, cohort = ask_for_student_info
  while !(name.empty? && cohort.empty?)
    name = "Unknown name" if name.empty?
    cohort = :november if cohort.empty?
    add_student(name, cohort)
    puts "#{name} of the #{cohort} cohort has been added to the student list!"
    name, cohort = ask_for_student_info
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list
  students_by_cohort = Hash.new {|hash, key| hash[key] = []}
  @students.each do |student|
    name = student[:name] ; cohort = student[:cohort]
    students_by_cohort[cohort] << name
  end
  students_by_cohort.each do |cohort, some_students|
    puts "In the #{cohort} cohort we have"
    some_students.each { |student| puts student }
  end
end

def print_footer
  case @students.count
    when 0
      puts "We have no students!\n\n"
    when 1
      puts "Overall, we have 1 great student\n\n"
    else
      puts "Overall, we have #{@students.count} great students\n\n"
  end
end

def show_students
  print_header
  print_students_list
  print_footer
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save students to students.csv"
  puts "4. Load students from students.csv"
  puts "5. Remove all recorded students"
  puts "9. Exit"
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts(csv_line)
  end
  file.close
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    add_student(name, cohort)
  end
  file.close
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "5"
      clear_students
    when "9"
      exit
    else
      puts "Invalid input"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu