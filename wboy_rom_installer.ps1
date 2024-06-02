
$WorkingDirectory = Get-Location
$length = 73

$XORTable = @(0x04, 0x54, 0x51, 0x15, 0x40, 0x44, 0x01, 0x51,
              0x55, 0x10, 0x44, 0x41, 0x05, 0x55, 0x50, 0x14,
              0x41, 0x45, 0x00, 0x50, 0x54, 0x11, 0x45, 0x40,
              0x04, 0x54, 0x51, 0x15, 0x40, 0x44, 0x01, 0x51,
              0x55, 0x10, 0x44, 0x41, 0x05, 0x55, 0x50, 0x14,
              0x41, 0x45, 0x00, 0x50, 0x54, 0x11, 0x45, 0x40,
              0x04, 0x54, 0x51, 0x15, 0x40, 0x44, 0x01, 0x51,
              0x55, 0x10, 0x44, 0x41, 0x05, 0x55, 0x50, 0x14,
              0x04, 0x54, 0x51, 0x15, 0x40, 0x44, 0x01, 0x51,
              0x55, 0x10, 0x44, 0x41, 0x05, 0x55, 0x50, 0x14,
              0x41, 0x45, 0x00, 0x50, 0x54, 0x11, 0x45, 0x40,
              0x04, 0x54, 0x51, 0x15, 0x40, 0x44, 0x01, 0x51,
              0x55, 0x10, 0x44, 0x41, 0x05, 0x55, 0x50, 0x14,
              0x41, 0x45, 0x00, 0x50, 0x54, 0x11, 0x45, 0x40,
              0x04, 0x54, 0x51, 0x15, 0x40, 0x44, 0x01, 0x51,
              0x55, 0x10, 0x44, 0x41, 0x05, 0x55, 0x50, 0x14)
			  
$SWPTable = @(0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x02,
              0x02, 0x02, 0x02, 0x02, 0x03, 0x03, 0x03, 0x03, 0x04, 0x04,
              0x04, 0x04, 0x04, 0x05, 0x05, 0x05, 0x05, 0x05, 0x06, 0x06,
              0x06, 0x06, 0x06, 0x07, 0x07, 0x07, 0x07, 0x07, 0x08, 0x08,
              0x08, 0x08, 0x09, 0x09, 0x09, 0x09, 0x09, 0x0A, 0x0A, 0x0A,
              0x0A, 0x0A, 0x0B, 0x0B, 0x0B, 0x0B, 0x0B, 0x0C, 0x0C, 0x0C,
              0x0C, 0x0C, 0x0D, 0x0D, 0x08, 0x08, 0x08, 0x08, 0x09, 0x09,
              0x09, 0x09, 0x09, 0x0A, 0x0A, 0x0A, 0x0A, 0x0A, 0x0B, 0x0B,
              0x0B, 0x0B, 0x0C, 0x0C, 0x0C, 0x0C, 0x0C, 0x0D, 0x0D, 0x0D,
              0x0D, 0x0D, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0F, 0x0F, 0x0F,
              0x0F, 0x0F, 0x10, 0x10, 0x10, 0x10, 0x11, 0x11, 0x11, 0x11,
              0x11, 0x12, 0x12, 0x12, 0x12, 0x12, 0x13, 0x13, 0x13, 0x13,
              0x13, 0x14, 0x14, 0x14, 0x14, 0x14, 0x15, 0x15)



	cls
	Write-Output " .------------------------------."
	Write-Output " |Building Wonderboy ROMs       |"
	Write-Output " '------------------------------'"

	New-Item -ItemType Directory -Path $WorkingDirectory"/arcade" -Force
	New-Item -ItemType Directory -Path $WorkingDirectory"/arcade/wboy" -Force


	Write-Output "Building CPU ROM"
	cmd /c copy /b epr-7489.116+epr-7490.109 $WorkingDirectory"/arcade/wboy/rom1.bin"
	
	Write-Output "Copying non encrypted data"
	cmd /c copy /b epr-7491.96 $WorkingDirectory"/arcade/wboy/"
	
	Write-Output "Copying sound ROMs"
	cmd /c copy /b epr-7498.120 $WorkingDirectory"/arcade/wboy/"
	
	Write-Output "Copying tile ROMs"
	cmd /c copy /b epr-7497.62 $WorkingDirectory"/arcade/wboy/"
	cmd /c copy /b epr-7495.64 $WorkingDirectory"/arcade/wboy/"
	cmd /c copy /b epr-7493.66 $WorkingDirectory"/arcade/wboy/"
	cmd /c copy /b epr-7496.61 $WorkingDirectory"/arcade/wboy/"
	cmd /c copy /b epr-7494.63 $WorkingDirectory"/arcade/wboy/"
	cmd /c copy /b epr-7492.65 $WorkingDirectory"/arcade/wboy/"
	
	Write-Output "Combining sprite ROMs"
	cmd /c copy /b epr-7485.117+epr-7487.04+epr-7486.110+epr-7488.05 $WorkingDirectory"/arcade/wboy/sprites.bin"
	
	Write-Output "Copying lookup PROM"
	cmd /c copy /b pr-5317.76 $WorkingDirectory"/arcade/wboy/"
	
	Write-Output "Dumping XOR table"
	$xorBytes = [System.Byte[]]$XORTable
	$xorPath = [System.IO.Path]::Combine($WorkingDirectory, "arcade", "wboy", "xortable.bin")
	[System.IO.File]::WriteAllBytes($xorPath, $xorBytes)
	
	
	Write-Output "Dumping swap table"
	$swpBytes = [System.Byte[]]$SWPTable
	$swpPath = [System.IO.Path]::Combine($WorkingDirectory, "arcade", "wboy", "swptable.bin")
	[System.IO.File]::WriteAllBytes($swpPath, $swpBytes)
	
	$bytes = New-Object byte[] $length
	for ($i = 0; $i -lt $bytes.Length; $i++) {
	$bytes[$i] = 0xFF
	}

	$output_file = Join-Path -Path $WorkingDirectory -ChildPath "arcade\wboy\wbcfg"
	$output_directory = [System.IO.Path]::GetDirectoryName($output_file)
	[System.IO.File]::WriteAllBytes($output_file, $bytes)

	Write-Output "All done!"
	