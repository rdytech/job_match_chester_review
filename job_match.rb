require "csv"
require "optparse"

options = {
  output_path: "output.csv",
  jobseekers_csv_path: "jobseekers.csv",
  jobs_csv_path: "jobs.csv"
}

OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-s INPUT", "--jobseekers INPUT", "Path to jobseekers.csv") do |input|
    options[:jobseekers_csv_path] = input
  end

  opts.on("-j INPUT", "--jobs INPUT", "Path to jobs.csv") do |input|
    options[:jobs_csv_path] = input
  end

  opts.on("-o INPUT", "--output INPUT", "Select output file") do |o|
    options[:output_path] = o.to_s
  end
end.parse!

jobseekers_arr = CSV.read(options[:jobseekers_csv_path], headers: true).map do |row|
  { id: row["id"], name: row["name"], skills: row["skills"].split(",") }
end

jobs_arr = CSV.read(options[:jobs_csv_path], headers: true).map do |row|
  { id: row["id"], title: row["title"], required_skills: row["required_skills"].split(",") }
end

recommendations_arr = jobseekers_arr.flat_map do |jobseeker|
  temp_arr = jobs_arr.flat_map do |job|
    matching_skills = jobseeker[:skills].intersection(job[:required_skills])
    matching_skill_count = matching_skills.length
    matching_skill_percent = (matching_skill_count.to_f / job[:required_skills].length) * 100

    {
      jobseeker_id: jobseeker[:id].to_i,
      jobseeker_name: jobseeker[:name],
      job_id: job[:id].to_i,
      job_title: job[:title],
      matching_skill_count: matching_skill_count,
      matching_skill_percent: matching_skill_percent.round(2)
    }
  end
  temp_arr.sort_by! { |j| [ -j[:matching_skill_percent], j[:job_id] ]}
end

headers = ["jobseeker_id", "jobseeker_name", "job_id", "job_title", "matching_skill_count", "matching_skill_percent"]
CSV.open(options[:output_path], "w", write_headers: true, headers: headers) do |csv|
  recommendations_arr.each { |row| csv << row.values }
end
