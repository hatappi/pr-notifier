# pr-notifier

It is a command line tool for notifying slack open pull requests

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pr-notifier'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install pr-notifier
```

## Usage

```bash
$ pr-notifier -g [GITHUB_TOKEN] -r hatappi/pr-notifier -w https://hooks.slack.com/services/xxxx/yyyy
```

## CommandLine options

```bash
-d, --dry-run                    DRY RUN
-g, --gh-token VALUE             GitHub access token ENV:GH_TOKEN
-r, --repos VALUE                GitHub repositories. separate comma ENV:GH_REPOS
-w, --webhook-url VALUE          slack webhook url ENV:SLACK_WEBHOOK_URL
-c, --channel VALUE              slack channel ENV:SLACK_CHANNEL
-u, --username VALUE             slack username ENV:SLACK_USERNAME
-t, --template VALUE             ERB template for sending to slack ENV:TEMPLATE
```

## Writing a template
pr-notifier' slack template can be changed and use [ERB](https://docs.ruby-lang.org/ja/latest/class/ERB.html).  
`pull_requests` variables can be used for templates.  
`pull_requests` is an array of instances with the following properties.  

```
- repo: repository name
- repo_url: repository_url
- url: pull request url
- title: pull request title
- body: pull request description
- reviewers: reviewer names
- assignees: assignee names
- creator: pull request creator name
- created_at: day pull request was created
```

exp.  

```erb
<%= Time.now %>
<% pull_requests.each do |pr| -%>
  <%= pr.title %>
  <%= pr.body %>
<% end -%>
```

## Contributing

If there is any thing you'd like to contribute or fix, please:

- Fork the repo
- Add tests for any new functionality
- Make your changes
- Make a pull request


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
