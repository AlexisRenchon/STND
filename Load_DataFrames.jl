# This script load DataFrames 

function rsoildata()

include("Get_Path.jl")
Sites, n_S, Years, n_Y, rsoilp = rsoilpath(); # example rsoil["Col"]["2017"][1] 

using DataFrames, Dates, CSV

Data = Dict(Sites .=> [Dict(Years .=> [[] for i in 1:n_Y]) for i in 1:n_S])
datetime = Dict(Sites .=> [Dict(Years .=> [[] for i in 1:n_Y]) for i in 1:n_S])

readata(x) = (y = CSV.read(x, DataFrame, dateformat = "HH:MM:SS", types=Dict("Time" => Time), silencewarnings=true); df = dropmissing(y)) 
readate(x) = Date.(x.Year.+2000, x.Month, x.Day) .+ x.Time

[[[push!(Data[S][Y], readata(rsoilp[S][Y][1][i])) for i = 1:length(rsoilp[S][Y][1])] for S in Sites] for Y in Years];

[[[push!(datetime[S][Y], readate(Data[S][Y][i])) for i = 1:length(Data[S][Y])] for S in Sites] for Y in Years]

return Data, datetime, Sites, n_S, Years, n_Y

end

