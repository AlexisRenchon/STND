# This script load DataFrames 

using DataFrames, Dates, CSV
include("Get_Path.jl")

function rsoildata()

Sites, n_S, Years, n_Y, rsoilp = rsoilpath(); # example rsoilp["Col"]["2017"][1] 

Data = Dict(Sites .=> [Dict(Years .=> [[] for i in 1:n_Y]) for i in 1:n_S])
datetime = Dict(Sites .=> [Dict(Years .=> [[] for i in 1:n_Y]) for i in 1:n_S])

readata(x) = (y = CSV.read(x, DataFrame, dateformat = "HH:MM:SS", types=Dict("Time" => Time), silencewarnings=true); df = dropmissing(y)) 
readate(x) = Date.(x.Year.+2000, x.Month, x.Day) .+ x.Time

# Line below needs to be fixed. 
# e.g. rsoilp["Col"]["2017"] has 8 folders, each folder has ~ 8 .csv files
# one option would be Data["Col"]["2017"]["folder_i"]["file_j"]
# I could create 2 menu which give name of folder (menu 1) and name of files (menu 2)
# Other, better option is by plot (e.g. Data["Col"]["2017"]["A"] ) 
[[[push!(Data[S][Y], readata(rsoilp[S][Y][1][i])) for i = 1:length(rsoilp[S][Y][1])] for S in Sites] for Y in Years];

[[[push!(datetime[S][Y], readate(Data[S][Y][i])) for i = 1:length(Data[S][Y])] for S in Sites] for Y in Years]

return Data, datetime, Sites, n_S, Years, n_Y

end

