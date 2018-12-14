require 'json'

ret = `aws secretsmanager get-secret-value --secret-id ad-scraper`
begin
  params = JSON.parse(ret)
  secrets = JSON.parse(params['SecretString'])
rescue
  return
end

envstr = "RAILS_SECRET_KEY_BASE=" + secrets['RAILS_SECRET_KEY_BASE'] + "\n"
envstr += "AD_SCRAPER_DATABASE_HOST=" + secrets['AD_SCRAPER_DATABASE_HOST'] + "\n"
envstr += "AD_SCRAPER_DATABASE_USER=" + secrets['AD_SCRAPER_DATABASE_USER'] + "\n"
envstr += "AD_SCRAPER_DATABASE_PASSWORD=" + secrets['AD_SCRAPER_DATABASE_PASSWORD'] + "\n"
envstr += "REDIS_HOST=" + secrets['REDIS_HOST'] + "\n"
envstr += "AD_SCRAPER_URL=" + secrets['AD_SCRAPER_URL'] + "\n"
envstr += "CHATWORK_API_KEY=" + secrets['CHATWORK_API_KEY'] + "\n"
envstr += "CHATWORK_ROOM_ID=" + secrets['CHATWORK_ROOM_ID'] + "\n"
envstr += "GOOGLE_OAUTH2_API_ID=" + secrets['GOOGLE_OAUTH2_API_ID'] + "\n"
envstr += "GOOGLE_OAUTH2_API_SECRET=" + secrets['GOOGLE_OAUTH2_API_SECRET'] + "\n"

print envstr
