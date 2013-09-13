categories = ["Writing", "Production", "Design", "Others"]
categories.each do |cat|
  JobCategory.create! name: cat
end
