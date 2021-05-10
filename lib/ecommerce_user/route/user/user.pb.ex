defmodule EcommerceUser.Role do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t :: integer | :cliente | :funcionario

  field :cliente, 0
  field :funcionario, 1
end

defmodule EcommerceUser.Empty do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{}
  defstruct []
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
          user: EcommerceUser.User.t() | nil
        }
  defstruct [:user]

  field :user, 1, type: EcommerceUser.User
end

defmodule EcommerceUser.User do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: String.t(),
          name: String.t(),
          email: String.t(),
          cpf: String.t(),
          role: EcommerceUser.Role.t(),
          address: String.t(),
          password: String.t(),
          card: String.t()
        }
  defstruct [:id, :name, :email, :cpf, :role, :address, :password, :card]

  field :id, 1, type: :string
  field :name, 2, type: :string
  field :email, 3, type: :string
  field :cpf, 5, type: :string
  field :role, 6, type: EcommerceUser.Role, enum: true
  field :address, 7, type: :string
  field :password, 8, type: :string
  field :card, 9, type: :string
end

defmodule EcommerceUser.UserList do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          users: [EcommerceUser.User.t()]
        }
  defstruct [:users]

  field :users, 1, repeated: true, type: EcommerceUser.User
end

defmodule EcommerceUser.UserResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          users: EcommerceUser.UserList.t() | nil
        }
  defstruct [:users]

  field :users, 1, type: EcommerceUser.UserList
end

defmodule EcommerceUser.UserService.Service do
  @moduledoc false
  use GRPC.Service, name: "EcommerceUser.UserService"

  rpc :create, EcommerceUser.UserRequest, EcommerceUser.User
  rpc :update, EcommerceUser.UserRequest, EcommerceUser.User
  rpc :delete, EcommerceUser.UserID, EcommerceUser.User
  rpc :select_all, EcommerceUser.Empty, EcommerceUser.UserList
  rpc :select_by_id, EcommerceUser.UserID, EcommerceUser.User
  rpc :select_by_name, EcommerceUser.UserName, EcommerceUser.User
end

defmodule EcommerceUser.UserService.Stub do
  @moduledoc false
  use GRPC.Stub, service: EcommerceUser.UserService.Service
end
