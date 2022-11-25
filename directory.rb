def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  students =  []
  name = gets.chomp
  puts "And which cohort is this student in?"
  cohort = gets.chomp
  while !(name.empty? && cohort.empty?)
    name = "Unknown name" if name.empty?
    cohort = :november if cohort.empty?
    students << {name: name, cohort: cohort.to_sym}
    puts "Now we have #{students.count} students."
    name = gets.chomp
    puts "And which cohort is this student in?"
    cohort = gets.chomp
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_by_cohort(students)
  students_by_cohort = Hash.new {|hash, key| hash[key] = []}
  students.each { |student|
  name = student[:name] ; cohort = student[:cohort]
  students_by_cohort[cohort] << name }
  students_by_cohort.each { |cohort, students|
    puts "In the #{cohort} cohort we have"
    students.each { |student| puts student }
    }
end

def print_footer(names)
  if names.count > 0
    puts "Overall, we have #{names.count} great students."
  else
    puts "We have no students!"
  end
end

students = input_students
print_header
print_by_cohort(students)
print_footer(students)