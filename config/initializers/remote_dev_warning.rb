if Rails.env.development?
  if ENV['DATABASE_URL'].present? || ENV['R2_BUCKET'].present?
    warning = <<~MSG
      ************************************************************
      WARNING: Development environment is configured to use remote
      services (DATABASE_URL or R2_BUCKET detected).

      DATABASE_URL: #{ENV['DATABASE_URL']}
      R2_BUCKET: #{ENV['R2_BUCKET']}

      You are pointed at remote production/staging resources. Be careful
      running destructive tasks (migrations, seeds, console commands)
      as they will affect that remote database/bucket.

      If you intended to do this, continue. Otherwise, unset these
      environment variables or use a different .env file.
      ************************************************************
    MSG

    Rails.logger.warn warning
    # Also print to STDOUT so it's visible in local terminal/server logs
    puts warning
  end
end

