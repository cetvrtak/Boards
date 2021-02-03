defmodule Boards.Authorization do
	alias __MODULE__
	defstruct role: nil, create: %{}, read: %{}, update: %{}, delete: %{}

	def can("Manage" = role) do
		grant(role)
		|> all(Owner)
	end

	def can("Write" = role) do
		grant(role)
		|> all(Owner)
	end

	def can("Read" = role) do
		grant(role)
		|> read(Owner)
	end

	def grant(role), do: %Authorization{role: role}

	def read(authorization, resource), do: put_action(authorization, :read, resource)
	def create(authorization, resource), do: put_action(authorization, :create, resource)
	def update(authorization, resource), do: put_action(authorization, :update, resource)
	def delete(authorization, resource), do: put_action(authorization, :delete, resource)

	def all(authorization, resource) do
		authorization
		|> create(resource)
		|> read(resource)
		|> update(resource)
		|> delete(resource)
	end

	def read?(authorization, resource) do
		Map.get(authorization.read, resource, false)
	end

	def create?(authorization, resource) do
		Map.get(authorization.create, resource, false)
	end

	def update?(authorization, resource) do
		Map.get(authorization.update, resource, false)
	end

	def delete?(authorization, resource) do
		Map.get(authorization.delete, resource, false)
	end

	defp put_action(authorization, action, resource) do
		updated_action = 
			authorization
			|> Map.get(action)
			|> Map.put(resource, true)

		Map.put(authorization, action, updated_action)
	end
end