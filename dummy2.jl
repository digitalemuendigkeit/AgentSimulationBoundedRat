# Exercise


#TODO: Write a simulation with 500,1000,1500,2000 agents
#      that where in the beginning every agent has value 0
#      except agent[1] has value 1
#      in every simulation step, every agent gets the
#      mean value of its neighbors
#      agents[2] = (agents[1] + agents[3]) /2
#      important to note is that agent[1] has only one neigbors
#      agents[agent_count] also always stays 0
#       mean(agents)
#      steps 5:10 steps

using Statistics
using Distributed
 function simulate(agent_count :: Integer, step_count :: Integer)
    agents = zeros(agent_count)
    @debug "We are currently simulation $agent_count agents."
    agents[1] = 1
    for step in 1:step_count, current_agent in 2:(agent_count-1)
        agents[current_agent] = (agents[current_agent-1] + agents[current_agent+1]) /2
    end
    mean(agents)
end


println("-------")

using Distributed

@time Threads.@threads for agent_count in 500:500:2000
    for steps in [10000,50000,100000]
        result = simulate(agent_count, steps)
        @info "The result for $agent_count agents and $steps steps is $result it ran on $(Threads.threadid())."
    end
end
