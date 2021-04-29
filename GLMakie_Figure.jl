include("Load_DataFrames.jl")

# Open a soil resp file, plot time series

using GLMakie
using PlotUtils: optimize_ticks

fig = Figure()

data_opts = [DATA_Col_2016, DATA_Col_2018]

menu = Menu(fig, options = zip(["Columbia 2016", "Columbia 2018"], data_opts))

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

