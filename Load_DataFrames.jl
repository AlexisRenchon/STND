# This script load DataFrames 

include("Get_Path.jl")
Sites, Years, rsoil = rsoilpath(); # example rsoil["Col"]["2017"][1] 

using DataFrames, Dates, CSV

DATA_Col_2016 = []
datetime_Col_2016 = []
for i = 1:length(Data_Col_2016)
	try
	push!(DATA_Col_2016, CSV.read(Data_Col_2016[i], DataFrame; dateformat = "HH:MM:SS", 
	types = [Int64, Int64, Int64, Time, Float64, Float64, Float64, Float64, Float64, Float64])) #for i = 1:length(Data_Col_2016)];
	DATA_Col_2016[i] = dropmissing(DATA_Col_2016[i]); # get rid of broken rows
	push!(datetime_Col_2016, Date.(DATA_Col_2016[i].Year.+2000, DATA_Col_2016[i].Month, DATA_Col_2016[i].Day) .+ DATA_Col_2016[i].Time)
	catch
		nothing
	end
end

DATA_Col_2017 = []
datetime_Col_2017 = []
for i = 1:length(Data_Col_2017)
	try
	push!(DATA_Col_2017, CSV.read(Data_Col_2017[i], DataFrame; dateformat = "HH:MM:SS")) 
	#types = [Int64, Int64, Int64, Time, Float64, Float64, Float64, Float64, Float64, Float64])) #for i = 1:length(Data_Col_2016)];
	DATA_Col_2017[i] = dropmissing(DATA_Col_2017[i]); # get rid of broken rows
	push!(datetime_Col_2017, Date.(DATA_Col_2017[i].Year.+2000, DATA_Col_2017[i].Month, DATA_Col_2017[i].Day) .+ DATA_Col_2017[i].Time)
	catch
		nothing
	end
end


