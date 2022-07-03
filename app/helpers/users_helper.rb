module UsersHelper
  def reporting_tree(user)
    u = user
    org = []
    org_hash = {}
    while !u.manager_id.nil? do
      reports = User.reports_of(u.manager_id)
      org.push reports if reports.length > 0
      org_hash[u.manager_id] = reports
      u = u.manager
    end

    org_hash
  end

  def mermaid_chart(user)
    u = user
    mermaid_body = "graph TD\n"
    while true do
      User.reports_of(u.id).each do |reportee|
        mermaid_body << "  A#{reportee.id}[#{reportee.name}]\n"
        mermaid_body << "   A#{u.id} --> A#{reportee.id}\n"
      end
      break if u.manager.nil?
      u = u.manager
    end

    mermaid_body << "  A#{u.id}[#{u.name}]\n"

    mermaid_body
  end

  def mermaid_full_chart
    mermaid_body = "graph TD\n"
    User.all.each do |u|
      mermaid_body << "   A#{u.manager_id} --> A#{u.id}\n" unless u.manager_id.nil?
    end
    mermaid_body
  end
end



# {
#   users: [
#     {
#       id: 1,
#       name: 'bob',
#       reports: [
#         {
#           id: 5,
#           name: 'sam'
#         },
#         {
#           id: 6,
#           name: 'sally',
#           reports: [
#             {
#               id: 11,
#               name: "mike"
#             },
#             {
#               id: 13,
#               name: 'robn'
#             }
#           ]
#         }
#       ]
#     }
#   ]
# }