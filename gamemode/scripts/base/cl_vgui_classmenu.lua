if ( IsValid( vgui_ClassMenu ) ) then
	vgui_ClassMenu:Remove( )
	vgui_ClassMenu = nil
end

timer.Simple( 0.1, function( )
	if ( !IsValid( vgui_ClassMenu ) ) then
		vgui_ClassMenu = vgui.Create( 'MW_ClassMenu' )
		
		surface.PlaySound( 'items/ammo_pickup.wav' )
	end
end )

net.Receive( 'mw_classmenu', function( _ )
	if ( !IsValid( vgui_ClassMenu ) ) then
		vgui_ClassMenu = vgui.Create( 'MW_ClassMenu' )
	end
end )

local PANEL = { }
function PANEL:Init( )
	local scrW, scrH = ScrW( ), ScrH( )
	
	self.MainFrame = vgui.Create( 'DFrame' )

	self.MainFrame.w = scrW
	self.MainFrame.h = scrH
	self.MainFrame.x = scrW / 2 - scrW / 2
	self.MainFrame.y = scrH / 2 - scrH / 2
	 
	self.MainFrame:SetTitle( '' )
	self.MainFrame:SetSize( self.MainFrame.w, self.MainFrame.h )
	self.MainFrame:SetPos( self.MainFrame.x, self.MainFrame.y )
	self.MainFrame:ShowCloseButton( false )
	self.MainFrame:SetDraggable( false )
	self.MainFrame:MakePopup( )
	self.MainFrame.Paint = function( _, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 33, 33, 33 ) )
	end
	
	self.MainFrame.ClassList = vgui.Create( 'DPanelList', self.MainFrame )
	self.MainFrame.ClassList:SetPos( self.MainFrame.w / 4.5, self.MainFrame.h / 5 )
	self.MainFrame.ClassList:SetSize( self.MainFrame.w * 0.55, self.MainFrame.h - 475 )
	self.MainFrame.ClassList:SetSpacing( 5.5 )
	self.MainFrame.ClassList:EnableHorizontal( true )
	self.MainFrame.ClassList:EnableVerticalScrollbar( true )
	self.MainFrame.ClassList.Paint = function( _, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 43, 43, 43 ) )
	end
	
	for k, v in pairs( Classes ) do
		local button = vgui.Create( 'DButton' )
		button:SetText( '' )
		button:SetSize( 68, 68 )
		button.Paint = function( _, w, h )
			draw.RoundedBox( 4, 0, 0, w, h, Color( 189, 195, 199 ) )
			
			surface.SetDrawColor( 255, 255, 255 )
			surface.SetMaterial( Material( v.Icon, 'smooth' ) )
			surface.DrawTexturedRect( 2, 2, 64, 64 )
		end
		
		button.DoClick = function( )
			self.classID = k
		end
		
		self.MainFrame.ClassList:AddItem( button )
	end
	
	self.MainFrame.ClassSelect = vgui.Create( 'DButton', self.MainFrame )
	self.MainFrame.ClassSelect:SetPos( self.MainFrame.w / 1.51, self.MainFrame.h / 1.6 )
	self.MainFrame.ClassSelect:SetText( '' )
	self.MainFrame.ClassSelect:SetSize( 150, 50 )
	self.MainFrame.ClassSelect.Paint = function( _, w, h )
		if ( !self.classID ) then
			color = Color( 127, 140, 141 )
			color2 = Color( 236, 240, 241, 50 )
		else
			color = Color( 211, 84, 0 )
			color2 = Color( 236, 240, 241 )
		end
		
		draw.RoundedBox( 4, 0, 0, w, h, color )
		draw.SimpleTextBlurred( '준비 완료', 22, w / 2, h / 4, color2, 1 )
	end
	self.MainFrame.ClassSelect.DoClick = function( )
		if ( !self.classID ) then return end
		
		net.Start( 'mw_classmenu_selected' )
			net.WriteInt( self.classID, 4 )
		net.SendToServer( )
		
		vgui_ClassMenu:Remove( )
	end
	
end

function PANEL:Think( )
end

function PANEL:Remove( )
	self.MainFrame:Remove( )
end

vgui.Register( 'MW_ClassMenu', PANEL, 'PANEL' )