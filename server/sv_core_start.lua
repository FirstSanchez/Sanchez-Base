-- DO NOT DELETE FAGGOT

CAN_START = true

ResourceStarted = function ()
	CAN_START = false
	CreateThread(function ()
		Wait(5000)
		CAN_START = true
	end)
end

START_MESSAGE = [[

 _____                                                                        _____ 
( ___ )                                                                      ( ___ )
 |   |~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|   | 
 |   |                                                                        |   | 
 |   |   ____    _    _   _  ____ _   _ _____ _____   ____ ___  ____  _____   |   | 
 |   |  / ___|  / \  | \ | |/ ___| | | | ____|__  /  / ___/ _ \|  _ \| ____|  |   | 
 |   |  \___ \ / _ \ |  \| | |   | |_| |  _|   / /  | |  | | | | |_) |  _|    |   | 
 |   |   ___) / ___ \| |\  | |___|  _  | |___ / /_  | |__| |_| |  _ <| |___   |   | 
 |   |  |____/_/   \_\_| \_|\____|_| |_|_____/____|  \____\___/|_| \_\_____|  |   | 
 |   |                             Core für ESX                           |   | 
 |___|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|___| 
(_____)                                                                      (_____)
]]

CreateThread(function ()
	Wait(0)
	while not CAN_START do
		Wait(0)
	end
	print(START_MESSAGE)
end)