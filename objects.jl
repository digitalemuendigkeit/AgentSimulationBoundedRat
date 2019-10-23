using PyPlot
#pygui(true)
using Statistics
using Random

mutable struct Agent
    opinion :: AbstractFloat

    function Agent()
        new(rand()*2 -1 )
    end
end





function talkto!(target::Agent, source::Agent, bounded_rat)
    if abs(target.opinion - source.opinion) < bounded_rat
        target.opinion = (target.opinion + source.opinion)/2
    end
end



function simulation(agent_count, steps, bounded_rat = 0.2)
    agents = [Agent() for x in 1:agent_count]

    PyPlot.clf()
    hist([a.opinion for a in agents])
    for step = 1:steps


        @inbounds source = agents[rand(1:agent_count)]
        @inbounds target = agents[rand(1:agent_count)]
        talkto!(target, source, bounded_rat)
    end



    hist([a.opinion for a in agents])
    display(gcf())
    (mean([a.opinion for a in agents]), std([a.opinion for a in agents]))
end


@time res = simulation(100000, 10000000, 0.4)
println(res)
