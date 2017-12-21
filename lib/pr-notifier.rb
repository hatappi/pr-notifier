require "pr-notifier/version"
require "pr-notifier/github"
require "erb"
require "slack-notifier"

module PrNotifier
  module_function
  def run(gh_token: nil, repos: nil, webhook_url: nil, channel: nil, username: nil, template: nil)
    gh_token ||= ENV['GH_TOKEN']
    repos = (repos || ENV['GH_REPOS'])&.split(',')
    webhook_url ||= ENV["SLACK_WEBHOOK_URL"]
    channel ||= ENV["SLACK_CHANNEL"]
    username ||= ENV["SLACK_USERNAME"]
    @template = template || ENV["TEMPLATE"]

    gh_client = Github.new(access_token: gh_token)
    prs = repos.each_with_object([]) { |repo, prs| prs.concat(gh_client.fetch_prs_by(repo)) }

    notifier = Slack::Notifier.new(webhook_url, channel: channel, username: username)
    notifier.ping(message(pull_requests: prs))
  end

  def message(pull_requests:) 
    ERB.new(template, nil, '-').result(binding)
  end

  def template
    @template || <<~ERB
<% pull_requests.each do |pr| -%>
:memo: <%= pr.title %>
      <%= pr.url %>
<% if pr.reviewers.size > 0 -%>
      reviewers: <%= pr.reviewers.join(", ") %>
<% end -%>
<% end -%>
ERB
  end
end
