

# Numerical operations
1 + 1
2 * 2
2 / 4
4 - 1

dump(3)

dump(9223372036854775807+1)

dump(3.4)

dump(44 // 23)

dump("Helllo")


#d
"Hallo, " * " Julia" ^ 3

false

true

true

!true

!false


a = 3
dump(a)

a = 3.4
dump(a)

# Type assertion

a = 3.0
b = 4

c = a + b
c = a % b
dump(c)

staslijads = "Hi this is a string \n Test"

staslijads

multi = """
Hi
thi
is a
multi line
string
"""

print(staslijads)


println("Kickarz")
println("Nextrow")



grades = [3.0, 1.3, 4.0, 1.0, 1.0]
grades2 = [3.0, 2.0, 5.0, 1.3, 1.0]

grades[4]

using(Statistics)
mean(grades)
var(grades)

std(grades)

cor(grades, grades2)


friend_count = 10:5:200
length(friend_count)
friend_count[39]

large_range = 1:1000000000000

large_range * 2
large_range[1000000]


### do a mini simulation
using Statistics
function simulate(agent_count::Integer, steps::Integer)

    agents = [rand() for i in 1:agent_count]

    for step in 1:steps
        #do simulation step
        agents[1] = agents[1] + 1
    end
    mean(agents)
end

println("---------------------")
for agent_count in 1:5:100
    println(simulate(agent_count, 8))
end
