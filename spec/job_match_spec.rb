require_relative "../job_match"

RSpec.describe "Job Match" do
    let(:jobseekers_csv_path) { "./spec/fixtures/test_jobseekers.csv" }
    let(:jobs_csv_path) { "./spec/fixtures/test_jobs.csv" }
    let(:correct_output_path) { "./spec/fixtures/correct_output.csv" }
    let(:output_path) { "./spec/test_output.csv" }

    after do
        File.delete(output_path)
    end

    it "outputs the correct CSV" do
        JobMatch.new(jobs_csv_path, jobseekers_csv_path, output_path).match_jobs
        correct_output = File.read(correct_output_path)
        output = File.read(output_path)
        expect(output).to eq(correct_output)
    end
end