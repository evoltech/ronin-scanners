require 'spec_helper'
require 'helpers/database'

require 'ronin/scanners/ip_scanner'

describe Scanners::IPScanner do
  before(:all) do
    @scanner = ronin_ip_scanner do

      def scan
        yield '127.0.0.1'
      end

    end
  end

  it "should normalize results to IPAddr objects" do
    @scanner.first.should == IPAddr.new('127.0.0.1')
  end

  it "should convert results into IpAddress resources" do
    resource = @scanner.each_resource.first

    resource.class.should == IPAddress
    resource.address.should == '127.0.0.1'
  end
end
