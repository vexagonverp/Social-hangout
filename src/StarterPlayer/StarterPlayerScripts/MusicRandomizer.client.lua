local SoundService = game:GetService("SoundService")

-- Number of other songs required to play before the same song can play again
local MININUM_SONGS_REQUIRED_BETWEEN_REPEATS = 2
local DEFAULT_VOLUME = 0.5

local random = Random.new()
local recentlyPlayedSoundObjects = {}

-- Array of song asset IDs to play randomly
local songs = {
	"rbxassetid://1837467590",
	"rbxassetid://1839198713",
	"rbxassetid://1839923818",
	"rbxassetid://1839825437",
	"rbxassetid://148987197",
}

-- Create and store sound objects to use in-game
local soundObjects = {}
for _, songID in ipairs(songs) do
	local soundObject = Instance.new("Sound")
	soundObject.SoundId = songID
	soundObject.Volume = DEFAULT_VOLUME
	soundObject.Parent = SoundService
	table.insert(soundObjects, soundObject)
end

-- Check and warn for any predictable randomization issues given the minimum songs between repeat
if MININUM_SONGS_REQUIRED_BETWEEN_REPEATS >= #soundObjects then
	warn("MININUM_SONGS_REQUIRED_BETWEEN_REPEATS is too high and cannot be respected")
elseif MININUM_SONGS_REQUIRED_BETWEEN_REPEATS == #soundObjects - 1 then
	warn("MININUM_SONGS_REQUIRED_BETWEEN_REPEATS is high enough that only one music sequence is possible (no randomization will occur)")
end

local function shuffleInPlace(array)
	for index1 = #array, 2, -1 do
		local index2 = random:NextInteger(1, index1)
		array[index1], array[index2] = array[index2], array[index1]
	end
end

while true do
	-- Randomly shuffle the given array in place (modifies the original array)
	shuffleInPlace(soundObjects)

	-- Enforce minimum song count required between repeated songs
	for recentlyPlayedIndex = 1, #recentlyPlayedSoundObjects do
		local recentlyPlayedSound = recentlyPlayedSoundObjects[recentlyPlayedIndex]

		for futureSongIndex = 1, #recentlyPlayedSoundObjects do
			local futureSoundObject = soundObjects[futureSongIndex]

			if recentlyPlayedSound == futureSoundObject then
				local numIndexesToMoveForward = math.max(MININUM_SONGS_REQUIRED_BETWEEN_REPEATS - futureSongIndex - recentlyPlayedIndex + 2, 0)

				if numIndexesToMoveForward > 0 then
					table.remove(soundObjects, futureSongIndex)
					table.insert(soundObjects, math.min(#soundObjects + 1, futureSongIndex + numIndexesToMoveForward), futureSoundObject)
				end
			end
		end
	end

	-- Play all songs in the newly shuffled and constrained song array
	for currentSongIndex = 1, #soundObjects do
		local currentSongObject = soundObjects[currentSongIndex]

		-- Play song
		currentSongObject:Play()

		currentSongObject.Ended:Wait()
	end

	-- Update the recently played sound objects array with the most recently played songs
	recentlyPlayedSoundObjects = {}
	for i = #soundObjects, #soundObjects - MININUM_SONGS_REQUIRED_BETWEEN_REPEATS + 1, -1 do
		table.insert(recentlyPlayedSoundObjects, soundObjects[i])
	end
end