module Types
  class RepoType < Types::BaseObject
    field :name, String, null: false
    field :url, String, null: false
  end
end
