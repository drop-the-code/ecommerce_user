defmodule EcommerceUser.Endpoint do
  use GRPC.Endpoint

  intercept GRPC.Logger.Server
  run EcommerceUser.User.Server
end
