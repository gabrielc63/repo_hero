require 'rails_helper'
require 'faker'

RSpec.describe 'Graphql, repo query, with activity', type: :request do
  let!(:repo) { Repo.create!(name: 'Repo Hero', url: 'https://github.com/repohero/repohero') }
  let(:server_response) { response.parsed_body }

  before do
    review = repo.reviews.create!(rating: 5, comment: "Review #{Faker::Name.name}")
    like = repo.likes.create!
    repo.activities.create(event: review)
    repo.activities.create(event: like)
  end

  it 'retrieves a single repo with a list of activities' do
    query = <<~QUERY
        query ($id: ID!) {
          repo(id: $id) {
          name
          activities {
            nodes {
              __typename
              event {
                ... on Review {
                  rating
                  comment
                }
                ... on Like {
                  createdAt
                }
              }
            }
          }
        }
      }
    QUERY

    post '/graphql', params: { query: query, variables: { id: repo.id } }
    expect(server_response).not_to have_errors
    expect(server_response['data']).to match(
      'repo' => a_hash_including(
        'name' => repo.name
      )
    )

    activities = server_response.dig('data', 'repo', 'activities', 'nodes')
    expect(activities.count).to eq(2)
  end
end
