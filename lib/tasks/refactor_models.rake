task refactor_models: :environment do
  puts '# rename short_description/blurb to summary'
  Activity.where(summary: nil).each { |a| a.update_attribute(:summary, a.read_attribute(:short_description)) }
  Course.where(summary: nil).each { |c| c.update_attribute(:summary, c.read_attribute(:short_description)) }
  Department.where(summary: nil).each { |d| d.update_attribute(:summary, d.read_attribute(:short_description)) }

  puts '# migrate old HTML/plaintext content to markdown'
  Activity.where(markdown: nil).each { |a| a.update_attribute(:markdown, a.read_attribute(:content)) }
  Announcement.where(markdown: nil).each { |a| a.update_attribute(:markdown, a.read_attribute(:content)) }
  Closure.where(markdown: nil).each { |c| c.update_attribute(:markdown, c.read_attribute(:content)) }
  Course.where(markdown: nil).each { |c| c.update_attribute(:markdown, c.read_attribute(:content)) }
  Department.where(markdown: nil).each { |d| d.update_attribute(:markdown, d.read_attribute(:content)) }
  Promotion.where(markdown: nil).each { |pr| pr.update_attribute(:markdown, pr.read_attribute(:blurb)) }

  puts '# done!'
end
