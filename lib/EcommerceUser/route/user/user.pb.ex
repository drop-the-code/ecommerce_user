defmodule EcommerceUser.UserRequest.Role do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :cliente | :funcionario

  field :cliente, 0
  field :funcionario, 1
end

defmodule EcommerceUser.UserResponse.Role do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :cliente | :funcionario

  field :cliente, 0
  field :funcionario, 1
end

defmodule EcommerceUser.UserID do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t()
        }
  defstruct [:id]

  field :id, 1, type: :string
end

defmodule EcommerceUser.UserName do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t()
        }
  defstruct [:name]

  field :name, 1, type: :string
end

defmodule EcommerceUser.UserRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          email: String.t(),
          password: String.t(),
          cpf: String.t(),
          endereco: String.t(),
          cartao: String.t()
        }
  defstruct [:name, :email, :password, :cpf, :endereco, :cartao]

  field :name, 1, type: :string
  field :email, 2, type: :string
  field :password, 3, type: :string
  field :cpf, 4, type: :string
  field :endereco, 5, type: :string
  field :cartao, 6, type: :string
end

defmodule EcommerceUser.UserResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          email: String.t(),
          cartao: String.t()
        }
  defstruct [:id, :name, :email, :cartao]

  field :id, 1, type: :string
  field :name, 2, type: :string
  field :email, 3, type: :string
  field :cartao, 4, type: :string
end

defmodule EcommerceUser.User.Service do
  @moduledoc false
  use GRPC.Service, name: "EcommerceUser.User"

  rpc :create, EcommerceUser.UserRequest, EcommerceUser.UserResponse
  rpc :update, EcommerceUser.UserRequest, EcommerceUser.UserResponse
  rpc :delete, EcommerceUser.UserRequest, EcommerceUser.UserResponse
  rpc :selectAll, Google.Protobuf.Empty, EcommerceUser.UserResponse
  rpc :selectByID, EcommerceUser.UserID, EcommerceUser.UserResponse
  rpc :selectByName, EcommerceUser.UserName, EcommerceUser.UserResponse
end

defmodule EcommerceUser.User.Stub do
  @moduledoc false
  use GRPC.Stub, service: EcommerceUser.User.Service
end
