module ControllerMacros
=begin
  def login_user
    #before(:each) do
      p 'xxxxxxxxxxxxxxxxxxxxxx'
      #controller.stub(:authenticate_user!).and_return true
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user.confirm!
      user = FactoryGirl.create(:user)
      sign_in user
    #end
  end
=end
#=begin
  def sign_in(user = double('user'))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
#=end
end
