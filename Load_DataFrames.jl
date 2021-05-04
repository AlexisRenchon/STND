# This script load DataFrames 

using DataFrames, Dates, CSV
include("Get_Path.jl")

function rsoildata()

Sites, n_S, Years, n_Y, rsoilp = rsoilpath(); # example rsoilp["Col"]["2017"][1] 

Data = Dict(Sites .=> [Dict(Years .=> [[] for i in 1:n_Y]) for i in 1:n_S])
datetime = Dict(Sites .=> [Dict(Years .=> [[] for i in 1:n_Y]) for i in 1:n_S])

Types = Dict(["Month", "Day", "Year", "Time", "Flux", "Temperature (C)"] .=> [Int64, Int64, Int64, Time, Float64, Float64])
readata(x) = (y = DataFrame(CSV.File(x, dateformat = "HH:MM:SS", types = Types, silencewarnings=true)); df = dropmissing(y); df = delete!(df, findall(df.Month .> 12)); df = delete!(df, findall(df.Month .< 1)); df = delete!(df, findall(df.Year .> 21)); df = delete!(df, findall(df.Day .< 1)); df = delete!(df, findall(df.Day .> 31))) 
readate(x) = Date.(x.Year.+2000, x.Month, x.Day) .+ x.Time

# one option would be Data["Col"]["2017"]["folder_i"]["file_j"]
# I could create 2 menu which give name of folder (menu 1) and name of files (menu 2)
# Other, better option is by plot (e.g. Data["Col"]["2017"]["A"] ) 

# troubleshooting:
# files IL-2D_FD_20160012_2020-05-15_12-57-32.csv 
# and IL-4A_FD_20160030_2020-05-15_12-29-35.csv needs to be deleted, not a data file
# in Fermilab STND Files/Fermilab 2020 Files/FRMI 2020 Soil Respiration/5-15-20
[[[[push!(Data[S][Y], readata(rsoilp[S][Y][j][i])) for i = 1:length(rsoilp[S][Y][j])] for j = 1:length(rsoilp[S][Y])] for S in Sites] for Y in Years];

# the code below is same as the line above, but can be useful for troubleshooting
# for Y in Years
#	for S in Sites
#		for j in 1:length(rsoilp[S][Y])
#			for i in 1:length(rsoilp[S][Y][j])
#				push!(Data[S][Y], readata(rsoilp[S][Y][j][i]));
#				println("Year ", Y, " Site ", S, " j ", j, " i ", i)
#			end
#		end
#	end
# end

[[[push!(datetime[S][Y], readate(Data[S][Y][i])) for i = 1:length(Data[S][Y])] for S in Sites] for Y in Years];

return Data, datetime, Sites, n_S, Years, n_Y

end

