function GM:LoadFonts( )
	local size_min = 8
	local size_max = 150
	for fontsize = size_min, size_max do
		surface.CreateFont( 'Tahoma_' .. fontsize, { font = 'Tahoma', size = fontsize, weight = 500, antialias = true } )
		surface.CreateFont( 'TahomaBlur_' .. fontsize, { font = 'Tahoma', size = fontsize, weight = 500, antialias = true, blursize = 3 } )
		surface.CreateFont( 'TahomaBoldOut_' .. fontsize, { font = 'Tahoma', size = fontsize, weight = 600, antialias = true, outline = true } )
		surface.CreateFont( 'TahomaBold_' .. fontsize, { font = 'Tahoma', size = fontsize, weight = 600, antialias = true } )
		surface.CreateFont( 'TahomaBoldBlur_' .. fontsize, { font = 'Tahoma', size = fontsize, weight = 600, antialias = true, blursize = 3 } )
	end
end

function draw.SimpleTextBlurred( str, size, x, y, col, xa )
	draw.SimpleText( str, 'TahomaBold_' .. size, x, y, col, xa )
	draw.SimpleText( str, 'TahomaBoldBlur_' .. size, x, y, Color( col.r, col.g, col.b, col.a - 155 ), xa )
end