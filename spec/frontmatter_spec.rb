require 'spec_helper'

describe Verso::Frontmatter do
  it 'fetches the remote resource' do
    @frontmatter = Verso::Frontmatter.new("code" => "6320", "edition" => "2011")
    @frontmatter.should_receive(:http_get).and_return(
      JSON.pretty_generate(:frontmatter => { :notice_block => "foobar" })
    )
    @frontmatter.notice_block
  end
end
