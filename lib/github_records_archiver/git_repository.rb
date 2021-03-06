module GitHubRecordsArchiver
  class GitError < StandardError; end

  class GitRepository
    def clone
      if Dir.exist? repo_dir # Repo already exists, just pull new objects
        Dir.chdir repo_dir
        git 'pull'
      else # Clone Git content from scratch
        git 'clone', clone_url, repo_dir
      end
    end

    def repo_dir
      fail 'Not implemented'
    end

    private

    def clone_url
      fail 'Not implemented'
    end

    # Run a git command, piping output to stdout
    def git(*args)
      output, status = Open3.capture2e('git', *args)
      fail GitError, output if status.exitstatus != 0
      output
    end
  end
end
