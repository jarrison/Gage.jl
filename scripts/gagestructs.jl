module GageStructs

mutable struct BoardInfo
	Size::UInt32   					  #Total size, in bytes, of the structure.
	BoardIndex::UInt32 				  # Board Index in the system
	BoardType::UInt32 				  # Numeric constant to represent Gage boards.
	strSerialNumber::Cstring;		  # String representing the board serial number.
	BaseBoardVersion::UInt32 		  # Version number of the base board.
	BaseBoardFirmwareVersion::UInt32   # Version number of the firmware on the base board.
	AddonBoardVersion::UInt32 		  # Version number of the Addon board.
	AddonBoardFirmwareVersion::UInt32  # Version number of the firmware of the Addon board.
	AddonFwOptions::UInt32 			  # Options of the current firmware image of Addon board
	BaseBoardFwOptions::UInt32 		  # Options of the current firmware image of Baseboard
	AddonHwOptions::UInt32 			  # Options of the Addon board pcb
	BaseBoardHwOptions::UInt32 		  # Options of the Baseboard pcb
	BoardInfo() = new(0,0,0,Ref{Cstring}(),0,0,0,0,0,0,0,0)
end



end
