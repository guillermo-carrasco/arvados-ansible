task :trusted_client => :production do
    wb = ApiClient.all.last; [wb.url_prefix, wb.created_at]
    include CurrentApiClient
    act_as_system_user do wb.update_attributes!(is_trusted: true) end
    Thread.current[:user] = User.all.select(&:identity_url).last
    Thread.current[:user].update_attributes is_admin: true, is_active: true
    User.where(is_admin: true).collect &:email
end
