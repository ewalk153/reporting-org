module UsersHelper
  def gravatar_img(email, size=100)
    "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email.strip)}?s=#{size}"
  end
  def reporting_org(user)
    u = user
    org = []
    reports = User.reports_of(u.id)
    org.concat(reports) if reports.length > 0
    while !u.manager_id.nil? do
      reports = User.reports_of(u.manager_id)
      org.concat(reports) if reports.length > 0
      u = u.manager
    end
    org << u

    org
  end
end
