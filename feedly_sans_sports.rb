#!/usr/bin/env ruby

require 'httparty'

class FeedlyApi
  include HTTParty

  base_uri 'https://feedly.com/v3'
  headers(
      Authorization: ENV['FEEDLY_API_AUTHORIZATION']
  )
end

resp =
  FeedlyApi.get(
    '/streams/contents',
    query: {
      streamId: ENV['FEEDLY_STREAM'],
      count: 1000,
      unreadOnly:  true,
      ranked: 'oldest',
      similar: true
    }
)

sports_items =
  resp['items'].select do |item|
    item['originId'].include?('/sports/')
  end

return unless sports_items.any?

resp =
  FeedlyApi.post(
    '/markers',
    headers: {
      'Content-Type': 'application/json'
    },
    body: {
      action: 'markAsRead',
      type: 'entries',
      entryIds: sports_items.map { |item| item['id'] }
    }.to_json
)
