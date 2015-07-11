class ContentPreparer
  def organization_data
    organization_data = {
      data: {
        type: "Organization",
        id: "1"
      }
    }
    JSON.generate(organization_data)
  end
end
