require 'bundler/setup'
require 'rspec'
require 'osx_tools'

RSpec.configure do |c|
  include OSXTools
end

module OSXTools

  def spec_resource_path
    File.dirname(__FILE__) + '/resources/'
  end

  def get_plist(filename)
    info_plist_file = spec_resource_path + filename
    io = File.open(info_plist_file)
    plist_xml = io.readlines.join(' ')
    io.close
    plist_xml
  end

  def get_invoker_with_injected_plist(filename)
    plist_xml = get_plist(filename)
    invoker = DiskutilInvoker.new
    invoker.stub!(:get_plist).and_return(plist_xml)
    invoker
  end

end

