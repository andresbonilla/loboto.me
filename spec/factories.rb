Factory.define :user do |user|
  user.username              "testusername"
  user.password              "sdfb$%$kn84n3i84f"
  user.password_confirmation "sdfb$%$kn84n3i84f"
end

Factory.define :credential do |credential|
  credential.service "facebook"
  credential.username "asfasgasgd"
  credential.crypted_password "asjfhaslkjdhfsldf"
  credential.association :user
end
