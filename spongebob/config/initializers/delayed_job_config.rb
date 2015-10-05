require "delayed_job"
require "delayed/backend/active_record"
Delayed::Worker.backend = :active_record
Delayed::Worker.destroy_failed_jobs = false
Delayed::Worker.max_run_time = 120.minutes
Delayed::Worker.sleep_delay = 60
Delayed::Worker.max_attempts = 2