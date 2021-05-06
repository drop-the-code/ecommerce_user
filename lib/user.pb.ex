defmodule User.UserRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          email: String.t(),
          password: String.t()
        }
  defstruct [:name, :email, :password]

  field :name, 1, type: :string
  field :email, 2, type: :string
  field :password, 3, type: :string
end

defmodule User.UserReply do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          email: String.t()
        }
  defstruct [:name, :email]

  field :name, 1, type: :string
  field :email, 2, type: :string
end

defmodule User.User.Service do
  @moduledoc false
  use GRPC.Service, name: "user.User"

  rpc :SayHello, User.UserRequest, User.UserReply
end

defmodule User.User.Stub do
  @moduledoc false
  use GRPC.Stub, service: User.User.Service
end
