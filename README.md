# Repo Hero

A GraphQL API built with Ruby on Rails for managing and reviewing code repositories. This application provides a flexible API for organizing repositories into categories, writing reviews, and tracking user engagement through likes and activities.

## Tech Stack

- **Ruby**: 3.4.7
- **Rails**: 8.0.3
- **GraphQL**: 2.5
- **Database**: SQLite3

## Features

- **Repository Management**: Store and query repository information
- **Category Organization**: Organize repositories into multiple categories
- **Reviews**: Write and retrieve reviews for repositories
- **User Engagement**: Track likes and activities for repositories
- **GraphQL API**: Flexible query interface for all resources

## GraphQL Schema

### Available Queries

```graphql
# Get all repositories
repos

# Get a specific repository by ID
repo(id: ID!)

# Get a category by ID
category(id: ID!)

# Fetch an object by global ID
node(id: ID!)

# Fetch multiple objects by IDs
nodes(ids: [ID!]!)
```

### Types

- **Repo**: Repository information with associations to categories, reviews, likes, and activities
- **Category**: Repository categories
- **Review**: User reviews for repositories
- **Like**: User likes for repositories
- **Activity**: User activities (likes or reviews)
- **Event**: Activity events

## Setup

### Prerequisites

- Ruby 3.4.7 or higher
- SQLite3

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. (Optional) Seed the database:
   ```bash
   rails db:seed
   ```

## Running the Application

Start the Rails server:

```bash
rails server
```

The GraphQL endpoint will be available at `http://localhost:3000/graphql`

## Using the GraphQL API

### Example Queries

#### Get all repositories with their categories and reviews:

```graphql
query {
  repos {
    id
    name
    url
    description
    categories {
      id
      name
    }
    reviews {
      id
      content
      rating
    }
  }
}
```

#### Get a specific repository:

```graphql
query {
  repo(id: "1") {
    id
    name
    url
    likes {
      id
    }
    activities {
      id
      activityType
    }
  }
}
```

### GraphQL Playground

You can explore the API using GraphiQL or any GraphQL client by sending POST requests to `/graphql`.

## Testing

Run the test suite:

```bash
rspec
```

The project uses RSpec for testing and Faker for generating test data.

## Project Structure

```
app/
├── graphql/
│   ├── mutations/          # GraphQL mutations
│   ├── resolvers/          # Custom resolvers
│   ├── types/             # GraphQL type definitions
│   │   ├── query_type.rb  # Root query type
│   │   ├── mutation_type.rb
│   │   ├── repo_type.rb
│   │   ├── category_type.rb
│   │   ├── review_type.rb
│   │   ├── like_type.rb
│   │   └── activity_type.rb
│   └── repo_hero_schema.rb
├── models/                # ActiveRecord models
└── controllers/
    └── graphql_controller.rb
```

## Development

The application follows standard Rails conventions with GraphQL-Ruby integration. All GraphQL types are located in `app/graphql/types/` and the schema is defined in `app/graphql/repo_hero_schema.rb`.

## License

This project is licensed under the MIT License.
