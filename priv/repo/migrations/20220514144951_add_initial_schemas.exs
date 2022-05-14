defmodule Center.Repo.Migrations.AddInitialSchemas do
  use Ecto.Migration

  def change do
    create table("families") do
      add :name, :string

      timestamps()
    end

    create table("individuals") do
      add :nickname, :string
      add :position, :string
      add :family_id, references(:families)

      timestamps()
    end

    create table("responsabilities") do
      add :description, :string

      timestamps()
    end

    create table("individual_responsability") do
      add :individual_id, references(:individuals)
      add :responsability_id, references(:responsabilities)

      timestamps()
    end
  end
end
