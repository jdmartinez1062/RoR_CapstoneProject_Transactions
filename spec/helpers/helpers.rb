module Helpers
  def log_in_with(name)
    visit login_path

    fill_in 'Name', with: name
    click_button 'Log in'
  end

  def expect_standard(obj)
    expect(page).to have_css('p', text: obj.time_name.to_s)
    expect(page).to have_css('p', text: obj.time_amount.to_s)
    expect(page).to have_css('p', text: obj.time_log.to_s)
  end

  def standard_procedure
    visit login_path
    log_in_with(user1.name)
  end

  def test_img_path
    File.new(Rails.root + 'spec/fixtures/Sprite-0003.png')
  end

  def standard_fixture
    let!(:user1) { User.create(name: 'test1') }

    let!(:group1) do
      user1.groups.create(name: 'Senior dev',
                          icon: File.new(Rails.root + 'spec/fixtures/Sprite-0003.png', 'r'))
    end

    let!(:transaction1) { group1.time_spents.create(name: 'Movement script', amount: 2, author_id: user1.id) }
  end
end
