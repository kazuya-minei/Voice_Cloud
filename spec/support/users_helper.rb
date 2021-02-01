module UserMacros
  def new
    @user = User.new(name:"Example User", email: "user@example.com",
    password:"foobar", password_confirmation:"foobar")
  end

  def valid_addresses
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
    first.last@foo.jp alice+bob@baz.cn] 
    valid_addresses.each do |valid_address| 
    @user.email = valid_address
    expect(@user.valid?).to be_truthy
    end
  end

  def invalid_addresses
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com foo@bar] 
    invalid_addresses.each do |invalid_address|  
    @user.email = invalid_address 
    expect(@user.invalid?).to be_truthy
    end
  end

  def mix_case_email
    mixcase_email = "FoOo@ExAmPlE.CoM"
    @user.email = "FoOo@ExAmPlE.CoM"
    @user.save
    @lowercase_email = mixcase_email.downcase
    @useremail = @user.reload.email
  end

end

