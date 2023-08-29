# Coding Challenge: Job Match Recommendation Engine

### Instructions:

Clone the repository and ensure you have Ruby 3.1.2 installed. Run the script with:

```
ruby job_match.rb
```

This will read two files by default: jobseekers.csv and jobs.csv. The output will be in output.csv

If you wish to use custom paths you can use the following flags:

```
-j
--jobs
```

Specifies the path for the Job input

```
-s
---jobseekers
```

Specifies the path for the Job Seekers input

```
-o
--output
```

Specifies the path for the output csv

#### Example:

```
ruby job_match.rb -o ~/matched.csv
```

This will output the results to a file named 'matched.csv' in the User's home directory

### Tests:

RSpec is used for testing. Install with:

```
gem install rspec
```

Then run the test with:

```
rspec spec/job_match_spec.rb
```
