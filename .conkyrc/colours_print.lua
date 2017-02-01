-- Conky Lua scripting example
--
-- In your conkyrc, use ${lua string_func} to call conky_string_func(), ${lua
-- int_func} to call conky_int_func(), and so forth.  You must load this script
-- in your conkyrc using 'lua_load <path>' before TEXT in order to call the
-- function.
--
do
	-- configuration
	local interval = 5 

	-- local variables protected from the evil outside world
	local next_update
	local buf 
	local int = 0
	local colour = 0
	local function update_buf()
		buf = os.time()
	end

	-- a function that returns the time with some special effects using a 5
	-- second interval
	function conky_string_func()
		local now = os.time()

		if next_update == nil or now >= next_update then
			update_buf();
			next_update = now + interval
		end
		colour = colour + 11100

		return string.format("${color #%06x}The time is now ", colour%0xffffff) .. tostring(buf) .. "${color}"
	end

	-- this function changes Conky's top colour based on a threshold
	function conky_top_colour(value, default_colour, upper_thresh, lower_thresh)
		local r, g, b = default_colour, default_colour, default_colour
		local colour = 0
		-- in my case, there are 4 CPUs so a typical high value starts at around ~20%, and 25% is one thread/process maxed out
		local thresh_diff = upper_thresh - lower_thresh
		if (value - lower_thresh) > 0 then
			if value > upper_thresh then value = upper_thresh end
			-- add some redness, depending on the 'strength'
			r = math.ceil(default_colour + ((value - lower_thresh) / thresh_diff) * (0xff - default_colour))
			b = math.floor(default_colour - ((value - lower_thresh) / thresh_diff) * default_colour)
			g = b
		end
		colour = (r * 0x10000) + (g * 0x100) + b -- no bit shifting operator in Lua afaik

		return string.format("${color #%06x}", colour%0xffffff)
	end
	-- parses the output from top and calls the colour function
	function conky_top_cpu_colour(arg)
		-- input is ' ${top name 1} ${top pid 1} ${top cpu 1} ${top mem 1}'
		local cpu = tonumber(string.match(arg, '(%d+%.%d+)'))
		-- tweak the last 3 parameters to your liking
		-- my machine has 4 CPUs, so an upper thresh of 25% is appropriate
		return conky_top_colour(cpu, 0xd3, 25, 15) .. arg
	end
	function conky_top_mem_colour(arg)
		-- input is '${top_mem name 1} ${top_mem pid 1} ${top_mem cpu 1} ${top_mem mem 1}'
		local mem = tonumber(string.match(arg, '%d+%.%d+%s+(%d+%.%d+)'))
		-- tweak the last 3 parameters to your liking
		-- my machine has 8GiB of ram, so an upper thresh of 15% is appropriate
		return conky_top_colour(mem, 0xd3, 15, 5) .. arg
	end
  
  function conky_colour_int(arg, lower, upper)
    local cur = tonumber(conky_parse(arg))
    local color = "${color0}"
    if cur < tonumber(lower) then
      color = "${color8}"
    elseif cur >= tonumber(upper) then
      color = "${color9}"
    end
    return string.format("%s%3d", color, cur)
  end
  function conky_colour_float(arg, lower, upper)
    local cur = tonumber(conky_parse(arg))
    local color = "${color0}"
    if cur < tonumber(lower) then
      color = "${color8}"
    elseif cur >= tonumber(upper) then
      color = "${color9}"
    end
    return string.format("%s%7.2f", color, cur)
  end
  function conky_colour_bytes(arg, lower, upper, postfix_color)
    local cur = conky_parse(arg)
    local num = tonumber(string.match(cur, "[%d%.]+"))
    local postfix = string.match(cur, "[A-Za-z]+")
    local r = string.format("%6.2f%s%s", num, postfix_color, postfix);

    local color = "${color0}"
     if num < tonumber(lower) then
       color = "${color8}"
     elseif num >= tonumber(upper) then
       color = "${color9}"
     end
     return string.format("%s%18s", color, r) 
  end
  function conky_substring(string, from, to)
    local str = conky_parse(string)
    return string.sub(str, tonumber(from), tonumber(to))
  end
  
  function conky_format(f, arg)
    local a = string.gsub(conky_parse(arg), " ", "")
    return string.format(f, a)
  end

	-- returns a percentage value that loops around
	function conky_int_func()
		int = int + 1
		return int % 100
	end
end
