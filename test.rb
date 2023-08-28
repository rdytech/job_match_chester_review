require "csv"

jobseekers_arr = []
CSV.foreach("jobseekers.csv", headers: true) do |row|
  jobseekers_arr.push({ id: row["id"], name: row["name"], skills: row["skills"].split(",") })
end

jobs_arr = []
CSV.foreach("jobs.csv", headers: true) do |row|
  jobs_arr.push({ id: row["id"], title: row["title"], required_skills: row["required_skills"].split(",") })
end

puts jobseekers_arr
puts jobs_arr