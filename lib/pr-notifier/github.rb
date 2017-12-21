require 'octokit'

module PrNotifier
  class PullRequest
    attr_reader :repo, :repo_url, :url, :title, :body, :reviewers, :assignees, :creator, :created_at

    def initialize(repo:, repo_url:, url:, title:, body:, reviewers:, assignees:, creator:, created_at:)
      @repo = repo
      @repo_url = repo_url
      @url = url
      @title = title
      @body = body
      @reviewers = reviewers
      @assignees = assignees
      @creator = creator
      @created_at = created_at
    end
  end

  class Github
    attr_reader :client

    def initialize(access_token:)
      @client = Octokit::Client.new(access_token: access_token)
    end

    def fetch_prs_by(repo)
      prs = client.pull_requests(repo, { state: "open" })
      prs.map do |pr|
        PullRequest.new(
          repo: repo,
          repo_url: pr.head.repo.html_url,
          url: pr.html_url,
          title: pr.title,
          body: pr.body,
          reviewers: pr.requested_reviewers.map { |reviewer| reviewer[:login] },
          assignees: pr.assignees.map { |assignee| assignee[:login] },
          creator: pr.user[:login],
          created_at: pr.created_at,
        )
      end                                                      
    end
  end
end
