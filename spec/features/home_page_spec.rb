require_relative "../spec_helper.rb"

describe "the home page", :type => :feature do
  it "should redirect /home/ to /home" do
    visit '/home/'
    expect(current_path).to eq("/home")
  end

  it "should have a links element with a link to itself" do
    top_level_links_pattern = {
      links: {
          self: "#{base_url}/home"
      }
    }.ignore_extra_keys!
    visit '/home'
    expect(JSON.parse(page.body)).to match_json_expression(top_level_links_pattern)
  end

  it "should have a links element within the resource object's data" do
    top_level_data_pattern = {
      data: {
        links: {
          self: "#{base_url}/home"
        }
      }.ignore_extra_keys!
    }.ignore_extra_keys!
    visit '/home'
    expect(JSON.parse(page.body)).to match_json_expression(top_level_data_pattern)
  end

  it "should have type, id, and attributes describing the home page" do
    top_level_data_pattern = {
      data: {
        type: "WebPage",
        id: "1",
        attributes: {
          description: "Organizational Contact Points"
        }
      }.ignore_extra_keys!
    }.ignore_extra_keys!
    visit '/home'
    expect(JSON.parse(page.body)).to match_json_expression(top_level_data_pattern)
  end

  it "should have related Organization links" do
    top_level_data_pattern = {
      data: {
        relationships: {
          organization: {
            links: {
              self: "#{base_url}/home/relationships/organization",
              related: "#{base_url}/home/organization"
            }
          }
        }
      }.ignore_extra_keys!
    }.ignore_extra_keys!
    visit '/home'
    expect(JSON.parse(page.body)).to match_json_expression(top_level_data_pattern)
  end
end
