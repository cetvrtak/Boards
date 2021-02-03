defmodule Boards.AuthorizationTest do
	use ExUnit.Case
	import Boards.Authorization, except: [can: 1]
	alias Boards.Owner.Owner

	def can("read" = role) do
		grant(role)
			|> read(Owner)
	end

	test "role can read resource" do
		assert can("read") |> read?(Owner)
	end

	test "role can create resource" do
		refute can("read") |> create?(Owner)
	end

	test "role can update resource" do
		refute can("read") |> update?(Owner)
	end

	test "role can delete resource" do
		refute can("read") |> delete?(Owner)
	end
end