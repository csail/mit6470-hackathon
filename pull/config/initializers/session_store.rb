# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pull_session',
  :secret      => 'fb2c844f1e6239008cc663af3b47f8d65e98213dd613a54384bd0e2417ee6a171596acb6a8a7fdabc883f1b748273cf0fb0637b1c04b2198f37ba98cd250414d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
