# https://github.com/mongoid/mongoid-history/issues/192
Mongoid::History.tracker_class_name = :history_tracker

# in development mode rails does not load all models/classes
# force rails to load history tracker class
(Rails.env == 'development') && require_dependency(Mongoid::History.tracker_class_name.to_s)
