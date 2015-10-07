module Napoleon
  CommandResult = Struct.new(:result, :broadcast_server_response) do
    def broadcast_success?
      broadcast_server_response.to_s =~ /Net::HTTPOK/
    end
  end
end