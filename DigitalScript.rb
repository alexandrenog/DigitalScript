require 'chunky_png'

$lines=[]
def logic source
	$lines=source.split("\n").map{|e| e.chomp.downcase}.select!{|e| !e.eql?("")}
end
def get_signals text, time
	inputs = text.select{|l| /input /.match l}.map{|l| l.slice((l.index(' ')+1)...l.size)}
	vectors = text.select{|l| /input_/.match l}.map{|l| l.slice((l.index(' ')+1)...l.size)}
	input_objs=[]
	inputs.each do |inp|
		name, period, dutyc = inp.split(" ") # HOW PERIODIC 2-state INPUTS ARE READ
		period, dutyc = period.to_i, dutyc.to_i
		input_objs<<{"name"=>name,"period"=>period,"dutyc"=>dutyc,"signal"=>Array.new(period){|i| i>=period-dutyc}}		
	end
	vectors.each do |vec| # HOW PRE-DETERMINED INPUTS_ ARE READ
		name, *values = vec.split(" ")
		period, values = values.size, values.map{|v| v.to_i == 1}
		input_objs<<{"name"=>name,"period"=>period,"signal"=>values}	
	end
	total_period=input_objs.map{|e| e["period"]}.reduce(1, :lcm)
	if time != nil and time != 0
		total_period = time
	end
	signals=[]
	input_objs.map{|inp|
		first_signal_part=inp["signal"]*(total_period/inp["period"])
		complete_signal = first_signal_part.concat(inp["signal"].slice(0...(total_period%inp["period"])))
		signals<<{"name"=>inp["name"],"signal"=>complete_signal}
	}
	return [signals,total_period]
end
def get_operation op_text
	case op_text
	when "not"
	  return proc{|*vars| !vars[0]}
	when "and"
	  return proc{|*vars| vars.inject(true){|acc,el| acc && el}}
	when "or"
	  return proc{|*vars| vars.inject(false){|acc,el| acc || el}}
	when "xor"
	  return proc{|*vars| vars.inject(false){|acc,el| acc ^ el}}
	when "nand"
	  return proc{|*vars| ! vars.inject(true){|acc,el| acc && el}}
	when "nor"
	  return proc{|*vars| ! vars.inject(false){|acc,el| acc || el}}
	else
	  return proc{ 0}
	end
end

def get_expressions text
	vars = text.select{|l| /var/.match l}.map{|l| l.slice((l.index(' ')+1)...l.size)}
	vars_objs=[]
	vars.each do |var|
		name, operation, *input_vars = var.split(" ")
		#p input_vars
		operation=get_operation(operation)
		vars_objs<<{"name"=>name,"operation"=>operation,"input_vars"=>input_vars, "initial_value"=>0, "signal"=>[]}		
	end
	return vars_objs
end
def get_time text
	time_text = text.select{|l| /time/.match l}
	if time_text.is_a?(Array) and time_text.size==0
		return nil
	elsif  time_text.is_a?(Array) and time_text.size>=1
		return time_text[0].slice((time_text[0].index(' ')+1)...time_text[0].size).to_i
	elsif time_text.is_a?(String)
		return time_text.slice((time_text.index(' ')+1)...time_text.size).to_i
	end
end
def get_plots text
	plot_text = text.select{|l| /plot/.match l}
	plots = plot_text.inject(""){|acc,el|
		acc.concat(el.slice((el.index(' ')+1)...el.size).chomp)}
	plots=plots.split(' ')
end
def print_inputs inputs, clean_console=false
	system "cls" if clean_console
	inputs[0].each{|inp|
		print "#{inp["name"]}: "
		p inp["signal"].map{|v|(v)?1:0}
	}
end
def print_expressions expressions, clean_console=false
	system "cls" if clean_console
	expressions.each{|exp|
		print "#{exp["name"]}: "
		p exp["signal"].map{|v|(v)?1:0}
	}
end
def process_expressions signals, expressions, total_time
	total_time.times do |tick|
	 	expressions.each do |exp|
	 		vars = []
	 		exp["input_vars"].each{|var_name|
	 			sig=signals[0].select{|e| e["name"].eql?var_name}
	 			if(sig[0]!=nil)
	 				vars<<sig[0]["signal"][tick] 
	 			else
	 				exp_var=expressions.select{|e| e["name"].eql?var_name}[0]
	 				if(tick==0 and expressions.index(exp_var)>=expressions.index(exp))
	 					vars<<exp_var["initial_value"]
	 				else
	 					tck = (expressions.index(exp_var)<expressions.index(exp))?(tick):(tick-1)
	 					vars<<exp_var["signal"][tck]
	 				end
	 			end
	 		}
	 		value = exp["operation"].call(*vars)
	 		exp["signal"]<<value
	 	end
	 end
end
def create_image inputs, expressions, time, plots, file_name="image"
	if !plots.empty?
		inputs[0].select!{|input| plots.include? input["name"]}
		expressions.select!{|exp| plots.include? exp["name"]}
	end
	width = 1620
	step=1600.0/time
	gap = 12
	tile_height=gap+(step*2).to_i
	height = gap+tile_height*(inputs[0].size+expressions.size)
	if(height>width)
		tile_height=gap+step.to_i
		height = gap+tile_height*(inputs[0].size+expressions.size)
	end
	png = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color.from_hex('#00995c'))
	red = ChunkyPNG::Color.from_hex('#df2f2f')
	blue = ChunkyPNG::Color.from_hex('#2f2fdf')
	white = ChunkyPNG::Color.from_hex('#dfdfdf')
	grey = ChunkyPNG::Color.from_hex('#262626')
	black = ChunkyPNG::Color::BLACK
	inputs[0].each_with_index{|inp,index|
		inp["signal"].each_with_index{|value,tick|
			color=(value)?(red):(white)
			png.rect(10+(tick*step).to_i, gap+index*tile_height, (10+(tick+1)*step).to_i, (index+1)*tile_height,color,color)
		}
	}
	height_gap=tile_height*(inputs[0].size)
	expressions.each_with_index{|exp,index|
		exp["signal"].each_with_index{|value,tick|
			color=(value)?(blue):(white)
			png.rect(10+(tick*step).to_i,     gap+index*tile_height+height_gap, 
				     10+((tick+1)*step).to_i, (index+1)*tile_height+height_gap,color,color)
		}
	}
	(time+1).times do  |t|
		png.line(10+(t*step).to_i, 0, 10+(t*step).to_i, height, black)
	end
	if !inputs[0].empty? and !expressions.empty?
		png.rect(0, inputs[0].size*tile_height, width, inputs[0].size*tile_height+gap, grey,grey)
	end
	png.save(file_name+'.png', :interlace => true)

end
def run(file_name="")
	time = get_time($lines)
	inputs = get_signals($lines,time)
	expressions = get_expressions($lines)
	plots = get_plots($lines)
	time = inputs[1]
	process_expressions(inputs,expressions,time)
	print_inputs(inputs)
	print_expressions(expressions)
	if file_name.eql?("")
		create_image(inputs,expressions,time,plots)
	else
		create_image(inputs,expressions,time,plots,file_name)
	end
end

