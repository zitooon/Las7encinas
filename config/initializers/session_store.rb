# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_web_session',
  :secret      => '2897397e9e9c3b7cc06e59562434753ff7efae98b3b9f88a9fe75280eb13a9267106255c2081af0061a071208f57ae6d2a6ad2138f40326bc351c10a6fc689be'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
