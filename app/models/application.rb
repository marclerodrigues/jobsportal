class Application < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :job
  belongs_to :company

  def calculate_match(job, candidate)
    requirements = job.requirements.to_a
    skills = candidate.skills.to_a
    required_list = {}
    skills_list = {}
    requirements.each do |req|
      req_title = req.title.downcase
      required_list[req_title] = req.years
    end
    skills.each do |skill|
      skill_title = skill.title.downcase
      skills_list[skill_title] = skill.years.to_f
    end
    required_list = required_list.sort.to_h
    skills_list = skills_list.sort.to_h
    skills_that_matter = skills_list.select { |key, value| required_list.include? key }
    requirements_that_matter = required_list.select { |key, value| skills_list.include? key }
    if skills_that_matter == {} or requirements_that_matter == {}
      total = 0
    else
      total = skills_that_matter.merge(requirements_that_matter) do |key, old_val, new_val|
        old_val / new_val
      end
      total = (total.map(&:last).reduce(:+) / requirements.count.to_f)

      if total >= 1
        total = 1
      else
        total
      end
      total*100
    end
  end

=begin
  def calculate_match job, candidate
    requirements = job.requirements.sort.to_h
    skills = candidate.skills.sort.to_h
    skills_that_matter = skills.select { |k,v| requirements.include? k}
    requir_that_matter = requirements.select { |k,v| skills.include? k}
    total = skills_that_matter.merge(requir_that_matter) do |key, old_val, new_val|
      old_val / new_val.to_f
    end.map(&:last).reduce(:+) / requirements.count.to_f
    if total*100 >= 100
      total = 100
    else
      total*100
    end
  end
=end
end
