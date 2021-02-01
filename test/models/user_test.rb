require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup  #正しいユーザーデータを作成
    @user = User.new(name:"Example User", email: "user@example.com",
                     password:"foobar", password_confirmation:"foobar")
  end
  
  test "should be valid" do #setupで作成したデータが有効か？保存できるか？
    assert @user.valid?  #@user.valid?がtrueなら成功
  end
  
  test "name should be present" do
    @user.name = "     "  #存在性の検証、作成したデータのnameを空文字で上書きそれが有効か？
    assert_not @user.valid?  #@user.valid?がfalseで成功
  end
  
  test "email should be present" do #存在性
    @user.email = "     "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do #長さの検証
    @user.name = "a" * 51  #作成したデータのnameを51文字の"a"で上書き、それが有効か？
    assert_not @user.valid?  #@user.valid?がfalseで成功
  end

  test "email should not be too long" do  #長さの検証
    @user.email = "a" * 244+ "@example.com"
    assert_not @user.valid?
  end

  test "introduction-text should not be too long" do 
    @user.introduction_text = "a" * 151
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do #正しいメールアドレスを正しいものと認識出来るかチェック
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn] #正しいメールアドレス郡を渡す
    valid_addresses.each do |valid_address| #渡されたメールアドレスを全て順番に有効か検証する
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid" #@user.valid?がtrueで成功
    end                     #↑失敗した場合はどのメールアドレスで失敗したのかをわかるように
  end
  
  test "email validation should reject invalid addresses" do #無効なメールアドレスを無効なものとして弾くことが出来るかをチェック
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                          foo@bar_baz.com foo@bar+baz.com foo@bar..com] #不正なメールアドレス郡を渡す
    invalid_addresses.each do |invalid_address|  #順番に全てチェック
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid" #@user.valid?がfalseで成功
    end                       #↑失敗した場合はどのメールアドレスで失敗したのかをわかるように
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  #パスワードの最小文字数と存在性を検証
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6 #多重代入、一文で2つのカラムに値を代入する
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "user and work will be deleted together." do
    @user.save
    @user.works.create!(title: "nandemo", content: "iiyoooooo")
    assert_difference "Work.count", -1 do
      @user.destroy
    end
  end

end
