-- Set some variables - we want to pull most of this stuff out of Webscript's storage table
local GOOG_OAUTH_TOKEN = storage.google_oauth_token
local GOOG_PRINTER_ID  = storage.google_printer_id
local IG_CLIENT_ID     = storage.instagram_client_id
local HASHTAG          = 'printer'

-- If this is an IG real-time subscription challenge, return the
-- hub.challenge parameter to Instagram so they get lost
if request.query['hub.challenge'] then

	return request.query['hub.challenge']

end

-- Ping instagram and get the latest bit of media for our hashtag
local media = http.request({

	url = 'https://api.instagram.com/v1/tags/' .. HASHTAG .. '/media/recent',
	params = {client_id = IG_CLIENT_ID, count = 1}

})

-- Parse JSON response and get a decent-resolution version of the pic
media = json.parse(media.content)
media = media.data[1].images.standard_resolution.url

-- Submit a print job to Google Cloud Print
local job = http.request({

	url = 'https://www.google.com/cloudprint/submit',
	headers = {['Authorization'] = 'OAuth ' .. GOOG_OAUTH_TOKEN},
	params = {

		printerid = GOOG_PRINTER_ID,
		title = 'Instagram Printer',
		content = media,
		contentType = 'url'

	}

})

-- Return the job info (should probably not do this in real life)
return job