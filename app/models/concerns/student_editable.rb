module Concerns
  module StudentEditable
    extend ActiveSupport::Concern

    included do
      has_one :unlock_grant, :as => :student_editable, :class_name => "UnlockGrant"

      before_destroy do
        unlock_grant.destroy
      end

      before_update do
        unless unlock_grant || Current.user.staff?
          self.errors.add(:base, "Ask your advisor to grant temporary access to edit the page. This can be done from the club page on the advisor's account by clicking \"Unlock this page for student edits\"")
          throw :abort
        end
      end
    end

    def unlocked?
      !self.unlock_grant.nil?
    end

    def unlock(time, granter)
      return false if unlocked?
      return true if UnlockGrant.create(student_editable: self, granter: granter, expire_at: (Time.now + time))
    end
  end
end
