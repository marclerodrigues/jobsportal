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
      required_list[req.title.downcase] = req.years
    end
    skills.each do |skill|
      skills_list[skill.title.downcase] = skill.years.to_f
    end
    skills_that_matter = skills_list.sort.to_h.select { |key, value| required_list.include? key }
    requirements_that_matter = required_list.sort.to_h.select { |key, value| skills_list.include? key }
    if skills_that_matter == {} or requirements_that_matter == {}
      total = 0
    else
      calculate_total(skills_that_matter, requirements_that_matter, requirements.count)
    end
  end

  private

  def calculate_total(skill, required, requirements_count)
    total = skill.merge(required) do | key, old_val, new_val |
      old_val / new_val
    end.map(&:last).reduce(:+) / requirements_count.to_f
    total >= 1.0 ? total = 100 : total *= 100
  end
end
