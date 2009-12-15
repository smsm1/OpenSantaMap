# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_opensantamap_session',
  :secret      => 'eb5ca9c1b5c277f36fc8f7c47bc3f7c7ce75b60d4f308df17ceabe07c9b2c725e18b1542eadbfc78f49cd50e3d3d5888af33073df133c9657f5b74f51ca44e92'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
