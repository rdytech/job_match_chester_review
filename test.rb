require "csv"

jobseekers_arr = []
CSV.foreach("jobseekers.csv", headers: true) do |row|
  jobseekers_arr.push({ id: row["id"], name: row["name"], skills: row["skills"].split(",") })
end

jobs_arr = []
CSV.foreach("jobs.csv", headers: true) do |row|
  jobs_arr.push({ id: row["id"], title: row["title"], required_skills: row["required_skills"].split(",") })
end

recommendations_arr = []
jobseekers_arr.each do |jobseeker|

  temp_arr = []

  jobs_arr.each do |job|
    matching_skills = jobseeker[:skills].intersection(job[:required_skills])
    matching_skill_count = matching_skills.length
    matching_skill_percent = (matching_skill_count.to_f / job[:required_skills].length) * 100

    temp_arr.push({
      jobseeker_id: jobseeker[:id].to_i,
      jobseeker_name: jobseeker[:name],
      job_id: job[:id].to_i,
      job_title: job[:title],
      matching_skill_count: matching_skill_count,
      matching_skill_percent: matching_skill_percent.round(2)
    })
  end

  temp_arr.sort_by! { |j| [ -j[:matching_skill_percent], j[:job_id] ]}
  
  recommendations_arr.push(temp_arr)
end

puts recommendations_arr