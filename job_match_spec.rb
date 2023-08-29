require 'rspec'
require 'csv'
require_relative 'job_match'

describe 'Job Recommendations' do

  before do

  end

  it 'reads jobseekers from csv' do
    jobseekers_arr = CSV.read(jobseekers_csv_path, headers: true).map do |row|
      { id: row["id"], name: row["name"], skills: row["skills"].split(",") }
    end

    expect(jobseekers_arr).not_to be_empty
  end

  it 'reads jobs from csv' do
    jobs_arr = CSV.read(jobs_csv_path, headers: true).map do |row|
      { id: row["id"], title: row["title"], required_skills: row["required_skills"].split(",") }
    end

    expect(jobs_arr).not_to be_empty
  end

  it 'generates recommendations' do
    recommendations_arr = CSV.read(output_csv_path, headers: true).map do |row|
      {
        jobseeker_id: row["jobseeker_id"].to_i,
        jobseeker_name: row["jobseeker_name"],
        job_id: row["job_id"].to_i,
        job_title: row["job_title"],
        matching_skill_count: row["matching_skill_count"].to_i,
        matching_skill_percent: row["matching_skill_percent"].to_f
      }
    end

    expect(recommendations_arr).not_to be_empty
  end
end