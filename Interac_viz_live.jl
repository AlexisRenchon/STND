# This script interactively plot soil respiration data from STND files
# Menu: 
# 3 sites (Columbi/Fermilab/Temple),
# 6 years (2016-2021),
# 7 Rsoil sensors
# 3*6*7 = 126 options, each one plotting ~ 30,000 data point,  ~ 4 million data 

# Code written by Alexandre A. Renchon, started in April 2021

# This section gets path to raw data (.csv files) 

# At the top level of Input, we get the path for the 3 sites
Path_S = readdir("Input")

# Inside each site, there is one folder per year (2016-2021 as of April 2021)
# The line of code below gets the path for each site-year folder 
Sites = ["Col", "Fer", "Tem"]
Path_S_Y = Dict(Sites .=> [readdir(joinpath("Input", Inputs_f[i]), join = true) for i in 1:3])

# There are more folders than just e.g. Fermilab 2021. So we need to know path in Path_S_Y one correspond to year y
Which_year = Dict(Sites .=> [reduce(vcat, [findall(occursin.(i, Path_S_Y[S]).==1) for i in string.(collect(2016:2021))]) for S in Sites])

# Path to inside each folder Site/Year
Path_S_Y_i = Dict(Sites .=> [[] for i in 1:3])
[[push!(Path_S_Y_i[S], readdir(Path_S_Y[S][i], join = true)) for i in Which_year[S]] for S in Sites]



# WIP


# Path to .csv files, per sites and per year
Data_Col_f = []
[push!(Data_Col_f, readdir(Inputs_Col_y[i][reduce(vcat, findall(occursin.("respiration", lowercase.(Inputs_Col_y[i])).==1))], join=true)) for i in 1:5] # This gives path to all subfolder containing rsoil .csv files, 2016 to 2020, skip 2021 for now
n_D = [length(Data_Col_f[i]) for i = 1:5]

Data_Fer_f = []
[push!(Data_Fer_f, readdir(Inputs_Fer_y[i][reduce(vcat, findall(occursin.("respiration", lowercase.(Inputs_Fer_y[i])).==1))], join=true)) for i in 1:5] # This gives path to all subfolder containing rsoil .csv files, 2016 to 2020, skip 2021 for now
n_D = [length(Data_Fer_f[i]) for i = 1:5]

Data_Tem_f = []
[push!(Data_Tem_f, readdir(Inputs_Tem_y[i][reduce(vcat, findall(occursin.("respiration", lowercase.(Inputs_Tem_y[i])).==1))], join=true)) for i in 1:5] # This gives path to all subfolder containing rsoil .csv files, 2016 to 2020, skip 2021 for now
n_D = [length(Data_Tem_f[i]) for i = 1:5]


Data_Col_2016 = [] # Need to give only .csv files path
[push!(Data_Col_2016, readdir(Data_Col_f[1][i], join=true)) for i = 1:length(Data_Col_f[1])] # this gives path to all .csv files
Data_Col_2016 = reduce(vcat, Data_Col_2016)

Data_Col_2017 = [] # Need to give only .csv files path
[push!(Data_Col_2017, readdir(Data_Col_f[2][i], join=true)) for i = 1:length(Data_Col_f[2])] # this gives path to all .csv files
Data_Col_2017 = reduce(vcat, Data_Col_2017)

Data_Col_2018 = [] # Need to give only .csv files path
[push!(Data_Col_2018, readdir(Data_Col_f[3][i], join=true)) for i = 1:length(Data_Col_f[2])] # this gives path to all .csv files
Data_Col_2018 = reduce(vcat, Data_Col_2018)

Data_Col_2019 = [] # Need to give only .csv files path
[push!(Data_Col_2019, readdir(Data_Col_f[3][i], join=true)) for i = 1:length(Data_Col_f[2])] # this gives path to all .csv files
Data_Col_2019 = reduce(vcat, Data_Col_2019)

Data_Col_2020 = [] # Need to give only .csv files path
[push!(Data_Col_2020, readdir(Data_Col_f[3][i], join=true)) for i = 1:length(Data_Col_f[2])] # this gives path to all .csv files
Data_Col_2020 = reduce(vcat, Data_Col_2020)

Data_Fer_2016 = [] # Need to give only .csv files path
[push!(Data_Fer_2016, readdir(Data_Fer_f[1][i], join=true)) for i = 1:length(Data_Fer_f[1])] # this gives path to all .csv files
Data_Fer_2016 = reduce(vcat, Data_Fer_2016)

Data_Fer_2017 = [] # Need to give only .csv files path
[push!(Data_Fer_2017, readdir(Data_Fer_f[2][i], join=true)) for i = 1:length(Data_Fer_f[2])] # this gives path to all .csv files
Data_Fer_2017 = reduce(vcat, Data_Fer_2017)

Data_Fer_2018 = [] # Need to give only .csv files path
[push!(Data_Fer_2018, readdir(Data_Fer_f[3][i], join=true)) for i = 1:length(Data_Fer_f[2])] # this gives path to all .csv files
Data_Fer_2018 = reduce(vcat, Data_Fer_2018)

Data_Fer_2019 = [] # Need to give only .csv files path
[push!(Data_Fer_2019, readdir(Data_Fer_f[3][i], join=true)) for i = 1:length(Data_Fer_f[2])] # this gives path to all .csv files
Data_Fer_2019 = reduce(vcat, Data_Fer_2019)

Data_Fer_2020 = [] # Need to give only .csv files path
[push!(Data_Fer_2020, readdir(Data_Fer_f[3][i], join=true)) for i = 1:length(Data_Fer_f[2])] # this gives path to all .csv files
Data_Fer_2020 = reduce(vcat, Data_Fer_2020)

Data_Tem_2016 = [] # Need to give only .csv files path
[push!(Data_Tem_2016, readdir(Data_Tem_f[1][i], join=true)) for i = 1:length(Data_Tem_f[1])] # this gives path to all .csv files
Data_Tem_2016 = reduce(vcat, Data_Tem_2016)

Data_Tem_2017 = [] # Need to give only .csv files path
[push!(Data_Tem_2017, readdir(Data_Tem_f[2][i], join=true)) for i = 1:length(Data_Tem_f[2])] # this gives path to all .csv files
Data_Tem_2017 = reduce(vcat, Data_Tem_2017)

Data_Tem_2018 = [] # Need to give only .csv files path
[push!(Data_Tem_2018, readdir(Data_Tem_f[3][i], join=true)) for i = 1:length(Data_Tem_f[2])] # this gives path to all .csv files
Data_Tem_2018 = reduce(vcat, Data_Tem_2018)

Data_Tem_2019 = [] # Need to give only .csv files path
[push!(Data_Tem_2019, readdir(Data_Tem_f[3][i], join=true)) for i = 1:length(Data_Tem_f[2])] # this gives path to all .csv files
Data_Tem_2019 = reduce(vcat, Data_Tem_2019)

Data_Tem_2020 = [] # Need to give only .csv files path
[push!(Data_Tem_2020, readdir(Data_Tem_f[3][i], join=true)) for i = 1:length(Data_Tem_f[2])] # this gives path to all .csv files
Data_Tem_2020 = reduce(vcat, Data_Tem_2020)

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







# Open a soil resp file, plot time series

using GLMakie
using PlotUtils: optimize_ticks

fig = Figure()

data_opts = [DATA_Col_2016, DATA_Col_2018]

#data_opts = [Data_Col_2016, Data_Col_2017, Data_Col_2018, Data_Col_2019, Data_Col_2020,
#	     Data_Fer_2016, Data_Fer_2017, Data_Fer_2018, Data_Fer_2019, Data_Fer_2020,
#	     Data_Tem_2016, Data_Tem_2017, Data_Tem_2018, Data_Tem_2019, Data_Tem_2020]

menu = Menu(fig, options = zip(["Columbia 2016", "Columbia 2018"], data_opts))

#menu = Menu(fig, options = zip(
#	    ["Data_Col_2016", "Data_Col_2017", "Data_Col_2018", "Data_Col_2019", "Data_Col_2020",
#	     "Data_Fer_2016", "Data_Fer_2017", "Data_Fer_2018", "Data_Fer_2019", "Data_Fer_2020",
#	     "Data_Tem_2016", "Data_Tem_2017", "Data_Tem_2018", "Data_Tem_2019", "Data_Tem_2020"],
#	     data_opts))

fig[1, 1] = vgrid!(
    Label(fig, "Site-Year", width = nothing),
    menu,
    tellheight = false, width = 200)

ax1 = Axis(fig[1,2])

siteyear = Node{Any}(data_opts[1])
xdata = @lift($siteyear[1].Flux)

scatter!(ax1, 
	 #lift(X-> X[1].Flux, menu.selection),
	 xdata,
	strokewidth = 0, markersize = 5,
	color = RGBf0(reduce(vcat,rand(1)),reduce(vcat,rand(1)),reduce(vcat,rand(1))))

on(menu.selection) do s
	siteyear[] = s
end

fig


#for i = 1:lift(X->length(X), menu.selection)
	#try
#	DATA = CSV.read(lift(X->X[i], menu.selection), DataFrame; dateformat = "HH:MM:SS", 
#	types = [Int64, Int64, Int64, Time, Float64, Float64, Float64, Float64, Float64, Float64]) #for i = 1:length(Data_Col_2016)];
#	DATA = dropmissing!(DATA); # get rid of broken rows
#	datetime = Date.(DATA.Year.+2000, DATA.Month, DATA.Day) .+ DATA.Time
#	scatter!(ax1, datetime2rata.(datetime), 
#		 lift(X-> CSV.read(X[i], DataFrame,menu.selection).Flux,
#		      strokewidth = 0, markersize = 5, color = RGBf0(reduce(vcat,rand(1)),reduce(vcat,rand(1)),reduce(vcat,rand(1))))
	#catch
	#	nothing
	#end
#end

#dates = DateTime(2016, 01, 01, 00, 30, 00) : Minute(30) : DateTime(2021, 01, 01, 00, 00, 00);
#dateticks = optimize_ticks(dates[1], dates[end])[1]
#ax1.xticks[] = (datetime2rata.(dateticks) , Dates.format.(dateticks, "mm/dd/yyyy"));
#xlims!(ax1, (datetime2rata(dates[1]), datetime2rata(dates[end])));
#menu.is_open = true

#on(menu.selection) do s
#	data_opts = s
#end

# plt.axis.xtickformat = xs -> Dates.format.(datetime[convert.(Int, xs)], "m/d/Y")





