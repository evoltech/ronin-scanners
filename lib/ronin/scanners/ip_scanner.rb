#
# Ronin Scanners - A Ruby library for Ronin that provides Ruby interfaces to
# various third-party security scanners.
#
# Copyright (c) 2008-2010 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
#

require 'ronin/scanners/scanner'
require 'ronin/extensions/ip_addr'
require 'ronin/ip_address'

module Ronin
  module Scanners
    #
    # The {IPScanner} class represents scanners that yield `IPAddr` results
    # and `IPAddress` resources.
    #
    class IPScanner < Scanner

      #
      # Creates a new IP scanner object.
      #
      # @yield []
      #   The given block will be used to create a new IP scanner object.
      #
      # @return [IPScanner]
      #   The new IP scanner object.
      #
      # @example
      #   ronin_ip_scanner do
      #     cache do
      #       self.name = 'some IP scanner'
      #       self.description = %{
      #         This is an example IP scanner.
      #       }
      #     end
      #
      #     protected
      #
      #     def scan
      #     end
      #   end
      #
      contextify :ronin_ip_scanner

      protected

      #
      # Normalizes the result.
      #
      # @param [String, IPAddr] result
      #   The incoming result.
      #
      # @return [IPAddr]
      #   The normalized IP Address.
      #
      # @since 0.2.0
      #
      def normalize_result(result)
        unless result.kind_of?(IPAddr)
          IPAddr.new(result.to_s)
        else
          result
        end
      end

      #
      # Queries or creates a new IPAddress resource for the given result.
      #
      # @param [IPAddr] result
      #   The ip address.
      #
      # @return [IPAddress]
      #   The IPAddress resource from the Database.
      #
      # @since 0.2.0
      #
      def new_resource(result)
        IPAddress.first_or_new(:address => result)
      end

    end
  end
end
