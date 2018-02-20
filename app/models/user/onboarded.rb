module User::Onboarded
  def onboarding_steps
    required = []
    if staff?
      required << :picture unless picture.blank?
      required << :bio if bio.blank?
    end
    required
  end
end