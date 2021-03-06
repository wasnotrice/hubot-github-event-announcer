faker = require 'faker'

formatter = require '../../src/formatters/pull-request-review-comment'
{githubRepo, randomNumber} = require '../helpers'

describe 'Pull Request Review Comment Formatter', ->
  [content, event, label, name, number, otherName, repo, title, url] = []

  beforeEach ->
    content = faker.lorem.paragraphs()
    name = faker.internet.userName()
    number = randomNumber(32768)
    repo = githubRepo()
    url = faker.internet.avatar()

    event =
      type: 'pull_request_review_comment'
      data:
        action: 'created'
        comment:
          body: content
          html_url: url
          user:
            login: name
        pull_request:
          number: number
        repo:
          full_name: repo

  it 'formats a pull request review comment', ->
    expect(formatter(event)).toEqual """
      #{name} commented on Pull Request ##{number} on #{repo}
      Comment: #{content}

      #{url}
      """
