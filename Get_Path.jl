# This script interactively plot soil respiration data from STND files
# Menu: 
# 3 sites (Columbi/Fermilab/Temple),
# 6 years (2016-2021),
# 7 Rsoil sensors
# 3*6*7 = 126 options, each one plotting ~ 30,000 data point,  ~ 4 million data 

# Code written by Alexandre A. Renchon, started in April 2021

# This section gets path to raw data (.csv files) 


function rsoilpath()

# At the top level of Input, we get the path for the 3 sites
# Note that adding years will be easy, but will need some slight modification for now (but later can be automatised)
Sites = ["Col", "Fer", "Tem"]
n_S = length(Sites)
Years = string.(collect(2016:2020))
n_Y = length(Years)

Path_S = Dict(Sites .=> [readdir("Input", join = true)[i] for i = 1:n_S])

# Inside each site, there is one folder per year (2016-2021 as of April 2021)
# The line of code below gets the path for each site-year folder 
Path_S_Y = Dict(Sites .=> [readdir(Path_S[S], join = true) for S in Sites])

# There are more folders than just e.g. Fermilab 2021. So we need to know path in Path_S_Y one correspond to year y
Which_folder = Dict(Sites .=> [Dict(Years .=> [reduce(vcat, findall(occursin.(Y, Path_S_Y[S]).==1)) for Y in Years]) for S in Sites])

# Path to inside each folder Site/Year
Path_S_Y_i = Dict(Sites .=> [Dict(Years .=> [[] for i in 1:n_Y]) for i in 1:n_S])
[[[push!(Path_S_Y_i[S][Y], readdir(Path_S_Y[S][i], join = true)) for i in Which_folder[S][Y]] for Y in Years] for S in Sites]

# Path to subfolders containing .csv files, per sites and per year
Path_S_Y_sf = Dict(Sites .=> [Dict(Years .=> [[] for i in 1:n_Y]) for i in 1:n_S])
[[push!(Path_S_Y_sf[S][Y], readdir(Path_S_Y_i[S][Y][1][reduce(vcat, findall(occursin.("respiration", lowercase.(Path_S_Y_i[S][Y][1])).==1))], join=true)) for Y in Years] for S in Sites] # skip 2021 *

# remove non-directory files from Path_S_Y_sf
[[filter!(x -> isdir(x) == true, Path_S_Y_sf[S][Y][1]) for S in Sites] for Y in Years]

# Path to all .csv files, per sites and per year
Path_S_Y_full = Dict(Sites .=> [Dict(Years .=> [[] for i in 1:n_Y]) for i in 1:n_S])
[[[push!(Path_S_Y_full[S][Y], readdir(Path_S_Y_sf[S][Y][1][i], join=true)) for i = 1:length(Path_S_Y_sf[S][Y][1])] for S in Sites] for Y in Years]

# Remove non-csv files from Path_S_Y_full
[[filter!(x -> occursin(".csv", x) == true, Path_S_Y_full[S][Y][1]) for S in Sites] for Y in Years]

return Sites, Years, Path_S_Y_full

end
