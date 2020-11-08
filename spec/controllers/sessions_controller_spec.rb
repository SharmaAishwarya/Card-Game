require 'spec_helper'
require 'rails_helper'

describe SessionsController do

  #https://github.com/rails/rails/issues/34790
  #######MONKEY PATCH#########
  if RUBY_VERSION>='2.6.0'
    if Rails.version < '5'
      class ActionController::TestResponse < ActionDispatch::TestResponse
        def recycle!
          # hack to avoid MonitorMixin double-initialize error:
          @mon_mutex_owner_object_id = nil
          @mon_mutex = nil
          initialize
        end
      end
    else
      puts "Monkeypatch for ActionController::TestResponse no longer needed"
    end
  end
  ########################
  before(:all) do
    DatabaseCleaner.clean
    User.create!({username: "test_user", password: "asdfasdf",:email=>"holisticpanda"})
  end
  it 'Should flash a message "invalid username" if username is blank or nil' do
    post :create, {:username => {:username => ''}, :password => {:password => '123'}}
    expect(flash[:notice]).to match(/Invalid username*/)
  end
  it 'Should flash a message "invalid password" if password is blank or nil' do
    post :create, {:username => {:username => 'Test'}, :password => {:password => ''}}
    expect(flash[:notice]).to match(/Invalid password*/)
  end
  it 'Should flash a message login successful if username and password are correct' do
    fake_results = [double('User')]
    post :create, {:username => {:username => 'test_user'}, :password => {:password => 'asdfasdf'}}
    expect(flash[:notice]).to match(/Login Successful*/)
  end

end