
## Forest Fire Simulation
using Random
using PyPlot
pygui(true)
​
using Distributed
​
function showforest(forest)
    PyPlot.imshow(forest)
end
​
# 0 no tree
# 1 tree
# 2 burning
# 3 burnt
​
​
​
# test if something is burning
function stillburning(forest)
    for position in forest
        if position == 2
            return true
        end
    end
    return false
end
​
​
function simulation_step(forest, forest_size)
    temp_forest = copy(forest)
    for x = 1:forest_size, y = 1:forest_size
        if forest[x, y] == 2
            temp_forest[x, y] = 3
            for neighbor in [(-1, 0), (0, -1), (1, 0), (0, 1)]
                position = (x, y) .+ neighbor
                if all(position .> (0, 0)) &&
                   all(position .<= (forest_size, forest_size))
                    xp, yp = position
                    if forest[xp, yp] == 1
                        # put on fire
                        temp_forest[xp, yp] = 2
                    end
​
                end
​
            end
​
        end
    end
    return temp_forest
end
​
​
​
​
​
function report_burnt(forest)
    count_burnt = 0
    count_tree = 0
    for position in forest
        if position == 3
            count_burnt = count_burnt + 1
        end
        if position == 1
            count_tree = count_tree + 1
        end
    end
​
    return count_burnt / (count_burnt + count_tree)
end
​
​
​
function simulation(density = 0.57, forest_size = 251)
    forest = [zero(Int8) for x = 1:forest_size, y = 1:forest_size]
​
    for x = 1:forest_size, y = 1:forest_size
        if rand() < density
            forest[x, y] = 1
        end
    end
​
    for y = 1:forest_size
        forest[y, 1] = 2
    end
​
    while stillburning(forest)
        forest = simulation_step(forest, forest_size)
    end
    print(Threads.threadid())
    print(" ")
    println(report_burnt(forest))
​
    forest
end
​
​
Random.seed!(0)
​
@time for i in 1:100
    results = simulation(0.57, 500)
    #showforest(results)
end
​
Threads.nthreads()
