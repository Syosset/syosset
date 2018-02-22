# https://github.com/mongoid/mongoid-history/issues/192
Mongoid::History.tracker_class_name = :history_tracker

# in development mode rails does not load all models/classes
# force rails to load history tracker class
(Rails.env == 'development') && require_dependency(Mongoid::History.tracker_class_name.to_s)

if Rails.env.test?
  # Monkey-patch for mongoid options, making modifier fields optional
  class Mongoid::History::Options
    def default_options
      @default_options ||=
        { on: :all,
          except: %i[created_at updated_at],
          tracker_class_name: nil,
          modifier_field: :modifier,
          version_field: :version,
          changes_method: :changes,
          scope: scope,
          track_create: true,
          track_update: true,
          track_destroy: true,
          format: nil,
          modifier_field_optional: true }
    end
  end
end