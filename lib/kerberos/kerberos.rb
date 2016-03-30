require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class Kerberos < Authenticatable
      def valid?
        request.env['REMOTE_USER']
      end

      def authenticate!
        email = request.env['REMOTE_USER']
        username = request.env['REMOTE_USER'].split('@').first.downcase
        user = User.where(username: username).first
        if username
          if user
            success!(user)
          else
            user = User.create(email: email, username: username, password: 'password', password_confirmation: 'password')
            success!(user)
          end
        else
          fail!('No Remote User')
        end
      end
    end
  end
end

Warden::Strategies.add(:kerberos, Devise::Strategies::Kerberos)