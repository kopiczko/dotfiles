--this script works with MacOS Photos: 
--It will take the first photo's location and copy it onto the other selected photos in the same album.
tell application "Photos"
	activate
	set imageSel to (get selection)
	if (imageSel is {}) or (the length of imageSel < 2) then
		error "Please select at least two images."
	else
		set withAlti to false
		set withLati to false
		set withLongi to false
		
		try
			tell the first item of imageSel
				set loc to get the location --retrieve longitude and latitude as list
				set alti to get the altitude -- retrieve the altitude
				
				set lati to (the first item of loc) -- as number
				set longi to (the second item of loc) -- as number
				
				-- return altiS
				set withAlti to (alti is not equal to missing value)
				set withLati to (lati is not equal to missing value)
				set withLongi to (longi is not equal to missing value)
				
				if not withLati then
					set withLati to false
					error "Photo has no Latitude assigned"
				end if
				
				if not withLongi then
					error "Photo has no Latitude assigned"
				end if
				if (lati > 90.0) or (lati < -90.0) then
					error "Latitude out of range " & lati
				end if
				if (longi > 180.0) or (longi < -180.0) then
					error "Longitude out of range " & longi
				end if
				
			end tell
		on error errTexttwo number errNumtwo
			display dialog "No GPS: " & errNumtwo & return & errTexttwo
			return
		end try
		
		if (not withLongi or not withLati) then
			
			return {loc, alti} --testing
		end if
		
		repeat with i from 2 to count of imageSel
			
			set next_image to item i of imageSel
			
			tell next_image
				set its location to {lati, longi}
				-- if withAlti then -- photo has altitude tag
				-- set its altitude to alti
				-- end if
			end tell
			if withAlti then -- photo has altitude tag
				tell next_image
					-- set its altitude to alti as number  -- does not work
				end tell
			end if
			
			
		end repeat
	end if
	
	return {loc, alti, "Done"} -- for testing
end tell
